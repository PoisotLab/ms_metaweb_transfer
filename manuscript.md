---
bibliography: [references.bib]
---
# Introduction

_Justification & pertinence_

Something brief on why we want/need to predict networks.

Something on the fact that networks contain information.
_Sensu lato_ we can decode them

Something on the idea of phylogenetic signal and how this is better than
using functional traits (check last bit of statement though) <!-- TP Marten
Winter has a paper on that -->

Painting scenario of how sometimes we have good info for 
one area and the idea of we want to take this someplace new.

important point to make -- there is a lot of method to predict interactions
within a network, but we also know that not all places HAVE networks -
so we need to move info across space -- let's end the intro on this

> Fig: conceptual

# Methods

## Data

We use data on the European metaweb assembled by {>>ref<<}. We use the
definition of the metaweb first introduced by DUNNE, *i.e.* an inventory of
all possible interactions within species from a spatially delimited pool.
The metaweb is not a prediction of the food web at any specific locale
within the frontiers of the species pool -- in fact, these local food webs
are expected to have a subset of both the species and the interactions of
their metaweb (POISOT BETADIV). This being said, as the metaweb represents
the total of functional, phylogenetic, and macroecological processes
(MORALLES CASTILLA), it is still worthy of ecological attention. We induced
the subgraph corresponding to all mammals by matching species names in the
original network first to the GBIF taxonomic backbone (REF), and retaining
all those who matched to mammals; all nodes had valid matches to GBIF at
this step, and so this backbone is used for all name reconciliation steps
as outlined below.

The European metaweb represents the knowledge we want to learn and transfer;
the support for transfer is here represented by the phylogenetic similarity
of mammals. We used the mammalian consensus supertree by UPHAM, for which
all approx. 6000 names have been similarly matched to their GBIF valid
names. This step allows us to place each node of the mammalian European
metaweb in the phylogeny.

The destination problem to which we want to transfer knowledge is the
trophic interactions between mammals in Canada. We obtained the list
of extant species from the IUCN checklist, and selected the terrestrial
and semi-aquatic species (this corresponds to the same selection that was
applied by REF in the European metaweb). The IUCN names were, as previously,
reconciled against GBIF to have an exact match to the taxonomy.

The European metaweb had XXX species, and the Canadian species pool had
YYY - of these, only 17 were shared, which highlights the need to rely
on a knowledge transfer approach. In the following sections, we describe
the representational learning step applied to European data, the transfer
step through phylogenetic similarity, and the generation of a probabilistic
metaweb for the destination species pool.

## Learning the origin network representation

The first step in transfer learning is to learn the structure of the
origin dataset. In order to do so, we rely on an approach inspired from
representational learning, where we learn a *representation* of the metaweb,
rather than a list of interactions. This approach is conceptually different
from other metaweb-scale predictions (*.e.g.* ALBOUY, others?), in that the
metaweb representation is easily transferable. Specifically, we use Random
Dot Product Graphs (RDPG) to create a number of latent variables that can be
combined into an approximation of the network adjacency matrix. RDPG results
are known to have strong phylogenetic signal, and to capture the evolutionary
backbone of food webs GVDR&Stouffer. In addition, recent advances show that
the latent variables produced this way can be used to predict *de novo*
interactions GVDRPreprint.

The latent variables are created by performing a truncated Singular Value
Decomposition (tSVD) on the adjacency matrix. SVD is an appropriate embedding
of ecological networks, which has recently been shown to both capture their
complex, emerging properties STRYDOM, and to allow highly accurate prediction
of the interactions within a single network HAYSTACK. Under tSVD, an adjacency
matrix $\mathbf{A}$ is decomposed into three components, so that $\mathbf{A}
= \mathbf{L}\mathbf{\Sigma}\mathbf{R}'$, where TK TANYA plz add some text.

The latent variables used for the RDPG, called the left and right subspaces,
are defined as $\mathcal{L} = \mathbf{L}\sqrt{\mathbf{\Sigma}}$, and
$\mathcal{R} = \sqrt{\mathbf{\Sigma}}\mathbf{R}$ -- using the full rank of
$\mathbf{A}$, $\mathcal{L}\mathcal{R}' = \mathbf{A}$, and using any smaller
rank results in $\mathcal{L}\mathcal{R}' \approx \mathbf{A}$. Using a rank
of 1 for the tSVD provides a first-order approximation of the network, etc.

The specific rank at which the SVD ought to be truncated is a difficult
question. The purpose of SVD is to remove the noise, expressed at high
dimensions, and to focus on the signal, expressed at low dimension. In datasets
with a clear signal/noise demarcation, the scree plot of $\mathbf{\Sigma}$
can show a sharp drop at the rank where noise starts. Alternatively,
REF showed that the profile likelihood (assuming a known distribution of
$\mathbf{\Sigma}$, or a normal distribution otherwise) peaks at the rank
maximizing the signal-to-noise ration. Because the European metaweb is almost
entirely known, the amount of noise is low; this is reflected in FIGREF, where
the scree plot shows no important drop, and in FIGREF where the proportion of
variance explained increases smoothly at higher dimensions. For this reason,
we default back to an arbitrary threshold that explain 60% of the variance
in the underlying data, corresponding to 12 dimensions.

Because RDPG relies on matrix multiplication, the higher dimensions essentially
serve to make specific interactions converge towards 0 or 1; therefore,
for reasonably low ranks, there is no guarantee that the values in the
reconstructed network will be within the unit range. In order to determine
what constitutes an appropriate threshold, we performed the RDPG approach
on the European metaweb, and evaluated the threshold by treating this as a
binary classification problem, specifically assuming that both 0 and 1 in
the European metaweb are all true. Given the methodological given in REF,
this seems like a reasonable assumption, although one that does not hold
for all metawebs. We used the thresholding approach presented in HAYSTACK,
and picked a cutoff that maximized Youden's J statistic; the resulting cutoff
was 0.22, and gave an accuracy above 0.99.

The left and right subspaces for the European metaweb, accompanied by the
threshold, represent the knowledge we seek to transfer. In the next section,
we explain how we rely on phylogenetic similarity to do so.

## Transfer learning through phylogenetic relatedness

In order to transfer the knowledge from the European metaweb to the Canadian
species pool, we performed ancestral character estimation using a Brownian
motion model REF. We assumed that all traits (*i.e.* the feature vectors
for the left and right subspaces) where independent, which is a reasonable
assumption as every trait/dimension added to the tSVD has an *additive*
effect to the one before it. The Brownian motion algorithm returns the
*average* value of the trait, and its upper and lower bounds. Because we do
not estimate other parameters of the traits distributions, we considered that
every species trait is represented as a uniform distribution between these
bounds. Therefore, the inferred left and right sub-spaces for the Canadian
species pool ($\hat{\mathcal{L}}$ and $\hat{\mathcal{R}}$) have entries that
are distributions, representing the range of values for a given species at
a given dimension.

These objects represent the transfered knowledge, which we can use for
prediction of the Canadian metaweb.

## Probabilistic prediction of the destination network

The phylogenetic reconstruction of $\hat{\mathcal{L}}$ and $\hat{\mathcal{R}}$
has an associated uncertainty, represented by the breadth of the
uniform distribution associated to each of their entries. Therefore,
we can use this information to assemble a *probabilistic* metaweb
REFPoisotProbaNet.

Specifically, we have adopted the following approach. For every entry
in $\hat{\mathcal{L}}$ and $\hat{\mathcal{R}}$, we draw a value from
its distribution. This results in one instance of the possible left
($\hat{\mathcal{l}}$) and right ($\hat{\mathcal{r}}$) subspaces for the
Canadian metaweb. These can be multiplied, to produced one matrix of real
values. Because the entries in $\hat{\mathcal{l}}$ and $\hat{\mathcal{r}}$
are in the same space where $\mathcal{L}$ and $\mathcal{R}$ were originally
predicted, it follows that the threshold $\rho$ estimated for the European
metaweb also applies. We use this information to produce one random Canadian
metaweb, $N = \hat{\mathcal{L}}$$\hat{\mathcal{R}}' \ge \rho$.

Because the intervals around some trait values can be broad, we repeat the
above process $2\times 10^5$ times, which results in a probabilistic metaweb
$P$, where the probability of an interaction (here conveying our degree of
trust that it exists given the inferred trait distributions) is given by the
number of times where it appears across all random draws $N$, divided by the
number of samples. An interaction with $P_{i,j} = 1$ means that these two
species were predicted to interact in all $2\times 10^5$ random draws, etc..

## Data cleanup, discovery, and validation

- carry over the European metaweb subset as having either P=0 or P=1
- search in GLOBI: found approx. 360 interactions we predicted, and 30 we didn't
- addition of GLOBI data as having P=1

## Implementation and code availability

The entire pipeline was implemented in *Julia* 1.6 REF, and is available
under the permissive MIT License at DOI. The taxonomic cleanup steps are
done using `GBIF.jl`. The network embedding and analysis is done using
`EcologicalNetworks.jl` REF. The phylogenetic simulations are done using
`PhyloNetworks.jl` REF and `Phylo.jl` REF. Complete `Project.toml` and
`Manifest.toml` files specifying the full tree of dependencies are available
alongside the code. The entire pipeline runs comfortably on a laptop.

# Results

## Model results

We now have space to unpack the results a bit more

Spend some time on the Brownian model stuff...

> Fig: Adjacency matrix

> Fig: Trophic vs omni


> Table: Top-ranked interactions (based on 'probability')

Idea here is to unpack these top results a bit more and look 
for supporting references in the literature.

## Validation results

potentially... I think it makes sense although I can see 
a case where it makes sense to rather have the validation 
stuff all together in the discussion section depending on 
the 'tone' we take

# Discussions

_order TBD_

I guess we need a phrase about how the approach is really 
good and amazing - > this can then maybe link into use-case 
scenarios probably

Potential use-case scenarios -> bringing in space and 
time potentially

A cautionary tale regarding validation. Interaction can 
never be a true negative. Cannot use a empirical subset 
of a bigger (predicated) network for validation -> 
because e.g. dietary shifts across range.
