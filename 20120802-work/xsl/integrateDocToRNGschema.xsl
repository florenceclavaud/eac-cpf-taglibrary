<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="eac-cpf xd tei xi eg xsi rng" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:eg="http://www.tei-c.org/ns/Examples" version="2.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://relaxng.org/ns/structure/1.0"
  xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xml="http://www.w3.org/XML/1998/namespace"
  xmlns:eac-cpf="urn:isbn:1-931666-33-4">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> August 2nd, 2012</xd:p>
      <xd:p><xd:b>Author</xd:b> Florence Clavaud</xd:p>
      <xd:p>Stylesheet to integrate the summaries and descriptions of each element and attribute (in the TEI multilingual TL) into the RNG schema.</xd:p>
      <xd:p>The resulting RNG schema is documented, so that, for instance, you can read this documentation as a contextual help when you type an EAC-CPF instance.</xd:p>
      <xd:p>Could be enhanced, for instance using XHTML in the RNG schema.</xd:p>
      <xd:p>Same thing could be done for the W3C XML schema.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:variable name="multilTL" select="document('../tei/cpfTagLibrary-multilingual.xml')/tei:TEI"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="node()  | @*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rng:element[@name] | rng:attribute[@name]">
    <xsl:variable name="name" select="replace(normalize-space(@name), ':', '')"/>
    
    <xsl:element name="{name()}">
      <xsl:copy-of select="@*"/>
      <xsl:if test="$multilTL/descendant::tei:div[ lower-case(@xml:id)=$name]">
        <xsl:if test="$multilTL/descendant::tei:div[ lower-case(@xml:id)=$name]/tei:div[@type='summary']/tei:p[@xml:lang='eng']">
          <a:documentation xml:lang="eng">
            <xsl:apply-templates select="$multilTL/descendant::tei:div[ lower-case(@xml:id)=$name]/tei:div[@type='summary']/tei:p[@xml:lang='eng']/node()" mode="text"/>
          </a:documentation>
        </xsl:if>
        <xsl:if test="$multilTL/descendant::tei:div[ lower-case(@xml:id)=$name]/tei:div[@type='summary']/tei:p[@xml:lang='fre']">
          <a:documentation xml:lang="fre">
            <xsl:apply-templates select="$multilTL/descendant::tei:div[ lower-case(@xml:id)=$name]/tei:div[@type='summary']/tei:p[@xml:lang='fre']/node()" mode="text"/>
          </a:documentation>
        </xsl:if>
        <xsl:if test="$multilTL/descendant::tei:div[ lower-case(@xml:id)=$name]/tei:div[@type='description' and @xml:lang='eng']">
          <a:documentation xml:lang="eng">
            <xsl:apply-templates select="$multilTL/descendant::tei:div[ lower-case(@xml:id)=$name]/tei:div[@type='description' and @xml:lang='eng']/node()" mode="text"/>
          </a:documentation>
        </xsl:if>
        <xsl:if test="$multilTL/descendant::tei:div[ lower-case(@xml:id)=$name]/tei:div[@type='description' and @xml:lang='fre']">
          <a:documentation xml:lang="fre">
            <xsl:apply-templates select="$multilTL/descendant::tei:div[ lower-case(@xml:id)=$name]/tei:div[@type='description' and @xml:lang='fre']/node()" mode="text"/>
          </a:documentation>
        </xsl:if>
      </xsl:if>
      <xsl:apply-templates select="node()"/>
    </xsl:element>
   
  </xsl:template>
  <xsl:template match="tei:p" mode="text">
    <xsl:apply-templates mode="text"/>
  </xsl:template>
  <xsl:template match="tei:gi" mode="text">
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>&gt;</xsl:text>
   
  </xsl:template>
  <xsl:template match="tei:att" mode="text">
    <xsl:text>@</xsl:text>
    <xsl:value-of select="."/>
  </xsl:template>
</xsl:stylesheet>
