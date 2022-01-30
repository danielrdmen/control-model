
%{
This file contains an analysis performed to find an optimal PID controler for
the Aerogen2019 model, using the second Ziegler-Nichols aproximation.
%}

%---------------------------------------------------------------------------------------------------
% SCRIPT

clear
tStart = tic;

% loading transfer function from .mat file...
f_tran = load('transfer_function.mat', 'f_tran').f_tran;

%{ 
after a trial and error process, the Kcr that makes the
step response oscilatory has been obtained...
%}
Kcr = 3.26458;
cont = pid(Kcr, 0, 0);
step(feedback(cont * f_tran, 1), 1);
filename = join(['analysis/PID_ziegler_nichols_II_testing_', strrep(datestr(datetime('now')), ...
    ':', '_'), '_plot.eps']);
exportgraphics(gcf, filename, 'Resolution', 700)

% zooming into the first oscilation, the period Pcr is calculated...
h = 1 / 10000;
t = 0.05:h:0.2;
response = step(feedback(cont * f_tran, 1), t);
[~, imax] = max(response);
[~, imin] = min(response);
Pcr = 2 * abs(t(imax) - t(imin));

% calculating PID controler constants...
Ti = 0.5 * Pcr;
Td = 0.125 * Pcr;
Kp = 0.6 * Kcr;
Ki = Kp / Ti;
Kd = Kp * Td;

fprintf('Optimal PID, Ziegler-Nichols aproximation, method II\n\n')
fprintf(join(['Kp: ', num2str(Kp), '\n']))
fprintf(join(['Ki: ', num2str(Ki), '\n']))
fprintf(join(['Kd: ', num2str(Kd), '\n\n']))

% testing step response...
cont = pid(Kp, Ki, Kd);
step(feedback(cont * f_tran, 1));
filename = join(['analysis/PID_ziegler_nichols_II_', strrep(datestr(datetime('now')), ':', '_'), ...
    '_plot.eps']);
exportgraphics(gcf, filename, 'Resolution', 700)

fprintf(join(['elapsed time: ', num2str(toc(tStart)), '\n']))

% saving data...
if not(isfolder('analysis'))
    mkdir('analysis')
end

save(join(['analysis/PID_ziegler_nichols_II_', strrep(datestr(datetime('now')), ':', '_'), '.mat']))
