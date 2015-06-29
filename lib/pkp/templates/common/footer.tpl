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
 
<div id="sidebar_phones">
	<div class="block" >
		<div class="blockTitleModified">{translate key="plugins.block.navigation.journalContent"}</div>
		{if $currentJournal}
		<span class="blockSubtitle"></span>
		<ul class="sidebar_block_list_search">
			<li class="sd_bl_search_issue"><a href="{$baseUrl}/issue/archive.html">{translate key="navigation.browseByIssue"}</a></li>
			<li class="sd_bl_search_author"><a href="{$baseUrl}/search/authors.html">{translate key="navigation.browseByAuthor"}</a></li>
			<li class="sd_bl_search_title"><a href="{$baseUrl}/search/titles.html">{translate key="navigation.browseByTitle"}</a></li>
			<li class="sd_bl_search"><a href="{$baseUrl}/search/index.html">{translate key="navigation.advanced.search"}</a></li>
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
		<div class="row-fluid">
			<div class="span9">	
				<div class="footer-about-journal">
					<h2>Relaciones Internacionales</h2>
					<p>{translate key="footer.multilanguage"}</p>
				</div>
			</div>
			<div class="span3">			
				<div class="footer-logo-uam">
					<a href="http://www.uam.es" title="UAM" target="_blank">UAM</a>
				</div>				
			</div>			
		</div>
		
		<div class="row-fluid">
			<div class="span9">			
				<div class="footer-ojs-tools"> 
					<ul>
						<li class="footer-content-cc"><a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">BY-NC-SA</a></li>
						<li class="footer-content-oa"><a href="http://open-access.net/de_en/homepage/">OPEN ACESS</a></li>
						<li class="footer-content-lockss"><a href="http://lockss.stanford.edu/lockss/Home">LOCKSS</a></li>
						<li class="footer-content-dc"><a href="http://dublincore.org/">DUBLIN CORE</a></li>
						<li class="footer-content-pkp"><a href="http://pkp.sfu.ca/">PKP</a></li>
					</ul>
				</div>
			</div>
			
			<div class="span3">
				<div class="footer-nav">
					<ul>
						<li><a href="{$baseUrl}/about/contact.html">{translate key="footer.menuContact"}</a></li>
					</ul>
				</div>
				<div class="back-to-top" id="back-top">
					<a href="#" class="back-to-top">Top</a>
				</div>
			
					
				<script type="text/javascript">
				$('#back-to-top"').bind('click', function(e) {
				   e.preventDefault();
				   $('html, body').animate({ scrollTop: $(this.hash).offset().top }, "3000", "easeIn");

				   // edit: Opera requires the "html" elm. animated
				});
				</script>
			</div>
		</div>
	</div>	
</div>

{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}

</div><!-- container -->

{* JS Style switcher *}
<script type="text/javascript">
	$('#style-switcher a').styleSwitcher();
</script>

{* JS Carousel *}	
<script type="text/javascript" src="http://www.relacionesinternacionales.info/min/g=jscarrousel"></script>
<script type="text/javascript">
	$('#ca-container').contentcarousel();
</script>
	
</body>
</html>
{* MODIFICADO OJS V.2.4.6 / 06-2015*}