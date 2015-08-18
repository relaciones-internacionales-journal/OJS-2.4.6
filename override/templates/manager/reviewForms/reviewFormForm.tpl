{**
 * templates/manager/reviewForms/reviewFormForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to create/modify a review form.
 *
 *}
{strip}
{include file="common/header.tpl"}
{/strip}

{if $reviewFormId}
	<div id="editor-top-menu">
		<ul class="nav nav-pills">
			<li class="active"><a href="{url op="editReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.edit"}</a></li>
			<li><a href="{url op="reviewFormElements" path=$reviewFormId}">{translate key="manager.reviewFormElements"}</a></li>
			<li><a href="{url op="previewReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.preview"}</a></li>
		</ul>
	</div>
{/if}

<br/>

<form id="reviewFormForm" method="post" action="{url op="updateReviewForm"}">
{if $reviewFormId}
	<input type="hidden" name="reviewFormId" value="{$reviewFormId}"/>
{/if}

{include file="common/formErrors.tpl"}

<table class="data-alt" width="100%">
{if count($formLocales) > 1}
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{if $reviewFormId}{url|assign:"reviewFormFormUrl" op="editReviewForm" path=$reviewFormId escape=false}
			{else}{url|assign:"reviewFormFormUrl" op="createReviewForm" escape=false}
			{/if}
			{form_language_chooser form="reviewFormForm" url=$reviewFormFormUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</td>
	</tr>
{/if}
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="title" required="true" key="manager.reviewForms.title"}</td>
	<td width="80%" class="value"><input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" id="title" size="40" maxlength="120" class="textField" /></td>
</tr>
<tr valign="top">
	<td class="label">{fieldLabel name="description" key="manager.reviewForms.description"}</td>
	<td class="value"><textarea name="description[{$formLocale|escape}]" rows="4" cols="40" id="description" class="textArea">{$description[$formLocale]|escape}</textarea></td>
</tr>
</table>
<hr/>
<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-sm" onclick="document.location.href='{url op="reviewForms" escape=false}'" /> <input type="submit" value="{translate key="common.save"}" class="btn btn-sm" /></p>
</form>

<p>{translate key="common.requiredField"}</p>

{include file="common/footer.tpl"}

