size <- c(100,214,500)
ampl <- c(53.084475, 215.96, 500)
python <- c(53.08447502, 381.36, 900.246)
timeampl <- c(1.95,61.37,5000)
timepy <- c(0.149,1.3,23.85)

dataset <- NULL

dataset$size <- size
dataset$ampl <- ampl
dataset$python <- python
dataset$timeampl <- timeampl
dataset$timepy <- timepy


data <- as.data.frame(dataset)

library(ggplot2)
ggplot(data) + 
  geom_point(data=data, aes(y = data$ampl, x = data$size, colour="ILP"), size=4) +
  geom_point(data=data, aes(y = data$python, x = data$size, colour="MST"), size=4) +   xlab("Size") + ylab("Objective function") +
  geom_line(data=data, aes(y = data$ampl, x = data$size, colour="ILP"), size=1) +
  geom_line(data=data, aes(y = data$python, x = data$size, colour="MST"), size=1) +
  ggtitle("Optimality between ILP and MST")


ggplot(data) + 
  geom_point(data=data, aes(y = data$timeampl, x = data$size, colour="ILP"), size=3) +
  geom_point(data=data, aes(y = data$timepy, x = data$size, colour="MST"), size=3) +   xlab("Size") + ylab("Time") +
  geom_line(data=data, aes(y = data$timeampl, x = data$size, colour="ILP"), size=1) +
  geom_line(data=data, aes(y = data$timepy, x = data$size, colour="MST"), size=1) +
  ggtitle("Time as size increases")
