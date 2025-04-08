<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:tr="http://transpect.io"
  version="1.0" 
  name="undo-format-indent"
  type="tr:undo-format-indent">
  
  <p:input port="source" primary="true">
    <p:documentation>Your XML document.</p:documentation>
  </p:input>
  
  <p:output port="result">
    <p:documentation>Your XML document, without indentations.</p:documentation>
  </p:output>
  
  <p:option name="schema-uris">
    <p:documentation>The schema document(s). Whitespace separated list of absolute paths.</p:documentation>
  </p:option>

  <p:xslt name="undo-format-indent-xsl">
    <p:input port="stylesheet">
      <p:document href="../xsl/undo-format-indent.xsl"/>
    </p:input>
    <p:with-param name="schema-uris" select="$schema-uris"/>
  </p:xslt>

</p:declare-step>