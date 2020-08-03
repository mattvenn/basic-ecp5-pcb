PROJ=blinky
CONSTR=mv_ecp.lpf
TRELLIS=/usr/share/trellis
DEVICE=12k
PI_ADDR = pi@raspberrypi.local
FOMU_FLASH = ~/fomu-flash/fomu-flash

all: $(PROJ).svf prog-flash

%.json: %.v
	yosys -l yosys.log -p "synth_ecp5 -json $@" $<

%_out.config: %.json
	/usr/local/bin/nextpnr-ecp5 -l nextpnr.log --json $< --lpf $(CONSTR) --textcfg $@ --$(DEVICE) --package CABGA256 --speed 8

%.bit: %_out.config
	/usr/bin/ecppack --svf-rowsize 100000 --svf $(PROJ).svf --input $< --bit $@

$(PROJ).svf: $(PROJ).bit

prog: $(PROJ).svf
	openocd -f ../openocd.cfg -c "init; svf  $<; exit"

clean:
	rm -f $(PROJ).json $(PROJ).svf $(PROJ).bit $(PROJ)_out.config

prog-flash: $(PROJ).bit
	scp $< $(PI_ADDR):/tmp/$(PROJECT).bin
	ssh $(PI_ADDR) "sudo $(FOMU_FLASH) -w /tmp/$(PROJECT).bin; sudo $(FOMU_FLASH) -r"

.PHONY: prog clean
.PRECIOUS: ${PROJ}.json ${PROJ}_out.config
