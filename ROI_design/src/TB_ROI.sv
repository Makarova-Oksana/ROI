module ROI#(
parameter PIXEL_SIZE = 8,
parameter WIDTH = 1920,		// log2 = 11
parameter HEIGHT = 1080		// log2 = 11
)();
  wire clk;
  wire rst_n;
 // input AXI Stream interface                       
 reg  [ PIXEL_SIZE-1:0] i_s_axis_tdata;      
 reg  i_s_axis_tvalid;                        
 reg  i_s_axis_tlast ;                        
 wire o_s_axis_tready;                        
 // output AXI Stream interface                       
 wire [ PIXEL_SIZE-1:0] o_s_axis_tdata;      
 wire o_s_axis_tvalid;                        
 wire o_s_axis_tlast ;                        
 reg  i_s_axis_tready;                        
  
  
  
  

endmodule;