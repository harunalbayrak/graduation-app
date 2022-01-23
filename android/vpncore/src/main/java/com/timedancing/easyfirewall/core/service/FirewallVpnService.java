package com.timedancing.easyfirewall.core.service;

import android.app.PendingIntent;
import android.content.Intent;
import android.content.Context;
import android.net.VpnService;
import android.os.Handler;
import android.os.ParcelFileDescriptor;
import android.net.ConnectivityManager;

import com.timedancing.easyfirewall.activity.MainActivity;
import com.timedancing.easyfirewall.builder.HtmlBlockingInfoBuilder;
import com.timedancing.easyfirewall.constant.AppDebug;
import com.timedancing.easyfirewall.core.ProxyConfig;
import com.timedancing.easyfirewall.core.dns.DnsPacket;
import com.timedancing.easyfirewall.core.http.HttpRequestHeaderParser;
import com.timedancing.easyfirewall.core.nat.NatSession;
import com.timedancing.easyfirewall.core.nat.NatSessionManager;
import com.timedancing.easyfirewall.core.proxy.DnsProxy;
import com.timedancing.easyfirewall.core.proxy.TcpProxyServer;
import com.timedancing.easyfirewall.core.tcpip.CommonMethods;
import com.timedancing.easyfirewall.core.tcpip.IPHeader;
import com.timedancing.easyfirewall.core.tcpip.TCPHeader;
import com.timedancing.easyfirewall.core.tcpip.UDPHeader;
import com.timedancing.easyfirewall.core.util.VpnServiceHelper;
import com.timedancing.easyfirewall.event.VPNEvent;
import com.timedancing.easyfirewall.filter.BlackListFilter;
import com.timedancing.easyfirewall.util.DebugLog;
import com.timedancing.easyfirewall.core.util.NetworkUtil;
import com.timedancing.easyfirewall.util.NetFileManager;
import com.timedancing.easyfirewall.util.AppInfo;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.net.InetSocketAddress;

import de.greenrobot.event.EventBus;

/**
 * Created by zengzheying on 15/12/28.
 */
public class FirewallVpnService extends VpnService implements Runnable {

	private static int ID;
	private static int LOCAL_IP;
	private static Context mainContext;
	private boolean IsRunning = false;
	private Thread mVPNThread;
	private ParcelFileDescriptor mVPNInterface;
	private TcpProxyServer mTcpProxyServer;
	private DnsProxy mDnsProxy;
	private FileOutputStream mVPNOutputStream;

	private byte[] mPacket;
	private IPHeader mIPHeader;
	private TCPHeader mTCPHeader;
	private UDPHeader mUDPHeader;
	private ByteBuffer mDNSBuffer;
	private Handler mHandler;
	private long mSentBytes;
	private long mReceivedBytes;

	private static HashMap<String, Boolean> wifiRules = new HashMap<String, Boolean>();
    private static HashMap<String, Boolean> mobileNetworkRules = new HashMap<String, Boolean>();

	public static void setMainContext(Context mContext){
		mainContext = mContext;

		HtmlBlockingInfoBuilder.setMainContext(mContext);
		BlackListFilter.setMainContext(mContext);
	}

	public FirewallVpnService() {
		ID++;
		mHandler = new Handler();
		mPacket = new byte[20000];
		mIPHeader = new IPHeader(mPacket, 0);
		//Offset = ip报文头部长度
		mTCPHeader = new TCPHeader(mPacket, 20);
		mUDPHeader = new UDPHeader(mPacket, 20);
		//Offset = ip报文头部长度 + udp报文头部长度 = 28
		mDNSBuffer = ((ByteBuffer) ByteBuffer.wrap(mPacket).position(28)).slice();

		VpnServiceHelper.onVpnServiceCreated(this);

		DebugLog.i("New VPNService(%d)\n", ID);
	}

	public static HashMap<String, Boolean> getWifiRules(){
        return wifiRules;
    }

    public static HashMap<String, Boolean> getMobileNetworkRules(){
        return mobileNetworkRules;
    }

    private int setInitialRules(Builder builder){
        // Check if Wi-Fi
        boolean wifi = NetworkUtil.isWifiActive(this);
        DebugLog.i("wifi = %s\n", wifi);

        HashMap<String, Boolean> _map = null;
        if(wifi) {
            _map = wifiRules;
        } else{
            _map = mobileNetworkRules;
        }

        // DebugLog.i("%s",_map.toString());

        for (HashMap.Entry<String, Boolean> entry : _map.entrySet()) {
            String key = entry.getKey();
            Boolean value = entry.getValue();

			// DebugLog.i("%s-%s",key,value.toString());

			if(key.equals("com.example.graduation_app") || value == true){
				continue;
			}

            try {
				System.out.println(key + " - " + value);
				builder.addAllowedApplication(key);
				// builder.addAllowedApplication(key);
            } catch (Exception ex) {
                DebugLog.e("%s\n",ex.getMessage());
				continue;
				// return -1;
            }
        }

		return 0;
	}

	//启动Vpn工作线程
	@Override
	public void onCreate() {
		DebugLog.i("VPNService(%s) created.\n", ID);
		mVPNThread = new Thread(this, "VPNServiceThread");
		mVPNThread.start();
		setVpnRunningStatus(true);
		// notifyStatus(new VPNEvent(VPNEvent.Status.STARTING));
		super.onCreate();
	}

	//只设置IsRunning = true;
	@Override
	public int onStartCommand(Intent intent, int flags, int startId) {
		return super.onStartCommand(intent, flags, startId);
	}

	//停止Vpn工作线程
	@Override
	public void onDestroy() {
		DebugLog.i("VPNService(%s) destroyed.\n", ID);
		if (mVPNThread != null) {
			mVPNThread.interrupt();
		}
		VpnServiceHelper.onVpnServiceDestroy();
		super.onDestroy();
	}

	//发送UDP数据报
	public void sendUDPPacket(IPHeader ipHeader, UDPHeader udpHeader) {
		try {
			CommonMethods.ComputeUDPChecksum(ipHeader, udpHeader);
			this.mVPNOutputStream.write(ipHeader.mData, ipHeader.mOffset, ipHeader.getTotalLength());
		} catch (IOException e) {
			if (AppDebug.IS_DEBUG) {
				e.printStackTrace();
			}

			DebugLog.e("VpnService send UDP packet catch an exception %s", e);
		}
	}

	//建立VPN，同时监听出口流量
	private void runVPN() throws Exception {
		this.mVPNInterface = establishVPN();
		this.mVPNOutputStream = new FileOutputStream(mVPNInterface.getFileDescriptor());
		FileInputStream in = new FileInputStream(mVPNInterface.getFileDescriptor());
		int size = 0;
		try{
			while (size != -1 && IsRunning) {
				while ((size = in.read(mPacket)) > 0 && IsRunning) {
					if (mDnsProxy.Stopped || mTcpProxyServer.Stopped) {
						in.close();
						throw new Exception("LocalServer stopped.");
					}
					onIPPacketReceived(mIPHeader, size);
				}
				Thread.sleep(100);
			}
		} catch (Exception ex) {
			//
		}
		in.close();
		disconnectVPN();
	}

	public void reloadVPN() throws Exception{
        ParcelFileDescriptor prev = mVPNInterface;
        if (IsRunning)
            mVPNInterface = establishVPN();
        if (prev != null)
            prev.close();
    }

	public void reloadVPNWithNewHosts() throws Exception{
		ParcelFileDescriptor prev = mVPNInterface;
        if (IsRunning)
            mVPNInterface = establishVPN();
        if (prev != null)
            prev.close();
		ProxyConfig.Instance.prepare();
	}

	void onIPPacketReceived(IPHeader ipHeader, int size) throws IOException {

		switch (ipHeader.getProtocol()) {
			case IPHeader.TCP:
				TCPHeader tcpHeader = mTCPHeader;
				tcpHeader.mOffset = ipHeader.getHeaderLength(); //矫正TCPHeader里的偏移量，使它指向真正的TCP数据地址
				if (tcpHeader.getSourcePort() == mTcpProxyServer.Port) {

					NatSession session = NatSessionManager.getSession(tcpHeader.getDestinationPort());
					if (session != null) {
						ipHeader.setSourceIP(ipHeader.getDestinationIP());
						tcpHeader.setSourcePort(session.RemotePort);
						ipHeader.setDestinationIP(LOCAL_IP);

						CommonMethods.ComputeTCPChecksum(ipHeader, tcpHeader);
						mVPNOutputStream.write(ipHeader.mData, ipHeader.mOffset, size);
						mReceivedBytes += size;
					} else {
						DebugLog.i("NoSession: %s %s\n", ipHeader.toString(), tcpHeader.toString());
					}

				} else {
					//添加端口映射
					int portKey = tcpHeader.getSourcePort();
					NatSession session = NatSessionManager.getSession(portKey);

					// -PORTKEY-
					if (session == null || session.RemoteIP != ipHeader.getDestinationIP() || session.RemotePort
							!= tcpHeader.getDestinationPort()) {
						session = NatSessionManager.createSession(portKey, ipHeader.getDestinationIP(), tcpHeader
								.getDestinationPort());
					}

					session.LastNanoTime = System.nanoTime();
					session.PacketSent++; //注意顺序

					int tcpDataSize = ipHeader.getDataLength() - tcpHeader.getHeaderLength();
					if (session.PacketSent == 2 && tcpDataSize == 0) {
						return; //丢弃tcp握手的第二个ACK报文。因为客户端发数据的时候也会带上ACK，这样可以在服务器Accept之前分析出HOST信息。
					}

					//分析数据，找到host
					if (session.BytesSent == 0 && tcpDataSize > 10) {
						int dataOffset = tcpHeader.mOffset + tcpHeader.getHeaderLength();
						HttpRequestHeaderParser.parseHttpRequestHeader(session, tcpHeader.mData, dataOffset,
								tcpDataSize);
						DebugLog.i("Host: %s\n", session.RemoteHost);
						DebugLog.i("Request: %s %s\n", session.Method, session.RequestUrl);
					}

					//转发给本地TCP服务器
					ipHeader.setSourceIP(ipHeader.getDestinationIP());
					ipHeader.setDestinationIP(LOCAL_IP);
					tcpHeader.setDestinationPort(mTcpProxyServer.Port);

					CommonMethods.ComputeTCPChecksum(ipHeader, tcpHeader);
					mVPNOutputStream.write(ipHeader.mData, ipHeader.mOffset, size);
					session.BytesSent += tcpDataSize; //注意顺序
					mSentBytes += size;
				}

				// System.out.println("t-saddr: " + ipHeader.getSourceIP());
				// System.out.println("t-sport: " + tcpHeader.getSourcePort());
				// System.out.println("t-daddr: " + LOCAL_IP);
				// System.out.println("t-dport: " + mTcpProxyServer.Port);

				//getUidQ(6,)

				break;
			case IPHeader.UDP:
				UDPHeader udpHeader = mUDPHeader;
				udpHeader.mOffset = ipHeader.getHeaderLength();
				if (ipHeader.getSourceIP() == LOCAL_IP && udpHeader.getDestinationPort() == 53) {
					mDNSBuffer.clear();
					mDNSBuffer.limit(udpHeader.getTotalLength() - 8);
					DnsPacket dnsPacket = DnsPacket.fromBytes(mDNSBuffer);
					if(dnsPacket == null){
						System.out.println("dnspacket is null");
					}
					if (dnsPacket != null && dnsPacket.Header.QuestionCount > 0) {
						DebugLog.i("let the DnsProxy to process DNS request...\n");
						DebugLog.iWithTag("DNS", "Query " + dnsPacket.Questions[0].Domain);
						mDnsProxy.onDnsRequestReceived(ipHeader, udpHeader, dnsPacket);

						// System.out.println("u-saddr: " + ipHeader.getSourceIP());
						// System.out.println("u-sport: " + udpHeader.getSourcePort());
						// System.out.println("u-daddr: " + LOCAL_IP);
						// System.out.println("u-dport: " + udpHeader.getDestinationPort());
					}
				}

				// System.out.println("u-saddr: " + ipHeader.getSourceIP());
				// System.out.println("u-sport: " + udpHeader.getSourcePort());
				// System.out.println("u-daddr: " + ipHeader.getDestinationIP());
				// System.out.println("u-dport: " + udpHeader.getDestinationPort());

				break;
		}

	}

	// private int getUidQ(int protocol, String saddr, int sport, String daddr, int dport) {
    //     if (protocol != 6 /* TCP */ && protocol != 17 /* UDP */){
	// 		return -1;
	// 	}

    //     ConnectivityManager cm = (ConnectivityManager) this.getSystemService(Context.CONNECTIVITY_SERVICE);
    //     if (cm == null){
	// 		return -1;
	// 	}

    //     InetSocketAddress local = new InetSocketAddress(saddr, sport);
    //     InetSocketAddress remote = new InetSocketAddress(daddr, dport);

    //     System.out.println("Get uid local=" + local + " remote=" + remote);
    //     int uid = cm.getConnectionOwnerUid(protocol, local, remote);
    //     System.out.println("Get uid=" + uid);
    //     return uid;
    // }

	private void waitUntilPrepared() {
		while (prepare(this) != null) {
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				if (AppDebug.IS_DEBUG) {
					e.printStackTrace();
				}
				DebugLog.e("waitUntilPrepared catch an exception %s\n", e);
			}
		}
	}

	private ParcelFileDescriptor establishVPN() throws Exception {
		Builder builder = new Builder();
		builder.setMtu(ProxyConfig.Instance.getMTU());
		DebugLog.i("setMtu: %d\n", ProxyConfig.Instance.getMTU());

		ProxyConfig.IPAddress ipAddress = ProxyConfig.Instance.getDefaultLocalIP();
		LOCAL_IP = CommonMethods.ipStringToInt(ipAddress.Address);
		builder.addAddress(ipAddress.Address, ipAddress.PrefixLength);
		DebugLog.i("addAddress: %s/%d\n", ipAddress.Address, ipAddress.PrefixLength);

		for (ProxyConfig.IPAddress dns : ProxyConfig.Instance.getDnsList()) {
			builder.addDnsServer(dns.Address);
			DebugLog.i("addDnsServer: %s\n", dns.Address);
		}

		if (ProxyConfig.Instance.getRouteList().size() > 0) {
			for (ProxyConfig.IPAddress routeAddress : ProxyConfig.Instance.getRouteList()) {
				builder.addRoute(routeAddress.Address, routeAddress.PrefixLength);
				DebugLog.i("addRoute: %s/%d\n", routeAddress.Address, routeAddress.PrefixLength);
			}
			builder.addRoute(CommonMethods.ipIntToInet4Address(ProxyConfig.FAKE_NETWORK_IP), 16);
			DebugLog.i("addRoute for FAKE_NETWORK: %s/%d\n", CommonMethods.ipIntToString(ProxyConfig.FAKE_NETWORK_IP),
					16);
		} else {
			builder.addRoute("0.0.0.0", 0);
			DebugLog.i("addDefaultRoute: 0.0.0.0/0\n");
		}

		if(setInitialRules(builder) != 0){
			DebugLog.e("Set initial rules error\n");
		}
		
		// Class<?> SystemProperties = Class.forName("android.os.SystemProperties");
		// Method method = SystemProperties.getMethod("get", new Class[]{String.class});
		// ArrayList<String> servers = new ArrayList<>();
		// for (String name : new String[]{"net.dns1", "net.dns2", "net.dns3", "net.dns4",}) {
		// // for (String name : new String[]{"8.8.8.8", "8.8.4.4", "208.67.222.222", "208.67.220.220",}) {
		// 	String value = (String) method.invoke(null, name);
		// 	if (value != null && !"".equals(value) && !servers.contains(value)) {
		// 		servers.add(value);
		// 		builder.addRoute(value, 32); //添加路由，使得DNS查询流量也走该VPN接口

		// 		DebugLog.i("%s=%s\n", name, value);
		// 	}
		// }

		// String[] DNS_IPS = {"8.8.8.8","8.8.4.4"};
		// // DNS Server，就是该端口的DNS服务器地址；
		// for (String ip : DNS_IPS) {
		// 	builder.addDnsServer(ip);
		// }

		System.out.println("VPN START");

		Intent intent = new Intent(this, MainActivity.class);
		PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent, 0);
		builder.setConfigureIntent(pendingIntent);

		builder.setSession(ProxyConfig.Instance.getSessionName());
		ParcelFileDescriptor pfdDescriptor = builder.establish();
		// notifyStatus(new VPNEvent(VPNEvent.Status.ESTABLISHED));
		return pfdDescriptor;
	}

	@Override
	public void run() {
		try {
			DebugLog.i("VPNService(%s) work thread is Running...\n", ID);

			waitUntilPrepared();

			ProxyConfig.Instance.setDomainFilter(new BlackListFilter());
			ProxyConfig.Instance.setBlockingInfoBuilder(new HtmlBlockingInfoBuilder());
			ProxyConfig.Instance.prepare();

			//启动TCP代理服务
			mTcpProxyServer = new TcpProxyServer(0,this);
			mTcpProxyServer.start();

			mDnsProxy = new DnsProxy(this);
			mDnsProxy.start();
			DebugLog.i("DnsProxy started.\n");

			ProxyConfig.Instance.onVpnStart(this);
			while (IsRunning) {
				runVPN();
			}
			ProxyConfig.Instance.onVpnEnd(this);

		} catch (InterruptedException e) {
			if (AppDebug.IS_DEBUG) {
				e.printStackTrace();
			}
			DebugLog.e("VpnService run catch an exception %s.\n", e);
		} catch (Exception e) {
			if (AppDebug.IS_DEBUG) {
				e.printStackTrace();
			}
			DebugLog.e("VpnService run catch an exception %s.\n", e);
		} finally {
			DebugLog.i("VpnService terminated");
			dispose();
		}
	}

	public void disconnectVPN() {
		try {
			if (mVPNInterface != null) {
				mVPNInterface.close();
				mVPNInterface = null;
			}
		} catch (Exception e) {
			//ignore
		}
		// notifyStatus(new VPNEvent(VPNEvent.Status.UNESTABLISHED));
		this.mVPNOutputStream = null;
	}

	private synchronized void dispose() {
		//断开VPN
		disconnectVPN();

		//停止TCP代理服务
		if (mTcpProxyServer != null) {
			mTcpProxyServer.stop();
			mTcpProxyServer = null;
			DebugLog.i("TcpProxyServer stopped.\n");
		}

		if (mDnsProxy != null) {
			mDnsProxy.stop();
			mDnsProxy = null;
			DebugLog.i("DnsProxy stopped.\n");
		}

		stopSelf();
		setVpnRunningStatus(false);
//		System.exit(0);
	}

	private void notifyStatus(VPNEvent event) {
		EventBus.getDefault().post(event);
	}

	public boolean vpnRunningStatus() {
		return IsRunning;
	}

	public void setVpnRunningStatus(boolean isRunning) {
		IsRunning = isRunning;
	}
}
