import numpy as np
import random

# WARNING: this is failing for some reason I can't figure out!!!

A = np.array([
# [1, out, x, y, v1, v2, v3, v4, v5, v6, v7]
  [0, 0  , 0, 1, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 1, 0, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 1, 0, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 0, 1 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 0, 0 , 0 , 1 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 0, 0 , 0 , 0 , 1 , 0 , 0 , 0 ],
  [0, 0  , 0, 0, 0 , 1 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 0, 1 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 0, 2 , 0 , 0 , 0 , 0 , 0 , 0 ],
])

B = np.array([
# [1, out, x, y, v1, v2, v3, v4, v5, v6, v7]
  [0, 0  , 0, 1, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 1, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 1, 0, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 0, 0 , 0 , 1 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 1, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 1, 0, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 0, 0 , 0 , 1 , 0 , 0 , 0 , 0 ],
  [0, 0  , 0, 1, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
  [0, 0  , 1, 0, 0 , 0 , 0 , 0 , 0 , 0 , 0 ],
])

C = np.array([
# [1, out,  x,  y, v1, v2, v3, v4,  v5, v6, v7],
  [0, 0  ,  0,  0, 1 , 0 , 0 , 0 ,  0 ,  0, 0 ],
  [0, 0  ,  0,  0, 0 , 1 , 0 , 0 ,  0 ,  0, 0 ],
  [0, 0  ,  0,  0, 0 , 0 , 1 , 0 ,  0 ,  0, 0 ],
  [0, 0  ,  0,  0, 0 , 0 , 0 , 1 ,  0 ,  0, 0 ],
  [0, 0  ,  0,  0, 0 , 0 , 0 , 0 ,  1 ,  0, 0 ],
  [0, 0  ,  0,  0, 0 , 0 , 0 , 0 ,  0 ,  1, 0 ],
  [0, 0  ,  0,  0, 0 , 0 , 0 , 0 ,  0 ,  0, 1 ],
  [0, 0  ,  0, -2, 3 , 0 , 0 , 0 ,  0 ,  0, 0 ],
  [0, 2  , -2,  0, 0 , 3 , 0 , 2 , -4 , -1, 1 ],
])

x = random.randint(1,1000)
y = random.randint(1,1000)

out = (0.5*y**2 - 1.5*y + 1)*x + (-y**2 + 2*y)*x**2 + (0.5*y**2 - 0.5*y)*x**3

v1 = y  * y
v2 = x  * y
v3 = x  * x
v4 = v1 * v3
v5 = v3 * y
v6 = v4 * x
v7 = v2 * v3

w = np.array([1, out, x, y, v1, v2, v3, v4, v5, v6, v7])

print("A.w = ", A.dot(w))
print("B.w = ", B.dot(w))
print("A.w x B.w", np.multiply(A.dot(w), B.dot(w)))
print("C.w = ", C.dot(w))


result = C.dot(w) == np.multiply(A.dot(w), B.dot(w))
assert result.all(), "result is invalid"