library(ggplot2)
library(stringr)

data <- read.csv("data/train100-seed54321.dat", sep = " ", header = F)
#data$V5 <- str_detect(data$V5, "*")
#data$V5 <- gsub('*', '', data$V5)
data$V6 <- ifelse(data$V1 + data$V2 + data$V3 + data$V4 >= 2, 1, -1)
data$V7 <- NULL


sFile <- file("output/primal/s.txt", open = 'r')
wFile <- file("output/primal/w.txt", open = 'r')
gammaFile <- file("output/primal/gamma.txt", open = 'r')
lambdaFile <- file("output/dual/lambda.txt", open = 'r')

s <- readLines(sFile)
w <- readLines(wFile)
gamma <- readLines(gammaFile)
lambda <- readLines(lambdaFile)

#\d+\s*\d.\d*(e-\d\d|)

a <- str_extract_all("1 1.40163e-10    26 1.35625        51 1.40229e-10    76 1.40162e-10 77 1", "\\d+\\s*\\d.\\d*(e-\\d\\d|)")
a
