<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:map = "http://www.w3.org/2005/xpath-functions/map"
  xmlns:tr="http://transpect.io"
  default-mode="format-indent"
  exclude-result-prefixes="xs saxon tr map"
  version="3.0">

  <xsl:output indent="no"/>

  <xsl:param name="schema-docs" as="document-node(element(xs:schema))*" select="()"/>
  <xsl:param name="schema-uris" as="xs:string*" select="()">
    <!-- sequence of strings, but can also be a single string with WS-separated URIs -->
  </xsl:param>

  <!-- Currently only XSD schemas are supported, and the mixedness of an element 
       must be declared like this:
       <xs:element name="para">
         <xs:complexType mixed="true">
  -->

  <xsl:variable name="schemas" as="document-node(element(xs:schema))+" 
    select="if (exists($schema-docs)) then $schema-docs else $schema-uris ! tokenize(.) ! doc(.)"/>
  
  <xsl:key name="by-element" match="xs:element" use="@name"/>
  
  <xsl:function name="tr:is-mixed" as="xs:boolean" cache="yes">
    <xsl:param name="elt" as="element(*)?"/>
    <xsl:choose>
      <xsl:when test="exists($elt)">
        <xsl:variable name="namespace-uri" select="namespace-uri($elt)"/>
        <xsl:variable name="schema" as="document-node(element(xs:schema))" 
          select="if ($namespace-uri = '') 
                  then $schemas[not(normalize-space(*/@targetNamespace))]
                  else $schemas[*/@targetNamespace = $namespace-uri]"/>
        <xsl:sequence select="exists(
                                key('by-element', name($elt), $schema)[(xs:complexType/@mixed = 'true')
                                                                       or 
                                                                       (@type = 'xs:string')]
                              )"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="false()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
</xsl:stylesheet>