#include <ifaddrs.h>
#include <arpa/inet.h>

#import "IpHelper.h"
#import "GlWifiInfoPlugin.h"

@implementation GlWifiInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"gl_wifi_info"
            binaryMessenger:[registrar messenger]];
  GlWifiInfoPlugin* instance = [[GlWifiInfoPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getWifiIp" isEqualToString:call.method]) {
    result([self defaultRouter]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSString *)defaultRouter {
  NSString *ipString = nil;
  struct in_addr gatewayaddr;
  int r = getdefaultgateway(&(gatewayaddr.s_addr));
  if(r >= 0) {
      ipString = [NSString stringWithFormat: @"%s",inet_ntoa(gatewayaddr)];
  } else {
      NSLog(@"Wifi is not connected or you are using simulator Gateway ip address will be nil");
  }
  return ipString;
}

@end
