--	pulse generator
--	generates pulse with specified duration and length
--	duration specified by power of 2 clock cycles
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

entity pulse_generator is
	generic (
		duration	: positive;
		length		: positive
	);
	port (
		clk		: in std_logic;

		rst		: in std_logic;
		q		: out std_logic
	);
end;

architecture rtl of pulse_generator is
	signal cnt	: unsigned(duration-1 downto 0) := (others => '0');
begin
	counter : process(clk, rst)
	begin
		if rst = '1' then
			cnt <= (others => '0');
			q <= '0';
		elsif rising_edge(clk) then
			cnt <= cnt + 1;
			if cnt > 2**duration-length-1 then
				q <= '1';
			else
				q <= '0';
			end if;
		end if;
	end process counter;
end rtl;
