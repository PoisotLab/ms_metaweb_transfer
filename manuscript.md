---
bibliography: [references.bib]
---
# Introduction

_Justification & pertinence_

Something brief on why we want/need to predict networks.

Something on the fact that networks contain information.
_Sensu lato_ we can decode them

Something on the idea of phylogenetic signal and how 
this is better than using functional traits (check last 
bit of statement though)

Painting scenario of how sometimes we have good info for 
one area and the idea of we want to take this someplace new.

> Fig: conceptual

# Methods

## Data

- network data
- IUCN checklist for Canada
- phylogeny from Upham et al.
- GBIF name checking and synonyms replacement

## Learning the origin network representation

- t-SVD / RDPG explanation
- selection of the embedding depth
- thresholding based on known data
- extraction of the left/right subspace

## Transfer learning through phylogenetic relatedness

- Pagel's $\lambda$
- brownian motion model for every trait
- prediction: Uniform distribution between min/max

## Probabilistic prediction of the destination network

- random draws from the Uniform
- 20k replicates
- P(int) = success/trials

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
