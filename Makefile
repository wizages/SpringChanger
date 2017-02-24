SDKVERSION = 10.1
SYSROOT = $(THEOS)/sdks/iPhoneOS10.1.sdk
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SpringChanger
SpringChanger_FILES = Tweak.xm SCPreferencesManager.m
SpringChanger_EXTRA_FRAMEWORKS = Cephei
SpringChanger_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += springprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
