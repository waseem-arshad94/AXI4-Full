// For Demonstration purposes only
// Code has not been fully verified or tested 
// User assumes risk
`timescale 1ns / 1ps
module axi4_slave
(
    input  wire        s_axi_aclk,
    input  wire        s_axi_aresetn,

    input  wire [2:0]  s_axi_awid,
    input  wire        s_axi_awvalid,
    output reg         s_axi_awready,
    input  wire [23:0] s_axi_awaddr,
    input  wire [7:0]  s_axi_awlen,
    input  wire [2:0]  s_axi_awsize,
    input  wire [1:0]  s_axi_awburst,
    input  wire [1:0]  s_axi_awlock,
    input  wire [3:0]  s_axi_awcache,
    input  wire [2:0]  s_axi_awprot,
    input  wire [3:0]  s_axi_awqos,
    input  wire [4:0]  s_axi_awuser,
 
    input  wire [2:0]  s_axi_wid,
    input  wire        s_axi_wvalid,
    output reg         s_axi_wready,
    input  wire [31:0] s_axi_wdata,
    input  wire [3:0]  s_axi_wstrb,
    input  wire        s_axi_wlast,

    output reg  [2:0]  s_axi_bid,
    output reg         s_axi_bvalid,
    input  wire        s_axi_bready,
    output reg  [1:0]  s_axi_bresp,

    input  wire [2:0]  s_axi_arid,
    input  wire        s_axi_arvalid,
    output reg         s_axi_arready,
    input  wire [23:0] s_axi_araddr,
    input  wire [7:0]  s_axi_arlen,
    input  wire [2:0]  s_axi_arsize,
    input  wire [1:0]  s_axi_arburst,
    input  wire [1:0]  s_axi_arlock,
    input  wire [3:0]  s_axi_arcache,
    input  wire [2:0]  s_axi_arprot,
    input  wire [3:0]  s_axi_arqos,
    input  wire [4:0]  s_axi_aruser,

    output reg  [2:0]  s_axi_rid,
    output reg         s_axi_rvalid,
    input  wire        s_axi_rready,
    output reg  [31:0] s_axi_rdata,
    output reg         s_axi_rlast,
    output reg  [1:0]  s_axi_rresp
	);
parameter BUSY_SLAVE_TEST = 1;
reg s_axis_aresetn_reg;
reg [6:0] memory_address;
reg [31:0] data_memory [0:127];

reg [23:0] read_address;
reg [23:0] write_address;
reg [31:0] write_data ;
reg        write_assert;
wire       write_address_inrange;
wire       read_address_inrange;
localparam OKAY = 2'b00;
localparam DECERR = 2'b11;
reg [3:0]  timer;
localparam TIMEOUT = 15;
reg [7:0]  burst_count;
reg [5:0]  lfsr = 6'b100100;
wire       slave_ready;
reg        slave_was_ready;

localparam WRITE_BASE_ADDRESS = 24'h000000;
localparam WRITE_LAST_ADDRESS = 24'h000200;
localparam READ_BASE_ADDRESS  = 24'h000000;
localparam READ_LAST_ADDRESS  = 24'h000200;

localparam INIT = 0,WRR_READY = 1,WADDR_ACCEPT = 2,WADDR_INRANGE = 3,WADDR_ERROR = 4,
            WRITE_READY = 5,DATA_WRITE = 6,WMAST_STALL = 7,WSLAVE_STALL = 8,
            WRITE_LAST = 9,WRITE_ERROR = 10,
            BRESP_VALID = 11,BRESP_ACCEPT = 12,BRESP_ERROR = 13,
            RADDR_ACCEPT = 14,RADDR_INRANGE = 15,RADDR_ERROR = 16,
            RDATA_VALID = 17,RMAST_STALL = 18,RSLAVE_STALL = 19,
            RDATA_LAST = 20,RDATA_ERROR = 21;
reg [4:0] state,next_state;

reg [31:0] control_register;
reg [31:0] status_register;

always @(posedge s_axi_aclk)
begin
 s_axis_aresetn_reg <= s_axi_aresetn;
  slave_was_ready <= slave_ready;
  if (s_axi_aresetn == 0)
    lfsr <= 6'b110101;
  else if ((next_state == WRITE_READY) || (next_state == RADDR_INRANGE))
    lfsr[5:4] <= 2'b11;
  else
      lfsr[0] <= lfsr[5] ^ lfsr[4] ^ 1'b1;
      lfsr[5:1] <= lfsr[4:0];
end
assign slave_ready = BUSY_SLAVE_TEST?lfsr[5]:1;

always @(posedge s_axi_aclk)
begin
  s_axis_aresetn_reg <= s_axi_aresetn;
  if (s_axi_aresetn == 0)
    state <= INIT;
  else
    state <= next_state;
end

assign write_address_inrange = ((write_address >= WRITE_BASE_ADDRESS)
                              && (write_address <= WRITE_LAST_ADDRESS)) ?1:0;
assign read_address_inrange = ((read_address >= READ_BASE_ADDRESS)
                              && (read_address <= READ_LAST_ADDRESS)) ? 1:0;

always @(*) begin
  next_state = state;
  case (state)
    INIT:
      next_state = WRR_READY;
    WRR_READY:
      if (s_axi_awvalid == 1)
        next_state = WADDR_ACCEPT;
      else if (s_axi_arvalid == 1)
        next_state = RADDR_ACCEPT;
    WADDR_ACCEPT:
      if (write_address_inrange == 1)
        next_state = WADDR_INRANGE;
      else
        next_state = WADDR_ERROR;
    WADDR_INRANGE:
      if (slave_ready == 1)
        next_state = WRITE_READY;
    WADDR_ERROR:
      next_state = BRESP_VALID;
    WRITE_READY:
      if ((s_axi_wvalid == 1) && ((burst_count == 0) || (s_axi_wlast == 1)))
        next_state = WRITE_LAST;
      else if ((s_axi_wvalid == 1) && (slave_ready == 1))
        next_state = DATA_WRITE;
      else if (timer == TIMEOUT)
        next_state <= INIT;
    DATA_WRITE:
      if ((s_axi_wvalid == 1) && (slave_was_ready == 1) && 
          ((burst_count == 0) || s_axi_wlast == 1))
        next_state = WRITE_LAST;
      else if (s_axi_wvalid == 0)
        next_state = WMAST_STALL;
      else if ((s_axi_wvalid == 1) && (slave_ready == 0))
        next_state = WSLAVE_STALL;
    WMAST_STALL:
      if ((s_axi_wvalid == 1) && (slave_ready == 1) && 
         ((burst_count == 0) || (s_axi_wlast == 1)))
        next_state = WRITE_LAST;
      else if ((s_axi_wvalid == 1) && (slave_ready == 1))
        next_state = DATA_WRITE;
      else if ((s_axi_wvalid == 1) && (slave_ready == 0))
        next_state = WSLAVE_STALL;
      else if (timer == TIMEOUT)
        next_state = WRITE_ERROR;
    WSLAVE_STALL:
      if ((s_axi_wvalid == 1) && (slave_ready == 1) && (burst_count == 0))
        next_state = WRITE_LAST;
      else if ((s_axi_wvalid == 1) && (slave_ready == 1))
        next_state <= DATA_WRITE;
      else if ((s_axi_wvalid == 0) && (slave_ready == 1))
        next_state = WMAST_STALL;
      else if (timer == TIMEOUT)
        next_state = WRITE_ERROR;
    WRITE_LAST:
      next_state = BRESP_VALID;
    WRITE_ERROR:
      next_state = BRESP_VALID;
    BRESP_VALID:
      if (s_axi_bready == 1)
        next_state = BRESP_ACCEPT;
      else if (timer == TIMEOUT)
        next_state = INIT;
    BRESP_ACCEPT:
      next_state = INIT;
    BRESP_ERROR:
      next_state = INIT;
    RADDR_ACCEPT:
      if (read_address_inrange == 1)
        next_state = RADDR_INRANGE;
      else
        next_state = RADDR_ERROR;
    RADDR_INRANGE:
      if ((s_axi_rready == 1) && (slave_ready == 1) && (burst_count == 0)) 
        next_state = RDATA_LAST;
      else if ((s_axi_rready == 1) && (slave_ready == 1))
        next_state = RDATA_VALID;
      else if ((s_axi_rready == 0) && (slave_ready == 1))
        next_state = RMAST_STALL;
      else if (slave_ready == 0) 
        next_state = RSLAVE_STALL;
      else if (timer == TIMEOUT)
        next_state = RADDR_ERROR;
    RADDR_ERROR:
      next_state = INIT;
    RDATA_VALID:
      if ((s_axi_rready == 1) && (slave_ready == 1) && (burst_count == 1))
        next_state = RDATA_LAST;
      else if ((s_axi_rready == 1) && (slave_ready == 0))
        next_state = RSLAVE_STALL;
       else if (s_axi_rready == 0)
        next_state = RMAST_STALL;
    RMAST_STALL:
      if ((s_axi_rready == 1) && ( slave_ready == 1) && (burst_count == 1))
        next_state = RDATA_LAST;
      else if ((s_axi_rready == 1) && (slave_ready == 1))
        next_state = RDATA_VALID;
      else if ((s_axi_rready == 1) && (slave_ready == 0))
        next_state = RSLAVE_STALL;
      else if (timer == TIMEOUT)
        next_state = RDATA_ERROR;
     RSLAVE_STALL:
      if ((s_axi_rready == 1) && (slave_ready == 1) && (burst_count <= 1))
        next_state = RDATA_LAST;
      else if ((s_axi_rready == 1) && (slave_ready == 1))
        next_state = RDATA_VALID;
      else if ((s_axi_rready == 1) && (slave_ready == 1))
        next_state = RMAST_STALL;
      else if (timer == TIMEOUT)
        next_state = RDATA_ERROR;
   RDATA_LAST:
     if (s_axi_rready == 1)
       next_state = INIT;
    RDATA_ERROR:
      next_state = INIT;
    default:
      next_state = INIT;
  endcase
end

always @(posedge s_axi_aclk)
begin
  if (s_axi_aresetn == 0) begin
      s_axi_awready <= 1'b0;
      s_axi_wready  <= 1'b0;
      s_axi_bid     <= 3'b000;
      s_axi_bvalid  <= 1'b0;
      s_axi_bresp   <= 2'b00;
      s_axi_arready <= 1'b0;
      s_axi_rvalid  <= 1'b0;
      s_axi_rresp   <= 2'b00;
      s_axi_rid     <= 3'b000;
      s_axi_rlast   <= 1'b0;
  end else
  case (next_state)
    INIT : begin
      s_axi_awready <= 1'b0;
      s_axi_wready  <= 1'b0;
      s_axi_bvalid  <= 1'b0;
      s_axi_bid     <= 3'b000;
      s_axi_bresp   <= 2'b00;
      s_axi_arready <= 1'b0;
      s_axi_rid     <= 3'b000;
      s_axi_rvalid  <= 1'b0;
      s_axi_rresp   <= 2'b00;
      s_axi_rlast   <= 1'b0;
    end
    WRR_READY : begin
      s_axi_awready <= 1'b1;
      s_axi_arready <= 1'b1;
    end
    WADDR_ACCEPT : begin
      s_axi_awready <= 1'b0;
      s_axi_arready <= 1'b0;
   end
    WADDR_INRANGE : begin

   end
    WADDR_ERROR : begin

    end
    WRITE_READY : begin
      s_axi_wready  <= 1'b1;
      timer <= timer+1;
    end
    DATA_WRITE : begin
     timer <= 0;
      s_axi_bresp   <= OKAY;
      s_axi_wready  <= 1'b1;
    end
    WMAST_STALL : begin

    end
    WSLAVE_STALL : begin
      s_axi_wready  <= 1'b0;
    end
    WRITE_LAST : begin
     s_axi_wready  <= 1'b0;
    end
    WRITE_ERROR : begin
      s_axi_bresp   <= DECERR;
      s_axi_wready  <= 1'b0;
    end
    BRESP_VALID : begin
      s_axi_bvalid  <= 1'b1;
      timer <= timer+1;
   end
    BRESP_ACCEPT : begin
      s_axi_bvalid  <= 1'b0;
      s_axi_bresp   <= OKAY;
      timer <= 0;
    end
    BRESP_ERROR : begin

    end
    RADDR_ACCEPT : begin
      s_axi_awready <= 1'b0;
      s_axi_arready <= 1'b0;
    end
    RADDR_INRANGE : begin
     s_axi_rresp   <= OKAY;
     timer <= timer+1;
     if (burst_count != 0)
       s_axi_rvalid  <= 1'b1;
     else
       s_axi_rvalid  <= 1'b0;
    end
    RADDR_ERROR : begin
     s_axi_rresp   <= DECERR;
    end
    RDATA_VALID : begin
      s_axi_rvalid  <= 1'b1;
      s_axi_rresp   <= 2'b00;
      timer <= 0;
    end
    RMAST_STALL : begin
      timer <= timer+1;
    end
    RSLAVE_STALL : begin
      s_axi_rvalid  <= 1'b0;
      timer <= timer+1;
    end
    RDATA_LAST : begin
      s_axi_rlast   <= 1'b1;
      s_axi_rvalid  <= 1'b1;
    end
    RDATA_ERROR : begin
      s_axi_rvalid  <= 1'b0;
    end
    endcase
end

always @(posedge s_axi_aclk)
begin
  if (next_state == WADDR_ACCEPT)
    burst_count   <= s_axi_awlen;
  else if (next_state == RADDR_ACCEPT)
    burst_count   <= s_axi_arlen;
  else if (next_state == DATA_WRITE)
    burst_count <= burst_count - 1;
  else if (next_state == RDATA_VALID)
    burst_count <= burst_count - 1;
end

always @(posedge s_axi_aclk)
begin
  if (next_state == WADDR_ACCEPT)
     write_address <= s_axi_awaddr;
  else if ((next_state == DATA_WRITE) && (state != WRITE_READY))
     write_address   <= write_address+4;
  else if ((next_state == WRITE_LAST) && (state != WRITE_READY))
     write_address   <= write_address+4;
end

always @(posedge s_axi_aclk)
begin
  if ((next_state == DATA_WRITE) && (state != WSLAVE_STALL))
    write_data <= s_axi_wdata;
  else if ((next_state == WSLAVE_STALL) && (state == DATA_WRITE))
    write_data <= s_axi_wdata;
  else if (next_state == WRITE_LAST)
    write_data <= s_axi_wdata;
end

always @(posedge s_axi_aclk)
begin
  if ((next_state == DATA_WRITE) || (next_state == WRITE_LAST))
    write_assert <= 1'b1;
  else
     write_assert <= 1'b0;
end

always @(posedge s_axi_aclk)
begin
  if (next_state == RADDR_ACCEPT)
    read_address   <= s_axi_araddr;
  else if (next_state == RDATA_VALID)
    read_address   <= read_address+4;
  else if ((next_state == RDATA_LAST) && (state != RADDR_INRANGE) && (state != RDATA_LAST) && (state != RSLAVE_STALL))
    read_address   <= read_address+4;
end 

always @(posedge s_axi_aclk)
begin
  if (write_assert == 1)
    case (write_address)
      24'h000004: control_register <= write_data;
    endcase
end

always@(*)
begin
    case (read_address[23:8])
      16'h0000 :
        case (read_address[7:0])
          8'h04 : s_axi_rdata <= control_register;
          default : s_axi_rdata <= 32'h0;
        endcase
      24'h0001: s_axi_rdata <= data_memory[read_address[7:2]];
      default : s_axi_rdata <= 32'h0;
    endcase
end

always @(posedge s_axi_aclk)
begin
   if ((write_assert == 1) && (write_address[23:8] == 16'h0001))
     data_memory[write_address[7:2]] <= write_data;
end
endmodule