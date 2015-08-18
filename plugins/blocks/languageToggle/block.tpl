{**
 * plugins/blocks/languageToggle/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- language toggle.
 *
 *}

{if $enableLanguageToggle}
{* 
<div class="block" id="sidebar-language-toggle">
	<script type="text/javascript">
		<!--
		function changeLanguage() {ldelim}
			var e = document.getElementById('languageSelect');
			var new_locale = e.options[e.selectedIndex].value;

			var redirect_url = '{url|escape:"javascript" page="user" op="setLocale" path="NEW_LOCALE" source=$smarty.server.REQUEST_URI escape=false}';
			redirect_url = redirect_url.replace("NEW_LOCALE", new_locale);

			window.location.href = redirect_url;
		{rdelim}
		//-->
	</script>
	<span class="block-title">{translate key="common.language"}</span>
	<form action="#">
		<label for="languageSelect">{translate key="plugins.block.languageToggle.selectLabel"}</label>
		<select id="languageSelect" {if $isPostRequest}disabled="disabled" {/if}size="1" name="locale" class="selectMenu">{html_options options=$languageToggleLocales selected=$currentLocale}</select>
		<input type="submit" class="button" value="{translate key='form.submit'}" onclick="changeLanguage(); return false;" />
	</form>
</div>
{/if} 
*}
<div class="block-nav sidebar-language-toggle" style="display:none;">
	<div class="block-title">{translate key="common.language"}</div>
	{foreach from=$languageToggleLocales key=langkey item=langname}
      {if $langkey == $currentLocale}
         <a class="icon" href="#"><img src="{$baseUrl}/plugins/blocks/languageToggle/locale/{$langkey}/flag.png" alt="{$langname}" title="{$langname}" width="18" height="12" /></a>
      {else}
         <a class="icon" href={if $languageToggleNoUser}'{$currentUrl|escape}{if strstr($currentUrl, '?')}&{else}?{/if}setLocale={$langkey}'{else}'{url page="user" op="setLocale" path=$langkey source=$smarty.server.REQUEST_URI escape=false}'{/if}>
            <img src="{$baseUrl}/plugins/blocks/languageToggle/locale/{$langkey}/flag.png" alt="{$langname}" title="{$langname}" width="18" height="12" />
         </a>
      {/if}
   {/foreach}
</div>
{/if}

{* MODIFICADO OJS V.2.4.6 / 06-2015*}
