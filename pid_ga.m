
%{
This file contains an analysis performed to find an optimal PID controler for
the Aerogen2019 model, using a genetic algorithm (ga). The transfer function 
is loaded from an external file.
%}

%---------------------------------------------------------------------------------------------------
% SCRIPT

clear
tStart = tic;

% optimization options
options = optimoptions('ga', ...
                       'Display', 'iter', ...
                       'PopulationSize', 300, ...
                       'UseParallel', true ...
                      );

% preparing pool
delete(gcp('nocreate'))
p = parpool('local', 16);
p.IdleTimeout = 540;

% optimization process
[x,fval] = ga(@(x)target_PID(x), 3, [], [], [], [], [], [], [], options);

% loading transfer function from .mat file
f_tran = load('transfer_function.mat', 'f_tran').f_tran;

% modeling the optimal PID controler, and plotting the step response
cont = pid(x(1), x(2), x(3));
clf
step(feedback(cont * f_tran, 1))

fprintf(join(['elapsed time: ', num2str(toc(tStart)), '\n']))

% saving data...
if not(isfolder('analysis'))
    mkdir('analysis')
end

save(join(['analysis/ga_PID_', strrep(datestr(datetime('now')), ':', '_'), '.mat']))

% closing pool...
delete(gcp('nocreate'))

%---------------------------------------------------------------------------------------------------
% FUNCTIONS

function f=target_PID(x)
    %{
    Function to optimize, computes the area under the step response.

    Args:
        x (array): array with the optimization inputs (Kp, Ki, Kd).

    Return:
        This function returns the value of the variable to minimize.
    %}

    % loading transfer function from .mat file...
    f_tran = load('transfer_function.mat', 'f_tran').f_tran;

    % modeling the PID controler...
    cont = pid(x(1), x(2), x(3));
    step(feedback(cont * f_tran, 1));

    % computing the step response...
    dt = 0.01;
    t=0:dt:1;
    e = 1 - step(feedback(cont * f_tran, 1), t);

    % computing the area under the curve...
    f = sum(t' .* abs(e) * dt);

end
