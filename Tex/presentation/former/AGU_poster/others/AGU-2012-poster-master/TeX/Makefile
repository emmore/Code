all: Roche_AGU_2012.pdf

%.pdf: %.tex poster.bib
	pdflatex $<
	bibtex $*
	pdflatex $<
	pdflatex $<      # not a typo!
	# find real syntax for identifying PDF reader, its target
	evince $*.pdf &

clean:
	rm a0header.ps *.aux *.bbl *.blg *.log *.out *.pdf
