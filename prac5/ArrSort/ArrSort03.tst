// Test case 03 for ArrSort.asm
// Array with duplicates test

load ArrSort.asm,
output-file ArrSort03.out,
compare-to ArrSort03.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[60]%D2.6.2 RAM[61]%D2.6.2 RAM[62]%D2.6.2;

set PC 0,
set RAM[0]  0,  // Set R0
set RAM[1]  60, // Set R1 (Array size)
set RAM[2]  4,  // Set R2 (Array length)
set RAM[60] 3,  // Set Arr[0]
set RAM[61] 1,  // Set Arr[1]
set RAM[62] 1,  // Set Arr[2]
set RAM[63] 2;  // Set Arr[3]
repeat 600 {
  ticktock;    // Run for 600 clock cycles
}
set RAM[1] 60,  // Restore arguments in case program used them
set RAM[2] 4,
output;         // Output to file

