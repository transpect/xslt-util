<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tr="http://transpect.io"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!--  function tr:is-valid-iso-lang-code
          checks whether string matches ISO 639-1 language code
    -->
    
    <xsl:function name="tr:is-valid-iso-lang-code" as="xs:boolean">
        <xsl:param name="context" as="xs:string"/>
        <xsl:sequence select="some $i in document('')//tr:langs/tr:lang satisfies $i/@code eq $context"/>
    </xsl:function>    
    
    <tr:langs>
        <tr:lang code="alpha2" value="English"/>
        <tr:lang code="aa" value="Afar"/>
        <tr:lang code="ab" value="Abkhazian"/>
        <tr:lang code="ae" value="Avestan"/>
        <tr:lang code="af" value="Afrikaans"/>
        <tr:lang code="ak" value="Akan"/>
        <tr:lang code="am" value="Amharic"/>
        <tr:lang code="an" value="Aragonese"/>
        <tr:lang code="ar" value="Arabic"/>
        <tr:lang code="as" value="Assamese"/>
        <tr:lang code="av" value="Avaric"/>
        <tr:lang code="ay" value="Aymara"/>
        <tr:lang code="az" value="Azerbaijani"/>
        <tr:lang code="ba" value="Bashkir"/>
        <tr:lang code="be" value="Belarusian"/>
        <tr:lang code="bg" value="Bulgarian"/>
        <tr:lang code="bh" value="Bihari languages"/>
        <tr:lang code="bi" value="Bislama"/>
        <tr:lang code="bm" value="Bambara"/>
        <tr:lang code="bn" value="Bengali"/>
        <tr:lang code="bo" value="Tibetan"/>
        <tr:lang code="br" value="Breton"/>
        <tr:lang code="bs" value="Bosnian"/>
        <tr:lang code="ca" value="Catalan; Valencian"/>
        <tr:lang code="ce" value="Chechen"/>
        <tr:lang code="ch" value="Chamorro"/>
        <tr:lang code="co" value="Corsican"/>
        <tr:lang code="cr" value="Cree"/>
        <tr:lang code="cs" value="Czech"/>
        <tr:lang code="cu" value="Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic"/>
        <tr:lang code="cv" value="Chuvash"/>
        <tr:lang code="cy" value="Welsh"/>
        <tr:lang code="da" value="Danish"/>
        <tr:lang code="de" value="German"/>
        <tr:lang code="dv" value="Divehi; Dhivehi; Maldivian"/>
        <tr:lang code="dz" value="Dzongkha"/>
        <tr:lang code="ee" value="Ewe"/>
        <tr:lang code="el" value="Greek, Modern (1453-)"/>
        <tr:lang code="en" value="English"/>
        <tr:lang code="eo" value="Esperanto"/>
        <tr:lang code="es" value="Spanish; Castilian"/>
        <tr:lang code="et" value="Estonian"/>
        <tr:lang code="eu" value="Basque"/>
        <tr:lang code="fa" value="Persian"/>
        <tr:lang code="ff" value="Fulah"/>
        <tr:lang code="fi" value="Finnish"/>
        <tr:lang code="fj" value="Fijian"/>
        <tr:lang code="fo" value="Faroese"/>
        <tr:lang code="fr" value="French"/>
        <tr:lang code="fy" value="Western Frisian"/>
        <tr:lang code="ga" value="Irish"/>
        <tr:lang code="gd" value="Gaelic; Scottish Gaelic"/>
        <tr:lang code="gl" value="Galician"/>
        <tr:lang code="gn" value="Guarani"/>
        <tr:lang code="gu" value="Gujarati"/>
        <tr:lang code="gv" value="Manx"/>
        <tr:lang code="ha" value="Hausa"/>
        <tr:lang code="he" value="Hebrew"/>
        <tr:lang code="hi" value="Hindi"/>
        <tr:lang code="ho" value="Hiri Motu"/>
        <tr:lang code="hr" value="Croatian"/>
        <tr:lang code="ht" value="Haitian; Haitian Creole"/>
        <tr:lang code="hu" value="Hungarian"/>
        <tr:lang code="hy" value="Armenian"/>
        <tr:lang code="hz" value="Herero"/>
        <tr:lang code="ia" value="Interlingua (International Auxiliary Language Association)"/>
        <tr:lang code="id" value="Indonesian"/>
        <tr:lang code="ie" value="Interlingue; Occidental"/>
        <tr:lang code="ig" value="Igbo"/>
        <tr:lang code="ii" value="Sichuan Yi; Nuosu"/>
        <tr:lang code="ik" value="Inupiaq"/>
        <tr:lang code="io" value="Ido"/>
        <tr:lang code="is" value="Icelandic"/>
        <tr:lang code="it" value="Italian"/>
        <tr:lang code="iu" value="Inuktitut"/>
        <tr:lang code="ja" value="Japanese"/>
        <tr:lang code="jv" value="Javanese"/>
        <tr:lang code="ka" value="Georgian"/>
        <tr:lang code="kg" value="Kongo"/>
        <tr:lang code="ki" value="Kikuyu; Gikuyu"/>
        <tr:lang code="kj" value="Kuanyama; Kwanyama"/>
        <tr:lang code="kk" value="Kazakh"/>
        <tr:lang code="kl" value="Kalaallisut; Greenlandic"/>
        <tr:lang code="km" value="Central Khmer"/>
        <tr:lang code="kn" value="Kannada"/>
        <tr:lang code="ko" value="Korean"/>
        <tr:lang code="kr" value="Kanuri"/>
        <tr:lang code="ks" value="Kashmiri"/>
        <tr:lang code="ku" value="Kurdish"/>
        <tr:lang code="kv" value="Komi"/>
        <tr:lang code="kw" value="Cornish"/>
        <tr:lang code="ky" value="Kirghiz; Kyrgyz"/>
        <tr:lang code="la" value="Latin"/>
        <tr:lang code="lb" value="Luxembourgish; Letzeburgesch"/>
        <tr:lang code="lg" value="Ganda"/>
        <tr:lang code="li" value="Limburgan; Limburger; Limburgish"/>
        <tr:lang code="ln" value="Lingala"/>
        <tr:lang code="lo" value="Lao"/>
        <tr:lang code="lt" value="Lithuanian"/>
        <tr:lang code="lu" value="Luba-Katanga"/>
        <tr:lang code="lv" value="Latvian"/>
        <tr:lang code="mg" value="Malagasy"/>
        <tr:lang code="mh" value="Marshallese"/>
        <tr:lang code="mi" value="Maori"/>
        <tr:lang code="mk" value="Macedonian"/>
        <tr:lang code="ml" value="Malayalam"/>
        <tr:lang code="mn" value="Mongolian"/>
        <tr:lang code="mr" value="Marathi"/>
        <tr:lang code="ms" value="Malay"/>
        <tr:lang code="mt" value="Maltese"/>
        <tr:lang code="my" value="Burmese"/>
        <tr:lang code="na" value="Nauru"/>
        <tr:lang code="nb" value="Bokmål, Norwegian; Norwegian Bokmål"/>
        <tr:lang code="nd" value="Ndebele, North; North Ndebele"/>
        <tr:lang code="ne" value="Nepali"/>
        <tr:lang code="ng" value="Ndonga"/>
        <tr:lang code="nl" value="Dutch; Flemish"/>
        <tr:lang code="nn" value="Norwegian Nynorsk; Nynorsk, Norwegian"/>
        <tr:lang code="no" value="Norwegian"/>
        <tr:lang code="nr" value="Ndebele, South; South Ndebele"/>
        <tr:lang code="nv" value="Navajo; Navaho"/>
        <tr:lang code="ny" value="Chichewa; Chewa; Nyanja"/>
        <tr:lang code="oc" value="Occitan (post 1500); Provençal"/>
        <tr:lang code="oj" value="Ojibwa"/>
        <tr:lang code="om" value="Oromo"/>
        <tr:lang code="or" value="Oriya"/>
        <tr:lang code="os" value="Ossetian; Ossetic"/>
        <tr:lang code="pa" value="Panjabi; Punjabi"/>
        <tr:lang code="pi" value="Pali"/>
        <tr:lang code="pl" value="Polish"/>
        <tr:lang code="ps" value="Pushto; Pashto"/>
        <tr:lang code="pt" value="Portuguese"/>
        <tr:lang code="qu" value="Quechua"/>
        <tr:lang code="rm" value="Romansh"/>
        <tr:lang code="rn" value="Rundi"/>
        <tr:lang code="ro" value="Romanian; Moldavian; Moldovan"/>
        <tr:lang code="ru" value="Russian"/>
        <tr:lang code="rw" value="Kinyarwanda"/>
        <tr:lang code="sa" value="Sanskrit"/>
        <tr:lang code="sc" value="Sardinian"/>
        <tr:lang code="sd" value="Sindhi"/>
        <tr:lang code="se" value="Northern Sami"/>
        <tr:lang code="sg" value="Sango"/>
        <tr:lang code="si" value="Sinhala; Sinhalese"/>
        <tr:lang code="sk" value="Slovak"/>
        <tr:lang code="sl" value="Slovenian"/>
        <tr:lang code="sm" value="Samoan"/>
        <tr:lang code="sn" value="Shona"/>
        <tr:lang code="so" value="Somali"/>
        <tr:lang code="sq" value="Albanian"/>
        <tr:lang code="sr" value="Serbian"/>
        <tr:lang code="ss" value="Swati"/>
        <tr:lang code="st" value="Sotho, Southern"/>
        <tr:lang code="su" value="Sundanese"/>
        <tr:lang code="sv" value="Swedish"/>
        <tr:lang code="sw" value="Swahili"/>
        <tr:lang code="ta" value="Tamil"/>
        <tr:lang code="te" value="Telugu"/>
        <tr:lang code="tg" value="Tajik"/>
        <tr:lang code="th" value="Thai"/>
        <tr:lang code="ti" value="Tigrinya"/>
        <tr:lang code="tk" value="Turkmen"/>
        <tr:lang code="tl" value="Tagalog"/>
        <tr:lang code="tn" value="Tswana"/>
        <tr:lang code="to" value="Tonga (Tonga Islands)"/>
        <tr:lang code="tr" value="Turkish"/>
        <tr:lang code="ts" value="Tsonga"/>
        <tr:lang code="tt" value="Tatar"/>
        <tr:lang code="tw" value="Twi"/>
        <tr:lang code="ty" value="Tahitian"/>
        <tr:lang code="ug" value="Uighur; Uyghur"/>
        <tr:lang code="uk" value="Ukrainian"/>
        <tr:lang code="ur" value="Urdu"/>
        <tr:lang code="uz" value="Uzbek"/>
        <tr:lang code="ve" value="Venda"/>
        <tr:lang code="vi" value="Vietnamese"/>
        <tr:lang code="vo" value="Volapük"/>
        <tr:lang code="wa" value="Walloon"/>
        <tr:lang code="wo" value="Wolof"/>
        <tr:lang code="xh" value="Xhosa"/>
        <tr:lang code="yi" value="Yiddish"/>
        <tr:lang code="yo" value="Yoruba"/>
        <tr:lang code="za" value="Zhuang; Chuang"/>
        <tr:lang code="zh" value="Chinese"/>
        <tr:lang code="zu" value="Zulu"/>
    </tr:langs>
</xsl:stylesheet>