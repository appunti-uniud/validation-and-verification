DOCS  := vv exams
PDFS  := $(addsuffix .pdf,$(DOCS))

export TEXINPUTS := $(CURDIR)/Airy/academica:$(TEXINPUTS)
export OSFONTDIR := $(CURDIR)/Airy/fonts//
LUALATEX := lualatex -interaction=nonstopmode -halt-on-error

.PHONY: all clean distclean
all: $(PDFS)

# initialise Airy submodule if missing
Airy/academica/academica.cls:
	git submodule update --init --recursive

$(PDFS): %.pdf: %.tex preamble.tex Airy/academica/academica.cls
	$(LUALATEX) $*
	$(LUALATEX) $*

clean:
	rm -f $(foreach e,aux log toc out lof lot synctex.gz,$(addsuffix .$(e),$(DOCS)))

distclean: clean
	rm -f $(PDFS)
