<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:functx="http://www.functx.com"
  xmlns:tr="http://transpect.io"
  exclude-result-prefixes="xs"
  version="3.0">
  
  <xsl:import href="http://transpect.io/xslt-util/num/xsl/num.xsl"/>
  <xsl:import href="http://transpect.io/xslt-util/functx/xsl/functx.xsl"/>
  
  <!-- tr:regex-from-string( xs:string )
    
       creates a regex representation from a string,
       e.g. 'abcd01234' => '([0-4]|[a-d])+'
  -->
  
  <xsl:function name="tr:regex-from-string" as="xs:string">
    <xsl:param name="string" as="xs:string*"/>
    <xsl:variable name="range-map" as="map(xs:integer, xs:integer*)"
                  select="tr:get-adjacent-integers-from-seq(
                            sort(distinct-values(string-to-codepoints(string-join($string, ''))))
                          )"/>
    <xsl:variable name="regexes-from-range-map" as="xs:string*"
                  select="for $i in (1 to map:size($range-map))
                          return let $seq := map:get($range-map, $i)
                                 return if(count($seq) gt 1)
                                          then concat('[',
                                                      functx:escape-for-regex(codepoints-to-string($seq[1])),
                                                      '-',
                                                      functx:escape-for-regex(codepoints-to-string($seq[last()])),
                                                      ']')
                                        else if(count($seq) eq 1)
                                          then '[' || functx:escape-for-regex(codepoints-to-string($seq)) || ']'
                                        else ()"/>
    <xsl:sequence select="concat('(',
                                 string-join($regexes-from-range-map, '|'), 
                                 if(string-length($string) eq 1)
                                 then ')'
                                 else  ')+')"/>
  </xsl:function>
  
</xsl:stylesheet>