latexmk -xelatex main.tex
latexmk -c
rm *.xdv
mv main.pdf Team39_deliverable-1.pdf
