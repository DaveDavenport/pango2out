PROGRAM:=pango2out
PREFIX?=/usr/local/
DEPENDENCIES:=glib-2.0 pango
V?=@

all: ${PROGRAM}

-include depends.mk

depends.mk: Makefile
	${info Check for dependencies: ${DEPENDENCIES}}
	$V which pkg-config
	$V pkg-config --exists --print-errors ${DEPENDENCIES}
	$V echo "LDFLAGS+=$(shell pkg-config --silence-errors --libs ${DEPENDENCIES})" > $@
	$V echo "CFLAGS+=$(shell pkg-config --silence-errors --cflags ${DEPENDENCIES})" >> $@


# Build in rule passes ldflags in wrong order.
${PROGRAM}: ${PROGRAM}.c  depends.mk
	$(info Compile: $< --> $@)
	$V $(CC) ${CFLAGS} -o $@ $< ${LDFLAGS}

.PHONY: install
install: $(PROGRAM)
	$(info Install: ${PROGRAM} --> ${DESTDIR}${PREFIX}/bin/)
	$V install -D ${PROGRAM} ${DESTDIR}${PREFIX}/bin/

.PHONY: clean
clean:
	$(info Delete: ${PROGRAM} depends.mk)
	$V rm -f ${PROGRAM} depends.mk
