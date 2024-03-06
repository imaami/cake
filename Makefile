override THIS_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

all clean default:
	@+$(MAKE) -C $(THIS_DIR)src $@

.PHONY: all clean default

override .DEFAULT_GOAL := default
