library(ggplot2)
library(stringr)

setwd('C:/Users/Marc PC/Desktop/OTDM/SVM-project')

data <- read.csv("data/train100-seed54321.dat", sep = " ", header = F)
data$V7 <- gsub('[*]', '', data$V7)
data$V5 <- data$V7 
data$V6 <- ifelse(data$V1 + data$V2 + data$V3 + data$V4 >= 2, 1, -1)
data$V7<- NULL


sFile <- file("output/primal/s.txt", open = 'r')
wFile <- file("output/primal/w.txt", open = 'r')
gammaFile <- file("output/primal/gamma.txt", open = 'r')
lambdaFile <- file("output/dual/lambda.txt", open = 'r')

s <- readLines(sFile)
w <- readLines(wFile)
gamma <- readLines(gammaFile)
lambda <- readLines(lambdaFile)

#\d+\s*\d.\d*(e-\d\d|)
######s
s <- s[-length(s)] #""
s <- s[-length(s)] #";"
s<- s[-1] #"s [*] :=" 
s <- gsub("$", "                          ", s)
#a <- regexec("\\d\\.+\\d\\d\\d\\d\\V\\V\\V\\V\\V", s)
a<- str_extract_all(s, "\\d\\.+\\d\\d\\d\\V\\V\\V\\V\\V\\V")

s.primal<- double(100)
for(i in 1:length(a)) {
  for(j in 1:length(a[[i]])) {
    s.primal[i+((j-1)*length(a))]<- a[[i]][j]
  }
}
s.primal <- as.data.frame(as.numeric(s.primal))

######W
w <- w[-1]
w <- w[-length(w)]
w <- w[-length(w)]
wa<- str_extract_all(w, "\\d\\.+\\d\\d\\d\\d\\d")
w.primal <-double(4)
for (q in 1:length(wa)) {
  w.primal[q] <- wa[[q]]
}
w.primal <- as.data.frame(as.numeric(w.primal))




##########gama
gammaa<- str_extract_all(gamma, "[-]\\d\\.+\\d\\d\\d\\d")
gamma.primal <- as.data.frame(as.numeric(gammaa[[1]]))



######lambda
lambda <- lambda[-length(lambda)]
lambda <- lambda[-length(lambda)]
lambda <- lambda[-1]
lambda <- gsub("$", "                          ", lambda)
lambda.string <- str_extract_all(lambda, "[0-9]+([.][0-9]+e-[0-9]+)|\\s\\d\\d\\d\\s|\\s[0-9]+[.][0-9]+\\s")
lambda.string[[25]][4] <- lambda.string[[25]][5]
length(lambda.string[[25]]) <- 4 
lambda.dual<- double(100)
for(i in 1:length(lambda.string)) {
  for(j in 1:length(lambda.string[[i]])) {
    lambda.dual[i+((j-1)*length(lambda.string))]<- lambda.string[[i]][j]
  }
}
lambda.dual <- as.data.frame(as.numeric(lambda.dual))



remove(gammaa)
remove(wa)
remove(a)
remove(lambda.string)
remove(gamma)
remove(gammaFile)
remove(i)
remove(j)
remove(lambda)
remove(lambdaFile)
remove(q)
remove(s)
remove(sFile)
remove(w)
remove(wFile)


###Primal form prediction
options(scipen = 100)

data$prediction <- 0
w.x <- 0
for (i in 1:nrow(data)) {
  for(j in 1:4) {
    w.x <- w.x + w.primal[j,1]*data[i,j]
  }
  if((w.x + gamma.primal[[1]] + s.primal[i,1]) >= 1) {
    data$prediction[i] <- +1 
  }
  else if((w.x + gamma.primal[[1]] + s.primal[i,1]) <= -1) {
    data$prediction[i] <- -1
  }
  w.x <- 0
}

data$correct <- data$prediction == data$V6
