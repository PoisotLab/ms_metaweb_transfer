JRNL := 01_ELE
RVRND := 01

ALL: response_to_reviewers.pdf suppmat/suppmat.pdf

suppmat/suppmat.pdf: suppmat/01_svd_overfit.pdf suppmat/02_normal_overpredicts.pdf suppmat/03_pca.pdf
	pdfunite $^ $@

response_to_reviewers.pdf: reviews/$(JRNL)/$(RVRND).md
	pandoc $< -o $@ --template=.assets/templates/_responses.tex

suppmat/01_svd_overfit.pdf: suppmat/01_svd_overfit.md
	pandoc $< -o $@

suppmat/02_normal_overpredicts.pdf: suppmat/02_normal_overpredicts.md
	pandoc $< -o $@

suppmat/03_pca.pdf: suppmat/03_pca.md
	pandoc $< -o $@