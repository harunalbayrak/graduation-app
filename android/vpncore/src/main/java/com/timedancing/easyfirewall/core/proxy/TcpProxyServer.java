package com.timedancing.easyfirewall.core.proxy;

import com.timedancing.easyfirewall.constant.AppDebug;
import com.timedancing.easyfirewall.core.ProxyConfig;
import com.timedancing.easyfirewall.core.nat.NatSession;
import com.timedancing.easyfirewall.core.nat.NatSessionManager;
import com.timedancing.easyfirewall.core.tcpip.CommonMethods;
import com.timedancing.easyfirewall.core.tunel.Tunnel;
import com.timedancing.easyfirewall.core.tunel.TunnelFactory;
import com.timedancing.easyfirewall.util.DebugLog;
import com.timedancing.easyfirewall.util.AppInfo;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.Iterator;
import java.net.InetSocketAddress;

import android.content.Context;
import android.net.ConnectivityManager;

/**
 * Created by zengzheying on 15/12/30.
 */
public class TcpProxyServer implements Runnable {

	public boolean Stopped;
	public short Port;

	Selector mSelector;
	ServerSocketChannel mServerSocketChannel;
	Thread mServerThread;
	public static Context mainContext;

	public TcpProxyServer(int port, Context context) throws IOException {
		mSelector = Selector.open();
		mServerSocketChannel = ServerSocketChannel.open();
		mServerSocketChannel.configureBlocking(false);
		mServerSocketChannel.socket().bind(new InetSocketAddress(port));
		mServerSocketChannel.register(mSelector, SelectionKey.OP_ACCEPT);
		this.Port = (short) mServerSocketChannel.socket().getLocalPort();
		mainContext = context;

		DebugLog.i("AsyncTcpServer listen on %s:%d success.\n", mServerSocketChannel.socket().getInetAddress()
				.toString(), this.Port & 0xFFFF);
	}

	/**
	 * 启动TcpProxyServer线程
	 */
	public void start() {
		mServerThread = new Thread(this, "TcpProxyServerThread");
		mServerThread.start();
	}

	public void stop() {
		this.Stopped = true;
		if (mSelector != null) {
			try {
				mSelector.close();
				mSelector = null;
			} catch (Exception ex) {
				if (AppDebug.IS_DEBUG) {
					ex.printStackTrace(System.err);
				}
				DebugLog.e("TcpProxyServer mSelector.close() catch an exception: %s", ex);
			}
		}

		if (mServerSocketChannel != null) {
			try {
				mServerSocketChannel.close();
				mServerSocketChannel = null;
			} catch (Exception ex) {
				if (AppDebug.IS_DEBUG) {
					ex.printStackTrace(System.err);
				}

				DebugLog.e("TcpProxyServer mServerSocketChannel.close() catch an exception: %s", ex);
			}
		}
	}


	@Override
	public void run() {
		try {
			while (true) {
				Iterator<SelectionKey> keyIterator;

				try{
					mSelector.select();
					keyIterator = mSelector.selectedKeys().iterator();
				} catch (Exception ex){
					break;
				}
				while (keyIterator.hasNext()) {
					SelectionKey key = keyIterator.next();
					if (key.isValid()) {
						try {
							if (key.isReadable()) {
								((Tunnel) key.attachment()).onReadable(key);
							} else if (key.isWritable()) {
								((Tunnel) key.attachment()).onWritable(key);
							} else if (key.isConnectable()) {
								((Tunnel) key.attachment()).onConnectable();
							} else if (key.isAcceptable()) {
								onAccepted(key);
							}
						} catch (Exception ex) {
							if (AppDebug.IS_DEBUG) {
								ex.printStackTrace(System.err);
							}

							DebugLog.e("TcpProxyServer iterate SelectionKey catch an exception: %s", ex);
						}
					}
					keyIterator.remove();
				}

			}
		} catch (Exception e) {
			if (AppDebug.IS_DEBUG) {
				e.printStackTrace(System.err);
			}

			DebugLog.e("TcpProxyServer catch an exception: %s", e);
		} finally {
			this.stop();
			DebugLog.i("TcpServer thread exited.");
		}
	}

	InetSocketAddress getDestAddress(SocketChannel localChannel) {
		short portKey = (short) localChannel.socket().getPort();
		NatSession session = NatSessionManager.getSession(portKey);
		if (session != null) {
			if (ProxyConfig.Instance.needProxy(session.RemoteHost, session.RemoteIP)) {
				//TODO 完成跟具体的拦截策略？？？
				DebugLog.i("%d/%d:[BLOCK] %s=>%s:%d\n", NatSessionManager.getSessionCount(), Tunnel.SessionCount,
						session.RemoteHost,
						CommonMethods.ipIntToString(session.RemoteIP), session.RemotePort & 0xFFFF);

				return null;
			} else {
				return new InetSocketAddress(localChannel.socket().getInetAddress(), session.RemotePort & 0xFFFF);
			}
		}
		return null;
	}

	void onAccepted(SelectionKey key) {
		Tunnel localTunnel = null;
		SocketChannel localChannel;

		try {
			localChannel = mServerSocketChannel.accept();
			localTunnel = TunnelFactory.wrap(localChannel, mSelector);

			InetSocketAddress destAddress = getDestAddress(localChannel);
			if (destAddress != null) {
				Tunnel remoteTunnel = TunnelFactory.createTunnelByConfig(destAddress, mSelector);
				//关联兄弟
				remoteTunnel.setIsHttpsRequest(localTunnel.isHttpsRequest());
				remoteTunnel.setBrotherTunnel(localTunnel);
				localTunnel.setBrotherTunnel(remoteTunnel);
				remoteTunnel.connect(destAddress); //开始连接
			} else {
				short portKey = (short) localChannel.socket().getPort();
				NatSession session = NatSessionManager.getSession(portKey);
				if (session != null) {
					DebugLog.i("Have block a request to %s=>%s:%d", session.RemoteHost, CommonMethods.ipIntToString
									(session.RemoteIP),
							session.RemotePort & 0xFFFF);
					localTunnel.sendBlockInformation();
				} else {
					DebugLog.i("Error: socket(%s:%d) have no session.", localChannel.socket().getInetAddress()
							.toString(), portKey);
				}

				localTunnel.dispose();
			}

			// short portKey = (short) localChannel.socket().getPort();
			// NatSession session = NatSessionManager.getSession(portKey);

			// InetSocketAddress local = new InetSocketAddress(localChannel.socket().getLocalAddress(),localChannel.socket().getLocalPort());
			// int uu = getUidQ(6,local,destAddress);
			// if(uu != -1){
			// 	AppInfo appInfo = AppInfo.createFromUid(mainContext,uu);
			// 	System.out.println(appInfo.leaderAppName);
			// }
			

		} catch (Exception ex) {
			if (AppDebug.IS_DEBUG) {
				ex.printStackTrace(System.err);
			}

			DebugLog.e("TcpProxyServer onAccepted catch an exception: %s", ex);

			if (localTunnel != null) {
				localTunnel.dispose();
			}
		}
	}

	private int getUidQ(int protocol, InetSocketAddress local, InetSocketAddress remote) {
		int uid = -1;
		try{
			if (protocol != 6 /* TCP */ && protocol != 17 /* UDP */){
				return -1;
			}
			ConnectivityManager cm = (ConnectivityManager) mainContext.getSystemService(Context.CONNECTIVITY_SERVICE);
			if (cm == null){
				return -1;
			}
			System.out.println("Get uid local=" + local + " remote=" + remote);
			uid = cm.getConnectionOwnerUid(protocol, local, remote);
			System.out.println("Get uid=" + uid);
		} catch(Exception e){
			// e.printStackTrace();
			return -1;
		}
        return uid;
    }
}
