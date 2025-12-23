<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:tr="http://transpect.io"
  exclude-result-prefixes="xs math rng tr"
  version="3.0">

  <xsl:key name="rng-element-by-name" match="rng:element | rng:define | rng:ref" use="@name"/>
  <xsl:key name="rng-attribute-by-name" match="rng:attribute" use="@name"/>
  
  <xsl:key name="xsd-element-by-name" match="xs:element" use="@name"/>

  <xsl:function name="tr:rng-get-parent-elements" as="xs:string*" cache="yes">
    <xsl:param name="name" as="xs:string"/>
    <xsl:param name="schema" as="xs:string"/>
    <xsl:variable name="used-schema" select="if (doc-available($schema)) then document($schema) else ()"/>
    <xsl:if test="not($used-schema//rng:*)">
      <xsl:message terminate="yes" select="'No RNG schema provided or schema is empty'"/>
    </xsl:if>
    
    <xsl:variable name="name-instances" as="item()*">
      <xsl:choose>
        <xsl:when test="$name='text()'">
          <xsl:sequence select="$used-schema//rng:text"/>
        </xsl:when>
        <xsl:when test="$name='empty()'">
          <xsl:sequence select="$used-schema//rng:empty[not(ancestor::*[@name][1][matches(@name,'^attlist\.')])]"/>
        </xsl:when>
        <xsl:when test="matches($name,'^@')">
          <xsl:sequence select="key('rng-attribute-by-name',replace($name,'^@',''),$used-schema)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="key('rng-element-by-name',$name,$used-schema)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:sequence select="distinct-values(
                            sort(($name-instances[ancestor::*[@name][1]
                                                             [self::rng:element]]/ancestor::*[@name][1]
                                                                                             [self::rng:element]/@name, 
                                  for $n 
                                  in distinct-values($name-instances[ancestor::*[@name][1]
                                                                                [self::rng:ref or self::rng:define]
                                                                                [not(@name=$name)]]/ancestor::*[@name][1]
                                                                                                               [self::rng:ref or self::rng:define]
                                                                                                               [not(@name=$name)]/@name) 
                                  return tr:rng-get-parent-elements($n,$schema))))"/>
  </xsl:function>
  
  <xsl:function name="tr:xsd-get-parent-elements" as="xs:string*" cache="yes">
    <xsl:param name="name" as="xs:string"/>
    <xsl:param name="schema" as="xs:string"/>
    <xsl:variable name="used-schema" select="if (doc-available($schema)) then document($schema) else ()"/>
    <xsl:if test="not($used-schema/xs:schema)">
      <xsl:message terminate="yes" select="'No XSD schema provided or schema is empty'"/>
    </xsl:if>
    
    <xsl:variable name="name-instances" as="item()*">
      <xsl:choose>
        <xsl:when test="$name='text()'">
          <xsl:sequence select="$used-schema//xs:complexType[xs:simpleContent] | 
                                $used-schema//xs:simpleType[not(ancestor::xs:attribute)] | 
                                $used-schema//xs:complexType[@mixed='true'] |
                                $used-schema//xs:element[not(xs:simpleType or xs:complexType)][@type and matches(@type,'^xs:')]/@type"/>
        </xsl:when>
        <xsl:when test="starts-with($name,'@')">
          <xsl:sequence select="$used-schema//xs:attribute[(@name,@ref)=replace($name,'^@','')]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$used-schema//xs:*[(@name,@ref,@type,@base)=$name] | 
                                $used-schema//xs:element[@substitutionGroup=$name]/@substitutionGroup"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:sequence select="sort(distinct-values(($used-schema//xs:element[$name='empty()']
                                                                        [not(@abstract='true')]
                                                                        [tr:xsd-is-empty-element(.)]
                                                                        [not(@substitutionGroup) or 
                                                                         (@substitutionGroup and 
                                                                          key('xsd-element-by-name',
                                                                              @substitutionGroup,
                                                                              $used-schema)[tr:xsd-is-empty-element(.)])]/@name,
                                                $name-instances/ancestor::xs:element[not(@abstract='true')][1]/@name,
                               for $n in distinct-values($name-instances/ancestor::xs:*[@name][1]
                                                                                       [not(self::xs:element[not(@abstract='true')])]
                                                                                       [not(@name=$name)]/@name)
                               return tr:xsd-get-parent-elements($n,$schema))))"/>
  </xsl:function>
  
  <xsl:function name="tr:xsd-is-empty-element" as="xs:boolean" cache="yes">
    <xsl:param name="context" as="item()"/>
    <xsl:sequence select="exists($context[not(.//xs:element or 
                                              .//xs:simpleType or 
                                              .//xs:simpleContent or
                                              .//xs:complexContent or
                                              .//xs:group or
                                              .//xs:complexType[@mixed='true'])]
                                         [not(@type and matches(@type,'^xs:'))])"/>
  </xsl:function>
  
</xsl:stylesheet>