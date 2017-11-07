<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:calstable="http://docs.oasis-open.org/ns/oasis-exchange/table"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <!-- return all @colnum values, where there is no entry containing text -->
  <xsl:function name="calstable:empty-cols" as="xs:integer*">
    <xsl:param name="tgroup" as="element(tgroup)"/>
    <xsl:sequence select="$tgroup/colspec/@colnum[calstable:is-empty-col(., $tgroup)]"/>
  </xsl:function>
  
  <!-- return true if there is no entry using the col specified by colnum directly or indirectly in a namest/nameend span -->
  <xsl:function name="calstable:is-empty-col" as="xs:boolean">
    <xsl:param name="colnum" as="xs:decimal"/>
    <xsl:param name="tgroup" as="element(tgroup)"/>
    <xsl:variable name="colnames" select="$tgroup/colspec[@colnum=$colnum]/@colname"/>
    <xsl:variable name="entries" select="$tgroup//(entry[@colname = $colnames], entry[@namest][calstable:is-col-in-span($colnum, @namest, @nameend, $tgroup/colspec)])"/>
    <xsl:sequence select="empty($entries//text())"/>
  </xsl:function>
  
  <!-- return true if col for colnum is beetween namest and nameend (inclusive) -->
  <xsl:function name="calstable:is-col-in-span" as="xs:boolean">
    <xsl:param name="colnum" as="xs:decimal"/>
    <xsl:param name="namest" as="xs:string"/>
    <xsl:param name="nameend" as="xs:string"/>
    <xsl:param name="colspecs" as="element(colspec)+"/>
    <xsl:variable name="start" select="$colspecs[@colname = $namest]/@colnum" as="xs:integer"/>
    <xsl:variable name="end" select="$colspecs[@colname = $nameend]/@colnum" as="xs:integer"/>
    <xsl:sequence select="$colnum = ($start to $end)"/>
  </xsl:function>
  
</xsl:stylesheet>
