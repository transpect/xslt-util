<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr="http://transpect.io"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <xsl:variable name="tr:uri-regex" as="xs:string"
                select="'([a-z0-9+.-]+):(?://(?:((?:[a-z0-9-._~!$&amp;''()*+,;=:]|%[0-9A-F]{2})*)@)?((?:[a-z0-9-._~!$&amp;''()*+,;=]|%[0-9A-F]{2})*)(?::(\d*))?(/(?:[a-z0-9A-Z-._~!$&amp;''()*+,;=:@/]|%[0-9A-F]{2})*)?|(/?(?:[a-z0-9A-Z-._~!$&amp;''()*+,;=:@]|%[0-9A-F]{2})+(?:[a-z0-9A-Z-._~!$&amp;''()*+,;=:@/]|%[0-9A-F]{2})*)?)(?:\?((?:[a-z0-9A-Z-._~!$&amp;''()*+,;=:/?@]|%[0-9A-F]{2})*))?(?:#((?:[a-z0-9A-Z-._~!$&amp;''()*+,;=:/?@]|%[0-9A-F]{2})*))?'"/>
  
  <xsl:variable name="tr:uri-permitted-chars" as="xs:string"
                select="'%!\*''\( \);:@&amp;=\+$,/\?#\[\]a-z0-9\-_\.~'"/>
  
  <xsl:function name="tr:is-uri-valid" as="xs:boolean">
    <xsl:param name="uri" as="xs:string"/>
    <xsl:sequence select="matches($uri, concat('^', $tr:uri-regex, '$'))"/>
  </xsl:function>
  
  <xsl:function name="tr:uri-get-bad-chars" as="xs:string?">
    <xsl:param name="uri" as="xs:string"/>
    <xsl:sequence select="replace($uri, concat('[', $tr:uri-permitted-chars, ']'), '', 'i')"/>
  </xsl:function>
  
  <xsl:function name="tr:encode-for-url" as="xs:string?">
    <xsl:param name="url" as="xs:string"/>
    <xsl:sequence select="string-join(for $i in for $j in string-to-codepoints($url) 
                                                return codepoints-to-string($j)
                                      return if(matches($i, concat('[', $tr:uri-permitted-chars, ']'))) 
                                             then $i 
                                             else encode-for-uri($i), 
                                      '')"/>
  </xsl:function>
  
</xsl:stylesheet>
