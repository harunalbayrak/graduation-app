// package com.example.graduation_app

// import android.app.Activity.RESULT_OK
// import android.app.Service
// import androidx.annotation.NonNull
// import android.content.Intent
// import android.content.ComponentName
// import android.content.ServiceConnection
// import android.content.Context
// import android.os.IBinder
// import android.net.VpnService
// import android.net.ConnectivityManager
// import com.w3engineers.vpn.*
// import java.net.NetworkInterface
// import java.util.*

// import io.flutter.embedding.engine.plugins.FlutterPlugin
// import io.flutter.embedding.engine.plugins.activity.ActivityAware
// import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
// import io.flutter.plugin.common.EventChannel
// import io.flutter.plugin.common.MethodCall
// import io.flutter.plugin.common.MethodChannel
// import io.flutter.plugin.common.MethodChannel.MethodCallHandler
// import io.flutter.plugin.common.MethodChannel.Result
// import io.flutter.plugin.common.PluginRegistry

// class FlutterVPNService: FlutterPlugin, MethodCallHandler, ActivityAware {
//   private val CHANNEL = "local_vpn_service"
//   private lateinit var activityMainBinding: ActivityPluginBinding

//   private lateinit var channel: MethodChannel
//   private lateinit var eventChannel: EventChannel

//   private var vpnStateService: VpnStateService? = null
//   private val _serviceConnection = object : ServiceConnection {
//     override fun onServiceConnected(name: ComponentName, service: IBinder) {
//         vpnStateService = (service as VpnStateService.LocalBinder).service
//         VpnStateHandler.vpnStateService = vpnStateService
//         vpnStateService?.registerListener(VpnStateHandler)
//     }

//     override fun onServiceDisconnected(name: ComponentName) {
//         vpnStateService = null
//         VpnStateHandler.vpnStateService = null
//     }
//   }

//   /*
//   override fun startUI() {
//     activityMainBinding = viewDataBinding as ActivityPluginBinding
//     activityMainBinding.setLifecycleOwner(this)
//     activityMainBinding.vpnStateModel = VpnStateModel()
//   }
//   */

//   override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//     when (call.method) {
//       "deneme" -> {
//           result.success(10)
//       }
//       "prepare" -> {
//         val intent = VpnService.prepare(activityMainBinding.activity.applicationContext)
//         if (intent != null) {
//           var listener: PluginRegistry.ActivityResultListener? = null
//           listener = PluginRegistry.ActivityResultListener { req, res, _ ->
//               if (req == 0 && res == RESULT_OK) {
//                   result.success(true)
//               } else {
//                   result.success(false)
//               }
//               listener?.let { activityMainBinding.removeActivityResultListener(it) };
//               true
//           }
//           activityMainBinding.addActivityResultListener(listener)
//           activityMainBinding.activity.startActivityForResult(intent, 0)
//         } else {
//           // If intent is null, already prepared
//           result.success(true)
//         }
//       }
//     }
//   }

//   override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//     // Load charon bridge
//     System.loadLibrary("androidbridge")

//     // Register method channel.
//     channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_vpn")
//     channel.setMethodCallHandler(this);

//     // Register event channel to handle state change.
//     eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "flutter_vpn_states")
//     eventChannel.setStreamHandler(VpnStateHandler)

//     flutterPluginBinding.applicationContext.bindService(
//       Intent(flutterPluginBinding.applicationContext, LocalVPNService::class.java),
//       _serviceConnection,
//       Service.BIND_AUTO_CREATE
//     )
//   }

//   override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
//     channel.setMethodCallHandler(null)
//     eventChannel.setStreamHandler(null)
//   }

//   /*
//   override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//       super.configureFlutterEngine(flutterEngine)
//       MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//         call, result ->
        
//         if (call.method == "deneme") {
//           //var x = VhostsService();
//           //var x = Address()
//           //print(Address.IPv4);

//           result.success(10)
//         } else {
//           result.notImplemented()
//         }
//       }
//   }
//   */

//   /*
//   override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
//       println("onActivityResult(resultCode:  $resultCode)")  
//       if (resultCode == RESULT_OK) {
//         val vpnServiceIntent = Intent(applicationContext, LocalVPNService::class.java)
//         startService(vpnServiceIntent)
//         activityMainBinding.vpnStateModel?.setIsVpnServiceRunningLiveData(true)
//       } else if (resultCode == RESULT_CANCELED) {
//         println("Refused")  
//         //showVPNRefusedDialog()
//       }
//   }
//   */

//   fun startUI() {
//       activityMainBinding = viewDataBinding as ActivityMainBinding
//       activityMainBinding.setLifecycleOwner(this)
//       activityMainBinding.vpnStateModel = VpnStateModel()
//   }
    
//   fun startVPN(){
//     // check for VPN already running
//     try {
//       if (!checkForActiveInterface("tun0")) {
//         // get user permission for VPN
//         val intent = VpnService.prepare(this)
//         if (intent != null) {
//           println("ask user for VPN permission")
//           //startActivityForResult(intent, 0)
//         } else {
//           println("already have VPN permission")
//           //onActivityResult(0, RESULT_OK, null)
//         }
//       }
//     } catch (e: Exception) {
//       println("Exception checking network interfaces :" + e.message)
//       e.printStackTrace()
//     }
//   }

//   /**
//    * check a network interface by name
//    *
//    * @param networkInterfaceName Network interface Name on Linux, for example tun0
//    * @return true if interface exists and is active
//    * @throws Exception throws Exception
//    */
//   @Throws(Exception::class)
//   private fun checkForActiveInterface(networkInterfaceName: String): Boolean {
//       val interfaces = Collections.list(NetworkInterface.getNetworkInterfaces())
//       for (networkInterface in interfaces) {
//           if (networkInterface.name == networkInterfaceName) {
//               return networkInterface.isUp
//           }
//       }
//       return false
//   }

//   /** check whether network is connected or not
//    * @return boolean
//    */
//   private fun isConnectedToInternet(): Boolean {
//     val connectivity = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
//     val networkInfo = connectivity.activeNetworkInfo
//     if (networkInfo != null && networkInfo.isConnected) {
//         return true
//     }
//     return false
//   }



//   /* FLUTTER-VPN */
//   override fun onAttachedToActivity(binding: ActivityPluginBinding) {
//     activityMainBinding = binding
//   }

//   override fun onDetachedFromActivity() {
//   }

//   override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
//     activityMainBinding = binding
//   }

//   override fun onDetachedFromActivityForConfigChanges() {
//   }
// }

