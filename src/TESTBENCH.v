`timescale 1ns/1ps
`define PERIOD 20

`include "TOP.v"

module Memory(
    input   wire    i_clk,
    input   wire    i_WR,   // 0 - Read, 1 - Write
    input   wire    i_CS,   // 低有效
    input   wire    [9:0]   i_addr,
    input   wire    [31:0]  i_data,
    output  reg     [31:0]  o_data,
    input   wire    check
);

    reg [31:0] MEM [0:1023];

    wire r, w;
    assign r = ~i_CS & ~i_WR;
    assign w = ~i_CS & i_WR;

    integer ofile;
    integer gold_out;
    integer index;
    integer success;
    integer dummy;

    initial begin
        $readmemh("data/memory.vec", MEM);
        ofile = $fopen("data/out.vec", "r");
    end

    always @ (posedge i_clk) begin
        if (r) begin
            o_data <= MEM[i_addr];
        end
    end
    
    always @ (posedge i_clk) begin
        if (w) begin
            MEM[i_addr] <= i_data;
        end
    end

    always @ (posedge check) begin
        index = 10'd20;
        success = 1'b1;

        begin: gold_test
            forever begin
                dummy = $fscanf(ofile, "%h", gold_out);
                if (gold_out == 32'hffff_ffff)
                    disable gold_test;
                if (gold_out != MEM[index]) begin
                    $display("%d: %08x %08x", index, gold_out, MEM[index]);
                    success = 1'b0;
                    $display("Fail!");
                end
                index = index + 1;
            end
        end
        if (success) begin
            $display("Success!\n");
        end
    end

endmodule

module TESTBENCH;

    reg clk, nrst;
    // Memory
    wire [9:0] mem_addr;
    wire [31:0] mem_data_i;
    wire [31:0] mem_data_o;
    wire mem_WR, mem_CS;
    // DTW Processor
    reg [31:0] dtw_in;
    reg dtw_valid;
    wire dtw_ready;

    reg check;

    integer ifile;
    integer dummy;

    TOP dtw(clk, nrst,
        mem_addr, mem_data_o, mem_data_i, dtw_data_ena, mem_WR, mem_CS,
        dtw_in, dtw_valid, dtw_ready);
    Memory mem(clk, mem_WR, mem_CS, mem_addr, mem_data_i, mem_data_o, check);

    always #(`PERIOD/2) clk = ~clk;
    
    initial begin
        ifile = $fopen("data/in.vec", "r");
    end

    initial begin
        clk = 1'b0;
        nrst = 1'b0;
        dtw_in = 32'd0;
        dtw_valid = 1'b0;
        check = 1'b0;

        #(`PERIOD*9.6) nrst = 1'b1;
        // invalid input
        #(`PERIOD*10) dtw_in = $random % 32'hffff_ffff;
        #(`PERIOD*10) dtw_in = $random % 32'hffff_ffff;
        #(`PERIOD*10) dtw_in = $random % 32'hffff_ffff;

        repeat(10) begin
            // send R sequence
            #(`PERIOD*10) dtw_valid = 1'b1;
            dummy = $fscanf(ifile, "%h", dtw_in);
            repeat(19) begin
                #(`PERIOD) dummy = $fscanf(ifile, "%h", dtw_in);
            end
            #(`PERIOD) dtw_valid = 1'b0;
            dtw_in = 32'h0;
            // wait for the output
            while (dtw_ready != 1'b1) #(`PERIOD);

            check = 1'b1;
            #(`PERIOD) check = 1'b0;
        end

        $fclose(ifile);
        $finish;
    end

    // memory test
    /*
    initial begin
        mem_CS = 1'b1;
        mem_WR = 1'b0;
        mem_addr = 10'h0;

        #(`PERIOD*10) mem_CS = 1'b0;
        #(`PERIOD*10) mem_addr = 10'h0;
        #(`PERIOD*10) mem_addr = 10'h1;
        #(`PERIOD*10) mem_addr = 10'h2;
        #(`PERIOD*10) mem_addr = 10'h3;
    end
    */

endmodule