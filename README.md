## Associated repository

The code for analyses/methods can be found [here](https://github.com/PoisotLab/MetawebTransferLearning)

## About the manuscript building

- Edit `manuscript.md` to make changes to the text.
- The website, draft, and preprint versions are updated after each commit on
  `main`. 
- Previews are also generated for commits on pull-requests, but they need to be
  downloaded as artifacts. The two options to access them are:
  1. Go the `Actions` tab, select the action related to your recent commit, and
     download the `manuscript` zip file in the `Artifacts` section at the bottom
     of the page.
  1. Go the `Checks` tab of your PR (or of one of its commits), select one of
     the jobs on the left, click on `Artifacts` on the right of the page,
     and download the `manuscript` file.

## About the references

- We use [Zotero](https://www.zotero.org/) for references management
- We use the [Better BibTeX](https://retorque.re/zotero-better-bibtex/) plugin
  for citation key generations
- The citation key format we use is meant to convey information on the author,
  date, year, and title. It must be set in the Better BibTeX preferences 
  (`Preferences > Better BibTeX > Citation keys`) as:
    ```
    [auth:fold][year][title:fold:nopunctordash:skipwords:lower:select=1,    1:substring=1,3:capitalize][title:fold:nopunctordash:skipwords:lower:select=2,  2:substring=1,3:capitalize]
    ```
- We also use the same package to automatically export the manuscript references
  to `references.bib`. To do so, right-click on a collection, select Export
  Collection, select the `Better BibTeX` format, and check `Keep updated`.
- It is a good idea to remove a lot of fields that are not strictly speaking
  required for references (`Preferences > Better BibTeX > Export > Fields`). The list of fields we usually ignore is:
    ```
    abstract, copyright, annotation, file, pmid, month, shorttitle, keywords
    ```

## About Markdown formatting

- This is a citation: `@Eckart1936AppOne`. We can also have citations in brackets:
  `[@Eckart1936AppOne]`.
- This is an equation, which we can cite with `@eq:eq1`:
  `$$J = -\frac{1}{\ln(k)}\sum_{i=1}^k s_i\cdot\ln(s_i)$$
  {#eq:eq1}`
- Inline eq. look like this `$J = -\frac{1}{\ln(k)}\sum_{i=1}^k s_i\cdot\ln(s_i)$`
- This is a figure, which we can cite a figure with `@fig:conceptual`:
  `![This is the legend of the figure](figures/conceptual.png){#fig:conceptual}`

More details in the [template repo's `manuscript.md`](https://github.com/PoisotLab/manuscript-template/blob/master/manuscript.md).