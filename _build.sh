#!/bin/sh

set -ev

Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::bs4_book')"

# Figure this out on gh actions later...
# Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"

