
ifeq ($(BSPROOT),)
    $(error You must first run 'source environment')
endif

subdir-y := tools
subdir-y += zen

zen_depends-y = \
	tools

include Makefile.lib

clone:
	@true

config:
	@true

build:
	@true

install:
	@true

uninstall:
	@true

clean:
	@true

distclean: clean
	@true
