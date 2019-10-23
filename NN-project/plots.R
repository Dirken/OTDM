#otdm visualization:


dataset <- read.csv("uo_nn_batchR.csv", sep = ";")

dataset$X <- NULL
#by target
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


dataset_la0 <- dataset[dataset$la == 0,]
dataset_la1 <- dataset[dataset$la == 1,]
dataset_la10 <- dataset[dataset$la == 10,]

mean(dataset_la0$te_acc)
mean(dataset_la1$te_acc)
mean(dataset_la10$te_acc)

b1 <- barplot(dataset_la0$te_acc, main="Data from lambda=0",  xlab="Experiments", ylab="t_acc")
#text(b1, labels=dataset_la0$num_target, xpd=F)

barplot(dataset_la1$te_acc, main="Data from lambda=1",  xlab="Experiments", ylab="t_acc")
barplot(dataset_la10$te_acc, main="Data from lambda=10",  xlab="Experiments", ylab="t_acc")


#Jo ara per ara agafaria lambda 1 perquè és el que més accuracy té.
#Per altra part, el que faria després és agafar el metode 3 perquè convergeix molt més ràpid però no sé
#si realment el que et comento és com hauria de ser o no.

plot(dataset_la1$niter)
#aqui pots veure dos grups i realment, pots veure que uns son de bfgs i els altres de gm
dataset_la1_g <- dataset_la1[dataset_la1$isd == 1,]
dataset_la1_bfgs <- dataset_la1[dataset_la1$isd == 3,]

plot(dataset_la1_g$niter)
plot(dataset_la1_bfgs$niter)

#idk
