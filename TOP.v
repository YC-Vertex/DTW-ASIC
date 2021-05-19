`include "src/DTW_CTRL.v"
`include "src/DTW_DC.v"
`include "src/DTW_BT.v"

module TOP(
    input   wire    clk_i,
    input   wire    rst_i,

    output  wire    [9:0]   addr_o,
    inout   wire    [31:0]  data,
    output  wire    WR_o,
    output  wire    CS_o,

    input   wire    [31:0]  Sin_i,
    input   wire    valid_i,
    output  wire    ready_o
);

    wire [29:0] T;
    wire [29:0] R;
    assign T = data[29:0];

    wire dc_ena;
    wire bt_start;

    wire [4:0] ti_ext2dc;
    wire [11:0] tsrc;
    wire [4:0] ri_ext2dc;
    wire [11:0] rsrc;

    wire [17:0] sel0;
    wire [17:0] sel1;
    wire [17:0] sel2;

    wire [95:0] D;
    wire [29:0] ti_dc2bt;
    wire [29:0] ri_dc2bt;
    wire [11:0] path;

    wire [9:0] addr;

    DTW_DC dtw_dc(
        .clk(clk_i), .nrst(rst_i), .ena(dc_ena),

        .T(T), .i_tindex(ti_ext2dc), .i_tsrc(tsrc),
        .R(R), .i_rindex(ri_ext2dc), .i_rsrc(rsrc),

        .i_sel0(sel0), .i_sel1(sel1), .i_sel2(sel2),

        .D(D), .o_tindex(ti_dc2bt), .o_rindex(ri_dc2bt), .o_path(path)
    );

    DTW_BT dtw_bt(
        .clk(clk_i), .nrst(rst_i),

        .i_tindex(ti_dc2bt),
        .i_rindex(ri_dc2bt),
        .D(D),
        .i_path(path),

        .i_bt_start(bt_start),
        .o_bt_end(bt_end),
        .o_data(data)
    );

    DTW_CTRL dtw_ctrl(
        .clk(clk_i), .nrst(rst_i),
        .i_valid(valid_i), .o_ready(ready_o),

        .Rin(Sin_i), .R(R), 

        .o_dc_ena(dc_ena),
        .o_tindex(ti_ext2dc), .o_rindex(ri_ext2dc),
        .o_tsrc(tsrc), .o_rsrc(rsrc),
        .o_sel0(sel0), .o_sel1(sel1), .o_sel2(sel2),

        .o_addr(addr_dc), .o_WR(WR_o), .o_CS(CS_o),

        .o_bt_start(bt_start), .o_bt_end(bt_end)
    );

endmodule
