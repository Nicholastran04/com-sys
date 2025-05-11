// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place.
// Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Handle edge case: if length <= 0, mark as done
@R2
D=M
@DONE
D;JLE   // If length <= 0, array is already sorted

// Initialize outer loop counter (i=0)
@i
M=0

(OUTER_LOOP)
    // Check if outer loop is done (i >= length-1)
    @i
    D=M
    @R2
    D=D-M+1
    @DONE
    D;JGE

    // Initialize minimum index as current i
    @i
    D=M
    @min_idx
    M=D

    // Initialize inner loop counter (j=i+1)
    @i
    D=M
    @j
    M=D+1

    (INNER_LOOP)
        // Check if inner loop is done (j >= length)
        @j
        D=M
        @R2
        D=D-M
        @SWAP
        D;JGE

        // Get A[min_idx]
        @R1
        D=M
        @min_idx
        A=D+M
        D=M       // D = A[min_idx]
        @min_val
        M=D

        // Get A[j]
        @R1
        D=M
        @j
        A=D+M
        D=M       // D = A[j]

        // Compare: if A[j] < A[min_idx], update min_idx
        @min_val
        D=D-M     // D = A[j] - A[min_idx]
        @SKIP_UPDATE
        D;JGE     // If A[j] >= A[min_idx], skip update

        // Update min_idx to j
        @j
        D=M
        @min_idx
        M=D

    (SKIP_UPDATE)
        // j++
        @j
        M=M+1
        @INNER_LOOP
        0;JMP

    (SWAP)
        // Check if min_idx == i (no swap needed)
        @i
        D=M
        @min_idx
        D=D-M
        @CONTINUE
        D;JEQ

        // Get A[i]
        @R1
        D=M
        @i
        A=D+M
        D=M       // D = A[i]
        @temp
        M=D

        // Get A[min_idx]
        @R1
        D=M
        @min_idx
        A=D+M
        D=M       // D = A[min_idx]

        // Set A[i] = A[min_idx]
        @R1
        A=M
        @i
        A=D+M
        M=D       // A[i] = A[min_idx]

        // Set A[min_idx] = temp
        @temp
        D=M
        @R1
        A=M
        @min_idx
        A=D+M
        M=D       // A[min_idx] = temp

    (CONTINUE)
        // i++
        @i
        M=M+1
        @OUTER_LOOP
        0;JMP

(DONE)
    // Set R0 to True (-1) to indicate completion
    @0
    M=0     // Initialize R0 to 0 (redundant but explicit)
    @1
    D=-A    // D = -1 (True)
    @R0
    M=D     // R0 = True (-1)

(END)
    @END
    0;JMP   // Infinite loop to end p