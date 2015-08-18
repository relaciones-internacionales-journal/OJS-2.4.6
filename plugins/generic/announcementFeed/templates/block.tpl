{**
 * plugins/generic/announcementFeed/templates/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Announcement feed plugin navigation sidebar.
 *
 *}
<div class="block" id="sidebarAnnouncementFeed">
	<div class="block-title-modified">RSS</div>
	{*
	<a href="{url page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"atom"}">
	<img src="{$baseUrl}/plugins/generic/announcementFeed/templates/images/atom10_logo.gif" alt="{translate key="plugins.generic.announcementfeed.atom.altText"}" border="0" /></a>
	<br/>
	*}
	<ul class="plain">
		<li><i class="fa fa-rss"></i> <a href="{url page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"rss2"} class="rss" target="_blank">RSS 2.0</a></li>
	<ul>
	{*
	<br/>
	<a href="{url page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"rss"}">
	<img src="{$baseUrl}/plugins/generic/announcementFeed/templates/images/rss10_logo.gif" alt="{translate key="plugins.generic.announcementfeed.rss1.altText"}" border="0" /></a>
	*}
</div>

{* MODIFICADO OJS V.2.4.6 / 06-2015*}