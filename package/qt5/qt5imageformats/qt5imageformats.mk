#############################################################
#
# qt5imageformats
#
#############################################################

# Wednesday June 12 2013, stable
QT5IMAGEFORMATS_VERSION = a196fc62304ae23e68f60ae85a6106692f419f98
# Tuesday June 04 2013, release
#QT5IMAGEFORMATS_VERSION = 37257d4be0cab8d5a92db9566f89ac115645f81f
QT5IMAGEFORMATS_SITE = git://gitorious.org/qt/qtimageformats.git
QT5IMAGEFORMATS_SITE_METHOD = git

#QT5IMAGEFORMATS_VERSION = $(QT5_VERSION)
#QT5IMAGEFORMATS_SITE = $(QT5_SITE)
#QT5IMAGEFORMATS_SOURCE = qtimageformats-opensource-src-$(QT5IMAGEFORMATS_VERSION).tar.xz

QT5IMAGEFORMATS_DEPENDENCIES = qt5base

QT5IMAGEFORMATS_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_QT5BASE_LICENSE_APPROVED),y)
QT5IMAGEFORMATS_CONFIGURE_OPTS += -opensource -confirm-license
QT5IMAGEFORMATS_LICENSE = LGPLv2.1 or GPLv3.0
# Here we would like to get license files from qt5base, but qt5base
# may not be extracted at the time we get the legal-info for qt5svg.
else
QT5IMAGEFORMATS_LICENSE = Commercial license
QT5IMAGEFORMATS_REDISTRIBUTE = NO
endif

define QT5IMAGEFORMATS_CONFIGURE_CMDS
	(cd $(@D); $(HOST_DIR)/usr/bin/qmake)
endef

define QT5IMAGEFORMATS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5IMAGEFORMATS_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

ifeq ($(BR2_PREFER_STATIC_LIB),)
define QT5IMAGEFORMATS_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/qt/plugins/imageformats/*.so $(TARGET_DIR)/usr/lib/qt/plugins/imageformats/
endef
endif

$(eval $(generic-package))
