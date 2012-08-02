<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="xd tei xi eg xlink xsi" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:eg="http://www.tei-c.org/ns/Examples" version="2.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  
  >
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> August 2nd, 2012</xd:p>
      <xd:p><xd:b>Author</xd:b> Florence Clavaud</xd:p>
      <xd:p>Stylesheet to merge the TEI English Tag Library (instance in several files) and the TEI French one (existing in a single file).</xd:p>
      <xd:p>The resulting XML instance includes several files, like the initial English one. It is valid against the prepared schema.</xd:p>
      
      <xd:p>Maybe this stylesheet could be reused for other comparable files.</xd:p>
      
    </xd:desc>
  </xd:doc>
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:variable name="frenchText" select="document('../tei/cpfTagLibrary-fre-revised.xml')/tei:TEI"/>
  <xsl:variable name="path">
    <xsl:value-of select="concat('../tei/descriptions/','?select=*.xml;recurse=yes;on-error=warning')"/>
  </xsl:variable>
  <xsl:variable name="engDescFiles" select="collection($path)"/>
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
  <xsl:template match="tei:teiHeader">
    <teiHeader>
    <xsl:apply-templates select="$frenchText/tei:teiHeader/node()"/>
      </teiHeader>
  </xsl:template>
  <xsl:template match="tei:front">
    <front>
      <titlePage xml:lang="eng">
        <xsl:apply-templates select="tei:titlePage/node()"/>
      </titlePage>
      <div xml:lang="eng" type="EnglishIntroduction">
        <xsl:apply-templates select="tei:div"/>
      </div>
      <div xml:lang="fre" type="FrenchIntroduction">
        <xsl:apply-templates select="$frenchText/tei:text/tei:front/node()"/>
      </div>
    </front>
  </xsl:template>
  <xsl:template match="tei:back">
    <back>
      <div xml:id="appendix-eng" type="appendix" xml:lang="eng">
        <xsl:apply-templates select="tei:div/node()"/>
      </div>
      <div xml:id="appendix-fre" type="appendix" xml:lang="fre">
        <xsl:apply-templates select="$frenchText/tei:text/tei:back/tei:div/node()"/>
      </div>
    </back>
  </xsl:template>
  
  <xsl:template match="eg:egXML/descendant-or-self::*/@*">
    <xsl:attribute name="{name()}">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:attribute>
  </xsl:template>

 
  <xsl:template match="tei:body">
    <body>
      <div type="elements">
        <xsl:for-each select="$engDescFiles/tei:div[starts-with(@type, 'element')]">
          <xsl:variable name="id" select="@xml:id"/>
         
          <xsl:variable name="type">
            <xsl:choose>
              <xsl:when test="starts-with(@type, 'element')">elem</xsl:when>
              <xsl:when test="starts-with(@type, 'attribute')">attr</xsl:when>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="outputUrl">
            <xsl:value-of select="concat('../tei/descriptions-multilingual/', $type, '-', $id, '.xml')"/>
          </xsl:variable>
          <xsl:variable name="filename" select="concat('./descriptions-multilingual/', $type, '-', $id, '.xml')"/>
          <xi:include xmlns:xi="http://www.w3.org/2001/XInclude">
            <xsl:attribute name="href">
              <xsl:value-of select="$filename"/>
            </xsl:attribute>
            <xsl:attribute name="parse">xml</xsl:attribute>
          </xi:include>
          <xsl:result-document href="{$outputUrl}" exclude-result-prefixes="xd tei xi eg xlink">
            <xsl:processing-instruction name="xml-model">
              <xsl:text>href="tagLibrary_elementDesc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
            </xsl:processing-instruction>
            <div xml:id="{$id}" type="{@type}">
              <xsl:apply-templates select="tei:head"/>
              <xsl:apply-templates select="tei:div" mode="desc">
                <xsl:with-param name="id" select="$id"/>
              </xsl:apply-templates>
            </div>
           
          </xsl:result-document>
        </xsl:for-each>
      </div>
      <div type="attributes">
        <xsl:for-each select="$engDescFiles/tei:div[starts-with(@type, 'attribute')]">
          <xsl:variable name="id" select="@xml:id"/>
          
          <xsl:variable name="type">
            <xsl:choose>
              <xsl:when test="starts-with(@type, 'element')">elem</xsl:when>
              <xsl:when test="starts-with(@type, 'attribute')">attr</xsl:when>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="outputUrl">
            <xsl:value-of select="concat('../tei/descriptions-multilingual/', $type, '-', $id, '.xml')"/>
          </xsl:variable>
          <xsl:variable name="filename" select="concat('./descriptions-multilingual/', $type, '-', $id, '.xml')"/>
          <xi:include xmlns:xi="http://www.w3.org/2001/XInclude">
            <xsl:attribute name="href">
              <xsl:value-of select="$filename"/>
            </xsl:attribute>
            <xsl:attribute name="parse">xml</xsl:attribute>
          </xi:include>
          <xsl:result-document href="{$outputUrl}" exclude-result-prefixes="xd tei xi eg xlink xsi">
            <xsl:processing-instruction name="xml-model">
              <xsl:text>href="tagLibrary_elementDesc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
            </xsl:processing-instruction>
            <div xml:id="{$id}" type="{@type}">
              <xsl:apply-templates select="tei:head"/>
              <xsl:apply-templates select="tei:div" mode="desc">
                <xsl:with-param name="id" select="$id"/>
              </xsl:apply-templates>
            </div>
            
          </xsl:result-document>
        </xsl:for-each>
      </div>
    </body>
  </xsl:template>
 <xsl:template match="tei:div[@type='mayContain'] | tei:div[@type='mayOccurWithin'] | tei:div[@type='occurrence'] | tei:div[@type='reference']" mode="desc">
   <xsl:apply-templates select="."/>
 </xsl:template>
  <xsl:template match="tei:div[@type='fullName']" mode="desc">
    <xsl:param name="id"/>
    <div type="fullName">
      <xsl:copy-of select="child::tei:p"/>
      <xsl:if test="$frenchText/descendant::tei:div[@xml:id=$id and child::tei:div[@type='fullName']]">
        <p xml:lang="fre">
          <xsl:apply-templates select="$frenchText/descendant::tei:div[@xml:id=$id]/child::tei:div[@type='fullName']/tei:p/node()" />
        </p>
      </xsl:if>
    </div>
  </xsl:template>
  <xsl:template match="tei:div[@type='summary']" mode="desc">
    <xsl:param name="id"/>
    <div type="summary">
      <xsl:apply-templates select="tei:p"/>
      <xsl:if test="$frenchText/descendant::tei:div[@xml:id=$id and child::tei:div[@type='summary']]">
        <p xml:lang="fre">
          <xsl:apply-templates select="$frenchText/descendant::tei:div[@xml:id=$id]/child::tei:div[@type='summary']/child::tei:p/node()" />
        </p>
      </xsl:if>
    </div>
  </xsl:template>
  <xsl:template match="tei:div[@type='description']" mode="desc">
    <xsl:param name="id"/>
    <div type="description" xml:lang="eng">
      <xsl:for-each select="tei:p">
        <p>
          <xsl:apply-templates select="node()"/>
        </p>
      </xsl:for-each>
    </div>
    <xsl:if test="$frenchText/descendant::tei:div[@xml:id=$id and child::tei:div[@type='description']]">
      <div type="description" xml:lang="fre">
        <xsl:apply-templates select="$frenchText/descendant::tei:div[@xml:id=$id]/child::tei:div[@type='description']/child::tei:p" />
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:div[@type='attributes']" mode="desc">
    <xsl:param name="id"/>
    <div type="attributes">
      <xsl:apply-templates select="tei:p"/>
      <xsl:if test="$frenchText/descendant::tei:div[@xml:id=$id and child::tei:div[@type='attributes']]">
        <p xml:lang="fre">
          <xsl:apply-templates select="$frenchText/descendant::tei:div[@xml:id=$id]/child::tei:div[@type='attributes']/tei:p/node()" />
        </p>
      </xsl:if>
    </div>
  </xsl:template>
  <xsl:template match="tei:div[@type='examples']" mode="desc">
    <xsl:param name="id"/>
    <div type="examples">
      <xsl:apply-templates select="node()"/>
      <xsl:if test="$frenchText/descendant::tei:div[@xml:id=$id and child::tei:div[@type='examples']]">
       <!-- <p xml:lang="fre">-->
        <xsl:apply-templates select="$frenchText/descendant::tei:div[@xml:id=$id]/child::tei:div[@type='examples']/node()" />
      <!--  </p>-->
      </xsl:if>
    </div>
  </xsl:template>
  <xsl:template match="tei:div[@type='datatype']" mode="desc">
    <xsl:param name="id"/>
    <div type="datatype" xml:lang="eng">
      <xsl:for-each select="tei:p">
        <p>
          <xsl:apply-templates select="node()"/>
        </p>
      </xsl:for-each>
    </div>
    <xsl:if test="$frenchText/descendant::tei:div[@xml:id=$id and child::tei:div[@type='datatype']]">
      <div type="datatype" xml:lang="fre">
        <xsl:apply-templates select="$frenchText/descendant::tei:div[@xml:id=$id]/child::tei:div[@type='datatype']/child::tei:p" />
      </div>
    </xsl:if>
    <xsl:if test="$frenchText/descendant::tei:div[@xml:id=$id and child::tei:div[@type='values']]">
      <div type="values" xml:lang="fre">
        <xsl:apply-templates select="$frenchText/descendant::tei:div[@xml:id=$id]/child::tei:div[@type='values']/child::tei:p" />
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
