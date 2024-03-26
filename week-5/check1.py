import numpy as np
import random

A = np.array([
    [0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 5, 0, 0, 0],
])

B = np.array([
    [0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 0],
])

C = np.array([
    [0, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 0, 0, 1],
    [0, 1, 0, 10, -1, 0, 4, -13],
])

x = random.randint(1,1000)
y = random.randint(1,1000)

out = 5*x**3 -4*y**2*x**2 + 13*x*y**2 + x**2 - 10*y

v1 = x*x
v2 = y*y
v3 = v1*v2
v4 = v2*x

w = np.array([1, out, x, y, v1, v2, v3, v4])

result = C.dot(w) == np.multiply(A.dot(w), B.dot(w))
assert result.all(), "result is invalid"