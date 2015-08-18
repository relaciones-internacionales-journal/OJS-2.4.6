{**
 * plugins/blocks/keywordCloud/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Keyword cloud block plugin
 *
 *}
<div class="block" id="sidebar-keyword-cloud">
	<div class="block-title-modified">{translate key="plugins.block.keywordCloud.title"}</div>
	<ul class="sd-bl-keywords">
	{foreach name=cloud from=$cloudKeywords key=keyword item=count}
		<li><a href="{url page="search" subject=$keyword}">{$keyword}</a></li>
	{/foreach}
	</ul>
</div>

{* MODIFICADO OJS V.2.4.6 / 06-2015*}