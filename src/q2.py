import numpy as np
import tqdm
import sys
sys.path.insert(0, "./lib")
import singlyconnected

pc = 0.592746

L = 2**9
num_samples = 100

num_ps = 50
ps = np.zeros((2, num_ps))
ps[0] = pc * (1 + 1e-9 + np.linspace(0, 0.1, num_ps))
ps[1] = pc * (1 - 1e-9 - np.linspace(0, 0.1, num_ps))

M_SC = np.zeros((2, num_ps))

for i in range(2):
    for j in tqdm.tqdm(range(num_ps)):
        M_SC[i, j] = singlyconnected.M_SC(ps[i, j], L, num_samples)
P_SC = M_SC / L**2

np.savetxt("tmp/q2.dat", np.column_stack((*np.abs(ps - pc), *P_SC)))
