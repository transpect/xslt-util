<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:map = "http://www.w3.org/2005/xpath-functions/map"
  xmlns:tr="http://transpect.io"
  default-mode="format-indent"
  exclude-result-prefixes="xs saxon tr map a rng"
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

  <xsl:variable name="schema-docs-by-uris" select="$schema-uris ! tokenize(.) ! doc(.)" as="document-node(element())*"/>
  
  <xsl:variable name="schemas" as="document-node(element())+">
    <xsl:if test="empty($schema-docs union $schema-docs-by-uris)">
      <xsl:message terminate="yes" select="'Error: No schema documents given and/or absolute file paths in param ''schema-uris'' are unaccessible.'"/>
    </xsl:if>
    <xsl:for-each select="$schema-docs union $schema-docs-by-uris">
      <xsl:apply-templates select="." mode="resolve-includes"/>  
    </xsl:for-each>
  </xsl:variable>
  
  <xsl:template match="document-node(element(rng:grammar))" mode="resolve-includes" as="document-node(element(rng:grammar))">
    <xsl:document>
      <xsl:apply-templates mode="#current"/>  
    </xsl:document>
  </xsl:template>
  
  <xsl:template match="rng:include[@href]" mode="resolve-includes">
    <xsl:apply-templates select="doc(resolve-uri(@href, base-uri(.)))/rng:grammar/node()" mode="resolve-includes"/>
  </xsl:template>
  
  <xsl:template match="document-node(element(xs:schema))" mode="resolve-includes" as="document-node(element(xs:schema))+">
    <xsl:document>
      <xsl:apply-templates mode="#current"/>  
    </xsl:document>
    <xsl:variable name="imports" as="document-node(element(xs:schema))+">
      <xsl:call-template name="xs-imports"/>
    </xsl:variable>
    <xsl:for-each select="$imports">
      <xsl:document>
        <xsl:apply-templates mode="#current"/>
      </xsl:document>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="xs-imports">
    <xsl:for-each select="descendant::xs:import[@schemaLocation]">
      <xsl:variable name="target-base-uri" as="xs:anyURI"
        select="resolve-uri(@schemaLocation, base-uri(.))"/>
      <xsl:variable name="target-doc" as="document-node(element(xs:schema))"
        select="doc(resolve-uri(@schemaLocation, base-uri(.)))"/>
      <xsl:for-each select="$target-doc/*">
        <xsl:document>
          <xsl:copy>
            <xsl:attribute name="xml:base" select="$target-base-uri"/>
            <xsl:apply-templates select="@*, node()" mode="#current"/>
          </xsl:copy>
        </xsl:document>
      </xsl:for-each>
      <xsl:for-each select="$target-doc">
        <xsl:call-template name="xs-imports"/>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="xs:include[@schemaLocation]" mode="resolve-includes">
    <xsl:apply-templates select="doc(resolve-uri(@schemaLocation, base-uri(.)))/xs:schema/node()" mode="resolve-includes"/>
  </xsl:template>
  
  <xsl:template match="* | @*" mode="resolve-includes">
    <xsl:copy>
      <xsl:apply-templates select="@*, node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="rng-expanded">
    <xsl:result-document href="debug.rng" indent="yes">
      <xsl:sequence select="$schemas"/>
    </xsl:result-document>
  </xsl:template>

  <xsl:key name="by-xsd-element" match="xs:element" use="@name"/>
  <xsl:key name="by-rng-element" match="rng:element" use="@name"/>
  
  <xsl:function name="tr:is-mixed" as="xs:boolean" cache="yes">
    <xsl:param name="elt" as="element(*)?"/>
    <xsl:choose>
      <xsl:when test="exists($elt) and $schemas[xs:schema]">
        <xsl:variable name="namespace-uri" select="namespace-uri($elt)"/>
        <xsl:variable name="schema" as="document-node(element(xs:schema))" 
          select="if ($namespace-uri = '') 
                  then $schemas[xs:schema[not(normalize-space(@targetNamespace))]]
                  else $schemas[xs:schema[@targetNamespace = $namespace-uri]]"/>
        <xsl:sequence select="exists(
                                key('by-xsd-element', local-name($elt), $schema)[(xs:complexType/@mixed = 'true')
                                                                                 or 
                                                                                 (@type = 'xs:string')]
                              )"/>
      </xsl:when>
      <xsl:when test="exists($elt) and $schemas[rng:grammar]">
        <xsl:sequence select="name($elt) = $rng-mixed-elements/@name"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="false()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="tr:preserves-space" as="xs:boolean">
    <xsl:param name="elt" as="element()?"/>
    <xsl:sequence  
      select="exists(
               ($elt/ancestor-or-self::*[@xml:space][1][@xml:space = 'preserve'],
                $elt/ancestor-or-self::*[name() = $preserved-space-elements/@name])[last()]
              )"/>
  </xsl:function>

  <xsl:variable name="preserved-space-elements" as="element(*)*">
    <xsl:variable name="atts" as="element(rng:attribute)*" 
      select="$schemas//rng:attribute[@name = 'xml:space'][@a:defaultValue = 'preserve']"/>
    <xsl:sequence select="$atts ! rng:find-element-define(.)
      union
      $schemas//xs:element[xs:complexType/xs:attribute[@ref = 'xml:space'][@fixed = 'preserve']]"/>
  </xsl:variable>
  
  <xsl:variable name="rng-mixed-elements" as="element(rng:element)*">
    <xsl:variable name="text-schema-elts" as="element()*" 
      select="$schemas/descendant::rng:text union $schemas/descendant::rng:mixed union 
              $schemas/descendant::rng:data[@type = ('string', 'xs:string')]"/>
    <xsl:sequence select="$text-schema-elts ! rng:find-element-define(.)"/>
  </xsl:variable>

  <xsl:function name="rng:find-element-define" as="element(*)*" cache="yes">
    <xsl:param name="rng-elt" as="element(*)+"/>
    <xsl:for-each select="$rng-elt">
      <xsl:variable name="containing-elt-or-def" as="element(*)*"
        select="ancestor::*[self::rng:element union self::rng:define union self::rng:attribute][1]"/>
<!--      <xsl:message select="'looking up ', ."></xsl:message>-->
      <xsl:if test="empty($containing-elt-or-def)">
        <xsl:message select="'empty for ', string-join((name(), @name), ' ')"></xsl:message>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="exists($containing-elt-or-def/self::rng:attribute)"/>
        <xsl:when test="exists($containing-elt-or-def/self::rng:element)">
          <xsl:sequence select="$containing-elt-or-def"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="def" as="element(rng:define)" select="$containing-elt-or-def"/>
          <xsl:variable name="referenced-by" as="element(*)*" select="key('ref-by-name', $def/@name, root($def[1]))"/>
          <xsl:sequence select="rng:find-element-define($referenced-by)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:function>
  
  <xsl:key name="ref-by-name" match="rng:ref" use="@name"/>
  
  <xsl:key name="define-by-name" match="rng:define" use="@name"/>

  <xsl:template name="test">
    <xsl:message select="'text ', string-join(sort($rng-mixed-elements/@name), ', ')"/>
    <xsl:message select="'preserve ', string-join(sort($preserved-space-elements/@name), ', ')"/>
  </xsl:template>
  
  
</xsl:stylesheet>