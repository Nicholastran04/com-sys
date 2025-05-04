// Calculates the absolute value of R1 and stores the result in R0.
// (R0, R1 refer to RAM[0], and RAM[1], respectively.)

// Put your code here.

@1      // Load R1
D=M     // D = R1

@POSITIVE
D;JGE   // If D >= 0, jump to POSITIVE

// If R1 < 0, negate it
D=-D    // D = -R1

@0
M=D     // Store abs(R1) in R0
@END
0;JMP

(POSITIVE)
@0
M=D     // Store R1 in R0

(END)