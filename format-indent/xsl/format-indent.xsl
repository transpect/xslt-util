<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:map = "http://www.w3.org/2005/xpath-functions/map"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:tr="http://transpect.io"
  default-mode="format-indent"
  exclude-result-prefixes="xs saxon tr map rng"
  version="3.0">

  <xsl:import href="format-indent-common.xsl"/>

  <!-- This stylesheet inserts line breaks and indentation spaces or tabs at places 
       where ignorable whitespace is permitted.
       It is not a full serializer (that also may insert line breaks between attributes
       or namespace declarations).
       The accumulator 'wrapping' is a map with the keys 'col' and 'text'.
       'col' is an integer that holds the text column position before and 
       after processing text nodes in particular.
       'text' contains a possibly wrapped and indented version of the original
       text node content (and an empty string for other nodes).
       The results of this stylesheet should be output with indent="no", otherwise
       additional whitespace in mixed-content contexts (for example, between an
       <italic> and a <bold> element) may be inserted. -->
       
  <xsl:mode name="format-indent" on-no-match="shallow-copy" use-accumulators="#all"/>
  
  <xsl:param name="target-line-length" as="xs:integer" select="120"/>
  <xsl:param name="keep-ignorable-ws" select="false()" as="xs:boolean"/>
  <xsl:param name="indent-unit" as="xs:string" select="'  '">
    <!-- use '&#9;' for tabs -->
  </xsl:param>
  <xsl:param name="tab-width" as="xs:integer" select="4">
    <!-- only relevant if tabs are contained in $indent-unit -->
  </xsl:param>

  <xsl:variable name="indent-unit-length" as="xs:integer">
    <xsl:variable name="spaces" as="xs:string+">
      <xsl:analyze-string select="$indent-unit" regex="&#9;">
        <xsl:matching-substring>
          <xsl:sequence select="(1 to $tab-width) ! ' '"/>
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <xsl:sequence select="."/>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:variable>
    <xsl:sequence select="string-join($spaces) => string-length()"/>
  </xsl:variable>

  <xsl:variable name="initial-w" as="element(w)">
    <!-- Originally the accumulator was a map as described above. I wanted to rule
      out that the errors are related to maps. Errors occur with this element approach,
      too, although they manifest differently. -->
    <w col="1" text=""/>
  </xsl:variable>

  <xsl:accumulator name="wrapping" initial-value="map{'col': 1, 'text': ''}" as="map(xs:string, xs:anyAtomicType)">
    <!-- map keys: 'col': xs:integer, 'text': xs:string (empty string for elements,
      wrapped text for text nodes, currently no wrapping for processing instructions and comments) --> 

    <xsl:accumulator-rule match="text()[empty(ancestor::xs:* | ancestor::rng:*)]" phase="start">
      <xsl:sequence select="map{'col': $value?col, 'text': ''}"/>
    </xsl:accumulator-rule>

    <xsl:accumulator-rule match="text()[empty(ancestor::xs:* | ancestor::rng:*)]" phase="end">
      <xsl:variable name="indent" as="xs:string" select="tr:indent(.)"/>
      <xsl:variable name="content" select="." as="xs:string"/>
      <xsl:variable name="context" select="." as="text()"/>
      <xsl:variable name="preserve-space" as="xs:boolean" select="tr:preserves-space(..)"/>
      <xsl:variable name="start-col" as="xs:integer" select="$value?col"/>
      <xsl:choose>
        <xsl:when test="$preserve-space">
          <xsl:sequence select="tr:map-after-wrap($start-col, $content)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="tokenized" as="xs:string+" select="tokenize($content, '\s+')"/>
          <xsl:variable name="last-token-pos" select="count($tokenized)"/>
          <xsl:iterate select="$tokenized">
            <xsl:param name="col" as="xs:integer" select="$start-col"/>
            <xsl:param name="string" as="xs:string" select="''"/>
            <xsl:on-completion>
              <xsl:sequence select="tr:map-after-wrap($start-col, $string)"/>
            </xsl:on-completion>
            <xsl:variable name="token" as="xs:string" select="."/>
            <xsl:variable name="pos" as="xs:integer" select="position()"/>
            <xsl:variable name="is-last" as="xs:boolean" select="position() = last()"/>
<!--            <xsl:message select="'1P ', $pos, ' T:', $token, ' L:', last(), 'I:', $is-last"></xsl:message>-->
            <xsl:variable name="end-tags-length" as="xs:integer">
              <xsl:choose>
                <xsl:when test="position() = last()">
                  <xsl:for-each-group select="$context/ancestor::*" group-adjacent="tr:is-mixed(.)">
                    <xsl:if test="position() = last()">
                      <!-- the sum of the end tag lengths of the immediate ancestors that 
                           permit non-WS text -->
                      <xsl:sequence select="xs:integer(sum(for $anc in current-group()
                                                           return string-length(name($anc)) + 3))"/>
                    </xsl:if>
                  </xsl:for-each-group>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="0"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <!--<xsl:message select="'IIIIIIIIII col', $col,' t:', $token, 
              string-length($token) , $end-tags-length"></xsl:message>-->
            <xsl:variable name="token-follows" as="xs:boolean" select="exists($tokenized[position() = $pos + 1])"/>
            <xsl:variable name="new-string" as="xs:string"
              select="$string || (if(not($token-follows) 
                                     or 
                                     ($col + string-length($token) + (1[$token-follows], 0)[1] + $end-tags-length 
                                      le $target-line-length))
                                  then $token (:|| $col :)|| ' '[$token-follows]
                                  else $token (:|| $col :)|| '&#xa;' || $indent)"/>
            <!--<xsl:message select="'Next iteration: string: ' , $new-string, ' col: ', map:get(tr:map-after-wrap($col, $new-string), 'col')"></xsl:message>-->
            <xsl:next-iteration>
              <xsl:with-param name="string" select="$new-string"/>
              <xsl:with-param name="col" select="map:get(tr:map-after-wrap($start-col, $new-string), 'col')"/>
            </xsl:next-iteration>
          </xsl:iterate>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:accumulator-rule>

    <xsl:accumulator-rule match="processing-instruction()[empty(ancestor::xs:* | ancestor::rng:*)]" phase="end">
      <xsl:sequence select="map{'col': $value?col + string-length(name()) + string-length(.) + 5, 'text': ''}"/>
    </xsl:accumulator-rule>
    
    <xsl:accumulator-rule match="comment()[empty(ancestor::xs:* | ancestor::rng:*)]" phase="end">
      <xsl:sequence select="map{'col': $value?col + string-length(.) + 7, 'text': ''}"/>
    </xsl:accumulator-rule>
    
    <xsl:accumulator-rule match="*[empty(ancestor::xs:* | ancestor::rng:*)]" phase="start">
      <!-- here we try to estimate the string length of the serialized start tag -->
      <xsl:variable name="start-col" as="xs:integer" select="$value?col"/>
      <xsl:variable name="tag-beginning-length" as="xs:integer" select="1 + string-length(name())"/>
      <xsl:variable name="top-level-namespace-decls" as="xs:string*">
        <!-- we cannot be sure that the declarations are placed on the top-level element, but we 
             just assume it -->
        <xsl:if test="empty(parent::*)">
            <xsl:for-each-group select="(//* | //@*)[exists(prefix-from-QName(node-name(.))[not(. = 'xml')])]" 
              group-by="prefix-from-QName(node-name(.))">
              <xsl:sequence select="' xmlns:' || current-grouping-key() || '=&quot;' || 
                                    namespace-uri-for-prefix(current-grouping-key(), (.[self::*], ..)[1]) || '&quot;' "/>
            </xsl:for-each-group>
          </xsl:if>
      </xsl:variable>
      <xsl:variable name="namespace-decl-length" as="xs:integer" 
        select="string-length(string-join($top-level-namespace-decls))"/>
      <xsl:variable name="xmlns" as="text()*">
        <xsl:apply-templates select="." mode="xmlns"/>
      </xsl:variable>
      <xsl:variable name="xmlns-length" as="xs:integer" select="1 + string-length($xmlns)"/>
      <xsl:variable name="attributes-length" as="xs:integer*" select="xs:integer(sum(@* ! tr:attribute-length(.)))"/>
      <xsl:variable name="whole-start-tag-length" as="xs:integer"
        select="$tag-beginning-length + $namespace-decl-length + $xmlns-length + $attributes-length + 1"/>
      <xsl:choose>
        <xsl:when test="tr:is-mixed(parent::*)">
          <xsl:sequence select="map{'col': $value?col + $whole-start-tag-length, 'text': ''}"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="map{'col': tr:indent-length(parent::*) + $whole-start-tag-length, 'text': ''}"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:accumulator-rule>
    
    <xsl:accumulator-rule match="*[empty(ancestor::xs:* | ancestor::rng:*)]" phase="end">
      <xsl:choose>
        <xsl:when test="exists(node())">
          <xsl:sequence select="map{'col': $value?col + string-length(name()) + 3, 'text': ''}"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="map{'col': $value?col + 1, 'text': ''}"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:accumulator-rule>
  </xsl:accumulator>

  <xsl:template match="*" mode="xmlns">
    <xsl:if test="not(namespace-uri(.) = namespace-uri(..))
                  and not(in-scope-prefixes(.) = prefix-from-QName(node-name(.)))">
      <xsl:text xml:space="preserve"> xmlns="</xsl:text>
      <xsl:value-of select="namespace-uri(.)"/>
      <xsl:text>"</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="text()" mode="format-indent">
    <xsl:value-of select="map:get(accumulator-after('wrapping'), 'text')"/>
  </xsl:template>
  
  <xsl:template match="*[not(tr:is-mixed(parent::*))]" mode="format-indent">
    <xsl:value-of select="'&#xa;' || tr:indent(.)"/>
    <xsl:copy>
      <xsl:apply-templates select="@*, node()" mode="#current"/>
      <xsl:if test="not(tr:is-mixed(.))">
        <xsl:value-of select="'&#xa;' || tr:indent(.)"/>  
      </xsl:if>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[tr:is-mixed(parent::*)]" mode="format-indent">
    <xsl:copy>
      <xsl:apply-templates select="@*, node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:function name="tr:attribute-length" as="xs:integer">
    <!-- 4: a single space before, an equals sign and two quotation marks -->
    <xsl:param name="att" as="attribute(*)"/>
    <xsl:sequence select="4 + string-length(name($att)) + string-length($att)"/>
  </xsl:function>
  
  <xsl:function name="tr:indent-length" as="xs:integer" cache="yes">
    <!-- the indent length for child elements -->
    <xsl:param name="elt" as="element(*)?"/>
    <xsl:sequence select="if (exists($elt))
                          then count($elt/ancestor::*[not(tr:is-mixed(.))]) * $indent-unit-length
                          else 0"/>
  </xsl:function>

  <xsl:function name="tr:indent" as="xs:string" cache="yes">
    <xsl:param name="node" as="node()"/>
    <xsl:sequence select="string-join(for $s in 
                                       (1 to (count($node/ancestor::*[not(tr:is-mixed(.))]) 
                                              + (1[exists($node/self::text())], 0)[1])
                                       ) return $indent-unit)"/>
  </xsl:function>
  
  <xsl:function name="tr:map-after-wrap" as="map(xs:string, xs:anyAtomicType)">
    <xsl:param name="start-col" as="xs:integer"/>
    <xsl:param name="wrapped-string" as="xs:string"/>
    <xsl:variable name="lines" as="xs:string+" select="tokenize($wrapped-string, '&#xa;')"/>
    <xsl:variable name="last-line" as="xs:string" select="$lines[last()]"/>
    <xsl:sequence select="map{'col': if (count($lines) gt 1) 
                                     then string-length($last-line)
                                     else $start-col + string-length($last-line),
      'text': $wrapped-string}"/>
  </xsl:function>
</xsl:stylesheet>