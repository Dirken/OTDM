import networkx as nx
G = nx.Graph()
G.add_edge('A', 'B', weight=4)
G.add_edge('B', 'D', weight=2)
G.add_edge('A', 'C', weight=3)
G.add_edge('C', 'D', weight=4)
G.add_edge('Z', 'Z', weight=0)

if nx.has_path(G, 'A', 'Z'):
	print("yes")
else:
	print("no")