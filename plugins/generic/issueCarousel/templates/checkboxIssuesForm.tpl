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
 
{iterate from=issues item=issue}
	<tr valign="top">
	{assign var="i" value=$issue->getIssueId()}	
		<td width="10%" class="label" align="right"><input type="checkbox" name="selectedCarouselIssues[]" id="selectedCarouselIssues" value="{$i}" {if in_array ($i,$selectedCarouselIssues)} checked="checked"{/if}/></td>
		<td width="90%" class="value">{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a></td>	
	</tr>
{/iterate}