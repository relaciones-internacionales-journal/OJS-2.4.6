{**
 * templates/author/submit/step2.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 2 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step2"}
{include file="author/submit/submitHeader.tpl"}

<form method="post" action="{url op="saveSubmit" path=$submitStep}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

<div id="author-submission-file">
<h3>{translate key="author.submit.submissionFile"}</h3>
{if $submissionFile}
<p><strong>{translate key="common.fileName"}: </strong>
	<a href="{url op="download" path=$articleId|to_array:$submissionFile->getFileId()}">{$submissionFile->getFileName()|escape}</a>
</p>
<p><strong>{translate key="common.originalFileName"}: </strong>
	{$submissionFile->getOriginalFileName()|escape}
	</p>
<p><strong>{translate key="common.fileSize"}: </strong>
	{$submissionFile->getNiceFileSize()}
</p>
<p><strong>{translate key="common.dateUploaded"}: </strong>
	{$submissionFile->getDateUploaded()|date_format:$datetimeFormatShort}
</p>
{else}
<p><strong>{translate key="author.submit.noSubmissionFile"}</strong></p>
{/if}
</div>
<hr/>
<div id="add-submission-file">
	{if $submissionFile}
		<p><strong>{fieldLabel name="submissionFile" key="author.submit.replaceSubmissionFile"}</strong></p>
	{else}
		<p><strong>{fieldLabel name="submissionFile" key="author.submit.uploadSubmissionFile"}</strong></p>
	{/if}
	<div>
		<input type="file" class="btn btn-file btn-sm"" name="submissionFile" id="submissionFile" />
		<input name="uploadSubmissionFile" type="submit" class="btn btn-sm" value="{translate key="common.upload"}" />
	</div>
	{if $currentJournal->getSetting('showEnsuringLink')}<a class="action question-general" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
</div>
<hr/>
<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-sm" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /> <input type="submit"{if !$submissionFile} onclick="return confirm('{translate|escape:"jsparam" key="author.submit.noSubmissionConfirm"}')"{/if} value="{translate key="common.saveAndContinue"}" class="btn btn-sm" /></p>
<hr/>
<div id="upload-instructions">{translate key="author.submit.uploadInstructions"}</div>

{if $journalSettings.supportPhone}
	{assign var="howToKeyName" value="author.submit.howToSubmit"}
{else}
	{assign var="howToKeyName" value="author.submit.howToSubmitNoPhone"}
{/if}

<p>{translate key=$howToKeyName supportName=$journalSettings.supportName supportEmail=$journalSettings.supportEmail supportPhone=$journalSettings.supportPhone}</p>

</form>

{include file="common/footer.tpl"}

