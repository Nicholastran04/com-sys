// Test case 01 for Mult.asm
// Computes R1 * R2 = 123 * 45 = 5535

load Mult.asm,
output-file Mult01.out,
compare-to Mult01.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2;

set PC 0,
set RAM[0] 0,  // Set R0
set RAM[1] 123,  // Set R1
set RAM[2] 45;  // Set R2
repeat 200 {
  ticktock;    // Run for 200 clock cycles
}
set RAM[1] 123, // Restore arguments in case program used them
set RAM[2] 45,
output;        // Output to file