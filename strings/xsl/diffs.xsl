<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr="http://transpect.io"
  exclude-result-prefixes="xs tr"
  version="2.0">
  
  <xsl:function name="tr:diff-strings" as="xs:string*">
    <xsl:param name="string1" as="xs:string?"/>
    <xsl:param name="string2" as="xs:string?"/>
    <xsl:param name="context" as="xs:double"/>

  <xsl:choose>
    <xsl:when test="empty($string2)">
      <xsl:sequence select="$string1"/>
    </xsl:when>
    <xsl:when test="empty($string1)">
      <xsl:sequence select="$string2"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:sequence select="substring($string1, 
                                    tr:first-diff($string1,$string2)-$context,
                                    string-length($string1)+2- tr:last-diff($string1,$string2)- tr:first-diff($string1,$string2)+2*$context), 
                          substring($string2,
                                    tr:first-diff($string1,$string2)-$context,
                                    string-length($string2)+2- tr:last-diff($string1,$string2)- tr:first-diff($string1,$string2)+2*$context)"/>      
    </xsl:otherwise>
  </xsl:choose>
  </xsl:function>
  
  <xsl:function name="tr:diff-strings-pos" as="xs:string?">
    <xsl:param name="string" as="xs:string?"/>
    <xsl:param name="pos1" as="xs:double"/>
    <xsl:param name="pos2" as="xs:double"/>
    <xsl:param name="context" as="xs:double"/>

  <xsl:choose>
    <xsl:when test="empty($string)">
      <xsl:sequence select="''"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="normalized-pos1" select="(1[$pos1 - $context lt 2],$pos1 - $context)[1]"/>
      <xsl:variable name="normalized-pos2" select="(1[$pos2 - $context lt 2],$pos2 - $context)[1]"/>
      <xsl:sequence select="substring($string, 
                                      $normalized-pos1,
                                      string-length($string)+2- $normalized-pos2 - $normalized-pos1)"/>      
    </xsl:otherwise>
  </xsl:choose>
  </xsl:function>
  
  <xsl:function name="tr:before-diff" as="xs:string+">
    <xsl:param name="string1" as="xs:string"/>
    <xsl:param name="string2" as="xs:string"/>
    <xsl:param name="context" as="xs:double"/>
    
    <xsl:sequence select="(''[tr:first-diff($string1,$string2)-$context lt 2],
                           substring($string1, 1, tr:first-diff($string1,$string2) - 1 - $context))[1],
                          (''[tr:first-diff($string1,$string2)-$context lt 2],
                           substring($string2, 1, tr:first-diff($string1,$string2) - 1 - $context))[1]"/>
  </xsl:function>
  
  <xsl:function name="tr:after-diff" as="xs:string+">
    <xsl:param name="string1" as="xs:string"/>
    <xsl:param name="string2" as="xs:string"/>
    <xsl:param name="context" as="xs:double"/>
    
    <xsl:sequence select="(''[tr:last-diff($string1,$string2)-$context lt 2],
                           substring($string1, 
                                     string-length($string1)+2- tr:last-diff($string1,$string2), 
                                     tr:last-diff($string1,$string2)-1))[1],
                          (''[tr:last-diff($string1,$string2)-$context lt 2],
                           substring($string1, 
                                     string-length($string1)+2- tr:last-diff($string1,$string2)+$context, 
                                     tr:last-diff($string1,$string2)-$context - 1))[1]"/>
  </xsl:function>
  
  <xsl:function name="tr:before-diff-pos" as="xs:string?">
    <xsl:param name="string" as="xs:string"/>
    <xsl:param name="pos" as="xs:double"/>
    <xsl:param name="context" as="xs:double"/>
    
    <xsl:sequence select="(''[($pos - $context lt 2) or string-length($string)=0],
                           substring($string, 1, $pos - 1 - $context))[1]"/>
  </xsl:function>
  
  <xsl:function name="tr:after-diff-pos" as="xs:string?">
    <xsl:param name="string" as="xs:string"/>
    <xsl:param name="pos" as="xs:double"/>
    <xsl:param name="context" as="xs:double"/>
    
    <xsl:variable name="normalized-pos" select="$pos - $context"/>
    <xsl:sequence select="(''[$normalized-pos lt 2],
                           substring($string, 
                                     string-length($string)+2- $normalized-pos, 
                                     $normalized-pos - 1))[1]"/>
  </xsl:function>
 
  <xsl:function name="tr:last-diff" as="xs:double">
    <xsl:param name="string1" as="xs:string"/>
    <xsl:param name="string2" as="xs:string"/>
    
    <xsl:sequence select="tr:first-diff(codepoints-to-string(reverse(string-to-codepoints($string1))),
                                        codepoints-to-string(reverse(string-to-codepoints($string2))))"/>
  </xsl:function>
  
  <xsl:function name="tr:first-diff" as="xs:double">
    <xsl:param name="string1" as="xs:string"/>
    <xsl:param name="string2" as="xs:string"/>
    
    <xsl:sequence select="(1[(string-length($string1),string-length($string2))=0],
                           (for $length in min((string-length($string1), string-length($string2))),
                                $complete-match-result in $length +1,
                                $left-result in tr:aux-first-diff(substring($string1, 1, $length),
                                                                  substring($string2, 1, $length))
                            return min(($left-result, $complete-match-result))))[1]"/>
  </xsl:function>
  
  <xsl:function name="tr:aux-first-diff" as="xs:double">
    <xsl:param name="string1" as="xs:string"/>
    <xsl:param name="string2" as="xs:string"/>
    
    <xsl:sequence select="for $length in string-length($string1)
                          return if ($length eq 1)
                                 then 1 + number($string1 eq $string2)
                                 else for $half-length in $length idiv 2,
                                          $left-diff-pos in tr:aux-first-diff(substring($string1,1,$half-length),
                                                                              substring($string2,1,$half-length))
                                      return if ($left-diff-pos le $half-length)
                                             then $left-diff-pos
                                             else $left-diff-pos + tr:aux-first-diff(substring($string1,$half-length+1),
                                                                                     substring($string2,$half-length+1)) - 1"/>
  </xsl:function>
  
</xsl:stylesheet>