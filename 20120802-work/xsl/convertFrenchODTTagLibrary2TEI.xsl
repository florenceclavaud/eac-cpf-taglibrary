<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0"
  exclude-result-prefixes="office style text table draw fo dc
  meta number tei svg chart dr3d math form
  script ooo ooow oooc dom xd xforms xs xsd xsi " office:version="1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
  xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
  xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
  xmlns:ooo="http://openoffice.org/2004/office" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
  xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
  xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> August 2nd, 2012</xd:p>
      <xd:p><xd:b>Author</xd:b> Florence Clavaud</xd:p>
      <xd:p>Stylesheet to convert the French translation of EAC-CPF Tag Library, that existed only as an OpenDocumentFormat (odt) file, into a single TEI file that could be validated against the prepared TEI schema and whose structure can
        compare with the one of the English file.</xd:p>
      <xd:p>To be used once. Any change in this French translation should be made in the TEI file now.</xd:p>
      <xd:p>Based upon styles used in the ODT file. Maybe could be reused for other comparable files.</xd:p>
      <xd:p>The resulting file must be corrected (a few errors, about eiht or ten, only).</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:variable name="styles" select="/office:document-content/office:automatic-styles"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="/">
    <!-- PI in order to associate the resulting file with the ad hoc schema -->
    <xsl:processing-instruction name="xml-model">
      <xsl:text>href="EACCPF-TL-teiliteSchema.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
    </xsl:processing-instruction>
    <xsl:apply-templates select="office:document-content/office:body"/>
  </xsl:template>
  <xsl:template match="/office:document-content/office:body">
    <TEI>
      <!-- teiHeader : here, we have typed it directly in the XSLT, its quicker and easier -->
      <teiHeader>
        <fileDesc>
          <titleStmt>
            <title xml:lang="eng">Encoded Archival Context—Corporate Bodies, Persons, and Families (EAC-CPF)</title>
            <title xml:lang="eng" type="part2">Tag Library</title>
            <title xml:lang="fre">Contexte archivistique encodé Collectivités, personnes et familles (EAC-CPF)</title>
            <title xml:lang="fre" type="part2">Dictionnaire des balises</title>
            <respStmt xml:lang="eng">
              <resp>Prepared and maintained by the </resp>
              <name>Encoded Archival Context Working Group (EACWG) of the Society of American Archivists</name>
            </respStmt>
            <respStmt xml:lang="fre">
              <resp>Elaboré par </resp>
              <name>le groupe de travail sur le Contexte archivistique encodé (EACWG) de la Society of American Archivists</name>
            </respStmt>
            <respStmt xml:lang="fre">
              <resp>Maintenu par </resp>
              <name>la Staatsbibliothek zu Berlin</name>
            </respStmt>
            <respStmt xml:lang="fre">
              <resp>traduit de l’anglais par</resp>
              <name>le groupe AFNOR CG/46/CN357/GE4</name>
            </respStmt>
          </titleStmt>
          <editionStmt>
            <p xml:lang="eng">Draft</p>
            <p xml:lang="fre">version provisoire, mai 2012</p>
          </editionStmt>
          <publicationStmt>
            <publisher xml:lang="eng">Society of American Archivists in collaboration with Staatsbibliothek zu Berlin.</publisher>
            <date when="2010"/>
          </publicationStmt>
          <sourceDesc>
            <p xml:lang="eng">Born digital.</p>
            <p xml:lang="fre">Nativement numérique</p>
          </sourceDesc>
        </fileDesc>
      </teiHeader>
      <text xml:lang="fre">
        <xsl:apply-templates select="office:text" mode="text"/>
      </text>
    </TEI>
  </xsl:template>
  <!-- the text element macrostructure -->
  <xsl:template match="/office:document-content/office:body/office:text" mode="text">
    <front>
      <!-- front : the first div is a French addition, typed -->
      <div>
        <head>Composition du groupe des traducteurs, membres du AFNOR CG46/CN357/GE4</head>
        <p>CG 46 Information et documentation (président : Pierre Fuzeau)</p>
        <p>CN 357 Modélisation, production et accès aux documents (présidente : Françoise Bourdon)</p>
        <p>GE 4 Données d'autorité (animatrice : Anila Angjeli)</p>
        <list>
          <item>Anila Angjeli (Bibliothèque nationale de France)</item>
          <item>Vincent Boulet (Bibliothèque nationale de France)</item>
          <item>Florence Clavaud (École nationale des chartes)</item>
          <item>Danis Habib (Archives nationales)</item>
          <item>Aline Locker (Bibliothèque nationale de France)</item>
          <item>Denise Ogilvie (Archives nationales)</item>
          <item>Florent Palluault (Ministère de la culture et de la communication / Service du livre et de la lecture)</item>
          <item>Claire Sibille (Ministère de la culture et de la communication / Service interministériel des archives de France)</item>
          <item>Sébastien Studer (Ministère de la culture et de la communication / Service interministériel des archives de France)</item>
          <item>Pascal Tanésie (Archives nationales)</item>
        </list>
      </div>
      <xsl:for-each-group select="*[preceding-sibling::text:table-of-content and following-sibling::text:p[normalize-space(.)='Éléments']]"
        group-starting-with="descendant::text:p[@text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacTitre1']/@style:name or @text:style-name='eacTitre1']">
        <div>
          <head>
            <xsl:apply-templates select="."/>
          </head>
          <xsl:for-each-group select="current-group() except ." group-starting-with="text:p[@text:style-name='eacTitres' or @text:style-name='eacNomBalise']">
            <xsl:apply-templates select="current-group()" mode="front"/>
          </xsl:for-each-group>
        </div>
      </xsl:for-each-group>
    </front>
    <body>
      <xsl:for-each-group select="*[preceding-sibling::text:p[normalize-space(.)='Éléments']]"
        group-starting-with="descendant::text:p[@text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacTitre1']/@style:name or @text:style-name='eacTitre1']">
        <xsl:variable name="type">
          <xsl:choose>
            <xsl:when test="starts-with(normalize-space(.),'&lt;abbreviation&gt;')">element</xsl:when>
            <xsl:otherwise>attribute</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:if test="following::text:span[normalize-space(.)='Correspondance']">
          <div>
            <xsl:attribute name="type" select="concat($type, 's')"/>
            <xsl:for-each-group select="current-group()" group-starting-with="text:p[@text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacNomBalise']/@style:name or @text:style-name='eacNomBalise']">
              <xsl:variable name="gi">
                <xsl:choose>
                  <xsl:when test="$type='element'">
                    <xsl:value-of select="substring-after(substring-before(normalize-space(.), '&gt;'), '&lt;')"/>
                  </xsl:when>
                  <xsl:when test="$type='attribute'">
                    <xsl:value-of select="replace(substring-after(normalize-space(.),  '@'), ':', '')"/>
                  </xsl:when>
                </xsl:choose>
              </xsl:variable>
              <xsl:if test="normalize-space(.) !='Attributs'">
                <div xml:id="{$gi}">
                  <xsl:attribute name="type">
                    <xsl:value-of select="concat($type, 'Documentation')"/>
                  </xsl:attribute>
                  <xsl:apply-templates select="current-group()" mode="body">
                    <xsl:with-param name="type" select="$type"/>
                    <xsl:with-param name="gi" select="$gi"/>
                  </xsl:apply-templates>
                </div>
              </xsl:if>
            </xsl:for-each-group>
          </div>
        </xsl:if>
      </xsl:for-each-group>
    </body>
    <back>
      <div type="appendix" xml:id="crosswalk-fre">
        <head>Correspondance ISAAR(CPF) – EAC-CPF</head>
        <xsl:apply-templates select="*[preceding::text:span[normalize-space(.)='Correspondance']]" mode="back"/>
      </div>
    </back>
  </xsl:template>
  <!-- generating front element -->
  <xsl:template match="text:p[@text:style-name='eacTitres']" mode="front">
    <list>
      <head>
        <xsl:apply-templates mode="front"/>
      </head>
      <xsl:apply-templates select="following-sibling::text:list[1]" mode="liste"/>
    </list>
  </xsl:template>
  <xsl:template mode="front" match="text:p[@text:style-name='eacNomBalise']">
    <xsl:variable name="nextEacNomBaliseId" select="generate-id(following-sibling::text:p[@text:style-name='eacNomBalise'][1])"/>
    <div>
      <head>
        <xsl:apply-templates mode="front"/>
      </head>
      <xsl:apply-templates select="following-sibling::text:p[following-sibling::text:p[generate-id()=$nextEacNomBaliseId]]" mode="intro"/>
    </div>
  </xsl:template>
  <xsl:template mode="intro" match="text:p[@text:style-name='eacExemple']">
    <xsl:if test="normalize-space(.)=''">
      <egXML xmlns="http://www.tei-c.org/ns/Examples">
        <xsl:apply-templates mode="ex"/>
        <xsl:apply-templates mode="ex" select="following-sibling::text:p[@text:style-name='eacExemple' and following-sibling::text:p[normalize-space(.)='Éléments']]"/>
      </egXML>
    </xsl:if>
  </xsl:template>
  <xsl:template mode="front" match="text:list | text:p[@text:style-name='eacExemple']"/>
  
  <xsl:template match="text:p[@text:style-name='eacTexte' or @text:style-name='P12']" mode="front">
    <xsl:if test="not(preceding-sibling::text:p[normalize-space(.)='Vue d’ensemble de la structure et de la sémantique de l’EAC-CPF'])">
      <p>
        <xsl:apply-templates mode="front"/>
      </p>
    </xsl:if>
  </xsl:template>
  <xsl:template match="text:p[@text:style-name='eacTexte' or @text:style-name='P12']" mode="intro">
    <p>
      <xsl:apply-templates mode="front"/>
    </p>
  </xsl:template>
  <xsl:template mode="liste" match="text:list">
    <xsl:apply-templates mode="liste" select="text:list-item/text:p"/>
  </xsl:template>
  <xsl:template match="text:list-item/text:p" mode="liste">
    <item>
      <xsl:apply-templates mode="front"/>
    </item>
  </xsl:template>
  <!-- generating the body-->
  <xsl:template mode="body" match="text:p[@text:style-name='eacNomBalise' or @text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacNomBalise']/@style:name]">
    <xsl:param name="type"/>
    <xsl:param name="gi"/>
    <head>
      <xsl:choose>
        <xsl:when test="$type='element'">
          <gi>
            <xsl:value-of select="$gi"/>
          </gi>
        </xsl:when>
        <xsl:when test="$type='attribute'">
          <att>
            <xsl:value-of select="$gi"/>
          </att>
        </xsl:when>
      </xsl:choose>
    </head>
    <xsl:if test="$type='element'">
      <div type="fullName">
        <p>
          <xsl:value-of select="child::text()[preceding-sibling::text:tab]"/>
        </p>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template match="table:table" mode="body">
    <xsl:param name="gi"/>
    <xsl:param name="type"/>
    <xsl:apply-templates mode="body">
      <xsl:with-param name="gi" select="$gi"/>
      <xsl:with-param name="type" select="$type"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="table:table-row" mode="body">
    <xsl:param name="type"/>
    <xsl:param name="gi"/>
    <xsl:if test="count(table:table-cell)=2">
      <xsl:variable name="label" select="normalize-space(table:table-cell[1])"/>
      <div>
        <xsl:attribute name="type">
          <xsl:choose>
            <xsl:when test="starts-with($label, 'Résumé')">summary</xsl:when>
            <xsl:when test="starts-with($label, 'Peut contenir')">mayContain</xsl:when>
            <xsl:when test="starts-with($label, 'Peut être contenu dans')">mayOccurWithin</xsl:when>
            <xsl:when test="starts-with($label, 'Attributs')">attributes</xsl:when>
            <xsl:when test="starts-with($label, 'Occurrence')">occurrence</xsl:when>
            <xsl:when test="starts-with($label, 'Référence')">reference</xsl:when>
            <xsl:when test="starts-with($label, 'Type de données')">datatype</xsl:when>
            <xsl:when test="starts-with($label, 'Valeurs possibles')">values</xsl:when>
            <xsl:when test="starts-with($label, 'Valeur :')">values</xsl:when>
          </xsl:choose>
        </xsl:attribute>
        <p>
          <xsl:apply-templates select="table:table-cell[2]" mode="body">
            <xsl:with-param name="gi" select="$gi"/>
            <xsl:with-param name="type" select="$type"/>
          </xsl:apply-templates>
        </p>
      </div>
    </xsl:if>
    <xsl:if test="starts-with(normalize-space(table:table-cell[1]), 'Attributs')">
      <div type="attributes">
        <p>
          <list type="gloss">
            <label>
              <xsl:value-of select="table:table-cell[2]"/>
            </label>
            <item>
              <xsl:value-of select="table:table-cell[3]"/>
            </item>
            <xsl:for-each select="following-sibling::table:table-row[normalize-space(table:table-cell[1])='']">
              <label>
                <xsl:value-of select="table:table-cell[2]"/>
              </label>
              <item>
                <xsl:value-of select="table:table-cell[3]"/>
              </item>
            </xsl:for-each>
          </list>
        </p>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template
    match="text:p[@text:style-name='eacTitres']| text:p[@text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacTitres']/@style:name] | text:p[@text:style-name='P13' and starts-with(normalize-space(.), 'Exemple')]"
    mode="body">
    <xsl:param name="gi"/>
    <xsl:param name="type"/>
    <xsl:variable name="pId" select="generate-id()"/>
    <xsl:choose>
      <xsl:when test="starts-with(normalize-space(.), 'Description')">
        <div type="description">
          <xsl:apply-templates
            select="following-sibling::text:p[@text:style-name='eacTexte'][generate-id(preceding-sibling::text:p[@text:style-name='eacTitres' or @text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacTitres']/@style:name][1])=$pId] | following-sibling::text:list[generate-id(preceding-sibling::text:p[@text:style-name='eacTitres' or @text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacTitres']/@style:name][1])=$pId]"
            mode="desc"/>
        </div>
      </xsl:when>
      <xsl:when test="starts-with(normalize-space(.), 'Exemple')">
        <div type="examples">
          <egXML xmlns="http://www.tei-c.org/ns/Examples">
            <xsl:for-each
              select="following-sibling::text:p[@text:style-name='eacExemple' or @text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacExemple']/@style:name or @text:style-name='Fin_5f_élément'][generate-id(preceding-sibling::text:p[@text:style-name='eacTitres' or @text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacTitres']/@style:name or  text:p[@text:style-name='P13' and starts-with(normalize-space(.), 'Exemple')]][1])=$pId]">
              <xsl:apply-templates mode="ex"/>
            </xsl:for-each>
          </egXML>
        </div>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*" mode="ex">
    <xsl:choose>
      <xsl:when test="normalize-space(.)=''"/>
      <xsl:when test="child::text() and count(child::node())=1">
        <xsl:text> </xsl:text>
        <xsl:value-of select="." disable-output-escaping="yes"/>
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:when test="not(child::text())">
        <xsl:apply-templates mode="ex"/>
      </xsl:when>
      <xsl:when test="child::text() and count(child::node())>1">
        <xsl:text> </xsl:text>
        <xsl:value-of select="." disable-output-escaping="yes"/>
        <xsl:text> </xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="text:p[@text:style-name='eacTexte']" mode="desc">
    <p>
      <xsl:apply-templates mode="body"> </xsl:apply-templates>
    </p>
  </xsl:template>
  <xsl:template
    match="text:p[@text:style-name='eacExemple'  or @text:style-name='Fin_5f_élément' or @text:style-name=$styles/descendant::style:style[@style:parent-style-name='eacExemple']/@style:name]| text:list | text:p[@text:style-name='eacTexte']"
    mode="body"/>
  <xsl:template match="text:list" mode="desc">
    <list>
      <xsl:apply-templates select="text:list-item" mode="desc"> </xsl:apply-templates>
    </list>
  </xsl:template>
  <xsl:template match="text:list-item" mode="desc">
    <item>
      <xsl:apply-templates mode="desc"/>
    </item>
  </xsl:template>
  <!-- processing text nodes : creating gi and att attributes -->
  <xsl:template match="text()" mode="body desc front back">
    <xsl:analyze-string select="." regex="(&lt;)(\w+)(&gt;)">
      <xsl:matching-substring>
        <gi>
          <xsl:value-of select="regex-group(2)"/>
        </gi>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:analyze-string select="." regex="(@)(\w+:?\w+)">
          <xsl:matching-substring>
            <att>
              <xsl:value-of select="regex-group(2)"/>
            </att>
          </xsl:matching-substring>
          <xsl:non-matching-substring>
            <xsl:value-of select="."/>
          </xsl:non-matching-substring>
        </xsl:analyze-string>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>
  <!-- generating the back (crosswalk) -->
  <xsl:template match="table:table" mode="back">
    <table>
      <xsl:for-each select="table:table-row">
        <row>
          <xsl:for-each select="table:table-cell">
            <cell>
              <xsl:apply-templates mode="back"/>
            </cell>
          </xsl:for-each>
        </row>
      </xsl:for-each>
    </table>
  </xsl:template>
</xsl:stylesheet>
