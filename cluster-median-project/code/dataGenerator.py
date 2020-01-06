# Creating Test DataSets using sklearn.datasets.make_blobs 
from sklearn.datasets.samples_generator import make_blobs 
from matplotlib import pyplot as plt  
from matplotlib import style 
  
style.use("fivethirtyeight") 
 

X, y = make_blobs(n_samples = 100, centers = 4,  cluster_std = 0.45, n_features = 2, random_state=42) 
  
plt.scatter(X[:, 0], X[:, 1], s = 40, color = 'b') 
plt.xlabel("X") 
plt.ylabel("Y") 
  
plt.show() 
plt.clf() 
print(X)
