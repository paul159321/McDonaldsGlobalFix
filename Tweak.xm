#import <Foundation/Foundation.h>

static NSString *const kTargetBundleIdentifier = @"com.mcdonalds.mobileapp";
static NSString *const kMinimumBuildRemoteConfigKey = @"forceUpdate_minIOSBuild";

// Minimal FIRRemoteConfigValue-compatible object. The app reads numberValue
// for this setting; the other accessors keep alternate conversion paths safe.
@interface McDonaldsGlobalFixMinimumBuildValue : NSObject
+ (instancetype)sharedValue;
- (NSNumber *)numberValue;
- (NSString *)stringValue;
- (NSData *)dataValue;
- (BOOL)boolValue;
- (NSInteger)source;
@end

@implementation McDonaldsGlobalFixMinimumBuildValue

+ (instancetype)sharedValue {
    static McDonaldsGlobalFixMinimumBuildValue *value;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        value = [McDonaldsGlobalFixMinimumBuildValue new];
    });
    return value;
}

- (NSNumber *)numberValue {
    return @0;
}

- (NSString *)stringValue {
    return @"0";
}

- (NSData *)dataValue {
    return [@"0" dataUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)boolValue {
    return NO;
}

- (NSInteger)source {
    return 2;
}

@end


static BOOL IsTargetApp(void) {
    return [NSBundle.mainBundle.bundleIdentifier
        isEqualToString:kTargetBundleIdentifier];
}

static BOOL IsMinimumBuildKey(id key) {
    return [key isKindOfClass:NSString.class] &&
           [(NSString *)key isEqualToString:kMinimumBuildRemoteConfigKey];
}


%group McDonaldsGlobalFixRemoteConfigBypass

%hook FIRRemoteConfig

- (id)configValueForKey:(NSString *)key {
    if (IsMinimumBuildKey(key)) {
        return [McDonaldsGlobalFixMinimumBuildValue sharedValue];
    }
    return %orig;
}

- (id)configValueForKey:(NSString *)key source:(NSInteger)source {
    if (IsMinimumBuildKey(key)) {
        return [McDonaldsGlobalFixMinimumBuildValue sharedValue];
    }
    return %orig;
}

- (id)objectForKeyedSubscript:(NSString *)key {
    if (IsMinimumBuildKey(key)) {
        return [McDonaldsGlobalFixMinimumBuildValue sharedValue];
    }
    return %orig;
}

%end


%end


%ctor {
    @autoreleasepool {
        // Support any GMALite version. If Firebase Remote Config is absent,
        // do nothing instead of attempting to hook an unavailable class.
        if (IsTargetApp() && NSClassFromString(@"FIRRemoteConfig") != Nil) {
            %init(McDonaldsGlobalFixRemoteConfigBypass);
        }
    }
}
