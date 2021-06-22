#! /usr/bin/env bash

# Figure on the consequences of cutoff
cd figures; convert cutoff-interactions.png cutoff-connectance.png +append _figure-cutoffs.png

# Figure on the observed vs. imputed subspaces
convert subspaces.png imputed-subspaces.png -append _tmp-subspaces.png
convert _tmp-subspaces.png -rotate 270 _figure-subspaces.png

# Figure on the subspaces variance
convert screeplot.png varexplained.png +append _figure-screeplot.png

# Figure on adjacency matrix
cp adjacencymatrices.png _figure-adjacencymatrices.png

# Figure on the biological meaning of left/right subspaces
convert left-gen.png right-vuln.png +append _figure-degree.png

# Cleanup
rm _tmp*.png
