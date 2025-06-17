`timescale 1ns / 1ps

module approx_comp_42(Cout, Sum, A, B, C, D);
input A, B, C, D;
output Cout, Sum;
assign Cout = (A & B) | (C & D);
assign Sum =  (A^B)|(C^D);
endmodule

module approx_full_adder(Cout, S, Cin, A, B);
input A, B, Cin;
output S, Cout;
assign Cout = (A&B) | (B&Cin);
assign S = (A|B|Cin);
endmodule

module exact_half_adder(Ci, Si, ABi, abi);
input ABi, abi;
output Ci, Si;
assign Ci=ABi&abi;
assign Si=ABi^abi;
endmodule

module approx_multiplier(A, B, result);
  input [3:0] A, B;
  output [7:0] result;
  wire C1, C2, C3, C4, C5, G3, g03, g12;
  and (result[0], A[0], B[0]);
  or (result[1], A[0] & B[1], A[1] & B[0]);
  approx_comp_42 c2 (C2, result[2], 0, A[2] & B[0], A[0] & B[2], A[1] & B[1]);
  approx_comp_42 c3 (C3, result[3], C2, (A[3] & B[0]) | (A[0] & B[3]), (A[2] & B[1]) | (A[1] & B[2]), (A[0] & B[3] & A[3] & B[0]) |  (A[1] & B[2] & A[2] & B[1]));
  approx_comp_42 c4 (C4, result[4], C3, A[2] & B[2], A[1] & B[3], A[3] & B[1]);
  approx_full_adder c5 (C5, result[5], C4, A[2] & B[3], A[3] & B[2]);
  exact_half_adder c6 (result[7], result[6], C5, A[3] & B[3]);
endmodule

