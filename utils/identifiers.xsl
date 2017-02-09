<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <!-- A short stylesheet to add @xml:ids to most entries in these 'ographies, using 
    @n to determine the positioning of the label in the song. -->
  
  <xsl:output indent="no" method="xhtml"/>
  
  <xsl:param name="isEvents" as="xs:boolean">
    <xsl:value-of select="contains(base-uri(),'events')"/>
  </xsl:param>
  
  <xsl:variable name="otherFile" as="xs:string">
    <xsl:value-of select="if ( not($isEvents) ) then '../events.xml' 
                          else '../peoplePlacesThings.xml'"/>
  </xsl:variable>
  
  <xsl:variable name="key" as="item()*">
    <xsl:variable name="otherNs" as="item()*">
      <xsl:copy-of select="doc($otherFile)//@n"/>
    </xsl:variable>
    <xsl:for-each select="(//@n | $otherNs)">
      <xsl:sort select="data(.)"/>
      <xsl:value-of select="."/>
    </xsl:for-each>
  </xsl:variable>
  
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@* | node()[not(self::*)]">
    <xsl:if test="not( ancestor::* )">
      <xsl:text>&#x0A;</xsl:text>
    </xsl:if>
    <xsl:copy/>
  </xsl:template>
  
  <xsl:template match="*[@n]">
    <xsl:copy>
      <xsl:attribute name="xml:id">
        <xsl:text>pyre</xsl:text>
        <xsl:value-of select="format-number(index-of($key,@n),'000')"/>
        <xsl:text>.0</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>