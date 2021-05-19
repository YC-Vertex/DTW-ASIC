`include "ScoreArr.v"

module DTW_BT(
    input   wire    clk,
    input   wire    nrst,
    
    input   wire    [29:0]  i_tindex,
    input   wire    [29:0]  i_rindex,
    input   wire    [95:0]  D,
    input   wire    [11:0]   i_path,

    input   wire    i_bt_start, // 连接至最后一个单元的i_outena端口
    output  wire    o_bt_end,
    output  wire    [31:0]  o_data // to SRAM
);

    wire [15:0] D_1;
    wire [15:0] D_2;
    wire [15:0] D_3;
    wire [15:0] D_4;
    wire [15:0] D_5;
    wire [15:0] D_6;
    assign D_1 = D[95:80];
    assign D_2 = D[79:64];
    assign D_3 = D[63:48];
    assign D_4 = D[47:32];
    assign D_5 = D[31:16];
    assign D_6 = D[15: 0];

    wire [4:0] ti_1;
    wire [4:0] ti_2;
    wire [4:0] ti_3;
    wire [4:0] ti_4;
    wire [4:0] ti_5;
    wire [4:0] ti_6;
    assign ti_1 = i_tindex[29:25];
    assign ti_2 = i_tindex[24:20];
    assign ti_3 = i_tindex[19:15];
    assign ti_4 = i_tindex[14:10];
    assign ti_5 = i_tindex[ 9: 5];
    assign ti_6 = i_tindex[ 4: 0];

    wire [4:0] ri_1;
    wire [4:0] ri_2;
    wire [4:0] ri_3;
    wire [4:0] ri_4;
    wire [4:0] ri_5;
    wire [4:0] ri_6;
    assign ri_1 = i_rindex[29:25];
    assign ri_2 = i_rindex[24:20];
    assign ri_3 = i_rindex[19:15];
    assign ri_4 = i_rindex[14:10];
    assign ri_5 = i_rindex[ 9: 5];
    assign ri_6 = i_rindex[ 4: 0];

    wire [1:0] path_1;
    wire [1:0] path_2;
    wire [1:0] path_3;
    wire [1:0] path_4;
    wire [1:0] path_5;
    wire [1:0] path_6;
    assign path_1 = i_path[11:10];
    assign path_2 = i_path[9:8];
    assign path_3 = i_path[7:6];
    assign path_4 = i_path[5:4];
    assign path_5 = i_path[3:2];
    assign path_6 = i_path[1:0];

    ScoreArr score_arr(
        clk, nrst,
        ti_1, ti_2, ti_3, ti_4, ti_5, ti_6,
        ri_1, ri_2, ri_3, ri_4, ri_5, ri_6,
        D_1, D_2, D_3, D_4, D_5, D_6,
        path_1, path_2, path_3, path_4, path_5, path_6,
        i_bt_start, o_bt_end, o_data
    );

endmodule
