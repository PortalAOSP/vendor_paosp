
# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= PornAOSP

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    persist.sys.disable_rescue=true \
    ro.build.selinux=1 \
	ro.opa.eligible_device=true \
	ro.storage_manager.enabled=true \
    ro.com.google.ime.themes_dir=/system/etc/gboard_theme \
    ro.com.google.ime.theme_file=PornAosp.zip

# Default alarm/notification/ringtone sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.alarm_alert=Bright_morning.ogg \
    ro.config.notification_sound=Popcorn.ogg \
    ro.config.ringtone=The_big_adventure.ogg 

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/paosp/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/paosp/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/paosp/prebuilt/common/bin/50-paosp.sh:system/addon.d/50-paosp.sh \
    vendor/paosp/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/paosp/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/paosp/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/paosp/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/paosp/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# PornAOSP-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/paosp/config/permissions/paosp-sysconfig.xml:system/etc/sysconfig/paosp-sysconfig.xml

# PornAOSP Things
PRODUCT_COPY_FILES += \
    vendor/paosp/prebuilt/common/etc/gboard_theme/PornAosp.zip:system/etc/gboard_theme/PornAosp.zip 

# init.d support
PRODUCT_COPY_FILES += \
    vendor/paosp/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/paosp/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/paosp/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all PornAOSP-specific init rc files
$(foreach f,$(wildcard vendor/paosp/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/paosp/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is PornAOSP!
PRODUCT_COPY_FILES += \
    vendor/paosp/config/permissions/org.lineageos.android.xml:system/etc/permissions/org.lineageos.android.xml \
    vendor/paosp/config/permissions/privapp-permissions-lineage.xml:system/etc/permissions/privapp-permissions-lineage.xml

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/paosp/config/permissions/lineage-hiddenapi-package-whitelist.xml:system/etc/permissions/lineage-hiddenapi-package-whitelist.xml

# Include PornAOSP audio files
include vendor/paosp/config/paosp_audio.mk

# Include PornOTA config
include vendor/paosp/config/ota.mk

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/paosp/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/paosp/config/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/paosp/config/twrp.mk
endif

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Required PornAOSP packages
PRODUCT_PACKAGES += \
    LineageParts \
    Development \
    Profiles \
    Turbo \
    turbo.xml \
    privapp-permissions-turbo.xml 

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom PornAOSP packages
PRODUCT_PACKAGES += \
    BrowserInstaller \
    LineageSettingsProvider \
    LineageSetupWizard \
    Eleven \
    ExactCalculator \
    Focus \
    GBoard \
    Gallery \
    Pornhub \
    Lawnchair \
    LockClock \
    PinkPipe \
    WallpaperPicker \
    WeatherProvider \
    OPWeather \
    SubsKey

#
# Turbo notch experience
#

PRODUCT_PACKAGES += \
    DisplayCutoutEmulationTurboTallOverlay \
    DisplayCutoutEmulationTurboDoubleOverlay

	
# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Berry styles
include packages/overlays/PornAOSP/product_packages.mk

# Extra tools in PornAOSP
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_LINEAGE_CHARGER),true)
PRODUCT_PACKAGES += \
    lineage_charger_res_images \
    font_log.png \
    libhealthd.lineage
endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# maybe this will work
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.ime.themes_dir=/system/etc/gboard_theme \
    ro.com.google.ime.theme_file=PornAosp.zip

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    micro_bench \
    procmem \
    procrank \
    strace

# Conditionally build in su
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/paosp/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/paosp/overlay/common

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/paosp/build/target/product/security/lineage

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/paosp/config/partner_gms.mk

# Use release-keys with Official builds if possible
include vendor/paosp/config/release_keys.mk