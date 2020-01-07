import sys
import os
import numpy as np
import networkx as nx
from networkx import Graph
import matplotlib.pyplot as plt
from scipy.spatial import distance
from scipy.spatial.distance import pdist
from scipy.spatial.distance import squareform
import time

def takeDistance(element):
	return element[2]

def connected_components(G):
    seen = set()
    for v in G:
        if v not in seen:
            c = set(_plain_bfs(G, v))
            yield c
            seen.update(c)



def number_connected_components(G):

    return sum(1 for cc in connected_components(G))

def is_connected(G):

    if len(G) == 0:
        raise nx.NetworkXPointlessConcept('Connectivity is undefined ',
                                          'for the null graph.')
    return sum(1 for node in _plain_bfs(G, arbitrary_element(G))) == len(G)


def node_connected_component(G, n):

    return set(_plain_bfs(G, n))

def _plain_bfs(G, source):
    """A fast BFS node generator"""
    G_adj = G.adj
    seen = set()
    nextlevel = {source}
    while nextlevel:
        thislevel = nextlevel
        nextlevel = set()
        for v in thislevel:
            if v not in seen:
                yield v
                seen.add(v)
                nextlevel.update(G_adj[v])


class PrintGraph(Graph):
    """
    Example subclass of the Graph class.

    Prints activity log to file or standard output.
    """

    def __init__(self, data=None, name='', file=None, **attr):
        Graph.__init__(self, data=data, name=name, **attr)
        if file is None:
            import sys
            self.fh = sys.stdout
        else:
            self.fh = open(file, 'w')

    def add_node(self, n, attr_dict=None, **attr):
        Graph.add_node(self, n, attr_dict=attr_dict, **attr)
        self.fh.write("Add node: %s\n" % n)

    def add_nodes_from(self, nodes, **attr):
        for n in nodes:
            self.add_node(n, **attr)

    def remove_node(self, n):
        Graph.remove_node(self, n)
        self.fh.write("Remove node: %s\n" % n)

    def remove_nodes_from(self, nodes):
        for n in nodes:
            self.remove_node(n)

    def add_edge(self, u, v, attr_dict=None, **attr):
        Graph.add_edge(self, u, v, attr_dict=attr_dict, **attr)
        self.fh.write("Add edge: %s-%s\n" % (u, v))

    def add_edges_from(self, ebunch, attr_dict=None, **attr):
        for e in ebunch:
            u, v = e[0:2]
            self.add_edge(u, v, attr_dict=attr_dict, **attr)

    def remove_edge(self, u, v):
        Graph.remove_edge(self, u, v)
        self.fh.write("Remove edge: %s-%s\n" % (u, v))

    def remove_edges_from(self, ebunch):
        for e in ebunch:
            u, v = e[0:2]
            self.remove_edge(u, v)

    def clear(self):
        Graph.clear(self)
        self.fh.write("Clear graph\n")

def kMedoids(D, k, tmax=100):
    # determine dimensions of distance matrix D
    m, n = D.shape

    if k > n:
        raise Exception('too many medoids')

    # find a set of valid initial cluster medoid indices since we
    # can't seed different clusters with two points at the same location
    valid_medoid_inds = set(range(n))
    invalid_medoid_inds = set([])
    rs,cs = np.where(D==0)
    # the rows, cols must be shuffled because we will keep the first duplicate below
    index_shuf = list(range(len(rs)))
    np.random.shuffle(index_shuf)
    rs = rs[index_shuf]
    cs = cs[index_shuf]
    for r,c in zip(rs,cs):
        # if there are two points with a distance of 0...
        # keep the first one for cluster init
        if r < c and r not in invalid_medoid_inds:
            invalid_medoid_inds.add(c)
    valid_medoid_inds = list(valid_medoid_inds - invalid_medoid_inds)

    if k > len(valid_medoid_inds):
        raise Exception('too many medoids (after removing {} duplicate points)'.format(
            len(invalid_medoid_inds)))

    # randomly initialize an array of k medoid indices
    M = np.array(valid_medoid_inds)
    np.random.shuffle(M)
    M = np.sort(M[:k])

    # create a copy of the array of medoid indices
    Mnew = np.copy(M)

    # initialize a dictionary to represent clusters
    C = {}
    for t in xrange(tmax):
        # determine clusters, i. e. arrays of data indices
        J = np.argmin(D[:,M], axis=1)
        for kappa in range(k):
            C[kappa] = np.where(J==kappa)[0]
        # update cluster medoids
        for kappa in range(k):
            J = np.mean(D[np.ix_(C[kappa],C[kappa])],axis=1)
            j = np.argmin(J)
            Mnew[kappa] = C[kappa][j]
        np.sort(Mnew)
        # check for convergence
        if np.array_equal(M, Mnew):
            break
        M = np.copy(Mnew)
    else:
        # final update of cluster memberships
        J = np.argmin(D[:,M], axis=1)
        for kappa in range(k):
            C[kappa] = np.where(J==kappa)[0]

    # return results
    return M, C

def main():
	start_time = time.time()
	#Reads d and a
	d = np.loadtxt("../data/inputs/D2.txt")
	a = np.loadtxt("../data/inputs/A2.txt")
	vertex = 214
	numClusters = 6
	T = set()
	S = set()
	
	#Prims algorithm:
	S.add(0)
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
	#we drop the k-1 first elements which will lead to disconnect the graph into clusters:
	sortedEdges = sorted(T, reverse = True, key=takeDistance)[(numClusters-1):]  
	
	#we create a graph containing x-y-dist
	G = Graph()
	for i in range(vertex):
		G.add_node(i)
	for i in sortedEdges:
		G.add_edge(i[0], i[1], weight=i[2])

	clusters = nx.connected_components(G)

	#we calculate per each cluster the obj function
	iterator = 0
	medoids = []
	objectiveFunction = 0
	for c in clusters:
		points = []
		distancesMatrix = []
		for i in c:
			#Agafa les dades del cluster
			points.append([a[i][0], a[i][1]])
		#calcules la matriu de distancies D
		distancesMatrix = squareform(pdist(np.array(points), 'euclidean'))
		#print("---------------------------")
		#print(distancesMatrix)
		#calcules la suma per columnes de la matriu
		sumaColumna =  np.sum(distancesMatrix, axis=0)
		print(sumaColumna)
		#el medoide es el arg min d'aquest vector de sumes
		medoid = np.min(sumaColumna)
		print(medoid)
		#el obj value es la suma d'aquests valors
		objectiveFunction = objectiveFunction + medoid
		iterator +=1 

	

	end_time = time.time()
	print(end_time-start_time)

	
if __name__ == '__main__':
    main()