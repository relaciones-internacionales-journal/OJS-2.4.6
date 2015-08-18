# ojs-2-4-6
This is our current published Open Journal System installation. Changes from our previous version are now cleaner and easier to mantain. 

<b>Features:</b><br>
- OJS 2.4.6 modifications (OJS GitHub https://github.com/pkp/ojs):
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
  - Google Fonts: Roboto (<h2>, <h3>, <h4>), Open Sans (<p>, <a>, etc), Crimson Text (<h1>)
  - Override folder: includes all template changes, except those made in lib > pkp  subfolders and plugins folders. Also contains custom CSS and JS files.


- Plugins developed/updated/modified:
  - Plugin AddCssJs: used to add:
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

  - Plugin IssueCarousel: from Ictineo’s plugin: https://github.com/ictineo/ojs-issueCarousel. Updated to 2.4.6 and modified. See:
  - Block plugins and some block.tpl files: modified to add FontAwesome and CSS rules.

  - PHP & JS Style switcher.  Source: http://code.tutsplus.com/tutorials/jquery-style-switcher--net-532
  - Google Fonts: 
    - Roboto Condensed. Source:  http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300
    - Open Sans. Source: http://fonts.googleapis.com/css?family=Open+Sans:300,600,700
    - Crimson Text. Source: http://fonts.googleapis.com/css?family=Crimson+Text:400,700,600
  - JS Circular Content Carousel. Source: http://tympanus.net/codrops/2011/08/16/circular-content-carousel/
  - Minified CSS & JS via PHP. Source: https://github.com/mrclay/minify

# Notes & Recommendations
- OJS folders /cache/ /public/ and /files/ not provided. Neither config.inc.php for security reasons. So most images will not be available.
- This OJS is installed in a subfolder.
- Our hosting configuration forced us to hard code most OJS internal links and create lot's of weird .htaccess rules. USUALLY YOU WILL NOT HAVE TO CHANGE OR ADD THIS.
- Some config.inc.php configurations:<br>
base_url = "http://www.relacionesinternacionales.info/ojs"<br>
disable_path_info = On<br>
restful_urls = Off<br>
repository_id = oai.relacionesinternacionales.info

