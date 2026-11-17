<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr="http://transpect.io"
  exclude-result-prefixes="tr"
  version="2.0">
  
  <xsl:function name="tr:normalize-xmlid" as="xs:string">
    <xsl:param name="input" as="xs:string?"/>
    <xsl:variable name="name-char-inner" as="xs:string"
                  select="'-.0-9&#xb7;A-Z_a-z&#xc0;-&#xd6;&#xd8;-&#xf6;&#xf8;-&#x2ff;&#x300;-&#x37d;&#x37f;-&#x1fff;&#x200c;&#x200d;&#x203f;-&#x2040;&#x2070;-&#x218f;&#x2c00;-&#x2fef;&#x3001;-&#xd7ff;&#xf900;-&#xfdcf;&#xfdf0;-&#xfffd;&#x10000;-&#xeffff;'"/>
    <xsl:variable name="start-char-inner" as="xs:string"
                  select="'A-Z_a-z&#xc0;-&#xd6;&#xd8;-&#xf6;&#xf8;-&#x2ff;&#x370;-&#x37d;&#x37f;-&#x1fff;&#x200c;&#x200d;&#x2070;-&#x218f;&#x2c00;-&#x2fef;&#x3001;-&#xd7ff;&#xf900;-&#xfdcf;&#xfdf0;-&#xfffd;&#x10000;-&#xeffff;'"/>
    <xsl:variable name="cleaned" as="xs:string"
                  select="replace(normalize-space($input), concat('[^', $name-char-inner, ']'), '_')"/>
    <xsl:sequence select="     if ($cleaned eq '')                                          then concat('id_', generate-id())
                          else if (matches($cleaned, concat('^[', $start-char-inner, ']'))) then $cleaned
                          else                                                                   concat('_', $cleaned)"/>
  </xsl:function>
  
</xsl:stylesheet>


