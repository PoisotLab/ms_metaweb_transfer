# S.M.2 - the Normal model of latent variable evolution over-predicts

In this appendix, we compare the raw predictions made by the Normal and Uniform
models of latent variable evolution. The Normal model was created by (i) getting
the averag $\mu$ of the simulated values for each species/variable combination,
and (ii) estimating the standard deviation as $(\mu+c - \mu-c)/3.92$, where $c$
is one half of the 95% confidence interval around $\mu$.

As can be seen on the following figure, the Normal model tends to assign high
probabilities (up to $p \approx 0.4$) for interactions that the Uniform model
essentially rules out:

![](./figures/supplementary/comparison_models.png)

This can lead to severe over-estimation of the number of interactions. In fact,
the consequences of using a Normal model are obvious from looking at the
adjacency matrices below: most of the interactions are predicted between species
that occupy the lower trophic level, and are ecologically unrealistic.

![](./figures/adjacencymatrices.png)

This can be further revealed by looking at the connectance of the networks under
different thresholds:

![](./figures/supplementary/comparison_connectance.png)

Although the Uniform model predicts a lot of interactions with extremely low
probability, that are removed at a low threshold, the distribution of
probabilities under the Normal model leads to extremely (abnormaly) high
connectances even for threshdolds that are over twice as large as the optimal
threshold determined in main text and Supp. Mat. 1.

This has consequences for the overall network *structure*: specifically, the
Normal model predicts a lot more top predators than we expect uner the uniform
model; rather than there being a progressive change in top-intermediate-bottom
proportions as the threshold changes, there is ab abrupt shift at a threshold of
about 0.6, which suggests that the Normal model is biased towards
over-predicting most interactions with probabilities in the range $[0,0.6]$.

![](./figures/supplementary/comparison_tib.png)

The same "jump" can be observed when looking at the distribution of food chain
lengths:

![](./figures/supplementary/comparison_rophicchain.png)

For these reasons, we only use predictions from the Uniform model in the main
text.