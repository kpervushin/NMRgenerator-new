<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
  <h2>Content of XML exported NMR items</h2>  
  <xsl:apply-templates/>  
  </body>
  </html>
</xsl:template>

<xsl:template match="nmrattr">
  <p>
    <xsl:apply-templates select="nmrtype"/>  
    <xsl:apply-templates select="nmrname"/>
    <xsl:apply-templates select="nmrauthor"/>  
    <xsl:apply-templates select="nmrurl"/>
    <xsl:apply-templates select="nmrother"/>  
  </p>
</xsl:template>

<xsl:template match="nmrtype">
  NMRType: <span style="color:#ff0000">
  <xsl:value-of select="."/></span>
  <br />
</xsl:template>

<xsl:template match="nmrname">
  NMRName: <span style="color:#0000ff">
  <xsl:value-of select="."/></span>
  <br />
</xsl:template>

<xsl:template match="nmrauthor">
  NMRAuthor: <span style="color:#00ff00">
  <xsl:value-of select="."/></span>
  <br />
</xsl:template>

<xsl:template match="nmrurl">
  NMRURL: <span style="color:#00ff00">
  <xsl:value-of select="."/></span>
  <br />
</xsl:template>

<xsl:template match="nmrother">
  NMROther: <span style="color:#00ffff">
  <xsl:value-of select="."/></span>
  <br />
</xsl:template>


</xsl:stylesheet>

