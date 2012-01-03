CFLAGS=-ggdb -DSTANDALONE

all: config

config:config.y config.l simpleconfig.c
	bison -d config.y
	flex -oconfig.c config.l
	gcc ${CFLAGS} -c -o simpleconfig.o simpleconfig.c -I.
	gcc ${CFLAGS} -c -o config.o config.c -I.
	gcc ${CFLAGS} -c -o config.tab.o config.tab.c -I.
	gcc -o config config.tab.o config.o simpleconfig.o

clean:
	rm -f *~ config.tab.* *.o config.c config

