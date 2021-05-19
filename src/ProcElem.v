module ProcElem(
    input   wire    clk,
    input   wire    nrst,
    input   wire    ena,

    input   wire    [15:0]  D0,
    input   wire    [15:0]  D1,
    input   wire    [15:0]  D2,

    input   wire    [29:0]  T_prev,
    input   wire    [29:0]  T_global,
    input   wire    [4:0]   i_tindex_prev,
    input   wire    [4:0]   i_tindex_global,
    input   wire    [1:0]   i_tsrc,

    input   wire    [29:0]  R_prev,
    input   wire    [29:0]  R_global,
    input   wire    [4:0]   i_rindex_prev,
    input   wire    [4:0]   i_rindex_global,
    input   wire    [1:0]   i_rsrc,

    output  reg     [29:0]  T,
    output  reg     [4:0]   o_tindex,
    output  reg     [29:0]  R,
    output  reg     [4:0]   o_rindex,
    output  reg     [15:0]  D,
    output  reg     [1:0]   o_path
);

    localparam PATH0 = 2'b11; // (i-1,j-1)
    localparam PATH1 = 2'b10; // (i-1,j)
    localparam PATH2 = 2'b01; // (i,j-1)
    localparam PATH_RST = 2'b00;

    // 加载数据
    always @ (posedge clk or negedge nrst) begin
        if (~nrst | ~ena) begin
            T <= 30'd0;
        end
        else begin
            if (i_tsrc == 2'd1) begin
                T <= T_prev;
                o_tindex <= i_tindex_prev;
            end
            else if (i_tsrc == 2'd2) begin
                T <= T_global;
                o_tindex <= i_tindex_global;
            end
        end
    end
    always @ (posedge clk or negedge nrst) begin
        if (~nrst | ~ena) begin
            R <= 30'd0;
        end
        else begin
            if (i_rsrc == 2'd1) begin
                R <= R_prev;
                o_rindex <= i_rindex_prev;
            end
            else if (i_rsrc == 2'd2) begin
                R <= R_global;
                o_rindex <= i_rindex_global;
            end
        end
    end

    // 绝对值部分
    reg [9:0] v0_R;
    reg [9:0] v1_R;
    reg [9:0] v2_R;
    reg [9:0] v0_T;
    reg [9:0] v1_T;
    reg [9:0] v2_T;
    reg [10:0] mediant0;
    reg [10:0] mediant1;
    reg [10:0] mediant2;
    reg [10:0] abs0;
    reg [10:0] abs1;
    reg [10:0] abs2;
    reg [12:0] D_abs;

    always @ (*) begin
        v0_R = R[29:20];
        v1_R = R[19:10];
        v2_R = R[ 9: 0];
        v0_T = T[29:20];
        v1_T = T[19:10];
        v2_T = T[ 9: 0]; // 取相反数需要扩展符号位
        // 扩展一个符号位再相减，防止溢出
        mediant0 = {v0_R[9],v0_R} - {v0_T[9],v0_T}; 
        mediant1 = {v1_R[9],v1_R} - {v1_T[9],v1_T};
        mediant2 = {v2_R[9],v2_R} - {v2_T[9],v2_T};

        // 计算绝对值
        if (mediant0[10])
            abs0 = 1 + (~mediant0[9:0]);
        else
            abs0 = mediant0;

        if (mediant1[10])
            abs1 = 1 + (~mediant1[9:0]);
        else
            abs1 = mediant1;

        if (mediant2[10])
            abs2 = 1 + (~mediant2[9:0]);
        else
            abs2 = mediant2;

        // 求和
            D_abs = abs0 + abs1 + abs2;
    end

    // 最小值部分
    reg [15:0] D_min;
    reg path_t, t1, t2, t3; // temp

    always @ (*) begin
        t1 = D0 < D1;
        t2 = D1 < D2;
        t3 = D2 < D0;

        if (t1 & ~t3) begin // min = D0
            D_min = D0;
            path_t = PATH0;
        end
        else if (t2 & ~t1) begin // min = D1
            D_min = D1;
            path_t = PATH1;
        end
        else begin // min = D2
            D_min = D2;
            path_t = PATH2;
        end
    end

    // 输出距离和路径
    always @ (*) begin
        D = D_abs + D_min;
        o_path = path_t;
    end

endmodule
