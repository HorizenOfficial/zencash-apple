
target_name ?= zen

include ../Makefile.build

ZEN_VERSION=v2.0.20

zen_clone:
	if [ ! -d "zen_$(ZEN_VERSION)" ]; then git clone -b $(ZEN_VERSION) https://github.com/ZencashOfficial/zen.git zen_$(ZEN_VERSION); fi

zen_config:
	@true

zen_build:
	( cd zen_$(ZEN_VERSION); \
		CFLAGS="" CXXFLAGS="" LIBTOOLIZE=glibtoolize ./zcutil/build.sh -j ${BSPJOB}; \
	)

zen_install:
	rm -rf tmp
	mkdir -p tmp
	mkdir -p ${BSPINSTALL}/usr/local
	make DESTDIR=${BSPROOT}/zen/tmp -C zen_$(ZEN_VERSION) install
	cp -af ${BSPROOT}/zen/tmp/* ${BSPINSTALL}
	cp -a files/* ${BSPINSTALL}/usr/local/bin

zen_uninstall:
	make -C zen_$(ZEN_VERSION) uninstall

zen_clean:
	if [ -f "zen_$(ZEN_VERSION)/Makefile" ]; then make -C zen_$(ZEN_VERSION) distclean; fi

zen_distclean:
	rm -rf zen_$(ZEN_VERSION)
