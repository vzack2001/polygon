import numpy as np
import matplotlib.pyplot as plt

from polygon import poly
from util import draw_points, draw_poly

def get_test_polygon(v: np.ndarray=None):
    #define test polygon vertices
    if v is None:
        v = [   [3.5, 1], [4, 1.5], 
                [5, 1], [6, 2], [6, 3], [7, 2], [8, 2], [8, 0.5], [7.5, 0.5], [7.25, 0], 
                [7, 1], [6, 1], [5, 0], [4, 0]
            ]
    return np.asarray(v, dtype=np.float32)

def get_test_points(v: np.ndarray=None):
    # define test points
    if v is None:
        #v = [[0.5, 1], [2, 2.2], [5, 3.5], [5, 2], [6.5, 2.3], [8.5, 2.5], [7.5, 1], [6.5, 1], [5, 0.5], [5, -0.5], [3, 1]] # 
        #v = [[2, 2.2], [5, 2], [6.5, 2.3], [7.5, 1], [6.5, 1], [5, 0.5], [3, 1]] # 
        #v = [[4.5, 0], [5.5, 1.5], [6.5, 1], [7.3, 0.5], [8.3, 0.5]] # [4.5, 0], [6.5, 1.6], [6.5, 2.3], [6.5, 1], [5, 1], [7.5, 1] , [7.5, 0.5] 

        v = [   [5, 3], [6, 3], [7, 3.0],
                    [5, 2.5], [6, 2.5], [6.25, 2.5], [6.5, 2.5], [7, 2.5],
                    [5, 2], [6, 2], [6.5, 2], [7, 2], [8, 2],
                    [3.5, 1.5], [4, 1.5], [5, 1.5], [5.5, 1.5], [7.5, 1.5], [8., 1.5],
                    [3.5, 1], [4, 1], [5, 1], [6, 1], [6.5, 1], [7, 1], [8, 1],
                    [4, 0.5], [5, 1.5], [8, 1],
                    [3.75, 0.5], [4, 0.5], [5.5, 0.5], [7.2, 0.5], [7.75, 0.5], [8., 0.5],
                    [3.75, 0], [4, 0], [4.5, 0], [6, 0], [7.25, 0], [8., 0]]
    return np.asarray(v, dtype=np.float32)

if __name__ == '__main__':
 
    v = get_test_polygon()
    ax = draw_poly(v, figsize=(10,5), xlim=(3, 9), ylim=(-1, 4), color='#00fa', annotate=True)

    ptest = get_test_points()
    draw_points(ptest, color='#f00a', annotate=True, ax=ax)

    pl = poly(v)
    print(pl)

    p = pl.filter(ptest)
    draw_points(ptest[p], s=150, edgecolors='#0f0f', color='#0000', annotate=False, ax=ax)
    
    plt.show()
    print('Ok')
