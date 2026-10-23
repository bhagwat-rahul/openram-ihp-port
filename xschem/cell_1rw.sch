v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -120 -60 -120 -10 {lab=Q_bar}
N -80 -100 -80 -40 {lab=Q}
N -80 -190 -80 -160 {lab=vdd}
N -80 -10 -80 20 {lab=gnd}
N 80 -60 80 -40 {lab=Q_bar}
N 40 -100 40 -10 {lab=Q}
N 80 -130 80 -60 {lab=Q_bar}
N -120 -160 -120 -60 {lab=Q_bar}
N 40 -160 40 -100 {lab=Q}
N -80 -130 -80 -100 {lab=Q}
N 80 -190 80 -160 {lab=vdd}
N 80 -10 80 20 {lab=gnd}
N -80 70 90 70 {lab=wl}
N -80 -100 40 -100 {lab=Q}
N -120 -60 80 -60 {lab=Q_bar}
N -80 110 -80 160 {lab=gnd}
N -80 160 90 160 {lab=gnd}
N 90 110 90 160 {lab=gnd}
N -80 -190 80 -190 {lab=vdd}
N 40 -100 160 -100 {lab=Q}
N 160 -100 160 110 {lab=Q}
N 120 110 160 110 {lab=Q}
N -140 -60 -120 -60 {lab=Q_bar}
N -140 -60 -140 110 {lab=Q_bar}
N -140 110 -110 110 {lab=Q_bar}
N -50 110 -40 110 {lab=br}
N 40 110 60 110 {lab=bl}
N -200 20 -80 20 {lab=gnd}
N -200 20 -200 160 {lab=gnd}
N -200 160 -80 160 {lab=gnd}
N 80 20 200 20 {lab=gnd}
N 200 20 200 160 {lab=gnd}
N 90 160 200 160 {lab=gnd}
C {sg13g2_pr/sg13_lv_pmos.sym} 60 -160 0 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -100 -160 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -80 90 1 0 {name=M3
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 90 90 3 1 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -100 -10 0 0 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 60 -10 0 0 {name=M6
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} 40 110 2 0 {name=bl lab=bl}
C {iopin.sym} -40 110 2 1 {name=br lab=br}
C {ipin.sym} 0 70 1 0 {name=wl lab=wl}
C {iopin.sym} 0 -190 3 0 {name=vdd lab=vdd}
C {iopin.sym} 0 160 1 0 {name=gnd lab=gnd}
C {lab_wire.sym} 0 -60 1 1 {name=Q_bar sig_type=std_logic lab=Q_bar}
C {lab_wire.sym} 0 -100 1 0 {name=Q sig_type=std_logic lab=Q}
