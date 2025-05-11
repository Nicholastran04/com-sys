// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place.
// Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialize variables
@R2
D=M
@length
M=D         // length = R2

// Edge case: if array length <= 1, it's already sorted
@length
D=M
@DONE
D;JLE       // If length <= 1, array is already sorted

// Main sorting loop
@0
D=A
@i
M=D         // i = 0

(OUTER_LOOP)
    // Check if outer loop is done
    @i
    D=M
    @length
    D=D-M
    @DONE
    D;JGE    // If i >= length, we're done
    
    // Initialize min_idx = i
    @i
    D=M
    @min_idx
    M=D       // min_idx = i
    
    // Initialize j = i + 1
    @i
    D=M
    @j
    M=D+1     // j = i + 1
    
    (INNER_LOOP)
        // Check if inner loop is done
        @j
        D=M
        @length
        D=D-M
        @SWAP_PREP
        D;JGE    // If j >= length, exit inner loop
        
        // Compare A[j] with A[min_idx]
        // Get address of A[j]
        @R1
        D=M       // D = base address
        @j
        D=D+M     // D = base + j
        @j_addr
        M=D       // j_addr = &A[j]
        A=D       // A = &A[j]
        D=M       // D = A[j]
        @j_val
        M=D       // j_val = A[j]
        
        // Get address of A[min_idx]
        @R1
        D=M       // D = base address
        @min_idx
        D=D+M     // D = base + min_idx
        @min_idx_addr
        M=D       // min_idx_addr = &A[min_idx]
        A=D       // A = &A[min_idx]
        D=M       // D = A[min_idx]
        @min_val
        M=D       // min_val = A[min_idx]
        
        // Compare: if A[j] < A[min_idx], update min_idx
        @j_val
        D=M       // D = A[j]
        @min_val
        D=D-M     // D = A[j] - A[min_idx]
        @UPDATE_MIN
        D;JLT     // If A[j] < A[min_idx], update min_idx
        @INCREMENT_J
        0;JMP     // Else, continue to next j
        
        (UPDATE_MIN)
            @j
            D=M
            @min_idx
            M=D    // min_idx = j
            
        (INCREMENT_J)
            @j
            M=M+1  // j++
            @INNER_LOOP
            0;JMP  // Continue inner loop
    
    (SWAP_PREP)
        // Check if min_idx == i (no swap needed)
        @i
        D=M
        @min_idx
        D=D-M
        @INCREMENT_I
        D;JEQ    // If min_idx == i, no need to swap
        
        // Swap A[i] and A[min_idx]
        // Get address and value of A[i]
        @R1
        D=M       // D = base address
        @i
        D=D+M     // D = base + i
        @i_addr
        M=D       // i_addr = &A[i]
        A=D       // A = &A[i]
        D=M       // D = A[i]
        @i_val
        M=D       // i_val = A[i]
        
        // Get address and value of A[min_idx] (again to be safe)
        @R1
        D=M       // D = base address
        @min_idx
        D=D+M     // D = base + min_idx
        @min_idx_addr
        M=D       // min_idx_addr = &A[min_idx]
        A=D       // A = &A[min_idx]
        D=M       // D = A[min_idx]
        @min_val
        M=D       // min_val = A[min_idx]
        
        // Do the swap
        // A[min_idx] = A[i]
        @i_val
        D=M       // D = A[i]
        @min_idx_addr
        A=M       // A = &A[min_idx]
        M=D       // A[min_idx] = A[i]
        
        // A[i] = A[min_idx]
        @min_val
        D=M       // D = A[min_idx]
        @i_addr
        A=M       // A = &A[i]
        M=D       // A[i] = A[min_idx]
    
    (INCREMENT_I)
        @i
        M=M+1     // i++
        @OUTER_LOOP
        0;JMP     // Continue outer loop

(DONE)
    // Set R0 to True (-1) to indicate completion
    @1
    D=-A      // D = -1 (True)
    @R0
    M=D       // R0 = True (-1)
    
(END)
    @END
    0;JMP     // Infinite loop to end program