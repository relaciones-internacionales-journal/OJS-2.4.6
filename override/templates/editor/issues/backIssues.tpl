{**
 * templates/editor/issues/backIssues.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Listings of back issues
 *
 *}
{strip}
{assign var="pageTitle" value="editor.issues.backIssues"}
{assign var="page" value=$rangeInfo->getPage()}
{url|assign:"currentUrl" page="editor" op="backIssues"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", "moveIssue"); });
{/literal}
</script>

<div id="editor-top-menu">
	<ul class="nav nav-pills">
        <li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
        <li><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
        <li class="active"><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
	</ul>
</div>
<br/>
{if $usesCustomOrdering}
	{url|assign:"resetUrl" op="resetIssueOrder"}
	<p>{translate key="editor.issues.resetIssueOrder" url=$resetUrl}</p>
{/if}

<div id="editor-issues">
	<div class="editor-issues-list-head">
		<div class="title">{translate key="issue.issue"}</div>
		<div class="date">{translate key="editor.issues.published"}</div>
		<div class="issue-number">{translate key="editor.issues.numArticles"}</div>
		<div class="order">{translate key="common.order"}</div>
		<div class="issue-action">{translate key="common.action"}</div>
	</div>

	{iterate from=issues item=issue}
	<div class="editor-issues-list" id="issue-{$issue->getId()}">
		<div class="title"><a href="{url op="issueToc" path=$issue->getId()}" class="action">{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a></div>
		<div class="date">{$issue->getDatePublished()|date_format:"$dateFormatShort"|default:"&mdash;"}</div>
		<div class="issue-number">{$issue->getNumArticles()|escape}</div>
		<div class="order"><a href="{url op="moveIssue" d=u id=$issue->getId() issuesPage=$page }">&uarr;</a>	<a href="{url op="moveIssue" d=d id=$issue->getId() issuesPage=$page }">&darr;</a></div>
		<div class="issue-action"><a href="{url op="removeIssue" path=$issue->getId() issuesPage=$page }" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.confirmDelete"}')" class="action delete">{translate key="common.delete"}</a></div>
	</div>
{/iterate}

{if $issues->wasEmpty()}
	<div><p>{translate key="issue.noIssues"}</p>
{else}
	<div class="submissions-pagination">
		<p class="page-pagination">{page_info iterator=$issues}</p>
		<p class="page-pagination-pages">{page_links anchor="issues" name="issues" iterator=$issues}</p>
	</div>
{/if}

	<div class="editor-past-issues-current-issue">
		<form action="{url op="setCurrentIssue"}" method="post">
			<p class="arrow-down-box">{translate key="journal.currentIssue"}</p>
			<select name="issueId">
				<option value="">{translate key="common.none"}</option>
				{html_options options=$allIssues|truncate:40:"..." selected=$currentIssueId}
			</select>
			<input type="submit" value="{translate key="common.record"}" class="btn" />
		</form>
	</div>
</div>
{include file="common/footer.tpl"}

