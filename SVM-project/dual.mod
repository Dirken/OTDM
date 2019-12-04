param numPoints;
param numVars;
param dimensions;

param nu;
param train{m in 1..numPoints, n in 1..dimensions};
param x{m in 1..numPoints, n in 1..numVars};
param d{m in 1..numPoints};

param K{i in 1..numPoints, j in 1..numPoints};

# Decision variables
var lambda{m in 1..numPoints} >= 0, <= nu;

# Objective function
maximize obj_function:
	sum{m in 1..numPoints} lambda[m] - (1/2)*sum{mi in 1..numPoints, mj in 1..numPoints} lambda[mi]*d[mi]*lambda[mj]*d[mj]*K[mi,mj];
	
subject to Contraint1:
	sum{m in 1..numPoints} lambda[m]*d[m] = 0;