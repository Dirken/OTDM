#otdm visualization:
dataset <- read.csv("uo_nn_batchR.csv", sep = ";")

dataset_la1_bfgs <- dataset[dataset$la ==1,]
dataset_la1_bfgs <- dataset_la1_bfgs[dataset_la1_bfgs$isd==3,]

plot(dataset_la1_bfgs$te_acc)
min(dataset_la1_bfgs$te_acc)
