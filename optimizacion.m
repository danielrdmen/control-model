


[x,fval] = ga(@(x)optimiza_PID(x),3) 

function f=optimiza_PID(x)


s=tf('s')

f_tran=(2.437220078803965e+04*s+1.095008163976924e+07)/(s^4+5.083537205488497e+02*s^3+2.864166171813920e+04*s^2+6.852631388200964e+05*s+5.080214818614967e+06)

kp=x(1)
ki=x(2)
kd=x(3)

cont=pid(kp,ki,kd)


step(feedback(cont*f_tran,1))

dt=1/100;

t=0:dt:1;
e=1-step(feedback(cont*f_tran,1),t);



f=sum(t'.*abs(e)*dt);


end



