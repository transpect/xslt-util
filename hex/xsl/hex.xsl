<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr-hex-private="http://transpect.io/xslt-util/hex/private"
  xmlns:tr="http://transpect.io"
  version="2.0">

  <xsl:function name="tr:hex-to-dec" as="xs:integer">
    <xsl:param name="in" as="xs:string"/>
    <!-- e.g. 030C -->
    <xsl:sequence
      select="
    if (string-length($in) eq 1)
       then tr-hex-private:hex-digit-to-integer($in)
       else 16*tr:hex-to-dec(substring($in, 1, string-length($in)-1)) +
              tr-hex-private:hex-digit-to-integer(substring($in, string-length($in)))"/>
  </xsl:function>

  <xsl:function name="tr-hex-private:hex-digit-to-integer" as="xs:integer">
    <xsl:param name="char"/>
    <xsl:sequence
      select="string-length(substring-before('0123456789ABCDEF',
  	  upper-case($char)))"/>
  </xsl:function>

  <xsl:function name="tr:dec-to-hex" as="xs:string">
    <xsl:param name="in" as="xs:integer?"/>
    <xsl:sequence
      select="if (not($in) or ($in eq 0)) 
                          then '0' 
                          else concat(
                            if ($in gt 15) 
                            then tr:dec-to-hex($in idiv 16) 
                            else '',
                            substring('0123456789ABCDEF', ($in mod 16) + 1, 1)
                          )"/>
  </xsl:function>

  <xsl:function name="tr:pad" as="xs:string">
    <xsl:param name="string" as="xs:string"/>
    <xsl:param name="width" as="xs:integer"/>
    <xsl:sequence
      select="string-join((for $i in (string-length($string) to $width - 1) return '0', $string), '')"/>
  </xsl:function>

</xsl:stylesheet>
