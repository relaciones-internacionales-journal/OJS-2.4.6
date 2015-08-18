/**
 *
 * -------------------------------------------
 * Script for mobile menu
 * -------------------------------------------
 *
 **/
(function($) {
	$(function() {
		$(".mobile-menu-dropdown-link").on('click', function(event) {
		event.preventDefault(); 
		$("#menu-princ-mobile").slideToggle("slow");
		});
		  
		$(".mobile-lang-dropdown-link").on('click', function(event) {
		event.preventDefault(); 
		$("#mobile-language").slideToggle("slow");
		});
		  
		$(".mobile-styles-dropdown-link").on('click', function(event) {
		event.preventDefault();
		$("#mobile-styles").slideToggle("slow");
		});
		  
		$(".mobile-social-dropdown-link").on('click', function(event) {
		event.preventDefault();
		$("#mobile-social").slideToggle("slow");
		});
		  
		$(".mobile-search-dropdown-link").on('click', function(event) {
		event.preventDefault();
		$("#mobile-search").slideToggle("slow");
		});
	});
}(jQuery));