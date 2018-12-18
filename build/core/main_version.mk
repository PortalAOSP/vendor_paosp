# PornAOSP System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.paosp.version=$(XENONHD_VERSION) \
    ro.paosp.type=$(OTA_TYPE) \
    ro.paosp.timestamp=$(shell date +%s)

# LineageOS Platform SDK Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)
