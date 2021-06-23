#! /usr/bin/env bash

# Figure on the consequences of cutoff
cd figures; convert cutoff-interactions.png cutoff-connectance.png +append figure-cutoffs.png

# Figure on the observed vs. imputed subspaces
convert combined-empirical.png combined-prediction.png +append figure-subspaces.png

# Figure on the subspaces variance
convert screeplot.png varexplained.png +append figure-screeplot.png

# Figure on the biological meaning of left/right subspaces
convert left-gen.png right-vuln.png +append figure-degree.png

# Figure on inflation + degree distribution
convert inflation-comparison.png final-degree.png +append figure-validation.png

