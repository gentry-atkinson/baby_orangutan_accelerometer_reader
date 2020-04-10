MCU=atmega328p
PORT=$(shell pavr2cmd --prog-port)
CFLAGS=-g -Wall -mcall-prologues -mmcu=$(MCU) $(DEVICE_SPECIFIC_CFLAGS) -Os

CC=avr-gcc
TARGET=accel_test

AVRDUDE_DEVICE = m328p
AVRDUDE=avrdude
DEVICE ?= atmega168
OBJECT_FILES=accel_test.o
OBJ2HEX=avr-objcopy
LDFLAGS=-Wl,-gc-sections -lpololu_$(DEVICE) -Wl,-relax

all: accel_test.hex

clean:
	rm -f *.o *.elf *.hex

accel_test.hex: accel_test.obj
	avr-objcopy -R .eeprom -O ihex accel_test.obj accel_test.hex

accel_test.obj: accel_test.o SparkFunLIS3DH.o
		avr-gcc -g -Wall -mcall-prologues -mmcu=atmega328p  -Os accel_test.o -Wl,-gc-sections -lpololu_atmega168 -Wl,-relax -o accel_test.obj

accel_test.o: accel_test.cpp SparkFunLIS3DH.cpp
		avr-gcc -g -Wall -mcall-prologues -mmcu=atmega328p  -Os  -l SparkFunLIS3DH.h -c -o accel_test.o accel_test.cpp

SparkFunLIS3DH.o: SparkFunLIS3DH.cpp
		avr-gcc -g -Wall -mcall-prologues -mmcu=atmega328p  -Os  -l SparkFunLIS3DH.h -c -o SparkFunLIS3DH.o SparkFunLIS3DH.cpp
program: $(TARGET).hex
		$(AVRDUDE) -p $(AVRDUDE_DEVICE) -c avrisp2 -P $(PORT) -U flash:w:$(TARGET).hex
