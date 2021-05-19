module DTW_CTRL(
    input   wire    clk,
    input   wire    nrst,
    input   wire    i_valid,
    output  wire    o_ready,

    input   wire    [31:0]  Rin,
    output  reg     [29:0]  R,

    output  reg     o_dc_ena,
    output  reg     [4:0]   o_tindex,
    output  reg     [4:0]   o_rindex,
    output  reg     [11:0]  o_tsrc,
    output  reg     [11:0]  o_rsrc,
    output  reg     [17:0]  o_sel0,
    output  reg     [17:0]  o_sel1,
    output  reg     [17:0]  o_sel2,

    output  wire    [9:0]   o_addr,
    output  wire    o_WR,
    output  wire    o_CS,

    output  reg     o_bt_ena,
    output  reg     o_bt_start,
    input   wire    o_bt_end
);

    localparam DC_END = 6'd38;

    assign o_ready = ~o_dc_ena & ~o_bt_ena;

    reg [5:0] count;

    wire [9:0] addr_dc;
    wire [9:0] addr_bt;
    assign addr_dc = {5'b0, o_tindex};
    assign addr_bt = {4'b0, count};
    assign addr = (o_dc_ena | i_valid) ? {5'b0, o_tindex} : 10'bz;

    assign o_WR = o_bt_ena & ~o_bt_start;
    assign o_CS = 1'b1;

    // DC 使能信号
    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            o_dc_ena <= 1'b0;
        end
        else begin
            if (i_valid & o_ready)
                o_dc_ena <= 1'b1;
            else if (count == DC_END)
                o_dc_ena <= 1'b0;
        end
    end

    // DC 计数信号
    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            count <= 6'd0;
        end
        else begin
            if ((o_dc_ena | i_valid) | o_bt_ena)
                count <= count + 6'd1;
            else if (o_dc_ena && count == DC_END)
                count <= 6'd19;
            else if (o_bt_ena && o_bt_end)
                count <= 6'd0;
        end
    end

    // BT 使能信号
    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            o_bt_ena <= 1'b0;
            o_bt_start <= 1'b0;
        end
        else begin
            if (count == DC_END) begin
                o_bt_ena <= 1'b1;
                o_bt_start <= 1'b1;
            end
            else if (o_bt_ena & o_bt_start) begin
                o_bt_start <= 1'b0;
            end
            else if (o_bt_end) begin
                o_bt_ena <= 1'b0;
            end
        end
    end

    // DC 输入序列暂存
    reg [599:0] R_buf;
    always @ (posedge clk) begin
        R_buf <= {R_buf[569:0], Rin[29:0]};
    end

    // DC 控制信号
    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            o_rsrc<=12'b0;      //[11:10]为第一个PE，[9:8]第二个，[7:6]为第三个，[5:4]为第四个，[3:2]为第五个，[1:0]为第六个
            o_tsrc<=12'b0;
            o_sel0<=18'b111111111111111111; //[17:15]为第一个PE,[14:12]第二个,[11:9]第三个,[8:6]第四个,[5:3]第五个,[2:0]第六个
            o_sel1<=18'b111111111111111111; 
            o_sel2<=18'b111111111111111111; //这里我给的初始状态全0，为了方便下面各个cycle改变select信号时，无关的PE编号部分我都没改，默认是全1合适，这样每个sel的都是3'd7默认读ffff
        end
        else begin
            case (count)
                // 第0周期，产生第1周期
                6'd0: begin
                    o_tsrc[7:6]<=2'd2;
                    o_rsrc[7:6]<=2'd2;
                    o_sel0[11:9]<=3'd7;
                    o_sel1[11:9]<=3'd6;
                    o_sel2[11:9]<=3'd6;
                    o_tindex<=5'd0;
                    o_rindex<=5'd0;
                    R<=R_buf[29:0];
                end

                6'd1: begin
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd2;
                    o_tsrc[5:4]<=2'd2;
                    o_rsrc[5:4]<=2'd1;
                    o_sel0[11:9]<=3'd6;
                    o_sel1[11:9]<=3'd6;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd6;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd6;
                    o_tindex<=5'd1;
                    o_rindex<=5'd1;
                    R<=R_buf[29:0];
                end

                6'd2: begin
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                end

                6'd3: begin
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd2;
                    o_tsrc[5:4]<=2'd2;
                    o_rsrc[5:4]<=2'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd6;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd6;
                    o_tindex<=5'd2;
                    o_rindex<=5'd2;
                    R<=R_buf[59:30];
                end

                6'd4: begin
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd2;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd2;
                    o_rsrc[5:4]<=2'd0;
                    o_sel0[14:12]<=3'd6;
                    o_sel1[14:12]<=3'd6;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd6;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd6;
                    o_tindex<=5'd3;
                    o_rindex<=5'd3;
                    R<=R_buf[59:30];
                end

                6'd5: begin
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                end

                6'd6: begin
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd2;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd2;
                    o_rsrc[5:4]<=2'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd6;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd6;
                    o_tindex<=5'd4;
                    o_rindex<=5'd4;
                    R<=R_buf[89:60];
                end

                6'd7: begin
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd2;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd2;
                    o_rsrc[3:2]<=2'd1;
                    o_sel0[14:12]<=3'd6;
                    o_sel1[14:12]<=3'd6;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd6;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd6;
                    o_tindex<=5'd5;
                    o_rindex<=5'd5;
                    R<=R_buf[89:60];
                end

                6'd8: begin
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                end

                6'd9: begin
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd2;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd2;
                    o_rsrc[3:2]<=2'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd6;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd6;
                    o_tindex<=5'd6;
                    o_rindex<=5'd6;
                    R<=R_buf[119:90];
                end

                6'd10: begin
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                end

                6'd11: begin
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd2;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd2;
                    o_rsrc[3:2]<=2'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd6;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd6;
                    o_tindex<=5'd7;
                    o_rindex<=5'd7;
                    R<=R_buf[149:120];
                end

                6'd12: begin
                    o_tsrc[11:10]<=2'd1;
                    o_rsrc[11:10]<=2'd2;
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_tsrc[3:2]<=2'd2;
                    o_rsrc[3:2]<=2'd0;
                    o_sel0[17:15]<=3'd6;
                    o_sel1[17:15]<=3'd6;
                    o_sel2[17:15]<=3'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                    o_sel0[5:3]<=3'd6;
                    o_sel1[5:3]<=3'd4;
                    o_sel2[5:3]<=3'd6;
                    o_tindex<=5'd8;
                    o_rindex<=5'd8;
                    R<=R_buf[149:120];
                end

                6'd13: begin
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd1;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd0;
                    o_rsrc[3:2]<=2'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd0;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd4;
                end

                6'd14: begin
                    o_tsrc[11:10]<=2'd1;
                    o_rsrc[11:10]<=2'd2;
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_tsrc[3:2]<=2'd2;
                    o_rsrc[3:2]<=2'd0;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd6;
                    o_sel2[17:15]<=3'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd4;
                    o_sel2[5:3]<=3'd6;
                    o_tindex<=5'd9;
                    o_rindex<=5'd9;
                    R<=R_buf[179:150];
                end

                6'd15: begin
                    o_tsrc[11:10]<=2'd0;
                    o_rsrc[11:10]<=2'd2;
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd1;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd0;
                    o_rsrc[3:2]<=2'd1;
                    o_tsrc[1:0]<=2'd2;
                    o_rsrc[1:0]<=2'd1;
                    o_sel0[17:15]<=3'd6;
                    o_sel1[17:15]<=3'd6;
                    o_sel2[17:15]<=3'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd0;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd4;
                    o_sel0[2:0]<=3'd6;
                    o_sel1[2:0]<=3'd4;
                    o_sel2[2:0]<=3'd6;
                    o_tindex<=5'd10;
                    o_rindex<=5'd10;
                    R<=R_buf[179:150];
                end

                6'd16: begin
                    o_tsrc[11:10]<=2'd1;
                    o_rsrc[11:10]<=2'd0;
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_tsrc[3:2]<=2'd1;
                    o_rsrc[3:2]<=2'd0;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd0;
                    o_sel2[17:15]<=3'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd4;
                    o_sel2[5:3]<=3'd5;
                end

                6'd17: begin
                    o_tsrc[11:10]<=2'd0;
                    o_rsrc[11:10]<=2'd2;
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd1;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd0;
                    o_rsrc[3:2]<=2'd1;
                    o_tsrc[1:0]<=2'd2;
                    o_rsrc[1:0]<=2'd1;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd6;
                    o_sel2[17:15]<=3'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd0;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd4;
                    o_sel0[2:0]<=3'd5;
                    o_sel1[2:0]<=3'd4;
                    o_sel2[2:0]<=3'd6;
                    o_tindex<=5'd11;
                    o_rindex<=5'd11;
                    R<=R_buf[209:180];
                end

                6'd18: begin
                    o_tsrc[11:10]<=2'd1;
                    o_rsrc[11:10]<=2'd0;
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_tsrc[3:2]<=2'd1;
                    o_rsrc[3:2]<=2'd0;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd0;
                    o_sel2[17:15]<=3'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd4;
                    o_sel2[5:3]<=3'd5;
                end

                6'd19: begin
                    o_tsrc[11:10]<=2'd0;
                    o_rsrc[11:10]<=2'd2;
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd1;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd0;
                    o_rsrc[3:2]<=2'd1;
                    o_tsrc[1:0]<=2'd2;
                    o_rsrc[1:0]<=2'd1;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd6;
                    o_sel2[17:15]<=3'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd0;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd4;
                    o_sel0[2:0]<=3'd5;
                    o_sel1[2:0]<=3'd4;
                    o_sel2[2:0]<=3'd6;
                    o_tindex<=5'd12;
                    o_rindex<=5'd12;
                    R<=R_buf[239:210];
                end

                6'd20: begin
                    o_tsrc[11:10]<=2'd1;
                    o_rsrc[11:10]<=2'd0;
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_tsrc[3:2]<=2'd1;
                    o_rsrc[3:2]<=2'd0;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd0;
                    o_sel2[17:15]<=3'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd4;
                    o_sel2[5:3]<=3'd5;
                end

                6'd21: begin
                    o_tsrc[11:10]<=2'd0;
                    o_rsrc[11:10]<=2'd2;
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd1;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd0;
                    o_rsrc[3:2]<=2'd1;
                    o_tsrc[1:0]<=2'd2;
                    o_rsrc[1:0]<=2'd1;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd6;
                    o_sel2[17:15]<=3'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd0;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd4;
                    o_sel0[2:0]<=3'd5;
                    o_sel1[2:0]<=3'd4;
                    o_sel2[2:0]<=3'd6;
                    o_tindex<=5'd13;
                    o_rindex<=5'd13;
                    R<=R_buf[269:240];
                end

                6'd22: begin
                    o_tsrc[11:10]<=2'd1;
                    o_rsrc[11:10]<=2'd0;
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_tsrc[3:2]<=2'd1;
                    o_rsrc[3:2]<=2'd0;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd0;
                    o_sel2[17:15]<=3'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd4;
                    o_sel2[5:3]<=3'd5;
                end

                6'd23: begin
                    o_tsrc[11:10]<=2'd0;
                    o_rsrc[11:10]<=2'd2;
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd1;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd0;
                    o_rsrc[3:2]<=2'd1;
                    o_tsrc[1:0]<=2'd2;
                    o_rsrc[1:0]<=2'd1;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd6;
                    o_sel2[17:15]<=3'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd0;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd4;
                    o_sel0[2:0]<=3'd5;
                    o_sel1[2:0]<=3'd4;
                    o_sel2[2:0]<=3'd6;
                    o_tindex<=5'd14;
                    o_rindex<=5'd14;
                    R<=R_buf[299:270];
                end

                6'd24: begin
                    o_tsrc[11:10]<=2'd1;
                    o_rsrc[11:10]<=2'd0;
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_tsrc[3:2]<=2'd1;
                    o_rsrc[3:2]<=2'd0;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd0;
                    o_sel2[17:15]<=3'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd4;
                    o_sel2[5:3]<=3'd5;
                end

                6'd25: begin
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd1;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd0;
                    o_rsrc[3:2]<=2'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd0;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd4;
                end

                6'd26: begin
                    o_tsrc[11:10]<=2'd1;
                    o_rsrc[11:10]<=2'd2;
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_tsrc[3:2]<=2'd2;
                    o_rsrc[3:2]<=2'd0;
                    o_sel0[17:15]<=3'd0;
                    o_sel1[17:15]<=3'd6;
                    o_sel2[17:15]<=3'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd4;
                    o_sel2[5:3]<=3'd6;
                    o_tindex<=5'd15;
                    o_rindex<=5'd15;
                    R<=R_buf[359:330];
                end

                6'd27: begin
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd1;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd0;
                    o_rsrc[3:2]<=2'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd0;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd4;
                end

                6'd28: begin
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                end

                6'd29: begin
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd2;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd2;
                    o_rsrc[3:2]<=2'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd6;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd6;
                    o_tindex<=5'd16;
                    o_rindex<=5'd16;
                    R<=R_buf[419:390];
                end

                6'd30: begin
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                end

                6'd31: begin
                    o_tsrc[9:8]<=2'd0;
                    o_rsrc[9:8]<=2'd2;
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_tsrc[3:2]<=2'd2;
                    o_rsrc[3:2]<=2'd1;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd6;
                    o_sel2[14:12]<=3'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                    o_sel0[5:3]<=3'd4;
                    o_sel1[5:3]<=3'd3;
                    o_sel2[5:3]<=3'd6;
                    o_tindex<=5'd17;
                    o_rindex<=5'd17;
                    R<=R_buf[449:420];
                end

                6'd32: begin
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd0;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd1;
                    o_rsrc[5:4]<=2'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd1;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd4;
                end

                6'd33: begin
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                end

                6'd34: begin
                    o_tsrc[9:8]<=2'd1;
                    o_rsrc[9:8]<=2'd2;
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_tsrc[5:4]<=2'd2;
                    o_rsrc[5:4]<=2'd0;
                    o_sel0[14:12]<=3'd1;
                    o_sel1[14:12]<=3'd6;
                    o_sel2[14:12]<=3'd2;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd3;
                    o_sel2[8:6]<=3'd6;
                    o_tindex<=5'd18;
                    o_rindex<=5'd18;
                    R<=R_buf[509:480];
                end

                6'd35: begin
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd1;
                    o_tsrc[5:4]<=2'd0;
                    o_rsrc[5:4]<=2'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd1;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd3;
                end

                6'd36: begin
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                end

                6'd37: begin
                    o_tsrc[7:6]<=2'd0;
                    o_rsrc[7:6]<=2'd2;
                    o_tsrc[5:4]<=2'd2;
                    o_rsrc[5:4]<=2'd1;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd6;
                    o_sel2[11:9]<=3'd2;
                    o_sel0[8:6]<=3'd3;
                    o_sel1[8:6]<=3'd2;
                    o_sel2[8:6]<=3'd6;
                    o_tindex<=5'd19;
                    o_rindex<=5'd19;
                    R<=R_buf[569:540];
                end

                6'd38: begin
                    o_tsrc[7:6]<=2'd1;
                    o_rsrc[7:6]<=2'd0;
                    o_sel0[11:9]<=3'd2;
                    o_sel1[11:9]<=3'd2;
                    o_sel2[11:9]<=3'd3;
                end

                6'd40: // 第40cycle完成计算任务，cycle给o_bt_start信号，令其开始进行回溯任务
                begin
                    o_bt_start<=1;
                end	  
            endcase
        end 
    end

endmodule
