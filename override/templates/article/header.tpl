{**
 * templates/article/header.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View -- Header component.
 *}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}">
<head>
	<title>{$article->getLocalizedTitle()|strip_tags|truncate:60:"...":true|escape} | {$article->getFirstAuthor(true)|truncate:40:"...":true|escape}</title>
	<!-- Mobile viewport optimized -->
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta http-equiv="content-language" content="{$currentLocale}">
	<meta name="description" content="{$article->getLocalizedTitle()|strip_tags|truncate:160:"...":true|escape}" />
	{if $article->getLocalizedSubject()}
		<meta name="keywords" content="{$article->getLocalizedSubject()|escape}" />
	{/if}

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	{include file="article/dublincore.tpl"}
	{include file="article/googlescholar.tpl"}
	{call_hook name="Templates::Article::Header::Metadata"}

	{* Added touch icons & tile 4 phones *}
	<link rel="apple-touch-icon" sizes="57x57" href="http://www.relacionesinternacionales.info/apple-icon-57x57.png" />
	<link rel="apple-touch-icon" sizes="72x72" href="http://www.relacionesinternacionales.info/apple-icon-72x72.png" />
	<link rel="apple-touch-icon" sizes="114x114" href="http://www.relacionesinternacionales.info/apple-icon-114x114.png" />
	<link rel="apple-touch-icon" sizes="144x144" href="http://www.relacionesinternacionales.info/apple-icon-144x144.png" />
	<meta name="msapplication-TileImage" content="http://www.relacionesinternacionales.info/tile.png" />
	<meta name="msapplication-TileColor" content="#a46ea5" />
	
	
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/pkp.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/articleView.css" type="text/css" />
	{if $journalRt && $journalRt->getEnabled()}
		<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/rtEmbedded.css" type="text/css" />
	{/if}
	
	{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
	{*
	{if $leftSidebarCode || $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/sidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/leftSidebar.css" type="text/css" />{/if}
	*}
	{if $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode && $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" />{/if}

	{*{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}*}
	
	{* Google Fonts *}
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300" type="text/css" />
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,600,700" type="text/css" />
	<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Crimson+Text:400,700,600' type='text/css'>	
	
	<!-- Base Jquery -->
	{if $allowCDN}<script type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script type="text/javascript">{literal}
		// Provide a local fallback if the CDN cannot be reached
		if (typeof google == 'undefined') {
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js' type='text/javascript'%3E%3C/script%3E"));
		} else {
			google.load("jquery", "{/literal}{$smarty.const.CDN_JQUERY_VERSION}{literal}");
			google.load("jqueryui", "{/literal}{$smarty.const.CDN_JQUERY_UI_VERSION}{literal}");
		}
	{/literal}</script>
	{else}
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	{/if}

	<!-- Compiled scripts -->
	{* Disabled *}
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}	

	{$additionalHeadData}
	
	{* CSS style switcher *}	
	{php} 
		if(!empty($_COOKIE['style'])) $style = $_COOKIE['style'];
		else $style = 'custom';
	{/php}	
	<link id="stylesheet" type="text/css" href="{$baseUrl}/override/css/{php}echo $style{/php}.css" rel="stylesheet" />
	<link rel="stylesheet" href="{$baseUrl}/override/css/tablet.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/override/css/mobile.css" type="text/css" />
	
	<!-- AddThis Button BEGIN -->
	<script type="text/javascript">{literal}var addthis_config = {"data_track_clickback":true};{/literal}</script>
	<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=ra-4daff76407fac526"></script>
	<!-- AddThis Button END -->
	
	<!-- Begin Cookie Consent plugin by Silktide - http://silktide.com/cookieconsent -->
	<script type="text/javascript">
	   {literal} window.cookieconsent_options = {"message":"{/literal}{translate key=frontpage.cookiesPolicy}{literal}","dismiss":"{/literal}{translate key=frontpage.cookiesPolicyAccept}{literal}","learnMore":"{/literal}{translate key=frontpage.ReadMore}{literal}","link":"http://www.relacionesinternacionales.info/ojs/pages/view/politica-cookies.html","theme":false, "expiryDays":90};
	   {/literal}
	</script>
	
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
	<div id="sub-container" >
		<div id="breadcrumb">
			<a href="{$baseUrl}/index.html" target="_parent">{translate key="navigation.home"}</a> &bull;
			<a href="{$baseUrl}/issue/archive.html" target="_parent">{translate key="issue.issues"}</a> &bull;
			{if $issue}
				<a href="{$baseUrl}/issue/view/{$issue->getBestIssueId($currentJournal)}.html" target="_parent">{$issue->getIssueTitle(false,true)|escape} | {$issue->getIssueIdentification(false,true)|escape}</a> &bull;
			{/if}
			<a href="{url page="article" op="view" path=$articleId|to_array:$galleyId}" class="current" target="_parent">
				{foreach from=$article->getAuthors() item=author name=authorList}{$author->getLastName()|escape}
					{if !$smarty.foreach.authorList.last},{/if}
				{/foreach}
			</a>
		</div>
		
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
				<div id="content-article" itemscope itemtype="http://schema.org/ScholarlyArticle">
			
