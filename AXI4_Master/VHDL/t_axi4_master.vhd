-- For Demonstration purposes only
-- Code has not been fully verified or tested 
-- User assumes risk
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity T_AXI4_MASTER is
  generic(BUSY_SLAVE_TEST  : boolean := FALSE;
          BUSY_MASTER_TEST : boolean := FALSE);

end T_AXI4_MASTER;
architecture TEST of T_AXI4_MASTER is
component AXI4_SLAVE
  generic(BUSY_SLAVE_TEST : boolean := FALSE);
	port (
	S_AXI_ACLK	    : in std_logic;
	S_AXI_ARESETN	: in std_logic;

    S_AXI_AWID      : in std_logic_vector(2 DOWNTO 0);
	S_AXI_AWVALID	: in std_logic;
	S_AXI_AWREADY	: out std_logic;
	S_AXI_AWADDR	: in std_logic_vector(23 downto 0);
    S_AXI_AWLEN     : in std_logic_vector(7 downto 0);
    S_AXI_AWSIZE    : in std_logic_vector(2 downto 0);
    S_AXI_AWBURST   : in std_logic_vector(1 downto 0);
    S_AXI_AWLOCK    : in std_logic_vector(1 downto 0);
    S_AXI_AWCACHE   : in std_logic_vector(3 downto 0);
	S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
    S_AXI_AWQOS     : in std_logic_vector(3 downto 0);
    S_AXI_AWUSER    : in std_logic_vector(4 downto 0);
 
    S_AXI_WID       : in std_logic_vector(2 downto 0);
	S_AXI_WVALID	: in std_logic;
	S_AXI_WREADY	: out std_logic;
	S_AXI_WDATA 	: in std_logic_vector(31 downto 0);
	S_AXI_WSTRB  	: in std_logic_vector(3 downto 0);
    S_AXI_WLAST     : in std_logic;

    S_AXI_BID       : out std_logic_vector(2 downto 0);
	S_AXI_BVALID	: out std_logic;
	S_AXI_BREADY	: in std_logic;
	S_AXI_BRESP 	: out std_logic_vector(1 downto 0);

    S_AXI_ARID      : in std_logic_vector(2 downto 0);
	S_AXI_ARVALID	: in std_logic;
	S_AXI_ARREADY	: out std_logic;
	S_AXI_ARADDR	: in std_logic_vector(23 downto 0);
    S_AXI_ARLEN     : in std_logic_vector(7 downto 0);
    S_AXI_ARSIZE    : in std_logic_vector(2 downto 0);
    S_AXI_ARBURST   : in std_logic_vector(1 downto 0);
    S_AXI_ARLOCK    : in std_logic_vector(1 downto 0);
    S_AXI_ARCACHE   : in std_logic_vector(3 downto 0);
    S_AXI_ARPROT    : in std_logic_vector(2 downto 0);
    S_AXI_ARQOS     : in std_logic_vector(3 downto 0);
    S_AXI_ARUSER    : in std_logic_vector(4 downto 0);

    S_AXI_RID       : out std_logic_vector(2 downto 0);
	S_AXI_RVALID	: out std_logic;
	S_AXI_RREADY	: in std_logic;
	S_AXI_RDATA 	: out std_logic_vector(31 downto 0);
    S_AXI_RLAST     : out std_logic;
	S_AXI_RRESP 	: out std_logic_vector(1 downto 0)
	);
end component;

component AXI4_MASTER
    generic(BUSY_MASTER_TEST : boolean := FALSE);
	port (
	M_AXI_ACLK	        : in std_logic;
	M_AXI_ARESETN	    : in std_logic;
    M_AXI_AWID          :   out std_logic_vector(2 DOWNTO 0);
    M_AXI_AWADDR        :   out std_logic_vector(23 downto 0);
    M_AXI_AWSIZE        :   out std_logic_vector(2 downto 0);
    M_AXI_AWBURST       :   out std_logic_vector(1 downto 0);
    M_AXI_AWLEN         :   out std_logic_vector(7 downto 0);
    M_AXI_AWLOCK        :   out std_logic_vector(1 downto 0);
    M_AXI_AWCACHE       :   out std_logic_vector(3 downto 0);
    M_AXI_AWPROT        :   out std_logic_vector(2 downto 0);
    M_AXI_AWQOS         :   out std_logic_vector(3 downto 0);
    M_AXI_AWUSER        :   out std_logic_vector(4 downto 0);
    M_AXI_AWVALID       :   out std_logic;
    M_AXI_AWREADY       :   in  std_logic;
    -- Write data channel signals
    M_AXI_WID           :   out std_logic_vector(2 downto 0);
    M_AXI_WDATA         :   out std_logic_vector(31 downto 0);
    M_AXI_WSTRB         :   out std_logic_vector(3 downto 0);
    M_AXI_WLAST         :   out std_logic;
    M_AXI_WVALID        :   out std_logic;
    M_AXI_WREADY        :   in  std_logic;
        --  Write response channel signals
    M_AXI_BID           :   in  std_logic_vector(2 downto 0);
    M_AXI_BRESP         :   in  std_logic_vector(1 downto 0);
    M_AXI_BVALID        :   in  std_logic;
    M_AXI_BREADY        :   out std_logic;
        --  Read address channel signals
    M_AXI_ARID          :   out std_logic_vector(2 downto 0);
    M_AXI_ARADDR        :   out std_logic_vector(23 downto 0);
    M_AXI_ARLEN         :   out std_logic_vector(7 downto 0);
    M_AXI_ARSIZE        :   out std_logic_vector(2 downto 0);
    M_AXI_ARBURST       :   out std_logic_vector(1 downto 0);
    M_AXI_ARLOCK        :   out std_logic_vector(1 downto 0);
    M_AXI_ARCACHE       :   out std_logic_vector(3 downto 0);
    M_AXI_ARPROT        :   out std_logic_vector(2 downto 0);
    M_AXI_ARQOS         :   out std_logic_vector(3 downto 0);
    M_AXI_ARUSER        :   out std_logic_vector(4 downto 0);
    M_AXI_ARVALID       :   out std_logic;
    M_AXI_ARREADY       :   in  std_logic;
        -- Read data channel signals
    M_AXI_RID           :   in  std_logic_vector(2 downto 0);
    M_AXI_RDATA         :   in  std_logic_vector(31 downto 0);
    M_AXI_RRESP         :   in  std_logic_vector(1 downto 0);
    M_AXI_RLAST         :   in  std_logic;
    M_AXI_RVALID        :   in  std_logic;
    M_AXI_RREADY        :   out std_logic;
    WRITE               :   in  std_logic;
    WRITE_ADDRESS       :   in  std_logic_vector(23 downto 0);
    WRITE_BURSTLEN      :   in  std_logic_vector(7 downto 0);
    WRITE_DATA          :   in  std_logic_vector(31 downto 0);
    READ                :   in  std_logic;
    READ_ADDRESS        :   in  std_logic_vector(23 downto 0);
    READ_BURSTLEN       :   in  std_logic_vector(7 downto 0);
    READ_DATA           :   out std_logic_vector(31 downto 0)
	);
end component;
 
signal  S_AXI_ACLK	    : std_logic := '0';
signal  S_AXI_ARESETN	: std_logic;
signal  S_AXI_AWID      : std_logic_vector(2 DOWNTO 0);
signal  S_AXI_AWVALID	: std_logic;
signal  S_AXI_AWREADY	: std_logic;
signal  S_AXI_AWADDR	: std_logic_vector(23 downto 0);
signal  S_AXI_AWLEN     : std_logic_vector(7 downto 0);
signal  S_AXI_AWSIZE    : std_logic_vector(2 downto 0);
signal  S_AXI_AWBURST   : std_logic_vector(1 downto 0);
signal  S_AXI_AWLOCK    : std_logic_vector(1 downto 0);
signal  S_AXI_AWCACHE   : std_logic_vector(3 downto 0);
signal  S_AXI_AWPROT	: std_logic_vector(2 downto 0);
signal  S_AXI_AWQOS     : std_logic_vector(3 downto 0);
signal  S_AXI_AWUSER    : std_logic_vector(4 downto 0);
 
signal  S_AXI_WID       : std_logic_vector(2 downto 0);
signal  S_AXI_WVALID	: std_logic;
signal  S_AXI_WREADY	: std_logic;
signal  S_AXI_WDATA 	: std_logic_vector(31 downto 0);
signal  S_AXI_WSTRB 	: std_logic_vector(3 downto 0);
signal  S_AXI_WLAST     : std_logic;

signal  S_AXI_BID       : std_logic_vector(2 downto 0);
signal  S_AXI_BVALID	: std_logic;
signal  S_AXI_BREADY	: std_logic;
signal  S_AXI_BRESP 	: std_logic_vector(1 downto 0);

signal  S_AXI_ARID      : std_logic_vector(2 downto 0);
signal  S_AXI_ARVALID	: std_logic;
signal  S_AXI_ARREADY	: std_logic;
signal  S_AXI_ARADDR	: std_logic_vector(23 downto 0);
signal  S_AXI_ARLEN     : std_logic_vector(7 downto 0);
signal  S_AXI_ARSIZE    : std_logic_vector(2 downto 0);
signal  S_AXI_ARBURST   : std_logic_vector(1 downto 0);
signal  S_AXI_ARLOCK    : std_logic_vector(1 downto 0);
signal  S_AXI_ARCACHE   : std_logic_vector(3 downto 0);
signal  S_AXI_ARPROT    : std_logic_vector(2 downto 0);
signal  S_AXI_ARQOS     : std_logic_vector(3 downto 0);
signal  S_AXI_ARUSER    : std_logic_vector(4 downto 0);

signal  S_AXI_RID       : std_logic_vector(2 downto 0);
signal  S_AXI_RVALID	: std_logic;
signal  S_AXI_RREADY	: std_logic;
signal  S_AXI_RDATA 	: std_logic_vector(31 downto 0);
signal  S_AXI_RLAST     : std_logic;
signal  S_AXI_RRESP 	: std_logic_vector(1 downto 0);

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

SLAVE: AXI4_SLAVE 
generic map (BUSY_SLAVE_TEST => BUSY_SLAVE_TEST)
port map (  
  S_AXI_ACLK	=> S_AXI_ACLK,
  S_AXI_ARESETN	=> S_AXI_ARESETN,
  S_AXI_AWID  	=> S_AXI_AWID,
  S_AXI_AWVALID	=> S_AXI_AWVALID,
  S_AXI_AWREADY	=> S_AXI_AWREADY,
  S_AXI_AWADDR	=> S_AXI_AWADDR,
  S_AXI_AWLEN	=> S_AXI_AWLEN,
  S_AXI_AWSIZE  => S_AXI_AWSIZE,
  S_AXI_AWBURST => S_AXI_AWBURST,
  S_AXI_AWLOCK	=> S_AXI_AWLOCK,
  S_AXI_AWCACHE	=> S_AXI_AWCACHE,
  S_AXI_AWPROT	=> S_AXI_AWPROT,
  S_AXI_AWQOS	=> S_AXI_AWQOS,
  S_AXI_AWUSER	=> S_AXI_AWUSER,
  S_AXI_WID	    => S_AXI_WID,
  S_AXI_WVALID	=> S_AXI_WVALID,
  S_AXI_WREADY	=> S_AXI_WREADY,
  S_AXI_WDATA 	=> S_AXI_WDATA,
  S_AXI_WSTRB	=> S_AXI_WSTRB,
  S_AXI_WLAST	=> S_AXI_WLAST,
  S_AXI_BID	    => S_AXI_BID,
  S_AXI_BVALID	=> S_AXI_BVALID,
  S_AXI_BREADY	=> S_AXI_BREADY,
  S_AXI_BRESP 	=> S_AXI_BRESP,
  S_AXI_ARID	=> S_AXI_ARID,
  S_AXI_ARVALID	=> S_AXI_ARVALID,
  S_AXI_ARREADY	=> S_AXI_ARREADY,
  S_AXI_ARADDR	=> S_AXI_ARADDR,
  S_AXI_ARLEN	=> S_AXI_ARLEN,
  S_AXI_ARSIZE	=> S_AXI_ARSIZE,
  S_AXI_ARBURST	=> S_AXI_ARBURST,
  S_AXI_ARLOCK	=> S_AXI_ARLOCK,
  S_AXI_ARCACHE	=> S_AXI_ARCACHE,
  S_AXI_ARPROT	=> S_AXI_ARPROT,
  S_AXI_ARQOS	=> S_AXI_ARQOS,
  S_AXI_ARUSER	=> S_AXI_ARUSER,
  S_AXI_RID	    => S_AXI_RID,
  S_AXI_RVALID	=> S_AXI_RVALID,
  S_AXI_RREADY	=> S_AXI_RREADY,
  S_AXI_RDATA 	=> S_AXI_RDATA,
  S_AXI_RLAST	=> S_AXI_RLAST,
  S_AXI_RRESP 	=> S_AXI_RRESP);

MASTER: AXI4_MASTER 
generic map (BUSY_MASTER_TEST => BUSY_MASTER_TEST)
port map (  
  M_AXI_ACLK	=> S_AXI_ACLK,
  M_AXI_ARESETN	=> S_AXI_ARESETN,
  M_AXI_AWID  	=> S_AXI_AWID,
  M_AXI_AWVALID	=> S_AXI_AWVALID,
  M_AXI_AWREADY	=> S_AXI_AWREADY,
  M_AXI_AWADDR	=> S_AXI_AWADDR,
  M_AXI_AWLEN	=> S_AXI_AWLEN,
  M_AXI_AWSIZE  => S_AXI_AWSIZE,
  M_AXI_AWBURST => S_AXI_AWBURST,
  M_AXI_AWLOCK	=> S_AXI_AWLOCK,
  M_AXI_AWCACHE	=> S_AXI_AWCACHE,
  M_AXI_AWPROT	=> S_AXI_AWPROT,
  M_AXI_AWQOS	=> S_AXI_AWQOS,
  M_AXI_AWUSER	=> S_AXI_AWUSER,
  M_AXI_WID	    => S_AXI_WID,
  M_AXI_WVALID	=> S_AXI_WVALID,
  M_AXI_WREADY	=> S_AXI_WREADY,
  M_AXI_WDATA 	=> S_AXI_WDATA,
  M_AXI_WSTRB	=> S_AXI_WSTRB,
  M_AXI_WLAST	=> S_AXI_WLAST,
  M_AXI_BID	    => S_AXI_BID,
  M_AXI_BVALID	=> S_AXI_BVALID,
  M_AXI_BREADY	=> S_AXI_BREADY,
  M_AXI_BRESP 	=> S_AXI_BRESP,
  M_AXI_ARID	=> S_AXI_ARID,
  M_AXI_ARVALID	=> S_AXI_ARVALID,
  M_AXI_ARREADY	=> S_AXI_ARREADY,
  M_AXI_ARADDR	=> S_AXI_ARADDR,
  M_AXI_ARLEN	=> S_AXI_ARLEN,
  M_AXI_ARSIZE	=> S_AXI_ARSIZE,
  M_AXI_ARBURST	=> S_AXI_ARBURST,
  M_AXI_ARLOCK	=> S_AXI_ARLOCK,
  M_AXI_ARCACHE	=> S_AXI_ARCACHE,
  M_AXI_ARPROT	=> S_AXI_ARPROT,
  M_AXI_ARQOS	=> S_AXI_ARQOS,
  M_AXI_ARUSER	=> S_AXI_ARUSER,
  M_AXI_RID	    => S_AXI_RID,
  M_AXI_RVALID	=> S_AXI_RVALID,
  M_AXI_RREADY	=> S_AXI_RREADY,
  M_AXI_RDATA 	=> S_AXI_RDATA,
  M_AXI_RLAST	=> S_AXI_RLAST,
  M_AXI_RRESP 	=> S_AXI_RRESP,
  WRITE         => WRITE,
  WRITE_ADDRESS => WRITE_ADDRESS,
  WRITE_BURSTLEN => WRITE_BURSTLEN,
  WRITE_DATA    => WRITE_DATA,
  READ          => READ,
  READ_ADDRESS  => READ_ADDRESS,
  READ_BURSTLEN => READ_BURSTLEN,
  READ_DATA     => READ_DATA);

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
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1' and S_AXI_RREADY = '1' and S_AXI_RVALID = '1';
  assert S_AXI_RDATA = X"55555555" report "Read Data Error" severity failure;
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

--Burst Write Checker
process
begin
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1' and WRITE = '1' and WRITE_BURSTLEN > X"00";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1' and S_AXI_WREADY = '1' and S_AXI_WVALID = '1';
  write_value_check <= std_logic_vector(unsigned(S_AXI_WDATA) + 1);
  while S_AXI_WLAST /= '1' loop
    wait until S_AXI_ACLK'event and S_AXI_ACLK='1' and S_AXI_WREADY = '1' and S_AXI_WVALID = '1';
    assert write_value_check = S_AXI_WDATA report "Write Burst Data Error" severity failure;
    write_value_check <= std_logic_vector(unsigned(write_value_check) + 1);
  end loop;
end process;

--Burst Read Checker
process
begin
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1' and READ = '1' and READ_BURSTLEN > X"00";
  wait until S_AXI_ACLK'event and S_AXI_ACLK='1' and S_AXI_RREADY = '1' and S_AXI_RVALID = '1';
  read_value_check <= std_logic_vector(unsigned(S_AXI_RDATA) + 1);
  while S_AXI_RLAST /= '1' loop
    wait until S_AXI_ACLK'event and S_AXI_ACLK='1' and S_AXI_RREADY = '1' and S_AXI_RVALID = '1';
    assert read_value_check = S_AXI_RDATA report "Read Burst Data Error" severity failure;
    read_value_check <= std_logic_vector(unsigned(read_value_check) + 1);
  end loop;
end process;
end TEST;