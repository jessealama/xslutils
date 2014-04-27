.PHONY: all

all: $(addsuffix .xsl,$(basename $(wildcard *.xsltxt)))

%.xsl: %.xsltxt
	java -jar xsltxt.jar toXSL $*.xsltxt $*.xsl || rm $*.xsl;

clean:
	find . -type f -name '*.xsl' -delete
	find . -type f -name '*~' -delete
	find . -type f -name '.*~' -delete

# Local Variables:
# mode: makefile-gmake
# End:
