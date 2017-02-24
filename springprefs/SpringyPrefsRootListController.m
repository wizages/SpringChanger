#include "SpringyPrefsRootListController.h"
#import <CepheiPrefs/HBSupportController.h>
#import <libcolorpicker.h>
@implementation SpringyPrefsRootListController 

+ (NSString *)hb_specifierPlist {
    return @"Root";
}

+ (NSString *)hb_shareText {
    return @"Make your resprings awesome!";
}

+(NSString *)hb_shareURL {
    return @"";
}

- (void)showSupportEmailController {
	UIViewController *viewController = (UIViewController *)[HBSupportController supportViewControllerForBundle:[NSBundle bundleForClass:self.class] preferencesIdentifier:@"com.dopeteam.tails"];
	[self.navigationController pushViewController:viewController animated:YES];
}

-(void)preview{
	int32_t local = 0;
    CFMessagePortRef port = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR("com.wizages.babStart"));
    int progressPointer = local;
    NSData *progressMessage = [NSData dataWithBytes:&local length:sizeof(progressPointer)];
    if (port > 0) {
        CFMessagePortSendRequest(port, 0, (CFDataRef)progressMessage, 1000, 0, NULL, NULL);
    }
    HBLogDebug(@"Started");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    CFMessagePortRef port2 = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR("com.wizages.babEnd"));
	    if (port2 > 0) {
	        CFMessagePortSendRequest(port2, 0, (CFDataRef)progressMessage, 1000, 0, NULL, NULL);
	    }
	    HBLogDebug(@"Ended");
    });
}

@end