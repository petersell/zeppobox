<?xml version='1.0'?>
 
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    xmlns:exsl="http://exslt.org/common"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    extension-element-prefixes="exsl"
    exclude-result-prefixes="opentopic exslf opentopic-func ot-placeholder"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    version="2.0">
  
    <xsl:variable name="map" select="//opentopic:map"/>
    
    <xsl:template name="createMetadata">
    <rx:meta-info>
      <xsl:variable name="title" as="xs:string?">
        <xsl:apply-templates select="." mode="dita-ot:title-metadata"/>
      </xsl:variable>
      <xsl:if test="exists($title)">
        <rx:meta-field name="title" value="{$title}"/>
      </xsl:if>
         <rx:meta-field name="author" value="Andreas Petersell"/>
                 <rx:meta-field name="creator" value="petersell.com"/>
                 <rx:meta-field name="title" value="Baukastensystem oder Puzzle?"/>
                 <rx:meta-field name="subject" value="Das Baukastenprinzip bei Plastikstecksteinen"/>
                 <rx:meta-field name="keywords" value="Baukastensystem, Puzzle, Stecksteine, PeBe, Spielzeug, DDR-Spielzeug"/>
                 <rx:meta-field name="publisher" value="petersell.com"/>
    </rx:meta-info>
  </xsl:template>
    
    <!-- START - Logo und Titel auf Inhaltsverzeichnis -->
    <!-- createTocHeader von toc.xsl -->
   <xsl:template name="createTocHeader">
   <!-- external-graphic von front-matter.xsl --> 
        <fo:block text-align="center" width="100%">
          <fo:external-graphic src="url({concat($artworkPrefix, 'Customization/OpenTopic/common/artwork/artikelbild-4.gif')})"/>              
        </fo:block>
        <!-- Titel von front-matter_1.0.xsl - section "set the title" -->
        <!-- attribute-set __frontmatter__on__toc neu angelegt -->
                    <fo:block xsl:use-attribute-sets="__frontmatter__on__toc">
                        <xsl:choose>
                            <xsl:when test="$map/*[contains(@class,' topic/title ')][1]">
                                <xsl:apply-templates select="$map/*[contains(@class,' topic/title ')][1]"/>
                            </xsl:when>
                            <xsl:when test="$map//*[contains(@class,' bookmap/mainbooktitle ')][1]">
                                <xsl:apply-templates select="$map//*[contains(@class,' bookmap/mainbooktitle ')][1]"/>
                            </xsl:when>
                            <xsl:when test="//*[contains(@class, ' map/map ')]/@title">
                                <xsl:value-of select="//*[contains(@class, ' map/map ')]/@title"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="/descendant::*[contains(@class, ' topic/topic ')][1]/*[contains(@class, ' topic/title ')]"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
   <!-- START Wort INHALT ein/aus -->
        <!-- <fo:block xsl:use-attribute-sets="__toc__header" id="{$id.toc}">
            <xsl:call-template name="insertVariable">
                <xsl:with-param name="theVariableID" select="'Table of Contents'"/>
            </xsl:call-template>
        </fo:block> -->
    <!-- ENDE Wort INHALT ein/aus -->    
    </xsl:template>
     <!-- ENDE - Logo und Titel auf Inhaltsverzeichnis -->
     
     <!-- START Inhaltsverzeichnis auf ditamap -->
     <xsl:attribute-set name="__toc__topic__content">
        <xsl:attribute name="last-line-end-indent">-22pt</xsl:attribute>
        <xsl:attribute name="end-indent">22pt</xsl:attribute>
        <xsl:attribute name="text-indent">-.2in</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="text-align-last">justify</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">12pt</xsl:when>
                <xsl:otherwise>10pt</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="font-weight">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">bold</xsl:when>
                <xsl:otherwise>normal</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="margin-top">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">1em</xsl:when>
                <xsl:otherwise>0em</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>
     <!-- ENDE Inhaltsverzeichnis auf ditamap -->
    
    <!-- START titel_con (Titelei vor Impressum) zentriert -->   
 <xsl:template match="*[contains(@class, ' topic/p ')]">
<xsl:choose>
<xsl:when test="@otherprops='center'">
<fo:block xsl:use-attribute-sets="center">
<xsl:apply-templates/>
</fo:block>
</xsl:when>
<xsl:when test="@otherprops='center-big'">
<fo:block xsl:use-attribute-sets="center-big">
<xsl:apply-templates/>
</fo:block>
</xsl:when>
<xsl:when test="@otherprops='center-small'">
<fo:block xsl:use-attribute-sets="center-small">
<xsl:apply-templates/>
</fo:block>
</xsl:when>
<xsl:otherwise>
<fo:block xsl:use-attribute-sets="p" id="{@id}">
<xsl:apply-templates/>
</fo:block>
</xsl:otherwise>
</xsl:choose>
</xsl:template>
<!-- ENDE titel_con zentriert -->
</xsl:stylesheet>

