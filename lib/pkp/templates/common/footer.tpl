{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}
 
<div id="sidebar-phones">
	<div class="block" >
		<div class="block-title-modified">{translate key="plugins.block.navigation.journalContent"}</div>
		{if $currentJournal}
		<ul class="sidebar-block-list-search">
			<li class="sd-bl-search-issue"><a href="{$baseUrl}/issue/archive.html">{translate key="navigation.browseByIssue"}</a></li>
			<li class="sd-bl-search-author"><a href="{$baseUrl}/search/authors.html">{translate key="navigation.browseByAuthor"}</a></li>
			<li class="sd-bl-search-title"><a href="{$baseUrl}/search/titles.html">{translate key="navigation.browseByTitle"}</a></li>
			<li class="sd-bl-search"><a href="{$baseUrl}/search/index.html">{translate key="navigation.advanced.search"}</a></li>
			{call_hook name="Plugins::Blocks::Navigation::BrowseBy"}
		</ul>
		{/if}
	</div>
</div>
 
{if $displayCreativeCommons}
	{translate key="common.ccLicense"}
{/if}
{if $pageFooter}
	<br /><br />
	{$pageFooter}
{/if}
{call_hook name="Templates::Common::Footer::PageFooter"}

</div><!-- content -->
</div><!-- main -->
</div><!-- supramain -->
</div><!-- sub_container -->
</div><!-- general -->

<div id="footer">
	<div class="footer-container">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-9">	
					<div class="footer-about-journal">
						<h2>Relaciones Internacionales</h2>
						<p>{translate key="footer.multilanguage"}</p>
					</div>
				</div>
				<div class="col-md-3">			
					<div class="footer-logo-uam">
						<a href="http://www.uam.es" title="UAM" target="_blank">UAM</a>
					</div>				
				</div>			
			</div>
		
		<div class="row">
			<div class="col-md-9">			
				<div class="footer-ojs-tools"> 
					<ul>
						<li class="footer-content-cc"><a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">BY-NC-SA</a></li>
						<li class="footer-content-oa"><a href="http://open-access.net/de_en/homepage/">OPEN ACESS</a></li>
						<li class="footer-content-github"><a href="https://github.com/relaciones-internacionales-journal">GITHUB</a></li>
						<li class="footer-content-dc"><a href="http://dublincore.org/">DUBLIN CORE</a></li>
						<li class="footer-content-pkp"><a href="http://pkp.sfu.ca/">PKP</a></li>
					</ul>
				</div>
			</div>
			
			<div class="col-md-3">
				<div class="footer-nav">
					<ul>
						<li><a href="{$baseUrl}/about/contact.html">{translate key="footer.menuContact"}</a></li>
					</ul>
				</div>
				<div class="back-to-top" id="back-top">
					<a href="#" class="back-to-top">Top</a>
				</div>
			
				{literal}	
				<script type="text/javascript">
				$('#back-to-top"').bind('click', function(e) {
				   e.preventDefault();
				   $('html, body').animate({ scrollTop: $(this.hash).offset().top }, "3000", "easeIn");

				   // edit: Opera requires the "html" elm. animated
				});
				</script>
				{/literal}
			</div>
		</div>
	</div>	
</div>

{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}

</div><!-- container -->

{* JS Carousel*}
{if $smarty.get.page == 'index'}
	<script type="text/javascript">
	{literal}
		$('#ca-container').contentcarousel();
	{/literal}
	</script>
{else}
{* Do nothing here so carousel.js is not displayed on any other page*}
{/if}		

{*<script type="text/javascript" src="http://www.relacionesinternacionales.info/min/g=jscarrousel"></script>*}	
</body>
</html>
{* MODIFICADO OJS V.2.4.6 / 06-2015*}