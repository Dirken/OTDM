# Author: Jordi Castro
#
# Example of usage of libsvm and liblinear under scikit-learn module
#
import numpy as np
import time
from sklearn import svm
from sklearn.datasets import load_svmlight_file
from sklearn.metrics import classification_report

##### load colon-cancer instance

X_train, y_train = load_svmlight_file("colon-cancer")
X_test= X_train
y_test= y_train

print("Dataset: colon-cancer")
print("Total dataset size:")
print("n_samples: %d" % X_train.shape[0])
print("n_features: %d" % X_train.shape[1])

##### libsvm: rbf kernel and dual problem

t0= time.clock();
rbf_dual = svm.SVC(kernel='rbf', gamma= 'auto', C=1, verbose=1)
rbf_dual.fit(X_train, y_train)
y_pred= rbf_dual.predict(X_test)
print('accuracy= ',(sum(y_pred==y_test)/y_test.size)*100,'%')
print('CPU time= ',time.clock()-t0)
print(classification_report(y_test, y_pred))

##### libsvm: linear kernel and dual problem

t0= time.clock();
linear_dual = svm.SVC(kernel='linear', gamma= 'auto', C=1, verbose=1)
linear_dual.fit(X_train, y_train)
y_pred= linear_dual.predict(X_test)
print('accuracy= ',(sum(y_pred==y_test)/y_test.size)*100,'%')
print('CPU time= ',time.clock()-t0)
print(classification_report(y_test, y_pred))

##### liblinear: no kernel and primal problem

t0= time.clock();
linear_primal = svm.LinearSVC(C=1,max_iter=1000, verbose=1,dual=False)
linear_primal.fit(X_train, y_train)
y_pred= linear_primal.predict(X_test)
print('accuracy= ',(sum(y_pred==y_test)/y_test.size)*100,'%')
print('CPU time= ',time.clock()-t0)
print(classification_report(y_test, y_pred))

##### load usps instance

X_train, y_train = load_svmlight_file("usps.binary-ge5-lt5")
X_test, y_test = load_svmlight_file("usps.binary-ge5-lt5.t")

print("Dataset: usps.binary-ge5-lt5")
print("Total dataset size:")
print("n_samples: %d" % X_train.shape[0])
print("n_features: %d" % X_train.shape[1])

##### libsvm: rbf kernel and dual problem

t0= time.clock();
rbf_dual = svm.SVC(kernel='rbf', gamma= 'auto', C=1, verbose=1)
rbf_dual.fit(X_train, y_train)
y_pred= rbf_dual.predict(X_test)
print('accuracy= ',(sum(y_pred==y_test)/y_test.size)*100,'%')
print('CPU time= ',time.clock()-t0)
print(classification_report(y_test, y_pred))


##### libsvm: linear kernel and dual problem

t0= time.clock();
linear_dual = svm.SVC(kernel='linear', gamma= 'auto', C=1, verbose=1)
linear_dual.fit(X_train, y_train)
y_pred= linear_dual.predict(X_test)
print('accuracy= ',(sum(y_pred==y_test)/y_test.size)*100,'%')
print('CPU time= ',time.clock()-t0)
print(classification_report(y_test, y_pred))

##### liblinear: no kernel and primal problem

t0= time.clock();
linear_primal = svm.LinearSVC(C=1,max_iter=10000, verbose=1,dual=False)
linear_primal.fit(X_train, y_train)
y_pred= linear_primal.predict(X_test)
print('accuracy= ',(sum(y_pred==y_test)/y_test.size)*100,'%')
print('CPU time= ',time.clock()-t0)
print(classification_report(y_test, y_pred))

