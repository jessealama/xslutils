<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="trace.xsl"/>

  <xsl:template match="*" mode="die">
    <xsl:param name="message"/>
    <xsl:apply-templates select="." mode="trace"/>
    <xsl:choose>
      <xsl:when test="@*">
        <xsl:message>
          <xsl:text>Attributes:</xsl:text>
        </xsl:message>
        <xsl:for-each select="@*">
          <xsl:variable name="n" select="name (.)"/>
          <xsl:variable name="v" select="string (.)"/>
          <xsl:message>
            <xsl:value-of select="concat ($n, &quot; = &quot;, $v)"/>
          </xsl:message>
        </xsl:for-each>
        <xsl:message terminate="yes">
          <xsl:value-of select="$message"/>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">
          <xsl:value-of select="concat ($message, &quot;
&quot;, &quot;(This element has no attributes.)&quot;)"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
