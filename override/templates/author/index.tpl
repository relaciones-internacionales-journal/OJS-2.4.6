{**
 * templates/author/index.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal author index.
 *
 *}
{strip}
{assign var="pageTitle" value="common.queue.long.$pageToDisplay"}
{include file="common/header.tpl"}
{/strip}

<div id="editor-top-menu">
	<ul class="nav nav-pills">
		<li{if ($pageToDisplay == "active")} class="active"{/if}><a href="{url op="index" path="active"}">{translate key="common.queue.short.active"}</a></li>
		<li{if ($pageToDisplay == "completed")} class="active"{/if}><a href="{url op="index" path="completed"}">{translate key="common.queue.short.completed"}</a></li>
	</ul>
</div>
<br />

{include file="author/$pageToDisplay.tpl"}
<div id="submit-start">
<h4>{translate key="author.submit.startHereTitle"}</h4>
{url|assign:"submitUrl" op="submit"}
{translate submitUrl=$submitUrl key="author.submit.startHereLink"}<br />
</div>

{call_hook name="Templates::Author::Index::AdditionalItems"}

{include file="common/footer.tpl"}

