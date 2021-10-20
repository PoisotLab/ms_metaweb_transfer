# S.M.2 - the Normal model of latent variable evolution over-predicts

In this appendix, we compare the raw predictions made by the Normal and Uniform
models of latent variable evolution. The Normal model was created by (i) getting
the averag $\mu$ of the simulated values for each species/variable combination,
and (ii) estimating the standard deviation as $(\mu+c - \mu-c)/3.92$, where $c$
is one half of the 95% confidence interval around $\mu$.

As can be seen on the following figure, the Normal model tends to assign high
probabilities (up to $p \approx 0.4$) for interactions that the Uniform model
essentially rules out:

![](./figures/uniform_normal_comparison.png)

This can lead to severe over-estimation of the number of interactions. In fact,
the consequences of using a Normal model are obvious from looking at the
adjacency matrices below: most of the interactions are predicted between species
that occupy the lower trophic level, and are ecologically unrealistic.

![](./figures/adjacencymatrices.png)

For this reason, we only use predictions from the Uniform model in the main
text.