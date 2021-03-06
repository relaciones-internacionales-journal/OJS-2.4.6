{**
 * plugins/generic/staticPages/editStaticPageForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for editing a Static Page
 *
 *}
{strip}
{if $staticPageId}
	{assign var="pageTitle" value="plugins.generic.staticPages.editStaticPage"}
{else}
	{assign var="pageTitle" value="plugins.generic.staticPages.addStaticPage"}
{/if}
{include file="common/header.tpl"}
{/strip}

{translate key="plugins.generic.staticPages.editInstructions"}
<br />
{translate key="plugins.generic.staticPages.viewInstructions" pagesPath=$pagesPath|replace:"REPLACEME":"%PATH%"}
<br />
<br />

<script>
	$(function() {ldelim}
		// Attach the form handler.
		$('#editStaticPageForm').pkpHandler('$.pkp.controllers.form.FormHandler');
	{rdelim});
</script>
<form class="pkp_form" method="post" id="editStaticPageForm" action="{if $staticPageId}{plugin_url path="save"|to_array:$staticPageId}{else}{plugin_url path="save"}{/if}" >
<input type="hidden" name="edit" value="1" />
{if $staticPageId}
	<input type="hidden" name="staticPageId" value="{$staticPageId}" />
{/if}

{include file="common/formErrors.tpl"}

<table class="data_alt">
{if count($formLocales) > 1}
	<tr valign="top">
		<td class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td class="value">
			{if $staticPageId}{plugin_url|assign:"staticPageEditUrl" path="edit"|to_array:$staticPageId}
			{else}{plugin_url|assign:"staticPageEditUrl" path="edit"|to_array:$staticPageId}{/if}
			{form_language_chooser form="editStaticPageForm" url=$staticPageEditUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</td>
	</tr>
{/if}
	<tr>
		<td class="label">{fieldLabel required="true" name="pagePath" key="plugins.generic.staticPages.path"}</td>
		<td class="value" ><input type="text" name="pagePath" value="{$pagePath|escape}" size="40" id="path" maxlength="50" class="textField" /></td>
	</tr>
	<tr>
		<td class="label">{fieldLabel required="true" name="title" key="plugins.generic.staticPages.pageTitle"}</td>
		<td class="value" ><input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" size="40" id="title" maxlength="50" class="textField" /></td>
	</tr>
	<tr>
		<td class="label" valign="top">{fieldLabel required="true" name="content" key="plugins.generic.staticPages.content"}</td>
		<td>
		<textarea name="content[{$formLocale|escape}]" cols="50" rows="30">{$content[$formLocale]|escape}</textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<a href="http://tinymce.moxiecode.com?id=powered_by_tinymce"><img src="http://tinymce.sourceforge.net/buttons/powered_by_tinymce.png" border="0" width="88" height="32" alt="Powered by TinyMCE" /></a>
		</td>
	</tr>
</table>

<div class="separator"> <hr/></div>
<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-sm" onclick="document.location.href='{plugin_url path="settings"}'" /> <input type="submit" value="{translate key="common.save"}" class="btn btn-sm" /></p>

</form>

<p><span class="formRequired">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.6 / 06-2015*}
