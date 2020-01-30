#
# makefile - create icons of various sizes
#
# Copyright (C) 2019 Taiji Yamada <taiji@aihara.co.jp>
#
# usage:
#
# $ make clean all backup
# $ make headless_browser=chrome clean all backup
#
SVGS=\
FindYouColor.svg	\

SUFS=\
-20@2x.png	\
-20@3x.png	\
-29.png	\
-29@2x.png	\
-29@3x.png	\
-40@2x.png	\
-40@3x.png	\
-60@2x.png	\
-60@3x.png	\
-Small-20.png	\
-Small-20@2x.png	\
-Small-29.png	\
-Small-29@2x.png	\
-Small-40.png	\
-Small-40@2x.png	\
-76.png	\
-76@2x.png	\
-83.5@2x.png	\
-1024.jpg	\

IMGS=\
$(foreach svg, $(SVGS),$(foreach suf,$(SUFS),$(svg:%.svg=%$(suf))))	\

all:: $(IMGS)

#headless_browser=chrome
headless_browser=firefox

ifeq ($(headless_browser),chrome)

chrome="$(shell find /Applications -maxdepth 2 -name 'Google Chrome.app' -print -quit)/Contents/MacOS/Google Chrome"
chrome_headless_flags=--lang=ja --headless --window-size=1024,1024

%-1024.png: %.svg
	$(chrome) $(chrome_headless_flags) --screenshot="$@" "$<"

endif
ifeq ($(headless_browser),firefox)

firefox="$(shell find /Applications -maxdepth 2 -name Firefox.app -print -quit)/Contents/MacOS/firefox"
firefox_headless_flags=--headless --profile .profile --window-size 1024,1024

%-1024.png: %.svg
	$(firefox) $(firefox_headless_flags) --screenshot "$@" "data:image/svg+xml;base64,$$(base64 -b 0 "$<")"

endif

%-20.png: %-1024.png
	sips -Z 20 "$<" --out "$@"

%-20@2x.png: %-1024.png
	sips -Z 40 "$<" --out "$@"

%-20@3x.png: %-1024.png
	sips -Z 60 "$<" --out "$@"

%-29.png: %-1024.png
	sips -Z 29 "$<" --out "$@"

%-29@2x.png: %-1024.png
	sips -Z 58 "$<" --out "$@"

%-29@3x.png: %-1024.png
	sips -Z 87 "$<" --out "$@"

%-40.png: %-1024.png
	sips -Z 40 "$<" --out "$@"

%-40@2x.png: %-1024.png
	sips -Z 80 "$<" --out "$@"

%-40@3x.png: %-1024.png
	sips -Z 120 "$<" --out "$@"

%-60@2x.png: %-1024.png
	sips -Z 120 "$<" --out "$@"

%-60@3x.png: %-1024.png
	sips -Z 180 "$<" --out "$@"

%-76.png: %-1024.png
	sips -Z 76 "$<" --out "$@"

%-76@2x.png: %-1024.png
	sips -Z 152 "$<" --out "$@"

%-83.5@2x.png: %-1024.png
	sips -Z 167 "$<" --out "$@"

%-1024.jpg: %-1024.png
	sips -s format jpeg "$<" --out "$@"

%-Small-20.png: %-20.png
	cp -p "$<" "$@"

%-Small-20@2x.png: %-20@2x.png
	cp -p "$<" "$@"

%-Small-29.png: %-29.png
	cp -p "$<" "$@"

%-Small-29@2x.png: %-29@2x.png
	cp -p "$<" "$@"

%-Small-40.png: %-40.png
	cp -p "$<" "$@"

%-Small-40@2x.png: %-40@2x.png
	cp -p "$<" "$@"

clean:
	rm -f $(IMGS) *-1024.png
	rm -rf .profile

backup:
	[ -d by_$(headless_browser) ] || mkdir by_$(headless_browser)
	cp -p $(IMGS) by_$(headless_browser)/
