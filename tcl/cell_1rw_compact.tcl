# Run from this repository in Magic with the IHP SG13G2 magicrc.
# Build a flat, diffusion-sharing 6T cell from the M1-only device variants.
set root [file normalize [file join [file dirname [info script]] ..]]
set out $root/magic/cell_1rw
set art $root/.amp/in/artifacts/bitcell-compact
file mkdir $art
proc rect {layer x1 y1 x2 y2} {
    box values ${x1}um ${y1}um ${x2}um ${y2}um
    paint $layer
}
proc pad {layer x y w h} {
    rect $layer [expr {$x-$w/2}] [expr {$y-$h/2}] [expr {$x+$w/2}] [expr {$y+$h/2}]
}
proc pin {name layer x y index} {
    box values ${x}um ${y}um ${x}um ${y}um
    label $name center $layer
    port make $index
}
load compact_assembly -silent
foreach {name type x y} {
    XM2 pmos -0.95 1.30
    XM1 pmos 0.95 1.30
    XM5 nmos -0.95 0
    XM6 nmos 0.95 0
    XM4 nmos -1.52 0
    XM3 nmos 1.52 0
} {
    getcell $out/sg13_lv_${type}_m1.mag child 0 0 parent ${x}um ${y}um
    identify $name
}
flatten cell_1rw_compact -nolabels
load cell_1rw_compact
# Replace the generator's terminal stacks/gate ends with shared routing.
box values -3um -2um 3um 3um
erase metal1
erase poly
# One shared N-well, continuous across the left/right abutment boundaries.
rect nwell -2.075 0.78 2.075 1.83
foreach x {-0.95 0.95} {
    rect poly [expr {$x-.065}] -0.33 [expr {$x+.065}] 1.63
}
foreach x {-1.52 1.52} {
    rect poly [expr {$x-.065}] -0.75 [expr {$x+.065}] 0.33
}
# Source/drain contacts: Q nodes are shared by the adjacent NMOS pair.
foreach x {-1.805 -1.235 -0.665 0.665 1.235 1.805} {
    pad ndc $x 0 0.16 0.16
    pad metal1 $x 0 0.26 0.16
}
foreach x {-1.235 -0.665 0.665 1.235} {
    pad pdc $x 1.30 0.16 0.16
    pad metal1 $x 1.30 0.26 0.16
}
# VSS/VDD and body contacts, shared within each cell.
rect metal1 -0.795 -0.08 0.795 0.08
rect metal1 -0.795 1.22 0.795 1.38
pad psd 0 0 0.30 0.64
pad psc 0 0 0.16 0.16
pad nsd 0 1.30 0.30 0.42
pad nsc 0 1.30 0.16 0.16
# Storage node risers, kept away from the opposite inverter's gate pad.
foreach x {-1.41 1.41} {
    rect metal1 [expr {$x-.08}] -0.08 [expr {$x+.08}] 1.38
}
foreach x {-1.235 1.235} {
    if {$x < 0} {set edge -1.49} else {set edge 1.49}
    rect metal1 [expr {min($x,$edge)}] -0.08 [expr {max($x,$edge)}] 0.08
    rect metal1 [expr {min($x,$edge)}] 1.22 [expr {max($x,$edge)}] 1.38
}
# Cross-coupled storage nodes on separate M2 tracks.
foreach {qx gx y} {-1.41 0.95 0.44 1.41 -0.95 0.85} {
    pad poly $gx $y 0.30 0.30
    pad pc $gx $y 0.16 0.16
    foreach x [list $qx $gx] {
        pad metal1 $x $y 0.28 0.36
        pad via1 $x $y 0.20 0.20
    }
    rect metal2 [expr {min($qx,$gx)-.145}] [expr {$y-.1}] [expr {max($qx,$gx)+.145}] [expr {$y+.1}]
}
# Wordline contacts below the access gates; M1 crosses below the ground rail.
rect metal1 -2.075 -0.70 2.075 -0.50
foreach x {-1.52 1.52} {
    pad poly $x -0.60 0.30 0.30
    pad pc $x -0.60 0.16 0.16
    pad metal1 $x -0.60 0.28 0.28
}
# Bitlines on M2; their long rails meet the metal-area requirement.
foreach x {-1.865 1.865} {
    pad metal1 $x 0 0.22 0.42
    pad via1 $x 0 0.20 0.20
    rect metal2 [expr {$x-.1}] -0.84 [expr {$x+.1}] 1.83
}
# M3 power rails cross over the storage nodes and abut across columns.
foreach y {0 1.30} {
    pad metal1 0 $y 0.28 0.36
    pad via1 0 $y 0.20 0.20
    pad metal2 0 $y 0.60 0.26
    pad via2 0 $y 0.20 0.20
    pad metal3 0 $y 0.30 0.26
    rect metal3 -2.075 [expr {$y-.10}] 2.075 [expr {$y+.10}]
}
pin bl metal2 -1.865 0 1
pin br metal2 1.865 0 2
pin wl metal1 0 -0.60 3
pin vdd metal3 0 1.30 4
pin gnd metal3 0 0 5
box values -1.235um 0um -1.235um 0um
label Q center metal1
box values 1.235um 0um 1.235um 0um
label Q_bar center metal1
# Alternate rows must be mirrored vertically to share the N-well boundary.
# Explicit units avoid confusing Magic's lambda with its internal half-grid.
property FIXED_BBOX {-2.075um -0.84um 2.075um 1.83um}
select top cell
box values -3um -2um 3um 3um
drc style drc(full)
drc check
drc catchup
puts "=== COMPACT DRC ==="
drc why
puts "DRC_DETAILS: [drc listall why]"
cellname filepath cell_1rw_compact $out
save
gds write $root/gds/cell_1rw_compact.gds
extract path $art
extract all
ext2spice lvs
ext2spice -p $art -o $art/cell_1rw_compact.spice cell_1rw_compact
quit -noprompt
