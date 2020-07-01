#import "QqMtaPlugin.h"
#if __has_include(<qq_mta/qq_mta-Swift.h>)
#import <qq_mta/qq_mta-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "qq_mta-Swift.h"
#endif

static NSString CHANNEL_NAME = @"qq_mta";
@implementation QqMtaPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:CHANNEL_NAME
            binaryMessenger:[registrar messenger]];
  [registrar addMethodCallDelegate:instance channel:channel];
  //[SwiftQqMtaPlugin registerWithRegistrar:registrar];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"init" isEqualToString:call.method]) {
    NSString *iosAppKey = call.arguments[@"iosAppKey"];
    BOOL debugEnabled = call.arguments[@"debugEnabled"];

    [[MTAConfig getInstance] setDebugEnable:YES];
    [MTA startWithAppkey:iosAppKey];
  }
}
@end
