<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr="http://transpect.io"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <!--  *
        * tr:orcid-valid($orcid)
        * 
        * Validates ORCID iD in accordance with ISO/IEC 7064:2003.
        * The last number of the ORCID iD is a checksum with the 
        * values [0-9X] where 'X' represents 10. If the checksum of 
        * the first 15 digits match the value of the last digit, the
        * ORCID iD is valid. For tr:orcid-valid($orcid), the 
        * argument $orcid can have this form:
        * 
        * https://orcid.org/0000-0002-3694-6012 
        * 0000-0002-3694-6012
        * 0000000236946012
        * -->  
  
  <xsl:function name="tr:orcid-valid" as="xs:boolean">
    <xsl:param name="orcid" as="xs:string"/>
    <xsl:variable name="base-orcid" select="replace($orcid, '[-a-z\.:/\s]+', '', 'i')" as="xs:string"/>
    <xsl:sequence select="    string-length($base-orcid) eq 16
                          and   tr:orcid-checksum($base-orcid) 
                              = substring($base-orcid, 16, 1)"/>
  </xsl:function>
  
  <!--  *
        * tr:orcid-checksum($orcid)
        * 
        * Generates a checksum for a given ORCID iD.
        * 
        * -->
  
  <xsl:function name="tr:orcid-checksum" as="xs:string">
    <xsl:param name="orcid" as="xs:string"/>
    <xsl:variable name="base-orcid" select="replace($orcid, '[-a-z\.:/\s]+', '', 'i')" as="xs:string"/>
    <xsl:value-of select="tr:orcid-checksum-eval((), (), $base-orcid)"/>
  </xsl:function>
  
  <xsl:function name="tr:orcid-checksum-eval" as="xs:string">
    <xsl:param name="start-total" as="xs:integer?"/>
    <xsl:param name="start-pos" as="xs:integer?"/>
    <xsl:param name="orcid" as="xs:string"/>
    <xsl:variable name="total" select="($start-total, 0)[1]" as="xs:integer"/>
    <xsl:variable name="pos" select="($start-pos, 1)[1]" as="xs:integer"/>
    <xsl:variable name="digit" select="substring($orcid, $pos, 1)" as="xs:string"/>
    <xsl:variable name="new-total" as="xs:integer"
                  select="($total + (if($digit eq 'X') then 10 else xs:integer($digit))) * 2"/>
    <xsl:choose>
      <xsl:when test="$pos &lt; 15">
        <xsl:sequence select="tr:orcid-checksum-eval($new-total, $pos + 1, $orcid)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="remainder" select="$new-total mod 11" as="xs:integer"/>
        <xsl:variable name="result" select="(12 - $remainder) mod 11" as="xs:integer"/>
        <xsl:sequence select="if($result eq 10) then 'X' else xs:string($result)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <!--  *
        * tr:orcid-regex-valid($orcid)
        * 
        * check whether the argument conforms to the ORCID regex
        * -->
  
  <xsl:variable name="orcid-regex" select="'https://orcid\.org/(\d{4}-){3}\d{4}'" as="xs:string"/>
  
  <xsl:function name="tr:orcid-regex-valid" as="xs:boolean">
    <xsl:param name="orcid" as="xs:string"/>
    <xsl:sequence select="matches($orcid, $orcid-regex)"/>
  </xsl:function>
  
</xsl:stylesheet>