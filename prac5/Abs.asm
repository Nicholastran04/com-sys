// Calculates the absolute value of R1 and stores the result in R0.
// (R0, R1 refer to RAM[0], and RAM[1], respectively.)

// Put your code here.

// Computes a + b - c, where:
// R1 = a, R2 = b, R3 = c
// Result stored in R0

@R1
D=M        // D = a
@R2
D=D+M      // D = a + b
@R3
D=D-M      // D = a + b - c
@R0
M=D        // R0 = result