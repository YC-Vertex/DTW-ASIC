`timescale 1ns/1ps
`define PERIOD 20

`include "top.v"

module Memory(
    input   wire    i_clk,
    input   wire    i_WR,   // 0 - Read, 1 - Write
    input   wire    i_CS,   // 低有效
    input   wire    [9:0]   i_addr,
    inout   wire    [31:0]  dbus
);

    reg [31:0] MEM [0:1023];

    reg [31:0] data;
    wire r, w;
    assign r = ~i_CS & ~i_WR;
    assign w = ~i_CS & i_WR;
    assign dbus = r ? data : 32'bz;

    initial begin
        $readmemh("data/memory.vec", MEM);
    end

    always @ (posedge i_clk) begin
        if (r) begin
            data <= MEM[i_addr];
        end
        else begin
            data <= 32'bx;
        end
    end

endmodule

module TESTBENCH;

    reg clk, nrst;
    // Memory
    reg [9:0] mem_addr;
    wire [31:0] mem_data;
    reg mem_WR, mem_CS;
    // DTW Processor
    reg [31:0] dtw_in;
    reg dtw_valid;
    wire dtw_ready;

    integer ifile;
    integer dummy;

    Top dtw(clk, nrst,
        mem_addr, mem_data, mem_WR, mem_CS,
        dtw_in, dtw_valid, dtw_ready);
    Memory mem(clk, mem_WR, mem_CS, mem_addr, mem_data);

    always #(`PERIOD/2) clk = ~clk;
    
    initial begin
        ifile = $fopen("data/in.vec", "r");
    end

    initial begin
        clk = 1'b0;
        nrst = 1'b0;
        dtw_in = 32'd0;
        dtw_valid = 1'b0;

        #(`PERIOD*9.5) nrst = 1'b1;
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