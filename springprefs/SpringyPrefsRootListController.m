#include "SpringyPrefsRootListController.h"
#import <CepheiPrefs/HBSupportController.h>
#import <Cephei/HBPreferences.h>
#include <notify.h>
#import <libcolorpicker.h>

@import Photos;

@implementation SpringyPrefsRootListController{
	HBPreferences *_preferences;
}


+ (NSString *)hb_specifierPlist {
    return @"Root";
}

+ (NSString *)hb_shareText {
    return @"Make your resprings awesome or something like that... Or just say hi to Apple :)";
}

+(NSString *)hb_shareURL {
    return @"";
}

-(void)viewDidLoad{
	[super viewDidLoad];
	_preferences = [[HBPreferences alloc] initWithIdentifier:@"com.wizage.SpringPrefs"];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    CFMessagePortRef port2 = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR("com.wizages.babEnd"));
	    if (port2 > 0) {
	        CFMessagePortSendRequest(port2, 0, (CFDataRef)progressMessage, 1000, 0, NULL, NULL);
	    }
	    HBLogDebug(@"Ended");
    });
}

- (void)selectPhotos
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    [picker release];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	spinner.frame = picker.view.frame;
	spinner.hidesWhenStopped = YES;
	[picker.view addSubview:spinner];
	[spinner startAnimating];
	_preferences[@"photo"] = UIImageJPEGRepresentation(image, 0.5);
	notify_post([@"com.wizage.SpringPrefs/ReloadPrefs" UTF8String]);
	[self dismissViewControllerAnimated:YES completion:^{
		[spinner stopAnimating];
	}];
	
	
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end