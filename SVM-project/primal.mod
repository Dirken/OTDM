param numPoints;
param numVars;
param dimensions;

param nu; 
param train{m in 1..numPoints, n in 1..dimensions};
param x{m in 1..numPoints, n in 1..numVars};
param y{m in 1..numPoints};

# Decision variables
var s{m in 1..numPoints} >= 0;
var w{n in 1..numVars};
var gamma;

# Objective function
minimize obj_function:
	(1/2) * sum{n in 1..numVars} w[n]^2 + nu*sum{m in 1..numPoints} s[m];
	
subject to Constraint1 {m in 1..numPoints}:
	y[m]*((sum{n in 1..numVars} w[n]*x[m,n]) + gamma) + s[m] >= 1;          # m constraints