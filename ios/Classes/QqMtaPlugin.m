#import "QqMtaPlugin.h"
#import "MTA.h"
#import "MTAConfig.h"

static NSString *CHANNEL_NAME = @"qq_mta";
@implementation QqMtaPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:CHANNEL_NAME
            binaryMessenger:[registrar messenger]];
    QqMtaPlugin* instance = [[QqMtaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  //[SwiftQqMtaPlugin registerWithRegistrar:registrar];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"init" isEqualToString:call.method]) {
    NSDictionary *arguments=  [call arguments];
    NSString *iosAppKey = arguments[@"iosAppKey"];
    BOOL debugEnabled = [[arguments objectForKey:@"debugEnabled"] boolValue];
    [[MTAConfig getInstance] setDebugEnable:debugEnabled];
    [MTA startWithAppkey:iosAppKey];
  } else if ([@"trackEvent" isEqualToString:call.method]) {
    NSDictionary *arguments=  [call arguments];
    NSString *eventName = arguments[@"eventName"];
    NSDictionary *parameters = arguments[@"parameters"];
    if (parameters != nil) {
        [MTA trackCustomKeyValueEvent:eventName props:parameters];
    } else {
        [MTA trackCustomKeyValueEvent:eventName props:nil];
    }
  } else if ([@"isVPNOn" isEqualToString:call.method]) {
    BOOL isVPNOn = [self isVPNOn];
    result(isVPNOn);
  }
}

- (BOOL)isVPNOn
{
   BOOL flag = NO;
   NSString *version = [UIDevice currentDevice].systemVersion;
   // need two ways to judge this.
   if (version.doubleValue >= 9.0)
   {
       NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
       NSArray *keys = [dict[@"__SCOPED__"] allKeys];
       for (NSString *key in keys) {
           if ([key rangeOfString:@"tap"].location != NSNotFound ||
               [key rangeOfString:@"tun"].location != NSNotFound ||
               [key rangeOfString:@"ipsec"].location != NSNotFound ||
               [key rangeOfString:@"ppp"].location != NSNotFound){
               flag = YES;
               break;
           }
       }
   }
   else
   {
       struct ifaddrs *interfaces = NULL;
       struct ifaddrs *temp_addr = NULL;
       int success = 0;
       
       // retrieve the current interfaces - returns 0 on success
       success = getifaddrs(&interfaces);
       if (success == 0)
       {
           // Loop through linked list of interfaces
           temp_addr = interfaces;
           while (temp_addr != NULL)
           {
               NSString *string = [NSString stringWithFormat:@"%s" , temp_addr->ifa_name];
               if ([string rangeOfString:@"tap"].location != NSNotFound ||
                   [string rangeOfString:@"tun"].location != NSNotFound ||
                   [string rangeOfString:@"ipsec"].location != NSNotFound ||
                   [string rangeOfString:@"ppp"].location != NSNotFound)
               {
                   flag = YES;
                   break;
               }
               temp_addr = temp_addr->ifa_next;
           }
       }
       
       // Free memory
       freeifaddrs(interfaces);
   }


   return flag;
}
@end
