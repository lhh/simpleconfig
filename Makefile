CFLAGS=-ggdb -DSTANDALONE -Werror
OBJS_LIB=config.tab.o simpleconfig.o

all: config libsimpleconfig.a

config: $(OBJS_LIB) config.o
	gcc -o $@ $^

libsimpleconfig.a: $(OBJS_LIB)
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

