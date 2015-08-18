{**
 * templates/index/journal.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal index page.
 *
 *}
{strip}
{assign var="pageTitleTranslated" value=$siteTitle}
{include file="common/header.tpl"}
{/strip}

{call_hook name="Templates::Index::journal"}


{if $issue && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
	{* Display the table of contents or cover page of the current issue. *}

	<div class="fp-issue-block">

		<div class="fp-issue-bignumber">
		  <p><a href="#">N{$issue->getNumber()|strip_unsafe_html}</a></p>		  
		</div>
		
		<div class="fp-issue-title">	
		  <h2><a href="{$baseUrl}/issue/view/{$issue->getNumber()|strip_unsafe_html}.html" title="{translate key="frontpage.lastIssue"}">{$issue->getLocalizedTitle()|strip_unsafe_html}</a></h2>
		</div>
		
		<div class="fp-issue-meta">
			<p>{$issue->getLocalizedDescription() |strip_unsafe_html|nl2br} <span class="divider">/</span> {translate key="frontpage.lastIssueCoordinators"}
				{foreach name=sections from=$publishedArticles item=section key=sectionId}
					{if $sectionId == '10'}
						{foreach from=$section.articles item=article}
							{assign var=articlePath value=$article->getBestArticleId($currentJournal)}
							{$article->getLocalizedTitle()|strip_unsafe_html}
						{/foreach}
					{/if}
				{/foreach}
				
				<span class="divider">/</span>
				{foreach name=sections from=$publishedArticles item=section key=sectionId}
					{if $sectionId == '8'}
						{foreach from=$section.articles item=article}
						{assign var=articlePath value=$article->getBestArticleId($currentJournal)}	
						{assign var=articleId value=$article->getId()}
							{foreach from=$article->getGalleys() item=galley name=galleyList}
								<a href="{$baseUrl}/article/download/{$articlePath}/{$galley->getBestGalleyId($currentJournal)}.pdf" class="download" target="_blank">{translate key="frontpage.downloadlastFullIssue"} {$issue->getNumber()|strip_unsafe_html} {translate key="frontpage.full"}</a>
							{/foreach}
						{/foreach}
					{/if}
				{/foreach} 
			</p>
		</div>
	</div>
		
	<div class="fp-tabbed-area">  
		<ul class="nav nav-tabs" id ="fp-Tab">
			<li class="active"><a href="#{translate key="frontpage.lastIssueIntro"}" data-toggle="tab">{translate key="frontpage.lastIssueIntro"}</a></li>
			{foreach name=sections from=$publishedArticles item=section key=sectionId}
				{if $sectionId !='11' && $sectionId !='10' && $sectionId !='8' && $sectionId !='5'}
				<li><a href="#{$section.title|escape}" data-toggle="tab">{$section.title|escape}</a></li>{/if}
				{if $sectionId =='5'}<li><a href="#VS" data-toggle="tab">{$section.title|escape}</a></li>{/if}
				{if $sectionId =='11'}<li><a href="#FI" data-toggle="tab">{$section.title|escape}</a></li>{/if}
			{/foreach}
		</ul>
		
		<div class="tab-content">			
			{foreach name=sections from=$publishedArticles item=section key=sectionId}
				<div class="tab-pane" id="{$section.title|escape}">
					{foreach from=$section.articles item=article}
						{assign var=articlePath value=$article->getBestArticleId($currentJournal)}			  	
						
						<div class="toc-article">						

							{if $article->getLocalizedAbstract() == ""}
								{assign var=hasAbstract value=0}
							{else}
								{assign var=hasAbstract value=1}
							{/if}

							{assign var=articleId value=$article->getId()}

							<div class="toc-title">
								{if $hasAbstract}
									<a href="{$baseUrl}/article/view/{$articlePath}.html">{$article->getLocalizedTitle()|strip_unsafe_html}</a>
								{else}
									{$article->getLocalizedTitle()|strip_unsafe_html}
								{/if}
							</div>				
							
							<div class="toc-authors">
								{foreach from=$article->getAuthors() item=author name=authorList}
									{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
								{/foreach}
							</div>
												
							
							{if $hasAbstract}
							<div class="toc-abstract">
								<a href="{$baseUrl}/article/view/{$articlePath}.html">{translate key=article.abstract}</a>
							</div>
							{/if}
				
							<div class="toc-galleys">									
								{foreach from=$article->getGalleys() item=galley name=galleyList}
									<a href="{$baseUrl}/article/download/{$articlePath}/{$galley->getBestGalleyId($currentJournal)}.pdf" class="file" target="_blank">{$galley->getGalleyLabel()|escape}</a>										
								{/foreach}																				
							</div>								
						</div>
						
						{call_hook name="Templates::Issue::Issue::Article"}
					
					{/foreach}
				</div>								
			{/foreach}				
		</div> 								
	</div>

	<div class="fp-sidebar-left">
		{if $enableAnnouncementsHomepage}	
		<div class="fp-announcements-home">
			<h3><a href="{$baseUrl}/announcement.html">{translate key="announcement.announcementsHome"}</a></h3>
			{include file="announcement/list.tpl"}	
		</div>
		{/if}				
	</div>
		
		
	<div class="fp-past-issues-carrousel-container">
		<div class="other-issues">
			<p>{translate key="frontpage.PastIssues"}</p>
		</div>
		{call_hook name="Templates::Index::journal::issueCarousel"}										
	</div>				
	
	<div id="last-issues-phone">
	{call_hook name="Templates::Index::journal::MobileIssuesList"}		
	</div>
	
{/if}

{include file="common/footer.tpl"}

