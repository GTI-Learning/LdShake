<?php
	/**
	 * Elgg user sub-component on the main menu.
	 * 
	 * @package Elgg
	 * @subpackage Core
	 * @license http://www.gnu.org/licenses/old-licenses/gpl-2.0.html GNU Public License version 2
	 * @author Curverider Ltd
	 * @copyright Curverider Ltd 2008
	 * @link http://elgg.org/
	 */
?>
<div class="admin-menu-option">
	<h2><?php echo elgg_echo('usersettings:user'); ?> </h2>
	<p><?php echo elgg_echo('usersettings:user:opt:description'); ?><br />
	<a href="<?php echo $CONFIG->wwwroot . "pg/settings/user/"; ?>"><?php echo elgg_echo('usersettings:user:opt:linktext'); ?></a></p>
</div>