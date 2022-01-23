package com.timedancing.easyfirewall.core;


import android.content.Context;

import com.timedancing.easyfirewall.core.builder.BlockingInfoBuilder;
import com.timedancing.easyfirewall.core.builder.DefaultBlockingInfoBuilder;
import com.timedancing.easyfirewall.core.filter.DomainFilter;
import com.timedancing.easyfirewall.core.tcpip.CommonMethods;
import com.timedancing.easyfirewall.util.DebugLog;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Queue;
import java.util.LinkedList;

import android.net.ConnectivityManager;
import java.net.InetSocketAddress;

/**
 * Created by zengzheying on 15/12/28.
 */
public class ProxyConfig {

	public static final ProxyConfig Instance = new ProxyConfig();

	public final static int FAKE_NETWORK_MASK = CommonMethods.ipStringToInt("255.255.0.0");
	public final static int FAKE_NETWORK_IP = CommonMethods.ipStringToInt("10.231.0.0");

	private static Queue<HashMap<String,String>> hostQ = new LinkedList();

	ArrayList<IPAddress> mIpList;
	ArrayList<IPAddress> mDnsList;
	ArrayList<IPAddress> mRouteList;
	int mDnsTtl;

//	HashMap<String, Boolean> mDomainMap;
	String mSessionName;
	int mMtu;
	DomainFilter mDomainFilter;
	BlockingInfoBuilder mBlockingInfoBuilder;
	private VpnStatusListener mVpnStatusListener;

	public ProxyConfig() {
		mIpList = new ArrayList<>();
		mDnsList = new ArrayList<>();
		// mDnsList.add(new IPAddress("8.8.8.8"));
		// mDnsList.add(new IPAddress("8.8.4.4"));
		// mDnsList.add(new IPAddress("208.67.222.222"));
		// mDnsList.add(new IPAddress("208.67.220.220"));
		mRouteList = new ArrayList<>();

//		mDomainMap = new HashMap<>();
//		mDomainFilter = new BlackListFilter();
	}

	public static Queue<HashMap<String,String>> getQueue(){
		// System.out.println("returning Queue: " + hostQ.toString());
		return hostQ;
	}

	public static void clearQueue(){
		hostQ.clear();
	}

	public static boolean isFakeIP(int ip) {
		return (ip & ProxyConfig.FAKE_NETWORK_MASK) == ProxyConfig.FAKE_NETWORK_IP;
	}

	public void setDomainFilter(DomainFilter domainFilter) {
		mDomainFilter = domainFilter;
	}

	public void prepare() throws IllegalStateException {
		if (mDomainFilter != null) {
			mDomainFilter.prepare();
		} else {
			throw new IllegalStateException("ProxyConfig need an instance of DomainFilter," +
					" you should set an DomainFilter object by call the setDomainFilter() method");
		}
	}

	public IPAddress getDefaultLocalIP() {
		if (mIpList.size() > 0) {
			return mIpList.get(0);
		} else {
			return new IPAddress("10.8.0.2", 32);
		}
	}

	public ArrayList<IPAddress> getDnsList() {
		return mDnsList;
	}

	public ArrayList<IPAddress> getRouteList() {
		return mRouteList;
	}

	public int getDnsTTL() {
		if (mDnsTtl < 30) {
			mDnsTtl = 30;
		}
		return mDnsTtl;
	}

	public String getSessionName() {
		if (mSessionName == null) {
			mSessionName = "PFirewall";
		}
		return mSessionName;
	}

	public int getMTU() {
		if (mMtu > 1400 && mMtu <= 20000) {
			return mMtu;
		} else {
			return 20000;
		}
	}

	public boolean needProxy(String host, int ip) {
		boolean filter = mDomainFilter != null && mDomainFilter.needFilter(host, ip);
		DebugLog.iWithTag("Debug", String.format("host %s ip %s %s", host, CommonMethods.ipIntToString(ip), filter));

		HashMap<String, String> map = new HashMap<>();
		map.put(host, CommonMethods.ipIntToString(ip));

		if(!hostQ.add(map)){
			DebugLog.iWithTag("Debug", "Error adding to hostQ");
		}

		System.out.println("Filter: " + filter);

		return filter || isFakeIP(ip);
	}

	public void setBlockingInfoBuilder(BlockingInfoBuilder blockingInfoBuilder) {
		mBlockingInfoBuilder = blockingInfoBuilder;
	}

	public ByteBuffer getBlockingInfo() {
		if (mBlockingInfoBuilder != null) {
			return mBlockingInfoBuilder.getBlockingInformation();
		} else {
			return DefaultBlockingInfoBuilder.get().getBlockingInformation();
		}
	}

	public void setVpnStatusListener(VpnStatusListener vpnStatusListener) {
		mVpnStatusListener = vpnStatusListener;
	}

	public void onVpnStart(Context context) {
		if (mVpnStatusListener != null) {
			mVpnStatusListener.onVpnStart(context);
		}
	}


	public void onVpnEnd(Context context) {
		if (mVpnStatusListener != null) {
			mVpnStatusListener.onVpnEnd(context);
		}
	}

	public interface VpnStatusListener {
		void onVpnStart(Context context);

		void onVpnEnd(Context context);
	}

	public static class IPAddress {
		public final String Address;
		public final int PrefixLength;

		public IPAddress(String address, int prefixLength) {
			Address = address;
			PrefixLength = prefixLength;
		}

		public IPAddress(String ipAddressString) {
			String[] arrStrings = ipAddressString.split("/");
			String address = arrStrings[0];
			int prefixLength = 32;
			if (arrStrings.length > 1) {
				prefixLength = Integer.parseInt(arrStrings[1]);
			}

			this.Address = address;
			this.PrefixLength = prefixLength;
		}

		@Override
		public boolean equals(Object o) {
			if (o == null || !(o instanceof IPAddress)) {
				return false;
			} else {
				return this.toString().equals(o.toString());
			}
		}

		@Override
		public String toString() {
			return String.format("%s/%d", Address, PrefixLength);
		}
	}
}
