<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="lcletters">
    <xsl:text>abcdefghijklmnopqrstuvwxyz</xsl:text>
  </xsl:variable>
  <xsl:variable name="ucletters">
    <xsl:text>ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:text>
  </xsl:variable>

  <xsl:template name="lc">
    <xsl:param name="s"/>
    <xsl:value-of select="translate($s, $ucletters, $lcletters)"/>
  </xsl:template>

  <xsl:template name="uc">
    <xsl:param name="s"/>
    <xsl:value-of select="translate($s, $lcletters, $ucletters)"/>
  </xsl:template>

  <xsl:template name="capitalize-after-underscore">
    <xsl:param name="string"/>
    <xsl:choose>
      <xsl:when test="contains ($string, &quot;_&quot;)">
        <xsl:variable name="before" select="substring-before ($string, &quot;_&quot;)"/>
        <xsl:variable name="after" select="substring-after ($string, &quot;_&quot;)"/>
        <xsl:choose>
          <xsl:when test="$after = &quot;&quot;">
            <xsl:value-of select="$before"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="after-length" select="string-length ($after)"/>
            <xsl:variable name="first-char-as-string" select="substring ($after, 1, 1)"/>
            <xsl:variable name="after-first-char" select="substring ($after, 2, $after-length)"/>
            <xsl:variable name="first-char-as-string-uc">
              <xsl:call-template name="uc">
                <xsl:with-param name="s" select="$first-char-as-string"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="transformed-tail">
              <xsl:call-template name="capitalize-after-underscore">
                <xsl:with-param name="string" select="$after-first-char"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="concat ($before, $first-char-as-string-uc, $transformed-tail)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="position-in-string">
    <xsl:param name="string"/>
    <xsl:param name="thing"/>
    <xsl:choose>
      <xsl:when test="contains ($string, $thing)">
        <xsl:variable name="before-thing" select="substring-before ($string, $thing)"/>
        <xsl:value-of select="string-length ($before-thing)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>-1</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="starts-with-capital-letter">
    <xsl:param name="string"/>
    <xsl:choose>
      <xsl:when test="$string = &quot;&quot;">
        <xsl:text>0</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="c" select="substring ($string, 1, 1)"/>
        <xsl:choose>
          <xsl:when test="$c = &quot;A&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;B&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;C&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;D&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;E&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;F&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;G&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;H&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;I&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;J&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;K&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;L&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;M&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;N&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;O&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;P&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;Q&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;R&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;S&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;T&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;U&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;V&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;W&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;X&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;Y&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:when test="$c = &quot;Z&quot;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
