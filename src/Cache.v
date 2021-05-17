module Cache(
    input   wire    clk,
    input   wire    nrst,
    input   wire    ena,
    input   wire    [95:0]  D,
    output  reg     [95:0]  D_1,
    output  reg     [95:0]  D_2
);

    always @ (posedge clk or negedge nrst) begin
        if (~nrst | ~ena) begin
            D_1 <= 96'd0;
            D_2 <= 96'd0;
        end
        else begin
            {D_2, D_1} <= {D_1, D};
        end
    end

endmodule
