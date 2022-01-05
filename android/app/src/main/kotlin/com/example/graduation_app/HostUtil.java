package com.example.graduation_app;

import android.annotation.TargetApi;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.Process;
import androidx.preference.PreferenceManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

import java.net.UnknownHostException;
import java.net.InetSocketAddress;
import java.net.Inet4Address;
import java.net.Inet6Address;
import java.net.InetAddress;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

public class HostUtil {
    public HostUtil(Context context){
        contextS = context;
    }

    public Context contextS;  

    private static LogService logService = new LogService();

    private volatile Looper logLooper;
    private volatile LogHandler logHandler;

    private static final int MSG_STATS_START = 1;
    private static final int MSG_STATS_STOP = 2;
    private static final int MSG_STATS_UPDATE = 3;
    private static final int MSG_PACKET = 4;
    private static final int MSG_USAGE = 5;

    private boolean user_foreground = true;
    private boolean last_connected = false;
    private boolean last_metered = true;
    private boolean last_interactive = false;

    private int last_allowed = -1;
    private int last_blocked = -1;
    private int last_hosts = -1;

    private Map<String, Boolean> mapHostsBlocked = new HashMap<>();
    private Map<Integer, Forward> mapForward = new HashMap<>();
    private Map<Integer, Boolean> mapUidAllowed = new HashMap<>();
    private Map<Integer, Integer> mapUidKnown = new HashMap<>();
    private final Map<IPKey, Map<InetAddress, IPRule>> mapUidIPFilters = new HashMap<>();

    // Called from native code
    /*
    private void dnsResolved(ResourceRecord rr) {
        if (DatabaseHelper.getInstance(ServiceSinkhole.this).insertDns(rr)) {
            logService.LogI_3(TAG, "New IP " + rr);
            prepareUidIPFilters(rr.QName);
        }
    }
    */

    // Called from native code
    private boolean isDomainBlocked(String name) {
        //lock.readLock().lock();
        boolean blocked = (mapHostsBlocked.containsKey(name) && mapHostsBlocked.get(name));
        //lock.readLock().unlock();
        return blocked;
    }

    // Called from native code
    @TargetApi(Build.VERSION_CODES.Q)
    private int getUidQ(int version, int protocol, String saddr, int sport, String daddr, int dport) {
        if (protocol != 6 /* TCP */ && protocol != 17 /* UDP */)
            return Process.INVALID_UID;

        ConnectivityManager cm = (ConnectivityManager) contextS.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (cm == null)
            return Process.INVALID_UID;

        InetSocketAddress local = new InetSocketAddress(saddr, sport);
        InetSocketAddress remote = new InetSocketAddress(daddr, dport);

        logService.LogI_3("Get uid local=" + local + " remote=" + remote);
        int uid = cm.getConnectionOwnerUid(protocol, local, remote);
        logService.LogI_3("Get uid=" + uid);
        return uid;
    }

    private boolean isSupported(int protocol) {
        return (protocol == 1 /* ICMPv4 */ ||
                protocol == 58 /* ICMPv6 */ ||
                protocol == 6 /* TCP */ ||
                protocol == 17 /* UDP */);
    }

    // Called from native code
    private Allowed isAddressAllowed(Packet packet) {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(contextS);

        //lock.readLock().lock();

        packet.allowed = false;
        if (prefs.getBoolean("filter", false)) {
            // https://android.googlesource.com/platform/system/core/+/master/include/private/android_filesystem_config.h
            if (packet.protocol == 17 /* UDP */ && !prefs.getBoolean("filter_udp", false)) {
                // Allow unfiltered UDP
                packet.allowed = true;
                logService.LogI_3("Allowing UDP " + packet);
            } else if (packet.uid < 2000 &&
                    !last_connected && isSupported(packet.protocol) && false) {
                // Allow system applications in disconnected state
                packet.allowed = true;
                logService.LogI_3("Allowing disconnected system " + packet);
            } else if (packet.uid < 2000 &&
                    !mapUidKnown.containsKey(packet.uid) && isSupported(packet.protocol)) {
                // Allow unknown system traffic
                packet.allowed = true;
                logService.LogI_3("Allowing unknown system " + packet);
            } else if (packet.uid == Process.myUid()) {
                // Allow self
                packet.allowed = true;
                logService.LogI_3("Allowing self " + packet);
            } else {
                boolean filtered = false;
                IPKey key = new IPKey(packet.version, packet.protocol, packet.dport, packet.uid);
                if (mapUidIPFilters.containsKey(key))
                    try {
                        InetAddress iaddr = InetAddress.getByName(packet.daddr);
                        Map<InetAddress, IPRule> map = mapUidIPFilters.get(key);
                        if (map != null && map.containsKey(iaddr)) {
                            IPRule rule = map.get(iaddr);
                            if (rule.isExpired())
                                logService.LogI_3("DNS expired " + packet + " rule " + rule);
                            else {
                                filtered = true;
                                packet.allowed = !rule.isBlocked();
                                logService.LogI_3("Filtering " + packet +
                                        " allowed=" + packet.allowed + " rule " + rule);
                            }
                        }
                    } catch (UnknownHostException ex) {
                        logService.LogI_3("Allowed " + ex.toString());
                    }

                if (!filtered)
                    if (mapUidAllowed.containsKey(packet.uid))
                        packet.allowed = mapUidAllowed.get(packet.uid);
                    else
                        logService.LogI_3("No rules for " + packet);
            }
        }

        Allowed allowed = null;
        if (packet.allowed) {
            if (mapForward.containsKey(packet.dport)) {
                Forward fwd = mapForward.get(packet.dport);
                if (fwd.ruid == packet.uid) {
                    allowed = new Allowed();
                } else {
                    allowed = new Allowed(fwd.raddr, fwd.rport);
                    packet.data = "> " + fwd.raddr + "/" + fwd.rport;
                }
            } else
                allowed = new Allowed();
        }

        //lock.readLock().unlock();

        if (prefs.getBoolean("log", false) || prefs.getBoolean("log_app", false))
            if (packet.protocol != 6 /* TCP */ || !"".equals(packet.flags))
                if (packet.uid != Process.myUid())
                    logPacket(packet);

        return allowed;
    }

    // Called from native code
    private void logPacket(Packet packet) {
        logHandler.queue(packet);
    }

    private final class LogHandler extends Handler {
        public int queue = 0;
        private static final int MAX_QUEUE = 250;

        public LogHandler(Looper looper) {
            super(looper);
        }

        public void queue(Packet packet) {
            Message msg = obtainMessage();
            msg.obj = packet;
            msg.what = MSG_PACKET;
            msg.arg1 = (last_connected ? (last_metered ? 2 : 1) : 0);
            msg.arg2 = (last_interactive ? 1 : 0);

            synchronized (this) {
                if (queue > MAX_QUEUE) {
                    logService.LogI_3("Log queue full");
                    return;
                }

                sendMessage(msg);

                queue++;
            }
        }

        /*
        public void account(Usage usage) {
            Message msg = obtainMessage();
            msg.obj = usage;
            msg.what = MSG_USAGE;

            synchronized (this) {
                if (queue > MAX_QUEUE) {
                    Log.w(TAG, "Log queue full");
                    return;
                }

                sendMessage(msg);

                queue++;
            }
        }
        */

        @Override
        public void handleMessage(Message msg) {
            try {
                switch (msg.what) {
                    case MSG_PACKET:
                        log((Packet) msg.obj, msg.arg1, msg.arg2 > 0);
                        break;

                    case MSG_USAGE:
                        //usage((Usage) msg.obj);
                        break;

                    default:
                        logService.LogE_3("Unknown log message=" + msg.what);
                }

                synchronized (this) {
                    queue--;
                }

            } catch (Throwable ex) {
                logService.LogE_3(ex.toString());
            }
        }

        private void log(Packet packet, int connection, boolean interactive) {
            // Get settings
            SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(contextS);
            boolean log = prefs.getBoolean("log", false);
            boolean log_app = prefs.getBoolean("log_app", false);

            //DatabaseHelper dh = DatabaseHelper.getInstance(ServiceSinkhole.this);

            // Get real name
            //String dname = dh.getQName(packet.uid, packet.daddr);

            // Traffic log
            /*
            if (log)
                dh.insertLog(packet, dname, connection, interactive);
            */

            // Application log
            if (log_app && packet.uid >= 0 &&
                    !(packet.uid == 0 && (packet.protocol == 6 || packet.protocol == 17) && packet.dport == 53)) {
                if (!(packet.protocol == 6 /* TCP */ || packet.protocol == 17 /* UDP */))
                    packet.dport = 0;
                /*
                    if (dh.updateAccess(packet, dname, -1)) {
                    lock.readLock().lock();
                    if (!mapNotify.containsKey(packet.uid) || mapNotify.get(packet.uid))
                        showAccessNotification(packet.uid);
                    lock.readLock().unlock();
                }
                */
            }
        }

        /*
        private void usage(Usage usage) {
            if (usage.Uid >= 0 && !(usage.Uid == 0 && usage.Protocol == 17 && usage.DPort == 53)) {
                SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(ServiceSinkhole.this);
                boolean filter = prefs.getBoolean("filter", false);
                boolean log_app = prefs.getBoolean("log_app", false);
                boolean track_usage = prefs.getBoolean("track_usage", false);
                if (filter && log_app && track_usage) {
                    DatabaseHelper dh = DatabaseHelper.getInstance(ServiceSinkhole.this);
                    String dname = dh.getQName(usage.Uid, usage.DAddr);
                    Log.i(TAG, "Usage account " + usage + " dname=" + dname);
                    dh.updateUsage(usage, dname);
                }
            }
        }
        */
    }

    private class IPKey {
        int version;
        int protocol;
        int dport;
        int uid;

        public IPKey(int version, int protocol, int dport, int uid) {
            this.version = version;
            this.protocol = protocol;
            // Only TCP (6) and UDP (17) have port numbers
            this.dport = (protocol == 6 || protocol == 17 ? dport : 0);
            this.uid = uid;
        }

        @Override
        public boolean equals(Object obj) {
            if (!(obj instanceof IPKey))
                return false;
            IPKey other = (IPKey) obj;
            return (this.version == other.version &&
                    this.protocol == other.protocol &&
                    this.dport == other.dport &&
                    this.uid == other.uid);
        }

        @Override
        public int hashCode() {
            return (version << 40) | (protocol << 32) | (dport << 16) | uid;
        }

        @Override
        public String toString() {
            return "v" + version + " p" + protocol + " port=" + dport + " uid=" + uid;
        }
    }

    private class IPRule {
        private IPKey key;
        private String name;
        private boolean block;
        private long expires;

        public IPRule(IPKey key, String name, boolean block, long expires) {
            this.key = key;
            this.name = name;
            this.block = block;
            this.expires = expires;
        }

        public boolean isBlocked() {
            return this.block;
        }

        public boolean isExpired() {
            return System.currentTimeMillis() > this.expires;
        }

        public void updateExpires(long expires) {
            this.expires = Math.max(this.expires, expires);
        }

        @Override
        public boolean equals(Object obj) {
            IPRule other = (IPRule) obj;
            return (this.block == other.block && this.expires == other.expires);
        }

        @Override
        public String toString() {
            return this.key + " " + this.name;
        }
    }
}
