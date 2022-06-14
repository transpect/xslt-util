<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl		= "http://www.w3.org/1999/XSL/Transform"
  xmlns:xs		= "http://www.w3.org/2001/XMLSchema"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:tr= "http://transpect.io"
  xmlns:tr-hex-private		= "http://transpect.io"
  exclude-result-prefixes="xs tr"
  >

  <xsl:import href="num-3.0.xsl" use-when="xs:decimal(system-property('xsl:version')) ge 3.0"/>

<!--  <xsl:output method="text"/>-->
  <!-- only applies to the 'test_*' templates below  
    GI 2019-09-29: I had to comment this out because of a "Conflicting values for 
  output property method" error when including this XSL in a Schematron schema. -->


  <!-- hex ================================================================================================================= -->

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
            <xsl:sequence select="codepoints-to-string( tr:utf8decode( $utf8-bytes))"/>
          </xsl:matching-substring>
          <xsl:non-matching-substring>
            <xsl:sequence select="."/>
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
      ((($bytes[1] - 240) * 262144) +
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

  <xsl:template name="test_hex">
    <!-- Should return:
À la Pêc,
À la Pêche,
&#x1f4a9;,
A ö Ж € &#x1D11E;,
http://doi.org/10.1352/0895-8017(2008)113%5B32:ECICWD%5D%C3%A4%3E2.0.CO;2
-->
    <doc>
      <!-- contains combining accents U+300 and U+302. The result may not display properly in oXygen --><xsl:value-of 
        select="tr:unescape-uri('A%CC%80%20la%20Pe%CC%82che')"/>,
      <xsl:value-of select="tr:unescape-uri('%C3%80%20la%20P%C3%AAche')"/>,
      <xsl:value-of select="tr:unescape-uri('%F0%9F%92%A9')"/>,
      <!-- taken from https://rosettacode.org/wiki/UTF-8_encode_and_decode --><xsl:value-of 
        select="tr:unescape-uri('%41 %C3%B6 %D0%96 %E2%82%AC %F0%9D%84%9E')"/>,
      <xsl:value-of select="tr:escape-html-uri('http://doi.org/10.1352/0895-8017(2008)113[32:ECICWD]ä>2.0.CO;2')"/>
    </doc>
  </xsl:template>
  
  <!-- /hex ================================================================================================================ -->
  
  
  <!-- letters-to-number =================================================================================================== -->
  
  <xsl:function name="tr:letters-to-number" as="xs:integer">
  <!--wrapper for 1-parameter-call; default: type=1-->
    <xsl:param name="string" as="xs:string"/>
    <xsl:sequence select="tr:letters-to-number($string,1)"/>
  </xsl:function>
  
  <xsl:function name="tr:letters-to-number" as="xs:integer">
    <!-- a, b, c, …, aa, ab, … to 1, 2, 3, …, 27, 28, …
      Maybe this function should also deal with a, b, c, …, aa, bb, cc, … -->
    
    <xsl:param name="string" as="xs:string"/>
    <xsl:param name="type"/>
    <!--possible values: 1: normal: a..z, aa, ab..az, ba, bb
                         2: double digits: a..z, aa, bb..zz-->
    
    <xsl:variable name="offset" as="xs:integer">
      <xsl:choose>
        <xsl:when test="matches($string, '^[a-z][a-z]?$')">
          <xsl:sequence select="96"/>
        </xsl:when>
        <xsl:when test="matches($string, '^[A-Z][A-Z]?$')">
          <xsl:sequence select="64"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="-1"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$type = 2">
        <!-- length ordered letter groups aa,bb -->
        <xsl:choose>
          <xsl:when test="$offset = -1">
            <xsl:sequence select="0"/><!-- or throw an error? -->
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="nums" as="xs:integer+">
              <xsl:for-each select="string-to-codepoints($string)">
                <xsl:sequence select="."/>
              </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="length" as="xs:integer" select="count($nums)"/>
            <xsl:sequence select="xs:integer((sum($nums) div $length) + (26 * ($length - 1)) - $offset)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- lexicographic ordered letters aa,ab -->
        <xsl:choose>
          <xsl:when test="$offset = -1">
            <xsl:sequence select="0"/><!-- or throw an error? -->
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="nums" as="xs:integer+">
              <xsl:for-each select="reverse(string-to-codepoints($string))">
                <xsl:sequence select="(. - $offset) * tr:pow(26, position() - 1)"/>
              </xsl:for-each>
            </xsl:variable>
            <xsl:sequence select="xs:integer(sum($nums))"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="tr:pow" as="xs:integer">
    <xsl:param name="base" as="xs:integer"/>
    <xsl:param name="power" as="xs:integer"/>
    <xsl:choose>
      <xsl:when test="$power eq 0">
        <xsl:sequence select="1"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="$base * tr:pow($base, $power - 1)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <!-- /letters-to-number ================================================================================================== -->
  
  <!-- number-to-letters ================================================================================================== -->
  
   <xsl:function name="tr:number-to-letters" as="xs:string?">
    <xsl:param name="num" as="xs:integer"/>
    <xsl:variable name="mod" select="$num mod 26" as="xs:integer"/>
    <xsl:variable name="pos" 
      select="xs:integer(floor($num div 26) + 1)"/>
    <xsl:variable name="alphas" as="xs:string+"
      select="('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')"/>
    <xsl:value-of select="string-join((for $n in 1 to $pos return $alphas[$mod]), '')"/>
   </xsl:function>

  <!-- /number-to-letters ================================================================================================== -->

  <!-- roman numerals ====================================================================================================== -->
  
  <xsl:function name="tr:roman-to-int" as="xs:integer?">
    <xsl:param name="roman" as="xs:string"/>
    <xsl:variable name="tokens" as="xs:string+" select="('I','IV','V','IX','X','XL','L','XC','C','CD','D','CM','M')"/>
    <xsl:variable name="atomic-numbers" as="xs:integer+" select="(1,4,5,9,10,40,50,90,100,400,500,900,1000)"/>
    <xsl:variable name="ints" as="xs:integer*">
      <xsl:analyze-string select="$roman" regex="(IV|IX|XL|XC|CD|CM|[IVXLCDM])" flags="i">
        
        <xsl:matching-substring>
          <xsl:sequence select="$atomic-numbers[index-of($tokens, upper-case(current()))]"/>
        </xsl:matching-substring>
        
        <xsl:non-matching-substring>
          <xsl:message>Non-roman digit <xsl:value-of select="."/> in <xsl:value-of select="$roman"/></xsl:message>
          <xsl:sequence select="-1"/>
        </xsl:non-matching-substring>
        
      </xsl:analyze-string>
    </xsl:variable>
    
    <xsl:variable name="ascending" as="xs:boolean*" select="for $i in (1 to xs:integer(count($ints) - 1)) return $ints[$i + 1] gt $ints[$i]"/>
    
    <xsl:choose>
      <xsl:when test="$ints = -1"/>
      <xsl:when test="some $a in $ascending satisfies ($a eq true())">
        <xsl:message>Incorrect roman numeral <xsl:value-of select="$roman"/>: The sequence of number tokens must be descending. Found: <xsl:value-of select="for $i in $ints return $tokens[index-of($atomic-numbers, $i)]"/> </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="sum" select="sum($ints)" as="xs:double?"/>
        <xsl:sequence select="if ($sum castable as xs:integer) then xs:integer($sum) else ()"/>    
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:function>
  
  <xsl:function name="tr:roman-or-int-to-int" as="xs:integer?">
    <xsl:param name="number" as="item()?"/>
    <xsl:choose>
      <xsl:when test="$number castable as xs:integer">
        <xsl:sequence select="xs:integer($number)"/>
      </xsl:when>
      <xsl:when test="matches($number, '^[IVXLCDM]+$', 'i')">
        <xsl:sequence select="tr:roman-to-int($number)"/>
      </xsl:when>
    </xsl:choose>
  </xsl:function>
  
  <xsl:template name="test_roman-to-int">
    <xsl:for-each select="('MCMLXXIV', 'MMD', 'MDM', 'MXM', 'IXL', 'MIW', 'XML')">
      <xsl:value-of select="."/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="tr:roman-to-int(.)"/>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>
  

</xsl:stylesheet>
