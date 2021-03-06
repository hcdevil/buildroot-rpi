#############################################################
#
# qt5quick1
#
#############################################################

# Thursday June 20 2013, stable
QT5QUICK1_VERSION = 573b316e3a86a113a951d0add1f5d17afec55f25
# Tuesday May 28 2013, release
#QT5QUICK1_VERSION = dfe77c25412eedcfecfd738904c2714c53d1e3bb
QT5QUICK1_SITE = git://gitorious.org/qt/qtquick1.git
QT5QUICK1_SITE_METHOD = git

#QT5QUICK1_VERSION = $(QT5_VERSION)
#QT5QUICK1_SITE = $(QT5_SITE)
#QT5QUICK1_SOURCE = qtquick1-opensource-src-$(QT5QUICK1_VERSION).tar.xz

QT5QUICK1_DEPENDENCIES = qt5base qt5xmlpatterns qt5script qt5declarative qt5jsbackend qt5webkit

QT5QUICK1_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_QT5BASE_LICENSE_APPROVED),y)
QT5QUICK1_CONFIGURE_OPTS += -opensource -confirm-license
QT5QUICK1_LICENSE = LGPLv2.1 or GPLv3.0
# Here we would like to get license files from qt5base, but qt5base
# may not be extracted at the time we get the legal-info for
# qt5script.
else
QT5QUICK1_LICENSE = Commercial license
QT5QUICK1_REDISTRIBUTE = NO
endif

define QT5QUICK1_CONFIGURE_CMDS
	(cd $(@D); $(HOST_DIR)/usr/bin/qmake)
endef

define QT5QUICK1_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5QUICK1_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
	$(QT5_LA_PRL_FILES_FIXUP)
endef

define QT5QUICK1_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5Declarative.so.* $(TARGET_DIR)/usr/lib
#	cp -dpf $(STAGING_DIR)/usr/lib/qt/plugins/qmltooling/libqmldbg_inspector.so $(TARGET_DIR)/usr/lib/qt/plugins/qmltooling/
#	cp -dpf $(STAGING_DIR)/usr/lib/qt/plugins/qmltooling/libqmldbg_tcp_qtdeclarative.so $(TARGET_DIR)/usr/lib/qt/plugins/qmltooling/
#	cp -dpf $(STAGING_DIR)/usr/bin/qmlviewer $(TARGET_DIR)/usr/bin
	cp -dpfr $(STAGING_DIR)/usr/imports $(TARGET_DIR)/usr
endef

$(eval $(generic-package))
