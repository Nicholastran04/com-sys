// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialize array start address
@R1
D=M
@arr_start
M=D

// Initialize counter for array length
@R2
D=M
@counter
M=D

// Initialize min_value
@arr_start
D=M
D=M
@min_value
M=D

// Loop to check each element
@check_loop
@counter
D=M
@exit_loop
D;JEQ

// Get current array element
@arr_start
D=M
@current_value
M=D

// Compare current value with min_value
@min_value
D=M
@current_value
D=D-M
@update_min
D;JGT

// Update min_value if current value is smaller
@current_value
D=M
@min_value
M=D

// Increment array pointer and decrement counter
@arr_start
D=M
@arr_start
M=D+1

@counter
M=M-1

// Loop back to check next element
@check_loop
0;JMP

// Exit loop
@exit_loop

// Store result in R0
@min_value
D=M
@R0
M=D

@end
0;JMP
