<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <xsl:import href="http://www.functx.com/Sequences/Positional/index-of-node.xsl"/>
  
  <xsl:function name="functx:path-to-node-with-pos" as="xs:string" 
    xmlns:functx="http://www.functx.com" >
    <xsl:param name="node" as="node()?"/> 
    
    <xsl:variable name="names" as="xs:string*">
      <xsl:for-each select="$node/ancestor-or-self::*">
        <xsl:variable name="ancestor" select="."/>
        <xsl:variable name="sibsOfSameName"
          select="$ancestor/../*[name() = name($ancestor)]"/>
        <xsl:sequence select="concat(name($ancestor),
          if (count($sibsOfSameName) &lt;= 1)
          then ''
          else concat(
          '[',functx:index-of-node($sibsOfSameName,$ancestor),']'))"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:sequence select="string-join($names,'/')"/>
    
  </xsl:function>
</xsl:stylesheet>