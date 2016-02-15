PROGRAM:=pango2out
PREFIX?=/usr/local/
CFLAGS:=$(shell pkg-config --cflags pango glib-2.0)
LDFLAGS:=$(shell pkg-config --libs pango glib-2.0)
EMPTY:=

ifeq (${CFLAGS},${EMPTY})
    $(error "Failed to find dependencies: pango, glib-2.0")	
endif

all: ${PROGRAM}

# Build in rule passes ldflags in wrong order.
${PROGRAM}: ${PROGRAM}.c
	$(CC) ${CFLAGS} -o $@ $^ ${LDFLAGS}

.PHONY: install
install: $(PROGRAM)
	install -D ${PROGRAM} ${DESTDIR}${PREFIX}/bin/

.PHONY: clean
clean:
	rm -f ${PROGRAM}
