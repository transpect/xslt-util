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
    <xsl:variable name="base-orcid" as="xs:string" 
                  select="replace(replace($orcid, '^(https://orcid.org/)?(.+)$', '$2'), '-', '')"/>
    <xsl:variable name="total" select="0" as="xs:integer"/>
    <xsl:variable name="start-pos" select="1" as="xs:integer"/>
    <xsl:sequence select="    string-length($base-orcid) eq 16
                          and   tr:orcid-checksum($total, $start-pos, $base-orcid) 
                              = substring($base-orcid, 16, 1)"/>
  </xsl:function>
  
  <!--  *
        * tr:orcid-checksum($orcid)
        * 
        * Generates a checksum for a given ORCID iD. Permitted
        * value for $orcid are the base digits of the ORCID iD, e.g. 
        * 
        * 0000000236946012
        * -->
  
  <xsl:function name="tr:orcid-checksum" as="xs:string">
    <xsl:param name="total" as="xs:integer"/>
    <xsl:param name="pos" as="xs:integer"/>
    <xsl:param name="orcid" as="xs:string"/>
    <xsl:variable name="digit" select="substring($orcid, $pos, 1)" as="xs:string"/>
    <xsl:variable name="new-total" as="xs:integer"
                  select="($total + (if($digit eq 'X') then 10 else xs:integer($digit))) * 2"/>
    <xsl:choose>
      <xsl:when test="$pos &lt; 15">
        <xsl:sequence select="tr:orcid-checksum($new-total, $pos + 1, $orcid)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="remainder" select="$new-total mod 11" as="xs:integer"/>
        <xsl:variable name="result" select="(12 - $remainder) mod 11" as="xs:integer"/>
        <xsl:sequence select="if($result eq 10) then 'X' else xs:string($result)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <!-- for testing -->
  
  <xsl:template name="main">
    <xsl:sequence select="tr:orcid-valid('0000-0002-3694-6012')"/>
  </xsl:template>
  
</xsl:stylesheet>