module ProcElem(
    input   wire    clk,
    input   wire    nrst,
    input   wire    ena,

    input   wire    [15:0]  D0,
    input   wire    [15:0]  D1,
    input   wire    [15:0]  D2,

    input   wire    [29:0]  T_pe,
    input   wire    [29:0]  T_ext,
    input   wire    [1:0]   i_tsrc,

    input   wire    [29:0]  R_pe,
    input   wire    [29:0]  R_ext,
    input   wire    [1:0]   i_rsrc,

    output  reg     [29:0]  T,
    output  reg     [29:0]  R,
    
    output  reg     [15:0]  D,
    output  reg     [1:0]   o_path
);

    localparam PATH0 = 2'b11; // (i-1,j-1)
    localparam PATH1 = 2'b10; // (i-1,j)
    localparam PATH2 = 2'b01; // (i,j-1)
    localparam PATH_RST = 2'b00;

    reg [29:0] T_rt;
    reg [29:0] R_rt;

    // 加载数据
    always @ (*) begin
        case (i_tsrc)
            2'd0: T_rt = T;
            2'd1: T_rt = T_pe;
            2'd2: T_rt = T_ext;
			default: T_rt = 30'b0;
        endcase
    end
    always @ (*) begin
        case (i_rsrc)
            2'd0: R_rt = R;
            2'd1: R_rt = R_pe;
            2'd2: R_rt = R_ext;
			default: R_rt = 30'b0;
        endcase
    end
    // 加载数据（同步）
    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            T <= 30'd0;
            R <= 30'd0;
        end
        else begin
            if (~nrst) begin
                T <= 30'd0;
                R <= 30'd0;
            end
            else begin
                T <= T_rt;
                R <= R_rt;
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
    reg signed [10:0] mediant0;
    reg signed [10:0] mediant1;
    reg signed [10:0] mediant2;
    reg [10:0] abs0;
    reg [10:0] abs1;
    reg [10:0] abs2;
    reg [12:0] D_abs;

    always @ (*) begin
        v0_R = R_rt[29:20];
        v1_R = R_rt[19:10];
        v2_R = R_rt[ 9: 0];
        v0_T = T_rt[29:20];
        v1_T = T_rt[19:10];
        v2_T = T_rt[ 9: 0]; // 取相反数需要扩展符号位
        // 扩展一个符号位再相减，防止溢出
        mediant0 = {v0_R[9], v0_R} - {v0_T[9], v0_T}; 
        mediant1 = {v1_R[9], v1_R} - {v1_T[9], v1_T};
        mediant2 = {v2_R[9], v2_R} - {v2_T[9], v2_T};

        // 计算绝对值
        if (mediant0[10])
            abs0 = -mediant0;
        else
            abs0 = mediant0;

        if (mediant1[10])
            abs1 = -mediant1;
        else
            abs1 = mediant1;

        if (mediant2[10])
            abs2 = -mediant2;
        else
            abs2 = mediant2;

        // 求和
            D_abs = abs0 + abs1 + abs2;
    end

    // 最小值部分
    reg [15:0] D_min;
    reg t1, t2, t3; // temp
    reg [1:0] path;

    always @ (*) begin
        t1 = D0 <= D1;
        t2 = D1 <= D2;
        t3 = D2 <= D0;

        if (t1 & ~t3) begin // min = D0
            D_min = D0;
            path = PATH0;
        end
        else if (t2 & ~t1) begin // min = D1
            D_min = D1;
            path = PATH1;
        end
        else begin // min = D2
            D_min = D2;
            path = PATH2;
        end
    end

    // 输出距离和路径
    always @ (posedge clk) begin
        if (~nrst) begin
            D <= 16'd0;
            o_path <= PATH_RST;
        end
        else begin
            D <= D_abs + D_min;
            o_path <= path;
        end
    end

endmodule
