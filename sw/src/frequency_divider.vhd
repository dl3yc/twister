--	frequency divider
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
use ieee.numeric_std.all;

entity frequency_divider is
	generic (
		div		: positive
	);
	port (
		clk		: in std_logic;

		q		: out std_logic
	);
end;

architecture rtl of frequency_divider is
	signal cnt	: unsigned(div-1 downto 0) := (others => '0');
begin
	counter : process
	begin
		wait until rising_edge(clk);
		cnt <= cnt + 1;
	end process counter;
	q <= cnt(div-1);
end rtl;
