<?php

/**
 * @file plugins/generic/addCssJs/SettingsForm.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class SettingsForm
 * @ingroup plugins_generic_addCssJs
 *
 * @brief Form for journal managers to add external or internal CSS stylesheets and Js libraries
 */

import('lib.pkp.classes.form.Form');

class SettingsForm extends Form {

	/** @var $journalId int */
	var $journalId;

	/** @var $plugin object */
	var $plugin;

	/**
	 * Constructor
	 * @param $plugin object
	 * @param $journalId int
	 */
	function SettingsForm(&$plugin, $journalId) {
		$this->journalId = $journalId;
		$this->plugin =& $plugin;

		parent::Form($plugin->getTemplatePath() . 'settingsForm.tpl');
		$this->addCheck(new FormValidatorPost($this));
	}

	/**
	 * Initialize form data.
	 */
	function initData() {
		$journalId = $this->journalId;
		$plugin =& $this->plugin;

		$this->setData('addCssURL', $plugin->getSetting($journalId, 'addCssURL'));
		$this->setData('addJsURL', $plugin->getSetting($journalId, 'addJsURL'));
		$this->setData('addJsURLFooter', $plugin->getSetting($journalId, 'addJsURLFooter'));
	}

	/**
	 * Assign form data to user-submitted data.
	 */
	function readInputData() {
		$this->readUserVars(array('addCssURL', 'addJsURL', 'addJsURLFooter'));
	}

	/**
	 * Save settings. 
	 */
	function execute() {
		$plugin =& $this->plugin;
		$journalId = $this->journalId;

		$plugin->updateSetting($journalId, 'addCssURL', $this->getData('addCssURL'));
		$plugin->updateSetting($journalId, 'addJsURL', $this->getData('addJsURL'));
		$plugin->updateSetting($journalId, 'addJsURLFooter', $this->getData('addJsURLFooter'));
	}
}

?>
