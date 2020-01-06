dataset <- read.delim("../data/inputs/A2.txt", sep = " ", header = F)
D <- as.matrix(dist(dataset, method = "euclidean", upper = TRUE, diag = TRUE))
write.table(D, file="../data/inputs/D2.txt", sep=" ", col.names = F, row.names = F)
  