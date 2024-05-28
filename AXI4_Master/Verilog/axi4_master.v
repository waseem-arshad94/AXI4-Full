// For Demonstration purposes only
// Code has not been fully verified or tested 
// User assumes risk
`timescale 1ns / 1ps
module axi4_master
(
    input  wire        m_axi_aclk,
    input  wire        m_axi_aresetn,

    output reg  [2:0]  m_axi_awid ,
    output reg  [23:0] m_axi_awaddr,
    output reg  [2:0]  m_axi_awsize,
    output reg  [1:0]  m_axi_awburst,
    output reg  [7:0]  m_axi_awlen,
    output reg  [1:0]  m_axi_awlock ,
    output reg  [3:0]  m_axi_awcache,
    output reg  [2:0]  m_axi_awprot,
    output reg  [3:0]  m_axi_awqos,
    output reg  [4:0]  m_axi_awuser,
    output reg         m_axi_awvalid,
    input  wire        m_axi_awready,
    // Write data channel signals
    output reg  [2:0]  m_axi_wid ,
    output wire [31:0] m_axi_wdata,
    output reg  [3:0]  m_axi_wstrb,
    output reg         m_axi_wlast,
    output reg         m_axi_wvalid,
    input  wire        m_axi_wready,
        //  Write response channel signals
    input  wire        m_axi_bid,
    input  wire        m_axi_bresp,
    input  wire        m_axi_bvalid,
    output reg         m_axi_bready,
        //  Read address channel signals
    output reg  [2:0]  m_axi_arid,
    output reg  [23:0] m_axi_araddr,
    output reg  [7:0]  m_axi_arlen,
    output reg  [2:0]  m_axi_arsize,
    output reg  [1:0]  m_axi_arburst,
    output reg  [1:0]  m_axi_arlock,
    output reg  [3:0]  m_axi_arcache,
    output reg  [2:0]  m_axi_arprot,
    output reg  [3:0]  m_axi_arqos,
    output reg  [4:0]  m_axi_aruser,
    output reg         m_axi_arvalid,
    input  wire        m_axi_arready,
        // Read data channel signals
    input  wire [2:0]  m_axi_rid ,
    input  wire [31:0] m_axi_rdata,
    input  wire [1:0]  m_axi_rresp ,
    input  wire        m_axi_rlast,
    input  wire        m_axi_rvalid,
    output reg         m_axi_rready,
    input  wire        write,
    input  wire [23:0] write_address,
    input  wire [7:0]  write_burstlen,
    input  wire [31:0]  write_data,
    input  wire        read,
    input  wire [23:0] read_address,
    input  wire [7:0]  read_burstlen,
    output reg  [31:0] read_data
	);
parameter  BUSY_MASTER_TEST =0;
reg [3:0]  timer;
localparam TIMEOUT = 15;
reg [7:0]  burst_count;
reg [31:0] data_gen ;
reg [5:0]  lfsr = 6'b100000;
wire master_ready;
reg master_was_ready;

localparam INIT = 0,STANDBY = 1,WADDR_VALID = 2,WADDR_ACCEPT = 3,
            WADDR_ERROR = 4,WDATA_VALID = 5,WSLAVE_STALL = 6,
            WMAST_STALL = 7,WDATA_LAST = 8,WDATA_ERROR = 9,
            WAIT_RESPONSE = 10,ACCEPT_RESPONSE = 11,RESPONSE_ERROR = 12,
            RADDR_VALID = 13,RADDR_ACCEPT = 14,RDATA_VALID = 15,
            RSLAVE_STALL = 16,RMAST_STALL = 17,RDATA_LAST = 18,RDATA_ERROR = 19;
reg [4:0] state,next_state;

always @(posedge m_axi_aclk)
begin
    if( m_axi_aresetn == 0)
      state <= INIT;
    else
      state <= next_state;
end

always @(posedge m_axi_aclk)
begin
      lfsr[0] <= lfsr[5] ^ lfsr[4] ^ 1'b1;
      lfsr[5:1] <= lfsr[4:0];
    master_was_ready <= master_ready;
end

 assign master_ready = BUSY_MASTER_TEST ? lfsr[5] : 1;
//assign master_ready = lfsr[5];

always @(*) begin
  next_state = state;
  case (state)
    INIT:
      next_state = STANDBY;
    STANDBY:
      if (write == 1)
        next_state = WADDR_VALID;
      else if (read == 1)
        next_state = RADDR_VALID;
    WADDR_VALID:
      if ((m_axi_awready == 1) && (m_axi_wready == 1) && (burst_count == 0))
        next_state = WDATA_LAST;
      else if ((m_axi_awready == 1) && (m_axi_wready == 1))
        next_state = WDATA_VALID;
       else if (m_axi_awready == 1)
        next_state = WADDR_ACCEPT;
      else if (timer == TIMEOUT)
        next_state = WADDR_ERROR;
    WADDR_ACCEPT:
      if ((m_axi_wready == 1) && (burst_count == 0))
        next_state = WDATA_LAST;
      else if (m_axi_wready == 1)
        next_state = WDATA_VALID;
      else if (timer == TIMEOUT)
        next_state = WDATA_ERROR;
    WADDR_ERROR:
      next_state = WAIT_RESPONSE;
    WDATA_VALID:
      if ((m_axi_wready == 1) && (master_was_ready == 1) && (burst_count == 0))
        next_state = WDATA_LAST;
      else if ((m_axi_wready == 1) && (master_ready == 0))
        next_state = WMAST_STALL;
      else if (m_axi_wready == 0)
        next_state = WSLAVE_STALL;
    WSLAVE_STALL:
      if ((m_axi_wready == 1) && (master_ready == 1) && (burst_count == 0))
        next_state = WDATA_LAST;
      else if ((m_axi_wready == 1) && (master_ready == 1))
        next_state = WDATA_VALID;
      else if ((m_axi_wready == 1) && (master_ready == 0))
        next_state = WDATA_VALID;
      else if (m_axi_wready == 1)
        next_state = WMAST_STALL;
      else if (timer == TIMEOUT)
        next_state = WDATA_ERROR;
    WMAST_STALL:
      if ((m_axi_wready == 1) && (master_was_ready == 1) && (burst_count == 0))
        next_state = WDATA_LAST;
      else if ((m_axi_wready == 1) && (master_ready == 1))
        next_state = WDATA_VALID;
      else if ((m_axi_wready == 0) && (master_ready == 1))
        next_state = WSLAVE_STALL;
      else if (timer == TIMEOUT)
        next_state = WDATA_ERROR;
    WDATA_LAST:
      if (m_axi_bvalid == 1) 
        next_state = ACCEPT_RESPONSE;
      else
        next_state = WAIT_RESPONSE;
    WAIT_RESPONSE:
      if (m_axi_bvalid == 1)
        next_state = ACCEPT_RESPONSE;
      else if (timer == TIMEOUT)
        next_state = RESPONSE_ERROR;
    ACCEPT_RESPONSE:
      next_state = INIT;
    RESPONSE_ERROR:
      next_state = INIT;
    RADDR_VALID:
      if (m_axi_arready == 1)
        next_state = RADDR_ACCEPT;
      else if (timer == TIMEOUT)
        next_state = RESPONSE_ERROR;
    RADDR_ACCEPT:
      if ((m_axi_rvalid == 1) && ((burst_count == 0) || (m_axi_rlast == 1)))
        next_state = RDATA_LAST;
      else if (m_axi_rvalid == 1)
        next_state = RDATA_VALID;
      else
        next_state = RSLAVE_STALL;
    RDATA_VALID:
      if ((m_axi_rvalid == 1) && (master_was_ready == 1) && ((burst_count == 0) || (m_axi_rlast == 1)))
        next_state = RDATA_LAST;
      else if ((m_axi_rvalid == 1) && (master_ready == 0))
        next_state = RMAST_STALL;
      else if (m_axi_rvalid == 0)
        next_state = RSLAVE_STALL;
    RSLAVE_STALL:
      if ((m_axi_rvalid == 1) && (master_ready == 1) && (burst_count == 0))
        next_state = RDATA_LAST;
      else if ((m_axi_rvalid == 1) && (master_ready == 1))
        next_state = RDATA_VALID;
      else if (m_axi_rvalid == 1)
        next_state = RMAST_STALL;
    RMAST_STALL:
      if ((m_axi_rvalid == 1)&& (master_was_ready == 1) && ((burst_count == 0) || (m_axi_rlast == 1)))
        next_state = RDATA_LAST;
      else if ((m_axi_rvalid == 1) && (master_ready == 1))
        next_state = RDATA_VALID;
      else if (master_ready == 1)
        next_state = RSLAVE_STALL;
    RDATA_LAST:
      next_state = INIT;
    RDATA_ERROR:
      next_state = INIT;
    default:
      next_state = INIT;
  endcase
end

always @(posedge m_axi_aclk)
begin
  if (m_axi_aresetn == 0) begin
      m_axi_awvalid <= 0;
      m_axi_awid    <= 0;
      m_axi_awaddr  <= 0;
      m_axi_awprot  <= 0;
      m_axi_wvalid  <= 0;
      m_axi_awlen   <= 0;
      m_axi_awsize  <= 0;
      m_axi_awburst <= 0;
      m_axi_awlock  <= 0;
      m_axi_awcache <= 0;
      m_axi_awqos   <= 0;
      m_axi_awuser  <= 0;
      m_axi_wid     <= 0;
      data_gen      <= 0;
      m_axi_wstrb   <= 0;
      m_axi_wlast   <= 0;
      m_axi_bready  <= 0;
      m_axi_arvalid <= 0;
      m_axi_arid    <= 0;
      m_axi_araddr  <= 0;
      m_axi_arlen   <= 0;
      m_axi_arsize  <= 0;
      m_axi_arburst <= 0;
      m_axi_arqos   <= 0;
      m_axi_arprot  <= 0;
      m_axi_arlock  <= 0;
      m_axi_arcache <= 0;
      m_axi_aruser  <= 0;
      m_axi_rready  <= 0;
  end else    
  case (next_state)
    INIT: begin
      m_axi_awvalid <= 0;
      m_axi_awaddr  <= 0;
      m_axi_awburst <= 1;
      m_axi_awprot  <= 0;
      m_axi_wvalid  <= 0;
      data_gen      <= 0;
      m_axi_wstrb   <= 0;
      m_axi_bready  <= 0;
      m_axi_arvalid <= 0;
      m_axi_arburst <= 1;
      m_axi_araddr  <= 0;
      m_axi_arprot  <= 0;
      m_axi_rready  <= 0;
    end
    STANDBY: begin
      timer <= 0;
    end
    WADDR_VALID: begin
      m_axi_awvalid <= 1;
      m_axi_wvalid  <= 1;
      m_axi_awaddr  <= write_address;
      m_axi_awlen   <= write_burstlen;
      data_gen      <= write_data;
      burst_count   <= write_burstlen;
      if (write_burstlen == 0)
        m_axi_wlast <= 1;
    end
    WADDR_ACCEPT: begin
      m_axi_awvalid <= 0;
      if (m_axi_wready == 1)
        data_gen      <= data_gen + 1;
    end
    WADDR_ERROR: begin

    end
    WDATA_VALID: begin
      m_axi_wvalid  <= 1;
      if (burst_count == 1)
        m_axi_wlast <= 1;
      data_gen      <= data_gen + 1;
      m_axi_awvalid <= 0;
      timer <= 0;
      m_axi_bready  <= 0;
      burst_count <= burst_count - 1;
    end
    WSLAVE_STALL: begin
      timer <= timer + 1;
    end
    WMAST_STALL: begin
      timer <= timer + 1;
      m_axi_wvalid  <= 0;
    end
    WDATA_LAST: begin
      timer <= 0;
      m_axi_awvalid <= 0;
      m_axi_wvalid  <= 0;
      m_axi_wlast   <= 0;
      m_axi_bready  <= 1;
    end
    WDATA_ERROR: begin

    end
    WAIT_RESPONSE: begin
      m_axi_bready  <= 1;
    end
    ACCEPT_RESPONSE: begin
      m_axi_bready  <= 0;
    end
    RESPONSE_ERROR: begin

    end
    RADDR_VALID: begin
      m_axi_araddr  <= read_address;
      burst_count   <= read_burstlen;
      m_axi_arlen   <= read_burstlen;
      m_axi_arvalid <= 1;
      m_axi_rready  <= 1;
    end
    RADDR_ACCEPT: begin
      m_axi_arvalid <= 0;
    end
    RDATA_VALID: begin
      burst_count   <= burst_count - 1;
      m_axi_rready  <= 1;
    end
    RSLAVE_STALL: begin
      m_axi_rready  <= 1;
    end
    RMAST_STALL: begin
      m_axi_rready <= 0;
    end
    RDATA_LAST: begin
      m_axi_rready  <= 0;
    end
    RDATA_ERROR: begin
    end
endcase
end
assign m_axi_wdata = data_gen;

endmodule