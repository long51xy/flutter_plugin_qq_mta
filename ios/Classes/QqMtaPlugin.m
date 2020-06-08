#import "QqMtaPlugin.h"
#if __has_include(<qq_mta/qq_mta-Swift.h>)
#import <qq_mta/qq_mta-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "qq_mta-Swift.h"
#endif

@implementation QqMtaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftQqMtaPlugin registerWithRegistrar:registrar];
}
@end
