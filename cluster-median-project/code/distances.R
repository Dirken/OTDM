dataset <- read.delim("../data/inputs/A.txt", sep = " ", header = F)

D <- matrix(0.0, nrow = 214, ncol = 214)

for(j in 1:nrow(dataset)){
  for(k in 1:nrow(dataset)){
    D[j,k] <- sqrt(sum(dataset[j,]-dataset[k,])^2)
  }
}

write.table(D, file="../data/inputs/D.txt", sep=" ", col.names = F, row.names = F)
