alias ice_sorter d0
alias fe_sorter d1
alias cu_sorter d2
alias c_sorter d3
alias au_sorter d4

define ICE_H2O 1217489948
define ICE_H2 1253102035
define ICE_O2 -1805394113
define IRON 1758427767
define COPPER -707307845
define COAL 1724793494
define GOLD -1348105509

s ice_sorter Mode 2
s fe_sorter Mode 2
s cu_sorter Mode 2
s c_sorter Mode 2
s au_sorter Mode 2

loop:
yield
ls r0 ice_sorter 0 Occupied
breqz r0 8
ls r0 ice_sorter 0 PrefabHash
seq r1 ICE_H2O r0
seq r2 ICE_H2 r0
seq r3 ICE_O2 r0
or r1 r1 r2
or r1 r1 r3
s ice_sorter Output r1

ls r0 fe_sorter 0 Occupied
breqz r0 4
ls r0 fe_sorter 0 PrefabHash
seq r1 IRON r0
s fe_sorter Output r1

ls r0 c_sorter 0 Occupied
breqz r0 4
ls r0 c_sorter 0 PrefabHash
seq r1 COAL r0
s c_sorter Output r1

ls r0 cu_sorter 0 Occupied
breqz r0 4
ls r0 cu_sorter 0 PrefabHash
seq r1 COPPER r0
s cu_sorter Output r1

ls r0 au_sorter 0 Occupied
breqz r0 4
ls r0 au_sorter 0 PrefabHash
seq r1 GOLD r0
s au_sorter Output r1

j loop