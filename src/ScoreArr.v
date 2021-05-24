`include "ScoreUnit.v"

module ScoreArr (
    input   wire    clk,
    input   wire    nrst,

    input   wire    [4:0]   i_tindex_1,
    input   wire    [4:0]   i_tindex_2,
    input   wire    [4:0]   i_tindex_3,
    input   wire    [4:0]   i_tindex_4,
    input   wire    [4:0]   i_tindex_5, 
    input   wire    [4:0]   i_tindex_6,
    input   wire    [4:0]   i_rindex_1,
    input   wire    [4:0]   i_rindex_2,
    input   wire    [4:0]   i_rindex_3,
    input   wire    [4:0]   i_rindex_4,
    input   wire    [4:0]   i_rindex_5,
    input   wire    [4:0]   i_rindex_6,

    input   wire    [15:0]  D_1,
    input   wire    [15:0]  D_2,
    input   wire    [15:0]  D_3,
    input   wire    [15:0]  D_4,
    input   wire    [15:0]  D_5,
    input   wire    [15:0]  D_6,

    input   wire    [1:0]   i_path_1,
    input   wire    [1:0]   i_path_2,
    input   wire    [1:0]   i_path_3,
    input   wire    [1:0]   i_path_4,
    input   wire    [1:0]   i_path_5,
    input   wire    [1:0]   i_path_6,

    input   wire    i_bt_start,
    output  wire    o_bt_end,
    output  wire    [31:0]  o_data
);

    wire i_outena_19_19;
    wire o_ena0_19_19, o_ena1_19_19, o_ena2_19_19;
    ScoreUnit #(.TINDEX(5'd19), .RINDEX(5'd19)) uut19_19(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_19_19),
        .o_data(o_data),
        .o_ena0(o_ena0_19_19),
        .o_ena1(o_ena1_19_19),
        .o_ena2(o_ena2_19_19)
    );
    assign i_outena_19_19 = i_bt_start;

    wire i_outena_19_18;
    wire o_ena0_19_18, o_ena1_19_18, o_ena2_19_18;
    ScoreUnit #(.TINDEX(5'd19), .RINDEX(5'd18)) uut19_18(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_19_18),
        .o_data(o_data),
        .o_ena0(o_ena0_19_18),
        .o_ena1(o_ena1_19_18)
    );
    assign i_outena_19_18 = o_ena2_19_19;

    wire i_outena_18_19;
    wire o_ena0_18_19, o_ena1_18_19, o_ena2_18_19;
    ScoreUnit #(.TINDEX(5'd18), .RINDEX(5'd19)) uut18_19(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_18_19),
        .o_data(o_data),
        .o_ena0(o_ena0_18_19),
        .o_ena2(o_ena2_18_19)
    );
    assign i_outena_18_19 = o_ena1_19_19;

    wire i_outena_18_18;
    wire o_ena0_18_18, o_ena1_18_18, o_ena2_18_18;
    ScoreUnit #(.TINDEX(5'd18), .RINDEX(5'd18)) uut18_18(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_18_18),
        .o_data(o_data),
        .o_ena0(o_ena0_18_18),
        .o_ena1(o_ena1_18_18),
        .o_ena2(o_ena2_18_18)
    );
    assign i_outena_18_18 = o_ena0_19_19 | o_ena1_19_18 | o_ena2_18_19;

    wire i_outena_18_17;
    wire o_ena0_18_17, o_ena1_18_17, o_ena2_18_17;
    ScoreUnit #(.TINDEX(5'd18), .RINDEX(5'd17)) uut18_17(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_18_17),
        .o_data(o_data),
        .o_ena0(o_ena0_18_17),
        .o_ena1(o_ena1_18_17),
        .o_ena2(o_ena2_18_17)
    );
    assign i_outena_18_17 = o_ena0_19_18 | o_ena2_18_18;

    wire i_outena_18_16;
    wire o_ena0_18_16, o_ena1_18_16, o_ena2_18_16;
    ScoreUnit #(.TINDEX(5'd18), .RINDEX(5'd16)) uut18_16(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_18_16),
        .o_data(o_data),
        .o_ena0(o_ena0_18_16),
        .o_ena1(o_ena1_18_16)
    );
    assign i_outena_18_16 = o_ena2_18_17;

    wire i_outena_17_18;
    wire o_ena0_17_18, o_ena1_17_18, o_ena2_17_18;
    ScoreUnit #(.TINDEX(5'd17), .RINDEX(5'd18)) uut17_18(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_17_18),
        .o_data(o_data),
        .o_ena0(o_ena0_17_18),
        .o_ena1(o_ena1_17_18),
        .o_ena2(o_ena2_17_18)
    );
    assign i_outena_17_18 = o_ena0_18_19 | o_ena1_18_18;

    wire i_outena_17_17;
    wire o_ena0_17_17, o_ena1_17_17, o_ena2_17_17;
    ScoreUnit #(.TINDEX(5'd17), .RINDEX(5'd17)) uut17_17(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_17_17),
        .o_data(o_data),
        .o_ena0(o_ena0_17_17),
        .o_ena1(o_ena1_17_17),
        .o_ena2(o_ena2_17_17)
    );
    assign i_outena_17_17 = o_ena0_18_18 | o_ena1_18_17 | o_ena2_17_18;

    wire i_outena_17_16;
    wire o_ena0_17_16, o_ena1_17_16, o_ena2_17_16;
    ScoreUnit #(.TINDEX(5'd17), .RINDEX(5'd16)) uut17_16(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_17_16),
        .o_data(o_data),
        .o_ena0(o_ena0_17_16),
        .o_ena1(o_ena1_17_16),
        .o_ena2(o_ena2_17_16)
    );
    assign i_outena_17_16 = o_ena0_18_17 | o_ena1_18_16 | o_ena2_17_17;

    wire i_outena_17_15;
    wire o_ena0_17_15, o_ena1_17_15, o_ena2_17_15;
    ScoreUnit #(.TINDEX(5'd17), .RINDEX(5'd15)) uut17_15(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_17_15),
        .o_data(o_data),
        .o_ena0(o_ena0_17_15),
        .o_ena1(o_ena1_17_15),
        .o_ena2(o_ena2_17_15)
    );
    assign i_outena_17_15 = o_ena0_18_16 | o_ena2_17_16;

    wire i_outena_17_14;
    wire o_ena0_17_14, o_ena1_17_14, o_ena2_17_14;
    ScoreUnit #(.TINDEX(5'd17), .RINDEX(5'd14)) uut17_14(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_17_14),
        .o_data(o_data),
        .o_ena0(o_ena0_17_14),
        .o_ena1(o_ena1_17_14)
    );
    assign i_outena_17_14 = o_ena2_17_15;

    wire i_outena_16_18;
    wire o_ena0_16_18, o_ena1_16_18, o_ena2_16_18;
    ScoreUnit #(.TINDEX(5'd16), .RINDEX(5'd18)) uut16_18(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_16_18),
        .o_data(o_data),
        .o_ena0(o_ena0_16_18),
        .o_ena2(o_ena2_16_18)
    );
    assign i_outena_16_18 = o_ena1_17_18;

    wire i_outena_16_17;
    wire o_ena0_16_17, o_ena1_16_17, o_ena2_16_17;
    ScoreUnit #(.TINDEX(5'd16), .RINDEX(5'd17)) uut16_17(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_16_17),
        .o_data(o_data),
        .o_ena0(o_ena0_16_17),
        .o_ena1(o_ena1_16_17),
        .o_ena2(o_ena2_16_17)
    );
    assign i_outena_16_17 = o_ena0_17_18 | o_ena1_17_17 | o_ena2_16_18;

    wire i_outena_16_16;
    wire o_ena0_16_16, o_ena1_16_16, o_ena2_16_16;
    ScoreUnit #(.TINDEX(5'd16), .RINDEX(5'd16)) uut16_16(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_16_16),
        .o_data(o_data),
        .o_ena0(o_ena0_16_16),
        .o_ena1(o_ena1_16_16),
        .o_ena2(o_ena2_16_16)
    );
    assign i_outena_16_16 = o_ena0_17_17 | o_ena1_17_16 | o_ena2_16_17;

    wire i_outena_16_15;
    wire o_ena0_16_15, o_ena1_16_15, o_ena2_16_15;
    ScoreUnit #(.TINDEX(5'd16), .RINDEX(5'd15)) uut16_15(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_16_15),
        .o_data(o_data),
        .o_ena0(o_ena0_16_15),
        .o_ena1(o_ena1_16_15),
        .o_ena2(o_ena2_16_15)
    );
    assign i_outena_16_15 = o_ena0_17_16 | o_ena1_17_15 | o_ena2_16_16;

    wire i_outena_16_14;
    wire o_ena0_16_14, o_ena1_16_14, o_ena2_16_14;
    ScoreUnit #(.TINDEX(5'd16), .RINDEX(5'd14)) uut16_14(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_16_14),
        .o_data(o_data),
        .o_ena0(o_ena0_16_14),
        .o_ena1(o_ena1_16_14),
        .o_ena2(o_ena2_16_14)
    );
    assign i_outena_16_14 = o_ena0_17_15 | o_ena1_17_14 | o_ena2_16_15;

    wire i_outena_16_13;
    wire o_ena0_16_13, o_ena1_16_13, o_ena2_16_13;
    ScoreUnit #(.TINDEX(5'd16), .RINDEX(5'd13)) uut16_13(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_16_13),
        .o_data(o_data),
        .o_ena0(o_ena0_16_13),
        .o_ena1(o_ena1_16_13)
    );
    assign i_outena_16_13 = o_ena0_17_14 | o_ena2_16_14;

    wire i_outena_15_17;
    wire o_ena0_15_17, o_ena1_15_17, o_ena2_15_17;
    ScoreUnit #(.TINDEX(5'd15), .RINDEX(5'd17)) uut15_17(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_15_17),
        .o_data(o_data),
        .o_ena0(o_ena0_15_17),
        .o_ena1(o_ena1_15_17),
        .o_ena2(o_ena2_15_17)
    );
    assign i_outena_15_17 = o_ena0_16_18 | o_ena1_16_17;

    wire i_outena_15_16;
    wire o_ena0_15_16, o_ena1_15_16, o_ena2_15_16;
    ScoreUnit #(.TINDEX(5'd15), .RINDEX(5'd16)) uut15_16(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_15_16),
        .o_data(o_data),
        .o_ena0(o_ena0_15_16),
        .o_ena1(o_ena1_15_16),
        .o_ena2(o_ena2_15_16)
    );
    assign i_outena_15_16 = o_ena0_16_17 | o_ena1_16_16 | o_ena2_15_17;

    wire i_outena_15_15;
    wire o_ena0_15_15, o_ena1_15_15, o_ena2_15_15;
    ScoreUnit #(.TINDEX(5'd15), .RINDEX(5'd15)) uut15_15(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_15_15),
        .o_data(o_data),
        .o_ena0(o_ena0_15_15),
        .o_ena1(o_ena1_15_15),
        .o_ena2(o_ena2_15_15)
    );
    assign i_outena_15_15 = o_ena0_16_16 | o_ena1_16_15 | o_ena2_15_16;

    wire i_outena_15_14;
    wire o_ena0_15_14, o_ena1_15_14, o_ena2_15_14;
    ScoreUnit #(.TINDEX(5'd15), .RINDEX(5'd14)) uut15_14(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_15_14),
        .o_data(o_data),
        .o_ena0(o_ena0_15_14),
        .o_ena1(o_ena1_15_14),
        .o_ena2(o_ena2_15_14)
    );
    assign i_outena_15_14 = o_ena0_16_15 | o_ena1_16_14 | o_ena2_15_15;

    wire i_outena_15_13;
    wire o_ena0_15_13, o_ena1_15_13, o_ena2_15_13;
    ScoreUnit #(.TINDEX(5'd15), .RINDEX(5'd13)) uut15_13(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_15_13),
        .o_data(o_data),
        .o_ena0(o_ena0_15_13),
        .o_ena1(o_ena1_15_13),
        .o_ena2(o_ena2_15_13)
    );
    assign i_outena_15_13 = o_ena0_16_14 | o_ena1_16_13 | o_ena2_15_14;

    wire i_outena_15_12;
    wire o_ena0_15_12, o_ena1_15_12, o_ena2_15_12;
    ScoreUnit #(.TINDEX(5'd15), .RINDEX(5'd12)) uut15_12(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_15_12),
        .o_data(o_data),
        .o_ena0(o_ena0_15_12),
        .o_ena1(o_ena1_15_12),
        .o_ena2(o_ena2_15_12)
    );
    assign i_outena_15_12 = o_ena0_16_13 | o_ena2_15_13;

    wire i_outena_15_11;
    wire o_ena0_15_11, o_ena1_15_11, o_ena2_15_11;
    ScoreUnit #(.TINDEX(5'd15), .RINDEX(5'd11)) uut15_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_15_11),
        .o_data(o_data),
        .o_ena0(o_ena0_15_11),
        .o_ena1(o_ena1_15_11)
    );
    assign i_outena_15_11 = o_ena2_15_12;

    wire i_outena_14_17;
    wire o_ena0_14_17, o_ena1_14_17, o_ena2_14_17;
    ScoreUnit #(.TINDEX(5'd14), .RINDEX(5'd17)) uut14_17(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_14_17),
        .o_data(o_data),
        .o_ena0(o_ena0_14_17),
        .o_ena2(o_ena2_14_17)
    );
    assign i_outena_14_17 = o_ena1_15_17;

    wire i_outena_14_16;
    wire o_ena0_14_16, o_ena1_14_16, o_ena2_14_16;
    ScoreUnit #(.TINDEX(5'd14), .RINDEX(5'd16)) uut14_16(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_14_16),
        .o_data(o_data),
        .o_ena0(o_ena0_14_16),
        .o_ena1(o_ena1_14_16),
        .o_ena2(o_ena2_14_16)
    );
    assign i_outena_14_16 = o_ena0_15_17 | o_ena1_15_16 | o_ena2_14_17;

    wire i_outena_14_15;
    wire o_ena0_14_15, o_ena1_14_15, o_ena2_14_15;
    ScoreUnit #(.TINDEX(5'd14), .RINDEX(5'd15)) uut14_15(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_14_15),
        .o_data(o_data),
        .o_ena0(o_ena0_14_15),
        .o_ena1(o_ena1_14_15),
        .o_ena2(o_ena2_14_15)
    );
    assign i_outena_14_15 = o_ena0_15_16 | o_ena1_15_15 | o_ena2_14_16;

    wire i_outena_14_14;
    wire o_ena0_14_14, o_ena1_14_14, o_ena2_14_14;
    ScoreUnit #(.TINDEX(5'd14), .RINDEX(5'd14)) uut14_14(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_14_14),
        .o_data(o_data),
        .o_ena0(o_ena0_14_14),
        .o_ena1(o_ena1_14_14),
        .o_ena2(o_ena2_14_14)
    );
    assign i_outena_14_14 = o_ena0_15_15 | o_ena1_15_14 | o_ena2_14_15;

    wire i_outena_14_13;
    wire o_ena0_14_13, o_ena1_14_13, o_ena2_14_13;
    ScoreUnit #(.TINDEX(5'd14), .RINDEX(5'd13)) uut14_13(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_14_13),
        .o_data(o_data),
        .o_ena0(o_ena0_14_13),
        .o_ena1(o_ena1_14_13),
        .o_ena2(o_ena2_14_13)
    );
    assign i_outena_14_13 = o_ena0_15_14 | o_ena1_15_13 | o_ena2_14_14;

    wire i_outena_14_12;
    wire o_ena0_14_12, o_ena1_14_12, o_ena2_14_12;
    ScoreUnit #(.TINDEX(5'd14), .RINDEX(5'd12)) uut14_12(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_14_12),
        .o_data(o_data),
        .o_ena0(o_ena0_14_12),
        .o_ena1(o_ena1_14_12),
        .o_ena2(o_ena2_14_12)
    );
    assign i_outena_14_12 = o_ena0_15_13 | o_ena1_15_12 | o_ena2_14_13;

    wire i_outena_14_11;
    wire o_ena0_14_11, o_ena1_14_11, o_ena2_14_11;
    ScoreUnit #(.TINDEX(5'd14), .RINDEX(5'd11)) uut14_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_14_11),
        .o_data(o_data),
        .o_ena0(o_ena0_14_11),
        .o_ena1(o_ena1_14_11),
        .o_ena2(o_ena2_14_11)
    );
    assign i_outena_14_11 = o_ena0_15_12 | o_ena1_15_11 | o_ena2_14_12;

    wire i_outena_14_10;
    wire o_ena0_14_10, o_ena1_14_10, o_ena2_14_10;
    ScoreUnit #(.TINDEX(5'd14), .RINDEX(5'd10)) uut14_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_14_10),
        .o_data(o_data),
        .o_ena0(o_ena0_14_10),
        .o_ena1(o_ena1_14_10),
        .o_ena2(o_ena2_14_10)
    );
    assign i_outena_14_10 = o_ena0_15_11 | o_ena2_14_11;

    wire i_outena_14_9;
    wire o_ena0_14_9, o_ena1_14_9, o_ena2_14_9;
    ScoreUnit #(.TINDEX(5'd14), .RINDEX(5'd9)) uut14_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_6),
        .i_path(i_path_6),
        .i_tindex(i_tindex_6),
        .i_rindex(i_rindex_6),

        .i_outena(i_outena_14_9),
        .o_data(o_data),
        .o_ena0(o_ena0_14_9),
        .o_ena1(o_ena1_14_9)
    );
    assign i_outena_14_9 = o_ena2_14_10;

    wire i_outena_13_16;
    wire o_ena0_13_16, o_ena1_13_16, o_ena2_13_16;
    ScoreUnit #(.TINDEX(5'd13), .RINDEX(5'd16)) uut13_16(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_13_16),
        .o_data(o_data),
        .o_ena0(o_ena0_13_16),
        .o_ena2(o_ena2_13_16)
    );
    assign i_outena_13_16 = o_ena0_14_17 | o_ena1_14_16;

    wire i_outena_13_15;
    wire o_ena0_13_15, o_ena1_13_15, o_ena2_13_15;
    ScoreUnit #(.TINDEX(5'd13), .RINDEX(5'd15)) uut13_15(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_13_15),
        .o_data(o_data),
        .o_ena0(o_ena0_13_15),
        .o_ena1(o_ena1_13_15),
        .o_ena2(o_ena2_13_15)
    );
    assign i_outena_13_15 = o_ena0_14_16 | o_ena1_14_15 | o_ena2_13_16;

    wire i_outena_13_14;
    wire o_ena0_13_14, o_ena1_13_14, o_ena2_13_14;
    ScoreUnit #(.TINDEX(5'd13), .RINDEX(5'd14)) uut13_14(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_13_14),
        .o_data(o_data),
        .o_ena0(o_ena0_13_14),
        .o_ena1(o_ena1_13_14),
        .o_ena2(o_ena2_13_14)
    );
    assign i_outena_13_14 = o_ena0_14_15 | o_ena1_14_14 | o_ena2_13_15;

    wire i_outena_13_13;
    wire o_ena0_13_13, o_ena1_13_13, o_ena2_13_13;
    ScoreUnit #(.TINDEX(5'd13), .RINDEX(5'd13)) uut13_13(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_13_13),
        .o_data(o_data),
        .o_ena0(o_ena0_13_13),
        .o_ena1(o_ena1_13_13),
        .o_ena2(o_ena2_13_13)
    );
    assign i_outena_13_13 = o_ena0_14_14 | o_ena1_14_13 | o_ena2_13_14;

    wire i_outena_13_12;
    wire o_ena0_13_12, o_ena1_13_12, o_ena2_13_12;
    ScoreUnit #(.TINDEX(5'd13), .RINDEX(5'd12)) uut13_12(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_13_12),
        .o_data(o_data),
        .o_ena0(o_ena0_13_12),
        .o_ena1(o_ena1_13_12),
        .o_ena2(o_ena2_13_12)
    );
    assign i_outena_13_12 = o_ena0_14_13 | o_ena1_14_12 | o_ena2_13_13;

    wire i_outena_13_11;
    wire o_ena0_13_11, o_ena1_13_11, o_ena2_13_11;
    ScoreUnit #(.TINDEX(5'd13), .RINDEX(5'd11)) uut13_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_13_11),
        .o_data(o_data),
        .o_ena0(o_ena0_13_11),
        .o_ena1(o_ena1_13_11),
        .o_ena2(o_ena2_13_11)
    );
    assign i_outena_13_11 = o_ena0_14_12 | o_ena1_14_11 | o_ena2_13_12;

    wire i_outena_13_10;
    wire o_ena0_13_10, o_ena1_13_10, o_ena2_13_10;
    ScoreUnit #(.TINDEX(5'd13), .RINDEX(5'd10)) uut13_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_13_10),
        .o_data(o_data),
        .o_ena0(o_ena0_13_10),
        .o_ena1(o_ena1_13_10),
        .o_ena2(o_ena2_13_10)
    );
    assign i_outena_13_10 = o_ena0_14_11 | o_ena1_14_10 | o_ena2_13_11;

    wire i_outena_13_9;
    wire o_ena0_13_9, o_ena1_13_9, o_ena2_13_9;
    ScoreUnit #(.TINDEX(5'd13), .RINDEX(5'd9)) uut13_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_13_9),
        .o_data(o_data),
        .o_ena0(o_ena0_13_9),
        .o_ena1(o_ena1_13_9),
        .o_ena2(o_ena2_13_9)
    );
    assign i_outena_13_9 = o_ena0_14_10 | o_ena1_14_9 | o_ena2_13_10;

    wire i_outena_13_8;
    wire o_ena0_13_8, o_ena1_13_8, o_ena2_13_8;
    ScoreUnit #(.TINDEX(5'd13), .RINDEX(5'd8)) uut13_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_6),
        .i_path(i_path_6),
        .i_tindex(i_tindex_6),
        .i_rindex(i_rindex_6),

        .i_outena(i_outena_13_8),
        .o_data(o_data),
        .o_ena0(o_ena0_13_8),
        .o_ena1(o_ena1_13_8)
    );
    assign i_outena_13_8 = o_ena0_14_9 | o_ena2_13_9;

    wire i_outena_12_15;
    wire o_ena0_12_15, o_ena1_12_15, o_ena2_12_15;
    ScoreUnit #(.TINDEX(5'd12), .RINDEX(5'd15)) uut12_15(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_12_15),
        .o_data(o_data),
        .o_ena0(o_ena0_12_15),
        .o_ena1(o_ena1_12_15),
        .o_ena2(o_ena2_12_15)
    );
    assign i_outena_12_15 = o_ena0_13_16 | o_ena1_13_15;

    wire i_outena_12_14;
    wire o_ena0_12_14, o_ena1_12_14, o_ena2_12_14;
    ScoreUnit #(.TINDEX(5'd12), .RINDEX(5'd14)) uut12_14(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_12_14),
        .o_data(o_data),
        .o_ena0(o_ena0_12_14),
        .o_ena1(o_ena1_12_14),
        .o_ena2(o_ena2_12_14)
    );
    assign i_outena_12_14 = o_ena0_13_15 | o_ena1_13_14 | o_ena2_12_15;

    wire i_outena_12_13;
    wire o_ena0_12_13, o_ena1_12_13, o_ena2_12_13;
    ScoreUnit #(.TINDEX(5'd12), .RINDEX(5'd13)) uut12_13(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_12_13),
        .o_data(o_data),
        .o_ena0(o_ena0_12_13),
        .o_ena1(o_ena1_12_13),
        .o_ena2(o_ena2_12_13)
    );
    assign i_outena_12_13 = o_ena0_13_14 | o_ena1_13_13 | o_ena2_12_14;

    wire i_outena_12_12;
    wire o_ena0_12_12, o_ena1_12_12, o_ena2_12_12;
    ScoreUnit #(.TINDEX(5'd12), .RINDEX(5'd12)) uut12_12(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_12_12),
        .o_data(o_data),
        .o_ena0(o_ena0_12_12),
        .o_ena1(o_ena1_12_12),
        .o_ena2(o_ena2_12_12)
    );
    assign i_outena_12_12 = o_ena0_13_13 | o_ena1_13_12 | o_ena2_12_13;

    wire i_outena_12_11;
    wire o_ena0_12_11, o_ena1_12_11, o_ena2_12_11;
    ScoreUnit #(.TINDEX(5'd12), .RINDEX(5'd11)) uut12_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_12_11),
        .o_data(o_data),
        .o_ena0(o_ena0_12_11),
        .o_ena1(o_ena1_12_11),
        .o_ena2(o_ena2_12_11)
    );
    assign i_outena_12_11 = o_ena0_13_12 | o_ena1_13_11 | o_ena2_12_12;

    wire i_outena_12_10;
    wire o_ena0_12_10, o_ena1_12_10, o_ena2_12_10;
    ScoreUnit #(.TINDEX(5'd12), .RINDEX(5'd10)) uut12_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_12_10),
        .o_data(o_data),
        .o_ena0(o_ena0_12_10),
        .o_ena1(o_ena1_12_10),
        .o_ena2(o_ena2_12_10)
    );
    assign i_outena_12_10 = o_ena0_13_11 | o_ena1_13_10 | o_ena2_12_11;

    wire i_outena_12_9;
    wire o_ena0_12_9, o_ena1_12_9, o_ena2_12_9;
    ScoreUnit #(.TINDEX(5'd12), .RINDEX(5'd9)) uut12_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_12_9),
        .o_data(o_data),
        .o_ena0(o_ena0_12_9),
        .o_ena1(o_ena1_12_9),
        .o_ena2(o_ena2_12_9)
    );
    assign i_outena_12_9 = o_ena0_13_10 | o_ena1_13_9 | o_ena2_12_10;

    wire i_outena_12_8;
    wire o_ena0_12_8, o_ena1_12_8, o_ena2_12_8;
    ScoreUnit #(.TINDEX(5'd12), .RINDEX(5'd8)) uut12_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_12_8),
        .o_data(o_data),
        .o_ena0(o_ena0_12_8),
        .o_ena1(o_ena1_12_8),
        .o_ena2(o_ena2_12_8)
    );
    assign i_outena_12_8 = o_ena0_13_9 | o_ena1_13_8 | o_ena2_12_9;

    wire i_outena_12_7;
    wire o_ena0_12_7, o_ena1_12_7, o_ena2_12_7;
    ScoreUnit #(.TINDEX(5'd12), .RINDEX(5'd7)) uut12_7(
        .clk(clk),
        .nrst(nrst),

        .D(D_6),
        .i_path(i_path_6),
        .i_tindex(i_tindex_6),
        .i_rindex(i_rindex_6),

        .i_outena(i_outena_12_7),
        .o_data(o_data),
        .o_ena0(o_ena0_12_7),
        .o_ena1(o_ena1_12_7)
    );
    assign i_outena_12_7 = o_ena0_13_8 | o_ena2_12_8;

    wire i_outena_11_15;
    wire o_ena0_11_15, o_ena1_11_15, o_ena2_11_15;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd15)) uut11_15(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_11_15),
        .o_data(o_data),
        .o_ena0(o_ena0_11_15),
        .o_ena2(o_ena2_11_15)
    );
    assign i_outena_11_15 = o_ena1_12_15;

    wire i_outena_11_14;
    wire o_ena0_11_14, o_ena1_11_14, o_ena2_11_14;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd14)) uut11_14(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_11_14),
        .o_data(o_data),
        .o_ena0(o_ena0_11_14),
        .o_ena1(o_ena1_11_14),
        .o_ena2(o_ena2_11_14)
    );
    assign i_outena_11_14 = o_ena0_12_15 | o_ena1_12_14 | o_ena2_11_15;

    wire i_outena_11_13;
    wire o_ena0_11_13, o_ena1_11_13, o_ena2_11_13;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd13)) uut11_13(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_11_13),
        .o_data(o_data),
        .o_ena0(o_ena0_11_13),
        .o_ena1(o_ena1_11_13),
        .o_ena2(o_ena2_11_13)
    );
    assign i_outena_11_13 = o_ena0_12_14 | o_ena1_12_13 | o_ena2_11_14;

    wire i_outena_11_12;
    wire o_ena0_11_12, o_ena1_11_12, o_ena2_11_12;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd12)) uut11_12(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_11_12),
        .o_data(o_data),
        .o_ena0(o_ena0_11_12),
        .o_ena1(o_ena1_11_12),
        .o_ena2(o_ena2_11_12)
    );
    assign i_outena_11_12 = o_ena0_12_13 | o_ena1_12_12 | o_ena2_11_13;

    wire i_outena_11_11;
    wire o_ena0_11_11, o_ena1_11_11, o_ena2_11_11;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd11)) uut11_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_11_11),
        .o_data(o_data),
        .o_ena0(o_ena0_11_11),
        .o_ena1(o_ena1_11_11),
        .o_ena2(o_ena2_11_11)
    );
    assign i_outena_11_11 = o_ena0_12_12 | o_ena1_12_11 | o_ena2_11_12;

    wire i_outena_11_10;
    wire o_ena0_11_10, o_ena1_11_10, o_ena2_11_10;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd10)) uut11_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_11_10),
        .o_data(o_data),
        .o_ena0(o_ena0_11_10),
        .o_ena1(o_ena1_11_10),
        .o_ena2(o_ena2_11_10)
    );
    assign i_outena_11_10 = o_ena0_12_11 | o_ena1_12_10 | o_ena2_11_11;

    wire i_outena_11_9;
    wire o_ena0_11_9, o_ena1_11_9, o_ena2_11_9;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd9)) uut11_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_11_9),
        .o_data(o_data),
        .o_ena0(o_ena0_11_9),
        .o_ena1(o_ena1_11_9),
        .o_ena2(o_ena2_11_9)
    );
    assign i_outena_11_9 = o_ena0_12_10 | o_ena1_12_9 | o_ena2_11_10;

    wire i_outena_11_8;
    wire o_ena0_11_8, o_ena1_11_8, o_ena2_11_8;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd8)) uut11_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_11_8),
        .o_data(o_data),
        .o_ena0(o_ena0_11_8),
        .o_ena1(o_ena1_11_8),
        .o_ena2(o_ena2_11_8)
    );
    assign i_outena_11_8 = o_ena0_12_9 | o_ena1_12_8 | o_ena2_11_9;

    wire i_outena_11_7;
    wire o_ena0_11_7, o_ena1_11_7, o_ena2_11_7;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd7)) uut11_7(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_11_7),
        .o_data(o_data),
        .o_ena0(o_ena0_11_7),
        .o_ena1(o_ena1_11_7),
        .o_ena2(o_ena2_11_7)
    );
    assign i_outena_11_7 = o_ena0_12_8 | o_ena1_12_7 | o_ena2_11_8;

    wire i_outena_11_6;
    wire o_ena0_11_6, o_ena1_11_6, o_ena2_11_6;
    ScoreUnit #(.TINDEX(5'd11), .RINDEX(5'd6)) uut11_6(
        .clk(clk),
        .nrst(nrst),

        .D(D_6),
        .i_path(i_path_6),
        .i_tindex(i_tindex_6),
        .i_rindex(i_rindex_6),

        .i_outena(i_outena_11_6),
        .o_data(o_data),
        .o_ena0(o_ena0_11_6),
        .o_ena1(o_ena1_11_6)
    );
    assign i_outena_11_6 = o_ena0_12_7 | o_ena2_11_7;

    wire i_outena_10_14;
    wire o_ena0_10_14, o_ena1_10_14, o_ena2_10_14;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd14)) uut10_14(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_10_14),
        .o_data(o_data),
        .o_ena0(o_ena0_10_14),
        .o_ena1(o_ena1_10_14),
        .o_ena2(o_ena2_10_14)
    );
    assign i_outena_10_14 = o_ena0_11_15 | o_ena1_11_14;

    wire i_outena_10_13;
    wire o_ena0_10_13, o_ena1_10_13, o_ena2_10_13;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd13)) uut10_13(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_10_13),
        .o_data(o_data),
        .o_ena0(o_ena0_10_13),
        .o_ena1(o_ena1_10_13),
        .o_ena2(o_ena2_10_13)
    );
    assign i_outena_10_13 = o_ena0_11_14 | o_ena1_11_13 | o_ena2_10_14;

    wire i_outena_10_12;
    wire o_ena0_10_12, o_ena1_10_12, o_ena2_10_12;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd12)) uut10_12(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_10_12),
        .o_data(o_data),
        .o_ena0(o_ena0_10_12),
        .o_ena1(o_ena1_10_12),
        .o_ena2(o_ena2_10_12)
    );
    assign i_outena_10_12 = o_ena0_11_13 | o_ena1_11_12 | o_ena2_10_13;

    wire i_outena_10_11;
    wire o_ena0_10_11, o_ena1_10_11, o_ena2_10_11;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd11)) uut10_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_10_11),
        .o_data(o_data),
        .o_ena0(o_ena0_10_11),
        .o_ena1(o_ena1_10_11),
        .o_ena2(o_ena2_10_11)
    );
    assign i_outena_10_11 = o_ena0_11_12 | o_ena1_11_11 | o_ena2_10_12;

    wire i_outena_10_10;
    wire o_ena0_10_10, o_ena1_10_10, o_ena2_10_10;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd10)) uut10_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_10_10),
        .o_data(o_data),
        .o_ena0(o_ena0_10_10),
        .o_ena1(o_ena1_10_10),
        .o_ena2(o_ena2_10_10)
    );
    assign i_outena_10_10 = o_ena0_11_11 | o_ena1_11_10 | o_ena2_10_11;

    wire i_outena_10_9;
    wire o_ena0_10_9, o_ena1_10_9, o_ena2_10_9;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd9)) uut10_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_10_9),
        .o_data(o_data),
        .o_ena0(o_ena0_10_9),
        .o_ena1(o_ena1_10_9),
        .o_ena2(o_ena2_10_9)
    );
    assign i_outena_10_9 = o_ena0_11_10 | o_ena1_11_9 | o_ena2_10_10;

    wire i_outena_10_8;
    wire o_ena0_10_8, o_ena1_10_8, o_ena2_10_8;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd8)) uut10_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_10_8),
        .o_data(o_data),
        .o_ena0(o_ena0_10_8),
        .o_ena1(o_ena1_10_8),
        .o_ena2(o_ena2_10_8)
    );
    assign i_outena_10_8 = o_ena0_11_9 | o_ena1_11_8 | o_ena2_10_9;

    wire i_outena_10_7;
    wire o_ena0_10_7, o_ena1_10_7, o_ena2_10_7;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd7)) uut10_7(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_10_7),
        .o_data(o_data),
        .o_ena0(o_ena0_10_7),
        .o_ena1(o_ena1_10_7),
        .o_ena2(o_ena2_10_7)
    );
    assign i_outena_10_7 = o_ena0_11_8 | o_ena1_11_7 | o_ena2_10_8;

    wire i_outena_10_6;
    wire o_ena0_10_6, o_ena1_10_6, o_ena2_10_6;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd6)) uut10_6(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_10_6),
        .o_data(o_data),
        .o_ena0(o_ena0_10_6),
        .o_ena1(o_ena1_10_6),
        .o_ena2(o_ena2_10_6)
    );
    assign i_outena_10_6 = o_ena0_11_7 | o_ena1_11_6 | o_ena2_10_7;

    wire i_outena_10_5;
    wire o_ena0_10_5, o_ena1_10_5, o_ena2_10_5;
    ScoreUnit #(.TINDEX(5'd10), .RINDEX(5'd5)) uut10_5(
        .clk(clk),
        .nrst(nrst),

        .D(D_6),
        .i_path(i_path_6),
        .i_tindex(i_tindex_6),
        .i_rindex(i_rindex_6),

        .i_outena(i_outena_10_5),
        .o_data(o_data),
        .o_ena1(o_ena1_10_5)
    );
    assign i_outena_10_5 = o_ena0_11_6 | o_ena2_10_6;

    wire i_outena_9_14;
    wire o_ena0_9_14, o_ena1_9_14, o_ena2_9_14;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd14)) uut9_14(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_9_14),
        .o_data(o_data),
        .o_ena0(o_ena0_9_14),
        .o_ena2(o_ena2_9_14)
    );
    assign i_outena_9_14 = o_ena1_10_14;

    wire i_outena_9_13;
    wire o_ena0_9_13, o_ena1_9_13, o_ena2_9_13;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd13)) uut9_13(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_9_13),
        .o_data(o_data),
        .o_ena0(o_ena0_9_13),
        .o_ena1(o_ena1_9_13),
        .o_ena2(o_ena2_9_13)
    );
    assign i_outena_9_13 = o_ena0_10_14 | o_ena1_10_13 | o_ena2_9_14;

    wire i_outena_9_12;
    wire o_ena0_9_12, o_ena1_9_12, o_ena2_9_12;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd12)) uut9_12(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_9_12),
        .o_data(o_data),
        .o_ena0(o_ena0_9_12),
        .o_ena1(o_ena1_9_12),
        .o_ena2(o_ena2_9_12)
    );
    assign i_outena_9_12 = o_ena0_10_13 | o_ena1_10_12 | o_ena2_9_13;

    wire i_outena_9_11;
    wire o_ena0_9_11, o_ena1_9_11, o_ena2_9_11;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd11)) uut9_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_9_11),
        .o_data(o_data),
        .o_ena0(o_ena0_9_11),
        .o_ena1(o_ena1_9_11),
        .o_ena2(o_ena2_9_11)
    );
    assign i_outena_9_11 = o_ena0_10_12 | o_ena1_10_11 | o_ena2_9_12;

    wire i_outena_9_10;
    wire o_ena0_9_10, o_ena1_9_10, o_ena2_9_10;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd10)) uut9_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_9_10),
        .o_data(o_data),
        .o_ena0(o_ena0_9_10),
        .o_ena1(o_ena1_9_10),
        .o_ena2(o_ena2_9_10)
    );
    assign i_outena_9_10 = o_ena0_10_11 | o_ena1_10_10 | o_ena2_9_11;

    wire i_outena_9_9;
    wire o_ena0_9_9, o_ena1_9_9, o_ena2_9_9;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd9)) uut9_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_9_9),
        .o_data(o_data),
        .o_ena0(o_ena0_9_9),
        .o_ena1(o_ena1_9_9),
        .o_ena2(o_ena2_9_9)
    );
    assign i_outena_9_9 = o_ena0_10_10 | o_ena1_10_9 | o_ena2_9_10;

    wire i_outena_9_8;
    wire o_ena0_9_8, o_ena1_9_8, o_ena2_9_8;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd8)) uut9_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_9_8),
        .o_data(o_data),
        .o_ena0(o_ena0_9_8),
        .o_ena1(o_ena1_9_8),
        .o_ena2(o_ena2_9_8)
    );
    assign i_outena_9_8 = o_ena0_10_9 | o_ena1_10_8 | o_ena2_9_9;

    wire i_outena_9_7;
    wire o_ena0_9_7, o_ena1_9_7, o_ena2_9_7;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd7)) uut9_7(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_9_7),
        .o_data(o_data),
        .o_ena0(o_ena0_9_7),
        .o_ena1(o_ena1_9_7),
        .o_ena2(o_ena2_9_7)
    );
    assign i_outena_9_7 = o_ena0_10_8 | o_ena1_10_7 | o_ena2_9_8;

    wire i_outena_9_6;
    wire o_ena0_9_6, o_ena1_9_6, o_ena2_9_6;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd6)) uut9_6(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_9_6),
        .o_data(o_data),
        .o_ena0(o_ena0_9_6),
        .o_ena1(o_ena1_9_6),
        .o_ena2(o_ena2_9_6)
    );
    assign i_outena_9_6 = o_ena0_10_7 | o_ena1_10_6 | o_ena2_9_7;

    wire i_outena_9_5;
    wire o_ena0_9_5, o_ena1_9_5, o_ena2_9_5;
    ScoreUnit #(.TINDEX(5'd9), .RINDEX(5'd5)) uut9_5(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_9_5),
        .o_data(o_data),
        .o_ena0(o_ena0_9_5),
        .o_ena1(o_ena1_9_5)
    );
    assign i_outena_9_5 = o_ena0_10_6 | o_ena1_10_5 | o_ena2_9_6;

    wire i_outena_8_13;
    wire o_ena0_8_13, o_ena1_8_13, o_ena2_8_13;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd13)) uut8_13(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_8_13),
        .o_data(o_data),
        .o_ena0(o_ena0_8_13),
        .o_ena2(o_ena2_8_13)
    );
    assign i_outena_8_13 = o_ena0_9_14 | o_ena1_9_13;

    wire i_outena_8_12;
    wire o_ena0_8_12, o_ena1_8_12, o_ena2_8_12;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd12)) uut8_12(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_8_12),
        .o_data(o_data),
        .o_ena0(o_ena0_8_12),
        .o_ena1(o_ena1_8_12),
        .o_ena2(o_ena2_8_12)
    );
    assign i_outena_8_12 = o_ena0_9_13 | o_ena1_9_12 | o_ena2_8_13;

    wire i_outena_8_11;
    wire o_ena0_8_11, o_ena1_8_11, o_ena2_8_11;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd11)) uut8_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_8_11),
        .o_data(o_data),
        .o_ena0(o_ena0_8_11),
        .o_ena1(o_ena1_8_11),
        .o_ena2(o_ena2_8_11)
    );
    assign i_outena_8_11 = o_ena0_9_12 | o_ena1_9_11 | o_ena2_8_12;

    wire i_outena_8_10;
    wire o_ena0_8_10, o_ena1_8_10, o_ena2_8_10;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd10)) uut8_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_8_10),
        .o_data(o_data),
        .o_ena0(o_ena0_8_10),
        .o_ena1(o_ena1_8_10),
        .o_ena2(o_ena2_8_10)
    );
    assign i_outena_8_10 = o_ena0_9_11 | o_ena1_9_10 | o_ena2_8_11;

    wire i_outena_8_9;
    wire o_ena0_8_9, o_ena1_8_9, o_ena2_8_9;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd9)) uut8_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_8_9),
        .o_data(o_data),
        .o_ena0(o_ena0_8_9),
        .o_ena1(o_ena1_8_9),
        .o_ena2(o_ena2_8_9)
    );
    assign i_outena_8_9 = o_ena0_9_10 | o_ena1_9_9 | o_ena2_8_10;

    wire i_outena_8_8;
    wire o_ena0_8_8, o_ena1_8_8, o_ena2_8_8;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd8)) uut8_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_8_8),
        .o_data(o_data),
        .o_ena0(o_ena0_8_8),
        .o_ena1(o_ena1_8_8),
        .o_ena2(o_ena2_8_8)
    );
    assign i_outena_8_8 = o_ena0_9_9 | o_ena1_9_8 | o_ena2_8_9;

    wire i_outena_8_7;
    wire o_ena0_8_7, o_ena1_8_7, o_ena2_8_7;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd7)) uut8_7(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_8_7),
        .o_data(o_data),
        .o_ena0(o_ena0_8_7),
        .o_ena1(o_ena1_8_7),
        .o_ena2(o_ena2_8_7)
    );
    assign i_outena_8_7 = o_ena0_9_8 | o_ena1_9_7 | o_ena2_8_8;

    wire i_outena_8_6;
    wire o_ena0_8_6, o_ena1_8_6, o_ena2_8_6;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd6)) uut8_6(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_8_6),
        .o_data(o_data),
        .o_ena0(o_ena0_8_6),
        .o_ena1(o_ena1_8_6),
        .o_ena2(o_ena2_8_6)
    );
    assign i_outena_8_6 = o_ena0_9_7 | o_ena1_9_6 | o_ena2_8_7;

    wire i_outena_8_5;
    wire o_ena0_8_5, o_ena1_8_5, o_ena2_8_5;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd5)) uut8_5(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_8_5),
        .o_data(o_data),
        .o_ena0(o_ena0_8_5),
        .o_ena1(o_ena1_8_5),
        .o_ena2(o_ena2_8_5)
    );
    assign i_outena_8_5 = o_ena0_9_6 | o_ena1_9_5 | o_ena2_8_6;

    wire i_outena_8_4;
    wire o_ena0_8_4, o_ena1_8_4, o_ena2_8_4;
    ScoreUnit #(.TINDEX(5'd8), .RINDEX(5'd4)) uut8_4(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_8_4),
        .o_data(o_data),
        .o_ena1(o_ena1_8_4)
    );
    assign i_outena_8_4 = o_ena0_9_5 | o_ena2_8_5;

    wire i_outena_7_12;
    wire o_ena0_7_12, o_ena1_7_12, o_ena2_7_12;
    ScoreUnit #(.TINDEX(5'd7), .RINDEX(5'd12)) uut7_12(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_7_12),
        .o_data(o_data),
        .o_ena0(o_ena0_7_12),
        .o_ena2(o_ena2_7_12)
    );
    assign i_outena_7_12 = o_ena0_8_13 | o_ena1_8_12;

    wire i_outena_7_11;
    wire o_ena0_7_11, o_ena1_7_11, o_ena2_7_11;
    ScoreUnit #(.TINDEX(5'd7), .RINDEX(5'd11)) uut7_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_7_11),
        .o_data(o_data),
        .o_ena0(o_ena0_7_11),
        .o_ena1(o_ena1_7_11),
        .o_ena2(o_ena2_7_11)
    );
    assign i_outena_7_11 = o_ena0_8_12 | o_ena1_8_11 | o_ena2_7_12;

    wire i_outena_7_10;
    wire o_ena0_7_10, o_ena1_7_10, o_ena2_7_10;
    ScoreUnit #(.TINDEX(5'd7), .RINDEX(5'd10)) uut7_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_7_10),
        .o_data(o_data),
        .o_ena0(o_ena0_7_10),
        .o_ena1(o_ena1_7_10),
        .o_ena2(o_ena2_7_10)
    );
    assign i_outena_7_10 = o_ena0_8_11 | o_ena1_8_10 | o_ena2_7_11;

    wire i_outena_7_9;
    wire o_ena0_7_9, o_ena1_7_9, o_ena2_7_9;
    ScoreUnit #(.TINDEX(5'd7), .RINDEX(5'd9)) uut7_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_7_9),
        .o_data(o_data),
        .o_ena0(o_ena0_7_9),
        .o_ena1(o_ena1_7_9),
        .o_ena2(o_ena2_7_9)
    );
    assign i_outena_7_9 = o_ena0_8_10 | o_ena1_8_9 | o_ena2_7_10;

    wire i_outena_7_8;
    wire o_ena0_7_8, o_ena1_7_8, o_ena2_7_8;
    ScoreUnit #(.TINDEX(5'd7), .RINDEX(5'd8)) uut7_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_7_8),
        .o_data(o_data),
        .o_ena0(o_ena0_7_8),
        .o_ena1(o_ena1_7_8),
        .o_ena2(o_ena2_7_8)
    );
    assign i_outena_7_8 = o_ena0_8_9 | o_ena1_8_8 | o_ena2_7_9;

    wire i_outena_7_7;
    wire o_ena0_7_7, o_ena1_7_7, o_ena2_7_7;
    ScoreUnit #(.TINDEX(5'd7), .RINDEX(5'd7)) uut7_7(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_7_7),
        .o_data(o_data),
        .o_ena0(o_ena0_7_7),
        .o_ena1(o_ena1_7_7),
        .o_ena2(o_ena2_7_7)
    );
    assign i_outena_7_7 = o_ena0_8_8 | o_ena1_8_7 | o_ena2_7_8;

    wire i_outena_7_6;
    wire o_ena0_7_6, o_ena1_7_6, o_ena2_7_6;
    ScoreUnit #(.TINDEX(5'd7), .RINDEX(5'd6)) uut7_6(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_7_6),
        .o_data(o_data),
        .o_ena0(o_ena0_7_6),
        .o_ena1(o_ena1_7_6),
        .o_ena2(o_ena2_7_6)
    );
    assign i_outena_7_6 = o_ena0_8_7 | o_ena1_8_6 | o_ena2_7_7;

    wire i_outena_7_5;
    wire o_ena0_7_5, o_ena1_7_5, o_ena2_7_5;
    ScoreUnit #(.TINDEX(5'd7), .RINDEX(5'd5)) uut7_5(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_7_5),
        .o_data(o_data),
        .o_ena0(o_ena0_7_5),
        .o_ena1(o_ena1_7_5),
        .o_ena2(o_ena2_7_5)
    );
    assign i_outena_7_5 = o_ena0_8_6 | o_ena1_8_5 | o_ena2_7_6;

    wire i_outena_7_4;
    wire o_ena0_7_4, o_ena1_7_4, o_ena2_7_4;
    ScoreUnit #(.TINDEX(5'd7), .RINDEX(5'd4)) uut7_4(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_7_4),
        .o_data(o_data),
        .o_ena0(o_ena0_7_4),
        .o_ena1(o_ena1_7_4)
    );
    assign i_outena_7_4 = o_ena0_8_5 | o_ena1_8_4 | o_ena2_7_5;

    wire i_outena_6_11;
    wire o_ena0_6_11, o_ena1_6_11, o_ena2_6_11;
    ScoreUnit #(.TINDEX(5'd6), .RINDEX(5'd11)) uut6_11(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_6_11),
        .o_data(o_data),
        .o_ena0(o_ena0_6_11),
        .o_ena2(o_ena2_6_11)
    );
    assign i_outena_6_11 = o_ena0_7_12 | o_ena1_7_11;

    wire i_outena_6_10;
    wire o_ena0_6_10, o_ena1_6_10, o_ena2_6_10;
    ScoreUnit #(.TINDEX(5'd6), .RINDEX(5'd10)) uut6_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_6_10),
        .o_data(o_data),
        .o_ena0(o_ena0_6_10),
        .o_ena1(o_ena1_6_10),
        .o_ena2(o_ena2_6_10)
    );
    assign i_outena_6_10 = o_ena0_7_11 | o_ena1_7_10 | o_ena2_6_11;

    wire i_outena_6_9;
    wire o_ena0_6_9, o_ena1_6_9, o_ena2_6_9;
    ScoreUnit #(.TINDEX(5'd6), .RINDEX(5'd9)) uut6_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_6_9),
        .o_data(o_data),
        .o_ena0(o_ena0_6_9),
        .o_ena1(o_ena1_6_9),
        .o_ena2(o_ena2_6_9)
    );
    assign i_outena_6_9 = o_ena0_7_10 | o_ena1_7_9 | o_ena2_6_10;

    wire i_outena_6_8;
    wire o_ena0_6_8, o_ena1_6_8, o_ena2_6_8;
    ScoreUnit #(.TINDEX(5'd6), .RINDEX(5'd8)) uut6_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_6_8),
        .o_data(o_data),
        .o_ena0(o_ena0_6_8),
        .o_ena1(o_ena1_6_8),
        .o_ena2(o_ena2_6_8)
    );
    assign i_outena_6_8 = o_ena0_7_9 | o_ena1_7_8 | o_ena2_6_9;

    wire i_outena_6_7;
    wire o_ena0_6_7, o_ena1_6_7, o_ena2_6_7;
    ScoreUnit #(.TINDEX(5'd6), .RINDEX(5'd7)) uut6_7(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_6_7),
        .o_data(o_data),
        .o_ena0(o_ena0_6_7),
        .o_ena1(o_ena1_6_7),
        .o_ena2(o_ena2_6_7)
    );
    assign i_outena_6_7 = o_ena0_7_8 | o_ena1_7_7 | o_ena2_6_8;

    wire i_outena_6_6;
    wire o_ena0_6_6, o_ena1_6_6, o_ena2_6_6;
    ScoreUnit #(.TINDEX(5'd6), .RINDEX(5'd6)) uut6_6(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_6_6),
        .o_data(o_data),
        .o_ena0(o_ena0_6_6),
        .o_ena1(o_ena1_6_6),
        .o_ena2(o_ena2_6_6)
    );
    assign i_outena_6_6 = o_ena0_7_7 | o_ena1_7_6 | o_ena2_6_7;

    wire i_outena_6_5;
    wire o_ena0_6_5, o_ena1_6_5, o_ena2_6_5;
    ScoreUnit #(.TINDEX(5'd6), .RINDEX(5'd5)) uut6_5(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_6_5),
        .o_data(o_data),
        .o_ena0(o_ena0_6_5),
        .o_ena1(o_ena1_6_5),
        .o_ena2(o_ena2_6_5)
    );
    assign i_outena_6_5 = o_ena0_7_6 | o_ena1_7_5 | o_ena2_6_6;

    wire i_outena_6_4;
    wire o_ena0_6_4, o_ena1_6_4, o_ena2_6_4;
    ScoreUnit #(.TINDEX(5'd6), .RINDEX(5'd4)) uut6_4(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_6_4),
        .o_data(o_data),
        .o_ena0(o_ena0_6_4),
        .o_ena1(o_ena1_6_4),
        .o_ena2(o_ena2_6_4)
    );
    assign i_outena_6_4 = o_ena0_7_5 | o_ena1_7_4 | o_ena2_6_5;

    wire i_outena_6_3;
    wire o_ena0_6_3, o_ena1_6_3, o_ena2_6_3;
    ScoreUnit #(.TINDEX(5'd6), .RINDEX(5'd3)) uut6_3(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_6_3),
        .o_data(o_data),
        .o_ena0(o_ena0_6_3),
        .o_ena1(o_ena1_6_3)
    );
    assign i_outena_6_3 = o_ena0_7_4 | o_ena2_6_4;

    wire i_outena_5_10;
    wire o_ena0_5_10, o_ena1_5_10, o_ena2_5_10;
    ScoreUnit #(.TINDEX(5'd5), .RINDEX(5'd10)) uut5_10(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_5_10),
        .o_data(o_data),
        .o_ena2(o_ena2_5_10)
    );
    assign i_outena_5_10 = o_ena0_6_11 | o_ena1_6_10;

    wire i_outena_5_9;
    wire o_ena0_5_9, o_ena1_5_9, o_ena2_5_9;
    ScoreUnit #(.TINDEX(5'd5), .RINDEX(5'd9)) uut5_9(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_5_9),
        .o_data(o_data),
        .o_ena0(o_ena0_5_9),
        .o_ena2(o_ena2_5_9)
    );
    assign i_outena_5_9 = o_ena0_6_10 | o_ena1_6_9 | o_ena2_5_10;

    wire i_outena_5_8;
    wire o_ena0_5_8, o_ena1_5_8, o_ena2_5_8;
    ScoreUnit #(.TINDEX(5'd5), .RINDEX(5'd8)) uut5_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_5_8),
        .o_data(o_data),
        .o_ena0(o_ena0_5_8),
        .o_ena1(o_ena1_5_8),
        .o_ena2(o_ena2_5_8)
    );
    assign i_outena_5_8 = o_ena0_6_9 | o_ena1_6_8 | o_ena2_5_9;

    wire i_outena_5_7;
    wire o_ena0_5_7, o_ena1_5_7, o_ena2_5_7;
    ScoreUnit #(.TINDEX(5'd5), .RINDEX(5'd7)) uut5_7(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_5_7),
        .o_data(o_data),
        .o_ena0(o_ena0_5_7),
        .o_ena1(o_ena1_5_7),
        .o_ena2(o_ena2_5_7)
    );
    assign i_outena_5_7 = o_ena0_6_8 | o_ena1_6_7 | o_ena2_5_8;

    wire i_outena_5_6;
    wire o_ena0_5_6, o_ena1_5_6, o_ena2_5_6;
    ScoreUnit #(.TINDEX(5'd5), .RINDEX(5'd6)) uut5_6(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_5_6),
        .o_data(o_data),
        .o_ena0(o_ena0_5_6),
        .o_ena1(o_ena1_5_6),
        .o_ena2(o_ena2_5_6)
    );
    assign i_outena_5_6 = o_ena0_6_7 | o_ena1_6_6 | o_ena2_5_7;

    wire i_outena_5_5;
    wire o_ena0_5_5, o_ena1_5_5, o_ena2_5_5;
    ScoreUnit #(.TINDEX(5'd5), .RINDEX(5'd5)) uut5_5(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_5_5),
        .o_data(o_data),
        .o_ena0(o_ena0_5_5),
        .o_ena1(o_ena1_5_5),
        .o_ena2(o_ena2_5_5)
    );
    assign i_outena_5_5 = o_ena0_6_6 | o_ena1_6_5 | o_ena2_5_6;

    wire i_outena_5_4;
    wire o_ena0_5_4, o_ena1_5_4, o_ena2_5_4;
    ScoreUnit #(.TINDEX(5'd5), .RINDEX(5'd4)) uut5_4(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_5_4),
        .o_data(o_data),
        .o_ena0(o_ena0_5_4),
        .o_ena1(o_ena1_5_4),
        .o_ena2(o_ena2_5_4)
    );
    assign i_outena_5_4 = o_ena0_6_5 | o_ena1_6_4 | o_ena2_5_5;

    wire i_outena_5_3;
    wire o_ena0_5_3, o_ena1_5_3, o_ena2_5_3;
    ScoreUnit #(.TINDEX(5'd5), .RINDEX(5'd3)) uut5_3(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_5_3),
        .o_data(o_data),
        .o_ena0(o_ena0_5_3),
        .o_ena1(o_ena1_5_3),
        .o_ena2(o_ena2_5_3)
    );
    assign i_outena_5_3 = o_ena0_6_4 | o_ena1_6_3 | o_ena2_5_4;

    wire i_outena_5_2;
    wire o_ena0_5_2, o_ena1_5_2, o_ena2_5_2;
    ScoreUnit #(.TINDEX(5'd5), .RINDEX(5'd2)) uut5_2(
        .clk(clk),
        .nrst(nrst),

        .D(D_5),
        .i_path(i_path_5),
        .i_tindex(i_tindex_5),
        .i_rindex(i_rindex_5),

        .i_outena(i_outena_5_2),
        .o_data(o_data),
        .o_ena1(o_ena1_5_2)
    );
    assign i_outena_5_2 = o_ena0_6_3 | o_ena2_5_3;

    wire i_outena_4_8;
    wire o_ena0_4_8, o_ena1_4_8, o_ena2_4_8;
    ScoreUnit #(.TINDEX(5'd4), .RINDEX(5'd8)) uut4_8(
        .clk(clk),
        .nrst(nrst),

        .D(D_1),
        .i_path(i_path_1),
        .i_tindex(i_tindex_1),
        .i_rindex(i_rindex_1),

        .i_outena(i_outena_4_8),
        .o_data(o_data),
        .o_ena2(o_ena2_4_8)
    );
    assign i_outena_4_8 = o_ena0_5_9 | o_ena1_5_8;

    wire i_outena_4_7;
    wire o_ena0_4_7, o_ena1_4_7, o_ena2_4_7;
    ScoreUnit #(.TINDEX(5'd4), .RINDEX(5'd7)) uut4_7(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_4_7),
        .o_data(o_data),
        .o_ena0(o_ena0_4_7),
        .o_ena2(o_ena2_4_7)
    );
    assign i_outena_4_7 = o_ena0_5_8 | o_ena1_5_7 | o_ena2_4_8;

    wire i_outena_4_6;
    wire o_ena0_4_6, o_ena1_4_6, o_ena2_4_6;
    ScoreUnit #(.TINDEX(5'd4), .RINDEX(5'd6)) uut4_6(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_4_6),
        .o_data(o_data),
        .o_ena0(o_ena0_4_6),
        .o_ena1(o_ena1_4_6),
        .o_ena2(o_ena2_4_6)
    );
    assign i_outena_4_6 = o_ena0_5_7 | o_ena1_5_6 | o_ena2_4_7;

    wire i_outena_4_5;
    wire o_ena0_4_5, o_ena1_4_5, o_ena2_4_5;
    ScoreUnit #(.TINDEX(5'd4), .RINDEX(5'd5)) uut4_5(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_4_5),
        .o_data(o_data),
        .o_ena0(o_ena0_4_5),
        .o_ena1(o_ena1_4_5),
        .o_ena2(o_ena2_4_5)
    );
    assign i_outena_4_5 = o_ena0_5_6 | o_ena1_5_5 | o_ena2_4_6;

    wire i_outena_4_4;
    wire o_ena0_4_4, o_ena1_4_4, o_ena2_4_4;
    ScoreUnit #(.TINDEX(5'd4), .RINDEX(5'd4)) uut4_4(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_4_4),
        .o_data(o_data),
        .o_ena0(o_ena0_4_4),
        .o_ena1(o_ena1_4_4),
        .o_ena2(o_ena2_4_4)
    );
    assign i_outena_4_4 = o_ena0_5_5 | o_ena1_5_4 | o_ena2_4_5;

    wire i_outena_4_3;
    wire o_ena0_4_3, o_ena1_4_3, o_ena2_4_3;
    ScoreUnit #(.TINDEX(5'd4), .RINDEX(5'd3)) uut4_3(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_4_3),
        .o_data(o_data),
        .o_ena0(o_ena0_4_3),
        .o_ena1(o_ena1_4_3),
        .o_ena2(o_ena2_4_3)
    );
    assign i_outena_4_3 = o_ena0_5_4 | o_ena1_5_3 | o_ena2_4_4;

    wire i_outena_4_2;
    wire o_ena0_4_2, o_ena1_4_2, o_ena2_4_2;
    ScoreUnit #(.TINDEX(5'd4), .RINDEX(5'd2)) uut4_2(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_4_2),
        .o_data(o_data),
        .o_ena0(o_ena0_4_2),
        .o_ena1(o_ena1_4_2)
    );
    assign i_outena_4_2 = o_ena0_5_3 | o_ena1_5_2 | o_ena2_4_3;

    wire i_outena_3_6;
    wire o_ena0_3_6, o_ena1_3_6, o_ena2_3_6;
    ScoreUnit #(.TINDEX(5'd3), .RINDEX(5'd6)) uut3_6(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_3_6),
        .o_data(o_data),
        .o_ena0(o_ena0_3_6),
        .o_ena2(o_ena2_3_6)
    );
    assign i_outena_3_6 = o_ena0_4_7 | o_ena1_4_6;

    wire i_outena_3_5;
    wire o_ena0_3_5, o_ena1_3_5, o_ena2_3_5;
    ScoreUnit #(.TINDEX(5'd3), .RINDEX(5'd5)) uut3_5(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_3_5),
        .o_data(o_data),
        .o_ena0(o_ena0_3_5),
        .o_ena1(o_ena1_3_5),
        .o_ena2(o_ena2_3_5)
    );
    assign i_outena_3_5 = o_ena0_4_6 | o_ena1_4_5 | o_ena2_3_6;

    wire i_outena_3_4;
    wire o_ena0_3_4, o_ena1_3_4, o_ena2_3_4;
    ScoreUnit #(.TINDEX(5'd3), .RINDEX(5'd4)) uut3_4(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_3_4),
        .o_data(o_data),
        .o_ena0(o_ena0_3_4),
        .o_ena1(o_ena1_3_4),
        .o_ena2(o_ena2_3_4)
    );
    assign i_outena_3_4 = o_ena0_4_5 | o_ena1_4_4 | o_ena2_3_5;

    wire i_outena_3_3;
    wire o_ena0_3_3, o_ena1_3_3, o_ena2_3_3;
    ScoreUnit #(.TINDEX(5'd3), .RINDEX(5'd3)) uut3_3(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_3_3),
        .o_data(o_data),
        .o_ena0(o_ena0_3_3),
        .o_ena1(o_ena1_3_3),
        .o_ena2(o_ena2_3_3)
    );
    assign i_outena_3_3 = o_ena0_4_4 | o_ena1_4_3 | o_ena2_3_4;

    wire i_outena_3_2;
    wire o_ena0_3_2, o_ena1_3_2, o_ena2_3_2;
    ScoreUnit #(.TINDEX(5'd3), .RINDEX(5'd2)) uut3_2(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_3_2),
        .o_data(o_data),
        .o_ena0(o_ena0_3_2),
        .o_ena1(o_ena1_3_2),
        .o_ena2(o_ena2_3_2)
    );
    assign i_outena_3_2 = o_ena0_4_3 | o_ena1_4_2 | o_ena2_3_3;

    wire i_outena_3_1;
    wire o_ena0_3_1, o_ena1_3_1, o_ena2_3_1;
    ScoreUnit #(.TINDEX(5'd3), .RINDEX(5'd1)) uut3_1(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_3_1),
        .o_data(o_data),
        .o_ena1(o_ena1_3_1)
    );
    assign i_outena_3_1 = o_ena0_4_2 | o_ena2_3_2;

    wire i_outena_2_5;
    wire o_ena0_2_5, o_ena1_2_5, o_ena2_2_5;
    ScoreUnit #(.TINDEX(5'd2), .RINDEX(5'd5)) uut2_5(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_2_5),
        .o_data(o_data),
        .o_ena2(o_ena2_2_5)
    );
    assign i_outena_2_5 = o_ena0_3_6 | o_ena1_3_5;

    wire i_outena_2_4;
    wire o_ena0_2_4, o_ena1_2_4, o_ena2_2_4;
    ScoreUnit #(.TINDEX(5'd2), .RINDEX(5'd4)) uut2_4(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_2_4),
        .o_data(o_data),
        .o_ena0(o_ena0_2_4),
        .o_ena2(o_ena2_2_4)
    );
    assign i_outena_2_4 = o_ena0_3_5 | o_ena1_3_4 | o_ena2_2_5;

    wire i_outena_2_3;
    wire o_ena0_2_3, o_ena1_2_3, o_ena2_2_3;
    ScoreUnit #(.TINDEX(5'd2), .RINDEX(5'd3)) uut2_3(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_2_3),
        .o_data(o_data),
        .o_ena0(o_ena0_2_3),
        .o_ena1(o_ena1_2_3),
        .o_ena2(o_ena2_2_3)
    );
    assign i_outena_2_3 = o_ena0_3_4 | o_ena1_3_3 | o_ena2_2_4;

    wire i_outena_2_2;
    wire o_ena0_2_2, o_ena1_2_2, o_ena2_2_2;
    ScoreUnit #(.TINDEX(5'd2), .RINDEX(5'd2)) uut2_2(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_2_2),
        .o_data(o_data),
        .o_ena0(o_ena0_2_2),
        .o_ena1(o_ena1_2_2),
        .o_ena2(o_ena2_2_2)
    );
    assign i_outena_2_2 = o_ena0_3_3 | o_ena1_3_2 | o_ena2_2_3;

    wire i_outena_2_1;
    wire o_ena0_2_1, o_ena1_2_1, o_ena2_2_1;
    ScoreUnit #(.TINDEX(5'd2), .RINDEX(5'd1)) uut2_1(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_2_1),
        .o_data(o_data),
        .o_ena0(o_ena0_2_1),
        .o_ena1(o_ena1_2_1)
    );
    assign i_outena_2_1 = o_ena0_3_2 | o_ena1_3_1 | o_ena2_2_2;

    wire i_outena_1_3;
    wire o_ena0_1_3, o_ena1_1_3, o_ena2_1_3;
    ScoreUnit #(.TINDEX(5'd1), .RINDEX(5'd3)) uut1_3(
        .clk(clk),
        .nrst(nrst),

        .D(D_2),
        .i_path(i_path_2),
        .i_tindex(i_tindex_2),
        .i_rindex(i_rindex_2),

        .i_outena(i_outena_1_3),
        .o_data(o_data),
        .o_ena2(o_ena2_1_3)
    );
    assign i_outena_1_3 = o_ena0_2_4 | o_ena1_2_3;

    wire i_outena_1_2;
    wire o_ena0_1_2, o_ena1_1_2, o_ena2_1_2;
    ScoreUnit #(.TINDEX(5'd1), .RINDEX(5'd2)) uut1_2(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_1_2),
        .o_data(o_data),
        .o_ena0(o_ena0_1_2),
        .o_ena2(o_ena2_1_2)
    );
    assign i_outena_1_2 = o_ena0_2_3 | o_ena1_2_2 | o_ena2_1_3;

    wire i_outena_1_1;
    wire o_ena0_1_1, o_ena1_1_1, o_ena2_1_1;
    ScoreUnit #(.TINDEX(5'd1), .RINDEX(5'd1)) uut1_1(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_1_1),
        .o_data(o_data),
        .o_ena0(o_ena0_1_1),
        .o_ena1(o_ena1_1_1),
        .o_ena2(o_ena2_1_1)
    );
    assign i_outena_1_1 = o_ena0_2_2 | o_ena1_2_1 | o_ena2_1_2;

    wire i_outena_1_0;
    wire o_ena0_1_0, o_ena1_1_0, o_ena2_1_0;
    ScoreUnit #(.TINDEX(5'd1), .RINDEX(5'd0)) uut1_0(
        .clk(clk),
        .nrst(nrst),

        .D(D_4),
        .i_path(i_path_4),
        .i_tindex(i_tindex_4),
        .i_rindex(i_rindex_4),

        .i_outena(i_outena_1_0),
        .o_data(o_data),
        .o_ena1(o_ena1_1_0)
    );
    assign i_outena_1_0 = o_ena0_2_1 | o_ena2_1_1;

    wire i_outena_0_1;
    wire o_ena0_0_1, o_ena1_0_1, o_ena2_0_1;
    ScoreUnit #(.TINDEX(5'd0), .RINDEX(5'd1)) uut0_1(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_0_1),
        .o_data(o_data),
        .o_ena2(o_ena2_0_1)
    );
    assign i_outena_0_1 = o_ena0_1_2 | o_ena1_1_1;

    wire i_outena_0_0;
    wire o_ena0_0_0, o_ena1_0_0, o_ena2_0_0;
    ScoreUnit #(.TINDEX(5'd0), .RINDEX(5'd0)) uut0_0(
        .clk(clk),
        .nrst(nrst),

        .D(D_3),
        .i_path(i_path_3),
        .i_tindex(i_tindex_3),
        .i_rindex(i_rindex_3),

        .i_outena(i_outena_0_0),
        .o_data(o_data),
        .o_ena0(o_ena0_0_0)
    );
    assign i_outena_0_0 = o_ena0_1_1 | o_ena1_1_0 | o_ena2_0_1;

    assign o_bt_end = o_ena0_0_0 | o_ena1_0_0 | o_ena2_0_0;

endmodule