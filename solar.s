alias sensor d0
define SOLAR_HASH -539224550

day:
l r0 sensor Vertical
l r1 sensor Horizontal

bgt r1 91 night
blt r1 -89 night

jal getpos

add r1 180 r1

sb SOLAR_HASH Vertical r0
sb SOLAR_HASH Horizontal r1
yield
j day

getpos:
abs r0 r0
div r0 r0 1.5

min r0 r0 50
max r0 r0 0
sub r0 50 r0
j ra

night:
sb SOLAR_HASH Vertical 0
sb SOLAR_HASH Horizontal 90

night.loop:
l r1 d0 Horizontal
blt r1 91 day
bgt r1 -89 day
yield
j night.loop