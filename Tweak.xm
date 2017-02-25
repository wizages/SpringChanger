#import "SCPreferencesManager.h"

@interface PUIProgressWindow : NSObject {
	CALayer * _layer;
}

@property (nonatomic, readonly) CALayer *layer;

@end

@interface UIImage (twofers)
-(UIImage *)_flatImageWithColor:(UIColor *)color;
@end


%hook PUIProgressWindow

- (void)_createLayer {
	%orig;

	//self.layer.backgroundColor = [[SCPreferencesManager sharedInstance] colorForPreference:@"backgroundColor" fallback:@"#000000"].CGColor;
	UIImage *image = [[SCPreferencesManager sharedInstance]imageForShowing];
	if (image != nil){
		//self.layer.contentsScale = [UIScreen mainScreen].scale; //<-needed for the retina display, otherwise our image will not be scaled properly
		self.layer.contentsGravity = kCAGravityResizeAspectFill;
        //self.layer.contentsCenter = CGRectMake(15.0/image.size.width,0.0/image.size.height,1.0/image.size.width,0.0/image.size.height);
		self.layer.contents = (id)image.CGImage;
	}
}

- (CGImage*)_createImageWithName:(const char *)arg1 scale:(int)arg2 displayHeight:(int)arg3{
	return CGImageRetain([[UIImage imageWithCGImage:%orig] _flatImageWithColor:[[SCPreferencesManager sharedInstance] colorForPreference:@"appleColor" fallback:@"#000000"]].CGImage);

}

%end