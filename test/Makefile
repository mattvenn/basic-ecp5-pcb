PROJ=blinky
CONSTR=mv_ecp.lpf
DEVICE=45k
PI_ADDR = pi@fpga.local
FOMU_FLASH = ~/fomu-flash/fomu-flash

all: prog

%.json: %.v
	yosys -l yosys.log -p "synth_ecp5 -json $@" $<

%_out.config: %.json
	nextpnr-ecp5 -l nextpnr.log --json $< --lpf $(CONSTR) --textcfg $@ --$(DEVICE) --package CABGA256 --speed 6

%.bit: %_out.config
	ecppack --compress --svf-rowsize 100000 --svf $(PROJ).svf --input $< --bit $@

clean:
	rm -f $(PROJ).json $(PROJ).svf $(PROJ).bit $(PROJ)_out.config

prog: $(PROJ).bit
	scp $< $(PI_ADDR):/tmp/$(PROJ).bin
	ssh $(PI_ADDR) "sudo $(FOMU_FLASH) -w /tmp/$(PROJ).bin; sudo $(FOMU_FLASH) -r"

.PHONY: prog clean
.PRECIOUS: ${PROJ}.json ${PROJ}_out.config
