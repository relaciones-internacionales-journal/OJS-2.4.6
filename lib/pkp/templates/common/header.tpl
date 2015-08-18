{**
 * header.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header.
 *}
{strip}
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{if $pageCrumbTitle}
	{translate|assign:"pageCrumbTitleTranslated" key=$pageCrumbTitle}
{elseif !$pageCrumbTitleTranslated}
	{assign var="pageCrumbTitleTranslated" value=$pageTitleTranslated}
{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta http-equiv="content-language" content="{$currentLocale}">
	{if $smarty.get.page == 'index'}
	<title>{$currentJournal->getLocalizedTitle()|strip_unsafe_html}</title>
    {elseif $smarty.get.page == 'admin'}
	<title>{$pageTitleTranslated}</title>
    {else}
    <title>{$currentJournal->getLocalizedTitle()|strip_unsafe_html} | {$pageTitleTranslated}</title>
    {/if}
	 <title>Relaciones Internacionales | {$pageTitleTranslated}</title>
	{*  Mobile viewport optimized *}
	<meta name="viewport" content="width=device-width,initial-scale=1">
	
	<meta name="description" content="{$metaSearchDescription|escape}" />
	<meta name="keywords" content="{$metaSearchKeywords|escape}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
	{$metaCustomHeaders}
	
	{* Added touch icons & tile 4 phones *}
	<link rel="apple-touch-icon" sizes="57x57" href="http://www.relacionesinternacionales.info/apple-icon-57x57.png" />
	<link rel="apple-touch-icon" sizes="72x72" href="http://www.relacionesinternacionales.info/apple-icon-72x72.png" />
	<link rel="apple-touch-icon" sizes="114x114" href="http://www.relacionesinternacionales.info/apple-icon-114x114.png" />
	<link rel="apple-touch-icon" sizes="144x144" href="http://www.relacionesinternacionales.info/apple-icon-144x144.png" />
	<meta name="msapplication-TileImage" content="http://www.relacionesinternacionales.info/tile.png" />
	<meta name="msapplication-TileColor" content="#a46ea5" />
	
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}
	
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/pkp.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
	
	{* Google Fonts *}
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300" type="text/css" />
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,600,700" type="text/css" />
	<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Crimson+Text:400,700,600' type='text/css'>
	
	{* Minified CSS styles 
    <link rel="stylesheet" href="http://www.relacionesinternacionales.info/min/g=css" type="text/css" />*}
	
	{* Minified JS 
	<script type="text/javascript" src="http://www.relacionesinternacionales.info/min/g=js"></script>*}

	<!-- Base Jquery -->
	{if $allowCDN}<script type="text/javascript" src="//www.google.com/jsapi"></script>
		<script type="text/javascript">{literal}
			<!--
			// Provide a local fallback if the CDN cannot be reached
			if (typeof google == 'undefined') {
				document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
				document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js' type='text/javascript'%3E%3C/script%3E"));
			} else {
				google.load("jquery", "{/literal}{$smarty.const.CDN_JQUERY_VERSION}{literal}");
				google.load("jqueryui", "{/literal}{$smarty.const.CDN_JQUERY_UI_VERSION}{literal}");
			}
			// -->
		{/literal}</script>
	{else}
		<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
		<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	{/if}

	{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
	{* Disabled *}
	{*{if $leftSidebarCode || $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/sidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/leftSidebar.css" type="text/css" />{/if}*}
	
	{if $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode && $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" />{/if}
	
	{* Disabled *}
	{*{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}*}

	<!-- Default global locale keys for JavaScript -->
	{include file="common/jsLocaleKeys.tpl" }

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	<!-- Form validation -->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/validate/jquery.validate.js"></script>
	<script type="text/javascript">
		<!--
		// initialise plugins
		{literal}
		$(function(){
			jqueryValidatorI18n("{/literal}{$baseUrl}{literal}", "{/literal}{$currentLocale}{literal}"); // include the appropriate validation localization
			{/literal}{if $validateId}{literal}
				$("form[name={/literal}{$validateId}{literal}]").validate({
					errorClass: "error",
					highlight: function(element, errorClass) {
						$(element).parent().parent().addClass(errorClass);
					},
					unhighlight: function(element, errorClass) {
						$(element).parent().parent().removeClass(errorClass);
					}
				});
			{/literal}{/if}{literal}
			$(".tagit").live('click', function() {
				$(this).find('input').focus();
			});
		});
		// -->
		{/literal}
	</script>

	{if $hasSystemNotifications}
		{url|assign:fetchNotificationUrl page='notification' op='fetchNotification' escape=false}
		<script type="text/javascript">
			$(function(){ldelim}
				$.get('{$fetchNotificationUrl}', null,
					function(data){ldelim}
						var notifications = data.content;
						var i, l;
						if (notifications && notifications.general) {ldelim}
							$.each(notifications.general, function(notificationLevel, notificationList) {ldelim}
								$.each(notificationList, function(notificationId, notification) {ldelim}
									$.pnotify(notification);
								{rdelim});
							{rdelim});
						{rdelim}
				{rdelim}, 'json');
			{rdelim});
		</script>
	{/if}{* hasSystemNotifications *}

	{$additionalHeadData}
	
	<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>
	
	{* CSS style switcher *}	
	{php} 
		if(!empty($_COOKIE['style'])) $style = $_COOKIE['style'];
		else $style = 'custom';
	{/php}	
	<link id="stylesheet" type="text/css" href="{$baseUrl}/override/css/{php}echo $style{/php}.css" rel="stylesheet" />
	<link rel="stylesheet" href="{$baseUrl}/override/css/tablet.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/override/css/mobile.css" type="text/css" />
	
	<!-- Begin Cookie Consent plugin by Silktide - http://silktide.com/cookieconsent -->
	<script type="text/javascript">
	   {literal} window.cookieconsent_options = {"message":"{/literal}{translate key=frontpage.cookiesPolicy}{literal}","dismiss":"{/literal}{translate key=frontpage.cookiesPolicyAccept}{literal}","learnMore":"{/literal}{translate key=frontpage.ReadMore}{literal}","link":"http://www.relacionesinternacionales.info/ojs/pages/view/politica-cookies.html","theme":false, "expiryDays":90};
	   {/literal}
	</script>

<!-- End Cookie Consent plugin -->

</head>
<body id="pkp-{$pageTitle|replace:'.':'-'}">
<div id="container">
<script type="text/javascript">
	{literal}
		$(window).scroll(function() {
			if ($(this).scrollTop() > 81){  
				$('#header').addClass("sticky");
				}
			else{
				$('#header').removeClass("sticky");
			}
		});
	{/literal}
</script>
	<div id="header">
		<div id="header-container">				
			<div class="header-title" itemscope itemtype="http://schema.org/Organization">
				<h1 itemprop="name"><a href="{$baseUrl}/index.html" itemprop="url">{if $smarty.get.page == 'admin'}Relaciones Internacionales{else}{$currentJournal->getLocalizedTitle()|strip_unsafe_html}{/if}</a></h1>
				<meta itemprop="logo" content="{$baseUrl}/templates/images/logo_revista_57x50.png" />
			</div>
			
			<div class="menu-mobile-container">
				<h3><a class="mobile-menu-dropdown-link"><i class="fa fa-bars"> </i>Menu</a></h3>				
				<ul id="menu-princ-mobile" class="menu">{if $enableAnnouncements}
					<li><a href="{$baseUrl}/announcement.html" itemprop="url">{translate key="announcement.announcements"}</a></li>
					{/if}
					<li><a href="{$baseUrl}/about.html" itemprop="url">{translate key="navigation.about"}</a></li>
					<li><a href="{$baseUrl}/issue/archive.html" itemprop="url">{translate key="navigation.past.issues"}</a></li>
					<li><a href="{$baseUrl}/pages/view/indices.html" itemprop="url">{translate key="navigation.indexes"}</a></li>
					<li><a href="{$baseUrl}/about/submissions.html" itemprop="url">{translate key="navigation.ForAuthors"}</a></li>

					{call_hook name="Templates::Common::Header::Navbar::CurrentJournal"}

					{foreach from=$navMenuItems item=navItem}
						{if $navItem.url != '' && $navItem.name != ''}
							<li id="navItem"><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{$navItem.url|escape}{/if}">{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name}{/if}</a></li>
						{/if}
					{/foreach}
				</ul>
			</div>	
			
			<div class="submenu-mobile-container">
				<div class="col-md-3">
					<h3><a class="mobile-lang-dropdown-link"><i class="fa fa-flag-o"> </i>{translate key="user.langSelect"}</a></h3>				
					<ul id="mobile-language" class="menu">
						{foreach from=$languageToggleLocales key=langkey item=langname}
						  {if $langkey == $currentLocale}						  
							{if $currentLocale =='es_ES'}
								<a class="icon" href="#">/ ES</a>
							{elseif $currentLocale =='en_US'}
								<a class="icon" href="#">ENG</a>
							{else}
								<a class="icon" href="#">{$langname}</a>							
							{/if}
						  {else}
							 <a class="icon" href={if $languageToggleNoUser}'{$currentUrl|escape}{if strstr($currentUrl, '?')}&{else}?{/if}setLocale={$langkey}'{else}'{url page="user" op="setLocale" path=$langkey source=$smarty.server.REQUEST_URI escape=false}'{/if}>
								{if $currentLocale =='es_ES'}
									ENG
								{elseif $currentLocale =='en_US'}
									/ ES
								{else}
									{$langname}							
								{/if}
							 </a>
						  {/if}
					   {/foreach}
					</ul>
				</div>
				<div class="col-md-3">
					<h3><a class="mobile-styles-dropdown-link"><i class="fa fa-paint-brush"></i>{translate key="user.mobileSelectStyle"}</a></h3>
					<div id="mobile-styles">									
						<div class="circle-dark"><a href="{$baseUrl}/style-switcher.php?style=custom"><i class="fa fa-circle"></i></a></div>
						<div class="circle-light"><a href="{$baseUrl}/style-switcher.php?style=custom-light"><i class="fa fa-circle"></i></a></div>
					</div>
				</div>
				<div class="col-md-3">
					<h3><a class="mobile-social-dropdown-link"><i class="fa fa-coffee"></i>Social</a></h3>
					<div id="mobile-social">
						<a class="social-menu-academia" href="http://uam.academia.edu/relacionesinternacionales" title="Academia" target="_blank">A</a>
						<a class="social-menu-facebook" href="http://www.facebook.com/RelacionesInternacionales" title="Facebook" target="_blank">F</a>
						<a class="social-menu-twitter" href="http://twitter.com/RRInternacional" title="Twitter" target="_blank">T</a>		
					</div>
				</div>
				<div class="col-md-3">
					<h3><a class="mobile-search-dropdown-link"><i class="fa fa-search"></i>{translate key="navigation.search"}</a></h3>
					<div id="mobile-search">
						<div class="">
							<form method="post" action="{url page="search" op="search"}">
								<label for="query" style="display:none;">{translate key="navigation.search"}</label>
								<div class="input-group">
									<input type="text" id="query" name="query" maxlength="255" value="{translate key="navigation.search"}" class="textField" />
									<span class="input-group-btn">
										<button class="btn btn-default" type="submit"><i title="{translate key="navigation.search"}" class="fa fa-search"></i></button>
									</span>
								</div>	  
							</form>
						</div>
					</div>
				</div>						
			</div>	
			
			<div class="user-menu">
				<ul>
					{if $isUserLoggedIn}
					<li><a href="{$baseUrl}/user.html">{translate key="plugins.block.user.myHome"}</a></li>
					<li><a href="{$baseUrl}/login/signOut.html">{translate key="navigation.logout"}</a></li>					
					{else}				  
					<li>{*trigger modal*}<a href="#login-modal" role="button" data-toggle="modal">{translate key="navigation.login"}</a></li>					
					<li><a href="{$baseUrl}/user/register.html">{translate key="navigation.register"}</a></li>
					{/if}
				</ul>
			
				{* Modal *}
				<div id="login-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="login-modalLabel" aria-hidden="true">
					<div class="modal-header"><p>{translate key="about.onlineSubmissions.registrationRequired"}</p></div>
						<div class="modal-body">
							<form method="post" action="{$userBlockLoginUrl}">
								{if $error}
									<span class="pkp_form_error">{translate key="$error" reason=$reason}</span>
									<br />
									<br />
								{/if}
								<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />
								<table>
									<tr>
										<td><label for="sidebar-username">{translate key="user.username"}</label></td>
										<td><input type="text" id="sidebar-username" name="username" value="" size="12" maxlength="32" class="textField" /></td>
									</tr>
									<tr>
										<td><label for="sidebar-password">{translate key="user.password"}</label></td>
										<td><input type="password" id="sidebar-password" name="password" value="{$password|escape}" size="12" maxlength="32" class="textField" /></td>
									</tr>
								</table>
								
								<input type="submit" value="{translate key="user.login"}" class="btn" />
								<div class="modal-lost-pass"><a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a></div>
								<div class="modal-close"><p class="btn" data-dismiss="modal" aria-hidden="true">{translate key="common.close"}</p></div>						
							</form> 
						</div>							
					</div>
				</div>
				{* / Modal *}
				
				<div class="block-nav" id="sidebar-language-toggle">
					<div class="block-title" style=""></div>
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
				
				<div id="style-switcher">
					<p><strong>{translate key="user.styleswitcher"}</strong></p>			
					<div class="circle-dark"><a href="{$baseUrl}/style-switcher.php?style=custom"><i class="fa fa-circle"></i></a></div>
					<div class="circle-light"><a href="{$baseUrl}/style-switcher.php?style=custom-light"><i class="fa fa-circle"></i></a></div>
				</div>			
			</div>
		</div>
		
		<div id="menu-principal-container">
			<div id="menu-principal" itemscope itemtype="http://schema.org/SiteNavigationElement">
				<ul>{if $enableAnnouncements}
					<li><a href="{$baseUrl}/announcement.html" itemprop="url">{translate key="announcement.announcements"}</a></li>
					{/if}
					<li><a href="{$baseUrl}/about.html" itemprop="url">{translate key="navigation.about"}</a></li>
					<li><a href="{$baseUrl}/issue/archive.html" itemprop="url">{translate key="navigation.past.issues"}</a></li>
					<li><a href="{$baseUrl}/pages/view/indices.html" itemprop="url">{translate key="navigation.indexes"}</a></li>
					<li><a href="{$baseUrl}/about/submissions.html" itemprop="url">{translate key="navigation.ForAuthors"}</a></li>

					{call_hook name="Templates::Common::Header::Navbar::CurrentJournal"}

					{foreach from=$navMenuItems item=navItem}
						{if $navItem.url != '' && $navItem.name != ''}
							<li id="navItem"><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{$navItem.url|escape}{/if}">{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name}{/if}</a></li>
						{/if}
					{/foreach}
				</ul>
				
				<div id="social-menu">			
					<a class="social-menu-academia" href="http://uam.academia.edu/relacionesinternacionales" title="Academia" target="_blank">A</a>
					<a class="social-menu-facebook" href="http://www.facebook.com/RelacionesInternacionales" title="Facebook" target="_blank">F</a>
					<a class="social-menu-twitter" href="http://twitter.com/RRInternacional" title="Twitter" target="_blank">T</a>					
				</div>
				
				<div id="block-search">	
					<div class="dropdown">
						<button class="btn btn-searchcustom dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
							<i class="fa fa-search fa-2x icontolink" style="display:none;"> </i>
						</button>						
						<div class="dropdown-menu">
							<div class="arrow"></div>
							<form method="post" action="{url page="search" op="search"}">
								<label for="query" style="display:none;">{translate key="navigation.search"}</label>
								<div class="input-group">
									<input type="text" id="query" name="query" maxlength="255" value="{translate key="navigation.search"}" class="textField" />
									<span class="input-group-btn">
										<button class="btn btn-default" type="submit"><i title="{translate key="navigation.search"}" class="fa fa-search"></i></button>
									</span>
								</div>	  
							</form>
					  </div>
					</div>
				</div>			
			</div>
		</div>		
		
		<div id="general">
			<div id="sub-container">
			
			{if $smarty.get.page == 'index'}
				{* Do nothing here so sidebar is not displayed*}
			{else}						
				{include file="common/breadcrumbs.tpl"}
				
				{if $leftSidebarCode || $rightSidebarCode}
					<div id="sidebar">
						{if $leftSidebarCode}
							<div id="left-sidebar">
								{$leftSidebarCode}
							</div>
						{/if}
						{if $rightSidebarCode}
							<div id="rightSidebar">
								{$rightSidebarCode}
							</div>
						{/if}
					</div>
				{/if}

				<div id="supramain">
					<div id="main">				
					
					{if $issue}{* Display the table of contents or cover page of the current issue*}						
						<div class="issue-block">
							<div class="issue-bignumber">
							  <p><a href="#">N{$issue->getNumber()|strip_unsafe_html|nl2br}</a></p>					  
							</div>
							<div class="issue-description">
								<div class="issue-title">
								  <h2>{$pageSubtitleTranslated}</h2>
								</div>
								<div class="issue-meta">{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}
								</div>
							</div>
						</div>
						<br />										
					{/if}
					
					{if $issue}
						<div id="content" style="width:100%;">						
					{else}
						<h2>{$pageTitleTranslated}</h2><div class="main-arrow-right"></div>					
						{if $pageSubtitle && !$pageSubtitleTranslated}{translate|assign:"pageSubtitleTranslated" key=$pageSubtitle}{/if}
						{if $pageSubtitleTranslated}
							<h3>{$pageSubtitleTranslated}</h3>
						{/if}
						<div id="content" style="width:100%;">
					{/if}
			{/if}			

{* MODIFICADO OJS V.2.4.6 / 06-2015*}