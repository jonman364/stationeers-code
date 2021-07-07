alias aimee d0
alias recall d1
alias mode d2
alias locx d3
alias locz d4
alias velo d5
alias lastx r10
alias lastz r11
alias delta r12

define NONE 0
define MOVETO 2
define ROAM 3
define UNLOAD 4
define PATHTO 5
define FULL 6

define NEARX 2
define NEARZ 56
define HOMEX -12
define HOMEZ 55
define UNLOADX -1
define UNLOADZ 53
define MINEX 85
define MINEZ 11

start:
move r0 NEARX
move r1 NEARZ
jal botmove

move r0 MINEX
move r1 MINEZ
jal botmove

s aimee Mode ROAM
loop:
yield
l r0 aimee Mode
l r1 recall Setting
ls r2 aimee 0 Charge
beq r0 FULL gohome
beq r1 1 gohome
blt r2 100 gohome
s aimee Mode ROAM
jal display
j loop

gohome:
move r0 NEARX
move r1 NEARZ
jal botmove

move r0 UNLOADX
move r1 UNLOADZ
jal botmove

s aimee Mode UNLOAD
unload:
jal display
yield
l r0 aimee Mode
bgtz r0 unload

s aimee TargetX HOMEX
s aimee TargetZ HOMEZ
s aimee Mode PATHTO
yield
jal display
l r0 aimee Mode
brgtz r0 -3

s aimee On 0
j start

botmove:
push ra
s aimee TargetX r0
s aimee TargetZ r1
s aimee Mode MOVETO
botmove.loop:
jal display

yield
l r0 aimee Mode
bgtz r0 botmove.loop
pop ra
j ra

display:
push r0
l r0 aimee Mode
s mode Setting r0
l r0 aimee PositionX
s locx Setting r0
l r0 aimee PositionZ
s locz Setting r0
l r0 aimee VelocityMagnitude
mul r0 r0 100
round r0 r0
div r0 r0 100
s velo Setting r0

pop r0
j ra