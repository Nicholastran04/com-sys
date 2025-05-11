// This file is based on part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: Mult.asm

// Multiplies R1 and R2 and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialize result to 0
@R0
M=0

// Initialize sign flag to 0
@sign
M=0

// Absolute value of R1
@R1
D=M
@pos_r1
D;JGE

@sign
M=1
@R1
D=-M

(pos_r1)
@abs_r1
M=D

// Absolute value of R2
@R2
D=M
@pos_r2
D;JGE

@sign
D=M
@setSign2
D;JEQ
@sign
M=0
@contSign
0;JMP

(setSign2)
@sign
M=1

(contSign)
@R2
D=-M

(pos_r2)
@abs_r2
M=D

// Smaller value as counter
@abs_r1
D=M
@abs_r2
D=D-M
@use_r1
D;JLT

// Set counter and value to multiply
@abs_r2
D=M
@counter
M=D
@abs_r1
D=M
@value
M=D
@mult_loop
0;JMP

(use_r1)
@abs_r1
D=M
@counter
M=D
@abs_r2
D=M
@value
M=D

// Multiplication loop
(mult_loop)
@counter
D=M
@apply_sign
D;JEQ

@value
D=M
@R0
M=M+D

@counter
M=M-1

@mult_loop
0;JMP

// Apply the sign to the result
(apply_sign)
@sign
D=M
@end
D;JEQ

@R0
M=-M

(end)
@end
0;JMP
