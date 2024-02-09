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
    <xsl:param name="lang" as="xs:string"/>
    <xsl:sequence select="some $i in document('')//tr:langs/tr:lang satisfies $i/@code eq $lang"/>
  </xsl:function>
  
  <xsl:function name="tr:lang-is-ltr" as="xs:boolean">
    <xsl:param name="lang" as="xs:string"/>
    <xsl:sequence select="$lang = document('')//tr:langs/tr:lang[@dir eq 'ltr']/@code"/>
  </xsl:function>
  
  <xsl:function name="tr:lang-is-rtl" as="xs:boolean">
    <xsl:param name="lang" as="xs:string"/>
    <xsl:sequence select="$lang = document('')//tr:langs/tr:lang[@dir eq 'rtl']/@code"/>
  </xsl:function>
  
  <xsl:function name="tr:lang-dir" as="xs:string">
    <xsl:param name="lang" as="xs:string"/>
    <xsl:sequence select="document('')//tr:langs/tr:lang[$lang eq @code]/@dir"/>
  </xsl:function>
  
  <xsl:function name="tr:iso639-2-lang-to-iso639-1-lang" as="xs:string?">
    <xsl:param name="lang" as="xs:string"/>
    <xsl:sequence select="document('')//tr:langs/tr:lang[$lang = tokenize(@alt, '\s')]/@code"/>
  </xsl:function>
  
  <xsl:function name="tr:iso639-1-lang-to-iso639-2-lang" as="xs:string*">
    <xsl:param name="lang" as="xs:string"/>
    <xsl:sequence select="tokenize(document('')//tr:langs/tr:lang[$lang = @code]/@alt, '\s')"/>
  </xsl:function>
  
  <tr:langs>
    <tr:lang code="alpha2" dir="ltr" value="English"/>
    <tr:lang code="ab" dir="ltr" alt="abk" value="Abkhazian"/>
    <tr:lang code="aa" dir="ltr" alt="aar" value="Afar"/>
    <tr:lang code="af" dir="ltr" alt="afr" value="Afrikaans"/>
    <tr:lang code="ak" dir="ltr" alt="aka" value="Akan"/>
    <tr:lang code="sq" dir="ltr" alt="sqi alb" value="Albanian"/>
    <tr:lang code="am" dir="ltr" alt="amh" value="Amharic"/>
    <tr:lang code="ar" dir="rtl" alt="ara" value="Arabic"/>
    <tr:lang code="an" dir="ltr" alt="arg" value="Aragonese"/>
    <tr:lang code="hy" dir="ltr" alt="hye arm" value="Armenian"/>
    <tr:lang code="as" dir="ltr" alt="asm" value="Assamese"/>
    <tr:lang code="av" dir="ltr" alt="ava" value="Avaric"/>
    <tr:lang code="ae" dir="ltr" alt="ave" value="Avestan"/>
    <tr:lang code="ay" dir="ltr" alt="aym" value="Aymara"/>
    <tr:lang code="az" dir="ltr" alt="aze" value="Azerbaijani"/>
    <tr:lang code="bm" dir="ltr" alt="bam" value="Bambara"/>
    <tr:lang code="ba" dir="ltr" alt="bak" value="Bashkir"/>
    <tr:lang code="eu" dir="ltr" alt="eus baq" value="Basque"/>
    <tr:lang code="be" dir="ltr" alt="bel" value="Belarusian"/>
    <tr:lang code="bn" dir="ltr" alt="ben" value="Bengali"/>
    <tr:lang code="bi" dir="ltr" alt="bis" value="Bislama"/>
    <tr:lang code="bs" dir="ltr" alt="bos" value="Bosnian"/>
    <tr:lang code="br" dir="ltr" alt="bre" value="Breton"/>
    <tr:lang code="bg" dir="ltr" alt="bul" value="Bulgarian"/>
    <tr:lang code="my" dir="ltr" alt="mya bur" value="Burmese"/>
    <tr:lang code="ca" dir="ltr" alt="cat" value="Catalan, Valencian"/>
    <tr:lang code="ch" dir="ltr" alt="cha" value="Chamorro"/>
    <tr:lang code="ce" dir="ltr" alt="che" value="Chechen"/>
    <tr:lang code="ny" dir="ltr" alt="nya" value="Chichewa, Chewa, Nyanja"/>
    <tr:lang code="zh" dir="ltr" alt="zho chi" value="Chinese"/>
    <tr:lang code="cu" dir="ltr" alt="chu" value="Church Slavonic, Old Slavonic, Old Church Slavonic"/>
    <tr:lang code="cv" dir="ltr" alt="chv" value="Chuvash"/>
    <tr:lang code="kw" dir="ltr" alt="cor" value="Cornish"/>
    <tr:lang code="co" dir="ltr" alt="cos" value="Corsican"/>
    <tr:lang code="cr" dir="ltr" alt="cre" value="Cree"/>
    <tr:lang code="hr" dir="ltr" alt="hrv" value="Croatian"/>
    <tr:lang code="cs" dir="ltr" alt="ces cze" value="Czech"/>
    <tr:lang code="da" dir="ltr" alt="dan" value="Danish"/>
    <tr:lang code="dv" dir="rtl" alt="div" value="Divehi, Dhivehi, Maldivian"/>
    <tr:lang code="nl" dir="ltr" alt="nld dut" value="Dutch, Flemish"/>
    <tr:lang code="dz" dir="ltr" alt="dzo" value="Dzongkha"/>
    <tr:lang code="en" dir="ltr" alt="eng" value="English"/>
    <tr:lang code="eo" dir="ltr" alt="epo" value="Esperanto"/>
    <tr:lang code="et" dir="ltr" alt="est" value="Estonian"/>
    <tr:lang code="ee" dir="ltr" alt="ewe" value="Ewe"/>
    <tr:lang code="fo" dir="ltr" alt="fao" value="Faroese"/>
    <tr:lang code="fj" dir="ltr" alt="fij" value="Fijian"/>
    <tr:lang code="fi" dir="ltr" alt="fin" value="Finnish"/>
    <tr:lang code="fr" dir="ltr" alt="fra fre" value="French"/>
    <tr:lang code="fy" dir="ltr" alt="fry" value="Western Frisian"/>
    <tr:lang code="ff" dir="ltr" alt="ful" value="Fulah"/>
    <tr:lang code="gd" dir="ltr" alt="gla" value="Gaelic, Scottish Gaelic"/>
    <tr:lang code="gl" dir="ltr" alt="glg" value="Galician"/>
    <tr:lang code="lg" dir="ltr" alt="lug" value="Ganda"/>
    <tr:lang code="ka" dir="ltr" alt="kat geo" value="Georgian"/>
    <tr:lang code="de" dir="ltr" alt="deu ger" value="German"/>
    <tr:lang code="el" dir="ltr" alt="ell gre" value="Greek, Modern (1453–)"/>
    <tr:lang code="kl" dir="ltr" alt="kal" value="Kalaallisut, Greenlandic"/>
    <tr:lang code="gn" dir="ltr" alt="grn" value="Guarani"/>
    <tr:lang code="gu" dir="ltr" alt="guj" value="Gujarati"/>
    <tr:lang code="ht" dir="ltr" alt="hat" value="Haitian, Haitian Creole"/>
    <tr:lang code="ha" dir="rtl" alt="hau" value="Hausa"/>
    <tr:lang code="he" dir="rtl" alt="heb" value="Hebrew"/>
    <tr:lang code="hz" dir="ltr" alt="her" value="Herero"/>
    <tr:lang code="hi" dir="ltr" alt="hin" value="Hindi"/>
    <tr:lang code="ho" dir="ltr" alt="hmo" value="Hiri Motu"/>
    <tr:lang code="hu" dir="ltr" alt="hun" value="Hungarian"/>
    <tr:lang code="is" dir="ltr" alt="isl ice" value="Icelandic"/>
    <tr:lang code="io" dir="ltr" alt="ido" value="Ido"/>
    <tr:lang code="ig" dir="ltr" alt="ibo" value="Igbo"/>
    <tr:lang code="id" dir="ltr" alt="ind" value="Indonesian"/>
    <tr:lang code="ia" dir="ltr" alt="ina" value="Interlingua (International Auxiliary Language Association)"/>
    <tr:lang code="ie" dir="ltr" alt="ile" value="Interlingue, Occidental"/>
    <tr:lang code="iu" dir="ltr" alt="iku" value="Inuktitut"/>
    <tr:lang code="ik" dir="ltr" alt="ipk" value="Inupiaq"/>
    <tr:lang code="ga" dir="ltr" alt="gle" value="Irish"/>
    <tr:lang code="it" dir="ltr" alt="ita" value="Italian"/>
    <tr:lang code="ja" dir="ltr" alt="jpn" value="Japanese"/>
    <tr:lang code="jv" dir="ltr" alt="jav" value="Javanese"/>
    <tr:lang code="kn" dir="ltr" alt="kan" value="Kannada"/>
    <tr:lang code="kr" dir="ltr" alt="kau" value="Kanuri"/>
    <tr:lang code="ks" dir="rtl" alt="kas" value="Kashmiri"/>
    <tr:lang code="kk" dir="ltr" alt="kaz" value="Kazakh"/>
    <tr:lang code="km" dir="ltr" alt="khm" value="Central Khmer"/>
    <tr:lang code="ki" dir="ltr" alt="kik" value="Kikuyu, Gikuyu"/>
    <tr:lang code="rw" dir="ltr" alt="kin" value="Kinyarwanda"/>
    <tr:lang code="ky" dir="ltr" alt="kir" value="Kirghiz, Kyrgyz"/>
    <tr:lang code="kv" dir="ltr" alt="kom" value="Komi"/>
    <tr:lang code="kg" dir="ltr" alt="kon" value="Kongo"/>
    <tr:lang code="ko" dir="ltr" alt="kor" value="Korean"/>
    <tr:lang code="kj" dir="ltr" alt="kua" value="Kuanyama, Kwanyama"/>
    <tr:lang code="ku" dir="rtl" alt="kur" value="Kurdish"/>
    <tr:lang code="lo" dir="ltr" alt="lao" value="Lao"/>
    <tr:lang code="la" dir="ltr" alt="lat" value="Latin"/>
    <tr:lang code="lv" dir="ltr" alt="lav" value="Latvian"/>
    <tr:lang code="li" dir="ltr" alt="lim" value="Limburgan, Limburger, Limburgish"/>
    <tr:lang code="ln" dir="ltr" alt="lin" value="Lingala"/>
    <tr:lang code="lt" dir="ltr" alt="lit" value="Lithuanian"/>
    <tr:lang code="lu" dir="ltr" alt="lub" value="Luba-Katanga"/>
    <tr:lang code="lb" dir="ltr" alt="ltz" value="Luxembourgish, Letzeburgesch"/>
    <tr:lang code="mk" dir="ltr" alt="mkd mac" value="Macedonian"/>
    <tr:lang code="mg" dir="ltr" alt="mlg" value="Malagasy"/>
    <tr:lang code="ms" dir="ltr" alt="msa may" value="Malay"/>
    <tr:lang code="ml" dir="ltr" alt="mal" value="Malayalam"/>
    <tr:lang code="mt" dir="ltr" alt="mlt" value="Maltese"/>
    <tr:lang code="gv" dir="ltr" alt="glv" value="Manx"/>
    <tr:lang code="mi" dir="ltr" alt="mri mao" value="Maori"/>
    <tr:lang code="mr" dir="ltr" alt="mar" value="Marathi"/>
    <tr:lang code="mh" dir="ltr" alt="mah" value="Marshallese"/>
    <tr:lang code="mn" dir="ltr" alt="mon" value="Mongolian"/>
    <tr:lang code="na" dir="ltr" alt="nau" value="Nauru"/>
    <tr:lang code="nv" dir="ltr" alt="nav" value="Navajo, Navaho"/>
    <tr:lang code="nd" dir="ltr" alt="nde" value="North Ndebele"/>
    <tr:lang code="nr" dir="ltr" alt="nbl" value="South Ndebele"/>
    <tr:lang code="ng" dir="ltr" alt="ndo" value="Ndonga"/>
    <tr:lang code="ne" dir="ltr" alt="nep" value="Nepali"/>
    <tr:lang code="no" dir="ltr" alt="nor" value="Norwegian"/>
    <tr:lang code="nb" dir="ltr" alt="nob" value="Norwegian Bokmål"/>
    <tr:lang code="nn" dir="ltr" alt="nno" value="Norwegian Nynorsk"/>
    <tr:lang code="ii" dir="ltr" alt="iii" value="Sichuan Yi, Nuosu"/>
    <tr:lang code="oc" dir="ltr" alt="oci" value="Occitan"/>
    <tr:lang code="oj" dir="ltr" alt="oji" value="Ojibwa"/>
    <tr:lang code="or" dir="ltr" alt="ori" value="Oriya"/>
    <tr:lang code="om" dir="ltr" alt="orm" value="Oromo"/>
    <tr:lang code="os" dir="ltr" alt="oss" value="Ossetian, Ossetic"/>
    <tr:lang code="pi" dir="ltr" alt="pli" value="Pali"/>
    <tr:lang code="ps" dir="rtl" alt="pus" value="Pashto, Pushto"/>
    <tr:lang code="fa" dir="rtl" alt="fas per" value="Persian"/>
    <tr:lang code="pl" dir="ltr" alt="pol" value="Polish"/>
    <tr:lang code="pt" dir="ltr" alt="por" value="Portuguese"/>
    <tr:lang code="pa" dir="ltr" alt="pan" value="Punjabi, Panjabi"/>
    <tr:lang code="qu" dir="ltr" alt="que" value="Quechua"/>
    <tr:lang code="ro" dir="ltr" alt="ron rum" value="Romanian, Moldavian, Moldovan"/>
    <tr:lang code="rm" dir="ltr" alt="roh" value="Romansh"/>
    <tr:lang code="rn" dir="ltr" alt="run" value="Rundi"/>
    <tr:lang code="ru" dir="ltr" alt="rus" value="Russian"/>
    <tr:lang code="se" dir="ltr" alt="sme" value="Northern Sami"/>
    <tr:lang code="sm" dir="ltr" alt="smo" value="Samoan"/>
    <tr:lang code="sg" dir="ltr" alt="sag" value="Sango"/>
    <tr:lang code="sa" dir="ltr" alt="san" value="Sanskrit"/>
    <tr:lang code="sc" dir="ltr" alt="srd" value="Sardinian"/>
    <tr:lang code="sr" dir="ltr" alt="srp" value="Serbian"/>
    <tr:lang code="sn" dir="ltr" alt="sna" value="Shona"/>
    <tr:lang code="sd" dir="ltr" alt="snd" value="Sindhi"/>
    <tr:lang code="si" dir="ltr" alt="sin" value="Sinhala, Sinhalese"/>
    <tr:lang code="sk" dir="ltr" alt="slk slo" value="Slovak"/>
    <tr:lang code="sl" dir="ltr" alt="slv" value="Slovenian"/>
    <tr:lang code="so" dir="ltr" alt="som" value="Somali"/>
    <tr:lang code="st" dir="ltr" alt="sot" value="Southern Sotho"/>
    <tr:lang code="es" dir="ltr" alt="spa" value="Spanish, Castilian"/>
    <tr:lang code="su" dir="ltr" alt="sun" value="Sundanese"/>
    <tr:lang code="sw" dir="ltr" alt="swa" value="Swahili"/>
    <tr:lang code="ss" dir="ltr" alt="ssw" value="Swati"/>
    <tr:lang code="sv" dir="ltr" alt="swe" value="Swedish"/>
    <tr:lang code="tl" dir="ltr" alt="tgl" value="Tagalog"/>
    <tr:lang code="ty" dir="ltr" alt="tah" value="Tahitian"/>
    <tr:lang code="tg" dir="ltr" alt="tgk" value="Tajik"/>
    <tr:lang code="ta" dir="ltr" alt="tam" value="Tamil"/>
    <tr:lang code="tt" dir="ltr" alt="tat" value="Tatar"/>
    <tr:lang code="te" dir="ltr" alt="tel" value="Telugu"/>
    <tr:lang code="th" dir="ltr" alt="tha" value="Thai"/>
    <tr:lang code="bo" dir="ltr" alt="bod tib" value="Tibetan"/>
    <tr:lang code="ti" dir="ltr" alt="tir" value="Tigrinya"/>
    <tr:lang code="to" dir="ltr" alt="ton" value="Tonga (Tonga Islands)"/>
    <tr:lang code="ts" dir="ltr" alt="tso" value="Tsonga"/>
    <tr:lang code="tn" dir="ltr" alt="tsn" value="Tswana"/>
    <tr:lang code="tr" dir="ltr" alt="tur" value="Turkish"/>
    <tr:lang code="tk" dir="ltr" alt="tuk" value="Turkmen"/>
    <tr:lang code="tw" dir="ltr" alt="twi" value="Twi"/>
    <tr:lang code="ug" dir="ltr" alt="uig" value="Uighur, Uyghur"/>
    <tr:lang code="uk" dir="ltr" alt="ukr" value="Ukrainian"/>
    <tr:lang code="ur" dir="rtl" alt="urd" value="Urdu"/>
    <tr:lang code="uz" dir="ltr" alt="uzb" value="Uzbek"/>
    <tr:lang code="ve" dir="ltr" alt="ven" value="Venda"/>
    <tr:lang code="vi" dir="ltr" alt="vie" value="Vietnamese"/>
    <tr:lang code="vo" dir="ltr" alt="vol" value="Volapük"/>
    <tr:lang code="wa" dir="ltr" alt="wln" value="Walloon"/>
    <tr:lang code="cy" dir="ltr" alt="cym wel" value="Welsh"/>
    <tr:lang code="wo" dir="ltr" alt="wol" value="Wolof"/>
    <tr:lang code="xh" dir="ltr" alt="xho" value="Xhosa"/>
    <tr:lang code="yi" dir="rtl" alt="yid" value="Yiddish"/>
    <tr:lang code="yo" dir="ltr" alt="yor" value="Yoruba"/>
    <tr:lang code="za" dir="ltr" alt="zha" value="Zhuang, Chuang"/>
    <tr:lang code="zu" dir="ltr" alt="zul" value="Zulu"/>
  </tr:langs>
  
</xsl:stylesheet>