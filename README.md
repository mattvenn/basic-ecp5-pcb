# Aim

* Make an ECP5 FPGA dev board
* Keep it super simple and cheap
* Configured by on-board FLASH or direct with a Raspberry Pi
* 6 PMODs, 2 buttons, 2 LEDs, FLASH for configuration bitstreams.

# What a Lattice ecp5 FPGA needs

Check ECP5 family datasheet for more information.

* A clock input. Has to be provided by an oscillator, it doesn't have a crystal driver. Has to go to a PCLK pad
* 1.1v core supply for the internal logic
* 2.5v auxiliary power supply
* 3.3v IO supply for the IO pins. In this design, all banks of IO have the same supply
* Get configured over SPI interface. This can be done directly by a microcontroller or a computer, or the bitstream can be programmed into some FLASH, and the FPGA will read it at boot. If FLASH isn't provided then the bitstream needs to be programmed at every power up or configuration reset. See sysconfig documentation for more info.
* Decoupling capacitors for each IO bank.

# PCB

![board](hardware/board.jpg)

* [Schematic](hardware/schematic.pdf)
* [OHSPark project]() or [Gerbers](hardware/basic-ecp5-pcb-2020-07-16-fab.zip)
* 4 layer board: signal, gnd, 3.3v signal

# BOM

* FPGA ecp5 45k part, 14mm bga with 256 pins, 0.8mm pitch, $15 LFE5U-45F-6BG256C 
* 3.3v reg TLV73333PDBVT
* 1.1v reg TLV73311PDBVT
* 12MHz oscillator SIT2001BI-S2-33E-12.000000G
* 16MB FLASH IS25LP016D-JBLE (optional??).

# Test

See the [test program](test/top.v). This makes a nice pulsing effect on LED2, and LED1 is the slow PWM clock.
The buttons increase or decrease pulsing speed.

    make prog

Yosys and NextPNR are used to create the bitstream and then it's copied to the Raspberry Pi specified
by PI_ADDR in the [Makefile](test/Makefile). 

[Fomu-Flash](https://github.com/im-tomu/fomu-flash) is used to flash the SPI memory, or program the FPGA directly.

# Reference

* http://www.latticesemi.com/ecp5
* In particular, the ECP5 and ECP5-5G Hardware Checklist is very useful

# Inspiration

* https://github.com/Spritetm/hadbadge2019_pcb
* https://github.com/gregdavill/OrangeCrab
* https://www.crowdsupply.com/radiona/ulx3s
