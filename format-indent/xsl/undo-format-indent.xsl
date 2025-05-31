<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:map = "http://www.w3.org/2005/xpath-functions/map"
  xmlns:tr="http://transpect.io"
  default-mode="undo-format-indent"
  exclude-result-prefixes="xs saxon tr map"
  version="3.0">

  <xsl:import href="format-indent-common.xsl"/>

  <xsl:mode name="undo-format-indent" on-no-match="shallow-copy"/>
  
  <xsl:template match="*[tr:preserves-space(.)]/text()" mode="undo-format-indent" priority="1">
    <xsl:sequence select="."/>
  </xsl:template>

  <xsl:template match="*[tr:is-mixed(.)]/text()" mode="undo-format-indent">
    <xsl:value-of select="replace(., '\s+', ' ', 's')"/>
  </xsl:template>
  
  <xsl:template match="*[tr:is-mixed(.)]" mode="undo-format-indent">
    <xsl:message select="'mixed: ', name()"></xsl:message>
    <xsl:next-match></xsl:next-match>
  </xsl:template>
  
  <xsl:template match="*[not(tr:is-mixed(.))]/text()[not(normalize-space())]" mode="undo-format-indent"/>
  
</xsl:stylesheet>
