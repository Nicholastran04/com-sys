// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

    @R1
    D=M    // D = base address
    A=D    // A = base address
    D=M    // D = first element
    @R0
    M=D    // Store first element as current minimum
    
    @R2
    D=M    // D = array length
    @END
    D;JLE  // If array length <= 0, we're done
    
    D=D-1  // Decrement length (we already processed first element)
    @i
    M=D    // i = array length - 1
    
    @R1
    D=M    // D = base address
    @addr
    M=D    // Store base address
    
LOOP:
    @i
    D=M    // D = counter
    @END
    D;JLE  // If counter <= 0, we're done
    
    @addr
    M=M+1  // Move to next element
    A=M    // A = address of current element
    D=M    // D = current element
    
    @R0    // Compare with current minimum
    D=D-M  // D = current element - min
    @SKIP
    D;JGE  // If current element >= min, skip
    
    @addr
    A=M    // A = address of current element
    D=M    // D = current element
    @R0    
    M=D    // Update minimum
    
SKIP:
    @i
    M=M-1  // Decrement counter
    @LOOP
    0;JMP  // Continue loop
    
END:
    @END
    0;JMP  // Infinite loop to end program