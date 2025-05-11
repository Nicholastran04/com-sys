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

// Main sorting loop (i starts at 1)
@1
D=A
@i
M=D         // i = 1

(OUTER_LOOP)
    // Check if outer loop is done
    @i
    D=M
    @length
    D=D-M
    @DONE
    D;JGE    // If i >= length, we're done
    
    // Get the key (current element)
    @R1
    D=M       // D = base address
    @i
    D=D+M     // D = base + i
    A=D       // A = &A[i]
    D=M       // D = A[i]
    @key
    M=D       // key = A[i]
    
    // Initialize j = i - 1
    @i
    D=M
    D=D-1
    @j
    M=D       // j = i - 1
    
    (INNER_LOOP)
        // Check if j < 0
        @j
        D=M
        @INSERT_POSITION
        D;JLT    // If j < 0, we found insert position
        
        // Get A[j]
        @R1
        D=M       // D = base address
        @j
        D=D+M     // D = base + j
        A=D       // A = &A[j]
        D=M       // D = A[j]
        @j_val
        M=D       // j_val = A[j]
        
        // Compare A[j] with key
        @j_val
        D=M       // D = A[j]
        @key
        D=D-M     // D = A[j] - key
        @INSERT_POSITION
        D;JLE     // If A[j] <= key, found position
        
        // Shift A[j] to A[j+1] position
        @j_val
        D=M       // D = A[j]
        
        @R1
        A=M       // A = base address
        @j
        A=D+A     // A = base + j
        A=A+1     // A = &A[j+1]
        M=D       // A[j+1] = A[j] (shift)
        
        // Decrement j
        @j
        M=M-1     // j--
        @INNER_LOOP
        0;JMP     // Continue inner loop
    
    (INSERT_POSITION)
        // Insert key at A[j+1]
        @j
        D=M
        D=D+1     // D = j + 1
        @insert_pos
        M=D       // insert_pos = j + 1
        
        @R1
        D=M       // D = base address
        @insert_pos
        D=D+M     // D = base + insert_pos
        A=D       // A = &A[insert_pos]
        
        @key
        D=M       // D = key
        @R1
        A=M       // A = base address
        @insert_pos
        A=D+A     // A = base + insert_pos
        M=D       // A[insert_pos] = key
        
        // Increment i
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