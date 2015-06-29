{**
 * plugins/generic/addCssJs/templates/settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Add CSS stylesheets and JS libraries plugin settings
 *
 *}
{strip}
{assign var="pageTitle" value="plugins.generic.addCssJs.displayName"}

{assign var="installedCssList" value=$addCssURL|explode:","} 
{assign var="installedJsList" value=$addJsURL|explode:","} 
{assign var="installedFooterJsList" value=$addJsURLFooter|explode:","}


{include file="common/header.tpl"}
{/strip}

<form method="post" action="{plugin_url path="settings"}">
	<p>{translate key="plugins.generic.addCssJs.importantNotice"}</p>
	
	{include file="common/formErrors.tpl"}
	
	<table width="100%" class="data">	
		<tr valign="top">
			<td width="20%" class="label">{fieldLabel name="addCssURL" required="true" key="plugins.generic.addCssJs.addCssURL"}</td>
			<td width="80%" class="value"><textarea type="text" name="addCssURL" id="addCssURL" value="{$addCssURL}" rows="5" cols="40" class="textArea" />{$addCssURL}</textarea><br/>		
			<span class="instruct">{translate key="plugins.generic.addCssJs.addCssURLDetails"}</span>
			</td>
		</tr>
		<tr valign="top">
			<td width="20%" class="label">{fieldLabel name="addJsURL" required="true" key="plugins.generic.addCssJs.addJsURL"}</td>
			<td width="80%" class="value"><textarea type="text" name="addJsURL" id="addJsURL" value="{$addJsURL|escape}" rows="5" cols="40" class="textArea" />{$addJsURL|escape}</textarea><br/>		
			<span class="instruct">{translate key="plugins.generic.addCssJs.addJsURLDetails"}</span>
			</td>
		</tr>	
	</table>
	
	<div class="separator" style="margin-top:20px;padding-top:20px;">&nbsp;</div>
	
	<table width="100%" class="data">	
		<tr valign="top">
			<td width="20%" class="label">{fieldLabel name="addJsURLFooter" required="true" key="plugins.generic.addCssJs.addJsURLFooter"}</td>
			<td width="80%" class="value"><textarea type="text" name="addJsURLFooter" id="addJsURLFooter" value="{$addJsURLFooter}" rows="5" cols="40" class="textArea" />{$addJsURLFooter}</textarea><br/>		
			<span class="instruct">{translate key="plugins.generic.addCssJs.addJsURLFooterDetails"}</span>
			</td>
		</tr>	
	</table>	
	
	<input type="submit" name="save" class="button defaultButton" value="{translate key="common.save"}"/><input type="button" class="button" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
</form>

<div class="separator">&nbsp;</div>

<h4>{translate key="plugins.generic.addCssJs.installedCss"}</h4>
<ul>{foreach from=$installedCssList item=installedCss}
		<li>{$installedCss}</li>
	{/foreach}
</ul>

<h4>{translate key="plugins.generic.addCssJs.installedJs"}</h4>
<ul>{foreach from=$installedJsList item=installedJs}
		<li>{$installedJs}</li>
	{/foreach}
</ul>

<h4>{translate key="plugins.generic.addCssJs.footerInstalledJs"}</h4>
<ul>{foreach from=$installedFooterJsList item=installedFooterJs}
		<li>{$installedFooterJs}</li>
	{/foreach}
</ul>

{include file="common/footer.tpl"}
