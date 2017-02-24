#import <Cephei/HBPreferences.h>

@interface SCPreferencesManager : NSObject

@property (nonatomic, readonly) BOOL enabled;

+ (instancetype)sharedInstance;
- (UIColor *)colorForPreference:(NSString *)string fallback:(NSString *)fallback ;
@end