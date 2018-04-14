import time
import numpy as np
from scipy.ndimage.measurements import label

L = 10000
x = np.random.uniform(size=(L, L))
y = x > 0.5

t0 = time.time()
z = label(y)
t1 = time.time()

print("PYTHON time: %g" % (t1 - t0))
