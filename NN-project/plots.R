#otdm visualization:


dataset <- read.csv("uo_nn_batch.csv", sep = ";")

dataset$X <- NULL
dataset_targ_0 <- dataset[dataset$num_target == 0,]
dataset_targ_1 <- dataset[dataset$num_target == 1,]
dataset_targ_2 <- dataset[dataset$num_target == 2,]
dataset_targ_3 <- dataset[dataset$num_target == 3,]
dataset_targ_4 <- dataset[dataset$num_target == 4,]
dataset_targ_5 <- dataset[dataset$num_target == 5,]
dataset_targ_6 <- dataset[dataset$num_target == 6,]
dataset_targ_7 <- dataset[dataset$num_target == 7,]
dataset_targ_8 <- dataset[dataset$num_target == 8,]
dataset_targ_9 <- dataset[dataset$num_target == 9,]
