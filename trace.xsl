<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="*" mode="trace">
    <xsl:apply-templates select="." mode="trace-recursive"/>
  </xsl:template>

  <xsl:template name="attributes-and-values">
    <xsl:param name="attrs"/>
    <xsl:choose>
      <xsl:when test="count ($attrs) &gt; 0">
        <xsl:variable name="attr" select="$attrs[1]"/>
        <xsl:variable name="attr-n" select="name ($attr)"/>
        <xsl:variable name="attr-v" select="$attr"/>
        <xsl:choose>
          <xsl:when test="count ($attrs) &gt; 1">
            <xsl:variable name="rest">
              <xsl:call-template name="attributes-and-values">
                <xsl:with-param name="attrs" select="$attrs[position() &gt; 1]"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="concat ($attr-n, &quot; = &quot;, $attr-v, &quot; , &quot;, $rest)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat ($attr-n, &quot; = &quot;, $attr-v)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="trace-recursive">
    <xsl:variable name="n" select="name (.)"/>
    <xsl:variable name="position" select="count (preceding-sibling::*[name() = $n]) + 1"/>
    <xsl:if test="parent::*">
      <xsl:apply-templates select=".." mode="trace-recursive"/>
    </xsl:if>
    <xsl:variable name="message" select="concat ($n, &quot;[&quot;, $position, &quot;]&quot;)"/>
    <xsl:choose>
      <xsl:when test="count (@*) &gt; 0">
        <xsl:variable name="attr-string">
          <xsl:call-template name="attributes-and-values">
            <xsl:with-param name="attrs" select="@*"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:message>
          <xsl:value-of select="concat ($message, &quot; (&quot;, $attr-string, &quot;)&quot;)"/>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>
          <xsl:value-of select="$message"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
