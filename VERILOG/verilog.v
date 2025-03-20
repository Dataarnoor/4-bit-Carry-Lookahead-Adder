`timescale 1ns/1ps

module verilog(sum, c4, A, B, clk, reset);

    input [3:0] A, B;
    input clk, reset;
    output [3:0] sum;
    output c4;

    wire [3:0] A_ff, B_ff, sum_int;
    wire c4_int;
    wire C0 = 0;

    dff dff_a0(.d(A[0]), .clk(clk), .reset(reset), .q(A_ff[0]));
    dff dff_a1(.d(A[1]), .clk(clk), .reset(reset), .q(A_ff[1]));
    dff dff_a2(.d(A[2]), .clk(clk), .reset(reset), .q(A_ff[2]));
    dff dff_a3(.d(A[3]), .clk(clk), .reset(reset), .q(A_ff[3]));

    dff dff_b0(.d(B[0]), .clk(clk), .reset(reset), .q(B_ff[0]));
    dff dff_b1(.d(B[1]), .clk(clk), .reset(reset), .q(B_ff[1]));
    dff dff_b2(.d(B[2]), .clk(clk), .reset(reset), .q(B_ff[2]));
    dff dff_b3(.d(B[3]), .clk(clk), .reset(reset), .q(B_ff[3]));

    adder_4bit_cla cla_inst(
        .sum(sum_int), 
        .c4(c4_int), 
        .A(A_ff), 
        .B(B_ff), 
        .C0(C0)
    );

    dff dff_s0(.d(sum_int[0]), .clk(clk), .reset(reset), .q(sum[0]));
    dff dff_s1(.d(sum_int[1]), .clk(clk), .reset(reset), .q(sum[1]));
    dff dff_s2(.d(sum_int[2]), .clk(clk), .reset(reset), .q(sum[2]));
    dff dff_s3(.d(sum_int[3]), .clk(clk), .reset(reset), .q(sum[3]));

    dff dff_c4(.d(c4_int), .clk(clk), .reset(reset), .q(c4));

endmodule

module dff(d, clk, reset, q);
    input d, clk, reset;
    output reg q;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else
            q <= d;
    end
endmodule

module adder_4bit_cla(sum, c4, A, B, C0);

    input [3:0] A, B;
    input C0;
    output [3:0] sum;
    output c4;

    wire P0, G0, P1, G1, P2, G2, P3, G3;
    wire C4, C3, C2, C1;

    assign
        P0 = A[0] ^ B[0],
        P1 = A[1] ^ B[1],
        P2 = A[2] ^ B[2],
        P3 = A[3] ^ B[3];

    assign
        G0 = A[0] & B[0],
        G1 = A[1] & B[1],
        G2 = A[2] & B[2],
        G3 = A[3] & B[3];

    assign
        C1 = G0 | (P0 & C0),
        C2 = G1 | (P1 & G0) | (P1 & P0 & C0),
        C3 = G2 | (P2 & G1) | (P2 & P1 & G0) | (P2 & P1 & P0 & C0),
        C4 = G3 | (P3 & G2) | (P3 & P2 & G1) | (P3 & P2 & P1 & G0) | (P3 & P2 & P1 & P0 & C0);

    assign
        sum[0] = P0 ^ C0,
        sum[1] = P1 ^ C1,
        sum[2] = P2 ^ C2,
        sum[3] = P3 ^ C3;

    assign c4 = C4;

endmodule
