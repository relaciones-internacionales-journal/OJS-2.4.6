# About
This is our current published Open Journal System 2.4.6 installation. Changes from our previous version are now cleaner and easier to mantain. 

# Features
- <b>OJS 2.4.6 modifications</b> (OJS GitHub https://github.com/pkp/ojs):
  - Bootstrap 3.3.5
  - FontAwesome 4.3
  - JQuery 1.11.3 (needed for BS)
  - JQuery Migrate 1.2.1
  - Custom back-end and front-end design
  - Responsive design: mobile, tablet and desktop CSS stylesheets
  - User can choose between 2 styles, dark & light
  - Sticky header in desktop version
  - Menu toggle in mobile & tablet versions
  - Issues + Articles Carousel in journal frontpage
  - Cookies Notice
  - Google Structured Data Markup added in article and issues templates
  - Google Fonts: Roboto (`<h2>`, `<h3>`, `<h4>`), Open Sans (`<p>`, `<a>`, etc), Crimson Text (`<h1>`)
  - Override folder: includes all template changes, except those made in lib > pkp  subfolders and plugins folders. Also contains custom CSS and JS files.

- <b>Plugins developed/updated/modified:</b>
  - Plugin AddCssJs (stand alone plugin:https://github.com/relaciones-internacionales-journal/add-CSS-JS-plugin). Used to add:
    - CSS files:
      - font-awesome.min.css (external file)
      - bootstrap.min.css (external file)
      - carousel.css (in override > css folder)

    - JS files:
      - jquery-1.11.3.min.js (external file)
      - bootstrap.min.js (external file)
      - jquery.contentcarousel.js (in override > js folder)
      - jquery.easing.1.3.js (in override > js folder)
      - jquery.mousewheel.js (in override > js folder)
      - styleswitcher.jquery.js (in override > js folder)
      - jquery.menutoggle.js (in override > js folder)
      - cookieconsent.js (in override > js folder)

  - Plugin IssueCarousel: from Ictineo’s plugin: https://github.com/ictineo/ojs-issueCarousel. Updated to 2.4.6 and modified. See: https://github.com/relaciones-internacionales-journal/issue-carousel-plugin
  - Block plugins and some block.tpl files: modified to add FontAwesome and CSS rules.

- <b>Other:</b>
  - PHP & JS Style switcher.  Source: http://code.tutsplus.com/tutorials/jquery-style-switcher--net-532
  - Google Fonts: 
    - Roboto Condensed. Source:  http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300
    - Open Sans. Source: http://fonts.googleapis.com/css?family=Open+Sans:300,600,700
    - Crimson Text. Source: http://fonts.googleapis.com/css?family=Crimson+Text:400,700,600

# Installation
- Install OJS 2.4.6 (OJS GitHub https://github.com/pkp/ojs)
- Download our OJS customization and unzip it.
- Upload to your server (or overwrite):
  - file lib > pkp > classes > template > PKPTemplateManager.inc.php
  - folder lib > pkp > templates
  - folder plugins (or at least block plugins folder + addCssJs plugin + issueCarousel plugin)
  - folder override
- Customize!

# License
Same as OJS, see: https://github.com/pkp/ojs, that is released under the the <a href="https://github.com/pkp/ojs/blob/master/docs/COPYING" target="_blank">GNU General Public License</a>.

# Further customizations
- <b>CSS:</b> custom CSS files are stored in override > css. These stylesheet are loaded after any other stylesheet so they're called by header.tpl (article > header.tpl and lib > pkp > templates > common > header.tpl), not by any plugin.
  - mobile.css: for 50px to 600px devices
  - tablet.css: for 601px to 796px devices
  - custom.css and custom-light.css: for 797px to anything devices.

- <b>JS:</b> Bootstrap 3.3.5 needs jQuery 1.11 and OJS works with jQuery 1.08 (I think). So, even if we use jQuery Migrate sometimes conflicts arise. In order to avoid this, custom JS like the one used to toggle the menu in tablet and mobile devices should be enclosed like:
`(function($) {
	$(function() {
		$(".mobile-menu-dropdown-link").on('click', function(event) {
		event.preventDefault(); 
		$("#menu-princ-mobile").slideToggle("slow");
		});
	});
}(jQuery));`

- <b>Templates overwrite:</b> all modified templates are stored in override > templates folder, except those used in lib > pkp > templates. If you want to change another OJS  template, just copy the original .tpl file to his related folder in override > templates (or create a new folder named as the OJS original one) and change whatever you want.

# Notes & Recommendations
- OJS folders /cache/ /public/ and /files/ not provided. Neither config.inc.php for security reasons. 
- This OJS is installed in a subfolder.

# Issues
- <b>JS conflicts:</b> solution explained above.
- <b>Templates links:</b> Our hosting configuration forced us to hard code most OJS internal links and create lot's of weird .htaccess rules. So you may have to change some links in .tpl files in override > templates

