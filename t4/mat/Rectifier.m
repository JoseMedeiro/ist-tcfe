%%  Função do Retificador

%%Função Principal
function vf_t = Rectifier(t, ve_t, R2, n, m)

Is  = 1e-14;
VT  = 26e-3;

%%  Atribuição de Valores

Ve = mean(ve_t);
vd = solve_vD (Ve, R2, n);

id  = Is*(exp(vd/(VT*n))-1);
rd = VT*n/( Is*(exp(vd/(VT*n))));

Rdiodo = rd*(m/n);
Rtotal = R2 + Rdiodo;


if m!=0
cost = 0.1/((Rdiodo/m)/1e3);
endif

Racio = (rd*((n-m)/n))/(Rtotal);
I_t = (ve_t-Ve)/(R2+rd);

% Assumimos que a diferença de potencial é igual em todos os diodos
vf_t = (vd + I_t*rd)*(n-m)/(n);

endfunction

%%Funções Suporte
function f = f(vD,vS,R,n)
Is  = 1e-14;
VT  = 26e-3;

f   = vD + R*Is*(exp(vD/(VT*n))-1) - vS;
endfunction

function fd = fd(vD,R,n)
Is  = 1e-14;
VT  = 26e-3;

fd  = 1 + R*Is/(VT*n)*(exp(vD/(VT*n)));
endfunction

function vD_root = solve_vD (vS, R, n)
  delta = 1e-9;
  x_next = 0.70;

  do 
    x       = x_next;
    x_next  = x - f(x, vS, R, n)/fd(x, R, n);
  until (abs(x_next-x) < delta)

  vD_root = x_next;
endfunction
function v_out = tr(t, vS, R, n)
 v_out = zeros(1,length(t));
 for i=1:length(t)
    vD = solve_vD  (vS(i), R, n);
    v_out(i) = vD;
  endfor
endfunction 

%