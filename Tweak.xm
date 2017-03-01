#import "SCPreferencesManager.h"

@interface CALayer (seconds)
@property struct CGColor*contentsMultiplyColor;
@end

@interface PUIProgressWindow : NSObject {
	CALayer * _layer;
	CALayer * _progressLayer;
}

@property (nonatomic, readonly) CALayer *layer;

@end

@interface UIImage (twofers)
-(UIImage *)_flatImageWithColor:(UIColor *)color;
@end


%hook PUIProgressWindow

- (void)_createLayer {
	%orig;

	UIImage *image = [[SCPreferencesManager sharedInstance]imageForShowing];
	if (image != nil && [[SCPreferencesManager sharedInstance] isImageEnabled]){
		self.layer.contentsGravity = kCAGravityResizeAspectFill;
		self.layer.contents = (id)image.CGImage;
	} else {
		self.layer.backgroundColor = [[SCPreferencesManager sharedInstance] colorForPreference:@"backgroundColor" fallback:@"#000000"].CGColor;
	}

	CALayer *myProgressLayer = MSHookIvar<CALayer *>(self, "_progressLayer");
	if(myProgressLayer != nil){
		myProgressLayer.contentsMultiplyColor = [[SCPreferencesManager sharedInstance] colorForPreference:@"progressColor" fallback:@"#FFFFFF"].CGColor;
	}
}

- (CGImage*)_createImageWithName:(const char *)arg1 scale:(int)arg2 displayHeight:(int)arg3{
	if ([[SCPreferencesManager sharedInstance] isTintEnabled])
		return CGImageRetain([[UIImage imageWithCGImage:%orig] _flatImageWithColor:[[SCPreferencesManager sharedInstance] colorForPreference:@"appleColor" fallback:@"#FFFFFF"]].CGImage);
	else
		return %orig;

}

%end