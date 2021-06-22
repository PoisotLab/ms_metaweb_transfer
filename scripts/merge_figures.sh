#! /usr/bin/env bash

# Figure on the consequences of cutoff
cd figures; convert cutoff-interactions.png cutoff-connectance.png +append figure-cutoffs.png

# Figure on the observed vs. imputed subspaces
convert subspaces.png imputed-subspaces.png -append _tmp-subspaces.png
convert _tmp-subspaces.png -rotate 270 figure-subspaces.png

# Figure on the subspaces variance
convert screeplot.png varexplained.png +append figure-screeplot.png

# Figure on adjacency matrix
cp adjacencymatrices.png figure-adjacencymatrices.png

# Figure on the biological meaning of left/right subspaces
convert left-gen.png right-vuln.png +append figure-degree.png

# Cleanup
rm _tmp*.png
