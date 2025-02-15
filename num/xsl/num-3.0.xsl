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
  
 <xsl:function name="tr:int-to-roman" as="xs:string">
    <xsl:param name="num" as="xs:integer"/>
    <xsl:sequence select="
         if($num  ge 1000) then 'M'  || tr:int-to-roman($num - 1000) else 
         if($num  ge  900) then 'CM' || tr:int-to-roman($num -  900) else
         if($num  ge  500) then 'D'  || tr:int-to-roman($num -  500) else
         if($num  ge  400) then 'CD' || tr:int-to-roman($num -  400) else
         if($num  ge  100) then 'C'  || tr:int-to-roman($num -  100) else
         if($num  ge   90) then 'XC' || tr:int-to-roman($num -   90) else
         if($num  ge   50) then 'L'  || tr:int-to-roman($num -   50) else
         if($num  ge   40) then 'XL' || tr:int-to-roman($num -   40) else
         if($num  ge   10) then 'X'  || tr:int-to-roman($num -   10) else
         if($num  ge    9) then 'IX' || tr:int-to-roman($num -    9) else
         if($num  ge    5) then 'V'  || tr:int-to-roman($num -    5) else
         if($num  ge    4) then 'IV' || tr:int-to-roman($num -    4) else
         if($num  ge    1) then 'I'  || tr:int-to-roman($num -    1) else ''"/>
 </xsl:function>
  
</xsl:stylesheet>