# Simple makefile to build test executable and run valgrind
CPPFLAGS = -g

test: test.o

memcheck:
	valgrind --leak-check ./test 2

clean:
	rm -f test.o test
