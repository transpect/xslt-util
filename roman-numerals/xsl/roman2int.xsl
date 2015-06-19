<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr="http://transpect.io"
  exclude-result-prefixes="xs tr"
  version="2.0">
  <xsl:output method="text"/>

  <xsl:function name="tr:roman-to-int" as="xs:integer?">
    <xsl:param name="roman" as="xs:string"/>
    <xsl:variable name="tokens" as="xs:string+" select="('I','IV','V','IX','X','XL','L','XC','C','CD','D','CM','M')"/>
    <xsl:variable name="atomic-numbers" as="xs:integer+" select="(1,4,5,9,10,40,50,90,100,400,500,900,1000)"/>
    <xsl:variable name="ints" as="xs:integer*">
      <xsl:analyze-string select="$roman" regex="(IV|IX|XL|XC|CD|CM|[IVXLCDM])" flags="i">
        
        <xsl:matching-substring>
          <xsl:sequence select="$atomic-numbers[index-of($tokens, upper-case(current()))]"/>
        </xsl:matching-substring>
        
        <xsl:non-matching-substring>
          <xsl:message>Non-roman digit <xsl:value-of select="."/> in <xsl:value-of select="$roman"/></xsl:message>
          <xsl:sequence select="-1"/>
        </xsl:non-matching-substring>
        
      </xsl:analyze-string>
    </xsl:variable>
    
    <xsl:variable name="ascending" as="xs:boolean*" select="for $i in (1 to xs:integer(count($ints) - 1)) return $ints[$i + 1] gt $ints[$i]"/>
    
    <xsl:choose>
      <xsl:when test="$ints = -1"/>
      <xsl:when test="some $a in $ascending satisfies ($a eq true())">
        <xsl:message>Incorrect roman numeral <xsl:value-of select="$roman"/>: The sequence of number tokens must be descending. Found: <xsl:value-of select="for $i in $ints return $tokens[index-of($atomic-numbers, $i)]"/> </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="sum" select="sum($ints)" as="xs:double?"/>
        <xsl:sequence select="if ($sum castable as xs:integer) then xs:integer($sum) else ()"/>    
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:function>

  <xsl:template name="test">
    <xsl:for-each select="('MCMLXXIV', 'MMD', 'MDM', 'MXM', 'IXL', 'MIW', 'XML')">
      <xsl:value-of select="."/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="tr:roman-to-int(.)"/>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>