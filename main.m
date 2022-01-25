clear

parameters

model = 'Aerogen2019';

opspec = operspec(model);

opspec.States(2).Known = 1;
opspec.States(2).x = 50;

opt = findop(model, opspec, findopOptions('OptimizerType', 'simplex'))
