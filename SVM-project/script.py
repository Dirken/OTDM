from amplpy import AMPL, Environment
import sys
import os
ampl = AMPL(Environment('C:/Users/Meyerhofer/Desktop/UNI/OTDM/SVM-project/ampl_mswin64'))

size = range(-5, 9)

#for each nu:
def main():
	for i in range(-5, 9):
		f = open("data/nu.txt", "w")
		nu = 2**i
		print("----------------------------------------")
		print("nu= " + str(nu))
		f.write(str(nu))
		f.close()
		os.system("ampl_mswin64\\ampl dual.run")
		
		f = open("output/dual/acc_train.txt", "r") 
		acc_train = f.read()
		acc_trainValue = acc_train.split(" = ")[1].split("\n")[0]
		print("Train accuracy= " + str(acc_trainValue))
		f.close()

		f = open("output/dual/acc_test.txt", "r") 
		acc_test = f.read()
		acc_testValue = acc_test.split(" = ")[1].split("\n")[0]
		print("Test accuracy= " + str(acc_testValue))
		f.close()

		#os.system("dual.run")



		

if __name__ == '__main__':
    main()