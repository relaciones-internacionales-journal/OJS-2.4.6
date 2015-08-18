{**
 * templates/search/authorIndex.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Index of published articles by author.
 *
 *}
{strip}
{assign var="pageTitle" value="search.authorIndex"}
{include file="common/header.tpl"}
{/strip}

<hr/>
<ul class="search-results-list-authors">
	{foreach from=$alphaList item=letter}
		<li><a href="{url op="authors" searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a></li> 
	{/foreach} 
</ul>
<hr/>

<div id="authors-list">
{iterate from=authors item=author}
	{assign var=lastFirstLetter value=$firstLetter}
	{assign var=firstLetter value=$author->getLastName()|String_substr:0:1}

	{if $lastFirstLetter|lower != $firstLetter|lower}
			<div id="{$firstLetter|escape}">
		<h3>{$firstLetter|escape}</h3>
			</div>
	{/if}

	{assign var=lastAuthorName value=$authorName}
	{assign var=lastAuthorCountry value=$authorCountry}

	{assign var=authorAffiliation value=$author->getLocalizedAffiliation()}
	{assign var=authorCountry value=$author->getCountry()}

	{assign var=authorFirstName value=$author->getFirstName()}
	{assign var=authorMiddleName value=$author->getMiddleName()}
	{assign var=authorLastName value=$author->getLastName()}
	{assign var=authorName value="$authorLastName, $authorFirstName"}

	{if $authorMiddleName != ''}{assign var=authorName value="$authorName $authorMiddleName"}{/if}
	{strip}
		<p class="single-author"><a href="{url op="authors" path="view" firstName=$authorFirstName middleName=$authorMiddleName lastName=$authorLastName affiliation=$authorAffiliation country=$authorCountry}">{$authorName|escape}</a>
			{if $authorAffiliation}, {$authorAffiliation|escape}{/if}
			{if $lastAuthorName == $authorName && $lastAuthorCountry != $authorCountry}
				{* Disambiguate with country if necessary (i.e. if names are the same otherwise) *}
				{if $authorCountry} ({$author->getCountryLocalized()}){/if}
			{/if}
		</p>
	{/strip}
{/iterate}
{if !$authors->wasEmpty()}
	<p class="pagination">
		{page_info iterator=$authors}&nbsp;&nbsp;&nbsp;&nbsp;{page_links anchor="authors" iterator=$authors name="authors" searchInitial=$searchInitial}
	</p>
{else}
{/if}
</div>
{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.6 / 06-2015*}
