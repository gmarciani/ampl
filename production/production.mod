#===============================================================================
# PRODUCTION PROBLEM (Script)
#
# A company produces products P.
# Each product is sold at price Pprice.
# Each product needs a work of Pwork hours at price Wprice euros/hour.
# A product needs an amount of Pm kg of prime materials M.
# Each prime material costs Mprice euro/kg.
# The company can acquire Mmax kg of prime material, monthly.
# Determine the monthly production plan of products, so to maximize the
# monthly profit.
#===============================================================================
reset;

#===============================================================================
# PARAMETERS
#===============================================================================
set P;                  # products
set M;                  # prime materials
param Pprice {P} >= 0;  # sell price of product p (euro/unit)
param Pwork {P} >= 0;   # working hour for product p (hour/unit)
param Wprice >= 0;      # work-hour price (euro)
param Pmat {P,M} >= 0;  # prime material needed by product p (kg)
param Mprice {M} >= 0;  # price of prime material m (euro/kg)
param Mmax {M} >= 0;    # prime material monthly limit (kg/month)

#===============================================================================
# DECISION VARIABLES
#===============================================================================
var x {P} >= 0 integer; # production unit of product p.

#===============================================================================
# OBJECTIVE
#===============================================================================
maximize profit:
    + sum {p in P} (Pprice[p]*x[p])
    - Wprice*sum {p in P} (Pwork[p]*x[p])
    - sum {p in P, m in M} (Mprice[m]*Pmat[p,m]*x[p]);

#===============================================================================
# BOUNDS
#===============================================================================
subject to material_limit {m in M}: # prime material monthly limit
    sum {p in P} (Pmat[p,m]*x[p]) <= Mmax[m];
