module ScoreUnit(
    input   wire    clk,
    input   wire    nrst,

    input   wire    [15:0]  D,
    input   wire    [1:0]   i_path,
    input   wire    [4:0]   i_tindex,
    input   wire    [4:0]   i_rindex,

    input   wire    i_outena,   // 高有效，控制输出本地数据至SRAM
    inout   wire    [31:0]  o_data, // 三态门，输出本地数据至SRAM
    output  reg     o_ena0,     // 高有效，控制(i-1,j-1)的输出
    output  reg     o_ena1,     // 高有效，控制(i-1,j)的输出
    output  reg     o_ena2      // 高有效，控制(i,j-1)的输出
);

    parameter TINDEX = 5'd31; // invalid
    parameter RINDEX = 5'd31; // invalid

    localparam PATH0 = 2'b11; // (i-1,j-1)
    localparam PATH1 = 2'b10; // (i-1,j)
    localparam PATH2 = 2'b01; // (i,j-1)
    localparam PATH_RST = 2'b00;

    reg [15:0] _D; // for debug
    reg [31:0] data;
    reg [1:0] path; // 记录上一个位置，= p0/p1/p2

    // 写入SRAM
    assign o_data = i_outena ? data : 32'bz;

    // 存储计算结果
    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            path <= PATH_RST;
        end
        else begin
            if (i_tindex == TINDEX && i_rindex == RINDEX) begin
                _D <= D;
                data <= {3'b0, TINDEX, 3'b0, RINDEX, D};
                path <= i_path;
            end
        end
    end

    // 路径回溯
    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            o_ena0 <= 1'b0;
            o_ena1 <= 1'b0;
            o_ena2 <= 1'b0;
        end
        else begin
            {o_ena0, o_ena1, o_ena2} <= 3'b0;
            if (i_outena) begin
                case (path)
                    PATH0: o_ena0 <= 1'b1;
                    PATH1: o_ena1 <= 1'b1;
                    PATH2: o_ena2 <= 1'b1;
                endcase
            end
        end
    end

endmodule
