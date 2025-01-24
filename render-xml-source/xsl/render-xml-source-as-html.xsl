<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xs saxon html" version="3.0">

  <xsl:output indent="no"/>

  <xsl:mode name="serialize" on-no-match="text-only-copy"/>

  <xsl:param name="xpath" as="xs:string"/>
  <xsl:param name="highlight-xpath" as="xs:string" select="''"/>
  <xsl:param name="css-url" as="xs:string" select="'../css/xmlsrc.css'"/>
  <xsl:param name="include-css" as="xs:boolean" select="true()"/>
  <xsl:param name="scaffold" as="xs:boolean" select="false()"/>
  <xsl:param name="indent" as="xs:boolean" select="true()"/>
  <xsl:param name="text" as="xs:boolean" select="false()"/>
  <xsl:param name="max-length-for-atts" as="xs:integer" select="120"/>
  <xsl:param name="saxon-line-length" as="xs:integer" select="$max-length-for-atts"/>
  
  <xsl:template match="*">
    <xsl:variable name="root" as="document-node(element(*))">
      <xsl:choose>
        <xsl:when test="$indent">
          <xsl:sequence select=". => serialize(map {'indent': true(), 'saxon:line-length': $saxon-line-length}) => parse-xml()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:document>
            <xsl:sequence select="."/>
          </xsl:document>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$scaffold">
        <html>
          <head>
            <title>XML Source rendering</title>
            <xsl:choose>
              <xsl:when test="$include-css">
                <style>
                  <xsl:sequence select="unparsed-text($css-url)"/>
                </style>
              </xsl:when>
              <xsl:when test="normalize-space($css-url)">
                <link rel="stylesheet" href="{$css-url}"/>
              </xsl:when>
            </xsl:choose>
          </head>
          <body class="xmlsrc">
            <div class="xmlsrc">
              <xsl:apply-templates select="$root" mode="serialize"/>
            </div>
          </body>
        </html>
      </xsl:when>
      <xsl:otherwise>
        <div class="xmlsrc">
          <xsl:apply-templates select="$root" mode="serialize"/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/*" mode="serialize" priority="2">
    <xsl:choose>
      <xsl:when test="$text"><!-- assumption: /text/line document -->
        <xsl:apply-templates select="*" mode="#current"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="/text/line" mode="serialize" priority="2">
    <xsl:choose>
      <xsl:when test="$text">
        <xsl:apply-templates select="node()" mode="#current"/>
        <xsl:text xml:space="preserve">&#xa;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*" mode="serialize" priority="1">
    <span class="name elt">
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="name()"/>
    </span>
    <xsl:variable name="atts" as="document-node()">
      <xsl:document>
        <xsl:apply-templates select="." mode="xmlns"/>
        <xsl:if test="empty(parent::*)">
          <xsl:for-each-group select="(//* | //@*)[exists(prefix-from-QName(node-name(.))[not(. = 'xml')])]" 
            group-by="prefix-from-QName(node-name(.))">
            <span>
              <span class="namespace att">
                <xsl:value-of select="' xmlns:' || current-grouping-key()"/>
              </span>
              <span class="name att">
                <xsl:text>=</xsl:text>
              </span>
              <span class="val att">
                <xsl:text>"</xsl:text>
                <xsl:value-of select="namespace-uri-for-prefix(current-grouping-key(), (.[self::*], ..)[1])"/>
                <xsl:text>"</xsl:text>
              </span>
            </span>
          </xsl:for-each-group>
        </xsl:if>
        <xsl:apply-templates select="@*" mode="#current"/>
      </xsl:document>
    </xsl:variable>
    <xsl:iterate select="$atts/node()">
      <xsl:param name="length" as="xs:integer" select="0"/>
      <xsl:variable name="multiline-max" as="xs:integer" 
        select="max(tokenize(., '&#xa;') ! string-length(.)) => xs:integer()"/>
      <xsl:variable name="new-length" as="xs:integer" select="$length + $multiline-max"/>
      <xsl:if test="$new-length gt $max-length-for-atts">
        <br xmlns="http://www.w3.org/1999/xhtml"/>
      </xsl:if>
      <xsl:sequence select="."/>
      <xsl:next-iteration>
        <xsl:with-param name="length" select="if ($new-length gt $max-length-for-atts) 
                                              then string-length(.) else $new-length"/>
      </xsl:next-iteration>
    </xsl:iterate>
    <xsl:choose>
      <xsl:when test="empty(node())">
        <span class="name elt">/></span>
      </xsl:when>
      <xsl:otherwise>
        <span class="name elt">></span>
        <xsl:apply-templates mode="#current"/>
        <span class="name elt">
          <xsl:text>&lt;/</xsl:text>
          <xsl:value-of select="name()"/>
          <xsl:text>></xsl:text>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="@*" mode="serialize" priority="1">
    <xsl:text>  </xsl:text>
    <span>
      <span class="name att">
        <xsl:value-of select="name()"/>
      </span>
      <span class="val att">
        <xsl:text>="</xsl:text>
        <xsl:value-of select=". => replace('[ ]([ ]{4,})', '&#xa;$1') (: attribute values were probably multiline :)
                                => replace('&amp;', '&amp;amp;')
                                => replace('&lt;', '&amp;lt;')
                                => replace('&#x22;', '&amp;quot;')"/>
        <xsl:text>"</xsl:text>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="*" mode="xmlns">
    <xsl:if test="not(namespace-uri(.) = namespace-uri(..))
                  and not(in-scope-prefixes(.) = prefix-from-QName(node-name(.)))">
      <span>
        <span class="name att">
          <xsl:text xml:space="preserve"> xmlns=</xsl:text>
        </span>
        <span class="val att">
          <xsl:text>"</xsl:text>
          <xsl:value-of select="namespace-uri(.)"/>
          <xsl:text>"</xsl:text>
        </span>
      </span>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="text()" mode="serialize" priority="1">
    <xsl:value-of select=". => replace('&amp;', '&amp;amp;')
                            => replace('&lt;', '&amp;lt;')"/>
  </xsl:template>

  <xsl:template match="comment()" mode="serialize" priority="1">
    <span class="comment{if(empty(parent::*)) then ' unselectable' else''}">
      <xsl:if test="empty(parent::*)">
        <xsl:attribute name="title" select="'this comment cannot be selected'"/>
      </xsl:if>
      <xsl:value-of select="string-join(('&lt;!--', ., '-->'))"/>
    </span>
    <xsl:if test="empty(parent::*)">&#xa0;&#xa;</xsl:if>
  </xsl:template>
  
  <xsl:template match="processing-instruction()" mode="serialize" priority="1">
    <span class="pi{if(empty(parent::*)) then ' unselectable' else''}">
      <xsl:if test="empty(parent::*)">
        <xsl:attribute name="title" select="'this PI cannot be selected'"/>
      </xsl:if>
      <xsl:value-of select="string-join(('&lt;?', name(), ' ', ., '?>'))"/>  
    </span>
    <xsl:if test="empty(parent::*)">&#xa0;&#xa;</xsl:if>
  </xsl:template>


  
</xsl:stylesheet>