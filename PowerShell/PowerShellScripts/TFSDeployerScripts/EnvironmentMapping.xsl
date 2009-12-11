<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  <xsl:key name="grpTeamProj" match="*[@TeamProject]" use="@TeamProject" />
  <xsl:key name="grpKey" match="*[@Key]" use="concat(@TeamProject, ' ', @Key)" />
  <xsl:key name="grp" match="*[@Key]" use="@Key" />

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">

      <head>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <title>Environment Deployments</title>
        <style type="text/css">
			.TeamStyle {
			font-family: Arial, Helvetica, sans-serif;
			font-size: medium;
			font-weight: bold;
			border-style: solid;
			border-width: 1px;
			padding: 4px;
			background-color: #E2E2E2;
			list-style-type: none;
			margin-bottom: 10px;
			width: 600px;
			text-align: left;
			}
			.KeyStyle {
			margin: 5px 5px 5px -25px;
			border-style: solid;
			border-width: 1px;
			padding: 4px;
			font-family: Arial, Helvetica, sans-serif;
			background-color: #990000;
			font-size: medium;
			font-weight: bold;
			font-style: normal;
			font-variant: normal;
			text-decoration: none;
			list-style-type: none;
			text-align: left;
			}
			.BuildStyle {
			padding: 1px;
			background-color: #E2E2E2;
			font-family: Arial, Helvetica, sans-serif;
			margin-top: 4px;
			margin-left: -20px;
			font-size: small;
			position: relative;
			font-weight: normal;
			font-style: normal;
			font-variant: normal;
			text-decoration: none;
			list-style-type: none;
			text-align: left;
			}
			a:link {
			text-decoration: none;
			color: #666699;
			}
			a:visited {
			text-decoration: none;
			color: #666699;
			}


		</style>
	</head>
      <body>
        <center>

        Updated on <xsl:value-of select="Environments/@LastUpdated" />
        <br/>
        <xsl:apply-templates select="Environments/Environment/Builds" />
        </center>
      </body>
    </html>

  </xsl:template>

  <xsl:template match="Environments/Environment/Builds">
    <ul>
      <xsl:for-each select="Build[count(. | key('grpTeamProj', @TeamProject)[1]) = 1]">
        <xsl:sort select="@TeamProject" />
        <li class="TeamStyle">
          <xsl:value-of select="@TeamProject" />
          <ul>
            <xsl:variable name="team_projects" select="key('grpTeamProj', @TeamProject)" />
            <xsl:for-each select="$team_projects[generate-id() = generate-id( key('grpKey', concat(@TeamProject, ' ', @Key))[1])]">
              <xsl:sort select="@Key" />
              <li class="KeyStyle">
                <xsl:value-of select="@Key" />
                <ul>

                  <xsl:variable name="project_keys" select="key('grpKey', concat(@TeamProject, ' ', @Key))" />

                  <xsl:for-each select="key('grp', @Key)">
                    <xsl:sort select="@BuildNumber" />
                    <li class="BuildStyle">
                      <xsl:value-of select="@BuildNumber" /> (<a xmlns="http://www.w3.org/1999/xhtml" href="#" title="Deployment Timestamp: {@TimeStamp}"><xsl:value-of select="../../@Name" /> </a>)<br />
                    </li>
                  </xsl:for-each>
                </ul>
              </li>
            </xsl:for-each>
          </ul>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>


</xsl:stylesheet>
