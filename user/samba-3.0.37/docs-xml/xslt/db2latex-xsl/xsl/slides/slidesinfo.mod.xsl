<?xml version='1.0'?>
<!--############################################################################# 
|	$Id: //WIFI_SOC/release/SDK_4_1_0_0/source/user/samba-3.0.37/docs-xml/xslt/db2latex-xsl/xsl/slides/slidesinfo.mod.xsl#1 $
|- #############################################################################
|	$Author: bruce.chang $
|														
|   PURPOSE:
+ ############################################################################## -->

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
    exclude-result-prefixes="doc" version='1.0'>



<xsl:template match="slidesinfo">
<xsl:text>%--------------------------------------------------SLIDES INFORMATION&#10;</xsl:text>
<xsl:text>\title{{\black </xsl:text>
<xsl:apply-templates select="title"/>
<xsl:text>}}&#10;</xsl:text>
<xsl:text>\subtitle{{\black </xsl:text>
<xsl:apply-templates select="titleabbrev"/>
<xsl:text>}}&#10;</xsl:text>
<xsl:text>\author{{\black </xsl:text>
<xsl:apply-templates select="author|authorgroup"/>
<xsl:text>}}&#10;</xsl:text>
<xsl:text>
</xsl:text>
<xsl:text>\renewcommand{\slideparindent}{0mm}&#10;</xsl:text>
</xsl:template>




<xsl:template match="slidesinfo/title|slidesinfo/titleabbrev">
<xsl:apply-templates/>
</xsl:template>


<xsl:template match="slidesinfo/authorgroup">
<xsl:apply-imports/>
</xsl:template>

<xsl:template match="slidesinfo/author|slidesinfo/authorgroup/author">
<xsl:apply-imports/>
</xsl:template>

<xsl:template match="slidesinfo/releaseinfo">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="slidesinfo/date">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="slidesinfo/copyright">
</xsl:template>


</xsl:stylesheet>
