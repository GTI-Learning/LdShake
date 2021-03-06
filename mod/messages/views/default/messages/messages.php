<?php

	/**
	 * Elgg messages individual view
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
	 * 
	 * @uses $vars['entity'] Optionally, the message to view
	 * @uses get_input('type') If the user accesses the message from their sentbox, this variable is passed
	 * and used to make sure the correct icon and name is displayed
	 */
	 
    // set some variables to use below
	if(get_input("type") == "sent"){
    	
        // send back to the users sentbox
        $url = $vars['url'] . "mod/messages/sent.php";
        
        //this is used on the delete link so we know which type of message it is 
        $type = "sent";
        
    } else {
        
        //send back to the users inbox
        $url = $vars['url'] . "pg/messages/" . $vars['user']->username;
        
        //this is used on the delete link so we know which type of message it is 
        $type = "inbox";
        
    }
	 
    if (isloggedin())
    if (isset($vars['entity'])) {
    	if ($vars['entity']->toID == $vars['user']->guid
    		|| $vars['entity']->owner_guid == $vars['user']->guid) {
    		
?>
    <!-- get the correct return url -->
    <div id="messages_return"><!-- start of messages_return div -->
         <p><a href="<?php echo $url; ?>">&laquo; <?php echo T("back to messages"); ?></a></p>
    </div><!-- end of messages_return div -->
    
    <div class="messages_single"><!-- start of the message div -->
    
        <div class="messages_single_icon"><!-- start of the message_user_icon div -->
            <!-- get the user icon, name and date -->
            <?php
                // we need a different user icon and name depending on whether the user is reading the message
                // from their inbox or sentbox. If it is the inbox, then the icon and name will be the person who sent
                // the message. If it is the sentbox, the icon and name will be the user the message was sent to
                if($type == "sent"){
                    //get an instance of the user who the message has been sent to so we can access the name and icon
                    $user_object = get_entity($vars['entity']->toId);
                    //get the icon
                    echo " " . elgg_view("profile/icon",array('entity' => $user_object, 'size' => 'tiny'));
                    //get the name
                    echo "<br class=\"clearfloat\" /><p>".T("To").": <b>" . $user_object->name . "</b><br />";
                }else{
                    //get the icon
                    echo " " . elgg_view("profile/icon",array('entity' => $vars['entity']->getOwnerEntity(), 'size' => 'tiny'));
                    //get the name
                    echo "<br class=\"clearfloat\" /><p>".T("From").": <b>" . $vars['entity']->getOwnerEntity()->name . "</b><br />";
                }
            ?>
            <!-- get the time the message was sent -->
            <small><?php echo friendly_time($vars['entity']->time_created); ?></small>
            </p>
        </div><!-- end of the message_user_icon div -->
        
        <div class="message_body"><!-- start of div message_body -->
        
        <?php
		    //if the message is a reply, display the message the reply was for
		    //I need to figure out how to get the description out using -> (anyone?)
		    if($main_message = $vars['entity']->getEntitiesFromRelationship("reply")){
        		
    		    if($type == "sent"){
        		    echo "<div class='previous_message'><div class=\"previous_message_title\">".T("Original message").":</div><p>";
    		    }else{
    		        echo "<div class='previous_message'><div class=\"previous_message_title\">".T("Your message").":</div><p>";
		        }
		        
    		    echo $main_message[0][description] . "</p></div>";
        			
    	    }
    	?>
        
        <!-- display the title -->
        <div class="actiontitle">
		<h3><?php echo $vars['entity']->title; ?></h3>
		</div>
		
		<!-- display the message -->
		<div class="messagebody">
		<p><?php echo $vars['entity']->description; ?></p>
		</div>
		
		<!-- display the edit options, reply and delete -->
		<div class="message_options"><!-- start of the message_options div -->
		
		    <p><?php if($type != "sent")echo "<a href=\"javascript:void(0);\" class='message_reply buttonlike'>".T("Reply")."</a> &nbsp; "; ?> <?php echo elgg_view("output/confirmlink", array(
																'href' => $vars['url'] . "action/messages/delete?message_id=" . $vars['entity']->getGUID() . "&type={$type}",
																'class' => 'buttonlike',
																'text' => T("Delete"),
																'confirm' => T("Are you sure you want to delete this message?"),
															)); ?>
		    </p>
		</div><!-- end of the message_options div -->
		
		</div><!-- end of div message_body -->
              
		<!-- display the reply form -->
		<div id="message_reply_form">
			<form action="<?php echo $vars['url']; ?>action/messages/send" method="post" name="messageForm">
				<!-- populate the title space with the orginal message title, inserting re: before it -->						        
				<div style="float:left; padding-top:7px; padding-right: 15px; text-align:right; width: 50px;"><?php echo T("Title"); ?>:</div><input type='text' name='title' class="input-text" value="RE: <?php echo htmlspecialchars ($vars['entity']->title); ?>" style="width:660px;" />
				<div style="clear:both; height:20px;"></div>
				<div><?php echo T("Message"); ?>
				<textarea class="input-textarea" name="message" style="height: 300px; margin-top: 5px;"></textarea>
				</div>
				<p>
	        			<?php
                
	            				//pass across the guid of the message being replied to
    	        				echo "<input type='hidden' name='reply' value='" . $vars['entity']->getGUID() . "' />";
    	        				//pass along the owner of the message being replied to
    	        				echo "<input type='hidden' name='send_to' value='" . $vars['entity']->owner_guid . "' />";
                                if($vars['entity']->groupReply)
                                    echo "<input type='hidden' name='non_member_group_reply' value='" . $vars['entity']->nonMemberGroupReply . "' />";
	
	        			?>
	        			<input type="submit" class="submit_button" value="<?php echo T("Send"); ?>" />
                        <?php
                        if($vars['entity']->groupReply) {
                        ?>
                        <input id="group_submit" type="submit" class="submit_button" value="<?php echo T("Reply to all"); ?>" />
                        <?php
                        }
                        ?>

				</p>
			</form>
            <script type="text/javascript" src="<?php echo $vars['url']; ?>vendors/jquery/jquery-1.4.3.min.js"></script>
            <script type="text/javascript">
                $('input#group_submit').click(function() {
                    $('input[name=send_to]').val('<?php echo $vars['entity']->groupReply ?>');
                    $('form[name=messageForm]').submit();
                });
            </script>
		</div><!-- end of div reply_form -->

    </div><!-- end of the message div -->
	
<?php
    		}
    }
?>