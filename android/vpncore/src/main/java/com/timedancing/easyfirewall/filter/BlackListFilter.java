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

	private Map<String, Integer> mDomainMap = new HashMap<>();
	private SparseIntArray mIpMask = new SparseIntArray();
	private static Context mainContext;
	private static Map<String, Integer> mDomainMap2 = new HashMap<>();

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

	@Override
	public void prepare() {

		if (mDomainMap.size() != 0 || mIpMask.size() != 0) {
			return;
		}

		InputStream in = getHostInputStream();
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
					mDomainMap.put(parts[1], ip);
					mIpMask.put(ip, 1);
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
		if (mDomainMap.containsKey(key)) {
			filter = true;
			int oldIP = mDomainMap.get(key);
			if (!ProxyConfig.isFakeIP(ip) && ip != oldIP) {
				mDomainMap.put(key, ip);
				mIpMask.put(ip, 1);
			}
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

	private void downloadHostFile(){
		try {
			URL url = new URL("https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts");
			URLConnection conexion = url.openConnection();
			conexion.connect();
			int lenghtOfFile = conexion.getContentLength();
			InputStream is = url.openStream();
			FileOutputStream fos = new FileOutputStream(mainContext.getExternalCacheDir() + "/host.txt");
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

	private InputStream getHostInputStream() {
		File file = new File(mainContext.getExternalCacheDir(), "/host.txt");

		if(!file.exists()) {
			downloadHostFile();
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
