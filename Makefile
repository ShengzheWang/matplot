YUICOMPRESSOR=/home/abarth/Downloads/yuicompressor-2.4.2/build/yuicompressor-2.4.2.jar

SOURCE=demo/matplot.js

LICENCE_HEADER=admin/license_header
VERSION=0.1.1
TARGET=matplot-$(VERSION).js
TARGET_MIN=matplot-$(VERSION)-min.js


UPLOAD_DIR=gher-diva:/var/www/matplot/
#UPLOAD_DIR=localhost:/var/www/upload/matplot/

all: $(TARGET_MIN) demo


$(TARGET): $(SOURCE)
	cat $(LICENCE_HEADER) $(SOURCE) > $(TARGET)

$(TARGET_MIN): $(TARGET)
	cp $(LICENCE_HEADER) $(TARGET_MIN)
	java -jar $(YUICOMPRESSOR) $(TARGET) >> $(TARGET_MIN)

demo:
	cd demos; python ./demo.py

clean:
	rm -f $(TARGET_MIN) $(TARGET)

tar: $(TARGET_MIN) $(TARGET) doc
	tar --exclude-vcs -cvzf ../EarthGL-$(VERSION).tar.gz .

release: tar demo upload_doc