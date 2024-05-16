#
# Copyright (C) 2023 The Android Open-Source Project
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


# Thermal Config
ifeq (,$(TARGET_VENDOR_THERMAL_CONFIG_PATH))
TARGET_VENDOR_THERMAL_CONFIG_PATH := device/google/caimito/thermal
endif

PRODUCT_COPY_FILES += \
	$(TARGET_VENDOR_THERMAL_CONFIG_PATH)/thermal_info_config_$(TARGET_DEVICE).json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json \
	$(TARGET_VENDOR_THERMAL_CONFIG_PATH)/thermal_info_config_charge_$(TARGET_DEVICE).json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config_charge.json

ifneq (,$(filter $(TARGET_DEVICE),komodo caiman tokay))
PRODUCT_COPY_FILES += \
	$(TARGET_VENDOR_THERMAL_CONFIG_PATH)/thermal_info_config_$(TARGET_DEVICE)_proto.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config_proto.json \
	$(TARGET_VENDOR_THERMAL_CONFIG_PATH)/vt_estimation_model_$(TARGET_DEVICE).tflite:$(TARGET_COPY_OUT_VENDOR)/etc/vt_estimation_model.tflite \
	$(TARGET_VENDOR_THERMAL_CONFIG_PATH)/vt_prediction_lstm_model_$(TARGET_DEVICE).tflite:$(TARGET_COPY_OUT_VENDOR)/etc/vt_prediction_lstm_model.tflite
        ifneq (,$(filter $(TARGET_BUILD_VARIANT), userdebug eng))
            PRODUCT_COPY_FILES += \
            $(TARGET_VENDOR_THERMAL_CONFIG_PATH)/thermal_info_config_$(TARGET_DEVICE)_wingboard.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config_wingboard.json
        endif
endif

# Power HAL config
ifeq (,$(TARGET_VENDOR_PERF_CONFIG_PATH))
TARGET_VENDOR_PERF_CONFIG_PATH := device/google/caimito/perf
endif

PRODUCT_COPY_FILES += \
	$(TARGET_VENDOR_PERF_CONFIG_PATH)/powerhint-$(TARGET_DEVICE).json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json
PRODUCT_COPY_FILES += \
	$(TARGET_VENDOR_PERF_CONFIG_PATH)/powerhint-zuma.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint-proto.json

# Telephony Satellite Feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.satellite.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.satellite.xml

# Battery Mitigation Config
ifneq (,$(filter $(TARGET_DEVICE),komodo caiman tokay))
ifeq (,$(TARGET_VENDOR_BATTERY_MITIGATION_CONFIG_PATH))
TARGET_VENDOR_BATTERY_MITIGATION_CONFIG_PATH := device/google/caimito/battery_mitigation
endif

PRODUCT_COPY_FILES += \
	$(TARGET_VENDOR_BATTERY_MITIGATION_CONFIG_PATH)/bm_config_$(TARGET_DEVICE).json:$(TARGET_COPY_OUT_VENDOR)/etc/bm_config.json
endif

# sysconfigs from stock OS
PRODUCT_COPY_FILES += \
    device/google/caimito/product-sysconfig-stock.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/product-sysconfig-stock.xml
