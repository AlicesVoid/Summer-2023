all:	sender recv

sender:	sender.o
	g++ sender.o -o sender

recv:	recv.o
	g++ recv.o -o recv

sender.o:	 sender.cpp
	g++ -c -g sender.cpp

recv.o:	recv.cpp
	g++ -c -g recv.cpp


clean:
	rm -rf *.o sender recv 
