#import "SCPreferencesManager.h"
#import <Cephei/HBPreferences.h>
#import <libcolorpicker.h>

static NSString *const kSCEnabledKey = @"enabled";


@implementation SCPreferencesManager {
	HBPreferences *_preferences;
}

+ (instancetype)sharedInstance {
	static SCPreferencesManager *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});

	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		_preferences = [[HBPreferences alloc] initWithIdentifier:@"com.wizage.SpringPrefs"];

		[_preferences registerBool:&_enabled default:YES forKey:kSCEnabledKey];
	}

	return self;
}

- (UIColor *)colorForPreference:(NSString *)string fallback:(NSString *)fallback {

	NSString *potentialIndividualTint = _preferences[string];
	if (potentialIndividualTint) {
		return LCPParseColorString(potentialIndividualTint, @"#000000");
	}
	return LCPParseColorString(fallback, @"#000000");
}

#pragma mark - Memory management

- (void)dealloc {
	[_preferences release];

	[super dealloc];
}

@end