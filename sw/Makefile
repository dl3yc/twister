#	This file is part of twister.
#
#	twister is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	twister is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with twister.  If not, see <http://www.gnu.org/licenses/>.

GHDL=ghdl
GHDLRUNFLAGS= --stop-time=20ms
GTKW=gtkwave

# Default target
all: twister_tb

# Elaboration target
twister_tb: frequency_divider.o edge_detection.o pulse_extender.o pulse_generator.o twister.o twister_tb.o
	$(GHDL) -e $(GHDLFLAGS) $@

# Run target
run: twister_tb
	$(GHDL) -r twister_tb $(GHDLRUNFLAGS) --wave=twister.ghw
	$(GTKW) twister.ghw twister.sav

# Targets to analyze files
edge_detection.o: src/edge_detection.vhd
	$(GHDL) -a $(GHDLFLAGS) $<
frequency_divider.o: src/frequency_divider.vhd
	$(GHDL) -a $(GHDLFLAGS) $<
pulse_extender.o: src/pulse_extender.vhd
	$(GHDL) -a $(GHDLFLAGS) $<
pulse_generator.o: src/pulse_generator.vhd
	$(GHDL) -a $(GHDLFLAGS) $<
twister.o: src/twister.vhd
	$(GHDL) -a $(GHDLFLAGS) $<
twister_tb.o: src/twister_tb.vhd
	$(GHDL) -a $(GHDLFLAGS) $<

clean:
	$(GHDL) --clean
	rm work-obj93.cf
