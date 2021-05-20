%%  Função do Envelope

%%Função Principal
function V2_t = Envelope(t, V1_t, R, C1)

DIODO_ON  = 1;
DIODO_OFF = 0;

%%  Atribuição de Valores
deltat = t(2)-t(1);

V2_t = zeros(size(t));

DIODO_ON  = 1;
DIODO_OFF = 0;

%%Condições Iniciais
estado1 = DIODO_ON;
estado2 = DIODO_ON;

v2      = V1_t(1);
V2_t(1) = v2;
for c = 2:size(t,2)
  
  %Descobrir se o diodo muda de estado
  if (estado1 == DIODO_ON)
    estado2 = find_off(V1_t(c), V1_t(c-1), deltat, R, C1);
  else
    estado2 = find_on (V1_t(c), V2_t(c-1), deltat, R, C1);
  endif
  
  %Calcular 
  if (estado2 == DIODO_ON)
    V2_t(c) = V1_t(c);
  else
    V2_t(c) = C_offline(V2_t(c-1), deltat, R, C1);
  endif
  
  %Atualizar estados
  estado1 = estado2;
  
endfor

%Gráficos
%hf_PASSO3 = figure ();
%hold on
%plot(t*1e3,V2_t)
%xlabel ("t, ms");
%ylabel ("Voltage, V");
%legend("vd");
%print (hf_PASSO3, "PASSO3.eps", "-depsc");
%hold off;


endfunction

function state  = find_off  (Vin_2, Vin_1, deltat, R, C)
  % 0 é off
  % 1 é on
  
  V2_1 = Vin_1;
  V2_2 = V2_1*exp(-deltat/(R*C));
  
  if V2_2 < Vin_2
    state = 1;
  else
    state = 0;
  endif

endfunction
function state  = find_on   (Vin_2, V2_1 , deltat, R, C)
  % 0 é off
  % 1 é on
  
  V2_2 = V2_1*e^(-deltat/(R*C));
  
  if (V2_2 < Vin_2)
    state = 1;
  else
    state = 0;
  endif
  
endfunction
function v      = C_offline (       V2_1 , deltat, R, C)
  
  v = V2_1*e^(-deltat/(R*C));

endfunction

%