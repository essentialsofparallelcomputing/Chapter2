All: Listing1 Listing2 Listing3

Listing1: Listing1/build/TimeIt

Listing1/build/TimeIt:
	cd Listing1; mkdir build; cd build; cmake ..; make; make test

Listing2: Listing2/build/TimeIt

Listing2/build/TimeIt:
	cd Listing2; mkdir build; cd build; cmake ..; make; make commit_tests

Listing3: Listing3/build/test

Listing3/build/test:
	cd Listing3; make

clean:
	cd Listing1; rm -rf build
	cd Listing2; rm -rf build
	cd Listing3; rm -rf build
