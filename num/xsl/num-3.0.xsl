<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs		= "http://www.w3.org/2001/XMLSchema"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:tr= "http://transpect.io"
  version="3.0">
  
  <!-- takes a sequence of integers and returns a map 
       with groups of adjacent numbers (n₂=n₁+1)-->
  
  <xsl:function name="tr:get-adjacent-integers-from-seq" as="map(xs:integer, xs:integer*)">
    <xsl:param name="seq" as="xs:integer*"/>
    <xsl:variable name="range" select="for $i in (min($seq) to max($seq)) return $i"/>
    <xsl:map>
      <xsl:for-each-group select="$range" group-adjacent="exists(index-of($seq, .))">
        <xsl:map-entry key="position()" select="current-group()[current-grouping-key()]"/>
      </xsl:for-each-group>
    </xsl:map>
  </xsl:function>

</xsl:stylesheet>