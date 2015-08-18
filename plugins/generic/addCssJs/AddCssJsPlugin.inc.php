<?php

/**
 * @file plugins/generic/addCssJs/AddCssJsPlugin.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class AddCssJsPlugin
 * @ingroup plugins_generic_addCssJs
 *
 * @brief Makes possible to add new CSS and JS 
 */

import('lib.pkp.classes.plugins.GenericPlugin');

class AddCssJsPlugin extends GenericPlugin {
	/**
	 * @see PKPPlugin::register()
	 */
	function register($category, $path) {
		if (parent::register($category, $path)) {
			if ($this->getEnabled()) {
			HookRegistry::register('TemplateManager::display', array(&$this, 'AddCssLinks'));
			HookRegistry::register('Templates::Common::Footer::PageFooter', array($this, 'addJsToFooter'));
			HookRegistry::register('Templates::Article::Footer::PageFooter', array($this, 'addJsToFooter'));
			HookRegistry::register('Templates::Article::Interstitial::PageFooter', array($this, 'addJsToFooter'));
			HookRegistry::register('Templates::Article::PdfInterstitial::PageFooter', array($this, 'addJsToFooter'));
			HookRegistry::register('Templates::Rt::Footer::PageFooter', array($this, 'addJsToFooter'));
			HookRegistry::register('Templates::Help::Footer::PageFooter', array($this, 'addJsToFooter'));
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
		return __('plugins.generic.addCssJs.displayName');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription() {
		return __('plugins.generic.addCssJs.description');
	}
	
	/**
	 * Get the template path for this plugin.
	 */
	function getTemplatePath() {
		return parent::getTemplatePath() . 'templates/';
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
	 * Add to Head external / uploaded to server CSS and JS
	 */
	function AddCssLinks($hookName, $args) {
		if ($this->getEnabled()) {	
			$templateMgr =& $args[0]; 
			$currentJournal =& $templateMgr->get_template_vars('currentJournal');
			
			if ($currentJournal) {
				$addCssURL = $this->getSetting($currentJournal->getId(), 'addCssURL');
				$addJsURL = $this->getSetting($currentJournal->getId(), 'addJsURL');				
				$additionalHeadData = $templateMgr->get_template_vars('additionalHeadData');
				
				if ($addCssURL) {
					$CssToAdd = explode(",", $addCssURL);	
					$extraCssUrls = "";
					foreach ($CssToAdd as $newCss) {						
						$extraCssUrls .= '<link rel="stylesheet" href="'.$newCss.'" type="text/css" />';
					}					
					$AddToHeadCssUrls = $extraCssUrls;
				}	

				if ($addJsURL) {
					$JsToAdd = explode(",", $addJsURL);	
					$extraJsUrls = "";
					foreach ($JsToAdd as $newJS) {
						$extraJsUrls .= '<script src="'.$newJS.'"></script>';
					}				
					$AddToHeadJsUrls = $extraJsUrls;
				}
			
				if ((!empty($AddToHeadCssUrls)) && (!empty($AddToHeadJsUrls))) {
					$templateMgr->assign('additionalHeadData', $additionalHeadData."\n\t".$AddToHeadCssUrls."\n\t".$AddToHeadJsUrls);
				}
				
				elseif ((empty($AddToHeadCssUrls)) && ($AddToHeadJsUrls)) {
					$templateMgr->assign('additionalHeadData', $additionalHeadData."\n\t".$AddToHeadJsUrls);
				}
				
				elseif (($AddToHeadCssUrls) && (empty($AddToHeadJsUrls))) {
					$templateMgr->assign('additionalHeadData', $additionalHeadData."\n\t".$AddToHeadCssUrls);
				}			
			}			
		}

		return false;
	}
	
	/**
	 * Add to footer external / uploaded to server JS
	 */

	function addJsToFooter($hookName, $params) {
		$smarty =& $params[1];
		$output =& $params[2];
		$templateMgr =& TemplateManager::getManager();
		$currentJournal = $templateMgr->get_template_vars('currentJournal');

		if (!empty($currentJournal)) {
			$journal =& Request::getJournal();
			$journalId = $journal->getId();
			$addJsURLFooter = $this->getSetting($journalId, 'addJsURLFooter');				
			$JsToAddFooter = explode(",", $addJsURLFooter);	
			$extraJsUrlsFooter = "";
			foreach ($JsToAddFooter as $newJsFooter) {						
				$extraJsUrlsFooter .= '<script src="'.$newJsFooter.'"></script>';
			}
			
			$AddToFooterJsUrls = $extraJsUrlsFooter;

			$templateMgr->assign('AddToFooterJsUrls', $AddToFooterJsUrls);
			
			$output .= $templateMgr->fetch($this->getTemplatePath() . 'footerJs.tpl');			
		}
		return false;
	}

	/**
	 * Display verbs for the management interface.
	 */
	function getManagementVerbs() {
		$verbs = array();
		if ($this->getEnabled()) {
			$verbs[] = array('settings', __('plugins.generic.addCssJs.settings'));
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