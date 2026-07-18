v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -20 40 30 40 {lab=#net1}
N -60 -0 -0 -0 {lab=#net2}
N -150 -0 -120 0 {lab=#net3}
N 30 -0 60 0 {lab=#net4}
N -20 -160 -0 -160 {lab=#net1}
N -60 -120 30 -120 {lab=#net2}
N -20 -160 -20 40 {lab=#net1}
N -90 -160 -20 -160 {lab=#net1}
N -120 40 -20 40 {lab=#net1}
N -60 -120 -60 -0 {lab=#net2}
N -120 -120 -60 -120 {lab=#net2}
N -90 -0 -60 -0 {lab=#net2}
N -150 -160 -120 -160 {lab=#net5}
N 30 -160 60 -160 {lab=#net6}
N -70 140 40 140 {lab=#net7}
N -100 100 70 100 {lab=#net8}
C {sg13g2_pr/sg13_lv_pmos.sym} -120 -140 3 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -120 20 3 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -100 120 1 0 {name=M3
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 70 120 3 1 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 30 20 3 0 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 30 -140 3 0 {name=M6
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} 260 -160 0 0 {name=gnd lab=gnd}
C {iopin.sym} 330 -160 0 0 {name=vdd lab=vdd}
C {iopin.sym} 430 -170 0 0 {name=bl lab=bl}
C {iopin.sym} 400 -150 0 0 {name=br lab=br}
C {ipin.sym} 520 -150 0 0 {name=wl lab=wl}
