%run(trimado)
%% Definir tiempo de retardo y constante de tiempo
h=1/100000;
t=0:h:0.3;
response=step(f_tran,t);
response_t=diff(response)/h;
response_tt=diff(response_t)/h;
[M,tin] = min(abs((response_tt)));

m=response_t(tin);
yin=response(tin);

k=2.15;
T=k/m;
n=m*tin*h-yin;
L=n/m;

%% constantes de controlador PID


T_i=2*L;
Td=0.5*L;

k_p=1.2*T/L
k_i=k_p/T_i
k_d=k_p*Td

%%
cont=pid(k_p,k_i,k_d)
step(feedback(cont*f_tran,1))
