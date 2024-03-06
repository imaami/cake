ifneq ($(strip $(CAKE_COMMON_MK_INCLUDED)),1)
override export CAKE_COMMON_MK_INCLUDED := 1

override export ARCHFLAGS := -march=native -mtune=native
override export WARNFLAGS := -Wall -Wextra -Wno-multichar
override export BASEFLAGS := $(WARNFLAGS) -pipe -flto=auto $(ARCHFLAGS)

ifeq (1,$(strip $(DEBUG)))
override export BASEFLAGS += -O0 -ggdb3
else
override export BASEFLAGS += -O2
endif

export CC       := gcc
export CFLAGS   := $(BASEFLAGS) -std=gnu17
export CPPFLAGS := -DNDEBUG=1
endif
