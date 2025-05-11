// Test case 02 for ArrSort.asm
// Single-element array test

load ArrSort.asm,
output-file ArrSort02.out,
compare-to ArrSort02.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[40]%D2.6.2;

set PC 0,
set RAM[0]  0,  // Set R0
set RAM[1]  40, // Set R1 (Array size)
set RAM[2]  1,  // Set R2 (Array length)
set RAM[40] 7;  // Set Arr[0]
repeat 600 {
  ticktock;    // Run for 600 clock cycles
}
set RAM[1] 40,  // Restore arguments in case program used them
set RAM[2] 1,
output;         // Output to file
