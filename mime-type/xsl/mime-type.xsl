<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr="http://transpect.io"
  version="2.0">
  
  <xsl:import href="http://transpect.io/xslt-util/paths/xsl/paths.xsl"/>
  
  <!--  *
        * This function expects a file reference, cuts of the file extension and 
        * returns the mime-type. It's obvious that this method works only when 
        * the file extension corresponds to the real file type. 
        * -->
  
  <xsl:variable name="mime-types" as="element(mime)+">
    <mime type="application/epub+zip" ext="epub"/>
    <mime type="application/javascript" ext="js"/>
    <mime type="application/json" ext="json"/>
    <mime type="application/msword" ext="doc"/>
    <mime type="application/oebps-package+xml" ext="opf"/>
    <mime type="application/pdf" ext="pdf"/>
    <mime type="application/pls+xml" ext="pls"/>
    <mime type="application/smil+xml" ext="smil"/>
    <mime type="application/vnd.adobe-page-template+xml" ext="xpgt"/>
    <mime type="application/vnd.ms-excel" ext="xls"/>
    <mime type="application/vnd.ms-fontobject" ext="eot"/>
    <mime type="application/vnd.ms-opentype" ext="otf"/>
    <mime type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" ext="xlsx"/>
    <mime type="application/vnd.openxmlformats-officedocument.wordprocessingml.document" ext="docx"/>
    <mime type="application/x-dtbncx+xml" ext="ncx"/>
    <mime type="application/xhtml+xml" ext="html xhtml"/>
    <mime type="audio/aac" ext="aac"/>
    <mime type="audio/mp4" ext="m4a"/>
    <mime type="audio/mpeg" ext="mp3"/>
    <mime type="audio/webm" ext="weba"/>
    <mime type="audio/wav" ext="wav"/>
    <mime type="font/ttf" ext="ttf"/>
    <mime type="font/woff" ext="woff"/>
    <mime type="font/woff" ext="woff2"/>
    <mime type="image/bmp" ext="bmp"/>
    <mime type="image/gif" ext="gif"/>
    <mime type="image/jpeg" ext="jpg jpeg"/>
    <mime type="image/png" ext="png"/>
    <mime type="image/svg+xml" ext="svg"/>
    <mime type="image/tiff" ext="tif tiff"/>
    <mime type="image/x-eps" ext="eps"/>
    <mime type="text/css" ext="css"/>
    <mime type="text/csv" ext="csv"/>
    <mime type="text/xml" ext="xml"/>
    <mime type="text/plain" ext="txt"/>
    <mime type="video/mp4" ext="mp4 mpg"/>
    <mime type="video/webm" ext="webm"/>
  </xsl:variable>
  
  <xsl:function name="tr:fileref-to-mime-type" as="xs:string">
    <xsl:param name="path" as="xs:string"/>
    <xsl:sequence select="tr:ext-to-mime-type(lower-case(tr:ext($path)))"/>
  </xsl:function>
  
  <xsl:function name="tr:ext-to-mime-type" as="xs:string">
    <xsl:param name="ext" as="xs:string"/>
    <xsl:sequence select="$mime-types[tokenize(@ext, '\s') = lower-case($ext)]/@type"/>
  </xsl:function>
  
  <xsl:function name="tr:mime-type-to-fileext" as="xs:string?">
    <xsl:param name="media-type" as="xs:string?"/>
    <xsl:sequence select="tokenize($mime-types[@type eq $media-type]/@ext, '\s')[1]"/>
  </xsl:function>
  
</xsl:stylesheet>
