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
  }
}
@end
