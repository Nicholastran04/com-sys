// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place.
// Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Handle edge case: if length <= 1, mark as done
@R2
D=M
@DONE
D;JLE    // If length <= 1, array is already sorted

// Initialize outer loop counter (R3 = R2 - 1)
@R2
D=M
D=D-1
@R3
M=D

(OUTER_LOOP)
    // Check if outer loop is done
    @R3
    D=M
    @DONE
    D;JLE    // If R3 <= 0, we're done

    // Initialize inner loop counter (R4 = 0)
    @0
    D=A
    @R4
    M=D

    (INNER_LOOP)
        // Check if inner loop is done
        @R4
        D=M
        @R3
        D=D-M
        @OUTER_LOOP_END
        D;JGE    // If R4 >= R3, inner loop is done

        // Calculate address of current element (addr = R1 + R4)
        @R1
        D=M     // D = base address
        @R4
        D=D+M   // D = base address + offset
        @addr
        M=D     // addr = address of current element

        // Load current element and next element
        @addr
        A=M     // A = address of current element
        D=M     // D = current element value
        @R5
        M=D     // R5 = current element value

        @addr
        A=M+1   // A = address of next element
        D=M     // D = next element value
        @R6
        M=D     // R6 = next element value

        // Compare elements (if R5 > R6, swap)
        @R5
        D=M     // D = current element
        @R6
        D=D-M   // D = current - next
        @SKIP_SWAP
        D;JLE   // If current <= next, skip the swap

        // Swap elements
        @addr
        A=M     // A = address of current element
        D=M     // D = current element
        @temp
        M=D     // temp = current element

        @addr
        A=M+1   // A = address of next element
        D=M     // D = next element
        @addr
        A=M     // A = address of current element
        M=D     // current = next

        @temp
        D=M     // D = saved current value
        @addr
        A=M+1   // A = address of next element
        M=D     // next = temp (original current)

        (SKIP_SWAP)
        // Increment inner loop counter
        @R4
        M=M+1   // R4++
        @INNER_LOOP
        0;JMP

    (OUTER_LOOP_END)
    // Decrement outer loop counter
    @R3
    M=M-1   // R3--
    @OUTER_LOOP
    0;JMP

(DONE)
// Set R0 to True (-1) to indicate completion
@1
D=-A    // D = -1 (True)
@R0
M=D     // R0 = True (-1)

(END)
@END
0;JMP   // Infinite loop to end program