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

%%  Circuit Data

Vin   = 1;
Vout  = 1;
VCC   = 12;

RS    = 100;
RL    = 8;
RB1   = 80 *1e3;
RB2   = 20 *1e3;
RE1   = 100;
RE2   = 100;
RC1   = 1000;

CI    = 1  *1e-3;
CB    = 1  *1e-3;
CO    = 1  *1e-6;

f     = 100*1e3;
w     = 2*pi*f;

printf("VALUES_TAB \n")

printf("BJT        = %d  \n"    , 2           );
printf("\\#$R_S$   = %e  \n"    , RS          );
printf("\\#$R_L$   = %e  \n"    , RL          );
printf("\\#$R_1$   = %e  \n"    , RB1         );
printf("\\#$R_2$   = %e  \n"    , RB2         );
printf("\\#$R_E1$  = %e  \n"    , RE1         );
printf("\\#$R_C2$  = %e  \n"    , RC1         );
printf("\\#$R_OUT$ = %e  \n"    , RE2         );

printf("\\&$C_I$   = %e  \n"    , CI          );
printf("\\&$C_B$   = %e  \n"    , CB          );
printf("\\&$C_O$   = %e  \n"    , CO          );

TotalCost = (RB1+RB2+RC1+RE1+RE2)*1e-3 + (CB+CI+CO)*1e6 + 0.2;

printf("£Cost = %e  \n"         , TotalCost   );

printf("VALUES_END \n")


%%
%%  Gain Stage
%%

%%  Bijetor Data

VT    = 25e-3;
BFN   = 178.7;
VAFN  = 69.7;
VBEON = 0.7;

%%  DC Analysis

RB  = 1/(1/RB1+1/RB2);
VEQ = RB2/(RB1+RB2)*VCC;
IB1 = (VEQ-VBEON)/(RB+(1+BFN)*RE1);
IC1 = BFN*IB1;
IE1 = (1+BFN)*IB1;
VE1 = RE1*IE1;
VO1 = VCC-RC1*IC1;
VCE = VO1-VE1;

%%  Incremental Constants

gm1   = IC1/VT;
rpi1  = BFN/gm1;
ro1   = VAFN/IC1;

RSB=RB*RS/(RB+RS);

%%  AC Analysis

AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1))
AV1simple = RB/(RB+RS) * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))

% Altas frequências

RE1=0;
AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1))
AV1simple =  - RSB/RS * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))

% Back again

RE1 = 100;
ZI1 = 1/(1/RB1 + 1/RB2 + 1/rpi1)

ZO1 = 1/(1/ro1 + 1/RC1)

%%
%%  Output Stage
%%

%%  Bijector Data

BFP   = 227.3;
VAFP  = 37.2;
VEBON = 0.7;

%%  DC Analysis

VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2

%%  Incremental Constants

gm2   = IC2/VT;
gpi2  = gm2/BFP;
go2   = IC2/VAFP;
ge2   = 1/RE2;

%%  AC Analysis

AV2 = gm2/(gm2+gpi2+go2+ge2)

ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2)

ZO2 = 1/(gm2+gpi2+go2+ge2)


GainParcial = 20*log10(abs(AV1*AV2))
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

printf("values\n");
%%  Equations
ZS    = RS;
ZCI   = 1/(w*j*CI);
ZB    = 1/(1/RB1 + 1/RB2);

zpi1  = rpi1;
zo1   = ro1;

ZE1   = RE1;
ZCB   = 1/(w*j*CB);
ZE1CB = 1/(1/ZE1 + 1/ZCB);

ZC    = RC1;
zpi2  = 1/gpi2;
zo2   = 1/go2;
ZE2   = RE2;
Zo2E2 = 1/(1/zo2 + 1/ZE2);

ZCO   = 1/(w*j*CO);
ZL    = RL;

%%  Matrix

% Input Impedance

AI = [  ZCI + ZB  , -ZB               , 0   , 0               , 0           , 0     , 0     ; ...
        -ZB       , ZB + zpi1 + ZE1CB , 0   , -ZE1CB          , 0           , 0     , 0     ; ...
        0         , zpi1*gm1          , 1   , 0               , 0           , 0     , 0     ; ...
        0         , -ZE1CB            , -zo1, ZE1CB + zo1 + ZC, -ZC         , 0     , 0     ; ...
        0         , 0                 , 0   , -ZC             , zpi2+ZC     , Zo2E2 , -Zo2E2; ...
        0         , 0                 , 0   , 0               , -1-zpi2*gm2 , 1     , 0     ; ...
        0         , 0                 , 0   , 0               , 0           , 0     , 1     ];
        
BI = [  Vin       ; 0                 ; 0   ; 0               ; 0           ; 0     ; 0     ];

PI = AI\BI;

ZinputFull = Vin/PI(1)

% Output Impedance

AO = [  ZCI + ZB  , -ZB               , 0   , 0               , 0           , 0     , 0         ; ...
        -ZB       , ZB + zpi1 + ZE1CB , 0   , -ZE1CB          , 0           , 0     , 0         ; ...
        0         , zpi1*gm1          , 1   , 0               , 0           , 0     , 0         ; ...
        0         , -ZE1CB            , -zo1, ZE1CB + zo1 + ZC, -ZC         , 0     , 0         ; ...
        0         , 0                 , 0   , -ZC             , zpi2+ZC     , Zo2E2 , -Zo2E2    ; ...
        0         , 0                 , 0   , 0               , -1-zpi2*gm2 , 1     , 0         ; ...
        0         , 0                 , 0   , 0               , 0           , -Zo2E2, Zo2E2+ZCO];
        
BO = [  0         ; 0                 ; 0   ; 0               ; 0           ; 0     ; -Vout ];

PO = AO\BO;

ZoutputFull = Vin/(-PO(7))

% Normal Business

AG = [  ZS+ZCI+ZB , -ZB               , 0   , 0               , 0           , 0     , 0             ; ...
        -ZB       , ZB + zpi1 + ZE1CB , 0   , -ZE1CB          , 0           , 0     , 0             ; ...
        0         , zpi1*gm1          , 1   , 0               , 0           , 0     , 0             ; ...
        0         , -ZE1CB            , -zo1, ZE1CB + zo1 + ZC, -ZC         , 0     , 0             ; ...
        0         , 0                 , 0   , -ZC             , zpi2+ZC     , Zo2E2 , -Zo2E2        ; ...
        0         , 0                 , 0   , 0               , -1-zpi2*gm2 , 1     , 0             ; ...
        0         , 0                 , 0   , 0               , 0           , -Zo2E2, Zo2E2+ZCO+ZL ];
        
BG = [  Vin       ; 0                 ; 0   ; 0               ; 0           ; 0     ; 0     ];

PG = AG\BG;

GainFull = abs(PG(7)*ZL/Vin);

%%  Frequency Analysis

f         = logspace(1, 6+2, 10*(log10(100e6/10)));
w         = f*2*pi;
GainFreq  = w;
for c=1:size(w,2)
  
  ZCI   = 1/(w(c)*j*CI);
  ZE1   = RE1;
  ZCB   = 1/(w(c)*j*CB);
  ZE1CB = 1/(1/ZE1 + 1/ZCB);
  ZCO   = 1/(w(c)*j*CO);
  
  
  AG = [  ZS+ZCI+ZB , -ZB               , 0   , 0               , 0           , 0     , 0             ; ...
        -ZB       , ZB + zpi1 + ZE1CB , 0   , -ZE1CB          , 0           , 0     , 0             ; ...
        0         , zpi1*gm1          , 1   , 0               , 0           , 0     , 0             ; ...
        0         , -ZE1CB            , -zo1, ZE1CB + zo1 + ZC, -ZC         , 0     , 0             ; ...
        0         , 0                 , 0   , -ZC             , zpi2+ZC     , Zo2E2 , -Zo2E2        ; ...
        0         , 0                 , 0   , 0               , -1-zpi2*gm2 , 1     , 0             ; ...
        0         , 0                 , 0   , 0               , 0           , -Zo2E2, Zo2E2+ZCO+ZL ];
        
  BG = [  Vin       ; 0                 ; 0   ; 0               ; 0           ; 0     ; 0     ];

  PG = AG\BG;

  GainFreq(c) = PG(7)*ZL/Vin;
  
endfor


%%  Tabela DC

printf("MAT_DC_TAB \n")

printf("$V_{coll} - V_{base}$   = %e  \n", VO1-VE1);
printf("$V_{coll} - V_{0}$      = %e  \n", VO1    );

printf("MAT_DC_END \n")

%%  Tabela Impedance

printf("MAT_IMP_TAB \n")

printf("\\#$Z_{in-emitter}$    = %e  \n", ZI1                 );
printf("\\#$Z_{out-emitter}$   = %e  \n", ZO2                 );
printf("\\#$Z_{in-collector}$  = %e  \n", ZI1                 );
printf("\\#$Z_{out-collector}$ = %e  \n", ZO2                 );

printf("$Z_{in-collector}/$Z_{out-emitter}$ = %e  \n", ZI1/ZO2);

printf("\\#$Z_{in}$            = %e  \n", ZinputFull          );
printf("\\#$Z_{out}$           = %e  \n", ZoutputFull         );

printf("MAT_IMP_END \n")

%%  Tabela Gains

printf("MAT_GAIN_TAB \n")

printf("$Gain1 \\times Gain2$   = %e \n", AV1*AV2    );
printf("$Gain$   = %e  \n"              , GainFull   );

printf("MAT_GAIN_END \n")

%%  Gráficos db

hf_PASSO1 = figure ();
semilogx(f, 20*log10(abs(GainFreq)));
hold on;
xlabel ("f, Hz");
ylabel ("db(Gain)");
legend("Gain", "location", "northeast");
print (hf_PASSO1, "MAT_AB_AMP.eps", "-depsc");
hold off;

hf_PASSO2 = figure ();
semilogx(f, angle(GainFreq));
hold on;
xlabel ("f, Hz");
ylabel ("Phase (degrees)");
legend("Phase", "location", "northeast");
print (hf_PASSO2, "MAT_AB_PH.eps", "-depsc");
hold off;
