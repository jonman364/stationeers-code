alias button d0
alias countled d1

define AUTOMOD 0
define OREMOD 0
define SILOMOD 0
define FUELMOD 0
define KLAXON 0

wait:
yield
l r0 button Setting
beqz r0 wait

move r0 5
move r1 33
s button Lock 1
sb KLAXON On 1
sb KLAXON Setting 35
sleep 5
s button Open 0
countdown:
s countled Setting r0
sb KLAXON Setting r1
sleep 1
sub r0 r0 1
sub r1 r1 1
bgtz r0 countdown

s countled Setting 0
sb KLAXON Setting 36

sleep 1

sb AUTOMOD Activate 1

space.wait:
yield
lb r0 AUTOMOD Mode 0
blt r0 4 space.wait

mine:
sb OREMOD Activate 1
mine.loop:
yield
lb r0 OREMOD Mode 0
s countled Setting r0
lb r0 AUTOMOD Fuel 0
blt r0 700 return
lb r0 AUTOMOD CollectableGoods 0
bgtz r0 mine.loop
sb OREMOD Activate 0
sb AUTOMOD Activate 2

mine.travel:
lb r0 OREMOD Mode 0
s countled Setting r0
yield
lb r0 AUTOMOD CollectableGoods 0
beqz r0 mine.travel
sb AUTOMOD Activate 4
j space.wait

return:
lb r0 OREMOD Mode 0
s countled Setting r0
sb OREMOD Activate 0
sb AUTOMOD Activate 5

landing.wait:
yield
lb r0 AUTOMOD Mode 0
blt r0 6 landing.wait

s button Lock 0
sb KLAXON Setting 7

sleep 10

sb KLAXON On 0

j wait
