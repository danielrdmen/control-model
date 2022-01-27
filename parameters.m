
%{
model parameters file
In this file is defined the function that computes the model parameters.
%}

%---------------------------------------------------------------------------------------------------
% MODEL PARAMETERS

function [Vw, w, wn, psi, Rho, Rpala, Tf, Bm, Ke, J, La, Ra, R, c1, c2, c3, c4, c5, c6] = ...
    parameters(verbose)
    %{
    Function that computes the model parameters.

    Args:
        verbose (bool): if true, the parameters are displayed in terminal.

    Return:
        This function returns the model parameters.
    %}

    % wind speed in the operating point (m/s)
    Vw = 10;
    
    % turbine angular speed in the operating point (rad/s)
    w = 50;
    
    % natural frequency of the second order actuator (Hz)
    wn = 30;
    
    % damping ratio of the second order actuator (dimensionless)
    psi = 0.80;
    
    % air density (ISA, kg/m^3)
    Rho = 1.225;
    
    % blade radius (m)
    Rpala = 1.6;
    
    % resistance torque of the generator (N*m)
    Tf = 0.1;
    
    % friction coefficient (N*m*s/rad)
    Bm = 0.001;
    
    % electromotive forces par constant (V*s/rad)
    Ke = 1.3717;
    
    % Moment of inertia (N*m)
    J = 0.1;
    
    % generator inductance (H)
    La = 0.028;
    
    % generator resistance (Ω)
    Ra = 2.58;
    
    % wires resistance (Ω)
    R = 10;
    
    % constants to compute Cp using semi-empirical methods (dimensionless)
    c1 = 0.51763;
    c2 = 116;
    c3 = 0.4;
    c4 = 5;
    c5 = 21;
    c6 = 0.006795;

    % if verbose, the parameters are displayed...
    if verbose
        fprintf(join(['Model parameters: \n', ...
            '   wind speed in the operating point (m/s): ', num2str(Vw), '\n', ...
            '   turbine angular speed in the operating point (rad/s): ', num2str(w), '\n', ...
            '   natural frequency of the second order actuator (Hz): ', num2str(wn), '\n', ...
            '   damping ratio of the second order actuator (dimensionless)', num2str(psi), '\n', ...
            '   air density (ISA, kg/m^3): ', num2str(Rho), '\n', ...
            '   blade radius (m): ', num2str(Rpala), '\n', ...
            '   resistance torque of the generator (N*m): ', num2str(Tf), '\n', ...
            '   friction coefficient (N*m*s/rad): ', num2str(Bm), '\n', ...
            '   electromotive forces par constant (V*s/rad): ', num2str(Ke), '\n', ...
            '   Moment of inertia (N*m): ', num2str(J), '\n', ...
            '   generator inductance (H): ', num2str(La), '\n', ...
            '   generator resistance (Ω): ', num2str(Ra), '\n', ...
            '   wires resistance (Ω): ', num2str(R), '\n', ...
            '   constants to compute Cp (dimensionless), c1: ', num2str(c1), '\n', ...
            '   constants to compute Cp (dimensionless), c2: ', num2str(c2), '\n', ...
            '   constants to compute Cp (dimensionless), c3: ', num2str(c3), '\n', ...
            '   constants to compute Cp (dimensionless), c4: ', num2str(c4), '\n', ...
            '   constants to compute Cp (dimensionless), c5: ', num2str(c5), '\n', ...
            '   constants to compute Cp (dimensionless), c6: ', num2str(c6), '\n\n']))
    end

end
