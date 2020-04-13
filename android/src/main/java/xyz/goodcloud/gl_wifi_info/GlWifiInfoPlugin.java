package xyz.goodcloud.gl_wifi_info;

import android.content.Context;
import android.net.DhcpInfo;
import android.net.wifi.WifiManager;
import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static android.content.Context.WIFI_SERVICE;

/** GlWifiInfoPlugin */
public class GlWifiInfoPlugin implements MethodCallHandler {
  final String TAG= "WifiIpPlugin";
  final Context context;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "gl_wifi_info");
    channel.setMethodCallHandler(new GlWifiInfoPlugin(registrar.context()));
  }

  GlWifiInfoPlugin(Context ctx) {
    context = ctx;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getWifiIp")) {
      result.success(getWifiInfo());
    } else {
      result.notImplemented();
    }
  }

  public String getWifiInfo() {
    try {
      WifiManager wifiManager = (WifiManager) context.getApplicationContext().getSystemService(WIFI_SERVICE);
      DhcpInfo dhcpInfo = wifiManager.getDhcpInfo();

      return intToIp(dhcpInfo.gateway);
    } catch (Exception e) {
      Log.e(TAG, e.getMessage());
    }
    return null;
  }

  String intToIp(int i) {
    return (i & 0xFF) + "." +
            ((i >> 8) & 0xFF) + "." +
            ((i >> 16) & 0xFF) + "." +
            ((i >> 24) & 0xFF);
  }

}
