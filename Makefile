all: openrtm_cpp

VERSION     = 1.1.0
TARBALL     = build/OpenRTM-aist-$(VERSION)-RELEASE.tar.gz
TARBALL_URL = \
http://www.openrtm.org/pub/OpenRTM-aist/cxx/$(VERSION)/OpenRTM-aist-$(VERSION)-RELEASE.tar.bz2
UNPACK_CMD  = tar xfj
SOURCE_DIR  = build/OpenRTM-aist-$(VERSION)
MD5SUM_FILE = OpenRTM-aist-$(VERSION)-RELEASE.tar.bz2.md5sum

INSTALL_DIR = install

CONFIGURE_FLAGS = \
	--prefix=`rospack find openrtm_cpp`/$(INSTALL_DIR)/ \
	CPPFLAGS="-DNDEBUG" 				\
	CFLAGS="-g -O3"					\
	CXXFLAGS="-g -O3"

include $(shell rospack find mk)/download_unpack_build.mk

openrtm_cpp: $(INSTALL_DIR)/installed

$(INSTALL_DIR)/installed: $(SOURCE_DIR)/unpacked
	cd $(SOURCE_DIR)	  		\
	&& ./configure ${CONFIGURE_FLAGS}	\
	&& make			  		\
	&& make install
	touch $(INSTALL_DIR)/installed

clean:
	rm -rf $(SOURCE_DIR) $(INSTALL_DIR)

wipe: clean
	rm -rf build
