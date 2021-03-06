<?php

	/**
	 * Elgg profile icon edit form
	 *
     * @file modified by Interactive Technologies Group (GTI)
     * @authors (alpha. order) Abenia, P., Carralero, M.A., Chacón, J., Hernández-Leo, D., Moreno, P..
     * @Copyright (C) 2009-2012, Universitat Pompeu Fabra, Barcelona.
     * @based on:
	 * @package ElggProfile
	 * @license http://www.gnu.org/licenses/old-licenses/gpl-2.0.html GNU Public License version 2
	 * @author Curverider
	 * @copyright Curverider Ltd 2008
	 * @link http://elgg.com/
	 * 
	 * @uses $vars['entity'] The user entity
	 * @uses $vars['profile'] Profile items from $CONFIG->profile, defined in profile/start.php for now 
	 */

?>

<p><?php echo T("The profile picture is the image that's displayed on your profile page. <br /> You can change it as often as you'd like. (File formats accepted: GIF, JPG or PNG)"); ?></p>

<div id="current_user_avatar">

	<label><?php echo T("Current avatar"); ?></label>
	<?php 
		
		$user_avatar = $_SESSION['user']->getIcon('medium');//$vars['url'] . "pg/icon/" . $_SESSION['user']->username . "/medium/" . $_SESSION['user']->icontime . ".jpg";
		echo "<img src=\"{$user_avatar}\" alt=\"avatar\" />";

	?>

</div>

<div id="profile_picture_form">
	<form action="<?php echo $vars['url']; ?>action/profile/iconupload" method="post" enctype="multipart/form-data">
	<p><label><?php echo T("Edit profile icon"); ?></label><br />
	
		<?php

			echo elgg_view("input/file",array('internalname' => 'profileicon'));
		
		?>
		<br /><input type="submit" class="submit_button" value="<?php echo T("Uplaoad"); ?>" />
	</p>
	</form>
</div>
	
<div id="profile_picture_croppingtool">	
<label><?php echo T("Profile picture cropping tool"); ?></label><br />
<p>	
<?php

    echo T("Click and drag a square below to match how you want your picture cropped.  A preview of your cropped picture will appear in the box on the right.  When you are happy with the preview, click 'Create your avatar'. This cropped image will be used throughout the site as your avatar.");
    //display the current user photo 
    $user_master_image = $vars['url'] . "pg/icon/" . $_SESSION['user']->username . "/master/" . $_SESSION['user']->icontime . ".jpg";
    
?>
</p>

<p>
<img id="user_avatar" src="<?php echo $user_master_image; ?>" alt="<?php echo T("Profile picture"); ?>" />
</p>

<div class="clearfloat"></div>

<form action="<?php echo $vars['url']; ?>action/profile/cropicon" method="post" />
	<input type="hidden" name="username" value="<?php echo $vars['user']->username; ?>" />
	<input type="hidden" name="x_1" value="<?php echo $vars['user']->x1; ?>" id="x_1" />
    <input type="hidden" name="x_2" value="<?php echo $vars['user']->x2; ?>" id="x_2" />
    <input type="hidden" name="y_1" value="<?php echo $vars['user']->y1; ?>" id="y_1" />
    <input type="hidden" name="y_2" value="<?php echo $vars['user']->y2; ?>" id="y_2" />
	<input type="submit" name="submit" value="<?php echo elgg_echo("Create your avatar"); ?>" />
</form>

</div>
<div class="clearfloat"></div>

<script type="text/javascript">
var masterimage = '<?php echo $user_master_image ?>';
</script>