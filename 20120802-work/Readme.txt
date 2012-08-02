In the 20120802-work directory, you can find :

- this Readme.txt file ;

- a directory named eac-cpf ; contains the current cpf.rng schema, and the same one with English and French documentation in it (cpf-documented.rng  file)

- a directory named odt-src; contains the EAC-CPF Tag Library French translation as an OpenDocumentFormat file (EAC-CPF2010TL-fr-2012-05-01-src.odt) and the files made by unzipping this ODT file (the content.xml file is used to convert this into a TEI file) 

- a directory named xsl ; it contains 4 XSLT  :
    - oldTagLib2newTagLib-FC.xsl : an XSLT to convert the current TEI English Tag Library into a TEI instance (consisting of lot of files) that validates against the new model. Based upon Terry Catapano's work, with small changes in it.
    - convertFrenchODTTagLibrary2TEI.xsl : an XSLT to convert the French translation of the Tag Library (content.xml file, see above) into a single TEI file compliant with the new model 
    - mergeEngAndFreTagLibraries.xsl : an XSLT to merge the new English Tag Library instance and the TEI French Tag Library into a single instance consisting of lot of files, that validates against the new model
    - integrateDocToRNGschema.xsl : an XSLT to integrate some parts of the Tag Library into the cpf.rng schema in order to build a documented schema (cpf-documented.rng, see above)
    
- a directory named tei ; it contains :
  - cpfTagLibrary-FC.xml : the current English Tag Library
  - cpfTagLibrary-eng-new.xml : the same content, compliant with the new TEI schema  (made with oldTagLib2newTagLib-FC.xsl) ; includes the files stored in the descriptions subdirectory
  - cpfTagLibrary-fre.xml : the TEI file made with convertFrenchODTTagLibrary2TEI.xsl from the content.xml file. As it is made, not valid
 -  cpfTagLibrary-fre-revised.xml : the same file, a few manual changes in order to get a valid file
 - cpfTagLibrary-multilingual.xml : the TEI file resulting from the merging of the English (cpfTagLibrary-eng-new.xml) and French (cpfTagLibrary-fre-revised.xml) files, made with  mergeEngAndFreTagLibraries.xsl ;  includes the files stored in the descriptions-multilingual subdirectory
 - EACCPF-TL-teiliteSchema.rng and the other EACCPF-TL-teiliteSchema*.* files : an RNG schema that can be used to validate all the TEI files. Comes with its ODD file and HTML documentation. Made with the ROMA application (http://www.tei-c.org/Roma/), based upon TEI Lite, + tag and egXML elements.
 
 In the descriptions and descriptions-multilingual directories, there are small XML files, that are valid against a schema named tagLibrary_elementDesc.rng. This RNG schema was made by Terry Catapano, we have changed a few lines in it.
 
Author: Florence Clavaud (member of French AFNOR EAD and EAC-CPF groups, 
member of SAA/SDT team)
Date :  August 2nd 2012