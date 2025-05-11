// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialize variables
// Calculate end of array address: R2 = R1 + R2 - 1
@R1
D=M-1       // D = start address - 1 (adjusted for loop structure)
@R2
M=M+D       // R2 = R1 + R2 - 1 (now points to end address)

// Initialize R0 to maximum positive value as starting minimum
@32767      // Max positive value in 16-bit signed integer
D=A
@R0
M=D         // Start with maximum value as minimum

(LOOP)
(CHECK_TERMINATE)
    @R1
    D=M        // D = current address
    @R2
    D=D-M      // D = current - end
    @END
    D;JGT      // If current > end, we've processed all elements
    
    @R1
    A=M        // A = current address
    D=M        // D = current element value
    @ELEM_POS
    D;JGE      // If element >= 0, jump to ELEM_POS
    @ELEM_NEG
    0;JMP      // Otherwise, jump to ELEM_NEG

(UPDATE)
    @R1
    A=M        // A = current address
    D=M        // D = current element value
    @R0
    M=D        // R0 = current element (new minimum)

(SKIP)
    @R1
    M=M+1      // Move to next element
    @LOOP
    0;JMP      // Continue the loop

(END)
    @END
    0;JMP      // Infinite loop to end program

(R0_NEG)
    // If R0 is negative and element is negative
    @R1
    A=M
    D=M        // D = current element
    @R0
    D=D-M      // D = current - min
    @SKIP
    D;JGE      // If current >= min, skip
    @UPDATE
    0;JMP      // Otherwise, update minimum

(R0_POS)
    // If R0 is positive and element is positive
    @R1
    A=M
    D=M
    @R0
    D=D-M      // D = current - min
    @SKIP
    D;JGE      // If current >= min, skip
    @UPDATE
    0;JMP      // Otherwise, update minimum

(ELEM_NEG)
    // If current element is negative
    @R0
    D=M
    @R0_NEG
    D;JLT      // If R0 < 0, jump to R0_NEG
    @UPDATE
    0;JMP      // If element is negative but R0 is positive, update

(ELEM_POS)
    // If current element is positive or zero
    @R0
    D=M
    @R0_POS
    D;JGE      // If R0 >= 0, jump to R0_POS
    @SKIP
    0;JMP      // If element is positive but R0 is negative, skip