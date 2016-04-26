--	pulse extender
--	extends positive pulse by specified clock periods
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

entity pulse_extender is
	generic (
		delay	: positive
	);
	port (
		clk		: in std_logic;

		d		: in std_logic;
		q		: out std_logic
	);
end;

architecture rtl of pulse_extender is
	signal sr	: std_logic_vector(delay-1 downto 0) := (others => '0');
begin
	shiftregister : process(clk, d)
	begin
		if d = '1' then
			sr <= (others => '0');
		elsif rising_edge(clk) then
			sr(delay-1) <= '1';
			sr(delay-2 downto 0) <= sr(delay-1 downto 1);
		end if;
	end process shiftregister;
	q <= sr(0);
end rtl;
