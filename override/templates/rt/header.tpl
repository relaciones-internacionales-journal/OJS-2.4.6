{**
 * templates/rt/header.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common header for RT pages.
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}">
<head>
	<title>{translate key="rt.readingTools"}</title>
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
	
	{* G+ Publisher *}
	<link rel="publisher" href="https://plus.google.com/">
	
	{* Disabled *}
	{*
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/pkp.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/articleView.css" type="text/css" />
	{if $journalRt && $journalRt->getEnabled()}
		<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/rtEmbedded.css" type="text/css" />
	{/if}
	*}
	
	{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
	{*
	{if $leftSidebarCode || $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/sidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/leftSidebar.css" type="text/css" />{/if}
	*}
	{if $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode && $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" />{/if}

	{foreach from=$stylesheets item=cssUrl}
		{*<link rel="stylesheet" href="{$cssUrl}" type="text/css" />*}
	{/foreach}
	
	{* Google Fonts *}
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300" type="text/css" />
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,600,700" type="text/css" />
	<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Crimson+Text:400,700,600' type='text/css'>	
	
	{* Font Awesome 4.3 *}
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

	{* Bootstrap 3.3.4 *}
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>	
	
	{* Minified CSS styles *}
    <link rel="stylesheet" href="http://www.relacionesinternacionales.info/min/g=css" type="text/css" />
	
	{* CSS style switcher *}	
	{php} 
		if(!empty($_COOKIE['style'])) $style = $_COOKIE['style'];
		else $style = 'custom';
	{/php}	
	<link id="stylesheet" type="text/css" href="{$baseUrl}/styles/{php}echo $style{/php}.css" rel="stylesheet" />
	
	{* Minified JS *}
	<script type="text/javascript" src="http://www.relacionesinternacionales.info/min/g=js"></script>
	
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
	{*{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}
	*}

	{$additionalHeadData}
	
	<!-- AddThis Button BEGIN -->
	<script type="text/javascript">var addthis_config = {"data_track_clickback":true};</script>
	<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=ra-4daff76407fac526"></script>
	<!-- AddThis Button END -->
	
	<!-- Google Analytics BEGIN -->
	<script type="text/javascript">
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', '']);
	  _gaq.push(['_trackPageview']);
	  
		  (function() {
	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
	</script>
<!-- Google Analytics END -->
</head>
<body id="pkp-{$pageTitle|replace:'.':'-'}">
{literal}
<script type="text/javascript">
<!--
	if (self.blur) { self.focus(); }
// -->
</script>
{/literal}

{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}

<div id="container">

<div id="header">
	<div id="header_container">				
		<div class="headerTitle">
		<h1><a href="{$baseUrl}/index.html">Relaciones Internacionales</a></h1>
		</div>
	</div>
</div>

<div id="body">
<div id="top"></div>

<div id="main">

{literal}
<script type="text/javascript">
<!--
	if (self.blur) { self.focus(); }
// -->
</script>
{/literal}

<h2>{$pageTitleTranslated}</h2>

<div id="content">

{* MODIFICADO OJS V.2.4.6 / 06-2015*}