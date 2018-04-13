CFLAGS=-ggdb -DSTANDALONE

all: config libsimpleconfig.a

config: config.tab.c config.c simpleconfig.c
	gcc ${CFLAGS} -c -o simpleconfig.o simpleconfig.c -I.
	gcc ${CFLAGS} -c -o config.o config.c -I.
	gcc ${CFLAGS} -c -o config.tab.o config.tab.c -I.
	gcc -o config config.tab.o config.o simpleconfig.o

config.tab.c: config.y
	bison -d $^

config.c: config.l config.tab.c
	flex -o$@ $^

clean:
	rm -f *~ config.tab.* *.o config.c config libsimpleconfig.a

