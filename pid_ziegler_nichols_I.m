
%{
This file contains an analysis performed to find an optimal PID controler for
the Aerogen2019 model, using the first Ziegler-Nichols aproximation.
%}

%---------------------------------------------------------------------------------------------------
% SCRIPT

clear
tStart = tic;

% loading transfer function from .mat file...
f_tran = load('transfer_function.mat', 'f_tran').f_tran;

% analyzing the step response and calculating the inflection point...
h = 1 / 100000;
t = 0:h:0.3;
response = step(f_tran, t);
response_t = diff(response) / h;
response_tt = diff(response_t) / h;
[M, tin] = min(abs((response_tt)));
m = response_t(tin);
yin = response(tin);

% calculating the delay time (L) and the time constant (T)...
k = 2.15;
T = k / m;
n = m * tin * h - yin;
L = n / m;

% calculating PID controler constants...
Ti = 2 * L;
Td = 0.5 * L;
Kp = 1.2 * T / L;
Ki = Kp / Ti;
Kd = Kp * Td;

fprintf('Optimal PID, Ziegler-Nichols aproximation, method I\n\n')
fprintf(join(['Kp: ', num2str(Kp), '\n']))
fprintf(join(['Ki: ', num2str(Ki), '\n']))
fprintf(join(['Kd: ', num2str(Kd), '\n\n']))

% testing step response...
cont = pid(Kp, Ki, Kd);
step(feedback(cont * f_tran, 1));
filename = join(['analysis/PID_ziegler_nichols_I_', strrep(datestr(datetime('now')), ':', '_'), ...
    '_plot.eps']);
exportgraphics(gcf, filename, 'Resolution', 700)

fprintf(join(['elapsed time: ', num2str(toc(tStart)), '\n']))

% saving data...
if not(isfolder('analysis'))
    mkdir('analysis')
end

save(join(['analysis/PID_ziegler_nichols_I_', strrep(datestr(datetime('now')), ':', '_'), '.mat']))
