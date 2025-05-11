// Test case 02 for AddSub.asm
// Computes R1 + R2 - R3 = 2 + 3 - 7 = -2

load AddSub.asm,
output-file AddSub02.out,
compare-to AddSub02.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[3]%D2.6.2;

set PC 0,
set RAM[0] 0,  // Set R0
set RAM[1] 2,  // Set R1
set RAM[2] 3,  // Set R2
set RAM[3] 7;  // Set R3
repeat 100 {
  ticktock;
}
set RAM[1] 2,
set RAM[2] 3,
set RAM[3] 7,
output;
