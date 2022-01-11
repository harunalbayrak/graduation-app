package com.timedancing.easyfirewall.filter;

import android.content.Context;
import android.text.TextUtils;
import android.util.SparseIntArray;

import com.timedancing.easyfirewall.R;
import com.timedancing.easyfirewall.app.GlobalApplication;
import com.timedancing.easyfirewall.constant.AppDebug;
import com.timedancing.easyfirewall.core.ProxyConfig;
import com.timedancing.easyfirewall.core.filter.DomainFilter;
import com.timedancing.easyfirewall.core.tcpip.CommonMethods;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import java.net.URL;
import java.net.URLConnection;

/**
 * Created by zengzheying on 16/1/6.
 */
public class BlackListFilter implements DomainFilter {
	private SparseIntArray mIpMask = new SparseIntArray();
	private static Context mainContext;

	private static Map<String, Integer> _mDomainMap0 = new HashMap<>();
	private static Map<String, Integer> _mDomainMap1 = new HashMap<>();
	private static Map<String, Integer> _mDomainMap2 = new HashMap<>();
	private static Map<String, Integer> _mDomainMap3 = new HashMap<>();
	private static Map<String, Integer> _mDomainMap4 = new HashMap<>();
	private static Map<String, Integer> _mDomainMap5 = new HashMap<>();
	private static Map<String, Integer> _mDomainMap6 = new HashMap<>();
	private static Map<String, Integer> _mDomainMap7 = new HashMap<>();
	private static Map<String, Integer> mDomainMap2 = new HashMap<>();

	private static boolean filterHosts[] = {false, false, false, false, false, false, false, false};
	private static int filterHostsSize = 8;

	String malwareURL = "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Hosts/GoodbyeAds.txt";
	String adsTrackingURL = "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt";
	String socialURL = "https://www.github.developerdan.com/hosts/lists/facebook-extended.txt";
	String fakenewsURL = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts";
	String gamblingURL = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling/hosts";
	String xiaomiAdsURL = "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-Xiaomi-Extension.txt";
	String samsungAdsURL = "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-Samsung-AdBlock.txt";
	String spotifyAdsURL = "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-Spotify-AdBlock.txt";


	public static void setMainContext(Context mContext){
		mainContext = mContext;
	}

	public static void addBlockedHost(String host){
		mDomainMap2.put(host,0);

		System.out.println(mDomainMap2.toString());
	}

	public static void removeBlockedHost(String host){
		mDomainMap2.remove(host);
		
		System.out.println(mDomainMap2);

		System.out.println(mDomainMap2.toString());
	}

	public static void addHostsFile(int which){
		if(which < 0 || which >= filterHostsSize){
			System.out.println("error filter hosts size");
			return;
		}

		filterHosts[which] = true;
	}

	public static void removeHostsFile(int which){
		if(which < 0 || which >= filterHostsSize){
			System.out.println("error filter hosts size");
			return;
		}

		filterHosts[which] = false;
	}

	@Override
	public void prepare() {
		// if (mDomainMap.size() != 0 || mIpMask.size() != 0) {
		// 	return;
		// }

		for(int i=0;i<filterHostsSize;++i){
			if(filterHosts[i] == false){
				switch(i){
					case 0:
						_mDomainMap0.clear();
						break;
					case 1:
						_mDomainMap1.clear();
						break;
					case 2:
						_mDomainMap2.clear();
						break;
					case 3:
						_mDomainMap3.clear();
						break;
					case 4:
						_mDomainMap4.clear();
						break;
					case 5:
						_mDomainMap5.clear();
						break;
					case 6:
						_mDomainMap6.clear();
						break;
					case 7:
						_mDomainMap7.clear();
						break;
				}

				continue;
			}

			addToDomain(i);
		}
	}

	public void addToDomain(int i){
		InputStream in = getHostInputStream(i);
		BufferedReader reader = new BufferedReader(new InputStreamReader(in));
		String line = null;
		try {
			while ((line = reader.readLine()) != null) {
				line = line.trim();
				if(line.length() > 0){
					if (line.startsWith("#")
							|| !TextUtils.isDigitsOnly(String.valueOf(line.charAt(0)))) {
						continue;
					}
				}

				String[] parts = line.split(" ");
				if (parts.length == 2
						&& !"localhost".equalsIgnoreCase(parts[1])) {
					String ipStr = parts[0];
					int ip = CommonMethods.ipStringToInt(ipStr);
					if(parts[1].length() > 7){
						switch(i){
							case 0:
								_mDomainMap0.put(parts[1], ip);
								break;
							case 1:
								_mDomainMap1.put(parts[1], ip);
								break;
							case 2:
								_mDomainMap2.put(parts[1], ip);
								break;
							case 3:
								_mDomainMap3.put(parts[1], ip);
								break;
							case 4:
								_mDomainMap4.put(parts[1], ip);
								break;
							case 5:
								_mDomainMap5.put(parts[1], ip);
								break;
							case 6:
								_mDomainMap6.put(parts[1], ip);
								break;
							case 7:
								_mDomainMap7.put(parts[1], ip);
								break;
						}

						// mDomainMap.put(parts[1], ip);
						// System.out.println("p: " + mDomainMap.size());
						// System.out.println("p: " + parts[1]);
						mIpMask.put(ip, 1);
					}
				}
			}
		} catch (IOException ex) {
			if (AppDebug.IS_DEBUG) {
				ex.printStackTrace(System.err);
			}
		} finally {
			try {
				reader.close();
				in.close();
			} catch (IOException ex) {
				if (AppDebug.IS_DEBUG) {
					ex.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public boolean needFilter(String domain, int ip) {

		if (domain == null) {
			return false;
		}

		boolean filter = false;
		if (mIpMask.get(ip, -1) == 1) {
			filter = true;
		}
		if (Pattern.matches("\\d+\\.\\d+\\.\\d+\\.\\d+", domain.trim())) {
			int newIp = CommonMethods.ipStringToInt(domain.trim());
			filter = filter || (mIpMask.get(newIp, -1) == 1);
		}
		String key = domain.trim();
		if (_mDomainMap0.containsKey(key) || _mDomainMap1.containsKey(key) || _mDomainMap2.containsKey(key) || _mDomainMap3.containsKey(key) || _mDomainMap4.containsKey(key) || _mDomainMap5.containsKey(key) || _mDomainMap6.containsKey(key) || _mDomainMap7.containsKey(key)) {
			filter = true;
			// int oldIP = mDomainMap.get(key);
			// if (!ProxyConfig.isFakeIP(ip) && ip != oldIP) {
			// 	mDomainMap.put(key, ip);
			// 	mIpMask.put(ip, 1);
			// }
		} else if (mDomainMap2.containsKey(key)) {
			System.out.println("mdomain2 contains the keyyyyyyyyyyyy");

			for (int i = 0; i < mDomainMap2.size(); ++i){
				System.out.println(mDomainMap2.size());
				System.out.println(mDomainMap2);
			}

			filter = true;
			// int oldIP = mDomainMap2.get(key);
			// if (!ProxyConfig.isFakeIP(ip) && ip != oldIP) {
			// 	mDomainMap2.put(key, ip);
			// 	mIpMask.put(ip, 1);
			// }
		}

		return filter; 
	}

	private void downloadHostFile(int which){
		try {
			URL url = new URL(malwareURL);

			if(which < 0 || which >= filterHostsSize){
				System.out.println("error filter hosts size");
				return;
			}

			switch(which){
				case 0:
					url = new URL(malwareURL);
					break;
				case 1:
					url = new URL(adsTrackingURL);
					break;
				case 2:
					url = new URL(socialURL);
					break;
				case 3:
					url = new URL(fakenewsURL);
					break;
				case 4:
					url = new URL(gamblingURL);
					break;
				case 5:
					url = new URL(xiaomiAdsURL);
					break;
				case 6:
					url = new URL(samsungAdsURL);
					break;
				case 7:
					url = new URL(spotifyAdsURL);
					break;
			}

			StringBuilder sb = new StringBuilder();
			sb.append("/host");
			sb.append(which);
			sb.append(".txt");

			URLConnection conexion = url.openConnection();
			conexion.connect();
			int lenghtOfFile = conexion.getContentLength();
			InputStream is = url.openStream();
			FileOutputStream fos = new FileOutputStream(mainContext.getExternalCacheDir() + sb.toString());
			byte data[] = new byte[1024];
			long total = 0;
			int count = 0;
			while ((count = is.read(data)) != -1) {
				total += count;
				int progress_temp = (int) total * 100 / lenghtOfFile;
				/*publishProgress("" + progress_temp); //only for asynctask
				if (progress_temp % 10 == 0 && progress != progress_temp) {
					progress = progress_temp;
				}*/
				fos.write(data, 0, count);
			}
			is.close();
			fos.close();
		} catch (Exception e) {
			System.out.println("Unable to download - " + e.getMessage());
			// Log.e("ERROR DOWNLOADING", "Unable to download" + e.getMessage());
		}
	}

	private InputStream getHostInputStream(int which) {
		StringBuilder sb = new StringBuilder();
		sb.append("/host");
		sb.append(which);
		sb.append(".txt");

		File file = new File(mainContext.getExternalCacheDir(), sb.toString());

		if(!file.exists()) {
			downloadHostFile(which);
		}

		InputStream in = null;
		// Değişiklik!
		// Context context = GlobalApplication.getInstance();
		System.out.println("****************************");
		System.out.println(mainContext.getExternalCacheDir());
		System.out.println("****************************");
		if (file.exists()) {
			try {
				in = new FileInputStream(file);
			} catch (IOException ex) {
				if (AppDebug.IS_DEBUG) {
					ex.printStackTrace(System.err);
				}
			}
		}
		if (in == null) {
			in = mainContext.getResources().openRawResource(R.raw.hosts);
		}
		return in;
	}
}
