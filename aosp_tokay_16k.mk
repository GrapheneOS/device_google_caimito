$(call inherit-product, device/google/caimito/aosp_tokay.mk)

PRODUCT_NAME := aosp_tokay_16k

TARGET_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_BOOTS_16K := true
