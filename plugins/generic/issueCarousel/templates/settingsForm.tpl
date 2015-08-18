{**
 * settingsForm.tpl
 *
 * Copyright (c) 2013 Projecte Ictineo (www.projecteictineo.com)
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 * Updated for 2.4.6 by Relaciones Internacionales OJS Team
 *
 * issue Carousel plugin settings
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="plugins.generic.issuecarousel.displayName"}
{include file="common/header.tpl"}
{/strip}
<div id="carousel-plugin-settings">
<div id="description">{translate key="plugins.generic.issuecarousel.description"}</div>

<div class="separator">&nbsp;</div>

<h3>{translate key="plugins.generic.issuecarousel.chooseIssues"}</h3>

<form method="post" action="{plugin_url path="settings"}">
{include file="common/formErrors.tpl"}

<table width="100%" class="data">
	<tr valign="top">
		{call_hook name="TemplateManager::display::formCarouselIssuesList"}	
	</tr>			
</table>

<div class="separator"><hr/></div>
<input type="submit" name="save" class="button defaultButton" value="{translate key="common.save"}"/><input type="button" class="button" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
</form>

<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
</div>
{include file="common/footer.tpl"}
