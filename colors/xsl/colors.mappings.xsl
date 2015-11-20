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

  <xsl:function name="tr:pantone-c-to-rgb" as="xs:string?">
    <xsl:param name="pantone-name"  as="xs:string?"/>
    <xsl:sequence select="document('')
      //css:colors[@name eq 'pantone-c-rgb-map']
      /css:color[@name eq replace($pantone-name, '^PANTONE ', '')]
      /@rgb"/>
  </xsl:function>
  
<css:colors name="pantone-c-rgb-map">
    <css:color name="Yellow C" rgb="254 221 0"/>
    <css:color name="Yellow 012 C" rgb="255 215 0"/>
    <css:color name="Orange 021 C" rgb="254 80 0"/>
    <css:color name="Warm Red C" rgb="249 66 58"/>
    <css:color name="Red 032 C" rgb="239 51 64"/>
    <css:color name="Rubine Red C" rgb="206 0 88"/>
    <css:color name="Rhodamine Red C" rgb="225 0 152"/>
    <css:color name="Purple C" rgb="187 41 187"/>
    <css:color name="Violet C" rgb="68 0 153"/>
    <css:color name="Blue 072 C" rgb="16 6 159"/>
    <css:color name="Reflex Blue C" rgb="0 20 137"/>
    <css:color name="Process Blue C" rgb="0 133 202"/>
    <css:color name="Green C" rgb="0 171 132"/>
    <css:color name="Black C" rgb="45 41 38"/>
    <css:color name="Yellow 0131 C" rgb="242 240 161"/>
    <css:color name="Red 0331 C" rgb="252 174 187"/>
    <css:color name="Magenta 0521 C" rgb="241 178 220"/>
    <css:color name="Violet 0631 C" rgb="191 155 222"/>
    <css:color name="Blue 0821 C" rgb="116 209 234"/>
    <css:color name="Green 0921 C" rgb="157 231 215"/>
    <css:color name="Black 0961 C" rgb="158 151 142"/>
    <css:color name="801 C" rgb="0 154 206"/>
    <css:color name="802 C" rgb="68 214 44"/>
    <css:color name="803 C" rgb="255 233 0"/>
    <css:color name="804 C" rgb="255 170 77"/>
    <css:color name="805 C" rgb="255 114 118"/>
    <css:color name="806 C" rgb="255 62 181"/>
    <css:color name="807 C" rgb="234 39 194"/>
    <css:color name="871 C" rgb="132 117 78"/>
    <css:color name="872 C" rgb="133 113 77"/>
    <css:color name="873 C" rgb="134 109 75"/>
    <css:color name="874 C" rgb="139 111 78"/>
    <css:color name="875 C" rgb="135 103 79"/>
    <css:color name="876 C" rgb="139 99 75"/>
    <css:color name="877 C" rgb="138 141 143"/>
    <css:color name="Medium Yellow C" rgb="255 217 0"/>
    <css:color name="Bright Orange C" rgb="255 94 0"/>
    <css:color name="Bright Red C" rgb="249 56 34"/>
    <css:color name="Strong Red C" rgb="206 0 86"/>
    <css:color name="Pink C" rgb="214 37 152"/>
    <css:color name="Medium Purple C" rgb="78 0 142"/>
    <css:color name="Dark Blue C" rgb="0 35 156"/>
    <css:color name="Medium Blue C" rgb="0 132 202"/>
    <css:color name="Bright Green C" rgb="0 176 139"/>
    <css:color name="Neutral Black C" rgb="34 34 35"/>
    <css:color name="100 C" rgb="246 235 97"/>
    <css:color name="101 C" rgb="247 234 72"/>
    <css:color name="102 C" rgb="252 227 0"/>
    <css:color name="103 C" rgb="197 169 0"/>
    <css:color name="104 C" rgb="175 152 0"/>
    <css:color name="105 C" rgb="137 122 39"/>
    <css:color name="7401 C" rgb="245 225 164"/>
    <css:color name="7402 C" rgb="236 216 152"/>
    <css:color name="7403 C" rgb="238 212 132"/>
    <css:color name="7404 C" rgb="244 218 64"/>
    <css:color name="7405 C" rgb="242 205 0"/>
    <css:color name="7406 C" rgb="241 196 0"/>
    <css:color name="7407 C" rgb="203 160 82"/>
    <css:color name="106 C" rgb="249 229 71"/>
    <css:color name="107 C" rgb="251 225 34"/>
    <css:color name="108 C" rgb="254 219 0"/>
    <css:color name="109 C" rgb="255 209 0"/>
    <css:color name="110 C" rgb="218 170 0"/>
    <css:color name="111 C" rgb="170 138 0"/>
    <css:color name="112 C" rgb="156 132 18"/>
    <css:color name="113 C" rgb="250 224 83"/>
    <css:color name="114 C" rgb="251 221 64"/>
    <css:color name="115 C" rgb="253 218 36"/>
    <css:color name="116 C" rgb="255 205 0"/>
    <css:color name="117 C" rgb="201 151 0"/>
    <css:color name="118 C" rgb="172 132 0"/>
    <css:color name="119 C" rgb="137 115 34"/>
    <css:color name="127 C" rgb="243 221 109"/>
    <css:color name="128 C" rgb="243 213 78"/>
    <css:color name="129 C" rgb="243 208 62"/>
    <css:color name="130 C" rgb="242 169 0"/>
    <css:color name="131 C" rgb="204 138 0"/>
    <css:color name="132 C" rgb="160 116 0"/>
    <css:color name="133 C" rgb="108 87 27"/>
    <css:color name="1205 C" rgb="248 224 142"/>
    <css:color name="1215 C" rgb="251 216 114"/>
    <css:color name="1225 C" rgb="255 200 69"/>
    <css:color name="1235 C" rgb="255 184 28"/>
    <css:color name="1245 C" rgb="198 146 20"/>
    <css:color name="1255 C" rgb="173 132 31"/>
    <css:color name="1265 C" rgb="136 107 37"/>
    <css:color name="120 C" rgb="251 219 101"/>
    <css:color name="121 C" rgb="253 215 87"/>
    <css:color name="122 C" rgb="254 209 65"/>
    <css:color name="123 C" rgb="255 199 44"/>
    <css:color name="124 C" rgb="234 170 0"/>
    <css:color name="125 C" rgb="181 133 0"/>
    <css:color name="126 C" rgb="154 118 17"/>
    <css:color name="7548 C" rgb="255 198 0"/>
    <css:color name="7549 C" rgb="255 181 0"/>
    <css:color name="7550 C" rgb="209 144 0"/>
    <css:color name="7551 C" rgb="180 126 0"/>
    <css:color name="7552 C" rgb="115 83 29"/>
    <css:color name="7553 C" rgb="90 69 34"/>
    <css:color name="7554 C" rgb="75 61 42"/>
    <css:color name="7555 C" rgb="210 159 19"/>
    <css:color name="7556 C" rgb="183 139 32"/>
    <css:color name="7557 C" rgb="159 125 35"/>
    <css:color name="7558 C" rgb="150 113 38"/>
    <css:color name="7559 C" rgb="143 106 42"/>
    <css:color name="7560 C" rgb="125 98 46"/>
    <css:color name="7561 C" rgb="108 93 52"/>
    <css:color name="134 C" rgb="253 210 110"/>
    <css:color name="135 C" rgb="255 198 88"/>
    <css:color name="136 C" rgb="255 191 63"/>
    <css:color name="137 C" rgb="255 163 0"/>
    <css:color name="138 C" rgb="222 124 0"/>
    <css:color name="139 C" rgb="175 109 4"/>
    <css:color name="140 C" rgb="116 83 28"/>
    <css:color name="1345 C" rgb="253 208 134"/>
    <css:color name="1355 C" rgb="255 197 110"/>
    <css:color name="1365 C" rgb="255 181 73"/>
    <css:color name="1375 C" rgb="255 158 27"/>
    <css:color name="1385 C" rgb="213 120 0"/>
    <css:color name="1395 C" rgb="153 96 23"/>
    <css:color name="1405 C" rgb="110 76 30"/>
    <css:color name="141 C" rgb="242 199 92"/>
    <css:color name="142 C" rgb="241 190 72"/>
    <css:color name="143 C" rgb="241 180 52"/>
    <css:color name="144 C" rgb="237 139 0"/>
    <css:color name="145 C" rgb="207 127 0"/>
    <css:color name="146 C" rgb="167 109 17"/>
    <css:color name="147 C" rgb="113 92 42"/>
    <css:color name="7408 C" rgb="246 190 0"/>
    <css:color name="7409 C" rgb="240 179 35"/>
    <css:color name="7410 C" rgb="254 173 119"/>
    <css:color name="7411 C" rgb="230 166 93"/>
    <css:color name="7412 C" rgb="211 130 53"/>
    <css:color name="7413 C" rgb="220 134 51"/>
    <css:color name="7414 C" rgb="193 108 24"/>
    <css:color name="7562 C" rgb="189 155 96"/>
    <css:color name="7563 C" rgb="214 154 45"/>
    <css:color name="7564 C" rgb="219 138 6"/>
    <css:color name="7565 C" rgb="205 121 37"/>
    <css:color name="7566 C" rgb="173 100 51"/>
    <css:color name="7567 C" rgb="137 83 47"/>
    <css:color name="7568 C" rgb="119 81 53"/>
    <css:color name="7569 C" rgb="215 136 37"/>
    <css:color name="7570 C" rgb="211 131 43"/>
    <css:color name="7571 C" rgb="198 125 48"/>
    <css:color name="7572 C" rgb="182 114 51"/>
    <css:color name="7573 C" rgb="167 102 43"/>
    <css:color name="7574 C" rgb="158 106 56"/>
    <css:color name="7575 C" rgb="131 93 50"/>
    <css:color name="712 C" rgb="252 200 155"/>
    <css:color name="713 C" rgb="253 190 135"/>
    <css:color name="714 C" rgb="253 170 99"/>
    <css:color name="715 C" rgb="246 141 46"/>
    <css:color name="716 C" rgb="234 118 0"/>
    <css:color name="717 C" rgb="212 93 0"/>
    <css:color name="718 C" rgb="190 77 0"/>
    <css:color name="148 C" rgb="254 203 139"/>
    <css:color name="149 C" rgb="255 194 123"/>
    <css:color name="150 C" rgb="255 178 91"/>
    <css:color name="151 C" rgb="255 130 0"/>
    <css:color name="152 C" rgb="229 114 0"/>
    <css:color name="153 C" rgb="190 106 20"/>
    <css:color name="154 C" rgb="155 90 26"/>
    <css:color name="155 C" rgb="239 209 159"/>
    <css:color name="156 C" rgb="239 190 125"/>
    <css:color name="157 C" rgb="236 161 84"/>
    <css:color name="158 C" rgb="232 119 34"/>
    <css:color name="159 C" rgb="203 96 21"/>
    <css:color name="160 C" rgb="161 86 28"/>
    <css:color name="161 C" rgb="96 61 32"/>
    <css:color name="1485 C" rgb="255 174 98"/>
    <css:color name="1495 C" rgb="255 143 28"/>
    <css:color name="1505 C" rgb="255 105 0"/>
    <css:color name="1525 C" rgb="185 71 0"/>
    <css:color name="1535 C" rgb="148 69 11"/>
    <css:color name="1545 C" rgb="101 56 25"/>
    <css:color name="1555 C" rgb="255 185 144"/>
    <css:color name="1565 C" rgb="255 160 106"/>
    <css:color name="1575 C" rgb="255 127 50"/>
    <css:color name="1585 C" rgb="255 106 19"/>
    <css:color name="1595 C" rgb="216 96 24"/>
    <css:color name="1605 C" rgb="166 85 35"/>
    <css:color name="1615 C" rgb="139 71 32"/>
    <css:color name="162 C" rgb="255 190 159"/>
    <css:color name="163 C" rgb="255 157 110"/>
    <css:color name="164 C" rgb="255 127 65"/>
    <css:color name="165 C" rgb="255 103 31"/>
    <css:color name="166 C" rgb="227 82 5"/>
    <css:color name="167 C" rgb="190 83 28"/>
    <css:color name="168 C" rgb="115 56 29"/>
    <css:color name="7576 C" rgb="219 134 78"/>
    <css:color name="7577 C" rgb="224 126 60"/>
    <css:color name="7578 C" rgb="220 107 47"/>
    <css:color name="7579 C" rgb="220 88 42"/>
    <css:color name="7580 C" rgb="192 81 49"/>
    <css:color name="7581 C" rgb="134 74 51"/>
    <css:color name="7582 C" rgb="103 71 54"/>
    <css:color name="1625 C" rgb="255 163 139"/>
    <css:color name="1635 C" rgb="255 141 109"/>
    <css:color name="1645 C" rgb="255 106 57"/>
    <css:color name="1655 C" rgb="252 76 2"/>
    <css:color name="1665 C" rgb="220 68 5"/>
    <css:color name="1675 C" rgb="169 67 30"/>
    <css:color name="1685 C" rgb="131 57 33"/>
    <css:color name="169 C" rgb="255 179 171"/>
    <css:color name="170 C" rgb="255 134 116"/>
    <css:color name="171 C" rgb="255 92 57"/>
    <css:color name="172 C" rgb="250 70 22"/>
    <css:color name="173 C" rgb="207 69 32"/>
    <css:color name="174 C" rgb="150 56 33"/>
    <css:color name="175 C" rgb="107 53 41"/>
    <css:color name="7583 C" rgb="196 98 45"/>
    <css:color name="7584 C" rgb="186 88 38"/>
    <css:color name="7585 C" rgb="175 92 55"/>
    <css:color name="7586 C" rgb="158 83 48"/>
    <css:color name="7587 C" rgb="146 76 46"/>
    <css:color name="7588 C" rgb="123 77 53"/>
    <css:color name="7589 C" rgb="92 71 56"/>
    <css:color name="7590 C" rgb="212 181 158"/>
    <css:color name="7591 C" rgb="192 125 89"/>
    <css:color name="7592 C" rgb="177 85 51"/>
    <css:color name="7593 C" rgb="157 67 44"/>
    <css:color name="7594 C" rgb="124 58 45"/>
    <css:color name="7595 C" rgb="107 61 46"/>
    <css:color name="7596 C" rgb="92 61 49"/>
    <css:color name="7597 C" rgb="209 65 36"/>
    <css:color name="7598 C" rgb="189 71 42"/>
    <css:color name="7599 C" rgb="179 61 38"/>
    <css:color name="7600 C" rgb="141 63 43"/>
    <css:color name="7601 C" rgb="131 65 44"/>
    <css:color name="7602 C" rgb="123 73 49"/>
    <css:color name="7603 C" rgb="103 66 48"/>
    <css:color name="7604 C" rgb="228 213 211"/>
    <css:color name="7605 C" rgb="225 187 180"/>
    <css:color name="7606 C" rgb="214 147 138"/>
    <css:color name="7607 C" rgb="194 110 96"/>
    <css:color name="7608 C" rgb="164 73 61"/>
    <css:color name="7609 C" rgb="130 59 52"/>
    <css:color name="7610 C" rgb="104 52 49"/>
    <css:color name="7611 C" rgb="221 188 176"/>
    <css:color name="7612 C" rgb="202 154 142"/>
    <css:color name="7613 C" rgb="188 138 126"/>
    <css:color name="7614 C" rgb="163 127 116"/>
    <css:color name="7615 C" rgb="134 103 97"/>
    <css:color name="7616 C" rgb="107 76 76"/>
    <css:color name="7617 C" rgb="88 61 62"/>
    <css:color name="7520 C" rgb="234 190 176"/>
    <css:color name="7521 C" rgb="192 156 131"/>
    <css:color name="7522 C" rgb="180 106 85"/>
    <css:color name="7523 C" rgb="171 92 87"/>
    <css:color name="7524 C" rgb="164 82 72"/>
    <css:color name="7525 C" rgb="154 106 79"/>
    <css:color name="7526 C" rgb="138 57 27"/>
    <css:color name="489 C" rgb="236 195 178"/>
    <css:color name="488 C" rgb="236 186 168"/>
    <css:color name="487 C" rgb="234 167 148"/>
    <css:color name="486 C" rgb="232 146 124"/>
    <css:color name="485 C" rgb="218 41 28"/>
    <css:color name="484 C" rgb="154 51 36"/>
    <css:color name="483 C" rgb="101 48 36"/>
    <css:color name="176 C" rgb="255 177 187"/>
    <css:color name="177 C" rgb="255 128 139"/>
    <css:color name="178 C" rgb="255 88 93"/>
    <css:color name="179 C" rgb="224 60 49"/>
    <css:color name="180 C" rgb="190 58 52"/>
    <css:color name="181 C" rgb="129 49 47"/>
    <css:color name="1765 C" rgb="255 163 181"/>
    <css:color name="1775 C" rgb="255 141 161"/>
    <css:color name="1785 C" rgb="248 72 94"/>
    <css:color name="1788 C" rgb="238 39 55"/>
    <css:color name="1795 C" rgb="210 38 48"/>
    <css:color name="1805 C" rgb="175 39 47"/>
    <css:color name="1815 C" rgb="124 37 41"/>
    <css:color name="1767 C" rgb="252 175 192"/>
    <css:color name="1777 C" rgb="251 99 126"/>
    <css:color name="1787 C" rgb="244 54 76"/>
    <css:color name="1797 C" rgb="203 51 59"/>
    <css:color name="1807 C" rgb="164 52 58"/>
    <css:color name="1817 C" rgb="100 51 53"/>
    <css:color name="7618 C" rgb="198 110 78"/>
    <css:color name="7619 C" rgb="192 76 54"/>
    <css:color name="7620 C" rgb="183 49 44"/>
    <css:color name="7621 C" rgb="171 35 40"/>
    <css:color name="7622 C" rgb="147 39 44"/>
    <css:color name="7623 C" rgb="138 42 43"/>
    <css:color name="7624 C" rgb="128 47 45"/>
    <css:color name="7625 C" rgb="225 82 61"/>
    <css:color name="7626 C" rgb="198 53 39"/>
    <css:color name="7627 C" rgb="167 43 42"/>
    <css:color name="7628 C" rgb="158 42 43"/>
    <css:color name="7629 C" rgb="109 51 50"/>
    <css:color name="7630 C" rgb="99 50 49"/>
    <css:color name="7631 C" rgb="87 45 45"/>
    <css:color name="7415 C" rgb="230 186 168"/>
    <css:color name="7416 C" rgb="229 106 84"/>
    <css:color name="7417 C" rgb="224 78 57"/>
    <css:color name="7418 C" rgb="205 84 91"/>
    <css:color name="7419 C" rgb="176 74 90"/>
    <css:color name="7420 C" rgb="155 34 66"/>
    <css:color name="7421 C" rgb="101 29 50"/>
    <css:color name="182 C" rgb="250 187 203"/>
    <css:color name="183 C" rgb="252 155 179"/>
    <css:color name="184 C" rgb="246 82 117"/>
    <css:color name="185 C" rgb="228 0 43"/>
    <css:color name="186 C" rgb="200 16 46"/>
    <css:color name="187 C" rgb="166 25 46"/>
    <css:color name="188 C" rgb="118 35 47"/>
    <css:color name="196 C" rgb="236 199 205"/>
    <css:color name="197 C" rgb="232 156 174"/>
    <css:color name="198 C" rgb="223 70 97"/>
    <css:color name="199 C" rgb="213 0 50"/>
    <css:color name="200 C" rgb="186 12 47"/>
    <css:color name="201 C" rgb="157 34 53"/>
    <css:color name="202 C" rgb="134 38 51"/>
    <css:color name="189 C" rgb="248 163 188"/>
    <css:color name="190 C" rgb="246 117 153"/>
    <css:color name="191 C" rgb="239 66 111"/>
    <css:color name="192 C" rgb="228 0 70"/>
    <css:color name="193 C" rgb="191 13 62"/>
    <css:color name="194 C" rgb="155 39 67"/>
    <css:color name="195 C" rgb="120 47 64"/>
    <css:color name="1895 C" rgb="245 182 205"/>
    <css:color name="1905 C" rgb="245 155 187"/>
    <css:color name="1915 C" rgb="239 74 129"/>
    <css:color name="1925 C" rgb="224 0 77"/>
    <css:color name="1935 C" rgb="197 0 62"/>
    <css:color name="1945 C" rgb="166 9 61"/>
    <css:color name="1955 C" rgb="138 21 56"/>
    <css:color name="705 C" rgb="245 218 223"/>
    <css:color name="706 C" rgb="247 206 215"/>
    <css:color name="707 C" rgb="249 181 196"/>
    <css:color name="708 C" rgb="248 144 165"/>
    <css:color name="709 C" rgb="239 96 121"/>
    <css:color name="710 C" rgb="224 62 82"/>
    <css:color name="711 C" rgb="203 44 48"/>
    <css:color name="698 C" rgb="242 212 215"/>
    <css:color name="699 C" rgb="244 195 204"/>
    <css:color name="700 C" rgb="242 172 185"/>
    <css:color name="701 C" rgb="230 134 153"/>
    <css:color name="702 C" rgb="210 91 115"/>
    <css:color name="703 C" rgb="184 58 75"/>
    <css:color name="704 C" rgb="158 42 47"/>
    <css:color name="203 C" rgb="236 179 203"/>
    <css:color name="204 C" rgb="231 130 169"/>
    <css:color name="205 C" rgb="224 69 123"/>
    <css:color name="206 C" rgb="206 0 55"/>
    <css:color name="207 C" rgb="165 0 52"/>
    <css:color name="208 C" rgb="134 31 65"/>
    <css:color name="209 C" rgb="111 38 61"/>
    <css:color name="210 C" rgb="249 159 201"/>
    <css:color name="211 C" rgb="245 126 182"/>
    <css:color name="212 C" rgb="240 78 152"/>
    <css:color name="213 C" rgb="227 28 121"/>
    <css:color name="214 C" rgb="206 15 105"/>
    <css:color name="215 C" rgb="172 20 90"/>
    <css:color name="216 C" rgb="125 34 72"/>
    <css:color name="7422 C" rgb="244 205 212"/>
    <css:color name="7423 C" rgb="224 98 135"/>
    <css:color name="7424 C" rgb="226 69 133"/>
    <css:color name="7425 C" rgb="181 37 85"/>
    <css:color name="7426 C" rgb="164 18 63"/>
    <css:color name="7427 C" rgb="151 27 47"/>
    <css:color name="7428 C" rgb="106 44 62"/>
    <css:color name="7632 C" rgb="214 201 202"/>
    <css:color name="7633 C" rgb="196 164 167"/>
    <css:color name="7634 C" rgb="193 103 132"/>
    <css:color name="7635 C" rgb="198 54 99"/>
    <css:color name="7636 C" rgb="188 32 75"/>
    <css:color name="7637 C" rgb="145 47 70"/>
    <css:color name="7638 C" rgb="126 45 64"/>
    <css:color name="217 C" rgb="234 190 219"/>
    <css:color name="218 C" rgb="229 109 177"/>
    <css:color name="219 C" rgb="218 24 132"/>
    <css:color name="220 C" rgb="165 0 80"/>
    <css:color name="221 C" rgb="145 0 72"/>
    <css:color name="222 C" rgb="108 29 69"/>
    <css:color name="7639 C" rgb="147 109 115"/>
    <css:color name="7640 C" rgb="147 64 84"/>
    <css:color name="7641 C" rgb="142 44 72"/>
    <css:color name="7642 C" rgb="115 46 74"/>
    <css:color name="7643 C" rgb="103 46 69"/>
    <css:color name="7644 C" rgb="88 45 64"/>
    <css:color name="7645 C" rgb="80 43 58"/>
    <css:color name="223 C" rgb="239 149 207"/>
    <css:color name="224 C" rgb="235 111 189"/>
    <css:color name="225 C" rgb="223 25 149"/>
    <css:color name="226 C" rgb="208 0 111"/>
    <css:color name="227 C" rgb="170 0 97"/>
    <css:color name="228 C" rgb="137 12 88"/>
    <css:color name="229 C" rgb="103 33 70"/>
    <css:color name="230 C" rgb="244 166 215"/>
    <css:color name="231 C" rgb="242 119 198"/>
    <css:color name="232 C" rgb="233 60 172"/>
    <css:color name="233 C" rgb="198 0 126"/>
    <css:color name="234 C" rgb="162 0 103"/>
    <css:color name="235 C" rgb="132 11 85"/>
    <css:color name="670 C" rgb="234 211 226"/>
    <css:color name="671 C" rgb="230 188 216"/>
    <css:color name="672 C" rgb="223 160 201"/>
    <css:color name="673 C" rgb="217 134 186"/>
    <css:color name="674 C" rgb="198 87 154"/>
    <css:color name="675 C" rgb="174 37 115"/>
    <css:color name="676 C" rgb="150 0 81"/>
    <css:color name="677 C" rgb="229 206 219"/>
    <css:color name="678 C" rgb="227 200 216"/>
    <css:color name="679 C" rgb="222 190 210"/>
    <css:color name="680 C" rgb="201 150 182"/>
    <css:color name="681 C" rgb="176 108 150"/>
    <css:color name="682 C" rgb="153 72 120"/>
    <css:color name="683 C" rgb="124 40 85"/>
    <css:color name="684 C" rgb="228 198 212"/>
    <css:color name="685 C" rgb="220 182 201"/>
    <css:color name="686 C" rgb="208 161 186"/>
    <css:color name="687 C" rgb="190 132 163"/>
    <css:color name="688 C" rgb="167 99 137"/>
    <css:color name="689 C" rgb="137 59 103"/>
    <css:color name="690 C" rgb="97 33 65"/>
    <css:color name="510 C" rgb="235 190 203"/>
    <css:color name="509 C" rgb="232 179 195"/>
    <css:color name="508 C" rgb="228 169 187"/>
    <css:color name="507 C" rgb="213 146 170"/>
    <css:color name="506 C" rgb="132 52 78"/>
    <css:color name="505 C" rgb="111 44 63"/>
    <css:color name="504 C" rgb="87 41 50"/>
    <css:color name="7429 C" rgb="226 188 203"/>
    <css:color name="7430 C" rgb="220 169 191"/>
    <css:color name="7431 C" rgb="201 128 158"/>
    <css:color name="7432 C" rgb="181 92 128"/>
    <css:color name="7433 C" rgb="167 58 100"/>
    <css:color name="7434 C" rgb="155 50 89"/>
    <css:color name="7435 C" rgb="135 38 81"/>
    <css:color name="691 C" rgb="233 205 208"/>
    <css:color name="692 C" rgb="228 190 195"/>
    <css:color name="693 C" rgb="215 163 171"/>
    <css:color name="694 C" rgb="196 132 144"/>
    <css:color name="695 C" rgb="180 107 122"/>
    <css:color name="696 C" rgb="152 72 86"/>
    <css:color name="697 C" rgb="137 60 71"/>
    <css:color name="496 C" rgb="242 198 207"/>
    <css:color name="495 C" rgb="241 189 200"/>
    <css:color name="494 C" rgb="233 162 178"/>
    <css:color name="493 C" rgb="220 134 153"/>
    <css:color name="492 C" rgb="143 50 55"/>
    <css:color name="491 C" rgb="127 48 53"/>
    <css:color name="490 C" rgb="93 42 44"/>
    <css:color name="503 C" rgb="233 196 199"/>
    <css:color name="502 C" rgb="229 186 193"/>
    <css:color name="501 C" rgb="218 165 173"/>
    <css:color name="500 C" rgb="198 133 143"/>
    <css:color name="499 C" rgb="122 62 58"/>
    <css:color name="498 C" rgb="106 55 53"/>
    <css:color name="497 C" rgb="81 47 46"/>
    <css:color name="5035 C" rgb="223 194 195"/>
    <css:color name="5025 C" rgb="219 183 187"/>
    <css:color name="5015 C" rgb="204 161 166"/>
    <css:color name="5005 C" rgb="176 124 131"/>
    <css:color name="4995 C" rgb="156 97 105"/>
    <css:color name="4985 C" rgb="135 75 82"/>
    <css:color name="4975 C" rgb="63 32 33"/>
    <css:color name="236 C" rgb="241 167 220"/>
    <css:color name="237 C" rgb="236 134 208"/>
    <css:color name="238 C" rgb="228 93 191"/>
    <css:color name="239 C" rgb="219 62 177"/>
    <css:color name="240 C" rgb="197 41 155"/>
    <css:color name="241 C" rgb="175 22 133"/>
    <css:color name="242 C" rgb="128 34 95"/>
    <css:color name="2365 C" rgb="239 186 225"/>
    <css:color name="2375 C" rgb="226 119 205"/>
    <css:color name="2385 C" rgb="213 57 181"/>
    <css:color name="2395 C" rgb="200 0 161"/>
    <css:color name="2405 C" rgb="176 0 142"/>
    <css:color name="2415 C" rgb="158 0 126"/>
    <css:color name="2425 C" rgb="131 0 101"/>
    <css:color name="243 C" rgb="234 184 228"/>
    <css:color name="244 C" rgb="229 155 220"/>
    <css:color name="245 C" rgb="221 127 211"/>
    <css:color name="246 C" rgb="199 36 177"/>
    <css:color name="247 C" rgb="187 22 163"/>
    <css:color name="248 C" rgb="165 24 144"/>
    <css:color name="249 C" rgb="128 39 108"/>
    <css:color name="7646 C" rgb="165 110 135"/>
    <css:color name="7647 C" rgb="168 61 114"/>
    <css:color name="7648 C" rgb="153 30 102"/>
    <css:color name="7649 C" rgb="138 27 97"/>
    <css:color name="7650 C" rgb="114 34 87"/>
    <css:color name="7651 C" rgb="106 42 91"/>
    <css:color name="7652 C" rgb="94 39 81"/>
    <css:color name="250 C" rgb="231 186 228"/>
    <css:color name="251 C" rgb="221 156 223"/>
    <css:color name="252 C" rgb="201 100 207"/>
    <css:color name="253 C" rgb="173 26 172"/>
    <css:color name="254 C" rgb="152 29 151"/>
    <css:color name="255 C" rgb="114 36 108"/>
    <css:color name="517 C" rgb="235 198 223"/>
    <css:color name="516 C" rgb="230 190 221"/>
    <css:color name="515 C" rgb="226 172 215"/>
    <css:color name="514 C" rgb="212 139 200"/>
    <css:color name="513 C" rgb="147 50 142"/>
    <css:color name="512 C" rgb="131 49 119"/>
    <css:color name="511 C" rgb="97 44 81"/>
    <css:color name="7436 C" rgb="238 218 234"/>
    <css:color name="7437 C" rgb="204 174 208"/>
    <css:color name="7438 C" rgb="213 158 215"/>
    <css:color name="7439 C" rgb="178 136 185"/>
    <css:color name="7440 C" rgb="162 119 166"/>
    <css:color name="7441 C" rgb="159 92 192"/>
    <css:color name="7442 C" rgb="150 60 189"/>
    <css:color name="2562 C" rgb="215 169 227"/>
    <css:color name="2572 C" rgb="201 139 219"/>
    <css:color name="2582 C" rgb="172 79 198"/>
    <css:color name="2592 C" rgb="155 38 182"/>
    <css:color name="2602 C" rgb="135 24 157"/>
    <css:color name="2612 C" rgb="119 37 131"/>
    <css:color name="2622 C" rgb="101 49 101"/>
    <css:color name="7653 C" rgb="148 135 148"/>
    <css:color name="7654 C" rgb="162 120 156"/>
    <css:color name="7655 C" rgb="161 90 149"/>
    <css:color name="7656 C" rgb="142 58 128"/>
    <css:color name="7657 C" rgb="110 43 98"/>
    <css:color name="7658 C" rgb="106 52 96"/>
    <css:color name="7659 C" rgb="93 55 84"/>
    <css:color name="524 C" rgb="213 194 216"/>
    <css:color name="523 C" rgb="201 177 208"/>
    <css:color name="522 C" rgb="186 156 197"/>
    <css:color name="521 C" rgb="165 127 178"/>
    <css:color name="520 C" rgb="100 47 108"/>
    <css:color name="519 C" rgb="89 49 95"/>
    <css:color name="518 C" rgb="75 48 72"/>
    <css:color name="5245 C" rgb="219 205 211"/>
    <css:color name="5235 C" rgb="208 190 199"/>
    <css:color name="5225 C" rgb="198 176 188"/>
    <css:color name="5215 C" rgb="175 149 166"/>
    <css:color name="5205 C" rgb="134 100 122"/>
    <css:color name="5195 C" rgb="102 67 90"/>
    <css:color name="5185 C" rgb="74 48 65"/>
    <css:color name="5175 C" rgb="216 200 209"/>
    <css:color name="5165 C" rgb="211 192 205"/>
    <css:color name="5155 C" rgb="191 165 184"/>
    <css:color name="5145 C" rgb="155 119 147"/>
    <css:color name="5135 C" rgb="126 84 117"/>
    <css:color name="5125 C" rgb="105 60 94"/>
    <css:color name="5115 C" rgb="81 42 68"/>
    <css:color name="531 C" rgb="223 200 231"/>
    <css:color name="530 C" rgb="215 185 228"/>
    <css:color name="529 C" rgb="202 162 221"/>
    <css:color name="528 C" rgb="181 128 209"/>
    <css:color name="527 C" rgb="128 49 167"/>
    <css:color name="526 C" rgb="112 47 138"/>
    <css:color name="525 C" rgb="87 44 95"/>
    <css:color name="256 C" rgb="214 191 221"/>
    <css:color name="257 C" rgb="198 161 207"/>
    <css:color name="258 C" rgb="140 71 153"/>
    <css:color name="259 C" rgb="109 32 119"/>
    <css:color name="260 C" rgb="100 38 103"/>
    <css:color name="261 C" rgb="93 40 95"/>
    <css:color name="262 C" rgb="81 40 79"/>
    <css:color name="2563 C" rgb="203 163 216"/>
    <css:color name="2573 C" rgb="184 132 203"/>
    <css:color name="2583 C" rgb="160 94 181"/>
    <css:color name="2593 C" rgb="132 50 155"/>
    <css:color name="2603 C" rgb="112 32 130"/>
    <css:color name="2613 C" rgb="103 30 117"/>
    <css:color name="2623 C" rgb="95 33 103"/>
    <css:color name="7660 C" rgb="153 145 164"/>
    <css:color name="7661 C" rgb="141 110 151"/>
    <css:color name="7662 C" rgb="122 65 131"/>
    <css:color name="7663 C" rgb="107 48 119"/>
    <css:color name="7664 C" rgb="101 50 121"/>
    <css:color name="7665 C" rgb="94 54 110"/>
    <css:color name="7666 C" rgb="92 78 99"/>
    <css:color name="2567 C" rgb="193 160 218"/>
    <css:color name="2577 C" rgb="167 123 202"/>
    <css:color name="2587 C" rgb="130 70 175"/>
    <css:color name="2597 C" rgb="92 6 140"/>
    <css:color name="2607 C" rgb="80 7 120"/>
    <css:color name="2617 C" rgb="71 10 104"/>
    <css:color name="2627 C" rgb="60 16 83"/>
    <css:color name="263 C" rgb="215 198 230"/>
    <css:color name="264 C" rgb="193 167 226"/>
    <css:color name="265 C" rgb="144 99 205"/>
    <css:color name="266 C" rgb="117 59 189"/>
    <css:color name="267 C" rgb="95 37 159"/>
    <css:color name="268 C" rgb="88 44 131"/>
    <css:color name="269 C" rgb="81 45 109"/>
    <css:color name="2635 C" rgb="197 180 227"/>
    <css:color name="2645 C" rgb="173 150 220"/>
    <css:color name="2655 C" rgb="150 120 211"/>
    <css:color name="2665 C" rgb="125 85 199"/>
    <css:color name="2685 C" rgb="51 0 114"/>
    <css:color name="2695 C" rgb="46 26 71"/>
    <css:color name="270 C" rgb="180 181 223"/>
    <css:color name="271 C" rgb="149 149 210"/>
    <css:color name="272 C" rgb="116 116 193"/>
    <css:color name="273 C" rgb="36 19 95"/>
    <css:color name="274 C" rgb="33 21 81"/>
    <css:color name="275 C" rgb="32 23 71"/>
    <css:color name="276 C" rgb="34 28 53"/>
    <css:color name="2705 C" rgb="167 164 224"/>
    <css:color name="2715 C" rgb="139 132 215"/>
    <css:color name="2725 C" rgb="104 91 199"/>
    <css:color name="2735 C" rgb="46 0 139"/>
    <css:color name="2745 C" rgb="40 0 113"/>
    <css:color name="2755 C" rgb="37 14 98"/>
    <css:color name="2765 C" rgb="32 21 71"/>
    <css:color name="7667 C" rgb="110 124 160"/>
    <css:color name="7668 C" rgb="104 110 159"/>
    <css:color name="7669 C" rgb="97 94 155"/>
    <css:color name="7670 C" rgb="86 82 148"/>
    <css:color name="7671 C" rgb="81 70 137"/>
    <css:color name="7672 C" rgb="76 65 132"/>
    <css:color name="7673 C" rgb="83 84 134"/>
    <css:color name="7443 C" rgb="221 218 232"/>
    <css:color name="7444 C" rgb="182 184 220"/>
    <css:color name="7445 C" rgb="167 162 195"/>
    <css:color name="7446 C" rgb="137 134 202"/>
    <css:color name="7447 C" rgb="93 71 119"/>
    <css:color name="7448 C" rgb="75 56 76"/>
    <css:color name="7449 C" rgb="65 39 59"/>
    <css:color name="7674 C" rgb="135 140 180"/>
    <css:color name="7675 C" rgb="124 127 171"/>
    <css:color name="7676 C" rgb="117 102 160"/>
    <css:color name="7677 C" rgb="111 80 145"/>
    <css:color name="7678 C" rgb="104 71 141"/>
    <css:color name="7679 C" rgb="86 61 130"/>
    <css:color name="7680 C" rgb="82 49 120"/>
    <css:color name="663 C" rgb="229 225 230"/>
    <css:color name="664 C" rgb="224 219 227"/>
    <css:color name="665 C" rgb="198 188 208"/>
    <css:color name="666 C" rgb="161 146 178"/>
    <css:color name="667 C" rgb="124 105 146"/>
    <css:color name="668 C" rgb="97 75 121"/>
    <css:color name="669 C" rgb="63 42 86"/>
    <css:color name="5315 C" rgb="216 215 223"/>
    <css:color name="5305 C" rgb="198 196 210"/>
    <css:color name="5295 C" rgb="179 176 196"/>
    <css:color name="5285 C" rgb="141 137 165"/>
    <css:color name="5275 C" rgb="89 84 120"/>
    <css:color name="5265 C" rgb="64 58 96"/>
    <css:color name="5255 C" rgb="30 26 52"/>
    <css:color name="538 C" rgb="197 207 218"/>
    <css:color name="537 C" rgb="187 199 214"/>
    <css:color name="536 C" rgb="162 178 200"/>
    <css:color name="535 C" rgb="142 159 188"/>
    <css:color name="534 C" rgb="27 54 93"/>
    <css:color name="533 C" rgb="31 42 68"/>
    <css:color name="532 C" rgb="28 31 42"/>
    <css:color name="7541 C" rgb="217 225 226"/>
    <css:color name="7542 C" rgb="164 188 194"/>
    <css:color name="7543 C" rgb="152 164 174"/>
    <css:color name="7544 C" rgb="118 134 146"/>
    <css:color name="7545 C" rgb="66 85 99"/>
    <css:color name="7546 C" rgb="37 55 70"/>
    <css:color name="7547 C" rgb="19 30 41"/>
    <css:color name="552 C" rgb="185 211 220"/>
    <css:color name="551 C" rgb="163 199 210"/>
    <css:color name="550 C" rgb="141 185 202"/>
    <css:color name="549 C" rgb="107 164 184"/>
    <css:color name="548 C" rgb="0 61 76"/>
    <css:color name="547 C" rgb="0 49 60"/>
    <css:color name="546 C" rgb="7 43 49"/>
    <css:color name="5455 C" rgb="191 206 214"/>
    <css:color name="5445 C" rgb="183 201 211"/>
    <css:color name="5435 C" rgb="166 187 200"/>
    <css:color name="5425 C" rgb="122 153 172"/>
    <css:color name="5415 C" rgb="91 127 149"/>
    <css:color name="5405 C" rgb="79 117 139"/>
    <css:color name="5395 C" rgb="8 31 44"/>
    <css:color name="642 C" rgb="209 221 230"/>
    <css:color name="643 C" rgb="198 214 227"/>
    <css:color name="644 C" rgb="155 184 211"/>
    <css:color name="645 C" rgb="125 161 196"/>
    <css:color name="646 C" rgb="94 138 180"/>
    <css:color name="647 C" rgb="35 97 146"/>
    <css:color name="648 C" rgb="0 46 93"/>
    <css:color name="649 C" rgb="219 226 233"/>
    <css:color name="650 C" rgb="206 217 229"/>
    <css:color name="651 C" rgb="167 188 214"/>
    <css:color name="652 C" rgb="125 155 193"/>
    <css:color name="653 C" rgb="50 98 149"/>
    <css:color name="654 C" rgb="0 58 112"/>
    <css:color name="655 C" rgb="0 37 84"/>
    <css:color name="656 C" rgb="221 229 237"/>
    <css:color name="657 C" rgb="200 216 235"/>
    <css:color name="658 C" rgb="177 201 232"/>
    <css:color name="659 C" rgb="123 164 219"/>
    <css:color name="660 C" rgb="64 126 201"/>
    <css:color name="661 C" rgb="0 53 148"/>
    <css:color name="662 C" rgb="0 26 112"/>
    <css:color name="7450 C" rgb="189 197 219"/>
    <css:color name="7451 C" rgb="137 171 227"/>
    <css:color name="7452 C" rgb="128 148 221"/>
    <css:color name="7453 C" rgb="123 166 222"/>
    <css:color name="7454 C" rgb="95 143 180"/>
    <css:color name="7455 C" rgb="58 93 174"/>
    <css:color name="7456 C" rgb="96 110 178"/>
    <css:color name="2706 C" rgb="203 211 235"/>
    <css:color name="2716 C" rgb="159 174 229"/>
    <css:color name="2726 C" rgb="72 92 199"/>
    <css:color name="2736 C" rgb="30 34 170"/>
    <css:color name="2746 C" rgb="23 28 143"/>
    <css:color name="2756 C" rgb="21 31 109"/>
    <css:color name="2766 C" rgb="20 27 77"/>
    <css:color name="2708 C" rgb="184 204 234"/>
    <css:color name="2718 C" rgb="92 136 218"/>
    <css:color name="2728 C" rgb="0 71 187"/>
    <css:color name="2738 C" rgb="6 3 141"/>
    <css:color name="2748 C" rgb="0 24 113"/>
    <css:color name="2758 C" rgb="0 30 98"/>
    <css:color name="2768 C" rgb="7 29 73"/>
    <css:color name="2707 C" rgb="195 215 238"/>
    <css:color name="2717 C" rgb="167 198 237"/>
    <css:color name="2727 C" rgb="48 127 226"/>
    <css:color name="2747 C" rgb="0 26 114"/>
    <css:color name="2757 C" rgb="0 30 96"/>
    <css:color name="2767 C" rgb="19 41 75"/>
    <css:color name="277 C" rgb="171 202 233"/>
    <css:color name="278 C" rgb="139 184 232"/>
    <css:color name="279 C" rgb="65 143 222"/>
    <css:color name="280 C" rgb="1 33 105"/>
    <css:color name="281 C" rgb="0 32 91"/>
    <css:color name="282 C" rgb="4 30 66"/>
    <css:color name="283 C" rgb="146 193 233"/>
    <css:color name="284 C" rgb="108 172 228"/>
    <css:color name="285 C" rgb="0 114 206"/>
    <css:color name="286 C" rgb="0 51 160"/>
    <css:color name="287 C" rgb="0 48 135"/>
    <css:color name="288 C" rgb="0 45 114"/>
    <css:color name="289 C" rgb="12 35 64"/>
    <css:color name="7681 C" rgb="148 169 203"/>
    <css:color name="7682 C" rgb="103 135 183"/>
    <css:color name="7683 C" rgb="66 109 169"/>
    <css:color name="7684 C" rgb="56 94 157"/>
    <css:color name="7685 C" rgb="44 86 151"/>
    <css:color name="7686 C" rgb="29 79 145"/>
    <css:color name="7687 C" rgb="29 66 138"/>
    <css:color name="545 C" rgb="198 218 231"/>
    <css:color name="544 C" rgb="189 214 230"/>
    <css:color name="543 C" rgb="164 200 225"/>
    <css:color name="542 C" rgb="123 175 212"/>
    <css:color name="541 C" rgb="0 60 113"/>
    <css:color name="540 C" rgb="0 48 87"/>
    <css:color name="539 C" rgb="0 38 58"/>
    <css:color name="290 C" rgb="185 217 235"/>
    <css:color name="291 C" rgb="155 203 235"/>
    <css:color name="292 C" rgb="105 179 231"/>
    <css:color name="293 C" rgb="0 61 165"/>
    <css:color name="294 C" rgb="0 47 108"/>
    <css:color name="295 C" rgb="0 40 85"/>
    <css:color name="296 C" rgb="4 28 44"/>
    <css:color name="2905 C" rgb="141 200 232"/>
    <css:color name="2915 C" rgb="98 181 229"/>
    <css:color name="2925 C" rgb="0 156 222"/>
    <css:color name="2935 C" rgb="0 87 184"/>
    <css:color name="2945 C" rgb="0 76 151"/>
    <css:color name="2955 C" rgb="0 56 101"/>
    <css:color name="2965 C" rgb="0 38 62"/>
    <css:color name="297 C" rgb="113 197 232"/>
    <css:color name="298 C" rgb="65 182 230"/>
    <css:color name="299 C" rgb="0 163 224"/>
    <css:color name="300 C" rgb="0 94 184"/>
    <css:color name="301 C" rgb="0 75 135"/>
    <css:color name="302 C" rgb="0 59 92"/>
    <css:color name="303 C" rgb="0 42 58"/>
    <css:color name="7688 C" rgb="70 152 203"/>
    <css:color name="7689 C" rgb="41 143 194"/>
    <css:color name="7690 C" rgb="0 118 168"/>
    <css:color name="7691 C" rgb="0 98 152"/>
    <css:color name="7692 C" rgb="0 85 135"/>
    <css:color name="7693 C" rgb="0 73 118"/>
    <css:color name="7694 C" rgb="1 66 106"/>
    <css:color name="2975 C" rgb="153 214 234"/>
    <css:color name="2985 C" rgb="91 194 231"/>
    <css:color name="2995 C" rgb="0 169 224"/>
    <css:color name="3005 C" rgb="0 119 200"/>
    <css:color name="3015 C" rgb="0 98 155"/>
    <css:color name="3025 C" rgb="0 79 113"/>
    <css:color name="3035 C" rgb="0 62 81"/>
    <css:color name="7695 C" rgb="123 167 188"/>
    <css:color name="7696 C" rgb="99 153 174"/>
    <css:color name="7697 C" rgb="78 135 160"/>
    <css:color name="7698 C" rgb="65 116 141"/>
    <css:color name="7699 C" rgb="52 101 127"/>
    <css:color name="7700 C" rgb="22 92 125"/>
    <css:color name="7701 C" rgb="0 87 118"/>
    <css:color name="7457 C" rgb="187 221 230"/>
    <css:color name="7458 C" rgb="113 178 201"/>
    <css:color name="7459 C" rgb="66 152 181"/>
    <css:color name="7460 C" rgb="0 134 191"/>
    <css:color name="7461 C" rgb="0 125 186"/>
    <css:color name="7462 C" rgb="0 85 140"/>
    <css:color name="7463 C" rgb="0 43 73"/>
    <css:color name="304 C" rgb="154 219 232"/>
    <css:color name="305 C" rgb="89 203 232"/>
    <css:color name="306 C" rgb="0 181 226"/>
    <css:color name="307 C" rgb="0 107 166"/>
    <css:color name="308 C" rgb="0 88 124"/>
    <css:color name="309 C" rgb="0 59 73"/>
    <css:color name="635 C" rgb="164 219 232"/>
    <css:color name="636 C" rgb="139 211 230"/>
    <css:color name="637 C" rgb="78 195 224"/>
    <css:color name="638 C" rgb="0 175 215"/>
    <css:color name="639 C" rgb="0 149 200"/>
    <css:color name="640 C" rgb="0 130 186"/>
    <css:color name="641 C" rgb="0 103 160"/>
    <css:color name="7702 C" rgb="72 169 197"/>
    <css:color name="7703 C" rgb="0 156 189"/>
    <css:color name="7704 C" rgb="0 133 173"/>
    <css:color name="7705 C" rgb="0 112 150"/>
    <css:color name="7706 C" rgb="0 106 142"/>
    <css:color name="7707 C" rgb="0 97 127"/>
    <css:color name="7708 C" rgb="0 86 112"/>
    <css:color name="628 C" rgb="184 221 225"/>
    <css:color name="629 C" rgb="155 211 221"/>
    <css:color name="630 C" rgb="119 197 213"/>
    <css:color name="631 C" rgb="62 177 200"/>
    <css:color name="632 C" rgb="0 147 178"/>
    <css:color name="633 C" rgb="0 115 150"/>
    <css:color name="634 C" rgb="0 95 131"/>
    <css:color name="310 C" rgb="106 209 227"/>
    <css:color name="311 C" rgb="5 195 222"/>
    <css:color name="312 C" rgb="0 169 206"/>
    <css:color name="313 C" rgb="0 146 188"/>
    <css:color name="314 C" rgb="0 127 163"/>
    <css:color name="315 C" rgb="0 103 127"/>
    <css:color name="316 C" rgb="0 72 81"/>
    <css:color name="3105 C" rgb="104 210 223"/>
    <css:color name="3115 C" rgb="0 193 213"/>
    <css:color name="3125 C" rgb="0 174 199"/>
    <css:color name="3135 C" rgb="0 142 170"/>
    <css:color name="3145 C" rgb="0 119 139"/>
    <css:color name="3155 C" rgb="0 98 114"/>
    <css:color name="3165 C" rgb="0 79 89"/>
    <css:color name="7709 C" rgb="99 177 188"/>
    <css:color name="7710 C" rgb="0 167 181"/>
    <css:color name="7711 C" rgb="0 151 169"/>
    <css:color name="7712 C" rgb="0 133 155"/>
    <css:color name="7713 C" rgb="0 125 138"/>
    <css:color name="7714 C" rgb="0 118 128"/>
    <css:color name="7715 C" rgb="0 98 105"/>
    <css:color name="317 C" rgb="177 228 227"/>
    <css:color name="318 C" rgb="136 219 223"/>
    <css:color name="319 C" rgb="45 204 211"/>
    <css:color name="320 C" rgb="0 156 166"/>
    <css:color name="321 C" rgb="0 140 149"/>
    <css:color name="322 C" rgb="0 115 119"/>
    <css:color name="323 C" rgb="0 95 97"/>
    <css:color name="7464 C" rgb="160 209 202"/>
    <css:color name="7465 C" rgb="64 193 172"/>
    <css:color name="7466 C" rgb="0 176 185"/>
    <css:color name="7467 C" rgb="0 163 173"/>
    <css:color name="7468 C" rgb="0 115 152"/>
    <css:color name="7469 C" rgb="0 95 134"/>
    <css:color name="7470 C" rgb="0 90 112"/>
    <css:color name="7471 C" rgb="126 221 211"/>
    <css:color name="7472 C" rgb="92 184 178"/>
    <css:color name="7473 C" rgb="39 153 137"/>
    <css:color name="7474 C" rgb="0 118 129"/>
    <css:color name="7475 C" rgb="72 122 123"/>
    <css:color name="7476 C" rgb="13 82 87"/>
    <css:color name="7477 C" rgb="36 76 90"/>
    <css:color name="5523 C" rgb="182 207 208"/>
    <css:color name="5513 C" rgb="171 199 202"/>
    <css:color name="5503 C" rgb="148 183 187"/>
    <css:color name="5493 C" rgb="127 169 174"/>
    <css:color name="5483 C" rgb="79 134 142"/>
    <css:color name="5473 C" rgb="17 94 103"/>
    <css:color name="5463 C" rgb="7 39 45"/>
    <css:color name="7716 C" rgb="0 150 143"/>
    <css:color name="7717 C" rgb="0 133 125"/>
    <css:color name="7718 C" rgb="0 118 114"/>
    <css:color name="7719 C" rgb="0 109 104"/>
    <css:color name="7720 C" rgb="0 99 91"/>
    <css:color name="7721 C" rgb="0 94 93"/>
    <css:color name="7722 C" rgb="0 81 81"/>
    <css:color name="324 C" rgb="156 219 217"/>
    <css:color name="325 C" rgb="100 204 201"/>
    <css:color name="326 C" rgb="0 178 169"/>
    <css:color name="327 C" rgb="0 134 117"/>
    <css:color name="328 C" rgb="0 115 103"/>
    <css:color name="329 C" rgb="0 104 94"/>
    <css:color name="330 C" rgb="0 83 76"/>
    <css:color name="3242 C" rgb="113 219 212"/>
    <css:color name="3252 C" rgb="42 210 201"/>
    <css:color name="3262 C" rgb="0 191 179"/>
    <css:color name="3272 C" rgb="0 164 153"/>
    <css:color name="3282 C" rgb="0 133 120"/>
    <css:color name="3292 C" rgb="0 89 79"/>
    <css:color name="3302 C" rgb="0 76 69"/>
    <css:color name="3245 C" rgb="124 224 211"/>
    <css:color name="3255 C" rgb="44 213 196"/>
    <css:color name="3265 C" rgb="0 199 177"/>
    <css:color name="3275 C" rgb="0 179 152"/>
    <css:color name="3285 C" rgb="0 150 129"/>
    <css:color name="3295 C" rgb="0 120 100"/>
    <css:color name="3305 C" rgb="0 78 66"/>
    <css:color name="3248 C" rgb="109 205 184"/>
    <css:color name="3258 C" rgb="73 197 177"/>
    <css:color name="3268 C" rgb="0 171 142"/>
    <css:color name="3278 C" rgb="0 155 119"/>
    <css:color name="3288 C" rgb="0 130 100"/>
    <css:color name="3298 C" rgb="0 106 82"/>
    <css:color name="3308 C" rgb="3 70 56"/>
    <css:color name="566 C" rgb="185 220 210"/>
    <css:color name="565 C" rgb="161 214 202"/>
    <css:color name="564 C" rgb="134 200 188"/>
    <css:color name="563 C" rgb="107 187 174"/>
    <css:color name="562 C" rgb="0 111 98"/>
    <css:color name="561 C" rgb="0 89 76"/>
    <css:color name="560 C" rgb="29 60 52"/>
    <css:color name="573 C" rgb="181 227 216"/>
    <css:color name="572 C" rgb="165 223 211"/>
    <css:color name="571 C" rgb="152 219 206"/>
    <css:color name="570 C" rgb="107 202 186"/>
    <css:color name="569 C" rgb="0 129 109"/>
    <css:color name="568 C" rgb="0 108 91"/>
    <css:color name="567 C" rgb="23 63 53"/>
    <css:color name="559 C" rgb="173 202 184"/>
    <css:color name="558 C" rgb="154 190 170"/>
    <css:color name="557 C" rgb="133 176 154"/>
    <css:color name="556 C" rgb="111 162 135"/>
    <css:color name="555 C" rgb="40 114 79"/>
    <css:color name="554 C" rgb="32 92 64"/>
    <css:color name="553 C" rgb="40 71 52"/>
    <css:color name="5595 C" rgb="191 206 194"/>
    <css:color name="5585 C" rgb="167 189 177"/>
    <css:color name="5575 C" rgb="146 172 160"/>
    <css:color name="5565 C" rgb="127 156 144"/>
    <css:color name="5555 C" rgb="92 127 113"/>
    <css:color name="5545 C" rgb="67 105 91"/>
    <css:color name="5535 C" rgb="24 48 40"/>
    <css:color name="5665 C" rgb="186 197 185"/>
    <css:color name="5655 C" rgb="176 189 176"/>
    <css:color name="5645 C" rgb="163 178 164"/>
    <css:color name="5635 C" rgb="148 165 150"/>
    <css:color name="5625 C" rgb="112 133 115"/>
    <css:color name="5615 C" rgb="94 116 97"/>
    <css:color name="5605 C" rgb="34 55 43"/>
    <css:color name="5527 C" rgb="188 201 197"/>
    <css:color name="5517 C" rgb="177 192 188"/>
    <css:color name="5507 C" rgb="157 176 172"/>
    <css:color name="5497 C" rgb="130 153 149"/>
    <css:color name="5487 C" rgb="93 121 117"/>
    <css:color name="5477 C" rgb="62 93 88"/>
    <css:color name="5467 C" rgb="24 51 47"/>
    <css:color name="621 C" rgb="209 224 215"/>
    <css:color name="622 C" rgb="183 205 194"/>
    <css:color name="623 C" rgb="154 185 173"/>
    <css:color name="624 C" rgb="120 159 144"/>
    <css:color name="625 C" rgb="80 127 112"/>
    <css:color name="626 C" rgb="40 92 77"/>
    <css:color name="627 C" rgb="19 50 43"/>
    <css:color name="331 C" rgb="167 230 215"/>
    <css:color name="332 C" rgb="140 226 208"/>
    <css:color name="333 C" rgb="60 219 192"/>
    <css:color name="334 C" rgb="0 151 117"/>
    <css:color name="335 C" rgb="0 123 95"/>
    <css:color name="336 C" rgb="0 102 79"/>
    <css:color name="337 C" rgb="143 214 189"/>
    <css:color name="338 C" rgb="110 206 178"/>
    <css:color name="339 C" rgb="0 179 136"/>
    <css:color name="340 C" rgb="0 150 94"/>
    <css:color name="341 C" rgb="0 122 83"/>
    <css:color name="342 C" rgb="0 103 71"/>
    <css:color name="343 C" rgb="17 87 64"/>
    <css:color name="7723 C" rgb="80 166 132"/>
    <css:color name="7724 C" rgb="0 150 108"/>
    <css:color name="7725 C" rgb="0 135 85"/>
    <css:color name="7726 C" rgb="0 123 75"/>
    <css:color name="7727 C" rgb="0 111 68"/>
    <css:color name="7728 C" rgb="0 104 69"/>
    <css:color name="7729 C" rgb="0 88 68"/>
    <css:color name="3375 C" rgb="122 225 191"/>
    <css:color name="3385 C" rgb="71 215 172"/>
    <css:color name="3395 C" rgb="0 195 137"/>
    <css:color name="3405 C" rgb="0 175 102"/>
    <css:color name="3415 C" rgb="0 119 73"/>
    <css:color name="3425 C" rgb="0 99 65"/>
    <css:color name="3435 C" rgb="21 71 52"/>
    <css:color name="344 C" rgb="160 218 179"/>
    <css:color name="345 C" rgb="145 214 172"/>
    <css:color name="346 C" rgb="113 204 152"/>
    <css:color name="347 C" rgb="0 154 68"/>
    <css:color name="348 C" rgb="0 132 61"/>
    <css:color name="349 C" rgb="4 106 56"/>
    <css:color name="350 C" rgb="44 82 52"/>
    <css:color name="351 C" rgb="162 228 184"/>
    <css:color name="352 C" rgb="143 226 176"/>
    <css:color name="353 C" rgb="128 224 167"/>
    <css:color name="354 C" rgb="0 177 64"/>
    <css:color name="355 C" rgb="0 150 57"/>
    <css:color name="356 C" rgb="0 122 51"/>
    <css:color name="357 C" rgb="33 87 50"/>
    <css:color name="7478 C" rgb="155 227 191"/>
    <css:color name="7479 C" rgb="38 208 124"/>
    <css:color name="7480 C" rgb="0 191 111"/>
    <css:color name="7481 C" rgb="0 183 79"/>
    <css:color name="7482 C" rgb="0 159 77"/>
    <css:color name="7483 C" rgb="39 93 56"/>
    <css:color name="7484 C" rgb="0 87 63"/>
    <css:color name="7730 C" rgb="75 149 96"/>
    <css:color name="7731 C" rgb="34 136 72"/>
    <css:color name="7732 C" rgb="0 122 62"/>
    <css:color name="7733 C" rgb="0 112 65"/>
    <css:color name="7734 C" rgb="40 97 64"/>
    <css:color name="7735 C" rgb="54 87 59"/>
    <css:color name="7736 C" rgb="57 85 66"/>
    <css:color name="7737 C" rgb="107 165 57"/>
    <css:color name="7738 C" rgb="72 162 63"/>
    <css:color name="7739 C" rgb="49 155 66"/>
    <css:color name="7740 C" rgb="58 145 63"/>
    <css:color name="7741 C" rgb="68 136 62"/>
    <css:color name="7742 C" rgb="74 119 60"/>
    <css:color name="7743 C" rgb="68 105 61"/>
    <css:color name="358 C" rgb="173 220 145"/>
    <css:color name="359 C" rgb="161 216 132"/>
    <css:color name="360 C" rgb="108 194 74"/>
    <css:color name="361 C" rgb="67 176 42"/>
    <css:color name="362 C" rgb="80 158 47"/>
    <css:color name="363 C" rgb="76 140 43"/>
    <css:color name="364 C" rgb="74 119 41"/>
    <css:color name="7485 C" rgb="208 222 187"/>
    <css:color name="7486 C" rgb="188 225 148"/>
    <css:color name="7487 C" rgb="142 221 101"/>
    <css:color name="7488 C" rgb="120 214 75"/>
    <css:color name="7489 C" rgb="116 170 80"/>
    <css:color name="7490 C" rgb="113 153 73"/>
    <css:color name="7491 C" rgb="121 134 60"/>
    <css:color name="365 C" rgb="194 225 137"/>
    <css:color name="366 C" rgb="183 221 121"/>
    <css:color name="367 C" rgb="164 214 94"/>
    <css:color name="368 C" rgb="120 190 32"/>
    <css:color name="369 C" rgb="100 167 11"/>
    <css:color name="370 C" rgb="101 141 27"/>
    <css:color name="371 C" rgb="84 98 35"/>
    <css:color name="372 C" rgb="212 235 142"/>
    <css:color name="373 C" rgb="205 234 128"/>
    <css:color name="374 C" rgb="197 232 108"/>
    <css:color name="375 C" rgb="151 215 0"/>
    <css:color name="376 C" rgb="132 189 0"/>
    <css:color name="377 C" rgb="122 154 1"/>
    <css:color name="378 C" rgb="89 98 29"/>
    <css:color name="580 C" rgb="196 214 164"/>
    <css:color name="579 C" rgb="188 209 155"/>
    <css:color name="578 C" rgb="183 206 149"/>
    <css:color name="577 C" rgb="169 196 127"/>
    <css:color name="576 C" rgb="120 157 74"/>
    <css:color name="575 C" rgb="103 130 58"/>
    <css:color name="574 C" rgb="78 91 49"/>
    <css:color name="5807 C" rgb="208 209 171"/>
    <css:color name="5797 C" rgb="198 200 155"/>
    <css:color name="5787 C" rgb="186 189 139"/>
    <css:color name="5777 C" rgb="162 165 105"/>
    <css:color name="5767 C" rgb="138 141 74"/>
    <css:color name="5757 C" rgb="109 113 46"/>
    <css:color name="5747 C" rgb="61 68 30"/>
    <css:color name="5875 C" rgb="210 206 158"/>
    <css:color name="5865 C" rgb="203 199 147"/>
    <css:color name="5855 C" rgb="192 187 135"/>
    <css:color name="5845 C" rgb="175 169 110"/>
    <css:color name="5835 C" rgb="160 153 88"/>
    <css:color name="5825 C" rgb="137 129 61"/>
    <css:color name="5815 C" rgb="85 80 37"/>
    <css:color name="5803 C" rgb="195 198 168"/>
    <css:color name="5793 C" rgb="179 185 149"/>
    <css:color name="5783 C" rgb="163 170 131"/>
    <css:color name="5773 C" rgb="137 144 100"/>
    <css:color name="5763 C" rgb="115 123 76"/>
    <css:color name="5753 C" rgb="94 103 56"/>
    <css:color name="5743 C" rgb="62 72 39"/>
    <css:color name="7492 C" rgb="191 204 128"/>
    <css:color name="7493 C" rgb="187 197 146"/>
    <css:color name="7494 C" rgb="156 175 136"/>
    <css:color name="7495 C" rgb="143 153 62"/>
    <css:color name="7496 C" rgb="118 136 29"/>
    <css:color name="7497 C" rgb="122 114 86"/>
    <css:color name="7498 C" rgb="91 98 54"/>
    <css:color name="7744 C" rgb="186 188 22"/>
    <css:color name="7745 C" rgb="171 173 35"/>
    <css:color name="7746 C" rgb="153 155 48"/>
    <css:color name="7747 C" rgb="136 141 48"/>
    <css:color name="7748 C" rgb="124 128 52"/>
    <css:color name="7749 C" rgb="114 115 55"/>
    <css:color name="7750 C" rgb="101 102 53"/>
    <css:color name="379 C" rgb="226 232 104"/>
    <css:color name="380 C" rgb="219 228 66"/>
    <css:color name="381 C" rgb="206 220 0"/>
    <css:color name="382 C" rgb="196 214 0"/>
    <css:color name="383 C" rgb="168 173 0"/>
    <css:color name="384 C" rgb="148 147 0"/>
    <css:color name="385 C" rgb="120 113 33"/>
    <css:color name="386 C" rgb="233 236 107"/>
    <css:color name="387 C" rgb="227 233 53"/>
    <css:color name="388 C" rgb="224 231 33"/>
    <css:color name="389 C" rgb="208 223 0"/>
    <css:color name="390 C" rgb="181 189 0"/>
    <css:color name="391 C" rgb="154 149 0"/>
    <css:color name="392 C" rgb="130 122 4"/>
    <css:color name="587 C" rgb="227 228 141"/>
    <css:color name="586 C" rgb="224 226 124"/>
    <css:color name="585 C" rgb="219 222 112"/>
    <css:color name="584 C" rgb="210 215 85"/>
    <css:color name="583 C" rgb="183 191 16"/>
    <css:color name="582 C" rgb="142 140 19"/>
    <css:color name="581 C" rgb="98 93 32"/>
    <css:color name="393 C" rgb="240 236 116"/>
    <css:color name="394 C" rgb="237 233 57"/>
    <css:color name="395 C" rgb="236 232 26"/>
    <css:color name="396 C" rgb="225 224 0"/>
    <css:color name="397 C" rgb="191 184 0"/>
    <css:color name="398 C" rgb="173 164 0"/>
    <css:color name="399 C" rgb="160 146 0"/>
    <css:color name="3935 C" rgb="243 234 93"/>
    <css:color name="3945 C" rgb="243 229 0"/>
    <css:color name="3955 C" rgb="239 223 0"/>
    <css:color name="3965 C" rgb="238 220 0"/>
    <css:color name="3975 C" rgb="187 166 0"/>
    <css:color name="3985 C" rgb="154 135 0"/>
    <css:color name="3995 C" rgb="104 92 32"/>
    <css:color name="600 C" rgb="241 235 156"/>
    <css:color name="601 C" rgb="240 233 145"/>
    <css:color name="602 C" rgb="240 232 123"/>
    <css:color name="603 C" rgb="237 224 75"/>
    <css:color name="604 C" rgb="234 218 36"/>
    <css:color name="605 C" rgb="225 205 0"/>
    <css:color name="606 C" rgb="207 181 0"/>
    <css:color name="607 C" rgb="235 228 154"/>
    <css:color name="608 C" rgb="233 225 134"/>
    <css:color name="609 C" rgb="230 222 119"/>
    <css:color name="610 C" rgb="225 213 85"/>
    <css:color name="611 C" rgb="215 200 38"/>
    <css:color name="612 C" rgb="196 176 0"/>
    <css:color name="613 C" rgb="179 155 0"/>
    <css:color name="461 C" rgb="233 223 151"/>
    <css:color name="460 C" rgb="228 215 126"/>
    <css:color name="459 C" rgb="222 205 99"/>
    <css:color name="458 C" rgb="217 199 86"/>
    <css:color name="457 C" rgb="184 157 24"/>
    <css:color name="456 C" rgb="162 142 42"/>
    <css:color name="455 C" rgb="105 91 36"/>
    <css:color name="614 C" rgb="220 213 154"/>
    <css:color name="615 C" rgb="214 207 141"/>
    <css:color name="616 C" rgb="208 200 131"/>
    <css:color name="617 C" rgb="192 181 97"/>
    <css:color name="618 C" rgb="172 159 60"/>
    <css:color name="619 C" rgb="159 145 42"/>
    <css:color name="620 C" rgb="138 123 25"/>
    <css:color name="7751 C" rgb="202 182 75"/>
    <css:color name="7752 C" rgb="207 176 35"/>
    <css:color name="7753 C" rgb="193 160 30"/>
    <css:color name="7754 C" rgb="160 134 41"/>
    <css:color name="7755 C" rgb="137 118 48"/>
    <css:color name="7756 C" rgb="115 102 53"/>
    <css:color name="7757 C" rgb="103 94 51"/>
    <css:color name="7758 C" rgb="212 195 4"/>
    <css:color name="7759 C" rgb="196 178 0"/>
    <css:color name="7760 C" rgb="145 133 44"/>
    <css:color name="7761 C" rgb="116 113 54"/>
    <css:color name="7762 C" rgb="93 100 57"/>
    <css:color name="7763 C" rgb="88 92 59"/>
    <css:color name="7764 C" rgb="83 84 53"/>
    <css:color name="7765 C" rgb="187 179 35"/>
    <css:color name="7766 C" rgb="180 169 31"/>
    <css:color name="7767 C" rgb="170 157 46"/>
    <css:color name="7768 C" rgb="143 126 53"/>
    <css:color name="7769 C" rgb="113 97 53"/>
    <css:color name="7770 C" rgb="99 89 57"/>
    <css:color name="7771 C" rgb="78 73 52"/>
    <css:color name="4545 C" rgb="213 203 159"/>
    <css:color name="4535 C" rgb="207 196 147"/>
    <css:color name="4525 C" rgb="197 183 131"/>
    <css:color name="4515 C" rgb="179 163 105"/>
    <css:color name="4505 C" rgb="153 133 66"/>
    <css:color name="4495 C" rgb="140 119 50"/>
    <css:color name="4485 C" rgb="97 79 37"/>
    <css:color name="454 C" rgb="202 199 167"/>
    <css:color name="453 C" rgb="191 187 152"/>
    <css:color name="452 C" rgb="176 170 126"/>
    <css:color name="451 C" rgb="155 148 95"/>
    <css:color name="450 C" rgb="89 74 37"/>
    <css:color name="449 C" rgb="82 71 39"/>
    <css:color name="448 C" rgb="74 65 42"/>
    <css:color name="7499 C" rgb="241 230 178"/>
    <css:color name="7500 C" rgb="223 209 167"/>
    <css:color name="7501 C" rgb="217 200 158"/>
    <css:color name="7502 C" rgb="206 184 136"/>
    <css:color name="7503 C" rgb="168 153 104"/>
    <css:color name="7504 C" rgb="148 121 93"/>
    <css:color name="7505 C" rgb="129 96 64"/>
    <css:color name="468 C" rgb="221 203 164"/>
    <css:color name="467 C" rgb="211 188 141"/>
    <css:color name="466 C" rgb="198 170 118"/>
    <css:color name="465 C" rgb="185 151 91"/>
    <css:color name="464 C" rgb="139 91 41"/>
    <css:color name="463 C" rgb="116 79 40"/>
    <css:color name="462 C" rgb="92 70 43"/>
    <css:color name="7506 C" rgb="239 219 178"/>
    <css:color name="7507 C" rgb="252 210 153"/>
    <css:color name="7508 C" rgb="225 184 127"/>
    <css:color name="7509 C" rgb="214 164 97"/>
    <css:color name="7510 C" rgb="198 137 63"/>
    <css:color name="7511 C" rgb="183 119 41"/>
    <css:color name="7512 C" rgb="166 99 27"/>
    <css:color name="719 C" rgb="237 200 163"/>
    <css:color name="720 C" rgb="231 183 138"/>
    <css:color name="721 C" rgb="221 164 111"/>
    <css:color name="722 C" rgb="200 130 66"/>
    <css:color name="723 C" rgb="179 105 36"/>
    <css:color name="724 C" rgb="147 77 17"/>
    <css:color name="725 C" rgb="125 63 22"/>
    <css:color name="475 C" rgb="243 207 179"/>
    <css:color name="474 C" rgb="241 198 167"/>
    <css:color name="473 C" rgb="240 191 155"/>
    <css:color name="472 C" rgb="229 158 109"/>
    <css:color name="471 C" rgb="184 97 37"/>
    <css:color name="470 C" rgb="164 90 42"/>
    <css:color name="469 C" rgb="105 63 35"/>
    <css:color name="726 C" rgb="224 192 159"/>
    <css:color name="727 C" rgb="217 180 143"/>
    <css:color name="728 C" rgb="205 160 119"/>
    <css:color name="729 C" rgb="181 129 80"/>
    <css:color name="730 C" rgb="158 101 46"/>
    <css:color name="731 C" rgb="119 66 18"/>
    <css:color name="732 C" rgb="98 52 18"/>
    <css:color name="4685 C" rgb="224 198 173"/>
    <css:color name="4675 C" rgb="220 191 166"/>
    <css:color name="4665 C" rgb="205 167 136"/>
    <css:color name="4655 C" rgb="191 148 116"/>
    <css:color name="4645 C" rgb="173 124 89"/>
    <css:color name="4635 C" rgb="148 96 55"/>
    <css:color name="4625 C" rgb="79 44 29"/>
    <css:color name="7513 C" rgb="225 183 167"/>
    <css:color name="7514 C" rgb="213 162 134"/>
    <css:color name="7515 C" rgb="197 139 104"/>
    <css:color name="7516 C" rgb="153 85 43"/>
    <css:color name="7517 C" rgb="133 67 30"/>
    <css:color name="7518 C" rgb="109 79 71"/>
    <css:color name="7519 C" rgb="94 75 60"/>
    <css:color name="4755 C" rgb="215 196 183"/>
    <css:color name="4745 C" rgb="205 181 167"/>
    <css:color name="4735 C" rgb="192 163 146"/>
    <css:color name="4725 C" rgb="174 138 121"/>
    <css:color name="4715 C" rgb="149 108 88"/>
    <css:color name="4705 C" rgb="124 77 58"/>
    <css:color name="4695 C" rgb="91 52 39"/>
    <css:color name="482 C" rgb="219 200 182"/>
    <css:color name="481 C" rgb="211 187 168"/>
    <css:color name="480 C" rgb="198 169 146"/>
    <css:color name="479 C" rgb="170 128 102"/>
    <css:color name="478 C" rgb="112 63 42"/>
    <css:color name="477 C" rgb="98 59 42"/>
    <css:color name="476 C" rgb="78 54 41"/>
    <css:color name="7527 C" rgb="214 210 196"/>
    <css:color name="7528 C" rgb="197 185 172"/>
    <css:color name="7529 C" rgb="183 169 154"/>
    <css:color name="7530 C" rgb="163 147 130"/>
    <css:color name="7531 C" rgb="122 104 85"/>
    <css:color name="7532 C" rgb="99 81 61"/>
    <css:color name="7533 C" rgb="71 55 41"/>
    <css:color name="7534 C" rgb="209 204 189"/>
    <css:color name="7535 C" rgb="183 176 156"/>
    <css:color name="7536 C" rgb="166 159 136"/>
    <css:color name="7537 C" rgb="167 172 162"/>
    <css:color name="7538 C" rgb="148 154 144"/>
    <css:color name="7539 C" rgb="142 144 137"/>
    <css:color name="7540 C" rgb="75 79 84"/>
    <css:color name="427 C" rgb="208 211 212"/>
    <css:color name="428 C" rgb="193 198 200"/>
    <css:color name="429 C" rgb="162 170 173"/>
    <css:color name="430 C" rgb="124 135 142"/>
    <css:color name="431 C" rgb="91 103 112"/>
    <css:color name="432 C" rgb="51 63 72"/>
    <css:color name="433 C" rgb="29 37 45"/>
    <css:color name="420 C" rgb="199 201 199"/>
    <css:color name="421 C" rgb="178 180 178"/>
    <css:color name="422 C" rgb="158 162 162"/>
    <css:color name="423 C" rgb="137 141 141"/>
    <css:color name="424 C" rgb="112 115 114"/>
    <css:color name="425 C" rgb="84 88 90"/>
    <css:color name="426 C" rgb="37 40 42"/>
    <css:color name="441 C" rgb="190 198 196"/>
    <css:color name="442 C" rgb="162 172 171"/>
    <css:color name="443 C" rgb="145 157 157"/>
    <css:color name="444 C" rgb="113 124 125"/>
    <css:color name="445 C" rgb="80 87 89"/>
    <css:color name="446 C" rgb="63 68 68"/>
    <css:color name="447 C" rgb="55 58 54"/>
    <css:color name="413 C" rgb="186 187 177"/>
    <css:color name="414 C" rgb="168 169 158"/>
    <css:color name="415 C" rgb="145 147 136"/>
    <css:color name="416 C" rgb="126 127 116"/>
    <css:color name="417 C" rgb="101 102 92"/>
    <css:color name="418 C" rgb="81 83 74"/>
    <css:color name="419 C" rgb="33 35 34"/>
    <css:color name="400 C" rgb="196 191 182"/>
    <css:color name="401 C" rgb="175 169 160"/>
    <css:color name="402 C" rgb="157 150 141"/>
    <css:color name="403 C" rgb="140 133 123"/>
    <css:color name="404 C" rgb="119 110 100"/>
    <css:color name="405 C" rgb="105 97 88"/>
    <css:color name="406 C" rgb="196 188 183"/>
    <css:color name="407 C" rgb="178 168 162"/>
    <css:color name="408 C" rgb="151 140 135"/>
    <css:color name="409 C" rgb="133 120 116"/>
    <css:color name="410 C" rgb="116 102 97"/>
    <css:color name="411 C" rgb="94 81 77"/>
    <css:color name="412 C" rgb="56 47 45"/>
    <css:color name="434 C" rgb="208 196 197"/>
    <css:color name="435 C" rgb="193 178 182"/>
    <css:color name="436 C" rgb="171 152 157"/>
    <css:color name="437 C" rgb="123 100 105"/>
    <css:color name="438 C" rgb="88 68 70"/>
    <css:color name="439 C" rgb="69 53 54"/>
    <css:color name="440 C" rgb="56 46 44"/>
    <css:color name="Warm Gray 1 C" rgb="215 210 203"/>
    <css:color name="Warm Gray 2 C" rgb="203 196 188"/>
    <css:color name="Warm Gray 3 C" rgb="191 184 175"/>
    <css:color name="Warm Gray 4 C" rgb="182 173 165"/>
    <css:color name="Warm Gray 5 C" rgb="172 163 154"/>
    <css:color name="Warm Gray 6 C" rgb="165 156 148"/>
    <css:color name="Warm Gray 7 C" rgb="150 140 131"/>
    <css:color name="Warm Gray 8 C" rgb="140 130 121"/>
    <css:color name="Warm Gray 9 C" rgb="131 120 111"/>
    <css:color name="Warm Gray 10 C" rgb="121 110 101"/>
    <css:color name="Warm Gray 11 C" rgb="110 98 89"/>
    <css:color name="Cool Gray 1 C" rgb="217 217 214"/>
    <css:color name="Cool Gray 2 C" rgb="208 208 206"/>
    <css:color name="Cool Gray 3 C" rgb="200 201 199"/>
    <css:color name="Cool Gray 4 C" rgb="187 188 188"/>
    <css:color name="Cool Gray 5 C" rgb="177 179 179"/>
    <css:color name="Cool Gray 6 C" rgb="167 168 170"/>
    <css:color name="Cool Gray 7 C" rgb="151 153 155"/>
    <css:color name="Cool Gray 8 C" rgb="136 139 141"/>
    <css:color name="Cool Gray 9 C" rgb="117 120 123"/>
    <css:color name="Cool Gray 10 C" rgb="99 102 106"/>
    <css:color name="Cool Gray 11 C" rgb="83 86 90"/>
    <css:color name="Black 2 C" rgb="51 47 33"/>
    <css:color name="Black 3 C" rgb="33 39 33"/>
    <css:color name="Black 4 C" rgb="49 38 29"/>
    <css:color name="Black 5 C" rgb="62 43 46"/>
    <css:color name="Black 6 C" rgb="16 24 32"/>
    <css:color name="Black 7 C" rgb="61 57 53"/>
  </css:colors>
  
</xsl:stylesheet>