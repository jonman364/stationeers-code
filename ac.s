alias air d0
alias sensor d1
alias dial d2

off:
s air On 0
off.loop:
l r0 sensor Temperature
l r1 dial Setting
add r1 r1 273
bge r0 r1 on
yield
j off.loop

on:
s air On 1
on.loop:
l r0 sensor Temperature
l r1 dial Setting
add r1 r1 268
ble r0 r1 off
yield
j on.loop