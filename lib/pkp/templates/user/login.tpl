{**
 * templates/user/login.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{strip}
{assign var="pageTitle" value="user.login"}
{include file="common/header.tpl"}
{/strip}

{if !$registerOp}
	{assign var="registerOp" value="register"}
{/if}
{if !$registerLocaleKey}
	{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/if}

{if $loginMessage}
	<span class="instruct">{translate key="$loginMessage"}</span>
	<br />
	<br />
{/if}

{if $implicitAuth}
	<a id="implicitAuthLogin" href="{url page="login" op="implicitAuthLogin"}">Login</a>
{else}
	<div class="login-form">
	<form id="signinForm" method="post" action="{$loginUrl}" class="form-horizontal">
{/if}

{if $error}
	<div class="alert alert-block">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<p>{translate key="$error" reason=$reason}</p>
	</div>
	<br />
	<br />
{/if}

<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />

{if ! $implicitAuth}

	<div class="input-group">
		<span class="input-group-addon" id="basic-addon1"><i class="fa fa-user"></i></span>
		<input type="text" class="textField form-control" id="loginUsername" placeholder="{translate key="user.username"}" name="username" value="{$username|escape}" size="20" maxlength="32">		
	</div>
	
	<div class="input-group">
		<span class="input-group-addon" id="basic-addon2"><i class="fa fa-key"></i></span>
		<input type="password" class="textField form-control" id="loginPassword" placeholder="{translate key="user.password"}" name="password" value="{$password|escape}" size="20" maxlength="32">
		</div>
	</div>
	
	<input type="submit" value="{translate key="user.login"}" class="btn" />
	{if !$hideRegisterLink}<p class="login-register"><a href="{url page="user" op=$registerOp}">{translate key=$registerLocaleKey}</a></p>{/if}
	<p class="login-lost-password"><a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a></p>
	</div>
  
{/if}{* !$implicitAuth *}

<script type="text/javascript">
<!--
	document.getElementById('{if $username}loginPassword{else}loginUsername{/if}').focus();
// -->
</script>
</form>
</div>

{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.6 / 06-2015*}