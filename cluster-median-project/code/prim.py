import sys
import os
import numpy as np

def takeDistance(element):
	return element[2]

def main():
	#read d and a
	d = np.loadtxt("../data/inputs/D.txt")
	vertex = 214
	T = set()
	S = set()
	
	S.add(0)
	print(S)
	while len(S) != vertex:
		edges = set()
		minEdge = [99999,99999,99999]
		for x in S:
			for k in range(vertex):
				if k not in S and d[x][k] != 0:
					if d[x][k] < minEdge[2]:
						minEdge[0] = x
						minEdge[1] = k
						minEdge[2] = d[x][k]

		T.add((minEdge[0], minEdge[1], minEdge[2]))
		S.add(minEdge[1])
		sortedEdges = sorted(T, reverse = True, key=takeDistance)[6:]
		print(sortedEdges)




	
if __name__ == '__main__':
    main()