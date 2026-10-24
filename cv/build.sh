#!/bin/sh
# Builds the CV and puts the PDF in static/, where the website links it:
#   sh cv/build.sh
# Needs Python with PyYAML and XeLaTeX (TeX Live). GitHub Actions runs this on
# every push with TEXLIVE_IMAGE set, which typesets inside TeX Live's Docker
# image instead of a local install.
set -e
cd "$(dirname "$0")"

python3 generate.py
sh get-fonts.sh

args="-xelatex -interaction=nonstopmode -halt-on-error -outdir=build cv.tex"
if [ -n "$TEXLIVE_IMAGE" ]; then
  docker run --rm -v "$PWD:/cv" -w /cv "$TEXLIVE_IMAGE" latexmk $args
else
  latexmk $args
fi

cp build/cv.pdf ../static/shiyueli-cv.pdf
# The CV's old address, which other pages may still link to.
cp build/cv.pdf ../static/shiyueli-website-2026.pdf
