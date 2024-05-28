-- For Demonstration purposes only
-- Code has not been fully verified or tested 
-- User assumes risk
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity AXI4_SLAVE is
  generic(BUSY_SLAVE_TEST : boolean := FALSE);
	port (
		S_AXI_ACLK	    : in std_logic;
		S_AXI_ARESETN	  : in std_logic;

    S_AXI_AWID      : in std_logic_vector(2 DOWNTO 0);
		S_AXI_AWVALID	  : in std_logic;
		S_AXI_AWREADY	  : out std_logic;
		S_AXI_AWADDR	  : in std_logic_vector(23 downto 0);
    S_AXI_AWLEN     : in std_logic_vector(7 downto 0);
    S_AXI_AWSIZE    : in std_logic_vector(2 downto 0);
    S_AXI_AWBURST   : in std_logic_vector(1 downto 0);
    S_AXI_AWLOCK    : in std_logic_vector(1 downto 0);
    S_AXI_AWCACHE   : in std_logic_vector(3 downto 0);
		S_AXI_AWPROT	  : in std_logic_vector(2 downto 0);
    S_AXI_AWQOS     : in std_logic_vector(3 downto 0);
    S_AXI_AWUSER    : in std_logic_vector(4 downto 0);
 
    S_AXI_WID       : in std_logic_vector(2 downto 0);
		S_AXI_WVALID	  : in std_logic;
		S_AXI_WREADY	  : out std_logic;
		S_AXI_WDATA 	  : in std_logic_vector(31 downto 0);
		S_AXI_WSTRB	    : in std_logic_vector(3 downto 0);
    S_AXI_WLAST     : in std_logic;

    S_AXI_BID       : out std_logic_vector(2 downto 0);
		S_AXI_BVALID	  : out std_logic;
		S_AXI_BREADY	  : in std_logic;
		S_AXI_BRESP 	  : out std_logic_vector(1 downto 0);

    S_AXI_ARID      : in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	  : in std_logic;
		S_AXI_ARREADY	  : out std_logic;
		S_AXI_ARADDR	  : in std_logic_vector(23 downto 0);
    S_AXI_ARLEN     : in std_logic_vector(7 downto 0);
    S_AXI_ARSIZE    : in std_logic_vector(2 downto 0);
    S_AXI_ARBURST   : in std_logic_vector(1 downto 0);
    S_AXI_ARLOCK    : in std_logic_vector(1 downto 0);
    S_AXI_ARCACHE   : in std_logic_vector(3 downto 0);
    S_AXI_ARPROT    : in std_logic_vector(2 downto 0);
    S_AXI_ARQOS     : in std_logic_vector(3 downto 0);
    S_AXI_ARUSER    : in std_logic_vector(4 downto 0);

    S_AXI_RID       : out std_logic_vector(2 downto 0);
		S_AXI_RVALID	  : out std_logic;
		S_AXI_RREADY	  : in std_logic;
		S_AXI_RDATA 	  : out std_logic_vector(31 downto 0);
    S_AXI_RLAST     : out std_logic;
		S_AXI_RRESP 	  : out std_logic_vector(1 downto 0)
	);
end AXI4_SLAVE;
 
architecture RTL of AXI4_SLAVE is
signal memory_address : integer range 0 to 127;
type data_memory_type is array (0 to 127) of std_logic_vector(31 downto 0);
signal data_memory : data_memory_type :=(others =>(others=>'0'));

signal read_address : std_logic_vector(23 downto 0);
signal write_address : std_logic_vector(23 downto 0);
signal write_data    : std_logic_vector(31 downto 0);
signal write_assert  : std_logic;
signal write_address_inrange : std_logic;
signal read_address_inrange : std_logic;
constant OKAY            : std_logic_vector(1 downto 0) := "00";
constant DECERR          : std_logic_vector(1 downto 0) := "11";
signal timer             : integer range 0 to 15;
constant TIMEOUT         : integer := 15;
signal burst_count       : integer range 0 to 255;
signal lfsr              : std_logic_vector(5 downto 0):= "100100";
signal slave_ready       : std_logic;
signal slave_was_ready   : std_logic;


constant WRITE_BASE_ADDRESS : std_logic_vector(23 downto 0) := X"000000";
constant WRITE_LAST_ADDRESS : std_logic_vector(23 downto 0) := X"000200";
constant READ_BASE_ADDRESS  : std_logic_vector(23 downto 0) := X"000000";
constant READ_LAST_ADDRESS  : std_logic_vector(23 downto 0) := X"000200";

type state_type is (INIT,WRR_READY,WADDR_ACCEPT,WADDR_INRANGE,WADDR_ERROR,
                    WRITE_READY,DATA_WRITE,WMAST_STALL,WSLAVE_STALL,WRITE_LAST,WRITE_ERROR,
                    BRESP_VALID,BRESP_ACCEPT,BRESP_ERROR,
                    RADDR_ACCEPT,RADDR_INRANGE,RADDR_ERROR,
                    RDATA_VALID,RMAST_STALL,RSLAVE_STALL,RDATA_LAST,RDATA_ERROR);
signal state,next_state : state_type;

signal control_register : std_logic_vector(31 downto 0);
signal status_register  : std_logic_vector(31 downto 0);

begin

process(S_AXI_ACLK)
begin
  if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
    if next_state = WRITE_READY or next_state = RADDR_INRANGE then
      lfsr(5 downto 4) <= "11";
    else
      lfsr(0) <= lfsr(5) xor lfsr(4) xor '1';
      lfsr(5 downto 1) <= lfsr(4 downto 0);
    end if;
    slave_was_ready <= slave_ready;
  end if;
end process;
slave_ready <= lfsr(5) when BUSY_SLAVE_TEST else '1';
--slave_ready <= lfsr(5);
process(S_AXI_ACLK)
begin
  if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
     if S_AXI_ARESETN = '0' then
      state <= INIT;
    else
      state <= next_state;
    end if;
  end if;
end process;

write_address_inrange <= '1' when (write_address >= WRITE_BASE_ADDRESS)
                              and (write_address <= WRITE_LAST_ADDRESS) else '0';
read_address_inrange <= '1' when (read_address >= READ_BASE_ADDRESS)
                              and (read_address <= READ_LAST_ADDRESS) else '0';

process(state,S_AXI_AWVALID,S_AXI_WVALID,S_AXI_BREADY,write_address_inrange,S_AXI_ARVALID,
        read_address_inrange,S_AXI_RREADY,burst_count,slave_ready)
begin
  next_state <= state;
  case state is
    when INIT =>
      next_state <= WRR_READY;
    when WRR_READY =>
      if S_AXI_AWVALID = '1' then
        next_state <= WADDR_ACCEPT;
      elsif S_AXI_ARVALID = '1' then
        next_state <= RADDR_ACCEPT;
      end if;
    when WADDR_ACCEPT =>
      if write_address_inrange = '1' then
        next_state <= WADDR_INRANGE;
      else
        next_state <= WADDR_ERROR;
      end if;
    when WADDR_INRANGE =>
      if slave_ready = '1' then
        next_state <= WRITE_READY;
      end if;
    when WADDR_ERROR =>
      next_state <= BRESP_VALID;
    when WRITE_READY =>
      if S_AXI_WVALID = '1' and (burst_count = 0 or S_AXI_WLAST = '1') then
        next_state <= WRITE_LAST;
      elsif S_AXI_WVALID = '1' and slave_ready = '1' then
        next_state <= DATA_WRITE;
      elsif timer = TIMEOUT then
        next_state <= INIT;
      end if;
    when DATA_WRITE =>
      if S_AXI_WVALID = '1' and slave_was_ready = '1' and (burst_count = 0 or S_AXI_WLAST = '1') then
        next_state <= WRITE_LAST;
      elsif S_AXI_WVALID = '0' then
        next_state <= WMAST_STALL;
      elsif S_AXI_WVALID = '1' and slave_ready = '0' then
        next_state <= WSLAVE_STALL;
      end if;
    when WMAST_STALL =>
      if S_AXI_WVALID = '1' and slave_ready = '1' and (burst_count = 0 or S_AXI_WLAST = '1') then
        next_state <= WRITE_LAST;
      elsif S_AXI_WVALID = '1' and slave_ready = '1' then
        next_state <= DATA_WRITE;
      elsif S_AXI_WVALID = '1' and slave_ready = '0' then
        next_state <= WSLAVE_STALL;
      elsif timer = TIMEOUT then
        next_state <= WRITE_ERROR;
      end if;
    when WSLAVE_STALL =>
      if S_AXI_WVALID = '1' and slave_ready = '1' and burst_count = 0  then
        next_state <= WRITE_LAST;
      elsif S_AXI_WVALID = '1' and slave_ready = '1' then
        next_state <= DATA_WRITE;
      elsif S_AXI_WVALID = '0' and slave_ready = '1' then
        next_state <= WMAST_STALL;
      elsif timer = TIMEOUT then
        next_state <= WRITE_ERROR;
      end if;
    when WRITE_LAST =>
      next_state <= BRESP_VALID;
    when WRITE_ERROR =>
      next_state <= BRESP_VALID;
    when BRESP_VALID =>
      if S_AXI_BREADY = '1' then
        next_state <= BRESP_ACCEPT;
      elsif timer = TIMEOUT then
        next_state <= INIT;
      end if;
    when BRESP_ACCEPT =>
      next_state <= INIT;
    when BRESP_ERROR =>
      next_state <= INIT;
    when RADDR_ACCEPT =>
      if read_address_inrange = '1' then
        next_state <= RADDR_INRANGE;
      else
        next_state <= RADDR_ERROR;
      end if;
    when RADDR_INRANGE =>
      if S_AXI_RREADY = '1' and slave_ready = '1' and burst_count = 0 then
        next_state <= RDATA_LAST;
      elsif S_AXI_RREADY = '1' and slave_ready = '1' then
        next_state <= RDATA_VALID;
      elsif S_AXI_RREADY = '0' and slave_ready = '1' then
        next_state <= RMAST_STALL;
      elsif slave_ready = '0' then
        next_state <= RSLAVE_STALL;
      elsif timer = TIMEOUT then
        next_state <= RADDR_ERROR;
      end if;
    when RADDR_ERROR =>
      next_state <= INIT;
    when RDATA_VALID =>
      if S_AXI_RREADY = '1' and slave_ready = '1' and burst_count = 1 then
        next_state <= RDATA_LAST;
      elsif S_AXI_RREADY = '1' and slave_ready = '0' then
        next_state <= RSLAVE_STALL;
       elsif S_AXI_RREADY = '0' then
        next_state <= RMAST_STALL;
     end if;
    when RMAST_STALL =>
      if S_AXI_RREADY = '1' and slave_ready = '1' and burst_count = 1 then
        next_state <= RDATA_LAST;
      elsif S_AXI_RREADY = '1' and slave_ready = '1' then
        next_state <= RDATA_VALID;
      elsif S_AXI_RREADY = '1' and slave_ready = '0' then
        next_state <= RSLAVE_STALL;
      elsif timer = TIMEOUT then
        next_state <= RDATA_ERROR;
      end if;
     when RSLAVE_STALL =>
      if S_AXI_RREADY = '1' and slave_ready = '1' and burst_count = 1 then
        next_state <= RDATA_LAST;
      elsif S_AXI_RREADY = '1' and slave_ready = '1' then
        next_state <= RDATA_VALID;
      elsif S_AXI_RREADY = '0' and slave_ready = '1' then
        next_state <= RMAST_STALL;
      elsif timer = TIMEOUT then
        next_state <= RDATA_ERROR;
      end if;
   when RDATA_LAST =>
     if S_AXI_RREADY = '1' then
       next_state <= INIT;
    end if;
    when RDATA_ERROR =>
      next_state <= INIT;
    when others =>
      next_state <= INIT;
  end case;
end process;

process(S_AXI_ACLK)
begin
if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
  if S_AXI_ARESETN = '0' then
      S_AXI_AWREADY <= '0';
      S_AXI_WREADY  <= '0';
      S_AXI_BID     <= "000";
      S_AXI_BVALID  <= '0';
      S_AXI_BRESP   <= "00";
      S_AXI_ARREADY <= '0';
      S_AXI_RVALID  <= '0';
      S_AXI_RRESP   <= "00";
      S_AXI_RID     <= "000";
      S_AXI_RLAST   <= '0';
  else
  case next_state is
    when INIT =>
      S_AXI_AWREADY <= '0';
      S_AXI_WREADY  <= '0';
      S_AXI_BVALID  <= '0';
      S_AXI_BID     <= "000";
      S_AXI_BRESP   <= "00";
      S_AXI_ARREADY <= '0';
      S_AXI_RID     <= "000";
      S_AXI_RVALID  <= '0';
      S_AXI_RRESP   <= "00";
      S_AXI_RLAST   <= '0';
    when WRR_READY =>
      S_AXI_AWREADY <= '1';
      S_AXI_ARREADY <= '1';
    when WADDR_ACCEPT =>
      S_AXI_AWREADY <= '0';
      S_AXI_ARREADY <= '0';
   when WADDR_INRANGE =>

   when WADDR_ERROR =>

    when WRITE_READY =>
      S_AXI_WREADY  <= '1';
      timer <= timer+1;
    when DATA_WRITE =>
     timer <= 0;
      S_AXI_BRESP   <= OKAY;
      S_AXI_WREADY  <= '1';
    when WMAST_STALL =>

    when WSLAVE_STALL =>
      S_AXI_WREADY  <= '0';
    when WRITE_LAST =>
     S_AXI_WREADY  <= '0';
    when WRITE_ERROR =>
      S_AXI_BRESP   <= DECERR;
      S_AXI_WREADY  <= '0';
    when BRESP_VALID =>
      S_AXI_BVALID  <= '1';
      timer <= timer+1;
   when BRESP_ACCEPT =>
      S_AXI_BVALID  <= '0';
      S_AXI_BRESP   <= OKAY;
      timer <= 0;
    when BRESP_ERROR =>

    when RADDR_ACCEPT =>
      S_AXI_AWREADY <= '0';
      S_AXI_ARREADY <= '0';
    when RADDR_INRANGE =>
     S_AXI_RRESP   <= OKAY;
     timer <= timer+1;
     if burst_count /= 0 then
       S_AXI_RVALID  <= '1';
     else
       S_AXI_RVALID  <= '0';
     end if;
    when RADDR_ERROR =>
     S_AXI_RRESP   <= DECERR;
    when RDATA_VALID =>
      S_AXI_RVALID  <= '1';
      S_AXI_RRESP   <= "00";
      timer <= 0;
    when RMAST_STALL =>
      timer <= timer+1;
    when RSLAVE_STALL =>
      S_AXI_RVALID  <= '0';
      timer <= timer+1;
    when RDATA_LAST =>
      S_AXI_RLAST   <= '1';
      S_AXI_RVALID  <= '1';
    when RDATA_ERROR =>
      S_AXI_RVALID  <= '0';
    when others =>
     null;
    end case;
  end if;
end if;
end process;

process(S_AXI_ACLK)
begin
if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
  if next_state = WADDR_ACCEPT then
    burst_count   <= to_integer(unsigned(S_AXI_AWLEN));
  elsif next_state = RADDR_ACCEPT then
    burst_count   <= to_integer(unsigned(S_AXI_ARLEN));
  elsif next_state = DATA_WRITE then
    burst_count <= burst_count - 1;
  elsif next_state = RDATA_VALID then
    burst_count <= burst_count - 1;
  end if;
end if;
end process;

process(S_AXI_ACLK)
begin
if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
  if next_state = WADDR_ACCEPT then
     write_address <= S_AXI_AWADDR;
  elsif next_state = DATA_WRITE and state /= WRITE_READY then
     write_address   <= std_logic_vector(unsigned(write_address)+4);
  elsif next_state = WRITE_LAST and state /= WRITE_READY then
     write_address   <= std_logic_vector(unsigned(write_address)+4);
  end if;
end if;
end process;

process(S_AXI_ACLK)
begin
if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
  if next_state = DATA_WRITE and state /= WSLAVE_STALL then
    write_data <= S_AXI_WDATA;
  elsif next_state = WSLAVE_STALL and state = DATA_WRITE then
    write_data <= S_AXI_WDATA;
  elsif next_state = WRITE_LAST then
    write_data <= S_AXI_WDATA;
  end if;
end if;
end process;

process(S_AXI_ACLK)
begin
if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
  if next_state = DATA_WRITE or next_state = WRITE_LAST then
    write_assert <= '1';
  else
     write_assert <= '0';
  end if;
end if;
end process;

process(S_AXI_ACLK)
begin
if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
  if next_state = RADDR_ACCEPT then
    read_address   <= S_AXI_ARADDR;
  elsif next_state = RDATA_VALID then
    read_address   <= std_logic_vector(unsigned(read_address)+4);
  elsif next_state = RDATA_LAST and state /= RADDR_INRANGE and state /= RDATA_LAST then
    read_address   <= std_logic_vector(unsigned(read_address)+4);
  end if;
end if;
end process;

process(S_AXI_ACLK)
begin
if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
  if write_assert = '1' then
    case write_address is
      when X"000004" => control_register <= write_data;
      when others    => null;
    end case;
  end if;
end if;
end process;

process(read_address)
begin
    case read_address(23 downto 8) is
      when X"0000" =>
        case read_address(7 downto 0) is
          when X"04" => S_AXI_RDATA <= control_register;
          when others    => S_AXI_RDATA <= (others => '0');
        end case;
      when X"0001" => S_AXI_RDATA <= data_memory(to_integer(unsigned(read_address(7 downto 2))));
      when others => 
      S_AXI_RDATA <= (others => '0');
    end case;
end process;

process(S_AXI_ACLK)
begin
if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
   if write_assert = '1' and write_address(23 downto 8) = X"0001" then
     data_memory(to_integer(unsigned(write_address(7 downto 2)))) <= write_data;
   end if;
end if;
end process;
end RTL;