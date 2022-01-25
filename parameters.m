
%{
model parameters file
In this file are defined the different parameters of the wind turbine
model.
%}

%---------------------------------------------------------------------------------------------------
% MODEL PARAMETERS

% wind speed (m/s)
Vw = 10;

% natural frequency (Hz)
wn = 30;

% damping ratio (dimensionless)
psi = 0.80;

% air density (ISA, kg/m^3)
Rho = 1.225;

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

% constants to compute Cp using semi-empirical methods (dimensionless)
c1 = 0.51763;
c2 = 116;
c3 = 0.4;
c4 = 5;
c5 = 21;
c6 = 0.006795;
