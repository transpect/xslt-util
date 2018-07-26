<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr="http://transpect.io"
  version="2.0">
  
  <!--  *
        * This function expects a file reference, cuts of the file extension and 
        * returns the mime-type. It's obvious that this method works only when 
        * the file extension corresponds to the real file type. 
        * -->
  
  <xsl:function name="tr:fileext-to-mime-type" as="xs:string">
    <xsl:param name="fileref" as="xs:string"/>
    <xsl:variable name="file-extension" select="lower-case(replace($fileref, '.*\.(.*?)(#.+)?$', '$1'))"/>
    <xsl:variable name="media-type" 
                  select="if(contains($file-extension, 'html')) then 'application/xhtml+xml' 
                     else if($file-extension eq 'gif')          then 'image/gif'
                     else if($file-extension eq 'jpg')          then 'image/jpeg'
                     else if($file-extension eq 'jpeg')         then 'image/jpeg'
                     else if($file-extension eq 'js')           then 'application/javascript'
                     else if($file-extension eq 'png')          then 'image/png'
                     else if($file-extension eq 'svg')          then 'image/svg+xml'
                     else if(contains($file-extension, 'tif'))  then 'image/tiff'
                     else if($file-extension eq 'eps')          then 'image/x-eps'
                     else if($file-extension eq 'ncx')          then 'application/x-dtbncx+xml' 
                     else if($file-extension eq 'otf')          then 'font/otf'
                     else if($file-extension eq 'eot')          then 'application/vnd.ms-fontobject'
                     else if($file-extension eq 'ttf')          then 'font/ttf'
                     else if($file-extension eq 'woff')         then 'font/woff'
                     else if($file-extension eq 'woff2')        then 'font/woff2' 
                     else if($file-extension eq 'smil')         then 'application/smil+xml' 
                     else if($file-extension eq 'pls')          then 'application/pls+xml'
                     else if($file-extension eq 'mp3')          then 'audio/mpeg'
                     else if($file-extension eq 'm4a')          then 'audio/mp4'
                     else if($file-extension eq 'css')          then 'text/css'
                     else if($file-extension eq 'js')           then 'text/javascript'
                     else if($file-extension eq 'xml')          then 'text/xml'
                     else if($file-extension eq 'xpgt')         then 'application/vnd.adobe-page-template+xml'
                     else if($file-extension = ('mpg','mp4'))   then 'video/mp4'
                     else concat('UNKNOWN/', $file-extension)" as="xs:string"/>
    <xsl:value-of select="$media-type"/>
  </xsl:function>
  
  <xsl:function name="tr:mime-type-to-fileext" as="xs:string?">
    <xsl:param name="media-type" as="xs:string?"/>
<!--    <xsl:variable name="media-type" select="lower-case(replace($fileref, '.*\.(.*)$', '$1'))"/>-->
<xsl:variable name="file-extension"
              select="if($media-type eq 'application/xhtml+xml')         then 'html'
                 else if($media-type eq 'text/html')                     then 'html'
                 else if($media-type eq 'image/gif')                     then 'gif'
                 else if($media-type eq 'image/jpeg')                    then 'jpg'
                 else if($media-type eq 'image/png')                     then 'png'
                 else if($media-type eq 'image/svg+xml')                 then 'svg'
                 else if($media-type eq 'image/tiff')                    then 'tif'
                 else if($media-type eq 'image/x-eps')                   then 'eps'
                 else if($media-type eq 'application/x-dtbncx+xml')      then 'ncx' 
                 else if($media-type eq 'application/vnd.ms-opentype', 
                                        'application/x-font-opentype',
                                        'font/otf')                      then 'otf'
                 else if($media-type eq 'application/vnd.ms-fontobject') then 'eot'
                 else if($media-type = ('application/x-font-truetype', 
                                        'application/x-font-ttf', 
                                        'font/ttf'))                     then 'ttf'
                 else if($media-type eq 'application/font-woff',
                                        'font/woff')                     then 'woff'
                 else if($media-type eq 'application/font-woff2',
                                        'font/woff2')                    then 'woff2'
                 else if($media-type eq 'application/smil+xml')          then 'smil' 
                 else if($media-type eq 'application/pls+xml')           then 'pls'
                 else if($media-type eq 'audio/mpeg')                    then 'mp3'
                 else if($media-type eq 'audio/mp4')                     then 'm4a'
                 else if($media-type eq 'text/css')                      then 'css'
                 else if($media-type eq 'text/js')                       then 'javascript'
                 else if($media-type eq 'text/xml')                      then 'xml'
                 else if($media-type eq 'video/mp4')                     then 'mp4'
                 else ''" as="xs:string"/>
    <xsl:value-of select="concat('.', $file-extension)"/>
  </xsl:function>
  
</xsl:stylesheet>
