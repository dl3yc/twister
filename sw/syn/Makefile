# Project name
PROJECT=twister
# Part number
PART=XC9572XL-5-VQ64
# Output configuration file
# Sources
SOURCES=../src/edge_detection.vhd ../src/frequency_divider.vhd ../src/pulse_extender.vhd ../src/pulse_generator.vhd ../src/twister.vhd
# Constraints file
UCF=$(PROJECT).ucf

# Path to Xilinx tools, blank if in $PATH, must end in /
XILINX=/home/yc/ise/11.1/ISE/bin/lin/
PROGTOOLS=/home/yc/ise/11.1/ProgrammingTools/bin/lin/

WD=work
PB=$(WD)/$(PROJECT)

XSTFLAGS=-opt_mode Speed -opt_level 1 
CPLDFITFLAGS=-slew fast -power std -terminate keeper -unused float -optimize speed -init low

.PHONY: all clean

all: $(PB).tim

$(WD):
	mkdir $(WD)/

$(PB).ngc: $(SOURCES)
	@[ ! -e $(WD) ] && mkdir $(WD) || true
	@echo "Generating $(PB).prj..."
	@rm -f $(PB).prj
	@for i in $(SOURCES); do \
		echo "vhdl $(PROJECT) $$i" >> $(PB).prj; \
	done
	@echo "DEFAULT_SEARCH_ORDER" > $(PB).lso
	@echo "set -tmpdir $(WD) -xsthdpdir $(WD)" > $(PB).xst
	@echo "run -ifn $(PB).prj -ifmt mixed -top $(PROJECT) -ofn $@ -ofmt NGC -p $(PART) $(XSTFLAGS) -lso $(PB).lso" >> $(PB).xst
	$(XILINX)xst -ifn $(PB).xst -ofn $(PB)_xst.log

$(PB).ngd: $(PB).ngc $(UCF)
	cd $(WD) ; $(XILINX)ngdbuild -p $(PART) -uc ../$(UCF) ../$< ../$@

$(PB).vm6: $(PB).ngd
	cd $(WD) ; $(XILINX)cpldfit -p $(PART) ../$<

$(PB).tim: $(PB).vm6
	cd $(WD) ; $(XILINX)taengine -l ../$@ -detail -f $(PROJECT) ../$<

$(PB).jed: $(PB).vm6
	cd $(WD) ; $(XILINX)hprep6 -i ../$<

flash: $(PB).jed
	@echo "Generating $(PB).cmd..."
	@echo "setMode -bscan" > $(PB).cmd
	@echo "setCable -port parport0" >> $(PB).cmd
	@echo "identify" >> $(PB).cmd
	@echo "assignfile -p 1 -file $(PROJECT).jed" >> $(PB).cmd
	@echo "erase -p 1 -o" >> $(PB).cmd
	@echo "program -p 1" >> $(PB).cmd
	@echo "quit" >> $(PB).cmd
	cd $(WD) ; sudo LD_PRELOAD=$(PROGTOOLS)libusb-driver.so $(XILINX)impact -batch $(PROJECT).cmd

%: $(WD)/%
	@sed -e 's/FREQUENCY .* HZ/FREQUENCY 5E5 HZ/' $< >$@
	@echo "Output $@ is ready"

clean:
	rm -rf $(WD)
