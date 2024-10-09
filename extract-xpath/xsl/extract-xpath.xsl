<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="3.0">
  <xsl:strip-space elements="*"/>
  <xsl:param name="xpathAndPosition" required="yes"/>
  <xsl:param name="pre-length" select="200" as="xs:integer" required="no"/>
  <xsl:param name="post-length" select="200" as="xs:integer" required="no"/>
  <xsl:param name="highlight" select="'no'" required="no"/>
  <xsl:param name="highlight-name" select="'p'" required="no"/>
  
  <!--  Extracts the Content at an XPath from an XML document. The result will be an extract from the codument containing 
        all ancestors of the element at the XPath without the text-nodes.
        Parameters:
        - xpathAndPosition: the XPath for the center element. Can be extended with in-text position data. (example: "/document/standard[1]/p[30],4,23"
            meaning the in-text position is the character 4 to 27.
        - post-length: how much text will be preserved after the XPath element. (default: 200)
        - pre-length: how much text will be preserved before the XPath element. (default: 200)
        - highlight: the text found with xpathAndPosition can be highlighted if highlight set to yes (default: no)
        - highlight-name: the name of the element to highlight the found text with (default: p)
  -->
  
  <xsl:template match="/">
    <xsl:variable name="xpath" select="tokenize($xpathAndPosition, ',')[1]"/>
    <xsl:variable name="text-start" select="
        if (matches($xpathAndPosition, '^[^,]+,\d+,\d+$')) then
          tokenize($xpathAndPosition, ',')[2]
        else
          0"/>
    <xsl:variable name="text-length" select="
        if (matches($xpathAndPosition, '^[^,]+,\d+,\d+$')) then
          tokenize($xpathAndPosition, ',')[3]
        else
          0"/>
    <xsl:variable name="lengths">
      <xsl:apply-templates select="/" mode="lengths"/>
    </xsl:variable>
    <xsl:variable name="positions-pre">
      <xsl:apply-templates select="$lengths" mode="positions-pre"/>
    </xsl:variable>
    <xsl:variable name="positions">
      <xsl:apply-templates select="$positions-pre" mode="positions"/>
    </xsl:variable>
    <xsl:variable name="path-position">
      <xsl:evaluate xpath="$xpath" context-item="$positions"/>
    </xsl:variable>
    <xsl:variable name="highlight">
      <xsl:choose>
        <xsl:when test="$highlight eq 'yes'">
          <xsl:apply-templates select="$positions" mode="highlight">
            <xsl:with-param name="hightlight-node" select="$path-position" tunnel="yes"/>
            <xsl:with-param name="text-start" select="xs:integer($text-start)" tunnel="yes"/>
            <xsl:with-param name="text-length" select="xs:integer($text-length)" tunnel="yes"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$positions"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="start" select="$path-position/*/xs:integer(@data-position) - $pre-length"/>
    <xsl:variable name="end" select="$path-position/*/xs:integer(@data-position) + $post-length"/>
    <xsl:variable name="result">
      <xsl:apply-templates select="$highlight" mode="extract">
        <xsl:with-param name="start" select="$start" tunnel="yes"/>
        <xsl:with-param name="end" select="$end" tunnel="yes"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:sequence select="$result"/>
  </xsl:template>
  
  <xsl:template match="@*|node()" mode="#all" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*,node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*" mode="lengths">
    <xsl:copy>
      <xsl:attribute name="data-length" select="string-length(string-join(.//text() ! normalize-space(.)))"/>
      <xsl:apply-templates select="@*" mode="#current"/>
      <xsl:apply-templates mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*" mode="positions-pre">
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="#current"/>
      <xsl:attribute name="data-position" select="sum(./preceding-sibling::*/@data-length)"/>
      <xsl:apply-templates mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*" mode="positions">
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="#current"/>
      <xsl:attribute name="data-position" select="@data-position + sum(ancestor::*/@data-position)"/>
      <xsl:apply-templates mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*" mode="extract">
    <xsl:param name="start" tunnel="yes" select="0" as="xs:integer"/>
    <xsl:param name="end" tunnel="yes" as="xs:integer"/>
    <xsl:variable name="pos" select="xs:integer(@data-position)"/>
    <xsl:variable name="len" select="xs:integer(@data-length)"/>
    <xsl:if test="(($pos + $len) gt $start) and ($pos lt $end)">
      <xsl:copy>
        <xsl:apply-templates  select="@* except (@data-position,@data-length),node()" mode="#current">
          <xsl:with-param name="start" select="$start" tunnel="yes"/>
          <xsl:with-param name="end" select="$end" tunnel="yes"/>
        </xsl:apply-templates>
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="text()" mode="highlight">
    <xsl:param name="hightlight-node" tunnel="yes"/>
    <xsl:param name="text-start" tunnel="yes" as="xs:integer"/>
    <xsl:param name="text-length" tunnel="yes" as="xs:integer"/>
    <xsl:variable name="length" select="string-length(.)"/>
    <xsl:choose>
      <xsl:when test="./parent::* eq $hightlight-node">
        <xsl:variable name="text-before" select="substring(., 0, $text-start)"/>
        <xsl:variable name="text-after" select="substring(., $text-start + $text-length, $length)"/>
        <xsl:variable name="text" select="substring(., $text-start, $text-length)"/>
        <xsl:value-of select="$text-before"/>
        <xsl:element name="{$highlight-name}">
          <xsl:attribute name="data-position" select="./parent::*/xs:integer(@data-position) + string-length($text-before)"/>
          <xsl:attribute name="data-length" select="string-length($text)"/>
          <xsl:value-of select="$text"/>
        </xsl:element>
        <xsl:value-of select="$text-after"/>
      </xsl:when>
      <xsl:otherwise>
      <xsl:value-of select="."/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
