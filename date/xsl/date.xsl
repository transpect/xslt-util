<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs= "http://www.w3.org/2001/XMLSchema"
  xmlns:css= "http://www.w3.org/1996/css"
  xmlns:tr="http://transpect.io"
  version="2.0"
  exclude-result-prefixes="#all">

  <!--
  functions to work with date strings 
  see also https://github.com/transpect/xslt-util/trunk/functx/xsl/functx.xsl 
  -->
  
  <!-- function tr:string-to-date
       param string: input string, examples:
        (https://www.w3.org/TR/xslt20/#date-time-examples)
        2002-12-31
        12-31-2002
        31-12-2002
        31 XII 2002
        31st December, 2002
        31 DEC 2002
        December 31, 2002
        31 Dezember, 2002
        Tisdag 31 December 2002
        [2002-12-31]
        Two Thousand and Three
        einunddreißigste Dezember
        3:58 PM
        3:58:45 pm
        3:58:45 PM PDT
        3:58:45 o'clock PM PDT
        15:58
        15:58:45.762
        15:58:45 GMT+02:00
        15.58 Uhr GMT+
        3.58pm on Tuesday, 31st December
        12/31/2002 at 15:58:45
       param any-context: optional, to lookup for an ancestor xml:lang 
  -->
  <xsl:function name="tr:string-to-date" as="element()">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="any-context" as="xs:anyAtomicType"/>
    <xsl:variable name="string"  as="xs:string"
      select="replace($input, '^(\s\(\])+|(\s\)\])+$', '')"/>
    <xsl:variable name="result">
      <xsl:choose>
        <!-- empty input = empty output -->
        <xsl:when test="$string = ''"/>
        <!-- '2021', '1999': year only -->
        <xsl:when test="matches($string, '^(19|20)\d\d$')">
          <year>
            <xsl:value-of select="$string"/>
          </year>
        </xsl:when>
        <!-- '2020/12/23', MM/DD/YYYY, DD/MM/YYYY, YYYY/MM/DD -->
        <xsl:when test="matches($string, '^(19|20)\d\d/\d\d/\d\d$')">
          <xsl:variable name="group-2" as="xs:integer"
            select="xs:integer(replace($input, '^((19|20)\d\d)/(\d\d)/(\d\d)$', '$3'))"/>
          <xsl:variable name="group-3" as="xs:integer"
            select="xs:integer(replace($input, '^((19|20)\d\d)/(\d\d)/(\d\d)$', '$4'))"/>
          <year>
            <xsl:value-of select="replace($input, '^((19|20)\d\d)/(\d\d)/(\d\d)$', '$1')"/>
          </year>
          <xsl:choose>
            <xsl:when test="$group-2 gt 12">
              <month><xsl:value-of select="$group-3"/></month>
              <day><xsl:value-of select="$group-2"/></day>
            </xsl:when>
            <xsl:when test="$group-3 gt 12">
              <month><xsl:value-of select="$group-2"/></month>
              <day><xsl:value-of select="$group-3"/></day>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
        </xsl:when>
        <!-- '10 November 2006', 'October 11, 2006', '2010 November 6' -->
        <!--<xsl:when test="false()">
        </xsl:when>-->
        <!-- 20001200 -->
        <!--<xsl:when test="false()">
        </xsl:when>-->
        <xsl:otherwise>
          <output>err</output>
          <xsl:comment>No known/valid date format in input string found!</xsl:comment>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tr:result input="{$input}">
      <xsl:if test="string-join(($result/year, $result/month, $result/day), '-') castable as xs:date">
        <xsl:attribute name="xs:date" select="string-join(($result/year, $result/month, $result/day), '-')"/>
      </xsl:if>
      <xsl:sequence select="$result"/>
    </tr:result>
  </xsl:function>

  <xsl:template name="tr_string-to-date_test">
    <xsl:message select="'&#xa;', tr:string-to-date('1999 107', '')"/>
    <xsl:message select="'&#xa;################################'"/>
    <xsl:message select="'&#xa;', tr:string-to-date('2020/12/23', '')"/>
  </xsl:template>

</xsl:stylesheet>
