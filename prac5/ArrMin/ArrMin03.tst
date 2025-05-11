// Test case 03 for ArrMin.asm
// Finds the smallest element in an array containing duplicate values.

load ArrMin.asm,
output-file ArrMin03.out,
compare-to ArrMin03.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[20]%D2.6.2 RAM[21]%D2.6.2 RAM[22]%D2.6.2 RAM[23]%D2.6.2;

set PC 0,
set RAM[0]  0,  // Set R0
set RAM[1]  4,  // Set R1 (Array size)
set RAM[2]  4,  // Set R2 (Array length)
set RAM[20] 20, // Set Arr[0]
set RAM[21] 20, // Set Arr[1]
set RAM[22] 15, // Set Arr[2]
set RAM[23] 20; // Set Arr[3]
repeat 300 {
  ticktock;    // Run for 300 clock cycles
}

set RAM[1] 4,  // Restore arguments in case program used them
set RAM[2] 4,
output;        // Output to file
