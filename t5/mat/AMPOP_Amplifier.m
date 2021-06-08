%%%%%%
%%
%%  Ideal Analysis
%%
%%  We analyse seperatly the gain stage and the output stage, both DC and AC. 
%%  It is good because we can approximate nice stuff (like Av = infinite; Zo of 
%%  the AMPOP = 0, Iin of the AMPOP = 0), that simplify greatly our calculations
%%
%%%%%%

%%  Circuit Data

Vin   = 0.01;
Vout  = Vin;
VCC   = 5;
VEE   = -5;

R1    = 1                   *1e3;
R2    = 1/(1/1 +1/1)        *1e3;
R3    = 300                 *1e3;
R4    = 1/(1/10 +1/10 +1/10)*1e3;

C1    = 220                 *1e-9;
C2    = 220                 *1e-9;

f0    = 1                   *1e3;
w0    = 2*pi*f0;

printf("VALUES_TAB \n")

printf("AMPOP      = %d  \n"    , 1           );
printf("\\#$R_1$   = %e  \n"    , R1          );
printf("\\#$R_2$   = %e  \n"    , R2          );
printf("\\#$R_3$   = %e  \n"    , R3          );
printf("\\#$R_4$   = %e  \n"    , R4          );

printf("\\&$C_1$   = %e  \n"    , C1          );
printf("\\&$C_2$   = %e  \n"    , C2          );

TotalCost = (R1+R2+R3+R4)*1e-3 + (C1+C2)*1e6 + 13.32*1e3;

printf("£Cost = %e  \n"         , TotalCost   );

printf("VALUES_END \n")


%%
%%  Ideal Circuit Transfer Function
%%

f = logspace(1,8,1000);
s = f*2*pi*j;

T =     ((R1*C1*s)./(R1*C1*s + 1))  .*...
        ((R4+R3)/R4)                .*...
        (1./(R2*C2*s+1));

ZI1 = R1 + 1/(j*C1*w0)

ZO1 = 1/(1/R2 + j*C2*w0)

%%
%%  Graphs for this little ones
%%

lol = 0*log10(abs(T)) + 20*log10(max(abs(T))) - 3;

hf_PASSO1 = figure ();
semilogx(f, 20*log10(abs(T)), f, lol);
hold on;
xlabel ("f, Hz");
ylabel ("db(Gain)");
legend("Gain", "Cutoff amplitude", "location", "northeast");
print (hf_PASSO1, "MAT_AB_AMP.eps", "-depsc");
hold off;

hf_PASSO2 = figure ();
semilogx(f, angle(T)*180/pi);
hold on;
xlabel ("f, Hz");
ylabel ("Phase (degrees)");
legend("Phase", "location", "northeast");
print (hf_PASSO2, "MAT_AB_PH.eps", "-depsc");
hold off;

%%  Tabela Gains

printf("MAT_GAIN_TAB \n")

printf("$Gain$   = %e  \n", max(abs(T)));

printf("MAT_GAIN_END \n")

%%  Tabela Impedance

printf("MAT_IMP_TAB \n")

printf("\\#$Z_{in}$  = %e +j*%e \n", real(ZI1), imag(ZI1));
printf("\\#$Z_{out}$ = %e +j*%e \n", real(ZO1), imag(ZO1));

printf("MAT_IMP_END \n")
