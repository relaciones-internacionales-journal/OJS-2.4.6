{**
 * templates/author/submit/step3.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 3 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step3"}
{include file="author/submit/submitHeader.tpl"}

{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}

<form id="submit" method="post" action="{url op="saveSubmit" path=$submitStep}">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

{literal}
<script type="text/javascript">
<!--
// Move author up/down
function moveAuthor(dir, authorIndex) {
	var form = document.getElementById('submit');
	form.moveAuthor.value = 1;
	form.moveAuthorDir.value = dir;
	form.moveAuthorIndex.value = authorIndex;
	form.submit();
}
// -->
</script>
{/literal}

{if count($formLocales) > 1}
<div id="locales">
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{url|assign:"submitFormUrl" op="submit" path="3" articleId=$articleId escape=false}
			{* Maintain localized author info across requests *}
			{foreach from=$authors key=authorIndex item=author}
				{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
					{foreach from=$author.competingInterests key="thisLocale" item="thisCompetingInterests"}
						{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][competingInterests][{$thisLocale|escape}]" value="{$thisCompetingInterests|escape}" />{/if}
					{/foreach}
				{/if}
				{foreach from=$author.biography key="thisLocale" item="thisBiography"}
					{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][biography][{$thisLocale|escape}]" value="{$thisBiography|escape}" />{/if}
				{/foreach}
				{foreach from=$author.affiliation key="thisLocale" item="thisAffiliation"}
					{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][affiliation][{$thisLocale|escape}]" value="{$thisAffiliation|escape}" />{/if}
				{/foreach}
			{/foreach}
			{form_language_chooser form="submit" url=$submitFormUrl}
			<span class="help-block">{translate key="form.formLanguage.description"}</span>
		</td>
	</tr>
</table>
</div>
{/if}

<div id="author-submit-meta-authors">
<h3><a role="button" data-toggle="collapse" href="#tog-one" aria-expanded="false" aria-controls="tog-one">{translate key="article.authors"}<i class="fa fa-chevron-circle-down"></i></a></h3>
<div class="collapse" id="tog-one">
<input type="hidden" name="deletedAuthors" value="{$deletedAuthors|escape}" />
<input type="hidden" name="moveAuthor" value="0" />
<input type="hidden" name="moveAuthorDir" value="" />
<input type="hidden" name="moveAuthorIndex" value="" />

{foreach name=authors from=$authors key=authorIndex item=author}
<input type="hidden" name="authors[{$authorIndex|escape}][authorId]" value="{$author.authorId|escape}" />
<input type="hidden" name="authors[{$authorIndex|escape}][seq]" value="{$authorIndex+1}" />
{if $smarty.foreach.authors.total <= 1}
<input type="hidden" name="primaryContact" value="{$authorIndex|escape}" />
{/if}

<table width="100%" class="data-alt">
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-$authorIndex-firstName" required="true" key="user.firstName"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[{$authorIndex|escape}][firstName]" id="authors-{$authorIndex|escape}-firstName" value="{$author.firstName|escape}" size="20" maxlength="40" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-$authorIndex-middleName" key="user.middleName"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[{$authorIndex|escape}][middleName]" id="authors-{$authorIndex|escape}-middleName" value="{$author.middleName|escape}" size="20" maxlength="40" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-$authorIndex-lastName" required="true" key="user.lastName"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[{$authorIndex|escape}][lastName]" id="authors-{$authorIndex|escape}-lastName" value="{$author.lastName|escape}" size="20" maxlength="90" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-$authorIndex-email" required="true" key="user.email"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[{$authorIndex|escape}][email]" id="authors-{$authorIndex|escape}-email" value="{$author.email|escape}" size="30" maxlength="90" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-$authorIndex-orcid" key="user.orcid"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[{$authorIndex|escape}][orcid]" id="authors-{$authorIndex|escape}-orcid" value="{$author.orcid|escape}" size="30" maxlength="90" /><br />{translate key="user.orcid.description"}</td>
</tr>
<tr valign="top">
	<td class="label">{fieldLabel name="authors-$authorIndex-url" key="user.url"}</td>
	<td class="value"><input type="text" name="authors[{$authorIndex|escape}][url]" id="authors-{$authorIndex|escape}-url" value="{$author.url|escape}" size="30" maxlength="255" class="textField" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-$authorIndex-affiliation" key="user.affiliation"}</td>
	<td width="80%" class="value">
		<textarea name="authors[{$authorIndex|escape}][affiliation][{$formLocale|escape}]" class="textArea" id="authors-{$authorIndex|escape}-affiliation" rows="5" cols="40">{$author.affiliation[$formLocale]|escape}</textarea><br/>
		<span class="help-block">{translate key="user.affiliation.description"}</span>
	</td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-$authorIndex-country" key="common.country"}</td>
	<td width="80%" class="value">
		<select name="authors[{$authorIndex|escape}][country]" id="authors-{$authorIndex|escape}-country" class="selectMenu">
			<option value=""></option>
			{html_options options=$countries selected=$author.country}
		</select>
	</td>
</tr>
{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="authors-$authorIndex-competingInterests" key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</td>
		<td width="80%" class="value"><textarea name="authors[{$authorIndex|escape}][competingInterests][{$formLocale|escape}]" class="textArea" id="authors-{$authorIndex|escape}-competingInterests" rows="5" cols="40">{$author.competingInterests[$formLocale]|escape}</textarea></td>
	</tr>
{/if}{* requireAuthorCompetingInterests *}
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-$authorIndex-biography" key="user.biography" required="true"}<br />{translate key="user.biography.description"}</td>
	<td width="80%" class="value"><textarea name="authors[{$authorIndex|escape}][biography][{$formLocale|escape}]" class="textArea" id="authors-{$authorIndex|escape}-biography" rows="5" cols="40">{$author.biography[$formLocale]|escape}</textarea></td>
</tr>

{call_hook name="Templates::Author::Submit::Authors"}

{if $smarty.foreach.authors.total > 1}
<tr valign="top">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
<tr valign="top">
	<td colspan="2">
		<a href="javascript:moveAuthor('u', '{$authorIndex|escape}')" class="action">&uarr;</a> <a href="javascript:moveAuthor('d', '{$authorIndex|escape}')" class="action">&darr;</a>
		{translate key="author.submit.reorderhelp-blockions"}
	</td>
</tr>
<tr valign="top">
	<td width="80%" class="value" colspan="2"><label class="checkbox" for="primaryContact"><input type="radio" name="primaryContact" value="{$authorIndex|escape}"{if $primaryContact == $authorIndex} checked="checked"{/if} /> {translate key="author.submit.selectPrincipalContact"}</label> <br/><input type="submit" name="delAuthor[{$authorIndex|escape}]" value="{translate key="author.submit.deleteAuthor"}" class="btn btn-danger btn-sm" /></td>
</tr>
<hr/>
{/if}
</table>
{foreachelse}
<input type="hidden" name="authors[0][authorId]" value="0" />
<input type="hidden" name="primaryContact" value="0" />
<input type="hidden" name="authors[0][seq]" value="1" />
<table width="100%" class="data-alt">
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-firstName" required="true" key="user.firstName"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[0][firstName]" id="authors-0-firstName" size="20" maxlength="40" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-middleName" key="user.middleName"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[0][middleName]" id="authors-0-middleName" size="20" maxlength="40" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-lastName" required="true" key="user.lastName"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[0][lastName]" id="authors-0-lastName" size="20" maxlength="90" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-affiliation" key="user.affiliation"}</td>
	<td width="80%" class="value">
		<textarea name="authors[0][affiliation][{$formLocale|escape}]" class="textArea" id="authors-0-affiliation" rows="5" cols="40"></textarea><br/>
		<span class="help-block">{translate key="user.affiliation.description"}</span>
	</td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-country" key="common.country"}</td>
	<td width="80%" class="value">
		<select name="authors[0][country]" id="authors-0-country" class="selectMenu">
			<option value=""></option>
			{html_options options=$countries}
		</select>
	</td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-email" required="true" key="user.email"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[0][email]" id="authors-0-email" size="30" maxlength="90" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-orcid" key="user.orcid"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[0][orcid]" id="authors-0-orcid" size="30" maxlength="90" /><br />{translate key="user.orcid.description"}</td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-url" required="true" key="user.url"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="authors[0][url]" id="authors-0-url" size="30" maxlength="255" /></td>
</tr>
{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-competingInterests" key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</td>
	<td width="80%" class="value"><textarea name="authors[0][competingInterests][{$formLocale|escape}]" class="textArea" id="authors-0-competingInterests" rows="5" cols="40"></textarea></td>
</tr>
{/if}
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="authors-0-biography" key="user.biography"}<br />{translate key="user.biography.description"}</td>
	<td width="80%" class="value"><textarea name="authors[0][biography][{$formLocale|escape}]" class="textArea" id="authors-0-biography" rows="5" cols="40"></textarea></td>
</tr>
</table>
{/foreach}

<p><input type="submit" class="btn btn-sm" name="addAuthor" value="{translate key="author.submit.addAuthor"}" /></p>
</div>
</div>

<div id="author-submit-title-and-abstract">
<h3><a role="button" data-toggle="collapse" href="#tog-two" aria-expanded="false" aria-controls="tog-two">{translate key="submission.titleAndAbstract"}<i class="fa fa-chevron-circle-down"></i></a></h3>
<div class="collapse" id="tog-two">
<table width="100%" class="data-alt">

<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="title" required="true" key="article.title"}</td>
	<td width="80%" class="value"><input type="text" class="textField input-xxlarge" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="60" maxlength="255" /></td>
</tr>

<tr valign="top">
	<td width="20%" class="label">{if $section->getAbstractsNotRequired()==0}{fieldLabel name="abstract" key="article.abstract" required="true"}{else}{fieldLabel name="abstract" key="article.abstract"}{/if}</td>
	<td width="80%" class="value"><textarea name="abstract[{$formLocale|escape}]" id="abstract" class="textArea input-xxlarge" rows="15" cols="60">{$abstract[$formLocale]|escape}</textarea></td>
</tr>
</table>
</div>
</div>

{if $section->getMetaIndexed()==1}
	<div id="author-submit-indexing">
		<h3><a role="button" data-toggle="collapse" href="#tog-three" aria-expanded="false" aria-controls="tog-three">{translate key="submission.indexing"}<i class="fa fa-chevron-circle-down"></i></a></h3>
		{if $currentJournal->getSetting('metaDiscipline') || $currentJournal->getSetting('metaSubjectClass') || $currentJournal->getSetting('metaSubject') || $currentJournal->getSetting('metaCoverage') || $currentJournal->getSetting('metaType')}<p>{translate key="author.submit.submissionIndexingDescription"}</p>{/if}
		<div class="collapse" id="tog-three">
		<table width="100%" class="data-alt">
		{if $currentJournal->getSetting('metaDiscipline')}
		<tr valign="top">
			<td{if $currentJournal->getLocalizedSetting('metaDisciplineExamples') != ''} rowspan="2"{/if} width="20%" class="label">{fieldLabel name="discipline" key="article.discipline"}</td>
			<td width="80%" class="value"><input type="text" class="textField input-xlarge" name="discipline[{$formLocale|escape}]" id="discipline" value="{$discipline[$formLocale]|escape}" size="40" maxlength="255" /></td>
		</tr>
		{if $currentJournal->getLocalizedSetting('metaDisciplineExamples')}
		<tr valign="top">
			<td colspan="2"><span class="help-block">{$currentJournal->getLocalizedSetting('metaDisciplineExamples')|escape}</span></td>
		</tr>
		{/if}
		<tr valign="top">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		{/if}

		{if $currentJournal->getSetting('metaSubjectClass')}
		<tr valign="top">
			<td rowspan="2" width="20%" class="label">{fieldLabel name="subjectClass" key="article.subjectClassification"}</td>
			<td width="80%" class="value"><input type="text" class="textField input-xlarge" name="subjectClass[{$formLocale|escape}]" id="subjectClass" value="{$subjectClass[$formLocale]|escape}" size="40" maxlength="255" /></td>
		</tr>
		<tr valign="top">
			<td width="20%" class="label"><a href="{$currentJournal->getLocalizedSetting('metaSubjectClassUrl')|escape}" target="_blank">{$currentJournal->getLocalizedSetting('metaSubjectClassTitle')|escape}</a></td>
		</tr>
		<tr valign="top">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		{/if}

		{if $currentJournal->getSetting('metaSubject')}
		<tr valign="top">
			<td{if $currentJournal->getLocalizedSetting('metaSubjectExamples') != ''} rowspan="2"{/if} width="20%" class="label">{fieldLabel name="subject" key="article.subject"}</td>
			<td width="80%" class="value"><input type="text" class="textField input-xlarge" name="subject[{$formLocale|escape}]" id="subject" value="{$subject[$formLocale]|escape}" size="40" maxlength="255" /></td>
		</tr>
		{if $currentJournal->getLocalizedSetting('metaSubjectExamples') != ''}
		<tr valign="top">
			<td colspan="2"><span class="help-block">{$currentJournal->getLocalizedSetting('metaSubjectExamples')|escape}</span></td>
		</tr>
		{/if}
		<tr valign="top">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		{/if}

		{if $currentJournal->getSetting('metaCoverage')}
		<tr valign="top">
			<td{if $currentJournal->getLocalizedSetting('metaCoverageGeoExamples') != ''} rowspan="2"{/if} width="20%" class="label">{fieldLabel name="coverageGeo" key="article.coverageGeo"}</td>
			<td width="80%" class="value"><input type="text" class="textField input-xlarge" name="coverageGeo[{$formLocale|escape}]" id="coverageGeo" value="{$coverageGeo[$formLocale]|escape}" size="40" maxlength="255" /></td>
		</tr>
		{if $currentJournal->getLocalizedSetting('metaCoverageGeoExamples')}
		<tr valign="top">
			<td colspan="2"><span class="help-block">{$currentJournal->getLocalizedSetting('metaCoverageGeoExamples')|escape}</span></td>
		</tr>
		{/if}
		<tr valign="top">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr valign="top">
			<td{if $currentJournal->getLocalizedSetting('metaCoverageChronExamples') != ''} rowspan="2"{/if} width="20%" class="label">{fieldLabel name="coverageChron" key="article.coverageChron"}</td>
			<td width="80%" class="value"><input type="text" class="textField input-xlarge" name="coverageChron[{$formLocale|escape}]" id="coverageChron" value="{$coverageChron[$formLocale]|escape}" size="40" maxlength="255" /></td>
		</tr>
		{if $currentJournal->getLocalizedSetting('metaCoverageChronExamples') != ''}
		<tr valign="top">
			<td colspan="2"><span class="help-block">{$currentJournal->getLocalizedSetting('metaCoverageChronExamples')|escape}</span></td>
		</tr>
		{/if}
		<tr valign="top">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr valign="top">
			<td{if $currentJournal->getLocalizedSetting('metaCoverageResearchSampleExamples') != ''} rowspan="2"{/if} width="20%" class="label">{fieldLabel name="coverageSample" key="article.coverageSample"}</td>
			<td width="80%" class="value"><input type="text" class="textField input-xlarge" name="coverageSample[{$formLocale|escape}]" id="coverageSample" value="{$coverageSample[$formLocale]|escape}" size="40" maxlength="255" /></td>
		</tr>
		{if $currentJournal->getLocalizedSetting('metaCoverageResearchSampleExamples') != ''}
		<tr valign="top">
			<td colspan="2"><span class="help-block">{$currentJournal->getLocalizedSetting('metaCoverageResearchSampleExamples')|escape}</span></td>
		</tr>
		{/if}
		<tr valign="top">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		{/if}

		{if $currentJournal->getSetting('metaType')}
		<tr valign="top">
			<td width="20%" {if $currentJournal->getLocalizedSetting('metaTypeExamples') != ''}rowspan="2" {/if}class="label">{fieldLabel name="type" key="article.type"}</td>
			<td width="80%" class="value"><input type="text" class="textField input-xlarge" name="type[{$formLocale|escape}]" id="type" value="{$type[$formLocale]|escape}" size="40" maxlength="255" /></td>
		</tr>

		{if $currentJournal->getLocalizedSetting('metaTypeExamples') != ''}
		<tr valign="top">
			<td colspan="2"><span class="help-block">{$currentJournal->getLocalizedSetting('metaTypeExamples')|escape}</span></td>
		</tr>
		{/if}
		<tr valign="top">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		{/if}

		<tr valign="top">
			<td rowspan="2" width="20%" class="label">{fieldLabel name="language" key="article.language"}</td>
			<td width="80%" class="value"><input type="text" class="textField input-xlarge" name="language" id="language" value="{$language|escape}" size="5" maxlength="10" /></td>
		</tr>
		<tr valign="top">
			<td colspan="2"><span class="help-block">{translate key="author.submit.languageInstructions"}</span></td>
		</tr>
		</table>
		</div>
	</div>
	<div class="separator"></div>
{/if}

<div id="author-submit-submission-supporting-agencies">
<h3><a role="button" data-toggle="collapse" href="#tog-four" aria-expanded="false" aria-controls="tog-four">{translate key="author.submit.submissionSupportingAgencies"}<i class="fa fa-chevron-circle-down"></i></a></h3>
<div class="collapse" id="tog-four">
<p>{translate key="author.submit.submissionSupportingAgenciesDescription"}</p>

<table width="100%" class="data-alt">
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="sponsor" key="submission.agencies"}</td>
	<td width="80%" class="value"><input type="text" class="textField" name="sponsor[{$formLocale|escape}]" id="sponsor" value="{$sponsor[$formLocale]|escape}" size="60" maxlength="255" /></td>
</tr>
</table>
</div>
</div>

{call_hook name="Templates::Author::Submit::AdditionalMetadata"}

{if $currentJournal->getSetting('metaCitations')}
<div id="author-submit-meta-citations">
<h3><a role="button" data-toggle="collapse" href="#tog-five" aria-expanded="false" aria-controls="tog-five">{translate key="submission.citations"}<i class="fa fa-chevron-circle-down"></i></a></h3>
<div class="collapse" id="tog-five">
<p>{translate key="author.submit.submissionCitations"}</p>

<table width="100%" class="data-alt">
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="citations" key="submission.citations"}</td>
	<td width="80%" class="value"><textarea name="citations" id="citations" class="textArea" rows="15" cols="60">{$citations|escape}</textarea></td>
</tr>
</table>
</div></div>
{/if}

<div class="separator"><hr/></div>
<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-sm" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /> <input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-sm" /></p>

<p>{translate key="common.requiredField"}</p>

</form>

{if $scrollToAuthor}
	{literal}
	<script type="text/javascript">
		var authors = document.getElementById('authors');
		authors.scrollIntoView(false);
	</script>
	{/literal}
{/if}

{include file="common/footer.tpl"}

