$(call inherit-product, device/google/caimito/aosp_caiman.mk)

PRODUCT_NAME := aosp_caiman_16k

TARGET_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_BOOTS_16K := true
