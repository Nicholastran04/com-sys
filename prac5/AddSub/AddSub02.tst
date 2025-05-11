// Test case 02 for AddSub.asm
// Computes R1 + R2 - R3 = 5 + 9 - 3 = 11

load AddSub.asm,
output-file AddSub02.out,
compare-to AddSub02.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[3]%D2.6.2;

set PC 0,
set RAM[0] 0,  // Set R0
set RAM[1] 5,  // Set R1
set RAM[2] 9,  // Set R2
set RAM[3] 3;  // Set R3
repeat 100 {
  ticktock;
}
set RAM[1] 5,
set RAM[2] 9,
set RAM[3] 3,
output;
