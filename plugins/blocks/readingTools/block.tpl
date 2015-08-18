{**
 * plugins/blocks/readingTools/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Keyword cloud block plugin
 *
 *}

{if $journalRt && $journalRt->getEnabled()}

<div class="block" id="sidebar-RT-article-tools">

	<div class="block-title-modified">{translate key="plugins.block.readingTools.articleTools"}
	</div>
	
	<ul class="sidebar-block-RTools">
	{if $journalRt->getAbstract() && $galley && $article->getLocalizedAbstract()}
		<li class="article-tool-item">
			<a href="{url page="article" op="view" path=$articleId}" target="_parent">{translate key="article.abstract"}</a><br />
		</li>
	{/if}
	{if $journalRt->getPrinterFriendly()}
		<li class="print-article">
			<a href="{if !$galley || $galley->isHtmlGalley()}javascript:openRTWindow('{url page="rt" op="printerFriendly" path=$articleId|to_array:$galleyId}');{else}{url page="article" op="download" path=$articleId|to_array:$galleyId}{/if}">{translate key="plugins.block.readingTools.printThisArticle"}</a>
		</li>
	{/if}
	{if $journalRt->getViewMetadata()}
		<li class="metadata">
			<a href="javascript:openRTWindow('{url page="rt" op="metadata" path=$articleId|to_array:$galleyId}');">{translate key="rt.viewMetadata"}</a><br />
		</li>
	{/if}
	{if $journalRt->getCaptureCite()}
		<li class="cite-article">
			<a href="javascript:openRTWindow('{url page="rt" op="captureCite" path=$articleId|to_array:$galleyId}');">{translate key="rt.captureCite"}</a><br />
		</li>
	{/if}
	{if $journalRt->getSupplementaryFiles() && is_a($article, 'PublishedArticle') && $article->getSuppFiles()}
		<li class="supp-files">
			<a href="javascript:openRTWindow('{url page="rt" op="suppFiles" path=$articleId|to_array:$galleyId}');">{translate key="rt.suppFiles"}</a><br />
		</li>
	{/if}
	{if $journalRt->getFindingReferences()}
		<li class="finding-references">
			<a href="javascript:openRTWindow('{url page="rt" op="findingReferences" path=$article->getId()|to_array:$galleyId}');">{translate key="rt.findingReferences"}</a>
		</li>
	{/if}
	{if $journalRt->getViewReviewPolicy()}
		<li class="editorial-policies">
			<a href="{url page="about" op="editorialPolicies" anchor="peerReviewProcess"}" target="_parent">{translate key="rt.reviewPolicy"}</a>
		</li>
	{/if}
	{if $journalRt->getEmailOthers()}
		<li class="email-article">	
			{if $isUserLoggedIn}<a href="javascript:openRTWindow('{url page="rt" op="emailColleague" path=$articleId|to_array:$galleyId}');">{translate key="plugins.block.readingTools.emailThisArticle"}</a>
			{else}{translate key="plugins.block.readingTools.emailThisArticle"} <span style="font-size: 0.8em">({translate key="plugins.block.readingTools.loginRequired"})</span>{/if}
		</li>
	{/if}
	{if $journalRt->getEmailAuthor()}
		<li class="email-article">
			{if $isUserLoggedIn}<a href="javascript:openRTWindow('{url page="rt" op="emailAuthor" path=$articleId|to_array:$galleyId}');">{translate key="rt.emailAuthor"}</a>
			{else}{translate key="rt.emailAuthor"} <span style="font-size: 0.8em">({translate key="plugins.block.readingTools.loginRequired"})</span>{/if}
		</li>
	{/if}
	{if $enableComments}
		<li class="post-comment">
			{if $postingLoginRequired}{translate key="plugins.block.readingTools.postComment"} <span style="font-size: 0.8em">({translate key="plugins.block.readingTools.loginRequired"})</span>
			{else}<a href="{url page="comment" op="add" path=$article->getId()|to_array:$galleyId}">{translate key="plugins.block.readingTools.postComment"}</a>{/if}
		</li>
	{/if}
</div>
{/if}

{* MODIFICADO OJS V.2.4.6 / 06-2015 *}
