{**
 * templates/editor/issues/futureIssues.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Listings of future (unpublished) issues.
 *
 *}
{strip}
{assign var="pageTitle" value="editor.issues.futureIssues"}
{url|assign:"currentUrl" page="editor" op="futureIssues"}
{include file="common/header.tpl"}
{/strip}

<div id="editor-top-menu">
	<ul class="nav nav-pills">
        <li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
        <li class="active"><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
        <li><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
	</ul>
</div>
&nbsp;
<div id="editor-issues">
	<div class="editor-issues-list-head">
		<div class="long-title">{translate key="issue.issue"}</div>
		<div class="issue-number">{translate key="editor.issues.numArticles"}</div>
		<div class="issue-action">{translate key="common.action"}</div>
	</div>
	
	{iterate from=issues item=issue}
	<div class="editor_issues_list">
		<div class="long-title"><a href="{url op="issueToc" path=$issue->getId()}" class="action">{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a></div>
		<div class="issue-number">{$issue->getNumArticles()|escape}</div>
		<div class="issue-action"><a href="{url op="removeIssue" path=$issue->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.confirmDelete"}')" class="action delete">{translate key="common.delete"}</a></div>
	</div>
	{/iterate}
	
	{if $issues->wasEmpty()}
		<div class="no-issues"><p>{translate key="issue.noIssues"}</p></div>
	{else}
		<div class="submissions-pagination">
			<p class="page-pagination">{page_info iterator=$issues}</p>
			<p class="page-pagination-pages">{page_links anchor="issues" name="issues" iterator=$issues}</p
		</div>
	{/if}

</div>
{include file="common/footer.tpl"}

