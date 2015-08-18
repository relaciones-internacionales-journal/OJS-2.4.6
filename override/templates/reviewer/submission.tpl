{**
 * templates/reviewer/submission.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show the reviewer administration page.
 *
 * FIXME: At "Notify The Editor", fix the date.
 *
 *}
{strip}
{assign var="articleId" value=$submission->getId()}
{assign var="reviewId" value=$reviewAssignment->getId()}
{translate|assign:"pageTitleTranslated" key="submission.page.review" id=$articleId}
{assign var="pageCrumbTitle" value="submission.review"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function confirmSubmissionCheck() {
	if (document.getElementById('recommendation').recommendation.value=='') {
		alert('{/literal}{translate|escape:"javascript" key="reviewer.article.mustSelectDecision"}{literal}');
		return false;
	}
	return confirm('{/literal}{translate|escape:"javascript" key="reviewer.article.confirmDecision"}{literal}');
}
// -->
{/literal}
</script>
<div id="submission-to-be-reviewed">
	<h3>{translate key="reviewer.article.submissionToBeReviewed"}</h3>

	<p><strong>{translate key="article.title"}: </strong>{$submission->getLocalizedTitle()|strip_unsafe_html}
	</p>

	<p><strong>{translate key="article.journalSection"}: </strong>{$submission->getSectionTitle()|escape}
	</p>

	<p><strong>{translate key="article.abstract"}: </strong>{$submission->getLocalizedAbstract()|strip_unsafe_html|nl2br}
	</p>

	{assign var=editAssignments value=$submission->getEditAssignments()}
	{foreach from=$editAssignments item=editAssignment}
		{if !$notFirstEditAssignment}
			{assign var=notFirstEditAssignment value=1}
			<p><strong>{translate key="reviewer.article.submissionEditor"}: </strong>
		{/if}
				{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
				{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$articleId}
				{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
				{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
					{if $editAssignment->getCanEdit()}
						({translate key="submission.editing"})
					{else}
						({translate key="submission.review"})
					{/if}
				{/if}
				<br/>
	{/foreach}
	{if $notFirstEditAssignment}
		</p>
	{/if}
	
	<p><strong>{translate key="submission.metadata"}: </strong><a href="{url op="viewMetadata" path=$reviewId|to_array:$articleId}" class="action search-general" target="_new">{translate key="submission.viewMetadata"}</a>
	</p>

</div>

<div id="review-schedule">
	<h3>{translate key="reviewer.article.reviewSchedule"}</h3>
	
	<p><strong>{translate key="reviewer.article.schedule.request"}: </strong>
	{if $submission->getDateNotified()}{$submission->getDateNotified()|date_format:$dateFormatShort}{else}&mdash;{/if}
	</p>
	
	<p><strong>{translate key="reviewer.article.schedule.response"}: </strong>
	{if $submission->getDateConfirmed()}{$submission->getDateConfirmed()|date_format:$dateFormatShort}{else}&mdash;{/if}
	</p>
	
	<p><strong>{translate key="reviewer.article.schedule.submitted"}: </strong>
	{if $submission->getDateCompleted()}{$submission->getDateCompleted()|date_format:$dateFormatShort}{else}&mdash;{/if}
	</p>
	
	<p><strong>{translate key="reviewer.article.schedule.due"}: </strong>
	{if $submission->getDateDue()}{$submission->getDateDue()|date_format:$dateFormatShort}{else}&mdash;{/if}</td>
	</p>

</div>

{if $journal->getLocalizedSetting('reviewGuidelines') != ''}
	<div class="separator"></div>
	<div id="reviewer-guidelines">
		<h3>{translate key="reviewer.article.reviewerGuidelines"}</h3>
		<p>{$journal->getLocalizedSetting('reviewGuidelines')|nl2br}</p>
		</div>
{/if}

<div class="separator"></div>

<div id="review-steps">
<h3>{translate key="reviewer.article.reviewSteps"}</h3>

{include file="common/formErrors.tpl"}

{assign var="currentStep" value=1}

	{assign var=editAssignments value=$submission->getEditAssignments}
	{* FIXME: Should be able to assign primary editorial contact *}
	{if $editAssignments[0]}{assign var=firstEditAssignment value=$editAssignments[0]}{/if}
	<p><strong>{$currentStep|escape}.{assign var="currentStep" value=$currentStep+1}</strong>&nbsp;
		{translate key="reviewer.article.notifyEditorA"}{if $firstEditAssignment}, {$firstEditAssignment->getEditorFullName()|escape},{/if} {translate key="reviewer.article.notifyEditorB"}
		<br/>
		{translate key="submission.response"}&nbsp;&nbsp;&nbsp;&nbsp;
		{if not $confirmedStatus}
			{url|assign:"acceptUrl" op="confirmReview" reviewId=$reviewId}
			{url|assign:"declineUrl" op="confirmReview" reviewId=$reviewId declineReview=1}

			{if !$submission->getCancelled()}
				{translate key="reviewer.article.canDoReview"} {icon name="mail" url=$acceptUrl}
				&nbsp;&nbsp;&nbsp;&nbsp;
				{translate key="reviewer.article.cannotDoReview"} {icon name="mail" url=$declineUrl}
			{else}
				{url|assign:"url" op="confirmReview" reviewId=$reviewId}
				{translate key="reviewer.article.canDoReview"} {icon name="mail" disabled="disabled" url=$acceptUrl}
				&nbsp;&nbsp;&nbsp;&nbsp;
				{url|assign:"url" op="confirmReview" reviewId=$reviewId declineReview=1}
				{translate key="reviewer.article.cannotDoReview"} {icon name="mail" disabled="disabled" url=$declineUrl}
			{/if}
		{else}
			{if not $declined}<a href="#" class="accept-general">{translate key="submission.accepted"}</a>{else}<a href="#" class="delete">{translate key="submission.rejected"}</a>{/if}
		{/if}
	</p>
	<hr/>
	
	{if $journal->getLocalizedSetting('reviewGuidelines') != ''}
		<p><strong>{$currentStep|escape}.{assign var="currentStep" value=$currentStep+1}</strong>&nbsp;
			{translate key="reviewer.article.consultGuidelines"}
		</p>
		<hr/>
	{/if}

	<p><strong>{$currentStep|escape}.{assign var="currentStep" value=$currentStep+1}</strong>&nbsp;
		{translate key="reviewer.article.downloadSubmission"}
	</p>
	
	<ul class="plain" style="margin-top:0px;">
		{if ($confirmedStatus and not $declined) or not $journal->getSetting('restrictReviewerFileAccess')}
			<li><strong>{translate key="submission.submissionManuscript"}: </strong>&nbsp;
				{if $reviewFile}
				{if $submission->getDateConfirmed() or not $journal->getSetting('restrictReviewerAccessToFile')}
					<a href="{url op="downloadFile" path=$reviewId|to_array:$articleId:$reviewFile->getFileId():$reviewFile->getRevision()}" class="descargar-general">{$reviewFile->getFileName()|escape}</a>
				{else}{$reviewFile->getFileName()|escape}{/if}
				&nbsp;&nbsp;{$reviewFile->getDateModified()|date_format:$dateFormatShort}
				{else}
				{translate key="common.none"}
				{/if}
			</li>
			<li><strong>{translate key="article.suppFiles"}: </strong>&nbsp;
				{assign var=sawSuppFile value=0}
				{foreach from=$suppFiles item=suppFile}
					{if $suppFile->getShowReviewers() }
						{assign var=sawSuppFile value=1}
						<a href="{url op="downloadFile" path=$reviewId|to_array:$articleId:$suppFile->getFileId()}" class="descargar-general">{$suppFile->getFileName()|escape}</a><br />
					{/if}
				{/foreach}

				{if !$sawSuppFile}
					{translate key="common.none"}
				{/if}
			</li>
			
		{else}
			{translate key="reviewer.article.restrictedFileAccess"}</li>
		{/if}
	</ul>
	
	<hr/>
	{if $currentJournal->getSetting('requireReviewerCompetingInterests')}
		<p><strong>{$currentStep|escape}.{assign var="currentStep" value=$currentStep+1}</strong>&nbsp;
			{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}
			{translate key="reviewer.article.enterCompetingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}
			{if not $confirmedStatus or $declined or $submission->getCancelled() or $submission->getRecommendation()}<br/>
				{$reviewAssignment->getCompetingInterests()|strip_unsafe_html|nl2br}
			{else}
				<form action="{url op="saveCompetingInterests" reviewId=$reviewId}" method="post">
					<textarea {if $cannotChangeCI}disabled="disabled" {/if}name="competingInterests" class="textArea" id="competingInterests" rows="5" cols="40">{$reviewAssignment->getCompetingInterests()|escape}</textarea><br />
					<input {if $cannotChangeCI}disabled="disabled" {/if}class="btn" type="submit" value="{translate key="common.save"}" />
				</form>
			{/if}
		</p>			
		<hr/>
	{/if}{* $currentJournal->getSetting('requireReviewerCompetingInterests') *}

	{if $reviewAssignment->getReviewFormId()}
		<p><strong>{$currentStep|escape}.{assign var="currentStep" value=$currentStep+1}</strong>&nbsp;
			{translate key="reviewer.article.enterReviewForm"}<br/>
				{translate key="submission.reviewForm"}
				{if $confirmedStatus and not $declined}
					<a href="{url op="editReviewFormResponse" path=$reviewId|to_array:$reviewAssignment->getReviewFormId()}" class="document"></a>
				{else}
					 {icon name="comment" disabled="disabled"}
				{/if}
		</p>
		<hr/>

	{else}{* $reviewAssignment->getReviewFormId() *}
		<p><strong>{$currentStep|escape}.{assign var="currentStep" value=$currentStep+1}</strong>&nbsp;
			{translate key="reviewer.article.enterReviewA"}<br/>
				{translate key="submission.logType.review"}
				{if $confirmedStatus and not $declined}
					<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$articleId|to_array:$reviewId}');" class="icon"><i class="fa fa-comment"></i></a>
				{else}
					 {icon name="comment" disabled="disabled"}
				{/if}
		</p>
		<hr/>
	{/if}{* $reviewAssignment->getReviewFormId() *}

	<p><strong>{$currentStep|escape}.{assign var="currentStep" value=$currentStep+1}</strong>&nbsp;
		{translate key="reviewer.article.uploadFile"}<br/>
		{foreach from=$submission->getReviewerFileRevisions() item=reviewerFile key=key}
			{assign var=uploadedFileExists value="1"}
				{if $key eq "0"}
					{translate key="reviewer.article.uploadedFile"}
				{/if}
				<a href="{url op="downloadFile" path=$reviewId|to_array:$articleId:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="descargar-general">{$reviewerFile->getFileName()|escape}</a>
				{$reviewerFile->getDateModified()|date_format:$dateFormatShort}
				{if ($submission->getRecommendation() === null || $submission->getRecommendation() === '') && (!$submission->getCancelled())}
					<a class="action delete" href="{url op="deleteReviewerVersion" path=$reviewId|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}">{translate key="common.delete"}</a>
				{/if}
		{foreachelse}
			{translate key="reviewer.article.uploadedFile"}
		{/foreach}
		<br/>		
		
		{if $submission->getRecommendation() === null || $submission->getRecommendation() === ''}
			<form method="post" action="{url op="uploadReviewerVersion"}" enctype="multipart/form-data">
				<input type="hidden" name="reviewId" value="{$reviewId|escape}" />
				<div>
					<input type="file" name="upload" {if not $confirmedStatus or $declined or $submission->getCancelled()}disabled="disabled"{/if} class="btn btn-file btn-sm" />
					<input type="submit" name="submit" value="{translate key="common.upload"}" {if not $confirmedStatus or $declined or $submission->getCancelled()}disabled="disabled"{/if} class="btn btn-sm" style="margin-top:10px"/>
				</div>									
			</form>

			{if $currentJournal->getSetting('showEnsuringLink')}
				<span class="help-block">
					<br/><a class="action question-general" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>
				</span>
			{/if}
		{/if}
	</p>
	<hr/>
	
	<p><strong>{$currentStep|escape}.{assign var="currentStep" value=$currentStep+1}</strong>&nbsp;
		<{translate key="reviewer.article.selectRecommendation"}<br/>
		<strong>{translate key="submission.recommendation"}: </strong>
		{if $submission->getRecommendation() !== null && $submission->getRecommendation() !== ''}
			{assign var="recommendation" value=$submission->getRecommendation()}
			<strong>{translate key=$reviewerRecommendationOptions.$recommendation}</strong>&nbsp;&nbsp;
			{$submission->getDateCompleted()|date_format:$dateFormatShort}
		{else}
			<form id="recommendation" method="post" action="{url op="recordRecommendation"}">
			<input type="hidden" name="reviewId" value="{$reviewId|escape}" />
			<select name="recommendation" {if not $confirmedStatus or $declined or $submission->getCancelled() or (!$reviewFormResponseExists and !$reviewAssignment->getMostRecentPeerReviewComment() and !$uploadedFileExists)}disabled="disabled"{/if} class="selectMenu">
				{html_options_translate options=$reviewerRecommendationOptions selected=''}
			</select><br>
			<input type="submit" name="submit" onclick="return confirmSubmissionCheck()" class="btn btn-sm" style="margin-top:10px" value="{translate key="reviewer.article.submitReview"}" {if not $confirmedStatus or $declined or $submission->getCancelled() or (!$reviewFormResponseExists and !$reviewAssignment->getMostRecentPeerReviewComment() and !$uploadedFileExists)}disabled="disabled"{/if} />
			</form>
		{/if}
	</p>
</div>

{* MODIFICADO OJS V.2.4.6 / 06-2015*}

{include file="common/footer.tpl"}