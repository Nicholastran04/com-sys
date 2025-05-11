// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

    @R1    // Load the address of the first element
    D=M    // D = address of first element
    A=D    // Set A register to that address
    D=M    // D = first element value (initial min)
    @R0
    M=D    // R0 = first element (assume it's the minimum)
    
    @R2    // Check if array has only one element
    D=M    // D = length of array
    @END
    D;JLE  // If length <= 1, we're done (edge case)
    
    @counter
    M=D    // Initialize counter to array length
    M=M-1  // Decrement because we already processed the first element
    
    @R1
    D=M    // D = base address
    @currentAddress
    M=D    // Store base address in currentAddress
    
LOOP:
    @counter
    D=M    // D = counter
    @END
    D;JLE  // If counter <= 0, we're done
    
    @currentAddress
    M=M+1  // Move to next element in array
    A=M    // Set A to point to that element
    D=M    // D = current element value
    
    @R0
    D=D-M  // D = current element - current minimum
    @SKIP
    D;JGE  // If current element >= minimum, skip the update
    
    // Update minimum
    @currentAddress
    A=M    // Get address of current element again
    D=M    // D = current element value
    @R0
    M=D    // Update minimum
    
SKIP:
    @counter
    M=M-1  // Decrement counter
    @LOOP
    0;JMP  // Go back to loop
    
END:
    // R0 already contains the minimum value
    @END
    0;JMP  // Infinite loop to end program