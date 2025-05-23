LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE        := vendor.qti.hardware.AGMIPC@1.0-impl
LOCAL_MODULE_OWNER  := qti
LOCAL_VENDOR_MODULE := true

ifeq ($(SOONG_CONFIG_android_hardware_audio_run_64bit), true)
LOCAL_MULTILIB := 64
endif

LOCAL_CFLAGS        += -v -Wall
LOCAL_SRC_FILES     := src/agm_server_wrapper.cpp

LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/inc

LOCAL_SHARED_LIBRARIES := \
    libhidlbase \
    libutils \
    liblog \
    libcutils \
    libhardware \
    libbase \
    libar-gsl \
    vendor.qti.hardware.AGMIPC@1.0 \
    libagm

LOCAL_HEADER_LIBRARIES := libagmclient_headers

include $(BUILD_SHARED_LIBRARY)

ifeq ($(strip $(AUDIO_FEATURE_ENABLED_AGM_HIDL)),true)
  LOCAL_CFLAGS += -DAGM_HIDL_ENABLED
endif

ifneq ($(strip $(AUDIO_FEATURE_ENABLED_AGM_HIDL)),true)
include $(CLEAR_VARS)

LOCAL_MODULE               := vendor.qti.hardware.AGMIPC@1.0-service
LOCAL_INIT_RC              := vendor.qti.hardware.AGMIPC@1.0-service.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_OWNER         := qti

LOCAL_SRC_FILES            := src/service.cpp

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libcutils \
    libdl \
    libbase \
    libutils \
    libhardware \
    libhidlbase \
    vendor.qti.hardware.AGMIPC@1.0 \
    vendor.qti.hardware.AGMIPC@1.0-impl \
    libagm

LOCAL_HEADER_LIBRARIES := libagm_headers
LOCAL_HEADER_LIBRARIES := libagmclient_headers

include $(BUILD_EXECUTABLE)
endif
