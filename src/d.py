import numpy as np

N = 1000000
f = np.zeros(N)

# /Pstart/ #
z = np.random.uniform(size=N)**(-3 + 1)
z = np.sort(z)
P = np.arange(1, N + 1) / N

diff = (P[1:] - P[:-1]) / (z[1:] - z[:-1])
f[1:-1] = 0.5 * (diff[1:] + diff[:-1])
f[0] = diff[0]
f[-1] = diff[-1]

a, b = np.polyfit(np.log(z), np.log(f), deg=1)
# /Pend/ #

lastindex = np.searchsorted(z, 10)

np.savetxt("tmp/d_P.dat",
           np.column_stack((z, P))[:lastindex:lastindex // 1000])
np.savetxt("tmp/d_f.dat",
           np.column_stack((z, f))[:lastindex:lastindex // 1000])
np.savetxt("tmp/d_fapprox.dat",
           np.column_stack((z,
                            np.exp(b) * z**a))[:lastindex:lastindex // 1000])
np.savetxt("tmp/d_a.dat", [a], fmt="%.3f")
