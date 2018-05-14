import numpy as np
import tqdm
import sys
sys.path.insert(0, "./lib")
import singlyconnected

pc = 0.592746

L = 2**9
num_samples = 100

ps = pc * (1 + 10.0**(np.linspace(-9, 0, 1001)))

M_SC = np.zeros(len(ps))

for i, p in enumerate(tqdm.tqdm(ps)):
    M_SC[i] = singlyconnected.M_SC(p, L, num_samples)
P_SC = M_SC / L**2

np.savetxt("tmp/q2.dat", np.column_stack((ps - pc, P_SC)))
