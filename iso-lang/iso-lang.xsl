<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:letex="http://www.le-tex.de/namespace"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!--  function letex:is-valid-iso-lang-code
          checks whether string matches ISO 639-1 language code
    -->
    
    <xsl:function name="letex:is-valid-iso-lang-code" as="xs:boolean">
        <xsl:param name="context" as="xs:string"/>
        <xsl:sequence select="some $i in document('')//letex:langs/letex:lang satisfies $i/@code eq $context"/>
    </xsl:function>    
    
    <letex:langs>
        <letex:lang code="alpha2" value="English"/>
        <letex:lang code="aa" value="Afar"/>
        <letex:lang code="ab" value="Abkhazian"/>
        <letex:lang code="ae" value="Avestan"/>
        <letex:lang code="af" value="Afrikaans"/>
        <letex:lang code="ak" value="Akan"/>
        <letex:lang code="am" value="Amharic"/>
        <letex:lang code="an" value="Aragonese"/>
        <letex:lang code="ar" value="Arabic"/>
        <letex:lang code="as" value="Assamese"/>
        <letex:lang code="av" value="Avaric"/>
        <letex:lang code="ay" value="Aymara"/>
        <letex:lang code="az" value="Azerbaijani"/>
        <letex:lang code="ba" value="Bashkir"/>
        <letex:lang code="be" value="Belarusian"/>
        <letex:lang code="bg" value="Bulgarian"/>
        <letex:lang code="bh" value="Bihari languages"/>
        <letex:lang code="bi" value="Bislama"/>
        <letex:lang code="bm" value="Bambara"/>
        <letex:lang code="bn" value="Bengali"/>
        <letex:lang code="bo" value="Tibetan"/>
        <letex:lang code="br" value="Breton"/>
        <letex:lang code="bs" value="Bosnian"/>
        <letex:lang code="ca" value="Catalan; Valencian"/>
        <letex:lang code="ce" value="Chechen"/>
        <letex:lang code="ch" value="Chamorro"/>
        <letex:lang code="co" value="Corsican"/>
        <letex:lang code="cr" value="Cree"/>
        <letex:lang code="cs" value="Czech"/>
        <letex:lang code="cu" value="Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic"/>
        <letex:lang code="cv" value="Chuvash"/>
        <letex:lang code="cy" value="Welsh"/>
        <letex:lang code="da" value="Danish"/>
        <letex:lang code="de" value="German"/>
        <letex:lang code="dv" value="Divehi; Dhivehi; Maldivian"/>
        <letex:lang code="dz" value="Dzongkha"/>
        <letex:lang code="ee" value="Ewe"/>
        <letex:lang code="el" value="Greek, Modern (1453-)"/>
        <letex:lang code="en" value="English"/>
        <letex:lang code="eo" value="Esperanto"/>
        <letex:lang code="es" value="Spanish; Castilian"/>
        <letex:lang code="et" value="Estonian"/>
        <letex:lang code="eu" value="Basque"/>
        <letex:lang code="fa" value="Persian"/>
        <letex:lang code="ff" value="Fulah"/>
        <letex:lang code="fi" value="Finnish"/>
        <letex:lang code="fj" value="Fijian"/>
        <letex:lang code="fo" value="Faroese"/>
        <letex:lang code="fr" value="French"/>
        <letex:lang code="fy" value="Western Frisian"/>
        <letex:lang code="ga" value="Irish"/>
        <letex:lang code="gd" value="Gaelic; Scottish Gaelic"/>
        <letex:lang code="gl" value="Galician"/>
        <letex:lang code="gn" value="Guarani"/>
        <letex:lang code="gu" value="Gujarati"/>
        <letex:lang code="gv" value="Manx"/>
        <letex:lang code="ha" value="Hausa"/>
        <letex:lang code="he" value="Hebrew"/>
        <letex:lang code="hi" value="Hindi"/>
        <letex:lang code="ho" value="Hiri Motu"/>
        <letex:lang code="hr" value="Croatian"/>
        <letex:lang code="ht" value="Haitian; Haitian Creole"/>
        <letex:lang code="hu" value="Hungarian"/>
        <letex:lang code="hy" value="Armenian"/>
        <letex:lang code="hz" value="Herero"/>
        <letex:lang code="ia" value="Interlingua (International Auxiliary Language Association)"/>
        <letex:lang code="id" value="Indonesian"/>
        <letex:lang code="ie" value="Interlingue; Occidental"/>
        <letex:lang code="ig" value="Igbo"/>
        <letex:lang code="ii" value="Sichuan Yi; Nuosu"/>
        <letex:lang code="ik" value="Inupiaq"/>
        <letex:lang code="io" value="Ido"/>
        <letex:lang code="is" value="Icelandic"/>
        <letex:lang code="it" value="Italian"/>
        <letex:lang code="iu" value="Inuktitut"/>
        <letex:lang code="ja" value="Japanese"/>
        <letex:lang code="jv" value="Javanese"/>
        <letex:lang code="ka" value="Georgian"/>
        <letex:lang code="kg" value="Kongo"/>
        <letex:lang code="ki" value="Kikuyu; Gikuyu"/>
        <letex:lang code="kj" value="Kuanyama; Kwanyama"/>
        <letex:lang code="kk" value="Kazakh"/>
        <letex:lang code="kl" value="Kalaallisut; Greenlandic"/>
        <letex:lang code="km" value="Central Khmer"/>
        <letex:lang code="kn" value="Kannada"/>
        <letex:lang code="ko" value="Korean"/>
        <letex:lang code="kr" value="Kanuri"/>
        <letex:lang code="ks" value="Kashmiri"/>
        <letex:lang code="ku" value="Kurdish"/>
        <letex:lang code="kv" value="Komi"/>
        <letex:lang code="kw" value="Cornish"/>
        <letex:lang code="ky" value="Kirghiz; Kyrgyz"/>
        <letex:lang code="la" value="Latin"/>
        <letex:lang code="lb" value="Luxembourgish; Letzeburgesch"/>
        <letex:lang code="lg" value="Ganda"/>
        <letex:lang code="li" value="Limburgan; Limburger; Limburgish"/>
        <letex:lang code="ln" value="Lingala"/>
        <letex:lang code="lo" value="Lao"/>
        <letex:lang code="lt" value="Lithuanian"/>
        <letex:lang code="lu" value="Luba-Katanga"/>
        <letex:lang code="lv" value="Latvian"/>
        <letex:lang code="mg" value="Malagasy"/>
        <letex:lang code="mh" value="Marshallese"/>
        <letex:lang code="mi" value="Maori"/>
        <letex:lang code="mk" value="Macedonian"/>
        <letex:lang code="ml" value="Malayalam"/>
        <letex:lang code="mn" value="Mongolian"/>
        <letex:lang code="mr" value="Marathi"/>
        <letex:lang code="ms" value="Malay"/>
        <letex:lang code="mt" value="Maltese"/>
        <letex:lang code="my" value="Burmese"/>
        <letex:lang code="na" value="Nauru"/>
        <letex:lang code="nb" value="Bokmål, Norwegian; Norwegian Bokmål"/>
        <letex:lang code="nd" value="Ndebele, North; North Ndebele"/>
        <letex:lang code="ne" value="Nepali"/>
        <letex:lang code="ng" value="Ndonga"/>
        <letex:lang code="nl" value="Dutch; Flemish"/>
        <letex:lang code="nn" value="Norwegian Nynorsk; Nynorsk, Norwegian"/>
        <letex:lang code="no" value="Norwegian"/>
        <letex:lang code="nr" value="Ndebele, South; South Ndebele"/>
        <letex:lang code="nv" value="Navajo; Navaho"/>
        <letex:lang code="ny" value="Chichewa; Chewa; Nyanja"/>
        <letex:lang code="oc" value="Occitan (post 1500); Provençal"/>
        <letex:lang code="oj" value="Ojibwa"/>
        <letex:lang code="om" value="Oromo"/>
        <letex:lang code="or" value="Oriya"/>
        <letex:lang code="os" value="Ossetian; Ossetic"/>
        <letex:lang code="pa" value="Panjabi; Punjabi"/>
        <letex:lang code="pi" value="Pali"/>
        <letex:lang code="pl" value="Polish"/>
        <letex:lang code="ps" value="Pushto; Pashto"/>
        <letex:lang code="pt" value="Portuguese"/>
        <letex:lang code="qu" value="Quechua"/>
        <letex:lang code="rm" value="Romansh"/>
        <letex:lang code="rn" value="Rundi"/>
        <letex:lang code="ro" value="Romanian; Moldavian; Moldovan"/>
        <letex:lang code="ru" value="Russian"/>
        <letex:lang code="rw" value="Kinyarwanda"/>
        <letex:lang code="sa" value="Sanskrit"/>
        <letex:lang code="sc" value="Sardinian"/>
        <letex:lang code="sd" value="Sindhi"/>
        <letex:lang code="se" value="Northern Sami"/>
        <letex:lang code="sg" value="Sango"/>
        <letex:lang code="si" value="Sinhala; Sinhalese"/>
        <letex:lang code="sk" value="Slovak"/>
        <letex:lang code="sl" value="Slovenian"/>
        <letex:lang code="sm" value="Samoan"/>
        <letex:lang code="sn" value="Shona"/>
        <letex:lang code="so" value="Somali"/>
        <letex:lang code="sq" value="Albanian"/>
        <letex:lang code="sr" value="Serbian"/>
        <letex:lang code="ss" value="Swati"/>
        <letex:lang code="st" value="Sotho, Southern"/>
        <letex:lang code="su" value="Sundanese"/>
        <letex:lang code="sv" value="Swedish"/>
        <letex:lang code="sw" value="Swahili"/>
        <letex:lang code="ta" value="Tamil"/>
        <letex:lang code="te" value="Telugu"/>
        <letex:lang code="tg" value="Tajik"/>
        <letex:lang code="th" value="Thai"/>
        <letex:lang code="ti" value="Tigrinya"/>
        <letex:lang code="tk" value="Turkmen"/>
        <letex:lang code="tl" value="Tagalog"/>
        <letex:lang code="tn" value="Tswana"/>
        <letex:lang code="to" value="Tonga (Tonga Islands)"/>
        <letex:lang code="tr" value="Turkish"/>
        <letex:lang code="ts" value="Tsonga"/>
        <letex:lang code="tt" value="Tatar"/>
        <letex:lang code="tw" value="Twi"/>
        <letex:lang code="ty" value="Tahitian"/>
        <letex:lang code="ug" value="Uighur; Uyghur"/>
        <letex:lang code="uk" value="Ukrainian"/>
        <letex:lang code="ur" value="Urdu"/>
        <letex:lang code="uz" value="Uzbek"/>
        <letex:lang code="ve" value="Venda"/>
        <letex:lang code="vi" value="Vietnamese"/>
        <letex:lang code="vo" value="Volapük"/>
        <letex:lang code="wa" value="Walloon"/>
        <letex:lang code="wo" value="Wolof"/>
        <letex:lang code="xh" value="Xhosa"/>
        <letex:lang code="yi" value="Yiddish"/>
        <letex:lang code="yo" value="Yoruba"/>
        <letex:lang code="za" value="Zhuang; Chuang"/>
        <letex:lang code="zh" value="Chinese"/>
        <letex:lang code="zu" value="Zulu"/>
    </letex:langs>
</xsl:stylesheet>