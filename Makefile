All: Listing1 Listing2 Listing3 Gcov

.PHONY: Listing1 Listing2 Listing3 Gcov

Listing1:
	cd Listing1 && mkdir build && cd build && cmake .. && make && make test

Listing2:
	cd Listing2 && mkdir build && cd build && cmake .. && make && make commit_tests

Listing3:
	cd Listing3 && make && make memcheck

Gcov:
	cd Gcov && mkdir build && cd build && cmake .. && make && \
	   ./stream_triad && gcov CMakeFiles/stream_triad.dir/stream_triad.c.c

clean:
	cd Listing1 && rm -rf build
	cd Listing2 && rm -rf build
	cd Listing3 && make clean
	cd Gcov && rm -rf build
