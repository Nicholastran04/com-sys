
// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialize variables
// Calculate end of array address: R2 = R1 + R2 - 1
@R1
D=M-1
@R2
M=M+D

// Initialize R0 to maximum positive value as starting minimum
@32767
D=A
@R0
M=D

(LOOP)
    // Check termination condition
(CHECK_TERMINATE)
    @R1
    D=M
    @R2
    D=D-M
    @END
    D;JGT
    
    // Check if element is positive or negative
    @R1
    A=M
    D=M
    @ELEM_POS
    D;JGE
    @ELEM_NEG
    0;JMP

    // Update R0 with the smallest value
(UPDATE)
    @R1
    A=M
    D=M
    @R0
    M=D

    // Update R0 with the smallest value
(SKIP)
    @R1
    M=M+1
    @LOOP
    0;JMP

    // End program
(END)
    @END
    0;JMP

(R0_NEG)
    // If R0 is negative
    @R1
    A=M
    D=M
    @R0
    D=D-M
    @SKIP
    D;JGE
    @UPDATE
    0;JMP

(R0_POS)
    // If R0 is positive
    @R1
    A=M
    D=M
    @R0
    D=D-M
    @SKIP
    D;JGE
    @UPDATE
    0;JMP

(ELEM_NEG)
    // If current element is negative
    @R0
    D=M
    @R0_NEG
    D;JLT
    @UPDATE
    0;JMP

(ELEM_POS)
    // If current element is positive or zero
    @R0
    D=M
    @R0_POS
    D;JGE
    @SKIP
    0;JMP
