#! /bin/bash
#A PDF generation and subsiquent cleanup script. Origionally written by Dr. Louis Whitcomb, I believe.
pdflatex abstract
bibtex abstract
pdflatex -interaction batchmode abstract
rm *.aux
rm *.log
rm *.bbl
rm *.blg
