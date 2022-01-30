
%{
This file contains an analysis performed to calculate the trimming point of
the model in the operation point specified. Then, the model is linearizated
near the trimming point, and the dynamic response is analyzed.
%}

%---------------------------------------------------------------------------------------------------
% SCRIPT

clear
tStart = tic;

model = 'Aerogen2019';
diary_folder = 'analysis';

% setting diary
diary_name = strcat('trimming_', strrep(datestr(datetime('now')), ':', '_'), '.txt');
if not(isfolder(diary_folder)) 
    mkdir(diary_folder); 
end
diary([diary_folder, '/', diary_name])
diary on

fprintf('---------------------------------------------------------------------------------------\n')
fprintf('MODEL TRIMMING AND LINEARIZATION\n')
fprintf(join(['datetime: ', datestr(datetime('now')), '\n']))
fprintf(join(['model: ', model, '\n']))
fprintf('functions used: trim & linmod\n')
fprintf('---------------------------------------------------------------------------------------\n')
fprintf('\n')

% loading model parameters
[Vw, w, wn, psi, Rho, Rpala, Tf, Bm, Ke, J, La, Ra, R, c1, c2, c3, c4, c5, c6] = parameters(true);

% calculating trimming point using trim function...
x0 = [w; 1; -1; 0];
u0 = -1;
y0 = w;
ix = [];
iu = [];
iy = 1;

[x_trim, u_trim, y_trim, dx_trim] = trim(model, x0, u0, y0, ix, iu, iy);

fprintf(join(['Trimming point: \n', ...
            '   x0: ', mat2str(x0), '\n', ...
            '   u0: ', mat2str(u0), '\n', ...
            '   y0: ', mat2str(y0), '\n', ...
            '   x_trim: ', mat2str(x_trim), '\n', ... 
            '   u_trim: ', mat2str(u_trim), '\n', ...
            '   y_trim: ', mat2str(y_trim), '\n', ...
            '   dx_trim: ', mat2str(dx_trim), '\n\n']))

% linealizing the model near the trimming point...
[num, den] = linmod(model, x_trim, u_trim);

fprintf(join(['Model linearization: \n', ...
            '   num: ', mat2str(num), '\n', ...
            '   den: ', mat2str(den), '\n\n']))

% computing transfer function...
f_tran = tf(num, den);
save('transfer_function', 'f_tran')
fprintf('Model transfer function: \n')
zpk(f_tran)

% computing model poles...
fprintf('Model poles: \n')
damp(f_tran)

% show step response...
step(f_tran)
filename = join(['analysis/trim_step_response_', strrep(datestr(datetime('now')), ':', '_'), ...
    '_plot.eps']);
exportgraphics(gcf, filename, 'Resolution', 700)

% show root locus...
rlocus(f_tran)
filename = join(['analysis/trim_root_locus_', strrep(datestr(datetime('now')), ':', '_'), ...
    '_plot.eps']);
exportgraphics(gcf, filename, 'Resolution', 700)

% show bode diagram...
bode(f_tran)
filename = join(['analysis/trim_bode_diagram_', strrep(datestr(datetime('now')), ':', '_'), ...
    '_plot.eps']);
exportgraphics(gcf, filename, 'Resolution', 700)

% show nyquist diagram...
nyquist(f_tran)
filename = join(['analysis/trim_nyquist_diagram_', strrep(datestr(datetime('now')), ':', '_'), ...
    '_plot.eps']);
exportgraphics(gcf, filename, 'Resolution', 700)

fprintf(join(['\nelapsed time: ', num2str(toc(tStart)), '\n']))

diary off
