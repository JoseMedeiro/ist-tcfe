%%  Função do Estabilizador

RESOLUCAO = 3000;
R1        = 75e3;
R2        = 75e3;
C1        = 150e-6;
Vin       = 130.8317;
n         = 18;
m         = 0;

Resultado = 1:2;
t     = linspace(0,200e-3,RESOLUCAO);
vin_t = Vin*abs(real(e.^(j*(50*2*pi*t + pi/2))));

for c=1:RESOLUCAO
  
  if (vin_t(c) < 0.75*2)
    vin_t(c) = 0;
   else
    vin_t(c) = vin_t(c) - 0.75*2;
  endif
 
endfor


%%  Vamos chamar o envelope

ve_t_f    = Envelope(t, vin_t, R1, C1);

%%  Vamos chamar o retificador

vout_t_f  = Rectifier(t, ve_t_f, R2, n, m);

%%  Retirar o intervalo de tempo que queremos
c = 1;
while t(c) < 10e-3
  c = c +1;
endwhile
t_hold = c;
t_g    = linspace(t(t_hold),200e-3,RESOLUCAO-t_hold+1);

ve_t    = t_g;
vout_t  = t_g;
for c=t_hold:RESOLUCAO
  
  ve_t(c-t_hold+1)    = ve_t_f(c);
  vout_t(c-t_hold+1)  = vout_t_f(c);
  
endfor
  
%Gráficos
hf_PASSO4 = figure();
hold on
plot(t_g*1e3,ve_t)
plot(t_g*1e3,vout_t)
xlabel ("t, ms");
ylabel ("Voltage, V");
legend("v_{envelope}", "v_{out}");
print (hf_PASSO4, "PASSO4.eps", "-depsc");
hold off;

hf_PASSO41 = figure();
hold on
plot(t_g*1e3,ve_t)
xlabel ("t, ms");
ylabel ("Voltage, V");
legend("v_{envelope}");
print (hf_PASSO41, "PASSO41.eps", "-depsc");
hold off;

hf_PASSO42 = figure();
hold on
plot(t_g*1e3,vout_t)
xlabel ("t, ms");
ylabel ("Voltage, V");
legend("v_{out}");
print (hf_PASSO42, "PASSO42.eps", "-depsc");
hold off;

hf_PASSO5 = figure();
hold on
plot(t_g*1e3,vout_t - 12)
xlabel ("t, ms");
ylabel ("Voltage, V");
legend("v_{out} - 12V");
print (hf_PASSO5, "PASSO5.eps", "-depsc");
hold off;


Media     = mean(real(vout_t));
Altitude  = max(real(vout_t)) - min(real(vout_t));
Distancia = Media-12;
TotalCost = ((n+4)*0.1 + (R1 + R2)/1e3 + C1*1e6);
merit = 1/((Altitude + abs(Distancia) + 1e-6)*TotalCost);

printf("VALUES_TAB \n")

printf("$n$ = %e \n"            , 130.8317/230);
printf("Diodes  = %d + %d  \n"  , 18, 4       );
printf("\\#$R_1$   = %e  \n"    , R1          );
printf("\\#$R_2$   = %e  \n"    , R2          );
printf("\\&$C_1$   = %e  \n"    , C1          );



printf("VALUES_END \n")

printf("MAT_TAB \n")

printf("£$Custo$ = %e  \n", TotalCost   );
printf("$Ripple$ = %e \n" , Altitude    );
printf("$Distance$ = %e\n", Distancia   );

printf("MAT_END \n")
