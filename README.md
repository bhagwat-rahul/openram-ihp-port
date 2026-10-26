# IHPSG13G2 OpenRAM Port

Just some schematic and layout work on ihpsg13g2 to create primitive cells for open ram to be able to do it's magic

## M1-only bitcell layout starting point

Open `magic/cell_1rw/cell_1rw_m1.mag` for the alternate, unrouted top. It uses
`sg13_lv_nmos_m1.mag` and `sg13_lv_pmos_m1.mag` from the same directory, with
W/L = 0.15/0.13 µm and `viasrc`, `viadrn`, and `viagate` all set to zero.
Diffusion/poly contacts to M1 remain; automatic Via1/M2 stacks are omitted.
The original top and generated devices are unchanged.

XM1/XM2 are PMOS; XM3–XM6 are NMOS. The NMOS staging positions are spaced out
to avoid inter-device spacing violations before placement. The saved cyan
array-pitch and yellow geometry-envelope reference guides are retained. Use
`view -0.8um -3.3um 8.8um 1.6um` to see all devices and guides together.

These variants are **not yet DRC-clean standalone devices**: full Magic DRC
still reports M1 minimum area and missing substrate/well taps. Complete the
terminal metal area through routing and provide appropriate shared taps.
This is a layout starting point, not a connected or LVS-verified SRAM cell.

## Routed 6T bitcell

`magic/cell_1rw/cell_1rw_compact.mag` is a separate, flat, routed variant;
`gds/cell_1rw_compact.gds` is its exported layout. The original and M1-only
staging tops are unchanged. All six devices retain W/L = 0.15/0.13 µm.
Each access/pull-down pair shares diffusion and its storage-node contact.
The cell includes substrate/well taps, M2 cross-coupling and bitlines,
an M1 wordline, and M3 power rails. Port order is `bl br wl vdd gnd`.

The boundary is x = −2.075…2.075 µm, y = −0.84…1.83 µm: **4.15 × 2.67 µm**.
Wordline/power rails abut horizontally; bitlines abut vertically.
**Alternate rows must be mirrored vertically** to share the N-well boundary.
For example, successive row transforms are identity at y = 0, mirror-Y at
y = 3.66 µm, identity at y = 5.34 µm, and mirror-Y at y = 9.00 µm.
Here mirror-Y means negate the y coordinate, not the x coordinate.

Rebuild inside the IIC-OSIC container after selecting SG13G2:

```sh
iic-pdk ihp-sg13g2
magic -dnull -noconsole \
  -rcfile "$PDKPATH/libs.tech/magic/ihp-sg13g2.magicrc" \
  /foss/designs/ihp-openram/openram-ihp-port/tcl/cell_1rw_compact.tcl
```

Validation in the installed SG13G2 PDK:

- Magic `drc(full)`: zero errors, standalone and flattened 3-column × 4-row array.
- Official KLayout main/maximal checks: zero errors, standalone and array;
  chip-level density checks excluded (`--no_density`).
- Netgen LVS against `xschem/cell_1rw.sch`: unique match, including all six
  W/L values and body connections. Only the schematic's simulation-only
  `mm_ok` property is excluded from comparison; connectivity and dimensions
  are checked using the PDK setup.

Reports, extracted SPICE, and screenshots are under the locally ignored
`.amp/in/artifacts/bitcell-compact/`. These are physical verification results,
not SRAM stability, timing, yield, or foundry signoff qualification.

This pass is **not smaller than the shipped SRAM cell**: 11.0805 µm² versus
the foundry array pitch of 2.81 × 1.07 = 3.0067 µm²/bit (about 3.69× larger).
The reference is `RM_IHPSG13_1P_BITKIT_CELL` in the PDK's
`RM_IHPSG13_1P_64x16_c2.gds`; compare array pitches, not its overlapping
geometry envelope. This is a routed, verified baseline, not a minimum-area
replacement for the specialized foundry SRAM layout.
