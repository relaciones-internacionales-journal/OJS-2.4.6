{**
 * templates/search/authorDetails.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Index of published articles by author.
 *
 *}
{strip}
{assign var="pageTitle" value="search.authorDetails"}
{include file="common/header.tpl"}
{/strip}
<div id="author-details-single-author">
<h3>{$lastName|escape}, {$firstName|escape}{if $middleName} {$middleName|escape}{/if}</h3>
<p class="author-affiliation">{if $affiliation}{$affiliation|escape}{/if}{if $country}, {$country|escape}{/if}<p>
<p class="author-articles">{translate key="submission.event.general.articlesPublished"}<p>
{foreach from=$publishedArticles item=article}
	{assign var=issueId value=$article->getIssueId()}
	{assign var=issue value=$issues[$issueId]}
	{assign var=issueUnavailable value=$issuesUnavailable.$issueId}
	{assign var=sectionId value=$article->getSectionId()}
	{assign var=journalId value=$article->getJournalId()}
	{assign var=journal value=$journals[$journalId]}
	{assign var=section value=$sections[$sectionId]}
	{if $issue->getPublished() && $section && $journal}
	<ul>
		<li class="author-articles-title">{$article->getLocalizedTitle()|strip_unsafe_html}</li>
		<li class="author-articles-abstract"><a href="{url journal=$journal->getPath() page="article" op="view" path=$article->getBestArticleId()}" class="file">{if $article->getLocalizedAbstract()}{translate key="article.abstract"}{else}{translate key="article.details"}{/if}</a></li>
			{if (!$issueUnavailable || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN)}
			{foreach from=$article->getGalleys() item=galley name=galleyList}
				<li class="author-articles-galley"><a href="{url journal=$journal->getPath() page="article" op="view" path=$article->getBestArticleId()|to_array:$galley->getBestGalleyId($journal)}" class="file">{$galley->getGalleyLabel()|escape}</a></li>
			{/foreach}
			{/if}
		<li class="author-articles-issue"><a href="{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId()}">{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a> - {$section->getLocalizedTitle()|escape}</li>
	</ul>
	{/if}
{/foreach}

</div>
{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.6 / 06-2015*}