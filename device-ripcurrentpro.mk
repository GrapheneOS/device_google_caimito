#
# Copyright (C) 2021 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifdef RELEASE_GOOGLE_RIPCURRENTPRO_RADIO_DIR
RELEASE_GOOGLE_PRODUCT_RADIO_DIR := $(RELEASE_GOOGLE_RIPCURRENTPRO_RADIO_DIR)
endif
ifdef RELEASE_GOOGLE_RIPCURRENTPRO_RADIOCFG_DIR
RELEASE_GOOGLE_PRODUCT_RADIOCFG_DIR := $(RELEASE_GOOGLE_RIPCURRENTPRO_RADIOCFG_DIR)
endif
RELEASE_GOOGLE_BOOTLOADER_RIPCURRENTPRO_DIR ?= 24D1# Keep this for pdk TODO: b/327119000
RELEASE_GOOGLE_PRODUCT_BOOTLOADER_DIR := bootloader/$(RELEASE_GOOGLE_BOOTLOADER_RIPCURRENTPRO_DIR)
$(call soong_config_set,caimito_bootloader,prebuilt_dir,$(RELEASE_GOOGLE_BOOTLOADER_RIPCURRENTPRO_DIR))

ifdef RELEASE_KERNEL_RIPCURRENTPRO_DIR
TARGET_KERNEL_DIR ?= $(RELEASE_KERNEL_RIPCURRENTPRO_DIR)
TARGET_BOARD_KERNEL_HEADERS ?= $(RELEASE_KERNEL_RIPCURRENTPRO_DIR)/kernel-headers
else
TARGET_KERNEL_DIR ?= device/google/caimito-kernels/6.1/24D1
TARGET_BOARD_KERNEL_HEADERS ?= device/google/caimito-kernels/6.1/24D1/kernel-headers
endif

USE_SWIFTSHADER := false
BOARD_USES_SWIFTSHADER := false

$(call inherit-product-if-exists, vendor/google_devices/caimito/prebuilts/device-vendor-ripcurrentpro.mk)
$(call inherit-product-if-exists, vendor/google_devices/zumapro/prebuilts/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/zumapro/proprietary/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/caimito/proprietary/ripcurrentpro/device-vendor-ripcurrentpro.mk)
$(call inherit-product-if-exists, vendor/qorvo/uwb/qm35-hal/Device.mk)

include device/google/caimito/audio/ripcurrentpro/audio-tables.mk
include device/google/zumapro/device-shipping-common.mk
include hardware/google/pixel/vibrator/cs40l26/device-stereo.mk
include device/google/gs-common/bcmbt/bluetooth.mk
include device/google/gs-common/touch/stm/stm20.mk
include device/google/caimito/fingerprint/ultrasonic_udfps.mk
include device/google/gs-common/gril/hidl/1.7/gril_hidl.mk

# go/lyric-soong-variables
$(call soong_config_set,lyric,camera_hardware,ripcurrentpro)
$(call soong_config_set,lyric,tuning_product,ripcurrentpro)
$(warning target_device set to zuma on zumapro target)
$(call soong_config_set,google3a_config,target_device,ripcurrent)

# display
DEVICE_PACKAGE_OVERLAYS += device/google/caimito/ripcurrentpro/overlay

# Init files
PRODUCT_COPY_FILES += \
	device/google/caimito/conf/init.ripcurrentpro.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.ripcurrentpro.rc

# Recovery files
PRODUCT_COPY_FILES += \
        device/google/caimito/conf/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.ripcurrentpro.rc

# NFC
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
	frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
	frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
	device/google/caimito/nfc/libnfc-hal-st-disable.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf \
	device/google/caimito/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st-enable.conf \
	device/google/caimito/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf

PRODUCT_PACKAGES += \
	$(RELEASE_PACKAGE_NFC_STACK) \
	Tag \
	android.hardware.nfc-service.st

# SecureElement
PRODUCT_PACKAGES += \
	android.hardware.secure_element-service.thales

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
	device/google/caimito/nfc/libse-gto-hal-disable.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libse-gto-hal.conf

# Bluetooth HAL
PRODUCT_COPY_FILES += \
	device/google/caimito/bluetooth/bt_vendor_overlay_ripcurrentpro.conf:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth/bt_vendor_overlay.conf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bluetooth.a2dp_offload.supported=true \
    persist.bluetooth.a2dp_offload.disabled=false \
    persist.bluetooth.a2dp_offload.cap=sbc-aac-aptx-aptxhd-ldac-opus

# POF
PRODUCT_PRODUCT_PROPERTIES += \
    ro.bluetooth.finder.supported=true

# Spatial Audio
PRODUCT_PACKAGES += \
	libspatialaudio

# declare use of spatial audio
PRODUCT_PROPERTY_OVERRIDES += \
       ro.audio.spatializer_enabled=true

# declare use of stereo spatialization
PRODUCT_PROPERTY_OVERRIDES += \
    ro.audio.stereo_spatialization_enabled=true

# Bluetooth hci_inject test tool
PRODUCT_PACKAGES_DEBUG += \
    hci_inject

# Bluetooth OPUS codec
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.opus.enabled=true

# Bluetooth SAR test tool
PRODUCT_PACKAGES_DEBUG += \
    sar_test

# Bluetooth EWP test tool
PRODUCT_PACKAGES_DEBUG += \
    ewp_tool

# Bluetooth AAC VBR
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.a2dp_aac.vbr_supported=true

# Override BQR mask to enable LE Audio Choppy report, remove BTRT logging
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.bqr.event_mask=262238
else
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.bqr.event_mask=94
endif

# default BDADDR for EVB only
PRODUCT_PROPERTY_OVERRIDES += \
	ro.vendor.bluetooth.evb_bdaddr="22:22:22:33:44:55"

# Spatial Audio
PRODUCT_PACKAGES += \
	libspatialaudio \
	librondo

# Bluetooth LE Audio
PRODUCT_PRODUCT_PROPERTIES += \
	ro.bluetooth.leaudio_switcher.supported=true \
	bluetooth.profile.bap.unicast.client.enabled=true \
	bluetooth.profile.csip.set_coordinator.enabled=true \
	bluetooth.profile.hap.client.enabled=true \
	bluetooth.profile.mcp.server.enabled=true \
	bluetooth.profile.ccp.server.enabled=true \
	bluetooth.profile.vcp.controller.enabled=true

ifeq ($(RELEASE_PIXEL_BROADCAST_ENABLED), true)
PRODUCT_PRODUCT_PROPERTIES += \
	bluetooth.profile.bap.broadcast.assist.enabled=true \
	bluetooth.profile.bap.broadcast.source.enabled=true
endif

# Bluetooth LE Audio enable hardware offloading
PRODUCT_PRODUCT_PROPERTIES += \
	ro.bluetooth.leaudio_offload.supported=true \
	persist.bluetooth.leaudio_offload.disabled=false \

# Bluetooth LE Auido offload capabilities setting
PRODUCT_COPY_FILES += \
	device/google/caimito/bluetooth/le_audio_codec_capabilities.xml:$(TARGET_COPY_OUT_VENDOR)/etc/le_audio_codec_capabilities.xml

# Keymaster HAL
#LOCAL_KEYMASTER_PRODUCT_PACKAGE ?= android.hardware.keymaster@4.1-service

# Gatekeeper HAL
#LOCAL_GATEKEEPER_PRODUCT_PACKAGE ?= android.hardware.gatekeeper@1.0-service.software


# Gatekeeper
# PRODUCT_PACKAGES += \
# 	android.hardware.gatekeeper@1.0-service.software

# Keymint replaces Keymaster
# PRODUCT_PACKAGES += \
# 	android.hardware.security.keymint-service

# Keymaster
#PRODUCT_PACKAGES += \
#	android.hardware.keymaster@4.0-impl \
#	android.hardware.keymaster@4.0-service

#PRODUCT_PACKAGES += android.hardware.keymaster@4.0-service.remote
#PRODUCT_PACKAGES += android.hardware.keymaster@4.1-service.remote
#LOCAL_KEYMASTER_PRODUCT_PACKAGE := android.hardware.keymaster@4.1-service
#LOCAL_KEYMASTER_PRODUCT_PACKAGE ?= android.hardware.keymaster@4.1-service

# PRODUCT_PROPERTY_OVERRIDES += \
# 	ro.hardware.keystore_desede=true \
# 	ro.hardware.keystore=software \
# 	ro.hardware.gatekeeper=software

# PowerStats HAL
PRODUCT_SOONG_NAMESPACES += \
    device/google/caimito/powerstats/ripcurrentpro

# WiFi Overlay
PRODUCT_PACKAGES += \
    WifiOverlay2024

# Trusty liboemcrypto.so
PRODUCT_SOONG_NAMESPACES += vendor/google_devices/caimito/prebuilts

# Location
PRODUCT_SOONG_NAMESPACES += device/google/caimito/location/ripcurrentpro
$(call soong_config_set, gpssdk, buildtype, $(TARGET_BUILD_VARIANT))
PRODUCT_PACKAGES += gps.cfg
# For GPS property
PRODUCT_VENDOR_PROPERTIES += ro.vendor.gps.pps.enabled=true

PRODUCT_VENDOR_PROPERTIES += \
	persist.device_config.configuration.disable_rescue_party=true

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.udfps.als_feed_forward_supported=true \
    persist.vendor.udfps.lhbm_controlled_in_hal_supported=true

# Vibrator HAL
$(call soong_config_set,haptics,kernel_ver,v$(subst .,_,$(TARGET_LINUX_KERNEL_VERSION)))
ACTUATOR_MODEL := luxshare_ict_081545
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.vibrator.hal.chirp.enabled=1 \
    ro.vendor.vibrator.hal.device.mass=0.222 \
    ro.vendor.vibrator.hal.loc.coeff=2.8

# PKVM Memory Reclaim
PRODUCT_VENDOR_PROPERTIES += \
    hypervisor.memory_reclaim.supported=1

# Thread HAL
PRODUCT_PACKAGES += \
   com.google.caimito.hardware.threadnetwork
