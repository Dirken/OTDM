library(ggplot2)
library(stringr)

results$nu <- c(0.03125, 0.0625, 0.125, 0.25, 0.5, 1 , 2, 4, 8, 16, 32, 64, 128, 256)
results$train_acc <- c(0.53, 0.61, 0.82, 0.92, 0.94, 0.92, 0.94, 0.94, 0.93, 0.92, 0.92, 0.93, 0.93, 0.93)
results$test_acc <- c(0.51, 0.585, 0.785, 0.875, 0.905, 0.915, 0.91, 0.93, 0.9, 0.905, 0.91, 0.91, 0.91, 0.91)

results$nu[results$train_acc == max(results$train_acc)]

plot(log(nu), train_acc, type = 'b')

plot(log(nu), test_acc, type = 'b')

results$nu[results$test_acc == max(results$test_acc)]
