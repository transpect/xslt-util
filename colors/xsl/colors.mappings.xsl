<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:css="http://www.w3.org/1996/css"
  xmlns:tr="http://transpect.io"
  version="2.0">

  <xsl:variable name="known-keywords" as="xs:string+"
    select="document('')//css:colors[@name eq 'keyword-hex-map']/css:color/@name"/>

  <xsl:function name="tr:color-keyword-to-hex-rgb" as="xs:string">
    <xsl:param name="keyword" as="xs:string" />
    <xsl:sequence select="document('')
                          //css:colors[@name eq 'keyword-hex-map']
                              /css:color[@name eq $keyword]
                                /@hex"/>
  </xsl:function>

  <!-- Keyword-Hex-Map
       See section 4.3 of http://www.w3.org/TR/css3-color/ -->
  <css:colors name="keyword-hex-map">
    <css:color name="aliceblue"             hex="#F0F8FF" />
    <css:color name="antiquewhite"          hex="#FAEBD7" />
    <css:color name="aqua"                  hex="#00FFFF" />
    <css:color name="aquamarine"            hex="#7FFFD4" />
    <css:color name="azure"                 hex="#F0FFFF" />
    <css:color name="beige"                 hex="#F5F5DC" />
    <css:color name="bisque"                hex="#FFE4C4" />
    <css:color name="black"                 hex="#000000" />
    <css:color name="blanchedalmond"        hex="#FFEBCD" />
    <css:color name="blue"                  hex="#0000FF" />
    <css:color name="blueviolet"            hex="#8A2BE2" />
    <css:color name="brown"                 hex="#A52A2A" />
    <css:color name="burlywood"             hex="#DEB887" />
    <css:color name="cadetblue"             hex="#5F9EA0" />
    <css:color name="chartreuse"            hex="#7FFF00" />
    <css:color name="chocolate"             hex="#D2691E" />
    <css:color name="coral"                 hex="#FF7F50" />
    <css:color name="cornflowerblue"        hex="#6495ED" />
    <css:color name="cornsilk"              hex="#FFF8DC" />
    <css:color name="crimson"               hex="#DC143C" />
    <css:color name="cyan"                  hex="#00FFFF" />
    <css:color name="darkblue"              hex="#00008B" />
    <css:color name="darkcyan"              hex="#008B8B" />
    <css:color name="darkgoldenrod"         hex="#B8860B" />
    <css:color name="darkgray"              hex="#A9A9A9" />
    <css:color name="darkgreen"             hex="#006400" />
    <css:color name="darkgrey"              hex="#A9A9A9" />
    <css:color name="darkkhaki"             hex="#BDB76B" />
    <css:color name="darkmagenta"           hex="#8B008B" />
    <css:color name="darkolivegreen"        hex="#556B2F" />
    <css:color name="darkorange"            hex="#FF8C00" />
    <css:color name="darkorchid"            hex="#9932CC" />
    <css:color name="darkred"               hex="#8B0000" />
    <css:color name="darksalmon"            hex="#E9967A" />
    <css:color name="darkseagreen"          hex="#8FBC8F" />
    <css:color name="darkslateblue"         hex="#483D8B" />
    <css:color name="darkslategray"         hex="#2F4F4F" />
    <css:color name="darkslategrey"         hex="#2F4F4F" />
    <css:color name="darkturquoise"         hex="#00CED1" />
    <css:color name="darkviolet"            hex="#9400D3" />
    <css:color name="deeppink"              hex="#FF1493" />
    <css:color name="deepskyblue"           hex="#00BFFF" />
    <css:color name="dimgray"               hex="#696969" />
    <css:color name="dimgrey"               hex="#696969" />
    <css:color name="dodgerblue"            hex="#1E90FF" />
    <css:color name="firebrick"             hex="#B22222" />
    <css:color name="floralwhite"           hex="#FFFAF0" />
    <css:color name="forestgreen"           hex="#228B22" />
    <css:color name="fuchsia"               hex="#FF00FF" />
    <css:color name="gainsboro"             hex="#DCDCDC" />
    <css:color name="ghostwhite"            hex="#F8F8FF" />
    <css:color name="gold"                  hex="#FFD700" />
    <css:color name="goldenrod"             hex="#DAA520" />
    <css:color name="gray"                  hex="#808080" />
    <css:color name="green"                 hex="#008000" />
    <css:color name="greenyellow"           hex="#ADFF2F" />
    <css:color name="grey"                  hex="#808080" />
    <css:color name="honeydew"              hex="#F0FFF0" />
    <css:color name="hotpink"               hex="#FF69B4" />
    <css:color name="indianred"             hex="#CD5C5C" />
    <css:color name="indigo"                hex="#4B0082" />
    <css:color name="ivory"                 hex="#FFFFF0" />
    <css:color name="khaki"                 hex="#F0E68C" />
    <css:color name="lavender"              hex="#E6E6FA" />
    <css:color name="lavenderblush"         hex="#FFF0F5" />
    <css:color name="lawngreen"             hex="#7CFC00" />
    <css:color name="lemonchiffon"          hex="#FFFACD" />
    <css:color name="lightblue"             hex="#ADD8E6" />
    <css:color name="lightcoral"            hex="#F08080" />
    <css:color name="lightcyan"             hex="#E0FFFF" />
    <css:color name="lightgoldenrodyellow"  hex="#FAFAD2" />
    <css:color name="lightgray"             hex="#D3D3D3" />
    <css:color name="lightgreen"            hex="#90EE90" />
    <css:color name="lightgrey"             hex="#D3D3D3" />
    <css:color name="lightpink"             hex="#FFB6C1" />
    <css:color name="lightsalmon"           hex="#FFA07A" />
    <css:color name="lightseagreen"         hex="#20B2AA" />
    <css:color name="lightskyblue"          hex="#87CEFA" />
    <css:color name="lightslategray"        hex="#778899" />
    <css:color name="lightslategrey"        hex="#778899" />
    <css:color name="lightsteelblue"        hex="#B0C4DE" />
    <css:color name="lightyellow"           hex="#FFFFE0" />
    <css:color name="lime"                  hex="#00FF00" />
    <css:color name="limegreen"             hex="#32CD32" />
    <css:color name="linen"                 hex="#FAF0E6" />
    <css:color name="magenta"               hex="#FF00FF" />
    <css:color name="maroon"                hex="#800000" />
    <css:color name="mediumaquamarine"      hex="#66CDAA" />
    <css:color name="mediumblue"            hex="#0000CD" />
    <css:color name="mediumorchid"          hex="#BA55D3" />
    <css:color name="mediumpurple"          hex="#9370DB" />
    <css:color name="mediumseagreen"        hex="#3CB371" />
    <css:color name="mediumslateblue"       hex="#7B68EE" />
    <css:color name="mediumspringgreen"     hex="#00FA9A" />
    <css:color name="mediumturquoise"       hex="#48D1CC" />
    <css:color name="mediumvioletred"       hex="#C71585" />
    <css:color name="midnightblue"          hex="#191970" />
    <css:color name="mintcream"             hex="#F5FFFA" />
    <css:color name="mistyrose"             hex="#FFE4E1" />
    <css:color name="moccasin"              hex="#FFE4B5" />
    <css:color name="navajowhite"           hex="#FFDEAD" />
    <css:color name="navy"                  hex="#000080" />
    <css:color name="oldlace"               hex="#FDF5E6" />
    <css:color name="olive"                 hex="#808000" />
    <css:color name="olivedrab"             hex="#6B8E23" />
    <css:color name="orange"                hex="#FFA500" />
    <css:color name="orangered"             hex="#FF4500" />
    <css:color name="orchid"                hex="#DA70D6" />
    <css:color name="palegoldenrod"         hex="#EEE8AA" />
    <css:color name="palegreen"             hex="#98FB98" />
    <css:color name="paleturquoise"         hex="#AFEEEE" />
    <css:color name="palevioletred"         hex="#DB7093" />
    <css:color name="papayawhip"            hex="#FFEFD5" />
    <css:color name="peachpuff"             hex="#FFDAB9" />
    <css:color name="peru"                  hex="#CD853F" />
    <css:color name="pink"                  hex="#FFC0CB" />
    <css:color name="plum"                  hex="#DDA0DD" />
    <css:color name="powderblue"            hex="#B0E0E6" />
    <css:color name="purple"                hex="#800080" />
    <css:color name="red"                   hex="#FF0000" />
    <css:color name="rosybrown"             hex="#BC8F8F" />
    <css:color name="royalblue"             hex="#4169E1" />
    <css:color name="saddlebrown"           hex="#8B4513" />
    <css:color name="salmon"                hex="#FA8072" />
    <css:color name="sandybrown"            hex="#F4A460" />
    <css:color name="seagreen"              hex="#2E8B57" />
    <css:color name="seashell"              hex="#FFF5EE" />
    <css:color name="sienna"                hex="#A0522D" />
    <css:color name="silver"                hex="#C0C0C0" />
    <css:color name="skyblue"               hex="#87CEEB" />
    <css:color name="slateblue"             hex="#6A5ACD" />
    <css:color name="slategray"             hex="#708090" />
    <css:color name="slategrey"             hex="#708090" />
    <css:color name="snow"                  hex="#FFFAFA" />
    <css:color name="springgreen"           hex="#00FF7F" />
    <css:color name="steelblue"             hex="#4682B4" />
    <css:color name="tan"                   hex="#D2B48C" />
    <css:color name="teal"                  hex="#008080" />
    <css:color name="thistle"               hex="#D8BFD8" />
    <css:color name="tomato"                hex="#FF6347" />
    <css:color name="turquoise"             hex="#40E0D0" />
    <css:color name="violet"                hex="#EE82EE" />
    <css:color name="wheat"                 hex="#F5DEB3" />
    <css:color name="white"                 hex="#FFFFFF" />
    <css:color name="whitesmoke"            hex="#F5F5F5" />
    <css:color name="yellow"                hex="#FFFF00" />
    <css:color name="yellowgreen"           hex="#9ACD32" />
  </css:colors>

</xsl:stylesheet>