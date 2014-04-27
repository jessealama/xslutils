.PHONY: all

JAVA = java
XSLTXT = xsltxt.jar

all: $(addsuffix .xsl,$(basename $(wildcard *.xsltxt)))

%.xsl: %.xsltxt
	$(JAVA) -jar $(XSLTXT) toXSL $*.xsltxt $*.xsl || rm $*.xsl;

all: strings.xsl token-strings.xsl trace.xsl die.xsl copy.xsl die.xsl list.xsl

clean:
	rm -f *.xsl
