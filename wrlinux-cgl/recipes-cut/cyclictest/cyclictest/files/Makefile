
TARGET=cyclictest
FLAGS= -Wall -Wno-nonnull -O2
LIBS = -lpthread -lrt

all: cyclictest.c
	$(CC) $(FLAGS) $(LDFLAGS) $^ -o $(TARGET) $(LIBS)

clean:
	rm -f $(TARGET) *.o .depend *.*~

