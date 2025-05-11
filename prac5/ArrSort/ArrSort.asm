// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place.
// Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Handle edge case: if length == 0 or 1, finish
@R2
D=M
@FINISH
D;JEQ        // If length == 0, finish

@R2
D=M
@ONE
D=D-1
@FINISH
D;JEQ        // If length == 1, finish

// Compute end address and store in R4 (do NOT overwrite R2)
@R1
D=M         // D = base address
@R2
D=D+M       // D = base + length
D=D-1       // D = address of last element
@R4
M=D         // R4 = end address

(OUTER_LOOP)
(CHECK_TERMINATE)
    @R1
    D=M         // D = current start address
    @R4
    D=D-M       // D = start - end
    @FINISH
    D;JGE       // If start >= end, we're done
    
    @R1
    D=M
    @R3         // use R3 as the index of the inner loop
    M=D         // R3 = start address

(INNER_LOOP)
(CHECK_INNER_END)
    @R3
    D=M         // D = current position
    @R4
    D=D-M       // D = current - end
    @INNER_FINISH
    D;JGE       // If current >= end, inner loop is done
    
    // Compare current element with next element
    @R3
    A=M         // A = current address
    D=M         // D = current value
    @current
    M=D         // Save current value
    
    @R3
    A=M
    A=A+1       // A = next address
    D=M         // D = next value
    @next
    M=D         // Save next value
    
    @current
    D=M
    @next
    D=D-M       // D = current - next
    @SKIP
    D;JLE       // If current <= next, skip swap
    
    // Swap current and next
    @current
    D=M
    @temp
    M=D         // temp = current
    
    @next
    D=M
    @R3
    A=M
    M=D         // current = next
    
    @temp
    D=M
    @R3
    A=M
    A=A+1
    M=D         // next = temp

(SKIP)
    @R3
    M=M+1       // Move to next element
    @INNER_LOOP
    0;JMP

(INNER_FINISH)
    @R4
    M=M-1       // Reduce end address by 1
    @OUTER_LOOP
    0;JMP

(FINISH)
    @1
    D=-A
    @R0
    M=D         // R0 = -1 (True)

(END)
    @END
    0;JMP       // Infinite loop
