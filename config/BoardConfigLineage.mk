# Charger
ifeq ($(WITH_LINEAGE_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.lineage
endif

include vendor/paosp/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/paosp/config/BoardConfigQcom.mk
endif

include vendor/paosp/config/BoardConfigSoong.mk
