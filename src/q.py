import numpy as np
import sys
sys.path.insert(0, "./lib")
import singlyconnected

pc = 0.592746

Lpowmin = 4
Lpowmax = 10
Ls = np.asarray([2**i for i in range(Lpowmin, Lpowmax + 1)])
num_samples = [2**16 / L for L in Ls]

M_SC = [
    singlyconnected.M_SC(pc, L, int(samples))
    for (L, samples) in zip(Ls, num_samples)
]

D, b = np.polyfit(np.log(Ls), np.log(M_SC), deg=1)
M_SC_approx = np.exp(b) * Ls**D

np.savetxt("tmp/q.dat", np.column_stack((Ls, M_SC, M_SC_approx)))
np.savetxt("tmp/qD.dat", [D], fmt="%.3f")
