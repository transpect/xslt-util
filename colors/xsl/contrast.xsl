<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:css="http://www.w3.org/1996/css" 
  xmlns:tr="http://transpect.io" 
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns="http://docbook.org/ns/docbook" 
  xpath-default-namespace="http://docbook.org/ns/docbook" 
  exclude-result-prefixes="xs" version="3.0">

  <xsl:import href="colors.xsl"/>

  <xsl:function name="tr:get-brightness" as="xs:double">
    <xsl:param name="color" as="xs:double"/>
    <xsl:choose>
      <xsl:when test="($color div 255) &lt;= 0.03928">
        <xsl:variable name="lr1" as="xs:double" 
                      select="($color div 255) div 12.92"/>
        <xsl:sequence select="$lr1"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="lr2" as="xs:double" 
                      select="math:pow(((($color div 255) + 0.055) div 1.055), 2.4) "/>
        <xsl:sequence select="$lr2"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="tr:get-luminance" as="xs:double">
    <xsl:param name="r" as="xs:double"/>
    <xsl:param name="g" as="xs:double"/>
    <xsl:param name="b" as="xs:double"/>
    <xsl:variable name="luminance" as="xs:double" select="(0.2126 * $r) + (0.7152 * $g) + (0.0722 * $b)"/>
    <xsl:sequence select="$luminance"/>
  </xsl:function>

  <xsl:function name="tr:get-contrast" as="xs:double">
    <xsl:param name="L1" as="xs:double"/>
    <xsl:param name="L2" as="xs:double"/>
    <xsl:choose>
      <xsl:when test="$L1 &gt; $L2">
        <xsl:variable name="contrast" as="xs:double" select="($L1 + 0.05) div ($L2 + 0.05)"/>
        <xsl:sequence select="$contrast"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="contrast" as="xs:double" select="($L2 + 0.05) div ($L1 + 0.05)"/>
        <xsl:sequence select="$contrast"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="tr:is-contrast-sufficient" as="xs:boolean">
    <xsl:param name="contrast-output"/>
    <xsl:param name="font-size"/>
    <xsl:param name="threshold-min" as="xs:double"/>
    <xsl:param name="threshold-max" as="xs:double"/>
    <xsl:choose>
      <xsl:when test="$font-size &gt;= '18pt' or '24px' or '1.5em'">
        <xsl:sequence select="if($contrast-output &gt; $threshold-min) 
                              then true() 
                              else false()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="if($contrast-output &gt; $threshold-max) 
                              then true() 
                              else false()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="tr:is-contrast-sufficient-AAA" as="xs:boolean">
    <xsl:param name="contrast-output"/>
    <xsl:param name="font-size"/>
    <xsl:sequence select="tr:is-contrast-sufficient($contrast-output, $font-size, 4.5, 7)"/>
  </xsl:function>
  
  <xsl:function name="tr:is-contrast-sufficient-AA" as="xs:boolean">
    <xsl:param name="contrast-output"/>
    <xsl:param name="font-size"/>
    <xsl:sequence select="tr:is-contrast-sufficient($contrast-output, $font-size, 3, 4.5)"/>
  </xsl:function>

</xsl:stylesheet>
