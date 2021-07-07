alias sensor d0
#alias day d1
alias time d2
alias old r3

move old -180

loop:
l r0 sensor Horizontal

#bgtal old r0 incday
move old r0

div r0 r0 15
add r0 r0 13
floor r1 r0
sub r0 r0 r1
mul r0 r0 100
div r0 r0 1.6666666
floor r0 r0
div r0 r0 100
add r0 r0 r1

s time Setting r0

yield
j loop

incday:
l r3 day Setting
add r3 r3 1
s day Setting r3
j ra