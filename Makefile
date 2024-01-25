all:
	cobc -free -x -Wall -Icopybooks src/sha256_engine.cbl -o sha256_engine
	cobc -free -x -Wall -Icopybooks tests/sha256_test.cbl src/sha256_sub.cbl src/sha256_helper.c -o sha256_test
test:
	./sha256_test
clean:
	rm -f sha256_engine sha256_test *.exe *.o
