define pi 3.14159
loop:
l r0 d0 Vertical
l r1 d0 Horizontal

push r0
jal getpos

sub r0 50 r15
sub r1 0 r1

s d2 Setting r0
s d3 Setting r1
yield
j loop

getpos:
pop r15

sub r15 r15 45
mul r15 r15 pi
div r15 r15 90
sin r15 r15
mul r15 r15 25
add r15 r15 25
 j r17