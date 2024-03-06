override THIS_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
include $(THIS_DIR)../common.mk

override BIN := cake
override AUX := amalgamator maketest hoedown

default: | $(BIN)

all: | $(BIN) $(AUX) lib.c

override COMMON_SRC := \
  token.c              \
  hash.c               \
  hashmap.c            \
  console.c            \
  tokenizer.c          \
  osstream.c           \
  fs.c                 \
  options.c            \
  expressions.c        \
  pre_expressions.c    \
  type.c               \
  object.c             \
  parser.c             \
  visit.c              \
  flow_visit.c         \
  error.c              \
  format_visit.c       \
  tests.c

override SRC_cake := $(COMMON_SRC) main.c

override SRC := $(foreach b,$(BIN),$(SRC_$b))
override OBJ := $(SRC:%=%.o)
override DEP := $(SRC:%=%.d)

$(foreach b,$(BIN),$(eval $b: $$(SRC_$b:%=%.o); \
	+$$(CC) $$(CPPFLAGS) $$(CFLAGS) -o $$@ $$^ $$(LIB_$$@)))

%.c.o: %.c
	+$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c -MMD $<

lib.c: $(COMMON_SRC) | amalgamator
	+$(THIS_DIR)amalgamator.exe -o$@ $^

clean: | clean-tools
clean: override FILES_clean = $(wildcard $(BIN) $(DEP) $(OBJ) build lib.c)
clean:; $(if $(FILES_clean),$(RM) $(FILES_clean),@:)

clean-tools: override FILES_clean-tools = $(wildcard $(AUX:%=$(THIS_DIR)%.exe))
clean-tools:
	$(if $(FILES_$@),$(RM) $(FILES_$@))
	@+$(MAKE) -C $(THIS_DIR)tools clean

$(foreach x,$(AUX),$(eval $x: | $$(THIS_DIR)$x.exe))

$(THIS_DIR)amalgamator.exe $(THIS_DIR)maketest.exe:
	ln -fns $(THIS_DIR)tools/$(@F:.exe=) $@

$(THIS_DIR)hoedown.exe:
	ln -fns $(THIS_DIR)tools/$(@F:.exe=)/$(@F:.exe=) $@

$(AUX):
	@+$(MAKE) -C $(THIS_DIR)tools $@

.PHONY: all $(AUX) clean clean-tools default lib.c

-include $(DEP)
