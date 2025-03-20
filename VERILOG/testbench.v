
module testbench;

    reg [3:0] A, B;
    reg clk, reset;
    wire [3:0] sum;
    wire c4;

    verilog uut (
        .A(A),
        .B(B),
        .clk(clk),
        .reset(reset),
        .sum(sum),
        .c4(c4)
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,testbench);
        A = 4'b0000;
        B = 4'b0000;
        reset = 1;
        clk = 0;
        #10 reset = 0;
        #20 A[0] = 1'b1; B[0] = 1'b1;
        #40 A[1] = 1'b1; B[1] = 1'b1;
        #80 A[2] = 1'b1; B[2] = 1'b1;
        #160 A[3] = 1'b1; B[3] = 1'b1;

        #320 $finish;
    end


    always #25 clk = ~clk;
    initial begin
        $monitor("Time: %0t | A = %b | B = %b | sum = %b (s0=%b, s1=%b, s2=%b, s3=%b) | c4 (c4) = %b",
                 $time, A, B, sum, sum[0], sum[1], sum[2], sum[3], c4);
    end
endmodule
