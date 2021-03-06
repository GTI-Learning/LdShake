<?php

    /**
	 * Elgg reply to a message form
	 *
     * @file modified by Interactive Technologies Group (GTI)
     * @authors (alpha. order) Abenia, P., Carralero, M.A., Chacón, J., Hernández-Leo, D., Moreno, P..
     * @Copyright (C) 2009-2012, Universitat Pompeu Fabra, Barcelona.
     * @based on:
	 * @package ElggMessages
	 * @license http://www.gnu.org/licenses/old-licenses/gpl-2.0.html GNU Public License version 2
	 * @author Curverider Ltd <info@elgg.com>
	 * @copyright Curverider Ltd 2008
	 * @link http://elgg.com/
	 *
	 * @uses $vars['entity'] This is the message being replied to
	 *
	 */
	 
?>

<form action="<?php echo $vars['url']; ?>action/messages/send" method="post" name="messageForm">

    <!-- populate the title space with the orginal message title, inserting re: before it -->						        
	<p><label><?php echo T("Title"); ?>: <br /><input type='text' name='title' class="input-text" value='RE:<?php echo $vars['entity']->title; ?>' /></label></p>
	<p><label><?php echo T("Message"); ?>: <br /><textarea name='message' value='' class="input-textarea" /></textarea></label></p>
		
	<p>
	    <?php
                
	        //pass across the guid of the message being replied to
    	    echo "<input type='hidden' name='reply' value='" . $vars['entity']->getGUID() . "' />";
    	    //pass along the owner of the message being replied to
    	    echo "<input type='hidden' name='send_to' value='" . $vars['entity']->owner_guid . "' />";
            echo "<input type='hidden' name='non_member_user_group' value='" . $vars['entity']->nonMemberGroupReply . "' />";

        ?>
	    <input type="submit" class="submit_button" value="<?php echo T("Send"); ?>" />
	</p>
	
</form>
	<?php
        //display the message you are replying to
		if (isset($vars['entity'])) {
    		
    		echo "<h3>" . T("Message replying to") . "</h3>";
    		echo $vars['entity']->description;
    		
		}
    ?>