# Saddle Node Infinite Period (SNIPER) model

## Dependancies
sniperNW.m requires makePlots.m and sniper_function.m.

L2_v_sigma.m requires sniperNW.m and sniper_function.m.  
*NOTE*: if running this file it is useful to disable the construction of plots
by commenting out the line near the bottom of sniperNW.m.

meanfield.m has no dependancies.

## Function
sniperNW.m integrates a network of *N* SNIPER oscillators. It returns the L2 norm of the order parameter. It is possible to disable plots by commenting out the
line 'makeplots(~)' near the bottom of the file. 

L2_v_sigma.m works in tandem with sniperNW.m to create simulations of the relation between the L2 norm and the coupling strength.

meanfield.m is separate from the other files and numerically integrates the mean field equations of the SNIPER model.

![\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}](https://latex.codecogs.com/svg.latex?\Large&space;x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}) 
