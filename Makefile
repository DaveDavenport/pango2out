PROGRAM:=pango2out
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

.PHONY: 
clean:
	rm -f ${PROGRAM}
