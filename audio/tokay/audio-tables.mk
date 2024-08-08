#
# Copyright (C) 2020 The Android Open-Source Project
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

AUDIO_TABLE_FOLDER := tokay

# Choose AIDL config by build flag.
ifeq ($(USE_AUDIO_HAL_AIDL),true)
PRODUCT_SOONG_NAMESPACES += device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/aidl_config
PRODUCT_PACKAGES += audio_aidl_configs

else
# Platform Configuration for AudioHAL / SoundTriggerHAL
PRODUCT_COPY_FILES += \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/audio_policy_configuration_bluetooth_legacy_hal.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_bluetooth_legacy_hal.xml \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/audio_policy_configuration_le_offload_disabled.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_le_offload_disabled.xml \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/audio_policy_configuration_a2dp_offload_disabled.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_a2dp_offload_disabled.xml \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/audio_platform_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_configuration.xml \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/sound_trigger_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_configuration.xml \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/bluetooth_with_le_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml

# AudioEffectHAL Configuration
PRODUCT_COPY_FILES += \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml

# Mixer Path Configuration for AudioHAL
PRODUCT_COPY_FILES += \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/config/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml
endif

# Speaker firmware files
SPK_FIRMWARE_PATH := $(AUDIO_TABLE_FOLDER)/cs35l41/fw
SPK_FIRMWARE_FULL_PATH := device/google/caimito/audio/$(SPK_FIRMWARE_PATH)

PRODUCT_COPY_FILES += $(call copy-files,$(wildcard  $(SPK_FIRMWARE_FULL_PATH)/*),$(TARGET_COPY_OUT_VENDOR)/firmware)

# Audio tuning
PRODUCT_SOONG_NAMESPACES += device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/tuning
PRODUCT_PACKAGES += \
    recording.gatf \
    smartfeature.gstf \
    BLUETOOTH.dat \
    HANDSFREE.dat \
    HANDSET.dat \
    HEADSET.dat \
    mcps.dat \
    waves_config.ini \
    waves_preset.mps \
    compens_spk_l.conf \
    compens_spk_r.conf \
    default_mic_compensation.bin \
    downlink_bluetooth_headset_config.pb \
    downlink_dock_config.pb \
    downlink_external_speaker_config.pb \
    downlink_handset_config.pb \
    downlink_speaker_config.pb \
    downlink_wired_headset_config.pb \
    uplink_bluetooth_headset_aec_off_config.pb \
    uplink_bluetooth_headset_aec_on_config.pb \
    uplink_dock_aec_off_config.pb \
    uplink_dock_aec_on_config.pb \
    uplink_external_speaker_aec_off_config.pb \
    uplink_external_speaker_aec_on_config.pb \
    uplink_handset_aec_off_config.pb \
    uplink_handset_aec_on_config.pb \
    uplink_speaker_aec_off_config.pb \
    uplink_speaker_aec_on_config.pb \
    uplink_wired_headset_aec_off_config.pb \
    uplink_wired_headset_aec_on_config.pb

# userdebug and eng specific
PRODUCT_PACKAGES_DEBUG += \
    BLUETOOTH.mods \
    HANDSFREE.mods \
    HANDSET.mods \
    HEADSET.mods \
    template.xml \
    tuning_constraints_combination.xml \
    test_config.ini \
    test_preset.mps \
    speaker_post_processing_volume_spec.xml

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
# Mixer Path Configuration for Audio Speaker Calibration Tool crus_sp_cal
PRODUCT_COPY_FILES += \
    device/google/caimito/audio/$(AUDIO_TABLE_FOLDER)/cs35l41/crus_sp_cal_mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/crus_sp_cal_mixer_paths.xml

endif

# Offload spatializer config
PRODUCT_PACKAGES += \
    vendor.google.whitechapel.audio.hal.effect.spatializer.base \
    vendor.google.whitechapel.audio.hal.effect.spatializer.mode_2_ch \
    vendor.google.whitechapel.audio.hal.effect.spatializer.mode_6_ch \
    vendor.google.whitechapel.audio.hal.effect.spatializer.mode_xaural
