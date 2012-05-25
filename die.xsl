<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="trace.xsl"/>

  <xsl:template match="*" mode="die">
    <xsl:param name="message"/>
    <xsl:apply-templates select="." mode="trace"/>
    <xsl:message terminate="yes">
      <xsl:value-of select="$message"/>
    </xsl:message>
  </xsl:template>
</xsl:stylesheet>
