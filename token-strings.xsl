<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- //////////////////////////////////////////////////////////////////// -->
  <!-- Token string utilities -->
  <!-- //////////////////////////////////////////////////////////////////// -->
  <xsl:template name="token-string-is-empty">
    <xsl:param name="token-string"/>
    <xsl:choose>
      <xsl:when test="$token-string = &quot;,,&quot;">
        <xsl:text>1</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>0</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="token-string-tail">
    <xsl:param name="token-string"/>
    <xsl:variable name="empty">
      <xsl:call-template name="token-string-is-empty">
        <xsl:with-param name="token-string" select="$token-string"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$empty = &quot;1&quot;">
        <xsl:message terminate="yes">
          <xsl:text>Error: cannot take the tail of an empty token string.</xsl:text>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="after-first-comma" select="substring-after ($token-string, &quot;,&quot;)"/>
        <xsl:variable name="after-second-comma" select="substring-after ($after-first-comma, &quot;,&quot;)"/>
        <xsl:choose>
          <xsl:when test="$after-second-comma = &quot;&quot;">
            <xsl:text>,,</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat (&quot;,&quot;, $after-second-comma)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="token-string-head">
    <xsl:param name="token-string"/>
    <xsl:variable name="empty">
      <xsl:call-template name="token-string-is-empty">
        <xsl:with-param name="token-string" select="$token-string"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$empty = &quot;1&quot;">
        <xsl:message terminate="yes">
          <xsl:text>Error: cannot take the head of an empty token string.</xsl:text>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="after-first-comma" select="substring-after ($token-string, &quot;,&quot;)"/>
        <xsl:value-of select="substring-before ($after-first-comma, &quot;,&quot;)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Determine whether $string is actually a token string.  This means that it is either empty or (i) begins with a comma, (ii) contains a second comma, (iii) the substring between the first and second comma is non-empty, and (iv) the substring starting at the second comma is a valid token string. -->
  <xsl:template name="is-valid-token-string">
    <xsl:param name="string"/>
    <xsl:choose>
      <xsl:when test="starts-with ($string, &quot;,&quot;)">
        <xsl:variable name="after-first-comma" select="substring-after ($string, &quot;,&quot;)"/>
        <xsl:variable name="between-first-and-second-comma" select="substring-before ($after-first-comma, &quot;,&quot;)"/>
        <xsl:variable name="after-second-comma" select="substring-after ($after-first-comma, &quot;,&quot;)"/>
        <xsl:choose>
          <xsl:when test="$after-second-comma = &quot;&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="tail" select="concat (&quot;,&quot;, $after-second-comma)"/>
            <xsl:call-template name="is-valid-token-string">
              <xsl:with-param name="string" select="$tail"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>0</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="count-items-in-token-string">
    <xsl:param name="token-string"/>
    <xsl:variable name="empty">
      <xsl:call-template name="token-string-is-empty">
        <xsl:with-param name="token-string" select="$token-string"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$empty = &quot;1&quot;">
        <xsl:text>0</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="tail">
          <xsl:call-template name="token-string-tail">
            <xsl:with-param name="token-string" select="$token-string"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="items-in-tail">
          <xsl:call-template name="count-items-in-token-string">
            <xsl:with-param name="token-string" select="$tail"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$items-in-tail + 1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="add-to-token-string">
    <xsl:param name="item"/>
    <xsl:param name="token-string"/>
    <xsl:variable name="empty">
      <xsl:call-template name="token-string-is-empty">
        <xsl:with-param name="token-string" select="$token-string"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$empty = &quot;1&quot;">
        <xsl:value-of select="concat (&quot;,&quot;, $item, &quot;,&quot;)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat (&quot;,&quot;, $item, $token-string)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
