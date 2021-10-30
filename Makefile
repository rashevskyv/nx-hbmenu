export APP_VERSION	:=	3.5.0

ifeq ($(RELEASE),)
	export APP_VERSION	:=	$(APP_VERSION)
endif

.PHONY: clean all nx pc dist-bin

all: nx

romfs:
	@mkdir -p romfs

romfs/assets.zip	:	romfs assets
	@rm -f romfs/assets.zip
	@zip -rj romfs/assets.zip assets

dist-bin:	romfs/assets.zip
	$(MAKE) -f Makefile.nx dist-bin

nx:	romfs/assets.zip
	$(MAKE) -f Makefile.nx
	@cp $(CURDIR)/nx-hbmenu.nro /mnt/e/Switch/_kefir/kefir/hbmenu.nro

pc:	romfs/assets.zip
	$(MAKE) -f Makefile.pc

clean:
	@rm -Rf romfs
	$(MAKE) -f Makefile.pc clean
	$(MAKE) -f Makefile.nx clean
