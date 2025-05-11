// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialize variables
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

    // Move to the next element
(SKIP)
    @R1
    M=M+1
    @LOOP
    0;JMP

(END)
    // End program
    @END
    0;JMP

(R0_NEG)
    // Handle case when R0 is negative

(R0_POS)
    // Handle case when R0 is positive

(ELEM_NEG)
    // Handle case when current element is negative
    @R0
    D=M
    @R0_NEG
    D;JLT
    @UPDATE
    0;JMP

(ELEM_POS)
    // Handle case when current element is positive
    @R0
    D=M
    @R0_POS
    D;JGE
    @SKIP
    0;JMP
