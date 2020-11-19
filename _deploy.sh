#!/bin/sh

set -e

git config --global user.email "saladi@caltech.edu"
git config --global user.name "Shyam Saladi"

git clone -b gh-pages https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git book-output
cd book-output

cp -r ../_book/* ./
git add --all *
git commit -m"Update the book" || true
git push -q origin gh-pages

