<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl		= "http://www.w3.org/1999/XSL/Transform"
  xmlns:xs		= "http://www.w3.org/2001/XMLSchema"
  xmlns:tr= "http://transpect.io"
  xmlns:tr-hex-private		= "http://transpect.io"
  >

  <xsl:output method="text"/><!-- only applies to the 'test' template below -->

  <xsl:function name="tr:hex-to-dec" as="xs:integer">
    <xsl:param name="in" as="xs:string"/> <!-- e.g. 030C -->
    <xsl:sequence select="if (string-length($in) eq 0)
                          then 0
                          else
                            if (string-length($in) eq 1)
                            then tr-hex-private:hex-digit-to-integer($in)
                            else 16*tr:hex-to-dec(substring($in, 1, string-length($in)-1))
                                 + tr-hex-private:hex-digit-to-integer(substring($in, string-length($in)))"/>
  </xsl:function>
  
  <xsl:function name="tr-hex-private:hex-digit-to-integer" as="xs:integer">
    <xsl:param name="char"/>
    <xsl:sequence 
  	  select="string-length(substring-before('0123456789ABCDEF',
  	  upper-case($char)))"/>
  </xsl:function>

  <xsl:function name="tr:dec-to-hex" as="xs:string">
    <xsl:param name="in" as="xs:integer?"/>
    <xsl:sequence select="if (not($in) or ($in eq 0)) 
                          then '0' 
                          else concat(
                            if ($in gt 15) 
                            then tr:dec-to-hex($in idiv 16) 
                            else '',
                            substring('0123456789ABCDEF', ($in mod 16) + 1, 1)
                          )"/>
  </xsl:function>
  
  <xsl:function name="tr:pad" as="xs:string">
    <xsl:param name="string"     as="xs:string"/>
    <xsl:param name="width"     as="xs:integer"/>
    <xsl:sequence select="string-join((for $i in (string-length($string) to $width - 1) return '0', $string), '')"/>
  </xsl:function>

  <xsl:variable name="tr-hex-private:cp-base" select="string-to-codepoints('0A')" as="xs:integer+" />

  <!-- http://stackoverflow.com/a/13778818 credits to Sean B. Durkin -->
  <xsl:function name="tr:unescape-uri" as="xs:string?">
    <xsl:param name="uri" as="xs:string?"/>
    <xsl:variable name="chars" as="xs:string*">
      <xsl:if test="$uri">
        <xsl:analyze-string select="$uri" regex="(%[0-9A-F]{{2}})+" flags="i">
          <xsl:matching-substring>
            <xsl:variable name="utf8-bytes" as="xs:integer+">
              <xsl:analyze-string select="." regex="%([0-9A-F]{{2}})" flags="i">
                <xsl:matching-substring>
                  <xsl:variable name="nibble-pair"
                    select="for $nibble-char in string-to-codepoints( upper-case(regex-group(1))) 
                        return
                          if ($nibble-char ge $tr-hex-private:cp-base[2]) 
                          then $nibble-char - $tr-hex-private:cp-base[2] + 10
                          else $nibble-char - $tr-hex-private:cp-base[1]"
                    as="xs:integer+"/>
                  <xsl:sequence select="$nibble-pair[1] * 16 + $nibble-pair[2]"/>
                </xsl:matching-substring>
              </xsl:analyze-string>
            </xsl:variable>
            <xsl:value-of select="codepoints-to-string( tr:utf8decode( $utf8-bytes))"/>
          </xsl:matching-substring>
          <xsl:non-matching-substring>
            <xsl:value-of select="."/>
          </xsl:non-matching-substring>
        </xsl:analyze-string>
      </xsl:if>
    </xsl:variable>
    <xsl:sequence select="string-join($chars, '')"/>
  </xsl:function>

  <!-- http://stackoverflow.com/a/13778818 credits to Sean B. Durkin -->
  <xsl:function name="tr:utf8decode" as="xs:integer*">
    <xsl:param name="bytes" as="xs:integer*"/>
    <xsl:choose>
      <xsl:when test="empty($bytes)"/>
      <xsl:when test="$bytes[1] eq 0">
        <!-- The null character is not valid for XML. -->
        <xsl:sequence select="tr:utf8decode( remove( $bytes, 1))"/>
      </xsl:when>
      <xsl:when test="$bytes[1] le 127">
        <xsl:sequence select="$bytes[1], tr:utf8decode( remove( $bytes, 1))"/>
      </xsl:when>
      <xsl:when test="$bytes[1] lt 224">
        <xsl:sequence
          select="
      ((($bytes[1] - 192) * 64) +
        ($bytes[2] - 128)        ),
        tr:utf8decode( remove( remove( $bytes, 1), 1))"
        />
      </xsl:when>
      <xsl:when test="$bytes[1] lt 240">
        <xsl:sequence
          select="
      ((($bytes[1] - 224) * 4096) +
       (($bytes[2] - 128) *   64) +
        ($bytes[3] - 128)          ),
        tr:utf8decode( remove( remove( remove( $bytes, 1), 1), 1))"
        />
      </xsl:when>
      <xsl:when test="$bytes[1] lt 248">
        <xsl:sequence
          select="
      ((($bytes[1] - 224) * 262144) +
       (($bytes[2] - 128) *   4096) +
       (($bytes[3] - 128) *     64) +
        ($bytes[4] - 128)            ),
        tr:utf8decode( $bytes[position() gt 4])"
        />
      </xsl:when>
      <xsl:otherwise>
        <!-- Code-point valid for XML. -->
        <xsl:sequence select="tr:utf8decode( remove( $bytes, 1))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="tr:escape-html-uri" as="xs:string">
    <xsl:param name="in" as="xs:string"/>
    <xsl:variable name="prelim" as="xs:string*">
      <xsl:analyze-string select="escape-html-uri($in)" regex="[\[\]&lt;&gt;]">
        <xsl:matching-substring>
          <xsl:sequence select="concat('%', tr:dec-to-hex(string-to-codepoints(.)[1]))"/>
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <xsl:sequence select="."/>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:variable>
    <xsl:sequence select="string-join($prelim, '')"/>
  </xsl:function>

  <xsl:template name="test">
    <!-- Should return:
À la Pêche
 http://doi.org/10.1352/0895-8017(2008)113%5B32:ECICWD%5D%C3%A4%3E2.0.CO;2
-->
    <xsl:sequence select="tr:unescape-uri('A%CC%80%20la%20Pe%CC%82che')"/>
    <xsl:sequence select="'&#xa;'"/>
    <xsl:sequence select="tr:escape-html-uri('http://doi.org/10.1352/0895-8017(2008)113[32:ECICWD]ä>2.0.CO;2')"/>
  </xsl:template>

</xsl:stylesheet>
