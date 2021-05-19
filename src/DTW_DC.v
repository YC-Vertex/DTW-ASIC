`include "SystArr.v"
`include "Cache.v"

module DTW_DC(
    input   wire    clk,
    input   wire    nrst,
    input   wire    ena,

    input   wire    [29:0]  T,
    input   wire    [4:0]   i_tindex,
    input   wire    [11:0]  i_tsrc,

    input   wire    [29:0]  R,
    input   wire    [4:0]   i_rindex,
    input   wire    [11:0]  i_rsrc,

    input   wire    [17:0]  i_sel0,
    input   wire    [17:0]  i_sel1,
    input   wire    [17:0]  i_sel2,

    output  wire    [95:0]  D,
    output  wire    [29:0]  o_tindex,
    output  wire    [29:0]  o_rindex,
    output  wire    [11:0]  o_path
);

    wire [95:0] D0;
    wire [95:0] D1;
    wire [95:0] D2;

    wire [95:0] D_1; // 一个周期前的数据
    wire [95:0] D_2; // 两个周期前的数据

    SystArr syst_arr(
        clk, nrst, ena,
        T, i_tindex, i_tsrc,
        R, i_rindex, i_rsrc,
        D0, D1, D2, D, o_tindex, o_rindex, o_path
    );
    Cache cache(clk, nrst, ena, D, D_1, D_2);

    generate
        genvar i;
        for (i = 0; i < 6; i = i + 1) begin: gen_d
            localparam div16beg = 95 - i * 16;
            localparam div16end = 80 - i * 16;
            localparam div3beg = 17 - i * 3;
            localparam div3end = 15 - i * 3;

            // 距离数据
            reg [15:0] _D0;
            reg [15:0] _D1;
            reg [15:0] _D2;
            assign D0[div16beg:div16end] = _D0;
            assign D1[div16beg:div16end] = _D1;
            assign D2[div16beg:div16end] = _D2;

            // 选通信号
            wire [2:0] _s0;
            wire [2:0] _s1;
            wire [2:0] _s2;
            assign _s0 = i_sel0[div3beg:div3end];
            assign _s1 = i_sel1[div3beg:div3end];
            assign _s2 = i_sel2[div3beg:div3end];
            
            always @ (*) begin
                case (_s0)
                    3'd0: _D0 = D_2[95:80];
                    3'd1: _D0 = D_2[79:64];
                    3'd2: _D0 = D_2[63:48];
                    3'd3: _D0 = D_2[47:32];
                    3'd4: _D0 = D_2[31:16];
                    3'd5: _D0 = D_2[15: 0];
                    3'd7: _D0 = 16'd0;
                    default: _D0 = 16'hffff;
                endcase
            end

            always @ (*) begin
                case (_s1)
                    3'd0: _D1 = D_1[95:80];
                    3'd1: _D1 = D_1[79:64];
                    3'd2: _D1 = D_1[63:48];
                    3'd3: _D1 = D_1[47:32];
                    3'd4: _D1 = D_1[31:16];
                    3'd5: _D1 = D_1[15: 0];
                    3'd7: _D1 = 16'd0;
                    default: _D1 = 16'hffff;
                endcase
            end

            always @ (*) begin
                case (_s2)
                    3'd0: _D2 = D_1[95:80];
                    3'd1: _D2 = D_1[79:64];
                    3'd2: _D2 = D_1[63:48];
                    3'd3: _D2 = D_1[47:32];
                    3'd4: _D2 = D_1[31:16];
                    3'd5: _D2 = D_1[15: 0];
                    3'd7: _D2 = 16'd0;
                    default: _D2 = 16'hffff;
                endcase
            end
        end
    endgenerate

endmodule