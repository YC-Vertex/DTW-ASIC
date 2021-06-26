`include "ProcElem.v"

module SystArr(
    input   wire    clk,
    input   wire    nrst,
    input   wire    ena,

    input   wire    [29:0]  T,
    input   wire    [11:0]  i_tsrc,

    input   wire    [29:0]  R,
    input   wire    [11:0]  i_rsrc,

    input   wire    [95:0]  D0,
    input   wire    [95:0]  D1,
    input   wire    [95:0]  D2,

    output  wire    [95:0]  D,
    output  wire    [11:0]  o_path
);

    // T序列 6 -> 5 -> ... -> 1
    wire [179:0] T_in;
    wire [179:0] T_out;
    assign T_in = {T_out[149:0], 30'd0};

    // R序列 1 -> 2 -> ... -> 6
    wire [179:0] R_in;
    wire [179:0] R_out;
    assign R_in = {30'd0, R_out[179:30]};

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
            wire [29:0] _T_pe;
            wire [29:0] _R_pe;
            wire [1:0] _tsrc;
            wire [1:0] _rsrc;
            assign _T_pe = T_in[179-i*30 : 150-i*30];
            assign _R_pe = R_in[179-i*30 : 150-i*30];
            assign _tsrc = i_tsrc[11-i*2 : 10-i*2];
            assign _rsrc = i_rsrc[11-i*2 : 10-i*2];
            
            // PE输出：至相邻PE
            wire [29:0] _T;
            wire [29:0] _R;
            assign T_out[179-i*30 : 150-i*30] = _T;
            assign R_out[179-i*30 : 150-i*30] = _R;

            // PE输出：结果
            wire [15:0] _D;
            wire [1:0] _path;
            assign D[95-i*16 : 80-i*16] = _D;
            assign o_path[11-i*2 : 10-i*2] = _path;

            // 实例化PE
            ProcElem pe(
                .clk(clk), .nrst(nrst), .ena(ena),
                .D0(_D0), .D1(_D1), .D2(_D2),
                .T_pe(_T_pe), .T_ext(T), .i_tsrc(_tsrc),
                .R_pe(_R_pe), .R_ext(R), .i_rsrc(_rsrc),
                .T(_T), .R(_R),
                .D(_D), .o_path(_path)
            );
        end
    endgenerate

endmodule
