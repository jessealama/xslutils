<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="no"/>

  <!-- By default, just copy -->
  <xsl:template match="*">
    <xsl:variable name="n" select="name (.)"/>
    <xsl:element name="{$n}">
      <xsl:for-each select="@*">
        <xsl:copy-of select="."/>
      </xsl:for-each>
      <xsl:apply-templates select="child::node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="html">
        <xsl:apply-templates select="html"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="root" select="name (.)"/>
        <xsl:variable name="error-message" select="concat (&quot;Error: this stylesheet is intended to be applied to (X)HTML documents.&quot;, &quot;
&quot;, &quot;The root element name is:&quot;, &quot;
&quot;, &quot;
&quot;, &quot;  &quot;, $root, &quot;
&quot;, &quot;
&quot;, &quot;but we expected the root element to be &apos;html&apos;.&quot;)"/>
        <xsl:message terminate="yes">
          <xsl:value-of select="$error-message"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="p">
    <xsl:element name="p">
      <xsl:apply-templates select="child::node()" mode="normalize"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*" mode="normalize">
    <xsl:variable name="n" select="name (.)"/>
    <xsl:element name="{$n}">
      <xsl:for-each select="@*">
        <xsl:copy-of select="."/>
      </xsl:for-each>
      <xsl:apply-templates select="child::node()" mode="normalize"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="text()" mode="normalize">
    <xsl:value-of select="normalize-space ()"/>
  </xsl:template>
</xsl:stylesheet>
