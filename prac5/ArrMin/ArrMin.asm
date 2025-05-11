// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialize the array start address and length
@R1
D=M
@arr_start
M=D

@R2
D=M
@counter
M=D

// Initialize the minimum value to the first element
@arr_start
D=M
@min_value
M=D

// Loop through the array
@check_loop
D=M
@counter
D=D-M
@exit_loop
D;JEQ

// Compare current element with the minimum
@min_value
D=M
@arr_start
D=D-M
@update_min
D;JGT

// Update the minimum value
@arr_start
M=D

// Move to the next element
@arr_start
D=M
@arr_start
M=D+1

// Decrement the counter
@counter
M=M-1
@check_loop
0;JMP

// Exit the loop
(exit_loop)

// Store the minimum value in R0
@min_value
D=M
@R0
M=D

@end
@end
0;JMP
