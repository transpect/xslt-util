# format & indent

Requires Saxon 12.6+ because of an [`xsl:accumulator` issue](https://saxonica.plan.io/issues/6679).

## Invocation

There are examples on [format-indent-demo](https://github.com/gimsieke/format-indent-demo/). 

## Approach

The XSD or RNG schemas will be analyzed for elements that may contain non-whitespace text, including mixed content, and for elements that are declared whitespace-preserving.

The processing isn’t schema-aware in an XSLT sense. It is assumed that there is a single definition for an element (as is with DTDs), and this definition’s whitespace/text delcarations will be processed as follows:

We don’t support DTDs because they are hard to parse (ixml anyone?).

Multiple schema documents are supported mainly for XSD.

### Non-whitespace text permitted, including mixed content

The function is called `tr:is-mixed` (to be renamed to `tr:permits-non-ws-text`).

It checks the element definitions

- of XSD schemas
  - `xs:complexType/@mixed = 'true'`
  - or `@type = 'xs:string'`
- of RNG schemas
  - look for `mixed`, `text` or `data[@type = 'string']` in the include-expanded schema
  - then work your way up to the next element declaration, but stop if an attribute declaration comes first on the way up
  - when there is no element declaration, stop at the containing `define`, look for the `ref`s that refer to it and continue from these `ref`s to look upward for `element` declarations

TODO: We need to take care of namespaces, in particular when dealing with RNG schemas.
 
### Space preservation

- Explicit `xml:space="preserve"` in the content
- The element declaration contains a default attribute `xml:space="preserve"` 
  - XSD: tbd
  - RNG: `attribute[@name = 'xml:space'][@a:defaultValue = 'preserve']` (maybe a trang annotation?)
 