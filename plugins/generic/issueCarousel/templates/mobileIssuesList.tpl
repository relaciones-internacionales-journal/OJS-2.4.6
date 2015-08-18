{**
 * mobileIssuesList.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 * Updated for 2.4.6 by Relaciones Internacionales OJS Team
 *
 * We change carousel into a plain list for mobiles.
 *
 *}
 
<ul>
{iterate from=issues item=issue}	
{assign var="z" value=$issue->getIssueId()}	
	{if in_array ($z,$selectedCarouselIssues)}	
		<li><a href="{$baseUrl}/issue/view/{$issue->getNumber()|strip_unsafe_html}.html" title="{translate key="frontpage.lastIssue"}">{$issue->getLocalizedTitle()|strip_unsafe_html}</a></li>
	{/if}
{/iterate}
</ul>