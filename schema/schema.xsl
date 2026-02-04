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
  
  <xsl:function name="tr:rng-to-xpath" as="xs:string" cache="yes">
    <xsl:param name="name" as="xs:string"/>
    <xsl:param name="schema" as="xs:string"/>
    <xsl:param name="prefix" as="xs:string?"/>
    <xsl:variable name="used-schema" select="if (doc-available($schema)) then document($schema) else ()"/>
    <xsl:if test="not($used-schema//rng:*)">
      <xsl:message terminate="yes" select="'No RNG schema provided or schema is empty'"/>
    </xsl:if>
    <xsl:sequence select="string-join(for $def in $used-schema//rng:define[@name=$name]/*[not(matches(@name,'^attlist\.'))] 
                                      return tr:rng-pattern-to-xpath($def,$schema,$prefix),', ')"/>
  </xsl:function>
  
  <xsl:function name="tr:rng-pattern-to-xpath" as="xs:string" cache="yes">
    <xsl:param name="pattern" as="element()"/>
    <xsl:param name="schema" as="xs:string"/>
    <xsl:param name="prefix" as="xs:string?"/>
    <xsl:variable name="used-schema" select="if (doc-available($schema)) then document($schema) else ()"/>
    <xsl:choose>
      <xsl:when test="$pattern[self::rng:element or self::rng:group or self::rng:optional or self::rng:zeroOrMore or self::rng:oneOrMore][rng:*]">
        <xsl:variable name="count" select="count($pattern/rng:*[not(matches(@name,'^attlist\.'))])"/>
        <xsl:sequence select="concat('('[$count gt 1],
                                     string-join((for $e in $pattern/rng:*[not(matches(@name,'^attlist\.'))] 
                                                  return tr:rng-pattern-to-xpath($e,$schema,$prefix)),', '),
                                     ')'[$count gt 1])"/>
      </xsl:when>
      <xsl:when test="$pattern[self::rng:choice]">
        <xsl:sequence select="concat('(',string-join((for $e in $pattern/rng:*[not(matches(@name,'^attlist\.'))] 
                                                      return tr:rng-pattern-to-xpath($e,$schema,$prefix)),' | '),')')"/>
      </xsl:when>
      <xsl:when test="$pattern[self::rng:text]">
        <xsl:sequence select="'text()'"/>
      </xsl:when>
      <xsl:when test="$pattern[self::rng:ref][not(key('rng-element-by-name',@name,$used-schema)[self::rng:element])]">
        <xsl:sequence select="tr:rng-to-xpath($pattern/@name,$schema,$prefix)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="xs:string(concat($prefix,$pattern/@name))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="tr:rng-to-sequence" as="node()*" cache="yes">
    <xsl:param name="context" as="element()"/>
    <xsl:param name="schema" as="xs:string"/>
    <xsl:param name="desc" as="xs:boolean"/>
    <xsl:param name="mandatoriness" as="xs:boolean"/>
    <xsl:variable name="used-schema" select="if (doc-available($schema)) then document($schema) else ()"/>
    <xsl:if test="not($used-schema//rng:*)">
      <xsl:message terminate="yes" select="'No RNG schema provided or schema is empty'"/>
    </xsl:if>
    <xsl:sequence select="for $def in $used-schema//rng:define[@name=$context/local-name()]/*[not(matches(@name,'^attlist\.'))] 
                          return tr:rng-pattern-to-sequence($context,$def,$schema,$desc,if ($mandatoriness) then 'unset' else 'unused')"/>
  </xsl:function>
  
  <xsl:function name="tr:rng-pattern-to-sequence" as="node()*" cache="yes">
    <xsl:param name="context" as="element()"/>
    <xsl:param name="pattern" as="element()"/>
    <xsl:param name="schema" as="xs:string"/>
    <xsl:param name="desc" as="xs:boolean"/>
    <!-- expected values for mandatory: unused, unset, true, false -->
    <xsl:param name="mandatory" as="xs:string"/>
    <xsl:variable name="used-schema" select="if (doc-available($schema)) then document($schema) else ()"/>
    <xsl:choose>
      <xsl:when test="$pattern[self::rng:element[not(@name=$context/local-name())] or 
                               self::rng:oneOrMore[count(tr:get-ref-leave(., 
                                                                          $schema, 
                                                                          ())/descendant-or-self::rng:element[not(ancestor::rng:element)])=1]]
                              [rng:*][$mandatory='unset'] or
                      $pattern[self::rng:oneOrMore][rng:*][$mandatory='unset']
                              [count(for $i in rng:* return tr:rng-pattern-to-sequence($context,$i,$schema,$desc,'unused')) = 0]">
        <xsl:sequence select="for $e in $pattern/rng:*[not(matches(@name,'^attlist\.'))] 
                              return tr:rng-pattern-to-sequence($context,$e,$schema,$desc,'true')"/>
      </xsl:when>
      <xsl:when test="$pattern[self::rng:optional or self::rng:zeroOrMore][rng:*][$mandatory='unset'] or
                      $pattern[self::rng:oneOrMore][rng:*][$mandatory='unset']
                              [count(for $i in rng:* return tr:rng-pattern-to-sequence($context,$i,$schema,$desc,'unused')) gt 0]">
        <xsl:sequence select="for $e in $pattern/rng:*[not(matches(@name,'^attlist\.'))] 
                              return tr:rng-pattern-to-sequence($context,$e,$schema,$desc,'false')"/>
      </xsl:when>
      <xsl:when test="$pattern[self::rng:element or self::rng:group or self::rng:optional or self::rng:zeroOrMore or self::rng:oneOrMore][rng:*]">
        <xsl:sequence select="for $e in $pattern/rng:*[not(matches(@name,'^attlist\.'))] 
                              return tr:rng-pattern-to-sequence($context,$e,$schema,$desc,$mandatory)"/>
      </xsl:when>
      <xsl:when test="$pattern[self::rng:choice]
                              [rng:group or 
                               rng:ref[key('rng-element-by-name',@name,$used-schema)/rng:group]]">
        <xsl:variable name="sorted" as="node()+">
          <xsl:for-each select="$pattern/rng:*">
            <xsl:sort select="tr:check-mandatory($context,.,$schema,$desc)" data-type="number" order="ascending"/>
            <xsl:sort select="tr:check-optional($context,.,$pattern,$schema,$desc)" data-type="number" order="descending"/>
            <xsl:sequence select="."/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="tr:rng-pattern-to-sequence($context,$sorted[1],$schema,$desc,$mandatory)"/>
      </xsl:when>
      <xsl:when test="$pattern[self::rng:choice]">
        <xsl:variable name="sorted" as="node()+">
          <xsl:for-each select="$pattern/rng:*">
            <xsl:sort select="tr:check-mandatory($context,.,$schema,$desc)" data-type="number" order="ascending"/>
            <xsl:sort select="tr:check-optional($context,.,$pattern,$schema,$desc)" data-type="number" order="descending"/>
            <xsl:sequence select="."/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="new-mandatory" 
                      select="if (count(tr:rng-pattern-to-sequence($context,$sorted[1],$schema,$desc,'unused')) gt 0) 
                              then 'false' 
                              else $mandatory"/>
        <xsl:sequence select="(for $e in $pattern/rng:*[not(matches(@name,'^attlist\.'))]
                               return tr:rng-pattern-to-sequence($context,$e,$schema,$desc,$new-mandatory)) | ()"/>
      </xsl:when>
      <xsl:when test="$pattern[self::rng:text]">
        <xsl:sequence select="$context/text()"/>
      </xsl:when>
      <xsl:when test="$pattern[self::rng:ref][not(key('rng-element-by-name',@name,$used-schema)[self::rng:element])]">
        <xsl:sequence select="for $e in key('rng-element-by-name',$pattern/@name,$used-schema)[not(self::rng:element)]/rng:* 
                              return tr:rng-pattern-to-sequence($context,$e,$schema,$desc,$mandatory)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="existing" select="if ($desc) 
                                              then $context/descendant::*[local-name()=$pattern/@name] 
                                              else $context/child::*[local-name()=$pattern/@name]" as="element()*"/>
        <xsl:choose>
          <xsl:when test="not(exists($existing)) and $mandatory='true'">
            <xsl:element name="missing-element" namespace="{$context/namespace-uri()}">
              <xsl:attribute name="name" select="$pattern/@name"/>
            </xsl:element>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="$existing"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="tr:check-mandatory" as="xs:integer" cache="yes">
    <xsl:param name="context" as="element()"/>
    <xsl:param name="pattern" as="element()"/>
    <xsl:param name="schema"/>
    <xsl:param name="desc" as="xs:boolean"/>
    <xsl:variable name="used-schema" select="if (doc-available($schema)) then document($schema) else ()"/>
    <xsl:sequence select="count($pattern/rng:*[self::rng:element or self::rng:oneOrMore or 
                                               self::rng:ref[key('rng-element-by-name',@name,$used-schema)/rng:*[self::rng:element or 
                                                                                                                 self::rng:oneOrMore]]]
                                              [not(exists(tr:rng-pattern-to-sequence($context,.,$schema,$desc,'unused')))]
                                              [not(parent::rng:choice and (preceding-sibling::rng:*[tr:check-mandatory($context,.,$schema,$desc)=0] or following-sibling::rng:*[tr:check-mandatory($context,.,$schema,$desc)=0]))])"/>
  </xsl:function>
  
  <xsl:function name="tr:check-optional" as="xs:integer" cache="yes">
    <xsl:param name="context" as="element()"/>
    <xsl:param name="pattern" as="element()"/>
    <xsl:param name="choice" as="element()"/>
    <xsl:param name="schema" as="xs:string"/>
    <xsl:param name="desc" as="xs:boolean"/>
    <xsl:variable name="used-schema" select="if (doc-available($schema)) then document($schema) else ()"/>
    <xsl:variable name="choice-names" select="tokenize(tr:rng-pattern-to-xpath($choice,$schema,()),'[^\p{L}0-9\._-]+')"/>
    <xsl:variable name="pattern-names" select="tokenize(tr:rng-pattern-to-xpath($pattern,$schema,()),'[^\p{L}0-9\._-]+')"/>
    <xsl:sequence select="count($pattern-names[for $x in . 
                                               return (count($choice-names[.=$x])=1 and 
                                               (if ($desc) 
                                                then exists($context/descendant::*[local-name()=$x]) 
                                                else exists($context/child::*[local-name()=$x])))])"/>
  </xsl:function>
  
  <xsl:function name="tr:get-ref-leave" as="element()*" cache="yes">
    <xsl:param name="pattern" as="element()"/>
    <xsl:param name="schema" as="xs:string"/>
    <xsl:param name="seen" as="xs:string*"/>
    <xsl:variable name="used-schema" select="if (doc-available($schema)) then document($schema) else ()"/>
    <xsl:element name="{$pattern/local-name()}" namespace="{$pattern/namespace-uri()}">
      <xsl:sequence select="$pattern/@*"/>
      <xsl:for-each select="$pattern/rng:*[not(matches(@name,'^attlist\.'))]">
        <xsl:choose>
          <xsl:when test="self::rng:ref[not(@name=$seen)]">
            <xsl:variable name="key" select="key('rng-element-by-name',@name,$used-schema)[self::rng:define]"/>
            <xsl:sequence select="for $n in $key/rng:* 
                                  return if ($n/self::rng:element) 
                                         then $n 
                                         else tr:get-ref-leave($n,$schema,($seen,xs:string(@name)))"/>
          </xsl:when>
          <xsl:when test="self::rng:element">
            <xsl:sequence select="."/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="tr:get-ref-leave(.,$schema,$seen)"/>
          </xsl:otherwise>
        </xsl:choose>     
      </xsl:for-each>  
    </xsl:element>
  </xsl:function>
  
</xsl:stylesheet>