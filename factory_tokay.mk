#
# Copyright 2021 The Android Open-Source Project
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

TARGET_LINUX_KERNEL_VERSION := 6.1

$(call inherit-product, device/google/zumapro/factory_common.mk)
$(call inherit-product, device/google/caimito/device-tokay.mk)
include device/google/caimito/audio/tokay/factory-audio-tables.mk

PRODUCT_NAME := factory_tokay
PRODUCT_DEVICE := tokay
PRODUCT_MODEL := Factory build on Tokay
PRODUCT_BRAND := Android
PRODUCT_MANUFACTURER := Google

# default BDADDR for EVB only
PRODUCT_PROPERTY_OVERRIDES += \
	ro.vendor.bluetooth.evb_bdaddr="22:22:22:33:44:55"

# Location
# iGNSS
PRODUCT_PACKAGES += \
	sctd \
	spad \
	swcnd \
	libmptool_json \
	libmptool_log \
	libmptool_utils \
	sctd.json \
	spad.json \
	swcnd.json \
	android.hardware.gnss@2.1-impl
# eGNSS
# Override to factory SDK
SOONG_CONFIG_NAMESPACES += gpssdk
SOONG_CONFIG_gpssdk += sdkv1
SOONG_CONFIG_gpssdk_sdkv1 := true
SOONG_CONFIG_NAMESPACES += gpssdk
SOONG_CONFIG_gpssdk += gpsmcuversion
SOONG_CONFIG_gpssdk_gpsmcuversion := gpsv1_$(TARGET_BUILD_VARIANT)
SOONG_CONFIG_NAMESPACES += gpssdk
SOONG_CONFIG_gpssdk += gpsconf
SOONG_CONFIG_gpssdk_gpsconf := factory

# Factory binaries of camera
PRODUCT_PACKAGES += fatp_km4cm4tk4_wide_hat_tool fatp_km4cm4tk4_ultrawide_hat_tool fatp_tk4_front_hat_tool factory_lwis_client_test

PRODUCT_WITHOUT_TTS_VOICE_PACKS := true
