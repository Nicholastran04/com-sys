// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place.
// Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Edge case
@R2
D=M
@LENGTH_CHECK
D;JEQ

@R2
D=M
@ONE
D=D-1
@FINISH
D;JEQ

// End address
@R1
D=M
@R2
D=D+M
D=D-1
@R2
M=D

// Outer loop
(OUTER_LOOP)
(CHECK_TERMINATE)
    @R1
    D=M
    @R2
    D=D-M
    @FINISH
    D;JGE

    @R1
    D=M
    @R3
    M=D


// Inner loop
(INNER_LOOP)
(CHECK_INNER_END)
    @R3
    D=M
    @R2
    D=D-M
    @INNER_FINISH
    D;JGE

    @R3
    A=M
    D=M
    @current
    M=D

    @R3
    A=M+1
    D=M
    @next
    M=D

    @current
    D=M
    @next
    D=D-M
    @SKIP
    D;JLE
    
    // Swap values
    @current
    D=M
    @temp
    M=D

    @next
    D=M
    @R3
    A=M
    M=D

    @temp
    D=M
    @R3
    A=M+1
    M=D

(SKIP)
    @R3
    M=M+1
    @INNER_LOOP
    0;JMP

(INNER_FINISH)
    @R2
    M=M-1
    @OUTER_LOOP
    0;JMP

(FINISH)
    // Set R0 to True (-1) for completion
    @1
    D=-A
    @R0
    M=D

(END)
    @END
    0;JMP