<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="die.xsl"/>

  <xsl:template match="*">
    <xsl:variable name="n" select="name (.)"/>
    <xsl:variable name="message" select="concat (&quot;Unhandled &quot;, $n, &quot; node.&quot;)"/>
    <xsl:apply-templates select="." mode="die">
      <xsl:with-param name="message" select="$message"/>
    </xsl:apply-templates>
  </xsl:template>
</xsl:stylesheet>
