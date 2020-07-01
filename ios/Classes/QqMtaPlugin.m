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
    NSString *iosAppKey = call.arguments[@"iosAppKey"];
    BOOL debugEnabled = call.arguments[@"debugEnabled"];

    [[MTAConfig getInstance] setDebugEnable:debugEnabled];
    [MTA startWithAppkey:iosAppKey];
  }
}
@end
