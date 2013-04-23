xsltxts = $(wildcard *.xsltxt);
xsls = $(addsuffix .xsl,$(stylesheets))
stylesheets :=  $(basename $(xsltxts))
editable-files = $(xsltxts) $(xsls) Makefile .gitignore
emacs-backups = $(addsuffix ~,$(editable-files))

# functions
xslize = java -jar xsltxt.jar toXSL $(1) $(2)
xslize-or-kill = $(call xslize,$(1),$(2)) || (rm -f $(2); false)

%.xsl: %.xsltxt xsltxt.jar
	$(call xslize-or-kill,$*.xsltxt,$*.xsl)

all: $(xsls)

clean:
	rm -f $(xsls)
	rm -f $(emacs-backups)
