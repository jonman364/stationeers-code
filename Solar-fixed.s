loop:
l r0 d0 Vertical
l r1 d0 Horizontal

bgt r1 91 night

push r0
jal getpos

add r1 180 r1

s d2 Setting r15
s d3 Setting r1
yield
j loop

getpos:
pop r15

abs r15 r15
div r15 r15 1.5

min r15 r15 50
max r15 r15 0
sub r15 50 r15
j r17

night:
s d2 Setting 0
s d3 Setting 90

night.loop:
l r1 d0 Horizontal
slt r2 r1 91
sgt r3 r1 -89
add r2 r2 r3
beq r2 2 night.end
yield
j night.loop

night.end:
j loop