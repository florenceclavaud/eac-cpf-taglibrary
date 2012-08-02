<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd tei teiEg xi eg" xmlns:teiEg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:eg="http://www.tei-c.org/ns/Examples" version="2.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:xi="http://www.w3.org/2001/XInclude">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 16, 2012</xd:p>
            <xd:p><xd:b>Author:</xd:b> Terry Catapano</xd:p>
            <xd:p><xd:b>Revisions on:</xd:b> August 2nd, 2012</xd:p>
            <xd:p><xd:b>Revisions by</xd:b> Florence Clavaud</xd:p>
            <xd:p>Stylesheet to extract element and attribute descriptions from existing EAC-CPF tag library (i.e, "cpfTagLibrary.xml") as standalone documents converting resulting documents to proposed TEI-based encoding</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model">
            <xsl:text>href="EACCPF-TL-teiliteSchema.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
        </xsl:processing-instruction>
        <!-- output a TEI root element with relevant namespace declarations -->
        <!--  <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:eac-cpf="urn:isbn:1-931666-33-4"
            xmlns:exml="http://workaround for xml namespace restriction/namespace"
            xmlns:xlink="http://www.w3c.org/1999/xlink"
            xmlns:xi="http://www.w3.org/2003/XInclude">-->
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:eac-cpf="urn:isbn:1-931666-33-4" xmlns:xlink="http://www.w3c.org/1999/xlink">
         
            <!-- copy teiHeader -->
            <teiHeader>
                <!-- <xsl:copy-of select="/tei:TEI/tei:teiHeader/node()" copy-namespaces="no"/>-->
                <xsl:apply-templates select="/tei:TEI/tei:teiHeader/node()" mode="copy"/>
            </teiHeader>
            <!--<xsl:copy-of select="/tei:TEI/tei:teiHeader" exclude-result-prefixes="#all"/>-->
            <!-- output text element -->
            <text>
                <!-- copy front -->
                <front>
                    <!--  <xsl:copy-of select="/tei:TEI/tei:text/tei:front/node()" copy-namespaces="no"/>-->
                    <xsl:apply-templates select="/tei:TEI/tei:text/tei:front/node()" mode="copy"/>
                </front>
                <!--  <xsl:copy-of select="/tei:TEI/tei:text/tei:front"  exclude-result-prefixes="#all"/>-->
                <body>
                    <!-- process <div>'s in <body>. i.e., element and attribute descriptions -->
                    <div type="elements">
                        <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'elements']/tei:div"/>
                    </div>
                    <div type="attributes">
                        <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'attributes']/tei:div"/>
                    </div>
                </body>
                <!-- copy back -->
                <back>
                    <!--<xsl:copy-of select="/tei:TEI/tei:text/tei:back/node()" copy-namespaces="no"/>-->
                    <xsl:apply-templates select="/tei:TEI/tei:text/tei:back/node()" mode="copy"/>
                </back>
                <!--  <xsl:copy-of select="/tei:TEI/tei:text/tei:back"  exclude-result-prefixes="#all"/>-->
            </text>
        </TEI>
    </xsl:template>
    <!-- FC a basic template for teiHeader, front and back. Copies everything -->
    <xsl:template match="node()  | @*" mode="copy">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="copy"/>
            <xsl:apply-templates mode="copy"/>
        </xsl:copy>
    </xsl:template>
    <!-- FC  egXMLs in front -->
    <xsl:template match="teiEg:egXML" mode="copy">
        <egXML xmlns="http://www.tei-c.org/ns/Examples">
            <xsl:apply-templates mode="copy"/>
        </egXML>
    </xsl:template>
    <xsl:template match="tei:div">
        <xsl:variable name="filename" select="concat('./descriptions/', substring(@type, 1, 4), '-', @xml:id, '.xml')"/>
        <!--output xinclude reference for each element and attribute description -->
        <!-- FC add xmlns and parse attributes -->
        <xi:include xmlns:xi="http://www.w3.org/2001/XInclude">
            <xsl:attribute name="href">
                <xsl:value-of select="$filename"/>
            </xsl:attribute>
            <xsl:attribute name="parse">xml</xsl:attribute>
        </xi:include>
        <xsl:variable name="outputUrl">
            <xsl:value-of select="concat('../tei/descriptions/', substring(@type, 1, 4), '-', @xml:id, '.xml')"/>
        </xsl:variable>
        <!-- <xsl:call-template name="descDiv"/> -->
        <!--output document for each element and attribute description -->
        <!-- <xsl:result-document href="{$filename}" exclude-result-prefixes="#all" omit-xml-declaration="yes">-->
        <xsl:result-document href="{$outputUrl}" exclude-result-prefixes="#all">
            <!-- <xsl:element name="div" namespace="http://saa-sdt.org/tagLibrary/elementDesc/"> -->
            <!-- FC add PI to enable validation against the Tag Library descriptions schema -->
            <xsl:processing-instruction name="xml-model">
                <xsl:text>href="tagLibrary_elementDesc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
            </xsl:processing-instruction>
            <!--<xsl:element name="div" inherit-namespaces="no">-->
          
            <div xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">
                    <!-- change a few type attribute values -->
                    <xsl:for-each select="@type">
                        <xsl:choose>
                            <xsl:when test=". = 'element'">
                                <xsl:text>elementDocumentation</xsl:text>
                            </xsl:when>
                            <xsl:when test=". = 'attribute'">
                                <xsl:text>attributeDocumentation</xsl:text>
                            </xsl:when>
                          <!--  <xsl:when test=". = 'mayOccurIn'">
                                <xsl:text>mayOccurWithin</xsl:text>
                            </xsl:when>-->
                            <xsl:otherwise>
                                <xsl:copy/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:attribute>
                <xsl:copy-of select="@* except @type "/>
                <!-- get name of element from head[@type = 'tag'] -->
                <!-- FC add @type='attribute'-->
                <xsl:apply-templates select="tei:head[@type = 'tag' or @type='attribute']"/>
                <!-- FC add head[@type='name'] -->
                <xsl:apply-templates select="tei:head[@type='name']"/>
                <!-- process list containing description sections -->
                <xsl:apply-templates select="tei:list"/>
            </div>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="tei:head[@type = 'tag' or @type='attribute']">
        <head>
            <xsl:apply-templates/>
        </head>
       <!--FC <div type="fullName">
            <!-\- FC use eng, better than en -\->
            <p xml:lang="eng">
                <xsl:apply-templates select="parent::tei:div/tei:head[@type = 'name']"/>
            </p>
        </div>-->
    </xsl:template>
    <xsl:template match="tei:head[@type = 'name']">
        <div type="fullName">
            <p xml:lang="eng"> <xsl:value-of select="normalize-space(.)"/></p>
        </div>
       <!-- <xsl:value-of select="normalize-space(.)"/>-->
    </xsl:template>
    <xsl:template match="tei:list">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- convert description sections from <item> to <div> -->
    <xsl:template match="tei:item">
        <xsl:element name="div">
            <xsl:attribute name="type">
                <!-- change a few type attribute values -->
                <xsl:choose>
                    <xsl:when test="@n = 'mayOccurIn'">
                        <xsl:text>mayOccurWithin</xsl:text>
                    </xsl:when>
                    <xsl:when test="descendant::teiEg:egXML">
                        <xsl:text>examples</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@n"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
                <!-- convert <p> in tei namespace to xml:lang <p> elements in no namespace-->
                <xsl:when test="child::tei:p">
                    <xsl:for-each select="child::tei:p">
                        <!-- FC use eng, better than en -->
                        <p xml:lang="eng">
                            <xsl:apply-templates/>
                        </p>
                    </xsl:for-each>
                </xsl:when>
                <!-- convert lists to <p xml:lang="en"> containing list[@type = 'gloss'] -->
                <xsl:when test="tei:list">
                    <!-- FC use eng, better than en -->
                    <p xml:lang="eng">
                        <xsl:apply-templates select="tei:list" mode="gloss"/>
                    </p>
                </xsl:when>
                <xsl:when test="teiEg:egXML">
                
                    <egXML xmlns="http://www.tei-c.org/ns/Examples">
                        <xsl:copy-of select="teiEg:egXML/*" copy-namespaces="no"/>
                    </egXML>
                </xsl:when>
                <!-- convert tei:item to <p xml:lang="en" -->
                <xsl:when test="@n = 'summary'">
                    <!-- FC : use eng, better than en -->
                    <p xml:lang="eng">
                        <xsl:apply-templates/>
                    </p>
                </xsl:when>
                <xsl:when test="@n = 'description' and ancestor::tei:div[@type = 'attribute']">
                    <!--FC : use eng, better than en -->
                    <p xml:lang="eng">
                        <xsl:apply-templates/>
                    </p>
                </xsl:when>
                <!-- all other tei:items convert to <p> -->
                <xsl:otherwise>
                    <p>
                        <xsl:apply-templates/>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <!-- convert <tag> to <gi> -->
    <xsl:template match="tei:tag" mode="#all">
        <gi>
            <xsl:apply-templates/>
        </gi>
    </xsl:template>
    
    <!-- convert <att> in TEI namespace to <att> in no namespace -->
    <xsl:template match="tei:att">
        <att>
            <xsl:apply-templates/>
        </att>
    </xsl:template>
    <!-- templates for lists in mode "gloss"; i.e., attributes section -->
    <xsl:template match="tei:list" mode="gloss">
        <list type="gloss">
            <xsl:apply-templates mode="gloss"/>
        </list>
    </xsl:template>
    <xsl:template match="tei:label" mode="gloss">
        <label>
            <xsl:apply-templates/>
        </label>
    </xsl:template>
    <xsl:template match="tei:item" mode="gloss">
        <item>
            <xsl:apply-templates/>
        </item>
    </xsl:template>
</xsl:stylesheet>
