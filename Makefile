TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME ?= rootless
INSTALL_TARGET_PROCESSES = GMALite
DEBUG = 0
PACKAGE_VERSION = 1.5.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = McDonaldsGlobalFix
McDonaldsGlobalFix_FILES = Tweak.xm
McDonaldsGlobalFix_CFLAGS = -fobjc-arc -Wall -Wextra
McDonaldsGlobalFix_FRAMEWORKS = Foundation
McDonaldsGlobalFix_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/tweak.mk
