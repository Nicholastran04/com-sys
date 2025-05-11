// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place.
// Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialize loop variables
// i = 0 (outer loop index)
@0
D=A
@R3
M=D

// Main Sorting Loop (Outer Loop)
(OUTER_LOOP)
    // Check if i < R2 - 1 (i = R3)
    @R2
    D=M
    @R3
    D=D-M
    @END
    D;JLE // If i >= R2 - 1, end sorting

    // Inner loop: j = 0 (inner loop index)
    @0
    D=A
    @R4
    M=D

    // Compare and swap elements if necessary
(INNER_LOOP)
    // j < R2 - 1 - i
    @R2
    D=M
    @R3
    D=D-M
    @R4
    D=D-M
    @SKIP_INNER
    D;JLE

    // Compare elements at index j and j+1
    @R1
    A=M
    D=M       // D = RAM[R1 + j]
    @R4
    A=M+1
    D=D-M     // D = RAM[R1 + j+1] - RAM[R1 + j]
    @SWAP
    D;JGT    // If D > 0 (RAM[R1 + j] > RAM[R1 + j+1], swap them)

    // Move to the next inner loop iteration
(SKIP_INNER)
    @R4
    M=M+1      // Increment j
    @INNER_LOOP
    0;JMP

// Swap elements if necessary
(SWAP)
    // Swap elements at indices j and j+1
    @R1
    A=M
    @R4
    A=M       // A = R1 + j
    D=M       // D = RAM[R1 + j]
    @R1
    A=M
    @R4
    A=M+1     // A = R1 + j + 1
    M=D       // RAM[R1 + j + 1] = RAM[R1 + j]
    D=M       // D = RAM[R1 + j + 1]
    @R1
    A=M
    @R4
    A=M       // A = R1 + j
    M=D       // RAM[R1 + j] = RAM[R1 + j + 1]

    // Continue to next inner loop iteration
    @INNER_LOOP
    0;JMP

// Move to the next outer loop iteration
(OUTER_LOOP_END)
    @R3
    M=M+1      // Increment i
    @OUTER_LOOP
    0;JMP

// Program end
(END)
    @R0
    M=-1      // Set R0 to True (-1) when complete
    0;JMP
