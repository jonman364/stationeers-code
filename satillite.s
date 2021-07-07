alias sat d0
alias button d1
alias led d2

s led Mode 0
move r0 -5
move r2 0

hloop:
# if r0 >= 360: h_angle = -5
brlt r0 360 2
move r0 -5

add r0 r0 5
# if h_angle % 10: v_angle == 0 else: v_angle == 90
mod r3 r0 10
breqz r3 3
move r1 90
jr 2
move r1 0

vloop:
jal moveto
l r3 sat SignalStrength
l r4 sat SignalID
breq r4 r2 2
bge r3 0.95 found

# if h_angle % 10: v_angle += 5 else: v_angle -= 5
mod r3 r0 10
breqz r3 3
sub r1 r1 5
jr 2
add r1 r1 5

# if v_angle < 0 or v_angle > 90: break
bgt r1 90 hloop
blt r1 0 hloop
j vloop

moveto:
s sat Horizontal r0
s sat Vertical r1

moveto.loop:
yield
l r3 sat Horizontal
l r4 sat Vertical
sub r3 r3 r0
sub r4 r4 r1
abs r3 r3
abs r4 r4
bgt r3 1 moveto.loop
bgt r4 1 moveto.loop
j ra

found:
move r2 r4
s led Setting r2
found.loop:
yield
l r3 button Setting
beqz r3 found
j vloop

end: