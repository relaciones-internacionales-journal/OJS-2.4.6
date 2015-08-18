{**
 * templates/submission/instructions.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Submissions instructions page.
 *
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}">
<head>
	<title>{translate key=$pageTitle}</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	
	{* Added touch icons & tile 4 phones *}
	<link rel="apple-touch-icon" sizes="57x57" href="http://www.relacionesinternacionales.info/apple-icon-57x57.png" />
	<link rel="apple-touch-icon" sizes="72x72" href="http://www.relacionesinternacionales.info/apple-icon-72x72.png" />
	<link rel="apple-touch-icon" sizes="114x114" href="http://www.relacionesinternacionales.info/apple-icon-114x114.png" />
	<link rel="apple-touch-icon" sizes="144x144" href="http://www.relacionesinternacionales.info/apple-icon-144x144.png" />
	<meta name="msapplication-TileImage" content="http://www.relacionesinternacionales.info/tile.png" />
	<meta name="msapplication-TileColor" content="#a46ea5" />
	
	{* G+ Publisher *}
	<link rel="publisher" href="https://plus.google.com/">

	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/help.css" type="text/css" />

	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}
	
	{* Google Fonts *}
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300" type="text/css" />
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,600,700" type="text/css" />
	<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Crimson+Text:400,700,600' type='text/css'>	
	
	{* Minified CSS styles 
    <link rel="stylesheet" href="http://www.relacionesinternacionales.info/min/g=css" type="text/css" />*}	
	
	{* Minified JS 
	<script type="text/javascript" src="http://www.relacionesinternacionales.info/min/g=js"></script>*}

	<!-- Compiled scripts -->
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
	
</head>
<body id="modal-instructions">
{literal}
<script type="text/javascript">
<!--
	if (self.blur) { self.focus(); }
// -->
</script>
{/literal}

<div id="container-instructions">
	<div id="body">
		<div id="main">
			<h2>{translate key=$pageTitle}</h2>
			<div id="content">
				<p>{$instructions|nl2br}</p>
				<p><input type="button" onclick="window.close()" value="{translate key="common.close"}" class="btn btn-danger btn-sm" /></p>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="{$baseUrl}/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>

