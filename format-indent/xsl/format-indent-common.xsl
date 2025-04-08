<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:map = "http://www.w3.org/2005/xpath-functions/map"
  xmlns:tr="http://transpect.io"
  default-mode="format-indent"
  exclude-result-prefixes="xs saxon tr map"
  version="3.0">

  <xsl:output indent="no"/>

  <xsl:param name="schema-docs" as="document-node(element())*" select="()"/>
  <xsl:param name="schema-uris" as="xs:string*" select="()">
    <!-- sequence of strings, but can also be a single string with WS-separated URIs -->
  </xsl:param>

  <!-- Currently only RNG and XSD schemas are supported.
       The mixedness of an element must be declared like this in XSD:
       <xs:element name="para">
         <xs:complexType mixed="true">
  -->

  <xsl:variable name="schemas" as="document-node(element())+">
    <xsl:variable name="schema-docs-by-uris" select="$schema-uris ! tokenize(.) ! doc(.)" as="document-node(element())+"/>
    <xsl:if test="not(exists($schema-docs union $schema-docs-by-uris))">
      <xsl:message terminate="yes" select="'Error: No schema documents given and/or absolute file paths in param ''schema-uris'' are unaccessible.'"/>
    </xsl:if>
    <xsl:document>
      <xsl:for-each select="if (exists($schema-docs)) then $schema-docs else $schema-docs-by-uris">
        <xsl:apply-templates select="." mode="resolve-includes"/>
      </xsl:for-each>
    </xsl:document>
  </xsl:variable>
  
  <xsl:template match="rng:include[@href]" mode="resolve-includes">
    <xsl:apply-templates select="doc(concat(replace(base-uri(.), '^(.+/)[^/]+$', '$1'), @href))/rng:grammar" mode="resolve-includes"/>
  </xsl:template>
  
  <xsl:template match="* | @*" mode="resolve-includes">
    <xsl:copy>
      <xsl:apply-templates select="@*, node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:key name="by-xsd-element" match="xs:element" use="@name"/>
  <xsl:key name="by-rng-element" match="rng:element" use="@name"/>
  
  <xsl:variable name="rng-content-model-operator-elements" as="xs:string*" 
    select="('group', 'interleave', 'choice', 'oneOrMore', 'zeroOrMore', 'optional')"/>
  
  <xsl:function name="tr:is-mixed" as="xs:boolean" cache="yes">
    <xsl:param name="elt" as="element(*)?"/>
    <xsl:choose>
      <xsl:when test="exists($elt) and $schemas[xs:schema]">
        <xsl:variable name="namespace-uri" select="namespace-uri($elt)"/>
        <xsl:variable name="schema" as="document-node(element(xs:schema))" 
          select="if ($namespace-uri = '') 
                  then $schemas[xs:schema][not(normalize-space(*/@targetNamespace))]
                  else $schemas[xs:schema][*/@targetNamespace = $namespace-uri]"/>
        <xsl:sequence select="exists(
                                key('by-xsd-element', name($elt), $schema)[(xs:complexType/@mixed = 'true')
                                                                       or 
                                                                       (@type = 'xs:string')]
                              )"/>
      </xsl:when>
      <xsl:when test="exists($elt) and $schemas[rng:grammar]">
        <xsl:variable name="namespace-uri" select="namespace-uri($elt)"/>
        <xsl:sequence select="exists(
                                key('by-rng-element', name($elt), $schemas)[
                                  (., descendant::rng:*[not(local-name() = $rng-content-model-operator-elements)])[self::rng:text or rng:mixed or rng:date/@type = ('string', 'xs:string')]
                                ]
                              )"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="false()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
</xsl:stylesheet>