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
  <xsl:param name="normalize">
    <xsl:text>1</xsl:text>
  </xsl:param>

  <!-- whether text is to be normalized -->
  <!-- //////////////////////////////////////////////////////////////////// -->
  <!-- Templates -->
  <!-- //////////////////////////////////////////////////////////////////// -->
  <xsl:template match="/">
    <xsl:for-each select="*">
      <xsl:for-each select="preceding-sibling::node()">
        <xsl:sort order="descending"/>
        <xsl:apply-templates select="."/>
      </xsl:for-each>
      <xsl:apply-templates select="."/>
      <xsl:for-each select="following-sibling::node()">
        <xsl:sort order="ascending"/>
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*">
    <xsl:variable name="n" select="name (.)"/>
    <xsl:element name="{$n}">
      <xsl:for-each select="@*">
        <xsl:copy-of select="."/>
      </xsl:for-each>
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="comment()">
    <xsl:if test="$comments = &quot;1&quot;">
      <xsl:copy-of select="."/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:variable name="s" select="."/>
    <xsl:choose>
      <xsl:when test="$normalize = &quot;1&quot;">
        <xsl:value-of select="normalize-space ($s)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$s"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
