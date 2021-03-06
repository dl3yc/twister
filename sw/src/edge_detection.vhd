--	edge detection
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

entity edge_detection is
	port (
		clk		: in std_logic;

		d		: in std_logic;
		q		: out std_logic
	);
end;

architecture rtl of edge_detection is
	signal d_d	: std_logic := '0';
begin
	edge_detection: process
	begin
		wait until rising_edge(clk);
		d_d <= d;
	end process edge_detection;

	q <= '1' when (d_d = '0') and (d = '1') else '0';
end rtl;
