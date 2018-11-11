# OTA default build type
ifeq ($(OTA_TYPE),)
OTA_TYPE=Amateur
endif

# Make sure the uppercase is used
ifeq ($(OTA_TYPE),teen)
OTA_TYPE=Teen
endif
ifeq ($(OTA_TYPE),professional)
OTA_TYPE=Professional
endif

# PornAOSP version
PAOSP_VERSION := PAOSP_creamPie-$(shell date +"%y%m%d")-$(OTA_TYPE)
DEVICE := $(subst paosp_,,$(TARGET_PRODUCT))

ifneq ($(OTA_TYPE),Amateur)
# PAOSP OTA app
PRODUCT_PACKAGES += \
    PornOTA

# OTA Configuration
$(shell echo -e "OTA_Configuration\n \
ota_experimental=https://mirrors.c0urier.net/android/teamhorizon/P/OTA/ota_$(DEVICE)_experimental.xml\n \
ota_official=https://mirrors.c0urier.net/android/teamhorizon/P/OTA/ota_$(DEVICE)_official.xml\n \
device_name=ro.xenonhd.device\n \
release_type=Pie\n \
version_source=ro.paosp.version\n \
version_delimiter=-\n \
version_position=1\n \
version_format=yyMMdd" > $(OTA_DIR)/ota_conf)
endif
