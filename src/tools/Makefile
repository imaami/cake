override THIS_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
include $(THIS_DIR)../../common.mk

override BIN := amalgamator maketest

all: | $(BIN) hoedown

override SRC_amalgamator := amalgamator.c
override SRC_maketest := maketest.c

override SRC := $(foreach b,$(BIN),$(SRC_$b))
override OBJ := $(SRC:%=%.o)
override DEP := $(SRC:%=%.d)

$(foreach b,$(BIN),$(eval $b: $$(SRC_$b:%=%.o); \
	+$$(CC) $$(CPPFLAGS) $$(CFLAGS) -o $$@ $$^ $$(LIB_$$@)))

%.c.o: %.c
	+$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c -MMD $<

clean: | clean-hoedown
clean: override FILES_clean = $(wildcard $(BIN) $(DEP) $(OBJ))
clean:; $(if $(FILES_clean),$(RM) $(FILES_clean),@:)

clean-hoedown:
	@+$(MAKE) -C $(THIS_DIR)hoedown clean

hoedown: | hoedown/hoedown; @:

hoedown/hoedown:
	@+$(MAKE) -C $(THIS_DIR)hoedown $(@F)

.PHONY: all clean clean-hoedown hoedown/hoedown

-include $(DEP)
