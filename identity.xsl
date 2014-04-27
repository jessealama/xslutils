<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>
  <!-- //////////////////////////////////////////////////////////////////// -->
  <!-- Stylesheet parameters -->
  <!-- //////////////////////////////////////////////////////////////////// -->
  <xsl:param name="comments">
    <xsl:text>1</xsl:text>
  </xsl:param>

  <!-- whether comments are to be preserved -->
  <!-- //////////////////////////////////////////////////////////////////// -->
  <!-- Templates -->
  <!-- //////////////////////////////////////////////////////////////////// -->
  <xsl:template match="*">
    <xsl:variable name="n" select="name (.)"/>
    <xsl:element name="{$n}">
      <xsl:for-each select="@*">
        <xsl:copy-of select="."/>
      </xsl:for-each>
      <xsl:apply-templates select="*"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="comment()">
    <xsl:if test="$comments = &quot;1&quot;">
      <xsl:copy-of select="."/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
