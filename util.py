# draw polygon and test points
import numpy as np
import matplotlib.pyplot as plt


def draw_points(points: np.ndarray, annotate=False, ax=None, **kwargs):
    if ax is None:
        ax = plt.gca()

    plt.scatter(points[:, 0], points[:, 1], **kwargs)
    if annotate:
        for i, (x, y) in enumerate(points):
            ax.annotate(str(i), (x+0.1, y+0.1))
    return ax


def draw_poly(vertices: np.ndarray, figsize=(15,3), xlim=(0, 9), ylim=(0, 9), annotate=True, **kwargs):

    plt.figure(figsize=figsize)
    plt.xlim(*xlim)
    plt.ylim(*ylim)
    plt.grid(color='b', linestyle='-', linewidth=0.2)

    # draw poligon vertices
    ax = draw_points(vertices, annotate=annotate, **kwargs)

    # draw poligon edges
    edges = np.zeros_like(vertices, dtype=np.int32)
    edges[:, 0] = np.arange(vertices.shape[0])
    edges[:, 1] = np.roll(edges[:, 0], -1)

    for e in edges:
        x = [vertices[v, 0] for v in e]
        y = [vertices[v, 1] for v in e]
        plt.plot(x, y)

    return ax
