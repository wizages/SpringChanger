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

	self.layer.backgroundColor = [[SCPreferencesManager sharedInstance] colorForPreference:@"backgroundColor" fallback:@"#000000"].CGColor;


}

- (CGImage*)_createImageWithName:(const char *)arg1 scale:(int)arg2 displayHeight:(int)arg3{
	return CGImageRetain([[UIImage imageWithCGImage:%orig] _flatImageWithColor:[[SCPreferencesManager sharedInstance] colorForPreference:@"appleColor" fallback:@"#000000"]].CGImage);

}

%end