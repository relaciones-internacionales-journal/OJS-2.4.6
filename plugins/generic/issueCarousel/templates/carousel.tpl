{**
 * carousel.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 * Updated for 2.4.6 by Relaciones Internacionales OJS Team
 *
 * Carousel.
 *
 *}

<div id="ca-container" class="ca-container">	
	<div class="ca-wrapper">		
		{iterate from=issues item=issue}			
			{assign var="z" value=$issue->getIssueId()}	
			{if in_array ($z,$selectedCarouselIssues)}
				<div class="ca-item ca-item-{$issue->getNumber()|escape}">									
					<div class="ca-item-main">
						<div class="ca-icon"><img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $issue->getCoverPageAltText($locale) != ''} alt="{$issue->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/>
						</div>
						
						<h3><span style="font-size:14px;">{translate key="issue.issue"} {$issue->getNumber()|escape}</span><br/>{$issue->getLocalizedTitle()|escape}<br/><span style="font-size:14px;">{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</span><br/></h3>
						<a href="#" class="ca-more"><i class="fa fa-eye"></i></a>
					</div>
					<div class="ca-content-wrapper">
						<div class="ca-content">
							<h6><a href="{$baseUrl}/issue/view/{$issue->getNumber()|strip_unsafe_html}.html">{$issue->getLocalizedTitle()|escape}</a></h6>							
							<a href="#" class="ca-close"><i class="fa fa-times"></i></a>							
							<div class="ca-content-text">			
								
								{php}
									$templateMgr =& TemplateManager::getManager();
									$articlesCarousel = $this->get_template_vars('issue');
									$issueIdArticlesCarousel = $articlesCarousel->getId();
										
									$publishedArticleDao =& DAORegistry::getDAO('PublishedArticleDAO');
									$publishedArticles =& $publishedArticleDao->getPublishedArticlesInSections($issueIdArticlesCarousel , true);

									$templateMgr->assign_by_ref('publishedArticles', $publishedArticles);								  
								{/php}
													
								{foreach name=sections from=$publishedArticles item=section key=sectionId}
									{if $sectionId =='1'}
										<p class="ca-issue-title">{$section.title|escape}</p>									
										{foreach from=$section.articles item=article}										
											{assign var=articlePath value=$article->getBestArticleId($currentJournal)}			  																	
											<p class="ca-article-title"><a href="{$baseUrl}/article/view/{$articlePath}.html">{$article->getLocalizedTitle()|strip_unsafe_html}</a><br>												
											<i class="fa fa-pencil"></i>{foreach from=$article->getAuthors() item=author name=authorList}
													<span style="font-weight:bold">{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}</span>
											{/foreach}
											</p>																			
										{/foreach}
									{else}
										{*Do nothing*}
									{/if}
								{/foreach}
							</div>							
							<ul>
								<li><a class="crear-general" href="{$baseUrl}/issue/view/{$issue->getNumber()|strip_unsafe_html}.html">{translate key="frontpage.ReadMore"}</a></li>
							</ul>							
						</div>						
					</div>					
				</div>				
			{/if}			
		{/iterate}		
	</div>	
</div>

