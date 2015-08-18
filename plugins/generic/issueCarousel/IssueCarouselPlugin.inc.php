<?php

/**
 * @file IssueCarouselPlugin.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Updated for 2.4.6 by Relaciones Internacionales OJS Team
 *
 * @class IssueCarouselPlugin
 * @ingroup plugins_generic_issueCarousel
 *
 * @brief issueCarousel plugin class
 */


import('lib.pkp.classes.plugins.GenericPlugin');

class IssueCarouselPlugin extends GenericPlugin {
	function register($category, $path) {
		if (parent::register($category, $path)) {
			if ($this->getEnabled()) {
				HookRegistry::register('TemplateManager::display::formCarouselIssuesList',array(&$this, 'FormCarouselIssuesList'));
				HookRegistry::register('Templates::Index::journal::issueCarousel',array(&$this, 'callbackInsertCarousel'));
				HookRegistry::register('Templates::Index::journal::MobileIssuesList',array(&$this, 'callbackMobileInsertIssuesList'));
			}
			return true;
		}
		return false;
	}

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName() {
		return __('plugins.generic.issuecarousel.displayName');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription() {
		return __('plugins.generic.issuecarousel.description');
	}
	
	/**
	 * Get the template path for this plugin.
	 */
	function getTemplatePath() {
		return parent::getTemplatePath() . 'templates/';
	}
	  
	/**
	 * Get the name of the settings file to be installed on new journal
	 * creation.
	 * @return string
	 */
	function getContextSpecificPluginSettingsFile() {
		return $this->getPluginPath() . '/settings.xml';
	}

	/**
	 * Set the page's breadcrumbs, given the plugin's tree of items
	 * to append.
	 * @param $subclass boolean
	 */
	function setBreadcrumbs($isSubclass = false) {
		$templateMgr =& TemplateManager::getManager();
		$pageCrumbs = array(
			array(
				Request::url(null, 'user'),
				'navigation.user'
			),
			array(
				Request::url(null, 'manager'),
				'user.role.manager'
			)
		);
		if ($isSubclass) $pageCrumbs[] = array(
			Request::url(null, 'manager', 'plugins'),
			'manager.plugins'
		);

		$templateMgr->assign('pageHierarchy', $pageCrumbs);
	}

	/**
	 * Get Published Issues for Carousel
	 * Articles are retrieved by the template with ugly {php}
	 * because as indicated here:https://pkp.sfu.ca/support/forum/viewtopic.php?f=8&t=4786
	 * the issues objects we get are not "really an array". So this kind of code:
	 *
	 * $issue = $templateMgr->get_template_vars('issue');
	 * $publishedArticles =& $publishedArticleDao->getPublishedArticlesInSections($issueId , true);
	 * $templateMgr->assign_by_ref...
	 *
	 * always get articles as if IssueId = currentIssue, not as IssueId = issue->getIssueId()
	 * Should be an easier way with $issues = $carouselIssues->toArray();
	 */
	 
	 function FormCarouselIssuesList($hookName, $params) {
		$smarty =& $params[1];
		$output =& $params[2];
		$templateMgr =& TemplateManager::getManager();

		$journal =& Request::getJournal();
		$journalId = $journal->getId();
		$issueDao =& DAORegistry::getDAO('IssueDAO');	
				
		$formIssuesList =& $issueDao->getPublishedIssues($journalId);
				
		$templateMgr->assign_by_ref('issues', $formIssuesList);					
		$output .= $templateMgr->fetch($this->getTemplatePath() . 'checkboxIssuesForm.tpl');
								 
	return false;
	}  
	
	function callbackInsertCarousel($hookName, $params) {
		$smarty =& $params[1];
		$output =& $params[2];
		$templateMgr =& TemplateManager::getManager();

		$journal =& Request::getJournal();
		$journalId = $journal->getId();
		$issueDao =& DAORegistry::getDAO('IssueDAO');	
		
		
		$selectedCarouselIssues = $this->getSetting($journalId, 'selectedCarouselIssues');				
		$carouselIssues =& $issueDao->getPublishedIssues($journalId);
		
		$templateMgr->assign_by_ref('selectedCarouselIssues', $selectedCarouselIssues);		
		$templateMgr->assign_by_ref('issues', $carouselIssues);					
		$output .= $templateMgr->fetch($this->getTemplatePath() . 'carousel.tpl');
								 
	return false;
	}  
	
	/**
	 * Get Published Issues for Mobile style (plain list)
	 */
	  
	function callbackMobileInsertIssuesList($hookName, $params) {
		$smarty =& $params[1];
		$output =& $params[2];
		$templateMgr =& TemplateManager::getManager();

		$journal =& Request::getJournal();
		$journalId = $journal->getId();
		$issueDao =& DAORegistry::getDAO('IssueDAO');	
		
		$selectedCarouselIssues = $this->getSetting($journalId, 'selectedCarouselIssues');
		$mobileIssuesList =& $issueDao->getPublishedIssues($journalId);
		
		$templateMgr->assign_by_ref('selectedCarouselIssues', $selectedCarouselIssues);				
		$templateMgr->assign_by_ref('issues', $mobileIssuesList);					
		$output .= $templateMgr->fetch($this->getTemplatePath() . 'mobileIssuesList.tpl');
								 
	return false;
	}  

	/**
	 * Display verbs for the management interface.
	 */
	function getManagementVerbs() {
		$verbs = array();
		if ($this->getEnabled()) {
			$verbs[] = array('settings', __('plugins.generic.issuecarousel.settings'));
		}
		return parent::getManagementVerbs($verbs);
	}

 	/**
	 * Execute a management verb on this plugin
	 * @param $verb string
	 * @param $args array
	 * @param $message string Location for the plugin to put a result msg
	 * @param $messageParams array
	 * @return boolean
	 */
	function manage($verb, $args, &$message, &$messageParams) {
		if (!parent::manage($verb, $args, $message, $messageParams)) return false;

		switch ($verb) {
			case 'settings':
				$templateMgr =& TemplateManager::getManager();
				$templateMgr->register_function('plugin_url', array(&$this, 'smartyPluginUrl'));
				$journal =& Request::getJournal();

				$this->import('SettingsForm');
				$form = new SettingsForm($this, $journal->getId());

				if (Request::getUserVar('save')) {
					$form->readInputData();
					if ($form->validate()) {
						$form->execute();
						Request::redirect(null, 'manager', 'plugins');
						return false;
					} else {
						$this->setBreadCrumbs(true);
						$form->display();
					}
				} else {
					$this->setBreadCrumbs(true);
					$form->initData();
					$form->display();
				}
				return true;
			default:
				// Unknown management verb
				assert(false);
				return false;
		}
	}
}

?>
