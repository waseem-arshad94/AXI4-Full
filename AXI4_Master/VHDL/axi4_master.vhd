-- For Demonstration purposes only
-- Code has not been fully verified or tested 
-- User assumes risk
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity AXI4_MASTER is
  generic(BUSY_MASTER_TEST : boolean := FALSE);
	port (
		M_AXI_ACLK	    : in std_logic;
		M_AXI_ARESETN	: in std_logic;
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
end AXI4_MASTER;
 
architecture RTL of AXI4_MASTER is

signal timer             : integer range 0 to 15;
constant TIMEOUT         : integer := 15;
signal burst_count       : integer range 0 to 255;
signal data_gen          : std_logic_vector(31 downto 0);
signal lfsr              : std_logic_vector(5 downto 0):= "100000";
signal master_ready      : std_logic;
signal master_was_ready  : std_logic;

type state_type is (INIT,STANDBY,WADDR_VALID,WADDR_ACCEPT,WADDR_ERROR,WDATA_VALID,
                    WSLAVE_STALL,WMAST_STALL,WDATA_LAST,WDATA_ERROR,
                    WAIT_RESPONSE,ACCEPT_RESPONSE,RESPONSE_ERROR,
                    RADDR_VALID,RADDR_ACCEPT,RDATA_VALID,RSLAVE_STALL,RMAST_STALL,
                    RDATA_LAST,RDATA_ERROR);
signal state,next_state : state_type;

begin

process(M_AXI_ACLK)
begin
  if M_AXI_ACLK'event and M_AXI_ACLK = '1' then
    if M_AXI_ARESETN = '0' then
      state <= INIT;
    else
      state <= next_state;
    end if;
  end if;
end process;

process(M_AXI_ACLK)
begin
  if M_AXI_ACLK'event and M_AXI_ACLK = '1' then
    lfsr(0) <= lfsr(5) xor lfsr(4) xor '1';
    lfsr(5 downto 1) <= lfsr(4 downto 0);
    master_was_ready <= master_ready;
  end if;
end process;
--master_ready <= lfsr(5) when BUSY_MASTER_TEST else '1';
master_ready <= lfsr(5);


process(state,WRITE,READ,M_AXI_AWREADY,M_AXI_WREADY,timer,M_AXI_BVALID,M_AXI_ARREADY,M_AXI_RVALID,
        M_AXI_RLAST,burst_count,master_ready,master_was_ready)
begin
  next_state <= state;
  case state is
    when INIT =>
      next_state <= STANDBY;
    when STANDBY =>
      if WRITE = '1' then
        next_state <= WADDR_VALID;
      elsif READ = '1' then
        next_state <= RADDR_VALID;
      end if;
    when WADDR_VALID =>
      if M_AXI_AWREADY = '1' and M_AXI_WREADY = '1' and burst_count = 0 then
        next_state <= WDATA_LAST;
      elsif M_AXI_AWREADY = '1' and M_AXI_WREADY = '1' then
        next_state <= WDATA_VALID;
       elsif M_AXI_AWREADY = '1' then
        next_state <= WADDR_ACCEPT;
      elsif timer = TIMEOUT then
        next_state <= WADDR_ERROR;
      end if;
    when WADDR_ACCEPT =>
      if M_AXI_WREADY = '1' and burst_count = 0 then
        next_state <= WDATA_LAST;
      elsif M_AXI_WREADY = '1' then
        next_state <= WDATA_VALID;
      elsif timer = TIMEOUT then
        next_state <= WDATA_ERROR;
      end if;
    when WADDR_ERROR =>
      next_state <= WAIT_RESPONSE;
    when WDATA_VALID =>
      if M_AXI_WREADY = '1' and master_was_ready = '1' and burst_count = 0 then
        next_state <= WDATA_LAST;
      elsif M_AXI_WREADY = '1' and master_ready = '0' then
        next_state <= WMAST_STALL;
      elsif M_AXI_WREADY = '0' then
        next_state <= WSLAVE_STALL;
      end if;
    when WSLAVE_STALL =>
      if M_AXI_WREADY = '1' and master_ready = '1' and burst_count = 0 then
        next_state <= WDATA_LAST;
      elsif M_AXI_WREADY = '1' and master_ready = '1' then
        next_state <= WDATA_VALID;
      elsif M_AXI_WREADY = '1' and master_ready = '0' then
        next_state <= WDATA_VALID;
      elsif M_AXI_WREADY = '1' then
        next_state <= WMAST_STALL;
      elsif timer = TIMEOUT then
        next_state <= WDATA_ERROR;
      end if;
    when WMAST_STALL =>
      if M_AXI_WREADY = '1' and master_was_ready = '1' and burst_count = 0 then
        next_state <= WDATA_LAST;
      elsif M_AXI_WREADY = '1' and master_ready = '1' then
        next_state <= WDATA_VALID;
      elsif M_AXI_WREADY = '0' and master_ready = '1' then
        next_state <= WSLAVE_STALL;
      elsif timer = TIMEOUT then
        next_state <= WDATA_ERROR;
      end if;
    when WDATA_LAST =>
      if M_AXI_BVALID = '1'  then
        next_state <= ACCEPT_RESPONSE;
      else
        next_state <= WAIT_RESPONSE;
      end if;
    when WAIT_RESPONSE =>
      if M_AXI_BVALID = '1' then
        next_state <= ACCEPT_RESPONSE;
      elsif timer = TIMEOUT then
        next_state <= RESPONSE_ERROR;
      end if;
    when ACCEPT_RESPONSE =>
      next_state <= INIT;
    when RESPONSE_ERROR =>
      next_state <= INIT;
    when RADDR_VALID =>
      if M_AXI_ARREADY = '1' then
        next_state <= RADDR_ACCEPT;
      elsif timer = TIMEOUT then
        next_state <= RESPONSE_ERROR;
      end if;
    when RADDR_ACCEPT =>
      if M_AXI_RVALID = '1' and (burst_count = 0 or M_AXI_RLAST = '1') then
        next_state <= RDATA_LAST;
      elsif M_AXI_RVALID = '1' then
        next_state <= RDATA_VALID;
      else
        next_state <= RSLAVE_STALL;
      end if;
    when RDATA_VALID =>
      if M_AXI_RVALID = '1' and master_was_ready = '1' and (burst_count = 0 or M_AXI_RLAST = '1') then
        next_state <= RDATA_LAST;
      elsif M_AXI_RVALID = '1' and master_ready = '0' then
        next_state <= RMAST_STALL;
      elsif M_AXI_RVALID = '0' then
        next_state <= RSLAVE_STALL;
      end if;
    when RSLAVE_STALL =>
      if M_AXI_RVALID = '1' and master_ready = '1' and burst_count = 0 then
        next_state <= RDATA_LAST;
      elsif M_AXI_RVALID = '1' and master_ready = '1' then
        next_state <= RDATA_VALID;
      elsif M_AXI_RVALID = '1' then
        next_state <= RMAST_STALL;
      end if;
    when RMAST_STALL =>
      if M_AXI_RVALID = '1' and master_was_ready = '1' and (burst_count = 0 or M_AXI_RLAST = '1') then
        next_state <= RDATA_LAST;
      elsif M_AXI_RVALID = '1' and master_ready = '1' then
        next_state <= RDATA_VALID;
      elsif master_ready = '1' then
        next_state <= RSLAVE_STALL;
      end if;
    when RDATA_LAST =>
      next_state <= INIT;
    when RDATA_ERROR =>
      next_state <= INIT;
    when others =>
      next_state <= INIT;
  end case;
end process;

process(M_AXI_ACLK)
begin
if M_AXI_ACLK'event and M_AXI_ACLK = '1' then
  if M_AXI_ARESETN = '0' then
      M_AXI_AWVALID <= '0';
      M_AXI_AWID    <= (others => '0');
      M_AXI_AWADDR  <= (others => '0');
      M_AXI_AWPROT  <= (others => '0');
      M_AXI_WVALID  <= '0';
      M_AXI_AWLEN   <= (others => '0');
      M_AXI_AWSIZE  <= (others => '0');
      M_AXI_AWBURST <= (others => '0');
      M_AXI_AWLOCK  <= (others => '0');
      M_AXI_AWCACHE <= (others => '0');
      M_AXI_AWQOS   <= (others => '0');
      M_AXI_AWUSER  <= (others => '0');
      M_AXI_WID     <= (others => '0');
      data_gen      <= (others => '0');
      M_AXI_WSTRB   <= (others => '0');
      M_AXI_WLAST   <= '0';
      M_AXI_BREADY  <= '0';
      M_AXI_ARVALID <= '0';
      M_AXI_ARID    <= (others => '0');
      M_AXI_ARADDR  <= (others => '0');
      M_AXI_ARLEN   <= (others => '0');
      M_AXI_ARSIZE  <= (others => '0');
      M_AXI_ARBURST <= (others => '0');
      M_AXI_ARQOS   <= (others => '0');
      M_AXI_ARPROT  <= (others => '0');
      M_AXI_ARLOCK  <= (others => '0');
      M_AXI_ARCACHE <= (others => '0');
      M_AXI_ARUSER  <= (others => '0');
      M_AXI_RREADY  <= '0';
  else    
  case next_state is
    when INIT =>
      M_AXI_AWVALID <= '0';
      M_AXI_AWADDR  <= (others => '0');
      M_AXI_AWBURST <= "01";
      M_AXI_AWPROT  <= (others => '0');
      M_AXI_WVALID  <= '0';
      data_gen      <= (others => '0');
      M_AXI_WSTRB   <= (others => '0');
      M_AXI_BREADY  <= '0';
      M_AXI_ARVALID <= '0';
      M_AXI_ARBURST <= "01";
      M_AXI_ARADDR  <= (others => '0');
      M_AXI_ARPROT  <= (others => '0');
      M_AXI_RREADY  <= '0';
    when STANDBY =>
      timer <= 0;
    when WADDR_VALID =>
      M_AXI_AWVALID <= '1';
      M_AXI_WVALID  <= '1';
      M_AXI_AWADDR  <= WRITE_ADDRESS;
      M_AXI_AWLEN   <= WRITE_BURSTLEN;
      data_gen      <= WRITE_DATA;
      burst_count   <= to_integer(unsigned(WRITE_BURSTLEN));
      if WRITE_BURSTLEN = X"00" then
        M_AXI_WLAST <= '1';
      end if;

    when WADDR_ACCEPT =>
      M_AXI_AWVALID <= '0';
      if M_AXI_WREADY = '1' then
        data_gen      <= std_logic_vector(unsigned(data_gen) + 1);
      end if;
    when WADDR_ERROR =>

    when WDATA_VALID =>
      M_AXI_WVALID  <= '1';
      if burst_count = 1 then
        M_AXI_WLAST <= '1';
      end if;
      data_gen      <= std_logic_vector(unsigned(data_gen) + 1);
      M_AXI_AWVALID <= '0';
      timer <= 0;
      M_AXI_BREADY  <= '0';
      burst_count <= burst_count - 1;
    when WSLAVE_STALL =>
      timer <= timer + 1;
    when WMAST_STALL =>
      timer <= timer + 1;
      M_AXI_WVALID  <= '0';
     when WDATA_LAST =>
      timer <= 0;
      M_AXI_AWVALID <= '0';
      M_AXI_WVALID  <= '0';
      M_AXI_WLAST   <= '0';
      M_AXI_BREADY  <= '1';
     when WDATA_ERROR =>

    when WAIT_RESPONSE =>
      M_AXI_BREADY  <= '1';
    when ACCEPT_RESPONSE =>
      M_AXI_BREADY  <= '0';
    when RESPONSE_ERROR =>

    when RADDR_VALID =>
      M_AXI_ARADDR  <= read_address;
      burst_count   <= to_integer(unsigned(READ_BURSTLEN));
      M_AXI_ARLEN   <= READ_BURSTLEN;
      M_AXI_ARVALID <= '1';
      M_AXI_RREADY  <= '1';
    when RADDR_ACCEPT =>
      M_AXI_ARVALID <= '0';
    when RDATA_VALID =>
      burst_count   <= burst_count - 1;
      M_AXI_RREADY  <= '1';
    when RSLAVE_STALL =>
      M_AXI_RREADY  <= '1';
    when RMAST_STALL =>
      M_AXI_RREADY <= '0';
    when RDATA_LAST =>
      M_AXI_RREADY  <= '0';
    when RDATA_ERROR =>

  when others =>
     null;
    end case;
  end if;
end if;
end process;
      M_AXI_WDATA   <= data_gen;

end RTL;