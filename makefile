CC := gcc
LDFLAGS := $(shell pkg-config --libs libnl-genl-3.0)
DEBUG_CFLAGS := -DDEBUG=1 -std=c11 -Wall -Wextra -Wpedantic -g 
CFLAGS := -std=c11 -Wall -Wpedantic -Wno-unused-parameter
ifeq (${DEBUG},1)
	CFLAGS+=${DEBUG_FLAGS}
endif
CFLAGS += $(shell pkg-config --cflags libnl-genl-3.0)

.PHONY:all
all: nl80211_info ap-notify wifi-scan

nl80211_info: nl80211_info.o
	${CC} -o $@ $^ ${LDFLAGS} ${CFLAGS}

ap-notify: ap-notify.o
	${CC} -o $@ $^ ${LDFLAGS} ${CFLAGS}

.PHONY: wifi-scan
wifi-scan:
	$(MAKE) -C wifi-scan/ all

.c.o:
	$(CC) $(CFLAGS) -c $<

clean:
	rm -rf *.o nl80211_info ap-notify
	$(MAKE) -C wifi-scan/ clean
