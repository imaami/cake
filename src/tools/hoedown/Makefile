override THIS_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
include $(THIS_DIR)../../../common.mk

override BIN := hoedown

all: | $(BIN)

override SRC_hoedown := \
  autolink.c            \
  buffer.c              \
  document.c            \
  escape.c              \
  hoedown.c             \
  html.c                \
  html_blocks.c         \
  html_smartypants.c    \
  stack.c               \
  version.c

override SRC := $(foreach b,$(BIN),$(SRC_$b))
override OBJ := $(SRC:%=%.o)
override DEP := $(SRC:%=%.d)

$(foreach b,$(BIN),$(eval $b: $$(SRC_$b:%=%.o); \
	+$$(CC) $$(CPPFLAGS) $$(CFLAGS) -o $$@ $$^ $$(LIB_$$@)))

%.c.o: %.c
	+$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c -MMD $<

clean: override FILES_clean = $(wildcard $(BIN) $(DEP) $(OBJ))
clean:; $(if $(FILES_clean),$(RM) $(FILES_clean),@:)

.PHONY: all clean

-include $(DEP)
