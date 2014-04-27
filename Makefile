.PHONY: all

JAVA = java
XSLTXT = xsltxt.jar

all: $(addsuffix .xsl,$(basename $(wildcard *.xsltxt)))

%.xsl: %.xsltxt
	$(JAVA) -jar $(XSLTXT) toXSL $*.xsltxt $*.xsl || rm $*.xsl;

clean:
	find . -type f -name '*.xsl' -delete
	find . -type f -name '*~' -delete
	find . -type f -name '.*~' -delete
