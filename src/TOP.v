`include "DTW_CTRL.v"
`include "DTW_DC.v"
`include "DTW_BT.v"

module TOP(
    input   wire    clk_i,
    input   wire    rst_i,

    output  wire    [9:0]   addr_o,
    input   wire    [31:0]  data_i,
	output	wire	[31:0]	data_o,
	output	wire	data_tri_ena,
    output  wire    WR_o,
    output  wire    CS_o,

    input   wire    [31:0]  Sin_i,
    input   wire    valid_i,
    output  wire    ready_o
);

    wire [29:0] T;
    wire [29:0] R;

    wire dc_ena;
    wire bt_ena;
    wire bt_end;

    wire [11:0] tsrc;
    wire [11:0] rsrc;

    wire [17:0] sel0;
    wire [17:0] sel1;
    wire [17:0] sel2;

    wire [95:0] D;
    wire [11:0] path;

    wire [31:0] bt_data;

	assign data_tri_ena = bt_ena;
	assign data_o = bt_data;

    DTW_DC dtw_dc(
        .clk(clk_i), .nrst(rst_i), .ena(dc_ena),
        .T(T), .i_tsrc(tsrc),
        .R(R), .i_rsrc(rsrc),
        .i_sel0(sel0), .i_sel1(sel1), .i_sel2(sel2),
        .D(D), .o_path(path)
    );

    DTW_BT dtw_bt(
        .clk(clk_i), .nrst(rst_i),
        .D(D), .i_path(path),
        .i_bt_ena(bt_ena), .o_bt_end(bt_end),
        .o_data(bt_data)
    );

    DTW_CTRL dtw_ctrl(
        .clk(clk_i), .nrst(rst_i),
        .i_valid(valid_i), .o_ready(ready_o),

        .o_dc_ena(dc_ena), .o_bt_ena(bt_ena), .i_bt_end(bt_end),

        .Rin(Sin_i), .R(R), 
        .Tin(data_i), .T(T),
        .o_tsrc(tsrc), .o_rsrc(rsrc),
        .o_sel0(sel0), .o_sel1(sel1), .o_sel2(sel2),

        .o_addr(addr_o), .o_WR(WR_o), .o_CS(CS_o)
    );

endmodule
