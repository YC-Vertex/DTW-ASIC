`include "ProcElem.v"

module SystArr(
    input   wire    clk,
    input   wire    nrst,
    input   wire    ena,

    input   wire    [29:0]  T,
    input   wire    [4:0]   i_tindex,
    input   wire    [11:0]  i_tsrc,

    input   wire    [29:0]  R,
    input   wire    [4:0]   i_rindex,
    input   wire    [11:0]  i_rsrc,

    input   wire    [95:0]  D0,
    input   wire    [95:0]  D1,
    input   wire    [95:0]  D2,

    output  wire    [29:0]  o_tindex,
    output  wire    [29:0]  o_rindex,
    output  wire    [95:0]  D,
    output  wire    [11:0]  o_path
);

    // T序列 6 -> 5 -> ... -> 1
    wire [179:0] T_in;
    wire [179:0] T_out;
    wire [29:0]  ti_in;
    wire [29:0]  ti_out;
    assign T_in = {T_out[149:0], 30'd0};
    assign ti_in = {ti_out[24:0], 5'd0};

    // R序列 1 -> 2 -> ... -> 6
    wire [179:0] R_in;
    wire [179:0] R_out;
    wire [29:0]  ri_in;
    wire [29:0]  ri_out;
    assign R_in = {30'd0, R_out[179:30]};
    assign ri_in = {5'd0, ri_out[29:5]};

    assign o_tindex = ti_out;
    assign o_rindex = ri_out;

    generate
        genvar i;
        for (i = 0; i < 6; i = i + 1) begin: gen_pe
            // PE输入：距离
            wire [15:0] _D0;
            wire [15:0] _D1;
            wire [15:0] _D2;
            assign _D0 = D0[95-i*16 : 80-i*16];
            assign _D1 = D1[95-i*16 : 80-i*16];
            assign _D2 = D2[95-i*16 : 80-i*16];

            // PE输入：序列
            wire [29:0] _T_prev;
            wire [29:0] _R_prev;
            wire [4:0] _ti_prev;
            wire [4:0] _ri_prev;
            wire [1:0] _tsrc;
            wire [1:0] _rsrc;
            assign _T_prev = T_in[179-i*30 : 150-i*30];
            assign _R_prev = R_in[179-i*30 : 150-i*30];
            assign _ti_prev = ti_in[29-i*5 : 25-i*5];
            assign _ri_prev = ri_in[29-i*5 : 25-i*5];
            assign _tsrc = i_tsrc[11-i*2 : 10-i*2];
            assign _rsrc = i_rsrc[11-i*2 : 10-i*2];
            
            // PE输出
            wire [29:0] _T;
            wire [29:0] _R;
            wire [4:0] _ti;
            wire [4:0] _ri;
            wire [15:0] _D;
            wire [1:0] _path;
            assign T_out[179-i*30 : 150-i*30] = _T;
            assign R_out[179-i*30 : 150-i*30] = _R;
            assign ti_out[29-i*5 : 25-i*5] = _ti;
            assign ri_out[29-i*5 : 25-i*5] = _ri;
            assign D[95-i*16 : 80-i*16] = _D;
            assign o_path[11-i*2 : 10-i*2] = _path;

            // 实例化PE
            ProcElem pe(
                clk, nrst, ena,
                _D0, _D1, _D2,
                _T_prev, T, _ti_prev, i_tindex, _tsrc,
                _R_prev, R, _ri_prev, i_rindex, _rsrc,
                _T, _ti, _R, _ri, _D, _path
            );
        end
    endgenerate

endmodule
