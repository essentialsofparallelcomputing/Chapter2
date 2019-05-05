# Simple makefile to build test executable and run valgrind
CPPFLAGS = -g

test: test.o

memcheck:
	valgrind --leak-check=full ./test 2

clean:
	rm -f test.o test
