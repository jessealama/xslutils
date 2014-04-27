.PHONY: all clean

xsltxts = $(wildcard *.xsltxt)
stylesheets = $(basename $(xsltxts))
xsls = $(addsuffix .xsl,$(stylesheets))

all: $(xsls)

%.xsl: %.xsltxt
	(java -jar xsltxt.jar toXSL $< $@) || (rm $@; false)

clean:
	find . -type f -name '*.xsl' -delete
	find . -type f -name '*~' -delete
	find . -type f -name '.*~' -delete

# Local Variables:
# mode: makefile-gmake
# End:
