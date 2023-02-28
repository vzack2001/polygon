# Based on `Point in Polygon Strategies`
# https://erich.realtimerendering.com/ptinpoly/

import numpy as np

class poly():
    def __init__(self, vertices=None, verbose=False):
        
        self.verbose = verbose

        # poligon vertices
        self.vertices = None
        self.edges = None

        self.xlim = None
        self.ylim = None

        # edge line coeffs (y = mx + c)
        self.m = None
        self.c = None

        # vertical & horizontal line mask
        self.mask_zero_x = None  # vertical edges
        self.mask_zero_y = None  # horizontal edges
        self.mask_a = None       # significant vertices
        self.mask_b = None       # significant horizontal edges
        
        if vertices is not None:
            if isinstance(vertices, np.ndarray):
                vertices = self._remove_doubles(vertices)
                self.vertices, self.edges = self._from_numpy(vertices)
        
        self.xlim, self.ylim = self._get_limits(self.vertices)
        self.m, self.c, self.mask_zero_x, self.mask_zero_y, self.mask_a, self.mask_b = self._calc_coeff(self.vertices, self.edges)

        pass  # __init__()

    def __repr__(self):
        s = f'v{np.shape(self.vertices)}, xlim={self.xlim}, ylim={self.ylim}'
        #print_ndarray(f'vertices', self.vertices, stats=False)
        #print_ndarray(f'edges', self.edges, stats=False)
        return s
    
    def _create_edges(self, v: np.ndarray, dtype=np.int32):
        e = np.zeros_like(v, dtype=dtype)
        e[:, 0] = np.arange(v.shape[0])
        e[:, 1] = e[:, 0] + 1   # (0, 1), (1, 2), etc.
        e[-1, 1] = e[0, 0]      # (last, 0)
        # e[:, 1] = np.roll(e[:, 0], -1)  # eq
        return e

    def _from_numpy(self, v: np.ndarray):
        e = self._create_edges(v)
        return v, e

    def _get_limits(self, v: np.ndarray):
        min_x = np.amin(v[...,0], axis=0)
        max_x = np.amax(v[...,0], axis=0)
        min_y = np.amin(v[...,1], axis=0)
        max_y = np.amax(v[...,1], axis=0)
        return (min_x, max_x), (min_y, max_y)

    def _remove_doubles(self, v: np.ndarray):
        """ remove points lying on 
            vertical or horizontal edges
        """
        e = self._create_edges(v)

        idx = e[:, 1]                  # (n_vertex,)  # np.roll(e[:, 0], -1)
        ridx = np.roll(e[:, 0], 1)     # (n_vertex,)  # np.argsort(idx)

        a = v[e]      # (n_vertex, 2, 2) (n_vertex, [edge0,edge1], [x,y])
        d = a[:,1,:] - a[:,0,:]        # (n_vertex, 2) [x1-x0, y1-y0]

        mask_zero_x = (d[...,0] == 0)  # (n_vertex,)  # vertical line
        mask_zero_y = (d[...,1] == 0)  # (n_vertex,)  # horizontal line

        mask_remove_x = np.logical_and(mask_zero_x, mask_zero_x[idx])[ridx]
        mask_remove_y = np.logical_and(mask_zero_y, mask_zero_y[idx])[ridx]
        
        mask_remove = np.logical_or(mask_remove_x, mask_remove_y)

        if self.verbose:
            print(f'remove {np.sum(mask_remove)} vertex')

        return v[np.logical_not(mask_remove)]

    def _calc_coeff(self, v: np.ndarray, e: np.ndarray):
        # calc line coef (y = mx + c)
        a = v[e]       # (n_vertex, 2, 2) (n_vertex, [edge0,edge1], [x,y])

        d = a[:,1,:] - a[:,0,:]  # (n_vertex, 2) [x1-x0, y1-y0]
        dx = d[...,0]  # (n_vertex, )
        dy = d[...,1]  # (n_vertex, )

        # y = mx + c
        x = a[...,0]   # (n_vertex, 2) [x0,x1]
        y = a[...,1]   # (n_vertex, 2) [y0,y1]

        m = np.divide(dy, dx)[..., None]        # (n_vertex, 1)
        c = (y - m * x)[:,0:1]                  # (n_vertex, 1)

        mask_zero_x = (dx == 0)  # (n_vertex,)  # vertical line
        mask_zero_y = (dy == 0)  # (n_vertex,)  # horizontal line

        idx = e[:, 1]                           # (n_vertex,)
        ridx = np.roll(e[:, 0], 1)              # (n_vertex,)

        # signifcant vertices (in, out) (change belonging)
        mask_a = (-dy * dy[idx] < 0)[ridx]      # (n_vertex,)

        # signifcant horizontal edge (vertex in, out)
        dy_prev = y[:,0] - np.roll(y[:,0], 1)   # (n_vertex,)
        dy_next = y[:,0] - np.roll(y[:,0],-2)   # (n_vertex,)

        mask_b = np.logical_and(dy_prev * dy_next < 0, mask_zero_y) # (n_vertex,)

        return m, c, mask_zero_x[...,None], mask_zero_y[...,None], mask_a[...,None], mask_b[...,None]

    def filter_limits(self, points: np.ndarray):
        x = points[...,0]
        y = points[...,1]
        mask_x = np.logical_and(x >= self.xlim[0], x <= self.xlim[1])
        mask_y = np.logical_and(y >= self.ylim[0], y <= self.ylim[1])
        mask = np.logical_and(mask_x, mask_y)
        return points[mask]

    def filter(self, points: np.ndarray):
        ptest = self.filter_limits(points)         # (n_ptest, 2)

        ones = np.ones(ptest.shape[0])             # (n_ptest,)

        e = self.edges

        v = np.expand_dims(self.vertices, axis=1)  # (n_vertex, 1, 2)
        d = v - ptest   # (n_vertex, n_ptest, 2)   # (n_vertex, n_ptest, [dx,dy])
        
        dx = d[:,:,0]   # (n_vertex, n_ptest)
        dy = d[:,:,1]   # (n_vertex, n_ptest)

        ytest = ptest[:, 1]                        # (n_ptest,)

        a = dx[e]       # (n_vertex, [dx_edge0, dx_edge1], n_ptest)
        a = np.prod(a, axis=1)

        mask_vertex_x = (dx == 0)   # (n_vertex, n_ptest)
        mask_edge_x = (a < 0)       # (n_vertex, n_ptest)

        b = dy[e]                   # (n_vertex, [edge0,edge1], n_ptest)
        b = np.prod(b, axis=1)
        
        mask_vertex_y = (dy == 0)   # (n_vertex, n_ptest)  # through vertex
        mask_edge_y = (b < 0)       # (n_vertex, n_ptest)  # cross edge

        mask_zero_x = np.logical_and(mask_edge_y, self.mask_zero_x)   # through vertical edge
        mask_zero_y = np.logical_and(mask_vertex_y, self.mask_zero_y) # through horizontal edge

        # calc intersection x-coord
        x = np.divide(ytest - self.c, self.m)      # (n_vertex, n_ptest)
        x[mask_zero_x] = (self.vertices[:, 0:1] * ones)[mask_zero_x]  # add x-coord for vertical edges
        mask_zero_a = np.logical_and(x == ptest[:, 0], mask_edge_y)   # through any other edge

        mask_on_edge = np.logical_and(mask_zero_y, mask_edge_x)
        mask_on_vertex = np.logical_and(mask_vertex_x, mask_vertex_y)
        
        # points lying on edges or vertices
        mask_inside = np.logical_or(mask_on_edge, mask_on_vertex)
        mask_inside = np.logical_or(mask_inside, mask_zero_a)
        mask_inside = np.any(mask_inside, axis=0)

        mask_edge = np.logical_not(mask_edge_y)  # inverse
        x[mask_edge] = np.inf

        mask_vertex_a = np.logical_and(mask_vertex_y, self.mask_a)
        mask_vertex_b = np.logical_and(mask_vertex_y, self.mask_b)
        mask_vertex = np.logical_or(mask_vertex_a, mask_vertex_b)
        mask_vertex = np.logical_or(mask_vertex, mask_zero_x)

        x[mask_vertex] = (self.vertices[:, 0:1] * ones)[mask_vertex]

        # add ptest x-coord
        x = np.concatenate([x, ptest[:, 0][None,...]], axis=0)

        mask_in = ((np.argsort(x, axis=0).argmax(0) + 1) % 2 == 0)
        mask_in = np.logical_or(mask_in, mask_inside)

        return mask_in  # ptest[mask_in]


    pass  # class poly()
