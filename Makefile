.PHONY: all

XSLTXT = xsltxt.jar

all: $(addsuffix .xsl,$(basename $(wildcard *.xsltxt)))

%.xsl: %.xsltxt
	java -jar $(XSLTXT) toXSL $*.xsltxt $*.xsl || rm $*.xsl;

clean:
	find . -type f -name '*.xsl' -delete
	find . -type f -name '*~' -delete
	find . -type f -name '.*~' -delete
