<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:tr="http://transpect.io"
  xmlns="http://docbook.org/ns/docbook"
  version="1.0" 
  name="normalize-calstables"
  type="tr:normalize-calstables">
  
  <p:input port="source"/>
  <p:output port="result"/>
    
  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>
  
  <p:documentation>Rowspans and Colspans are dissolved and filled with empty cells. 
    This facilitates the conversion of CALS tables to LaTeX tabular tables. The graphic 
    below gives an example:
    
    -------------------             -------------------
    |  A  |  B        |             |  A  |  B  |  b  |
    -     -           -             -------------------
    |     |           |     -->     |  a  |  b  |  b  |
    -------------------             -------------------
    |  C  |  D        |             |  C  |  D  |  d  |
    -------------------             -------------------
    
  </p:documentation>
  
  <p:choose>
      
    <p:when test="//*:informaltable[.//*:informaltable[.//*:entry[@morerows or @namest]] or .//*:table[.//*:entry[@morerows or @namest]]]
                 |//*:table[.//*:informaltable[.//*:entry[@morerows or @namest]] or .//*:table[.//*:entry[@morerows or @namest]]]">
      
      <!-- resolve 1st tables without nested tables -->
      
      <p:viewport match="//*:informaltable[ancestor::*:informaltable and not(.//*:informaltable)][.//*:entry[@morerows or @namest]]
                        |//*:table[(ancestor::*:informaltable|ancestor::*:table) and not(.//*:informaltable|.//*:table)][.//*:entry[@morerows or @namest]]">
        
        <p:xslt name="normalize-calstables-xslt">
          <p:input port="stylesheet">
            <p:document href="../xsl/call-normalize.xsl"/>
          </p:input>
          <p:input port="parameters">
            <p:empty/>
          </p:input>
        </p:xslt>
        
      </p:viewport>
      
      <tr:normalize-calstables/>
      
    </p:when>
    <p:otherwise>
                
      <p:viewport match="//*:informaltable|//*:table">
        
        <p:xslt name="normalize-calstables-xslt">
          <p:input port="stylesheet">
            <p:document href="../xsl/call-normalize.xsl"/>
          </p:input>
          <p:input port="parameters">
            <p:empty/>
          </p:input>
        </p:xslt>
        
      </p:viewport>
      
    </p:otherwise>
  </p:choose>
            
</p:declare-step>