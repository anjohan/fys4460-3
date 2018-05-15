import numpy as np
import tqdm
import sys
sys.path.insert(0, "./lib")
import singlyconnected

pc = 0.592746

L = 2**9
num_samples = 100

num_ps = 20
ps = pc * (1 + np.logspace(np.log10(0.01), np.log10(0.15), num_ps))

M_SC = np.zeros(num_ps)

for j in tqdm.tqdm(range(num_ps)):
    M_SC[j] = singlyconnected.M_SC(ps[j], L, num_samples)
P_SC = M_SC / L**2

a, b = np.polyfit(np.log(np.abs(ps - pc)), np.log(P_SC), deg=1)
P_SC_approx = np.exp(b) * (ps - pc)**a

np.savetxt("tmp/q2.dat", np.column_stack((np.abs(ps - pc), P_SC, P_SC_approx)))
np.savetxt("tmp/q2exp.dat", [a], fmt="%.3f")
