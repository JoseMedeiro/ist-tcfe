%%  Função do Estabilizador
function Resultado = FullStabilizer(RESOLUCAO, R1, R2, C1, Vin, n, m)

Resultado = 1:2;
t     = linspace(0,200e-3,RESOLUCAO);
vin_t = Vin*abs(real(e.^(j*50*2*pi*t)));
for c=1:RESOLUCAO
  
  if (vin_t(c) < 0.65*2)
    vin_t(c) = 0;
   else
    vin_t(c) = vin_t(c) - 0.65*2;
  endif
 
endfor


%%  Vamos chamar o envelope

ve_t    = Envelope(t, vin_t, R1, C1);

%%  Vamos chamar o retificador

vout_t  = Rectifier(t, ve_t, R2, n, m);

%Gráficos

%hold on
%plot(t*1e3,vin_t)
%plot(t*1e3,ve_t)
%plot(t*1e3,vout_t)
%xlabel ("t, ms");
%ylabel ("Voltage, V");
%legend("vd");
%print (hf_PASSO3, "PASSO3.eps", "-depsc");
hold off;

Media     = mean(real(vout_t));
Altitude  = max(real(vout_t)) - min(real(vout_t));
Distancia = Media-12;
TotalCost = (n*0.1 + R2/1e3);
merit = 1/((Altitude + abs(Distancia) + 1e-6)*TotalCost);


Resultado(1) = Media-12;
Resultado(2) = Altitude;

endfunction

