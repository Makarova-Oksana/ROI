//
module ROI_SHELL #(
parameter PIXEL_SIZE = 8,
parameter WIDTH = 1920,		// log2 = 11
parameter HEIGHT = 1080		// log2 = 11
)(
input logic clk,
input logic rst_n,
// control APB interface
input  logic 		apb_psel ,
input  logic [31:0] apb_paddr ,
input  logic 		apb_penable ,
input  logic 		apb_pwrite ,
input  logic [31:0]	apb_pwdata ,
output logic [31:0] apb_prdata ,
output logic 		apb_pready ,
output logic 		apb_perror ,  

// input AXI Stream interface
input  logic [ PIXEL_SIZE-1:0] i_s_axis_tdata ,
input  logic i_s_axis_tvalid,
input  logic i_s_axis_tlast ,
output logic o_s_axis_tready,
// output AXI Stream interface
output logic [ PIXEL_SIZE-1:0] o_s_axis_tdata ,
output logic o_s_axis_tvalid,
output logic o_s_axis_tlast ,
input  logic i_s_axis_tready
); 


wire [10:0] roi_start_x_i, roi_start_y_i, roi_end_x_i, roi_end_y_i;
reg [10:0] axi_x, axi_y;
// output AXI Stream interface
always @(negedge rst_n  or posedge clk) 
	begin		  
		if (!rst_n) 
			begin 	
				axi_x <= 0;
				axi_y <= 0;
				
				o_s_axis_tready <=0;
				//						   
				o_s_axis_tdata  <=0;
				o_s_axis_tvalid	<=0;
				o_s_axis_tlast 	<=0;
			end					  
		else 	
			begin 	
			if (axi_x == WIDTH-1 ) begin axi_y <= axi_y + 1; end 
				if (i_s_axis_tlast) 
					begin   
						axi_x <= 0;
						axi_y <= 0;
					end
				if (i_s_axis_tvalid) 
					begin 
						o_s_axis_tdata  <= i_s_axis_tdata;
						o_s_axis_tready <= 1;	
						axi_x <= axi_x + 1;
					end
				else 
					begin 	 //?
						o_s_axis_tdata  <=	0;
						o_s_axis_tready <=	0;
					end
				
			
			end
		end
	
endmodule