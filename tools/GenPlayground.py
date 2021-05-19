import numpy as np

def GenPlayground(l = 20, w = 2.5):
    s1 = ((l+1)/2 - w, (l+1)/2 + w)
    s2 = ((l+1)/2 + w, (l+1)/2 - w)

    # Itakura constraint Playground
    IP = np.zeros((l+1,l+1))
    IP[0, 0] = 1
    for i in range(1, l+1):
        for j in range(1, l+2-i):
            IP[i,j] = \
                ((i+0.5)/(j-0.5) >= s1[0]/s1[1]) and \
                ((i-0.5)/(j+0.5) <= s2[0]/s2[1])
    for i in range(1, l+1):
        for j in range(l+2-i, l+1):
            IP[i,j] = IP[l+1-i,l+1-j]
    IP = IP[1:, 1:]

    IP_cycle = IP.copy().astype('int16')
    IP_pe = IP.copy().astype('int16')
    pe_map = {6:6, 5:6, 4:5, 3:5, 2:4, 1:4, 0:3, -1:3, -2:2, -3:2, -4:1, -5:1}
    for i in range(l):
        for j in range(l):
            if IP[i,j]:
                IP_cycle[i,j] = i + j
                IP_pe[i,j] = pe_map[i-j]
            else:
                IP_cycle[i,j] = -1
                IP_pe[i,j] = -1
    
    return IP, IP_cycle, IP_pe
