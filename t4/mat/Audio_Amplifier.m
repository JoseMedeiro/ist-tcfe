%%%%%%
%%
%%  Part-a-Part Analysis
%%
%%  We analyse seperatly the gain stage and the output stage, both DC and AC. 
%%  It is good because we can see the DC stuff (and the incremental constants) +
%%  we can see the output impedance of the gain and the input impedance of the 
%%  output stage (in order to compare them (good if Zoutgain << Zinout) and to 
%%  see if there is a direct link between any of the calculated impedances and 
%%  the ones of the full amplifier.
%%
%%  Also, the teacher gave us this one.
%%
%%%%%%

%%
%%  Gain Stage
%%

%%  Bijetor Data

VT    = 25e-3;
BFN   = 178.7;
VAFN  = 69.7;
VBEON = 0.7;

%%  Circuit Data

RE1   = 100;
RC1   = 1000;
RB1   = 80000;
RB2   = 20000;
VCC   = 12;
RS    = 100;

%%  DC Analysis

RB=1/(1/RB1+1/RB2)
VEQ=RB2/(RB1+RB2)*VCC
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1)
IC1=BFN*IB1
IE1=(1+BFN)*IB1
VE1=RE1*IE1
VO1=VCC-RC1*IC1
VCE=VO1-VE1

%%  Incremental Constants

gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

%%  AC Analysis

AV1 = RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)

AV1simple = gm1*RC1/(1+gm1*RE1)

RE1=0
AV1 = RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AV1simple = gm1*RC1/(1+gm1*RE1)

RE1=100

ZI1 = ((ro1+RC1+RE1)*(RB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)

ZX = ro1*((RB+rpi1)*RE1/(RB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RB)+1/RE1+gm1*rpi1/(rpi1+RB)))

ZO1 = 1/(1/ZX+1/RC1)

%%
%%  Output Stage
%%

%%  Bijector Data

BFP = 227.3
VAFP = 37.2
VEBON = 0.7

%%  Circuit Data

RE2 = 100

%%  DC Analysis

VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2

%%  Incremental Constants

gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

%%  AC Analysis

AV2 = gm2/(gm2+gpi2+go2+ge2)

ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2)

ZO2 = 1/(gm2+gpi2+go2+ge2)

%%%%%%
%%
%%  Full Analysis
%%
%%  We analyse the full circuit as one, in AC conditions, since the DC would be 
%%  the same as in the Part-a-Part analysis. 
%%  It is good because we can now predict the input and output impedances of the 
%%  amplifier, and draw conclusions.
%%  We do it by some method, probably Mesh Analysis (since we really want the 
%%  currents that pass thought the voltage sources, with the incremental models
%%  fueled by the DC data (for the incremental constants)
%%
%%%%%%

%%  Equations

%%  Matrix

%%  Impedance
