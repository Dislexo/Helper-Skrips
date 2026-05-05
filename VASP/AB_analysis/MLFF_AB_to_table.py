#!python
# out: NR N Vol/N E/N
import numpy as np

with open('ALLp.ML_AB', 'r') as f:
    for line in f:
        #skip all lines until "Configuration num."
        if 'Configuration num.' in line:
            CN = int(line.split('.')[1])
        if "The number of atoms" in line:
            next(f) #----- line
            A = int(next(f))
        if  "Primitive lattice vectors" in line:
            next(f) #----- line
            a = np.fromstring(next(f), sep=' ')
            b = np.fromstring(next(f), sep=' ')
            c = np.fromstring(next(f), sep=' ')
            V = np.abs(np.linalg.det(np.array((a,b,c))))
            VpA = V / A
        if "Total energy (eV)" in line:
            next(f) #----- line
            E = float(next(f))
            EpA = E / A
            print(CN,",",A, ",",V, ",",VpA, ",",E,",",EpA)
