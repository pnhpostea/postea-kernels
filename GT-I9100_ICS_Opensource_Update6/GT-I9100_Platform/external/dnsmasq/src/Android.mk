LOCAL_PATH := $(call my-dir)

#########################

include $(CLEAR_VARS)
LOCAL_SRC_FILES :=  bpf.c cache.c dbus.c dhcp.c dnsmasq.c forward.c helper.c lease.c log.c \
                    netlink.c network.c option.c rfc1035.c rfc2131.c tftp.c util.c

LOCAL_MODULE := dnsmasq

LOCAL_C_INCLUDES := external/dnsmasq/src

LOCAL_CFLAGS := -O2 -g -W -Wall -D__ANDROID__ -DNO_IPV6 -DNO_TFTP -DNO_SCRIPT

ifeq ($(SEC_PROJECT_REGION_OPERATOR), P8-LTE_USA_VZW)
LOCAL_CFLAGS += -DVZW_LTE
endif
#SISO Data Call Changes S
ifneq (,$(filter $(SEC_PROJECT_REGION_OPERATOR), U1_NA_SPR DALI_JPN_KDDI))
LOCAL_CFLAGS += -DNA_HOTSPOT_FRW
endif
#SISO Data Call Changes E

#MAX_AP_STA_NOTI AVIRAL_SEL_NAGSM_11072011 
ifeq ($(SEC_PROJECT_REGION_OPERATOR), U1_USA_ATT) 
LOCAL_CFLAGS += -DNA_HOTSPOT_FRW -DMAX_AP_STA_NOTI
endif
#AVIRAL_SEL_NAGSM_11072011
LOCAL_SYSTEM_SHARED_LIBRARIES := libc libcutils

include $(BUILD_EXECUTABLE)

