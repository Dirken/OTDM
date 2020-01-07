dataset <- read.delim("../data/inputs/A3.txt", sep = " ", header = F)
D <- as.matrix(dist(dataset, method = "euclidean", upper = TRUE, diag = TRUE))
D <- round(D, digits=3)
write.table(D, file="../data/inputs/D3.txt", sep=" ", col.names = F, row.names = F)
  