SDKVERSION = 10.1
SYSROOT = $(THEOS)/sdks/iPhoneOS10.1.sdk
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SpringPrefs
SpringPrefs_FILES = SpringyPrefsRootListController.m HBColorPickerCell.m
SpringPrefs_INSTALL_PATH = /Library/PreferenceBundles
SpringPrefs_FRAMEWORKS = UIKit
SpringPrefs_PRIVATE_FRAMEWORKS = Preferences
SpringPrefs_EXTRA_FRAMEWORKS = CepheiPrefs Cephei
SpringPrefs_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SpringPrefs.plist$(ECHO_END)
