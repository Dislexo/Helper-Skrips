#!/bib/python3

import pandas as pd
import matplotlib.pyplot as mpl
import numpy as np
from pymatgen.core import Composition


def Plotknown2D(A,B,X):
    E0=[-4.893802,-5.2159708,-4.966289] # La Pd O
    results = pd.read_fwf("K_struc.txt") # read file with pandas
    Formulas = results["Composition"].to_numpy() # eport Composition line
    KCompo=[[Composition(comp)['La'] for comp in Formulas] ,
            [Composition(comp)['Pd'] for comp in Formulas] ,
            [Composition(comp)['O' ] for comp in Formulas],
            results["Energy"].to_numpy()]  #Transform into matrix with Atomic composition
    KCompo=np.array(KCompo)
    KCompo=KCompo[:,KCompo[X,:] == 0] # Only keep all structures that do not contain structure X
    KCompx = KCompo[A, :]/(KCompo[B, :]+KCompo[A, :]) # recalculate into effective composition
    KEnthalpy = KCompo[3,:] - KCompx * E0[A]  - (1-KCompx) * E0[B] # set to reference Energy
    mpl.plot(KCompx,KEnthalpy, 'o',color="#FFFFFF00", ms= 15, mec = 'purple', label='Experimental',zorder=3)

def VertLine(comp,color,text):
    mpl.axvline(x=comp, color=color, linestyle="--", linewidth=0.5)
    mpl.text(comp, 0.2, text, rotation=90, va="top", ha="right", color=color,zorder=2)

def Convexhull(N_comps,top_comps,add=1):
    hull_index = np.arange(N_comps+add)
    repeat = True
    while (repeat == True):
        repeat = False
        for i in np.arange(1,np.size(hull_index)-1):  # 1 2 ... N-2
            pre = hull_index[i-1]
            post = hull_index[i+1]
            prex = top_comps[1,pre]
            posx = top_comps[1,post]
            x = top_comps[1,hull_index[i]]
            reference = top_comps[0,pre] + (top_comps[0,post]-top_comps[0,pre])* ((x-prex)/(posx-prex))
            if (top_comps[0,hull_index[i]] > reference): #kick out
                repeat=True
                hull_index=np.delete(hull_index,i)
                break
    return hull_index
