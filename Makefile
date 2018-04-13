CFLAGS=-ggdb -Werror
STANDALONE_CFLAGS=-DSTANDALONE
OBJS_LIB=config.tab.o simpleconfig.o

all: config libsimpleconfig.a

config: $(OBJS_LIB) config-standalone.o
	gcc -o $@ $^

%-standalone.o: %.c
	gcc ${CFLAGS} ${STANDALONE_CFLAGS} -c -o $@ $^

libsimpleconfig.a: $(OBJS_LIB) config.o
	ar -rc $@ $^

%.o: %.c
	gcc ${CFLAGS} -c -o $@ $^

config.tab.c: config.y
	bison -d $^

config.c: config.l
	flex -o$@ $^

config.l: config.tab.c

clean:
	rm -f *~ config.tab.* *.o config.c config libsimpleconfig.a

