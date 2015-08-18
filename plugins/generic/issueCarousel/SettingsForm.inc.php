<?php

/**
 * @file SettingsForm.inc.php
 *
 * Copyright (c) 2013 Projecte Ictineo (www.projecteictineo.com)
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 * Updated for 2.4.6 by Relaciones Internacionales OJS Team
 *
 * @class SettingsForm
 * @ingroup plugins_generic_issueCarousel
 *
 * @brief Form for journal managers to modify issue carousel plugin settings
 */

// $Id$


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
		
		$this->setData('selectedCarouselIssues', $plugin->getSetting($journalId, 'selectedCarouselIssues'));
	}

	/**
	 * Assign form data to user-submitted data.
	 */
	function readInputData() {
		$this->readUserVars(array('selectedCarouselIssues'));
	}

	/**
	 * Save settings. 
	 */
	function execute() {
		$plugin =& $this->plugin;
		$journalId = $this->journalId;
		
		$plugin->updateSetting($journalId, 'selectedCarouselIssues', $this->getData('selectedCarouselIssues'));		
	}
}

?>
