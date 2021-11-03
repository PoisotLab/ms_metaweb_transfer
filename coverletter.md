Dear members of the Methods in Ecology and Evolution editorial board,

On behalf of my co-authors, I am pleased to submit our manuscript entitled “Food
web reconstruction through phylogenetic transfer of low-rank network
representation” for consideration as a Research Article in Methods in Ecology
and Evolution. Prior to submission, we discussed this manuscript with Dr.
Nicolas Lecomte, who agreed to handle it. We originally submitted this
manuscript to Ecology Letters, where after a round of review, the changes made
in response to the reviewers brought us over the size limit. We have attached
the detailed document with comments from the EiC, AE, and three reviewers, as
well as our responses and a marked-up copy of the document. Furthermore, the
editorial board of Ecology Letters has agreed to communicate the identity of
reviewers should you want to invite them to assess the revised version (this
query can be directed by email to ecolets2@cefe.cnrs.fr, with the submission ID
ELE-01209-2021).

A central issue within the field of network ecology is that datasets on species
interactions (and the resulting networks) are incomplete and unevenly
distributed. This presents a major bottleneck to developing an understanding of
networks across large spatial scales. The challenge of sampling interactions
often makes data collection non-viable and has led to the development of a suite
of methods that focus on addressing incompleteness within known networks.
However, these methods are limited in their capacity to begin addressing
existing gaps, i.e. unknown interactions in unsampled places. In this
manuscript we present a methodological framework that will allow us to begin
filling these gaps.

This framework is built on the premise of transfer learning whereby we can focus
on the information (species interaction data) that we do have and 'bring this
with us' (through various statistical methods) to an area where this information
is lacking. We achieve this by learning a representation of the known network
through graph embedding and transferring what we have learnt about how those
species interact through a suitable medium (phylogeny) and using this to predict
how species in the target location might interact. We discuss this framework by
inferring and constructing the metaweb for Canadian terrestrial mammals using
the European metaweb as the knowledge source - despite the fact that these two
regions share only 4% of species. Additional analyses/scrutiny suggests that the
framework itself is robust both when the original network is incomplete or
contains spurious interactions.

The flexibility, robustness, and low computational cost of this transfer
learning framework makes it of interest and applicability to a wide range of
scenarios and potential usages. We envisage this workflow as a starting point to
begin filling in spatial gaps and facilitate thinking about species interaction
networks over large spatial scales, but could also have applicability within
network theory (e.g. extinction cascades) or pertaining to conservation
scenarios.

The manuscript is complemented by a series of online and annotated notebooks
that aid in explanation and provide readers with a starting point for
implementation in their own work. Of note is that entire workflow can be run on
a laptop in a matter of minutes, making this an accessible option for a broad
range of end users.

The work described here has not been published elsewhere. All authors agree with
the the manuscript content and its submission to the journal. No part of this
manuscript has been published in any form elsewhere or is being considered for
publication elsewhere while it is being considered for publication in this
journal. This manuscript appeared as a preprint on EcoEvoRXiV with the following
DOI: 10.32942/osf.io/y7sdz.

We look forward to your editorial decision on this manuscript.
