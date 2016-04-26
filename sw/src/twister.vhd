--	top level entity
--	implements network interface translation to ronja free space optical link
--
--	This file is part of twister.
--
--	twister is free software: you can redistribute it and/or modify
--	it under the terms of the GNU General Public License as published by
--	the Free Software Foundation, either version 3 of the License, or
--	(at your option) any later version.
--
--	twister is distributed in the hope that it will be useful,
--	but WITHOUT ANY WARRANTY; without even the implied warranty of
--	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--	GNU General Public License for more details.
--
--	You should have received a copy of the GNU General Public License
--	along with twister.  If not, see <http://www.gnu.org/licenses/>.

library ieee;
use ieee.std_logic_1164.all;

entity twister is
	port (
		clk		: in std_logic;

		tp_rx	: in std_logic;
		tp_tx	: out std_logic_vector(1 downto 0);

		coax_rx	: in std_logic;
		coax_tx	: out std_logic;

		led_rx	: out std_logic;
		led_tx	: out std_logic
	);
end;

architecture structure of twister is
	signal tp_edge			: std_logic;
	signal tp_ext0			: std_logic;
	signal tp_ext1			: std_logic;
	signal tp_traffic_n		: std_logic;
	signal osc				: std_logic;
	signal coax_edge		: std_logic;
	signal coax_ext0		: std_logic;
	signal coax_traffic		: std_logic;
	signal coax_traffic_n	: std_logic;
	signal lit_pulse		: std_logic;
begin
	edge0 : entity work.edge_detection
		port map (
			clk		=> clk,
			d		=> tp_rx,
			q		=> tp_edge
		);

	sedge1 : entity work.edge_detection
		port map (
			clk		=> clk,
			d		=> coax_rx,
			q		=> coax_edge
		);

	pulse0 : entity work.pulse_extender
		generic map (
			delay	=> 5
		)
		port map (
			clk		=> clk,
			d		=> tp_edge,
			q		=> tp_ext0
		);

	pulse1 : entity work.pulse_extender
		generic map (
			delay	=> 8
		)
		port map(
			clk		=> clk,
			d		=> tp_ext0,
			q		=> tp_ext1
		);

	pulse2 : entity work.pulse_extender
		generic map (
			delay	=> 2
		)
		port map (
			clk		=> clk,
			d		=> tp_ext1,
			q		=> tp_traffic_n
		);

	osc0 : entity work.frequency_divider
		generic map (
			div		=> 4
		)
		port map (
			clk		=> clk,
			q		=> osc
		);

		coax_tx <= osc when tp_traffic_n = '1' else tp_rx;

	pulse3 : entity work.pulse_extender
		generic map (
			delay	=> 5
		)
		port map (
			clk		=> clk,
			d		=> coax_edge,
			q		=> coax_ext0
		);

	pulse4 : entity work.pulse_extender
		generic map (
			delay	=> 8
		)
		port map (
			clk		=> clk,
			d		=> coax_ext0,
			q		=> coax_traffic
		);

	coax_traffic_n <= not coax_traffic;

	gen0 : entity work.pulse_generator
		generic map (
			duration	=> 18,
			length		=> 2
		)
		port map (
			clk		=> clk,
			rst		=> coax_traffic,
			q		=> lit_pulse
		);

	tp_tx(0) <= '1' when coax_traffic = '0' else coax_rx;
	tp_tx(1) <= not lit_pulse when coax_traffic = '0' else not coax_rx;

	led_rx <= coax_traffic;
	led_tx <= not tp_traffic_n;
end structure;
