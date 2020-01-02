param m;
param n;
param k;

param A{i in 1..m, j in 1..n};
param D{i in 1..m, j in 1..m};

var x{i in 1..m, j in 1..m} binary;

minimize obj_function:
	sum{i in 1..m, j in 1..m} D[i,j]*x[i,j];
	
#every point belongs to one cluster
subject to Constraint1 {i in 1..m}:
	sum{j in 1..m} x[i,j] = 1;
	
#exactly k clusters
subject to Constraint2:
	sum{i in 1..m} x[i,i] = k;

#a point may belong to a cluster iff cluster exists
subject to Constraint3 {j in 1..m}:
	m*x[j,j] >= sum{i in 1..m} x[i,j];
