#
# Copyright 2021 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_SOONG_NAMESPACES += \
	vendor/qcom/fingerprint/qfp-service \
	vendor/qcom/fingerprint/QFPCalibration \

PRODUCT_PACKAGES += \
	qfp-daemon \
	QFPCalibration \

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/caimito/fingerprint/device_framework_matrix_product.xml

PRODUCT_COPY_FILES += \
	device/google/caimito/fingerprint/init.qfp.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qfp.sh

#$(call soong_config_set,fp_hal_feature,biometric_suez_support,true)

PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.qfp.update_vfs_calib=1

ifneq (,$(findstring factory, $(TARGET_PRODUCT)))
PRODUCT_PACKAGES += QfsFactoryTest
endif
