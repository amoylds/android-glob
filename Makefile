SHLIB = libglob.so
OBJS = glob.o

PREFIX ?= libs
LIBDIR = $(PREFIX)/lib
INCDIR = $(PREFIX)/include/


.PHONY: all install uninstall clean
all: libglob.so libglob.a

$(OBJS): %.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -I./ -fPIC -c $< -o $@

libglob.so: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -shared -o $(SHLIB)

libglob.a: $(OBJS)
	$(AR) rcs $@ $^
	ranlib $@

install: all
	install -d $(DESTDIR)$(LIBDIR)
	install -m 644 libglob.a $(DESTDIR)$(LIBDIR)
	install -m 755 $(SHLIB) $(DESTDIR)$(LIBDIR)
	install -d $(DESTDIR)$(INCDIR)
	install -m 644 glob.h $(DESTDIR)$(INCDIR)

uninstall:
	-rm -rf $(DESTDIR)$(INCDIR)
	-rm -f $(DESTDIR)$(LIBDIR)/libglob.*

clean:
	-rm -f libglob* $(OBJS)