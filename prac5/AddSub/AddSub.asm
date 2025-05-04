// Calculates R1 + R2 - R3 and stores the result in R0.
// (R0, R1, R2, R3 refer to RAM[0], RAM[1], RAM[2], and RAM[3], respectively.)

// Put your code here.

@1      // Load R1 (a)
D=M     // D = a

@2      // Load R2 (b)
D=D+M   // D = a + b

@3      // Load R3 (c)
D=D-M   // D = a + b - c

@0      // Store result in R0
M=D