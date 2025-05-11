// Test case 02 for Abs.asm
// Computes absolute value: R1 = -7 → R0 = 7

load Abs.asm,
output-file Abs02.out,
compare-to Abs02.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2;

set PC 0,
set RAM[0] 0,
set RAM[1] -7;
repeat 100 {
  ticktock;
}
set RAM[1] -7,
output;
