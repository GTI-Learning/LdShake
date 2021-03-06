<?php
	/**
	 * Provide a way of setting your email
	 * 
	 * @package Elgg
	 * @subpackage Core
	 * @license http://www.gnu.org/licenses/old-licenses/gpl-2.0.html GNU Public License version 2
	 * @author Curverider Ltd
	 * @copyright Curverider Ltd 2008
	 * @link http://elgg.org/
	 */

	$user = page_owner_entity();
	
	if ($user) {
?>
	<h3><?php echo T("Email settings"); ?></h3>
	<p>
		<?php echo T("Your email address"); ?>:
		<?php

			echo elgg_view('input/email',array('internalname' => 'email', 'value' => $user->email));
		
		?> 
	</p>

<?php } ?>