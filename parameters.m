
%{
model parameters file
In this file are defined the different parameters of the wind turbine
model.
%}

%---------------------------------------------------------------------------------------------------
% MODEL PARAMETERS

% blade radius (m)
Rpala = 1.6;

% resistance torque of the generator (N * m)
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
