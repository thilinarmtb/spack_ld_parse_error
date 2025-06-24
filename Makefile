.PHONY: all hello

all: hello

hello: hello.c
	$(CC) -c $< -o $@.o
	$(CC) -Wl,-rpath ${PWD}/libs -o $@ $@.o

clean:
	$(RM) hello.o hello
