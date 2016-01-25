<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"

  xmlns:xsl		= "http://www.w3.org/1999/XSL/Transform"
  xmlns:fn              = "http://www.w3.org/2005/xpath-functions"
  xmlns:xs		= "http://www.w3.org/2001/XMLSchema"
  xmlns:saxon		= "http://saxon.sf.net/"
  xmlns:tr		= "http://transpect.io"

  exclude-result-prefixes = "xs saxon fn tr"
>

  <!-- ================================================================================ -->
  <!-- IMPORT OF OTHER STYLESHEETS -->
  <!-- ================================================================================ -->

  <xsl:import href="error-handler.xsl"/>

  <!-- ================================================================================ -->
  <!-- OUTPUT FORMAT -->
  <!-- ================================================================================ -->
  
  <xsl:output
    method="xml"
    encoding="utf-8"
    indent="yes"
    />

  <xsl:preserve-space elements="*"/>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ main template ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
  
  <xsl:template name="main">
    <xsl:call-template name="signal-error">
      <xsl:with-param name="exit" select="'no'"/>
      <xsl:with-param name="hash">
        <value key="info-text">Testtext</value>
        <value key="xpath"><xsl:value-of select="saxon:path(.)"/></value>
        <value key="level">WRN</value>
        <value key="mode">test-1</value>
        <value key="pi">test-1</value>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="signal-error">
      <xsl:with-param name="exit" select="'yes'"/>
      <xsl:with-param name="error-code" select="'W2D_test'"/>
      <xsl:with-param name="hash">
        <value key="info-text">Testtext 2</value>
        <value key="xpath"><xsl:value-of select="saxon:path(node())"/></value>
        <value key="level">ERR</value>
        <value key="mode">test-2</value>
        <value key="pi">test-2</value>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>


</xsl:stylesheet>