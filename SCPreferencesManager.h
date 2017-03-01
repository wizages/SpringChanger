#import <Cephei/HBPreferences.h>

@interface SCPreferencesManager : NSObject

@property (nonatomic, readonly) BOOL isImageEnabled;
@property (nonatomic, readonly) BOOL isTintEnabled;

+ (instancetype)sharedInstance;
- (UIColor *)colorForPreference:(NSString *)string fallback:(NSString *)fallback ;
- (UIImage *)imageForShowing;
@end