# Inherit full common PornAOSP stuff
$(call inherit-product, vendor/paosp/config/common_full.mk)

PRODUCT_PACKAGES += \
    AppDrawer \
    LineageCustomizer

DEVICE_PACKAGE_OVERLAYS += vendor/paosp/overlay/tv
