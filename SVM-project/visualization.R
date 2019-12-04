library(ggplot2)
library(stringr)

data <- read.csv("data/train100-seed54321.dat", sep = " ", header = F)
data$V5 <- str_detect(data$V4, "*")
data$V6 <- NULL
data$V7 <- NULL
