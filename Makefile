SHELL = bash
PANDOC = pandoc
PYTHON = python

BUILD = build

all: pdf html

pdf:
	mkdir -p $(BUILD)/pdffigs/figs && \
	find ch*/figs -type f -exec cp {} $(BUILD)/pdffigs/figs/ \; && \
	TEXINPUTS="::./styles" $(PANDOC) metadata.yaml \
	ch*/*.md \
	ref_heading.md \
	-o $(BUILD)/thesis_SaladiShyamM.pdf \
	--default-image-extension=.pdf \
	--template=styles/template.tex \
	--filter pandoc-crossref \
	--lua-filter=frontmatter/short-captions.lua \
	--citeproc \
	--bibliography=references.bib \
	--top-level-division chapter \
	--resource-path='.:$(BUILD)/pdffigs:$(BUILD)/pdffigs/figs:' && \
	rm -r $(BUILD)/pdffigs

chapters = ch* frontmatter

html: $(chapters) search
$(chapters):
	[ -d "$@/figs" ] && mkdir -p $(BUILD)/figs/ && cp $@/figs/* $(BUILD)/figs/ || true; \
	$(PANDOC) \
	$@/*.md \
	ref_heading.md \
	--metadata-file metadata.yaml \
	--from=markdown+yaml_metadata_block \
	-o $(BUILD)/$@.html \
	--default-image-extension=.png \
	--dpi=300 \
	--template=styles/bs4_book.html \
	--filter pandoc-crossref \
	--citeproc \
	--bibliography=references.bib \
	--metadata=link-citations \
	--lua-filter=frontmatter/short-captions.lua \
	--top-level-division chapter && \
	rsync web_assets/* $(BUILD)/ 

# Build search index after chapters are built
search: $(chapters)
	$(PYTHON) build_search_index.py build/*.html > build/search.json

# Separate folders
# mkdir -p $(BUILD)/$@ && [ -d "$@/figs" ] && cp $@/figs/*.png $(BUILD)/$@ || true; \
# cd $(BUILD)/$@/ && find ../ -maxdepth 1 -type f -exec ln -s {} ./ \;
#

.PHONY: $(chapters)

clean:
	[ -d build ] && rm -r build/* || true
