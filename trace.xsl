<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="*" mode="trace">
    <xsl:apply-templates select="." mode="trace-recursive"/>
  </xsl:template>

  <xsl:template match="*" mode="trace-recursive">
    <xsl:variable name="n" select="name (.)"/>
    <xsl:variable name="position" select="count (preceding-sibling::*[name() = $n]) + 1"/>
    <xsl:if test="parent::*">
      <xsl:apply-templates select=".." mode="trace-recursive"/>
    </xsl:if>
    <xsl:variable name="message" select="concat ($n, &quot;[&quot;, $position, &quot;]&quot;)"/>
    <xsl:message>
      <xsl:value-of select="$message"/>
    </xsl:message>
  </xsl:template>
</xsl:stylesheet>
