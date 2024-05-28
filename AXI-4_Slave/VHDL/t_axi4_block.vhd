library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity T_AXI4_BLOCK is
  generic(BUSY_SLAVE_TEST  : boolean := FALSE;
          BUSY_MASTER_TEST : boolean := FALSE);

end T_AXI4_BLOCK;
architecture TEST of T_AXI4_BLOCK is
component axi4_bd_wrapper
 	port (
	M_AXI_ACLK_0	    : in std_logic;
	M_AXI_ARESETN_0	: in std_logic;

    WRITE_0               :   in  std_logic;
    WRITE_ADDRESS_0       :   in  std_logic_vector(23 downto 0);
    WRITE_BURSTLEN_0      :   in  std_logic_vector(7 downto 0);
    WRITE_DATA_0         :   in  std_logic_vector(31 downto 0);
    READ_0                :   in  std_logic;
    READ_ADDRESS_0        :   in  std_logic_vector(23 downto 0);
    READ_BURSTLEN_0       :   in  std_logic_vector(7 downto 0);
    READ_DATA_0          :   out std_logic_vector(31 downto 0)
	);
end component;
 
signal  S_AXI_ACLK	    : std_logic := '0';
signal  S_AXI_ARESETN	: std_logic;

signal  WRITE           : std_logic;
signal  WRITE_ADDRESS   : std_logic_vector(23 downto 0);
signal  WRITE_BURSTLEN  : std_logic_vector(7 downto 0);
signal  WRITE_DATA      : std_logic_vector(31 downto 0);
signal  READ            : std_logic;
signal  READ_ADDRESS    : std_logic_vector(23 downto 0);
signal  READ_BURSTLEN   : std_logic_vector(7 downto 0);
signal  READ_DATA       : std_logic_vector(31 downto 0);

signal read_value_check : std_logic_vector(31 downto 0);
signal write_value_check: std_logic_vector(31 downto 0);

begin

UUT: axi4_bd_wrapper 
port map (  
  M_AXI_ACLK_0	=> S_AXI_ACLK,
  M_AXI_ARESETN_0	=> S_AXI_ARESETN,
  WRITE_0         => WRITE,
  WRITE_ADDRESS_0 => WRITE_ADDRESS,
  WRITE_BURSTLEN_0 => WRITE_BURSTLEN,
  WRITE_DATA_0    => WRITE_DATA,
  READ_0          => READ,
  READ_ADDRESS_0  => READ_ADDRESS,
  READ_BURSTLEN_0 => READ_BURSTLEN,
  READ_DATA_0     => READ_DATA);

S_AXI_ACLK    <= not S_AXI_ACLK after 20 ns;
S_AXI_ARESETN <= '0', '1' after 80 ns;

process
begin
for i in 1 to 10 loop 
    wait until S_AXI_ACLK'event and S_AXI_ACLK='1'; 
  end loop;
  WRITE	<= '1';
  WRITE_ADDRESS	<= X"000004";
  WRITE_BURSTLEN <= X"00";
  WRITE_DATA 	<= X"55555555";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1';
  WRITE <= '0';
  for i in 1 to 20 loop wait until S_AXI_ACLK'event and S_AXI_ACLK='1'; end loop;
  READ	<= '1';
  READ_ADDRESS	<= X"000004";
  READ_BURSTLEN <= X"00";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1';
  READ <= '0';
  for i in 1 to 20 loop wait until S_AXI_ACLK'event and S_AXI_ACLK='1'; end loop;
  WRITE	<= '1';
  WRITE_ADDRESS	<= X"000100";
  WRITE_DATA 	<= X"00000000";
  WRITE_BURSTLEN <= X"0F";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1';
  WRITE <= '0';
  for i in 1 to 50 loop wait until S_AXI_ACLK'event and S_AXI_ACLK='1'; end loop;
  READ	<= '1';
  READ_ADDRESS	<= X"000100";
  READ_BURSTLEN <= X"0F";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1';
  READ <= '0';
  for i in 1 to 100 loop wait until S_AXI_ACLK'event and S_AXI_ACLK='1'; end loop;
  WRITE	<= '1';
  WRITE_ADDRESS	<= X"000140";
  WRITE_DATA 	<= X"00010000";
  WRITE_BURSTLEN <= X"1F";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1';
  WRITE <= '0';
  for i in 1 to 100 loop wait until S_AXI_ACLK'event and S_AXI_ACLK='1'; end loop;
  READ	<= '1';
  READ_ADDRESS	<= X"000140";
  READ_BURSTLEN <= X"1F";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1';
  READ <= '0';
  for i in 1 to 100 loop wait until S_AXI_ACLK'event and S_AXI_ACLK='1'; end loop;
  WRITE	<= '1';
  WRITE_ADDRESS	<= X"000120";
  WRITE_DATA 	<= X"00010020";
  WRITE_BURSTLEN <= X"2F";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1';
  WRITE <= '0';
  for i in 1 to 150 loop wait until S_AXI_ACLK'event and S_AXI_ACLK='1'; end loop;
  READ	<= '1';
  READ_ADDRESS	<= X"000120";
  READ_BURSTLEN <= X"2F";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1';
  READ <= '0';
  wait;
end process;

end TEST;