<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr="http://transpect.io"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <xsl:import href="http://transpect.io/xslt-util/num/xsl/num.xsl"/>
  
  <xsl:function name="tr:string-to-UPAD4" as="xs:string*">
    <xsl:param name="chars" as="xs:string"/>
    <xsl:sequence select="for $c in string-to-codepoints($chars) return concat('U+', tr:pad(tr:dec-to-hex($c), 4))"/>
  </xsl:function>
  
  <xsl:function name="tr:string-to-char-UPAD4" as="xs:string*">
    <xsl:param name="chars" as="xs:string"/>
    <xsl:sequence select="
      for $n 
      in (1 to string-length($chars))
      return string-join((substring($chars, $n, 1), ' (', tr:string-to-UPAD4(substring($chars, $n, 1)), ')'), '')"/>
  </xsl:function>
  
  <xsl:function name="tr:decode-text-with-html-ent" as="xs:string*">
    <xsl:param name="string" as="item()*"/>
    <xsl:variable name="regex-ent" select="'&amp;(\p{L}+);'"/>
    
    <xsl:analyze-string select="string-join($string, '')" regex="{$regex-ent}">
      <xsl:matching-substring>
        <xsl:value-of select="normalize-space(tr:decode-html-ent(regex-group(1)))"/>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:function>
  
  <xsl:function name="tr:decode-html-ent" as="xs:string*">
    <xsl:param name="string" as="xs:string"/>
    <xsl:value-of select="map:get($tr:html-entity-map, $string)"/>
  </xsl:function>
  
  <xsl:variable name="tr:html-entity-map" as="map(xs:string, xs:string)"
              select="map{ 
                          'le': '&#8804;',
                          'Yacute': '&#253;',
                          'cup': '&#8746;',
                          'sim': '&#8764;',
                          'real': '&#8476;',
                          'sub': '&#8834;',
                          'gt': '&#62;',
                          'lfloor': '&#8970;',
                          'ordf': '&#170;',
                          'sup': '&#8835;',
                          'otimes': '&#8855;',
                          'Ouml': '&#214;',
                          'ouml': '&#246;',
                          'sube': '&#8838;',
                          'Sigma': '&#963;',
                          'reg': '&#174;',
                          'Beta': '&#946;',
                          'oplus': '&#8853;',
                          'Pi': '&#960;',
                          'ETH': '&#240;',
                          'rfloor': '&#8971;',
                          'shy': '&#173;',
                          'Oslash': '&#248;',
                          'Otilde': '&#245;',
                          'ang': '&#8736;',
                          'trade': '&#8482;',
                          'fnof': '&#402;',
                          'Chi': '&#967;',
                          'upsih': '&#978;',
                          'frac12': '&#189;',
                          'rlm': '&#8207;',
                          'Eacute': '&#233;',
                          'permil': '&#8240;',
                          'hearts': '&#9829;',
                          'Icirc': '&#238;',
                          'cent': '&#162;',
                          'AElig': '&#230;',
                          'Psi': '&#968;',
                          'sum': '&#8721;',
                          'divide': '&#247;',
                          'iquest': '&#191;',
                          'Ecirc': '&#234;',
                          'ensp': '&#8194;',
                          'empty': '&#8709;',
                          'forall': '&#8704;',
                          'emsp': '&#8195;',
                          'Gamma': '&#947;',
                          'lceil': '&#8968;',
                          'dagger': '&#8225;',
                          'not': '&#172;',
                          'equiv': '&#8801;',
                          'Acirc': '&#226;',
                          'Agrave': '&#224;',
                          'Eta': '&#951;',
                          'alefsym': '&#8501;',
                          'ordm': '&#186;',
                          'piv': '&#982;',
                          'bdquo': '&#8222;',
                          'Delta': '&#948;',
                          'or': '&#8744;',
                          'acute': '&#180;',
                          'deg': '&#176;',
                          'cong': '&#8773;',
                          'Ntilde': '&#241;',
                          'lsaquo': '&#8249;',
                          'clubs': '&#9827;',
                          'hellip': '&#8230;',
                          'Ograve': '&#242;',
                          'Iuml': '&#207;',
                          'iuml': '&#239;',
                          'diams': '&#9830;',
                          'cedil': '&#184;',
                          'amp': '&#38;',
                          'Alpha': '&#945;',
                          'Egrave': '&#232;',
                          'darr': '&#8659;',
                          'and': '&#8743;',
                          'nsub': '&#8836;',
                          'ne': '&#8800;',
                          'Epsilon': '&#949;',
                          'isin': '&#8712;',
                          'Ccedil': '&#231;',
                          'lsquo': '&#8216;',
                          'copy': '&#169;',
                          'Aacute': '&#225;',
                          'Theta': '&#952;',
                          'mdash': '&#8212;',
                          'Euml': '&#203;',
                          'euml': '&#235;',
                          'Kappa': '&#954;',
                          'notin': '&#8713;',
                          'iexcl': '&#161;',
                          'ge': '&#8805;',
                          'Igrave': '&#236;',
                          'harr': '&#8660;',
                          'lowast': '&#8727;',
                          'Ocirc': '&#244;',
                          'infin': '&#8734;',
                          'brvbar': '&#166;',
                          'int': '&#8747;',
                          'macr': '&#175;',
                          'frac34': '&#190;',
                          'curren': '&#164;',
                          'asymp': '&#8776;',
                          'Lambda': '&#955;',
                          'frasl': '&#8260;',
                          'circ': '&#710;',
                          'crarr': '&#8629;',
                          'OElig': '&#339;',
                          'image': '&#8465;',
                          'there4': '&#8756;',
                          'lt': '&#60;',
                          'minus': '&#8722;',
                          'Atilde': '&#227;',
                          'ldquo': '&#8220;',
                          'nabla': '&#8711;',
                          'exist': '&#8707;',
                          'auml': '&#228;',
                          'Auml': '&#196;',
                          'Mu': '&#956;',
                          'frac14': '&#188;',
                          'nbsp': '&#160;',
                          'Oacute': '&#243;',
                          'bull': '&#8226;',
                          'larr': '&#8656;',
                          'laquo': '&#171;',
                          'oline': '&#8254;',
                          'ndash': '&#8211;',
                          'euro': '&#8364;',
                          'micro': '&#181;',
                          'Nu': '&#957;',
                          'cap': '&#8745;',
                          'Aring': '&#229;',
                          'Omicron': '&#959;',
                          'Iacute': '&#237;',
                          'perp': '&#8869;',
                          'para': '&#182;',
                          'rarr': '&#8658;',
                          'raquo': '&#187;',
                          'Ucirc': '&#251;',
                          'Iota': '&#953;',
                          'sbquo': '&#8218;',
                          'loz': '&#9674;',
                          'thetasym': '&#977;',
                          'ni': '&#8715;',
                          'part': '&#8706;',
                          'rdquo': '&#8221;',
                          'weierp': '&#8472;',
                          'sup1': '&#185;',
                          'sup2': '&#178;',
                          'Uacute': '&#250;',
                          'sdot': '&#8901;',
                          'Scaron': '&#353;',
                          'yen': '&#165;',
                          'Xi': '&#958;',
                          'plusmn': '&#177;',
                          'yuml': '&#376;',
                          'THORN': '&#254;',
                          'rang': '&#9002;',
                          'Ugrave': '&#249;',
                          'radic': '&#8730;',
                          'zwj': '&#8205;',
                          'tilde': '&#732;',
                          'uarr': '&#8657;',
                          'times': '&#215;',
                          'thinsp': '&#8201;',
                          'sect': '&#167;',
                          'rceil': '&#8969;',
                          'szlig': '&#223;',
                          'supe': '&#8839;',
                          'uuml': '&#252;',
                          'Uuml': '&#220;',
                          'rsquo': '&#8217;',
                          'Zeta': '&#950;',
                          'Rho': '&#961;',
                          'lrm': '&#8206;',
                          'Phi': '&#966;',
                          'zwnj': '&#8204;',
                          'lang': '&#9001;',
                          'pound': '&#163;',
                          'sigmaf': '&#962;',
                          'uml': '&#168;',
                          'prop': '&#8733;',
                          'Upsilon': '&#965;',
                          'Omega': '&#969;',
                          'middot': '&#183;',
                          'Tau': '&#964;',
                          'sup3': '&#179;',
                          'rsaquo': '&#8250;',
                          'prod': '&#8719;',
                          'quot': '&#34;',
                          'prime': '&#8243;',
                          'spades': '&#9824;'
                          }"/>
  
  
</xsl:stylesheet>