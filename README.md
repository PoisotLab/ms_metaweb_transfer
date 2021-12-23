# Introduction

There are two core challenges we are faced with in furthering our understanding
of ecological networks across space, particularly at macro-ecologically relevant
scales [*e.g.* @Trojelsgaard2016EcoNet]. First, ecological networks within a
location are difficult to sample properly [@Jordano2016ChaEco;
@Jordano2016SamNet], resulting in a widespread "Eltonian shortfall"
[@Hortal2015SevSho], *i.e.* a lack of knowledge about inter- and intra- specific
relationships. This first challenge has been, in large part, addressed by the
recent emergence of a suite of methods aiming to predict interactions within
*existing* networks, many of which are reviewed in @Strydom2021RoaPre. Second,
recent analyses based on collected data [@Poisot2021GloKno] or metadata
[@Cameron2019UneGlo] highlight that ecological networks are currently studied in
a biased subset of space and bioclimates, which impedes our ability to
generalize any local understanding of network structure. Meaning that, although
the framework to address incompleteness *within* networks exists, there would
still be regions for which, due to a *lack* of local interaction data, we are
unable to infer potential species interactions. Having a general solution for
inferring *potential* interactions (despite the unavailability of interaction
data) could be the catalyst for significant breakthroughs in our ability to
start thinking about species interaction networks over large spatial scales. In
a recent overview of the field of ecological network prediction,
@Strydom2021RoaPre identified two challenges of interest to the prediction of
interactions at large scales. First, there is a relative scarcity of relevant
data in most places globally -- paradoxically, this restricts our ability to
infer interactions to locations where inference is perhaps the least required;
second, accurate predictions often demand accurate predictors, and the lack of
methods that can leverage small amount of data is a serious impediment to our
predictive ability globally.

Here, we present a general method to recommend potential trophic interactions,
relying on the transfer learning of network representations, specifically by
using similarities of species in a biologically/ecologically relevant proxy
space (*e.g.* shared morphology or ancestry). Transfer learning is a machine
learning methodology that uses the knowledge gained from solving one problem and
applying it to a related (destination) problem [@Torrey2010TraLea;
@Pan2010SurTra]. In this instance, we solve the problem of predicting trophic
interactions between species, based on knowledge extracted from another species
pool for which interactions are known by using phylogenetic structure as a
medium for transfer. There is a plurality of measures of species similarities
that can be used for inferring *potential* species interactions *i.e.* metaweb
reconstruction [see *e.g.* @Morales-Castilla2015InfBio]; however, phylogenetic
proximity has several desirable properties when working at large scales.
@Gerhold2015PhyPat made the point that phylogenetic signal captures
diversification of characters (large macro-evolutionary process), but not
necessarily community assembly (fine ecological process); @Dormann2010EvoCli
previously found very similar conclusions. Interactions tend to reflect a
phylogenetic signal because they have a conserved pattern of evolutionary
convergence that encompasses a wide range of ecological and evolutionary
mechanisms [@Mouquet2012EcoAdv; @Cavender-Bares2009MerCom], and - most
importantly - retain this signal even when it is not detectable at the community
scale [@Poisot2018IntRet; @Hutchinson2017CopSig]. Finally, species interactions
at macro-ecological scales seem to respond mostly to macro-evolutionary
processes [@Price2003MacThe]; which is evidenced by the presence of conserved
backbones in food webs [@Mora2018IdeCom; @DallaRiva2016ExpEvo], strong
evolutionary signature on prey choice [@Stouffer2012EvoCon], and strong
phylogenetic signature in food web intervality [@Eklof2016PhyCom]. Phylogenetic
reconstruction has also previously been used within the context of ecological
networks, namely understanding ancestral plant-insect interactions
[@Braga2021PhyRec]. Taken together, these considerations suggest that
phylogenies can reliably be used to transfer knowledge on species interactions.

![Overview of the phylogenetic transfer learning (and prediction) of species
interactions networks. Starting from an initial, known, network, we learn its
representation through a graph embedding step (here, a truncated Singular Value
Decomposition; Step 1), yielding a series of latent traits (latent vulnerability
traits are more representative of species at the lower trophic-level and latent
generality traits are more representative of species at higher trophic-levels;
*sensu* @Schoener1989FooWeb); second, for the destination species pool, we
perform ancestral character estimation using a phylogeny (here, using a Brownian
model for the latent traits; Step 2); we then sample from the reconstructed
distribution of latent traits (Step 3) to generate a probabilistic metaweb at
the destination (here, assuming a uniform distribution of traits), and threshold
it to yield the final list of interactions (Step
4).](figures/figure-concept.png){#fig:concept}

Our methodology is outlined in @fig:concept, where we provide an illustration
based on learning the embedding of a metaweb of trophic interactions for
European mammals [known interactions; @Maiorano2020Tet10; @Maiorano2020DatTet]
and, based on phylogenetic relationships between mammals globally [*i.e.*,
phylogenetic tree @Upham2019InfMam], infer a metaweb for the Canadian mammalian
species pool (interactions are treated as unknown in this instance). Following
the definition of @Dunne2006NetStr, a metaweb is a network analogue to the
regional species pool; specifically, it is an inventory of all *potential*
interactions between species from a spatially delimited area (and so captures
the $\gamma$ diversity of interactions). The metaweb is, therefore, *not* a
prediction of the food web at a specific locale within the spatial area it
covers, and will have a different structure [notably by having a larger
connectance; see *e.g.* @Wood2015EffSpa]. These local food webs (which captures
the $\alpha$ diversity of interactions) are a subset of the metaweb's species
and interactions, and have been called "metaweb realizations"
[@Poisot2015SpeWhy]. Differences between local food web and their metaweb are
due to chance, species abundance and co-occurrence, local environmental
conditions, and local distribution of functional traits, among others.

Because the metaweb represents the joint effect of functional, phylogenetic, and
macroecological processes [@Morales-Castilla2015InfBio], it holds valuable
ecological information. Specifically, it is the "upper bounds" on what the
composition of the local networks can be [see *e.g.* @McLeod2021SamAsy]. These
local networks, in turn, can be reconstructed given appropriate knowledge of
local species composition, providing information on structure of food webs at
finer spatial scales. This has been done for example for tree-galler-parasitoid
systems [@Gravel2018BriElt], fish trophic interactions [@Albouy2019MarFis],
tetrapod trophic interactions [@OConnor2020UnvFoo], and crop-pest networks
[@Grunig2020CroFor]. Whereas the original metaweb definition, and indeed most
past uses of metawebs, was based on the presence/absence of interactions, we
focus on *probabilistic* metawebs where interactions are represented as the
chance of success of a Bernoulli trial [see *e.g.* @Poisot2016StrPro];
therefore, not only does our method recommend interactions that may exist, it
gives each interaction a score, allowing us to properly weigh them.

Our case study shows that phylogenetic transfer learning is an effective
approach to the generation of probabilistic metawebs. This showcases that
although the components (species) that make up the Canadian and European
communities may be *minimally* shared (the overall species overlap is less than
4%), if the medium (proxy space) selected in the transfer step is biologically
plausible, we can still effectively learn from the known network and make
biologically relevant predictions of interactions. Indeed, as we detail in the
results, when validated against known but fractional data of trophic
interactions between Canadian mammals, our model achieves a predictive accuracy
of approximately 91%. It should be reiterated that the framework presented in
@fig:concept is amenable to changes; notably, the measure of similarity may not
be phylogeny, and can be replaced by information on foraging
[@Beckerman2006ForBio], cell-level mechanisms [@Boeckaerts2021PreBac], or a
combination of traits and phylogenetic structure [@Stock2021PaiLea]. Most
importantly, although we focus on a trophic system, it is an established fact
that different (non-trophic) interactions do themselves interact with and
influence the outcome of trophic interactions [see *e.g.* @Kawatsu2021AreNet;
@Kefi2012MorMea]. Future development of metaweb inference techniques should
cover the prediction of multiple interaction types.

# Data used for the case study

We use data from the European metaweb assembled by @Maiorano2020Tet10. This was
assembled using data extracted from scientific literature (including published
papers, books, and grey literature) from the last 50 years and includes all
terrestrial tetrapods (mammals, breeding birds, reptiles and amphibians)
occurring on the European sub-continent (and Turkey) - with the caveat that only
species introduced in historical times and currently naturalized being included.
This metaweb itself is a network of binary (*i.e.* presence/absence), potential
two-way interactions between species pairs.

We filtered down the European metaweb to create a subgraph corresponding to all
mammals by matching species names in the original network to the Global
Biodiversity Information Facility (GBIF) taxonomic backbone
[@GBIFSecretariat2021GbiBac] and retaining all those who matched to mammals.
This serves a dual purpose 1) to extract only mammals from the European network
and 2) to match and standardize species names when aggregating the different
data sources further downstream (which is an important consideration when
combining datasets [@Grenie2021HarTax]). All nodes had valid matches to GBIF at
this step, and so this backbone is used for all name reconciliation steps as
outlined below.

The European metaweb represents the knowledge we want to learn and transfer; the
phylogenetic similarity of mammals here represents the information for transfer
(*i.e.* the transfer medium). We used the mammalian consensus supertree by
@Upham2019InfMam, for which all approximatively 6000 names have been similarly
matched to their GBIF valid names. This step allows us to place each node of the
mammalian European metaweb in the phylogeny.

The destination problem to which we want to transfer knowledge is the trophic
interactions between mammals in Canada. We obtained the list of extant species
from the International Union for Conservation of Nature (IUCN) checklist, and
selected the terrestrial and semi-aquatic species (this corresponds to the same
selection that was applied by @Maiorano2020Tet10 in the European metaweb). The
IUCN names were, as previously, reconciled against GBIF to have an exact match
to the taxonomy.

After taxonomic cleaning and reconciliation as outlined in the following
sections, the mammalian European metaweb has 260 species, and the Canadian
species pool has 163; of these, 17 (about 4% of the total) are shared, and 89
species from Canada (54%) had at least one congeneric species in Europe. The
similarity for both species pools predictably increases with higher taxonomic
order, with 19% of shared genera, 47% of shared families, and 75% of shared
orders; for the last point, Canada and Europe each had a single unique order
(*Didelphimorphia* for Canada, *Erinaceomorpha* for Europe).

In the following sections, we describe the representational learning step
applied to European data, the transfer step through phylogenetic similarity, and
the generation of a probabilistic metaweb for the destination species pool.

# Method description

The core point of our method is the transfer of knowledge of a known ecological
network, in order to predict interactions between species from another location
at which the network is unknown (or partially known). In @fig:concept, we give a
high-level overview of the approach; in the example around which this manuscript
is built (leveraging detailed knowledge about binary trophic interactions
between Mammalia in Europe to predict the less known trophic interactions
between closely phylogenetically related Mammalia in Canada), we use a series of
specific steps for network embedding, trait inference, network prediction and
thresholding.

Specifically, our approach can be summarized as follows: from the known network
in Europe, we use a truncated Singular Value Decomposition [t-SVD;
@Halko2011FinStr] to generate latent traits representing a low-dimensional
embedding of the network. As an aside, most ecologists are indirectly familiar
with SVD: Principal Component Analysis is a special case of SVD, which is more
sensitive to numerical instabilities [see notably @Shlens2014TutPri]. The latent
traits give an unbiased estimate of the node's position in the latent feature
spaces and can be mapped onto a reference phylogeny (other distance-based
measures of species proximity that allow for the inference of features in the
latent space can be used, for example the dissimilarity in functional traits).
Based on the reconstructed latent traits for species in the destination species
pool, a Random Dot Product Graph model [hereafter RDPG; @Young2007RanDot]
predicts the interaction between species through a function of the nodes'
features through matrix multiplication. Thus, from latent traits and node
position, we can infer interactions.

The method we develop is, ecologically speaking, a "black box", *i.e.* an
algorithm that can be understood mathematically, but whose component parts are
not always directly tied to ecological processes. There is a growing realization
in machine learning that (unintentional) black box algorithms are not
necessarily a bad thing [@Holm2019DefBla], as long as their constituent parts
can be examined (which is the case with our method). But more importantly, data
hold more information than we might think; as such, even algorithms that are
disconnected from the model can make correct guesses most of the time
[@Halevy2009UnrEff]; in fact, in an instance of ecological forecasting of
spatio-temporal systems, model-free approaches (*i.e.* drawing all of their
information from the data) outperformed model-informed ones
[@Perretti2013ModFor].

## Implementation and code availability

The entire pipeline is implemented in *Julia* 1.6 [@Bezanson2017JulFre] and is
available under the permissive MIT License at
[`https://osf.io/2zwqm/`](https://osf.io/2zwqm/). The taxonomic cleanup steps
are done using `GBIF.jl` [@Dansereau2021SimJl]. The network embedding and
analysis is done using `EcologicalNetworks.jl` [@Banville2021ManJl;
@Poisot2019EcoJl]. The phylogenetic simulations are done using
`PhyloNetworks.jl` [@Solis-Lemus2017PhyPac] and `Phylo.jl` [@Reeve2016HowPar]. A
complete `Project.toml` file specifying the full tree of dependencies is
available alongside the code. This material also includes a fully annotated copy
of the entire code required to run this project (describing both the intent of
the code and discussing some technical implementation details), a vignette for
every step of the process, and a series of Jupyter notebooks with the text and
code. The pipeline can be executed on a laptop in a matter of minutes, and
therefore does not require extensive computational power.

## Step 1: Learning the origin network representation

The first step in transfer learning is to learn the structure of the original
dataset. In order to do so, we rely on an approach inspired from
representational learning, where we learn a *representation* of the metaweb (in
the form of the latent subspaces), rather than a list of interactions (species
*a* eats *b*). This approach is conceptually different from other metaweb-scale
predictions [*e.g.* @Albouy2019MarFis], in that the metaweb representation is
easily transferable. Specifically, we use RDPG to create a number of latent
variables that can be combined into an approximation of the network adjacency
matrix. RDPG results are known to have strong phylogenetic signal, and to
capture the evolutionary backbone of food webs [@DallaRiva2016ExpEvo]; in other
words, the latent variables of an RDPG can be mapped onto a phylogenetic tree,
and phylogenetically similar predators should share phylogenetically similar
preys. In addition, recent advances show that the latent variables produced this
way can be used to predict *de novo* network edges. Interestingly, the latent
variables do not need to be produced by decomposing the network itself; in a
recent contribution, @Runghen2021ExpNod showed that deep artificial neural
networks are able to reconstruct the left and right subspaces of an RDPG, in
order to predict human movement networks from individual/location metadata. This
is an exciting opportunity, as it opens up the possibility of using additional
metadata as predictors.

The latent variables are created by performing a truncated Singular Value
Decomposition (t-SVD) on the adjacency matrix. SVD is an appropriate embedding
of ecological networks, which has recently been shown to both capture their
complex, emerging properties [@Strydom2021SvdEnt] and to allow highly accurate
prediction of the interactions within a single network [@Poisot2021ImpMam].
Under SVD, an adjacency matrix $\mathbf{A}$ (where
$\mathbf{A}_{m,n}\in\mathbb{B}$ where 1 indicates predation and 0 an absence
thereof) is decomposed into three components resulting in $\mathbf{A} =
\mathbf{U}\mathbf{\Sigma}\mathbf{V'}.$ Here, $\mathbf{\Sigma}$ is a $m \times n$
diagonal matrix and contains only singular ($\sigma$) values along its diagonal,
$\mathbf{U}$ is a $m \times m$ unitary matrix, and $\mathbf{V}'$ a $n \times n$
unitary matrix. Truncating the SVD removes additional noise in the dataset by
omitting non-zero and/or smaller $\sigma$ values from $\mathbf{\Sigma}$ using
the rank of the matrix. Under a t-SVD $\mathbf{A}_{m,n}$ is decomposed so that
$\mathbf{\Sigma}$ is a square $r \times r$ diagonal matrix (whith $1 \le r \le
r_{full}$ where $r_{full}$ is the full rank of $\mathbf{A}$ and $r$ the rank at
which we truncate the matrix) containing only non-zero $\sigma$ values.
Additionally, $\mathbf{U}$ is now a $m \times r$ semi unitary matrix and
$\mathbf{V}'$ a $n \times r$ semi-unitary matrix.

The specific rank at which the SVD ought to be truncated is a difficult
question. The purpose of SVD is to remove the noise (expressed at high
dimensions) and to focus on the signal, (expressed at low dimensions). In
datasets with a clear signal/noise demarcation, a scree plot of
$\mathbf{\Sigma}$ can show a sharp drop at the rank where noise starts
[@Zhu2006AutDim]. Because the European metaweb is almost entirely known, the
amount of noise (uncertainty) is low; this is reflected in @fig:scree (left),
where the scree plot shows no important drop, and in @fig:scree (right) where
the proportion of variance explained increases smoothly at higher dimensions.
For this reason, we default back to a threshold that explains 60% of the
variance in the underlying data, corresponding to 12 dimensions - *i.e.* a
tradeoff between accuracy and a reduced number of features.

An RDPG estimates the probability of observing interactions between nodes
(species) as a function of the nodes' latent variables, and is a way to turn an
SVD (which decompose one matrix into three) into two matrices that can be
multiplied to provide an approximation of the network. The latent variables used
for the RDPG, called the left and right subspaces, are defined as $\mathscr{L} =
\mathbf{U}\sqrt{\mathbf{\Sigma}}$, and $\mathscr{R} =
\sqrt{\mathbf{\Sigma}}\mathbf{V}'$ -- using the full rank of $\mathbf{A}$,
$\mathscr{L}\mathscr{R} = \mathbf{A}$, and using any smaller rank results in
$\mathscr{L}\mathscr{R} \approx \mathbf{A}$. Using a rank of 1 for the t-SVD
provides a first-order approximation of the network. One advantage of using an
RDPG rather than an SVD is that the number of components to estimate decreases;
notably, one does not have to estimate the singular values of the SVD.
Furthermore, the two subspaces can be directly multiplied to yield a network.


![Left: representation of the scree plot of the singular values from the t-SVD on
the European metaweb. The scree plot shows no obvious drop in the singular values
that may be leveraged to automatically detect a minimal dimension for embedding,
after *e.g.* @Zhu2006AutDim. Right: cumulative fraction of variance explained by
each dimension up to the rank of the European metaweb. The grey lines represent
cutoffs at 50, 60, …, 90% of variance explained. For the rest of the analysis, we
reverted to an arbitrary threshold of 60% of variance explained, which
represented a good tradeoff between accuracy and reduced number of
features.](figures/figure-screeplot.png){#fig:scree}

Because RDPG relies on matrix multiplication, the higher dimensions essentially
serve to make specific interactions converge towards 0 or 1; therefore, for
reasonably low ranks, there is no guarantee that the values in the reconstructed
network will be within the unit range. In order to determine what constitutes an
appropriate threshold for probability, we performed the RDPG approach on the
European metaweb, and evaluated the probability threshold by treating this as a
binary classification problem, specifically assuming that both 0 and 1 in the
European metaweb are all true. Given the methodological details given in
@Maiorano2020Tet10 and @OConnor2020UnvFoo, this seems like a reasonable
assumption, although one that does not hold for all metawebs. We used the
thresholding approach presented in @Poisot2021ImpMam, and picked a cutoff that
maximized Youden's $J$ statistic (a measure of the informedness (trust) of
predictions; @Youden1950IndRat); the resulting cutoff was 0.22, and gave an
accuracy above 0.99. In Supp. Mat. 1, we provide several lines of evidence that
using the entire network to estimate the threshold does not lead to overfitting;
that using a subset of species would yield the same threshold; that decreasing
the quality of the original data by adding of removing interactions would
minimally affect the predictive accuracy of RDPG applied to the European
metaweb; and that the networks reconstructed from artificially modified data are
reconstructed with the correct ecological properties.

The left and right subspaces for the European metaweb, accompanied by the
threshold for prediction, represent the knowledge we seek to transfer. In the
next section, we explain how we rely on phylogenetic similarity to do so.

## Steps 2 and 3: Transfer learning through phylogenetic relatedness

In order to transfer the knowledge from the European metaweb to the Canadian
species pool, we performed ancestral character estimation using a Brownian
motion model, which is a conservative approach in the absence of strong
hypotheses about the nature of phylogenetic signal in the network decomposition
[@Litsios2012EffPhy]. This uses the estimated feature vectors for the European
mammals to create a state reconstruction for all species (conceptually something
akin to a trait-based mammalian phylogeny using latent generality and
vulnerability traits) and allows us to impute the missing (latent) trait data
for the Canadian species that are not already in the European network; as we are
focused on predicting contemporary interactions, we only retained the values for
the tips of the tree. We assumed that all traits (*i.e.* the feature vectors for
the left and right subspaces) were independent, which is a reasonable assumption
as every trait/dimension added to the t-SVD has an *additive* effect to the one
before it. Note that the @Upham2019InfMam tree itself has some uncertainty
associated to inner nodes of the phylogeny. In this case study, we have decided
to not propagate this uncertainty, as it would complexify the process. The
Brownian motion algorithm returns the *average* value of the trait, and its
upper and lower bounds. Because we do not estimate other parameters of the
traits' distributions, we considered that every species trait is represented as
a uniform distribution between these bounds. The choice of the uniform
distribution was made because the algorithm returns a minimum and maximum point
estimate for the value, and given this information, the uniform distribution is
the one with maximum entropy. Had all mean parameters estimates been positive,
the exponential distribution would have been an alternative, but this is not the
case for the subspaces of an RDPG. In order to examine the consequences of the
choice of distribution, we estimated the variance per latent variable per node
to use a Normal distribution; as we show in Supp. Mat. 2, this decision results
in dramatically over-estimating the number and probability of interactions, and
therefore we keep the discussions in the main text to the uniform case. The
inferred left and right subspaces for the Canadian species pool
($\hat{\mathscr{L}}$ and $\hat{\mathscr{R}}$) have entries that are
distributions, representing the range of values for a given species at a given
dimension.

These objects represent the transferred knowledge, which we can use for
prediction of the Canadian metaweb.

## Step 4: Probabilistic prediction of the destination network

The phylogenetic reconstruction of $\hat{\mathscr{L}}$ and $\hat{\mathscr{R}}$
has an associated uncertainty, represented by the breadth of the uniform
distribution associated to each of their entries. Therefore, we can use this
information to assemble a *probabilistic* metaweb in the sense of
@Poisot2016StrPro, *i.e.* in which every interaction is represented as a single,
independent, Bernoulli event of probability $p$.

![Visual representation of the left (green/purple) and right (green/brown)
subspaces, alongside the adjacency matrix of the food web they encode
(greyscale). The European metaweb is on the left, and the imputed Canadian
metaweb (before data inflation) on the right. This figure illustrates how much
structure the left subspace captures. As we show in @fig:degree, the species
with a value of 0 in the left subspace are species without any
prey.](figures/figure-subspaces.png){#fig:subspaces}

Specifically, we have adopted the following approach. For every entry in
$\hat{\mathscr{L}}$ and $\hat{\mathscr{R}}$, we draw a value from its
distribution. This results in one instance of the possible left
($\hat{\mathscr{l}}$) and right ($\hat{\mathscr{r}}$) subspaces for the Canadian
metaweb. These can be multiplied, to produce one matrix of real values. Because
the entries in $\hat{\mathscr{l}}$ and $\hat{\mathscr{r}}$ are in the same space
where $\mathscr{L}$ and $\mathscr{R}$ were originally predicted, it follows that
the threshold $\rho$ estimated for the European metaweb also applies. We use
this information to produce one random Canadian metaweb, $N =
\hat{\mathscr{L}}\hat{\mathscr{R}}' \ge \rho$. As we can see in
(@fig:subspaces), the European and Canadian metawebs are structurally similar (as
would be expected given the biogeographic similarities) and the two (left and
right) subspaces are distinct *i.e.* capturing predation (generality) and prey
(vulnerability) latent traits.

Because the intervals around some trait values can be broad [in fact, probably
broader than what they would actually be, see *e.g.* @Garland1999IntPhy], we
repeat the above process $2\times 10^5$ times, which results in a probabilistic
metaweb $P$, where the probability of an interaction (here conveying our degree
of trust that it exists given the inferred trait distributions) is given by the
number of times where it appears across all random draws $N$, divided by the
number of samples. An interaction with $P_{i,j} = 1$ means that these two
species were predicted to interact in all $2\times 10^5$ random draws.

It must be noted that despite bringing in a large amount of information from the
European species pool and interactions, the Canadian metaweb has distinct
structural properties. Following an approach similar to @Vermaat2009MajDim, we
show in Supp. Mat. 3 that not only can we observe differences in a multivariate
space between the European and Canadian metaweb, we can also observe differences
in the same space between random subgraphs from these networks. These results
line up with the studies spatializing metawebs that have been discussed in the
introduction: changes in the species pool are driving local structural changes
in the networks.

## Data cleanup, discovery, validation, and thresholding

Once the probabilistic metaweb for Canada has been produced, we followed a
number of data inflation steps to finalize it. This step is external to the
actual transfer learning framework but rather serves as a way to augment and
validate the predicted metaweb.

![Left, comparison of the probabilities of interactions assigned by the model to
all interactions (grey curve), the subset of interactions found in GLOBI (red),
and in the @Strong2014ImpNon Newfoundland dataset (blue). The model recovers
more interactions with a low probability compared to data mining, which can
suggest that collected datasets are biased towards more common or easy to
identify interactions. Right, distribution of the in-degree and out-degree of
the mammals from Canada in the reconstructed metaweb. This figure describes a
flat, relatively short food web, in which there are few predators but a large
number of preys.](figures/figure-validation.png){#fig:inflation}

First, we extracted the subgraph corresponding to the 17 species shared between
the European and Canadian pools and replaced these interactions with a
probability of 0 (non-interaction) or 1 (interaction), according to their value
in the European metaweb. This represents a minute modification of the inferred
network (about 0.8% of all species pairs from the Canadian web), but ensures
that we are directly re-using knowledge from Europe.

Second, we looked for all species in the Canadian pool known to the Global
Biotic Interactions (GLoBI) database [@Poelen2014GloBio], and extracted their
known interactions. Because GLoBI aggregates observed interactions, it is not a
*networks* data source, and therefore the only information we can reliably
extract from it is that a species pair *was reported to interact at least once*.
This last statement should yet be taken with caution, as some sources in GLoBI
[*e.g.* @Thessen2014KnoExt] are produced through text analysis, and therefore
may not document direct evidence of the interaction. Nevertheless, should the
predictive model work, we would expect that a majority of interactions known to
GLoBI would also be predicted. We retrieved 366 interactions between mammals
from the Canadian species pool from GLoBI, 33 of which were not predicted by the
model; this results in a success rate of 91%. After performing this check, we
set the probability of all interactions known to GLoBI to 1.

Finally, we downloaded the data from @Strong2014ImpNon, who mined various
literature sources to identify trophic interactions in Newfoundland. This
dataset documented 25 interactions between mammals, only two of which were not
part of our (Canada-level) predictions, resulting in a success rate of 92%.
These two interactions were added to our predicted metaweb with a probability of 1.
A table listing all interactions in the predicted Canadian metaweb can be found
in the supplementary material.

![Left: effect of varying the cutoff for probabilities to be considered non-zero
on the number of unique links and on $\hat{L}$, the probabilistic estimate of
the number of links assuming that all interactions are independent. Right:
effect of varying the cutoff on the number of disconnected species, and on
network connectance. In both panels, the grey line indicates the cutoff
$P(i\rightarrow j) \approx 0.08$ that resulted in the first species losing all
of its interactions.](figures/figure-cutoffs.png){#fig:thresholds}

Because the confidence intervals on the inferred trait space are probably
over-estimates, we decided to apply a thresholding step to the interactions
after the data inflation (@fig:thresholds). @Cirtwill2021BuiFoo proposed a
number of strategies to threshold probabilistic networks. Their methods assume
the underlying data to be tag-based sequencing, which represents interactions as
co-occurrences of predator and prey within the same tags; this is conceptually
identical to our Bernoulli-trial based reconstruction of a probabilistic
network. We performed a full analysis of the effect of various cutoffs, and as
they either resulted in removing too few interactions, or removing enough
interactions that species started to be disconnected from the network, we set
this threshold for a probability equivalent to 0 to the largest possible value
that still allowed all species to have at least one interaction with a non-zero
probability. The need for this slight deviation from the @Cirtwill2021BuiFoo
method highlights the need for additional development on network thresholding.

# Results and discussion of the case study

In @fig:thresholds, we examine the effect of varying the cutoff on $P(i
\rightarrow j)$ on the number of links, species, and connectance. Determining a
cutoff using the maximum curvature, or central difference approximation of the
second order partial derivative, as suggested by *e.g.* @Cirtwill2021BuiFoo,
results in species being lost, or almost all links being kept. We therefore
settled on the value that allowed all species to remain with at least one
interaction. This result, in and of itself, suggests that additional
methodological developments for the thresholding of probabilistic networks are
required.

![Top: biological significance of the first dimension. Left: there is a linear
relationship between the values on the first dimension of the left subspace and
the generality, *i.e.* the relative number of preys, *sensu*
@Schoener1989FooWeb. Species with a value of 0 in this subspace are at the
bottom-most trophic level. Right: there is, similarly, a linear relationship
between the position of a species on the first dimension of the right subspace
and its vulnerability, *i.e.* the relative number of predators. Taken together,
these two figures show that the first-order representation of this network would
capture its degree distribution. Bottom: topological consequences of the first
dimension. Left: differences in the $z$-score of the actual configuration model
for the reconstructed network, and the prediction based only on the first
dimension. Right: distribution of the differences in the left
panel.](figures/figure-degree.png){#fig:degree}

The t-SVD embedding is able to learn relevant ecological features for the
network. @fig:degree shows that the first rank correlates linearly with
generality and vulnerability [@Schoener1989FooWeb], *i.e.* the number of preys
and predators for each species. Importantly, this implies that a rank 1
approximation represents the configuration model for the metaweb, *i.e.* a set
of random networks generated from a given degree sequence [@Park2004StaMec].
Accounting for the probabilistic nature of the degrees, the rank 1 approximation
also represents the *soft* configuration model [@vanderHoorn2018SpaMax]. Both
models are maximum entropy graph models [@Garlaschelli2018CovStr], with sharp
(all network realizations satisfy the specified degree sequence) and soft
(network realizations satisfy the degree sequence on average) local constraints,
respectively. The (soft) configuration model is an unbiased random graph model
widely used by ecologists in the context of null hypothesis significance testing
of network structure [*e.g.* @Bascompte2003NesAss] and can provide informative
priors for Bayesian inference of network structure [*e.g.* @Young2021BayInf]. It
is noteworthy that for this metaweb, the relevant information was extracted at
the first rank. Because the first rank corresponds to the leading singular value
of the system, the results of @fig:degree have a straightforward interpretation:
degree-based processes are the most important in structuring the mammalian food
web.

# Discussion

One important aspect in which Europe and Canada differ (despite their comparable
bioclimatic conditions) is the degree of the legacy of human impacts, which have
been much longer in Europe. @Nenzen2014Imp850 showed that even at small scales
(the Iberian peninsula), mammal food webs retain the signal of both climate
change and human activity, even when this human activity was orders of magnitude
less important than it is now. Similarly, @Yeakel2014ColEco showed that changes
in human occupation over several centuries can lead to food web collapse.
Megafauna in particular seems to be very sensitive to human arrival
[@Pires2015PleMeg]. In short, there is well-substantiated support for the idea
that human footprint affects more than the risk of species extinction
[@Marco2018ChaHum], and can lead to changes in interaction structure. Yet, owing
to the inherent plasticity of interactions, there have been documented instances
of food webs undergoing rapid collapse/recovery cycles over short periods of
time [@Pedersen2017SigCol]. The embedding of a network, in a sense, embeds its
macro-evolutionary history, especially as RDPG captures ecological signal
[@DallaRiva2016ExpEvo]; at this point, it is important to recall that a metaweb
is intended as a catalogue of all potential interactions, which should then be
filtered [@Morales-Castilla2015InfBio]. In practice (and in this instance) the
reconstructed metaweb will predict interactions that are plausible based on the
species' evolutionary history, however some interactions would/would not be
realized due to human impact.

@Dallas2017PreCry suggested that most links in ecological networks may be
cryptic, *i.e.* uncommon or otherwise hard to observe. This argument essentially
echoes @Jordano2016SamNet: the sampling of ecological interactions is difficult
because it requires first the joint observation of two species, and then the
observation of their interaction. In addition, it is generally expected that
weak or rare links would be more common in networks [@Csermely2004StrLin],
compared to strong, persistent links; this is notably the case in food chains,
wherein many weaker links are key to the stability of a system
[@Neutel2002StaRea]. In the light of these observations, the results in
@fig:inflation are not particularly surprising: we expect to see a surge in
these low-probability interactions under a model that has a good predictive
accuracy. Because the predictions we generate are by design probabilistic, then
one can weigh these rare links appropriately. In a sense, that most ecological
interactions are elusive can call for a slightly different approach to sampling:
once the common interactions are documented, the effort required in documenting
each rare interaction may increase exponentially. Recent proposals suggest that
machine learning algorithms, in these situations, can act as data generators
[@Hoffmann2019MacLea]: in this perspective, high quality observational data can
be supplemented with synthetic data coming from predictive models, which
increases the volume of information available for inference. Indeed,
@Strydom2021RoaPre suggested that knowing the metaweb may render the prediction
of local networks easier, because it fixes an "upper bound" on which
interactions can exist; indeed, with a probabilistic metaweb, we can consider
that the metaweb represents an aggregation of informative priors on the
interactions.

Related to the last point, @Cirtwill2019QuaFra showed that network inference
techniques based on Bayesian approaches would perform far better in the presence
of an interaction-level informative prior; the desirable properties of such a
prior would be that it is expressed as a probability, preferably representing a
Bernoulli event, the value of which would be representative of relevant
biological processes (probability of predation in this case). We argue that the
probability returned at the very last step of our framework may serve as this
informative prior; indeed, the output of our analysis can be used in subsequent
steps, also possibly involving expert elicitation to validate some of the most
strongly recommended interactions. One important *caveat* to keep in mind when
working with interaction inference is that interactions can never really be true
negatives (in the current state of our methodological framework and data
collection limitations); this renders the task of validating a model through the
usual application of binary classification statistics very difficult [although
see @Strydom2021RoaPre for a discussion of alternative suggestions]. The other
way through which our framework can be improved is by substituting the
predictors that are used for transfer. For example, in the presence of
information on species traits that are known to be predictive of species
interactions, one might want to rely on functional rather than phylogenetic
distances -- in food webs, body size (and allometrically related variables) has
been established as such a variable [@Brose2006ConRes]; the identification of
relevant functional traits is facilitated by recent methodological developments
[@Rosado2013GoiBac]. It should be noted that @Xing2021RisEco highlight
phylogenetic relatedness as one of the core components of network comparison at
the global scale. In this case study, we have embedded the original metaweb
using t-SVD, because it lends itself to an RDPG reconstruction, which is known
to capture the consequences of evolutionary processes [@DallaRiva2016ExpEvo];
this being said, there are other ways to embed graphs [@Arsov2019NetEmb;
@Cai2017ComSur; @Cao2019NetEmb], which can be used as alternatives.

As @Herbert1965Dun rightfully pointed out, "[y]ou can't draw neat lines around
planet-wide problems"; in this regard, our approach (and indeed, any inference
of a metaweb at large scales) must contend with several interesting and
interwoven families of problems. The first is the limit of the metaweb to embed
and transfer. If the initial metaweb is too narrow in scope, notably from a
taxonomic point of view, the chances of finding another area with enough related
species to make a reliable inference decreases; this would likely be indicated
by large confidence intervals during ancestral character estimation, but the
lack of well documented metawebs is currently preventing the development of more
concrete guidelines. The question of phylogenetic relatedness and dispersal is
notably true if the metaweb is assembled in an area with mostly endemic species,
and as with every predictive algorithm, there is room for the application of our
best ecological judgement. Conversely, the metaweb should be reliably filled,
which assumes that the $S^2$ interactions in a pool of $S$ species have been
examined, either through literature surveys or expert elicitation. Supp. Mat. 1
provides some guidance as to the type of sampling effort that should be
prioritized. Although RDPG was able to maintain very high predictive power when
interactions were missing, the addition of false positive interactions was
immediately detected; this suggests that it may be appropriate to err on the
side of "too many" interactions when constructing the initial metaweb to be
transferred. The second series of problems are related to determining which area
should be used to infer the new metaweb in, as this determines the species pool
that must be used. In our application, we focused on the mammals of Canada. The
upside of this approach is that information at the country level is likely to be
required by policy makers and stakeholders for their biodiversity assessment, as
each country tends to set goals at the national level [@Buxton2021KeyInf] for
which quantitative instruments are designed [@Turak2017UsiEss], with specific
strategies often enacted at smaller scales [@Ray2021BioCri]. And yet, we do not
really have a satisfying answer to the question of "where does a food web
stop?"; the current most satisfying solutions involve examining the spatial
consistency of network area relationships [see *e.g.* @Galiana2018SpaSca;
@Galiana2019GeoVar; @Galiana2021SpaSca; @Fortin2021NetEco], which is of course
impossible in the absence of enough information about the network itself. This
suggests that an *a posteriori* refinement of the results may be required, based
on a downscaling of the metaweb. The final family of problems relates less to
the availability of data or quantitative tools, and more to the praxis of
spatial ecology. Operating under the context of national divisions, in large
parts of the world, reflects nothing more than the legacy of settler
colonialism. Indeed, the use of ecological data is not an apolitical act
[@Nost2021PolEco], as data infrastructures tend to be designed to answer
questions within national boundaries, and their use both draws upon and
reinforces territorial statecraft; as per @Machen2021ThiAlg, this is
particularly true when the output of "algorithmic thinking" (*e.g.* relying on
machine learning to generate knowledge) can be re-used for governance (*e.g.*
enacting conservation decisions at the national scale). We therefore recognize
that methods such as we propose operate under the framework that contributed to
the ongoing biodiversity crisis [@Adam2014EleTre], reinforced environmental
injustice [@Choudry2013SavBio; @Dominguez2020DecCon], and on Turtle Island
especially, should be replaced by Indigenous principles of land management
[@Eichhorn2019SteDec; @Nokmaq2021AwaSle]. As we see AI/ML being increasingly
mobilized to generate knowledge that is lacking for conservation decisions
[*e.g.* @Lamba2019DeeLea; @MoseboFernandes2020MacLea], our discussion of these
tools need to go beyond the technical, and into the governance consequences they
can have.

**Acknowledgements:** We acknowledge that this study was conducted on land
within the traditional unceded territory of the Saint Lawrence Iroquoian,
Anishinabewaki, Mohawk, Huron-Wendat, and Omàmiwininiwak nations. TP, TS, DC,
and LP received funding from the Canadian Institue for Ecology & Evolution. FB
is funded by the Institute for Data Valorization (IVADO). TS, SB, and TP are
funded by a donation from the Courtois Foundation. CB was awarded a Mitacs
Elevate Fellowship no. IT12391, in partnership with fRI Research, and also
acknowledges funding from Alberta Innovates and the Forest Resources Improvement
Association of Alberta. M-JF acknowledges funding from NSERC Discovery Grant and
NSERC CRC. RR is funded by New Zealand’s Biological Heritage Ngā Koiora Tuku Iho
National Science Challenge, administered by New Zealand Ministry of Business,
Innovation, and Employment. BM is funded by the NSERC Alexander Graham Bell
Canada Graduate Scholarship and the FRQNT master’s scholarship. LP acknowledges
funding from NSERC Discovery Grant (NSERC RGPIN-2019-05771). TP acknowledges
financial support from NSERC through the Discovery Grants and Discovery
Accelerator Supplement programs. 

**Conflict of interest:** The authors have no conflict interests to disclose

**Authors' contributions:** TS, SB, and TP designed the study and performed the
analysis; GVDR, MF, and RR provided additional feedback on the analyses. DC, BM,
and FB helped with data collection. All editors contributed to writing and
editing the manuscript.

**Data availability:** All code and data used in this manuscript is publicly
available and archived on OSF [https://osf.io/2zwqm/](https://osf.io/2zwqm/) and
is currently referenced in the manuscript.

# References
