close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

syms Vin
syms vout_t

syms R1
syms C1

syms n
syms R2
RESOLUCAO = 1000;

m = 100;
n = 20 + m;

Vin   = 100;

%%Vamos fazer o FullStabilizer

%Considerando que R1 + R2 = Cte
C1 = 10e-6

RESOLUCAO1    = 50;
RESOLUCAO2    = 4;
percentagem   = linspace(1/RESOLUCAO1,1-1/RESOLUCAO1,RESOLUCAO1-1);
a             = size(percentagem);

ripple        = zeros(RESOLUCAO2,a(2));
deltacontinuo = ripple;
Rtotal = 5e3
for d=1:RESOLUCAO2

  for c=1:(RESOLUCAO1-1)
    
    R1 = Rtotal*(c/RESOLUCAO1);
    R2 = Rtotal - R1;
    
    dados               = FullStabilizer(RESOLUCAO, R1, R2, C1, Vin, n, m);
    ripple(d,c)         = dados(2);
    deltacontinuo(d,c)  = dados(1);

  endfor

 Rtotal = Rtotal+5e3;
 
endfor

%%Gráficos
hold on
plot(percentagem*1e2,ripple(1,:))
plot(percentagem*1e2,ripple(2,:))
plot(percentagem*1e2,ripple(3,:))
plot(percentagem*1e2,ripple(4,:))
%plot(percentagem*1e2,deltacontinuo(1,:))
%plot(percentagem*1e2,deltacontinuo(2,:))
xlabel ("R1, %");
ylabel ("Voltage, V");
legend("Riplle 10k", "Riplle 5k", "Variação 10k", "Variação 5k");
%print (hf_PASSO3, "PASSO3.eps", "-depsc");
hold off;