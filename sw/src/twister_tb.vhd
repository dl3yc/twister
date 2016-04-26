--	twister testbench
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

entity twister_tb is
end;

architecture structure of twister_tb is
	signal clk		: std_logic := '0';
	signal coax		: std_logic;
	signal tp_rx	: std_logic := '0';
	signal tp_tx	: std_logic_vector(1 downto 0);
	signal tx		: std_logic;
begin
	clk <= not clk after 31250 ps;

	dut : entity work.twister
		port map (
			clk		=> clk,

			tp_rx	=> tp_rx,
			tp_tx	=> tp_tx,

			coax_rx	=> coax,
			coax_tx	=> coax,

			led_rx	=> open,
			led_tx	=> open
		);

	with tp_tx select tx <=
		'Z' when "00",
		'0' when "01",
		'1' when "10",
		'Z' when "11",
		'0' when others;

	process
	begin
		wait for 1 ms;
		tp_rx <= '1';
		wait for 100 ns;
		tp_rx <= '0';
		wait for 1 ms;
		tp_rx <= '1';
		wait for 90 ns;
		tp_rx <= '0';
		wait for 90 ns;
		tp_rx <= '1';
		wait for 90 ns;
		tp_rx <= '0';
		wait for 90 ns;
		tp_rx <= '1';
		wait for 90 ns;
		tp_rx <= '0';
		wait for 90 ns;
		tp_rx <= '1';
		wait for 90 ns;
		tp_rx <= '0';
		wait for 90 ns;
		tp_rx <= '1';
		wait for 90 ns;
		tp_rx <= '0';
		wait for 90 ns;
		tp_rx <= '1';
		wait for 90 ns;
		tp_rx <= '0';
		wait for 90 ns;
		tp_rx <= '1';
		wait for 90 ns;
		tp_rx <= '0';
		wait for 90 ns;
		tp_rx <= '1';
		wait for 90 ns;
		tp_rx <= '0';
		wait for 90 ns;
		tp_rx <= '1';
		wait for 90 ns;
		tp_rx <= '0';
		wait;
	end process;
end structure;
