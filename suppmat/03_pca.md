# S.M.3 - RDPG reconstructed networks have diverse structures

In this appendix, we check that the networks reconstructed from the RDPG do
keep a variety of structural components, especially when selecting small species
pools from within them. In order to do so, we induced 400 random subgraphs
containing between 30 and 70 species, both from the Canadian and European
metawebs. For each of these subgraphs, we measured eight variables: the mean and
standard deviation of trophic levels, the standard deviation of degree (total,
in, and out), and the proportion of top, intermediate, and basal species. We
selected a random subset of 300 rows from the network-property matrix to fit a
Principal Component Analysis projection matrix ($W$), which we then used to
project all networks into the space formed by the first two principal
components.

![](./figures/supplementary/variation_pca.png)

The first axis (explaining most variance) was strongly correlated to the
standard deviation of the number of preys (-0.71), and the second axis to the
standard deviation in the number of predators (-0.95). These results match the
conclusions in main text, namely that the first dimensions of network embedding
capture the degree distribution.

Two things are important to note on this representation; each point is an
induced sub-graph, and the ellipses are the 95% confidence interval around the
points. First, there is some variations *within* a group (Europe *v.* Canada);
second, the two groups do not fully overlap. This suggests that not only the
sub-samples of the Canadian metaweb are not equivalent to the sub-samples of the
European metaweb (*i.e.* the two networks have structural differences),
realizations (here in the form of random local species pools) of the Canadian
metaweb also show some variability; in short, reconstructing a metaweb using a
RDPG will not result in homogeneous local networks, and may therefore be
suitable for lower-scale predictions.
