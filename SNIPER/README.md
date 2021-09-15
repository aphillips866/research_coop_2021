# Saddle Node Infinite Period (SNIPER) model

## Dependancies
sniperNW.m requires makePlots.m and sniper_function.m.

meanfield.m has no dependancies.

## Function
sniperNW.m integrates a network of *N* SNIPER oscillators. It returns the L2 norm of the order parameter. It is possible to disable plots by commenting out the
line 'makeplots(~)' near the bottom of the file. 

L2_v_sigma.m works in tandem with sniperNW.m to create simulations of the relation between the L2 norm and the coupling strength.

meanfield.m is separate from the other files and numerically integrates the mean field equations of the SNIPER model.
