// This file is based on part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: Mult.asm

// Multiplies R1 and R2 and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

@R0
M=0         // R0 = 0 (accumulator)

@R2
D=M         // D = R2 (multiplier)
@LOOP
M=D         // store multiplier in LOOP

@R1
D=M         // D = R1 (multiplicand)
@MULTIPLICAND
M=D

@LOOP
D=M         // D = counter (R2)
@END
D;JEQ       // if counter == 0, end

@MULTIPLICAND
D=M         // D = multiplicand
@R0
M=M+D       // R0 += multiplicand

@LOOP
M=M-1       // counter--

@LOOP
0;JMP       // repeat loop

(END)
@END
0;JMP       // infinite loop after finishing