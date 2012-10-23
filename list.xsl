<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="list">
    <xsl:param name="separ"/>
    <xsl:param name="elems"/>
    <xsl:for-each select="$elems">
      <xsl:apply-templates select="."/>
      <xsl:if test="not(position()=last())">
        <xsl:copy-of select="$separ"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="list-with-marker-after-penultimate-element">
    <xsl:param name="separ"/>
    <xsl:param name="elems"/>
    <xsl:param name="marker"/>
    <xsl:variable name="num-elems" select="count ($elems)"/>
    <xsl:choose>
      <xsl:when test="$num-elems = 0"/>
      <xsl:when test="$num-elems = 1">
        <xsl:variable name="elem" select="$elems[1]"/>
        <xsl:apply-templates select="$elem"/>
      </xsl:when>
      <xsl:when test="$num-elems = 2">
        <xsl:variable name="first-elem" select="$elems[1]"/>
        <xsl:variable name="second-elem" select="$elems[2]"/>
        <xsl:apply-templates select="$first-elem"/>
        <xsl:copy-of select="$marker"/>
        <xsl:apply-templates select="$second-elem"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="$elems">
          <xsl:variable name="position" select="position ()"/>
          <xsl:variable name="next-position" select="$position + 1"/>
          <xsl:variable name="last" select="last ()"/>
          <xsl:apply-templates select="."/>
          <xsl:choose>
            <xsl:when test="$position = $last"/>
            <xsl:when test="$next-position = $last">
              <xsl:copy-of select="$marker"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:copy-of select="$separ"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
