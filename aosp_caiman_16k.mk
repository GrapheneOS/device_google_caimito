$(call inherit-product, device/google/caimito/aosp_caiman.mk)

PRODUCT_NAME := aosp_caiman_16k

TARGET_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_RW_FILE_SYSTEM_TYPE := ext4
TARGET_BOOTS_16K := true
