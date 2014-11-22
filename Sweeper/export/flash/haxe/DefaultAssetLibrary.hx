package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Font;
import lime.graphics.Image;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if (sys || nodejs)
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Brown_Block.png", __ASSET__assets_images_tiles_brown_block_png);
		type.set ("assets/images/tiles/Brown_Block.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Character Boy.png", __ASSET__assets_images_tiles_character_boy_png);
		type.set ("assets/images/tiles/Character Boy.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Character Cat Girl.png", __ASSET__assets_images_tiles_character_cat_girl_png);
		type.set ("assets/images/tiles/Character Cat Girl.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Character Horn Girl.png", __ASSET__assets_images_tiles_character_horn_girl_png);
		type.set ("assets/images/tiles/Character Horn Girl.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Character Pink Girl.png", __ASSET__assets_images_tiles_character_pink_girl_png);
		type.set ("assets/images/tiles/Character Pink Girl.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Character Princess Girl.png", __ASSET__assets_images_tiles_character_princess_girl_png);
		type.set ("assets/images/tiles/Character Princess Girl.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Chest Closed.png", __ASSET__assets_images_tiles_chest_closed_png);
		type.set ("assets/images/tiles/Chest Closed.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Chest Lid.png", __ASSET__assets_images_tiles_chest_lid_png);
		type.set ("assets/images/tiles/Chest Lid.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Chest Open.png", __ASSET__assets_images_tiles_chest_open_png);
		type.set ("assets/images/tiles/Chest Open.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Dirt Block.png", __ASSET__assets_images_tiles_dirt_block_png);
		type.set ("assets/images/tiles/Dirt Block.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Door Tall Closed.png", __ASSET__assets_images_tiles_door_tall_closed_png);
		type.set ("assets/images/tiles/Door Tall Closed.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Door Tall Open.png", __ASSET__assets_images_tiles_door_tall_open_png);
		type.set ("assets/images/tiles/Door Tall Open.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Enemy Bug.png", __ASSET__assets_images_tiles_enemy_bug_png);
		type.set ("assets/images/tiles/Enemy Bug.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Gem Blue.png", __ASSET__assets_images_tiles_gem_blue_png);
		type.set ("assets/images/tiles/Gem Blue.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Gem Green.png", __ASSET__assets_images_tiles_gem_green_png);
		type.set ("assets/images/tiles/Gem Green.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Gem Orange.png", __ASSET__assets_images_tiles_gem_orange_png);
		type.set ("assets/images/tiles/Gem Orange.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Grass_Block.png", __ASSET__assets_images_tiles_grass_block_png);
		type.set ("assets/images/tiles/Grass_Block.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Heart.png", __ASSET__assets_images_tiles_heart_png);
		type.set ("assets/images/tiles/Heart.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Key.png", __ASSET__assets_images_tiles_key_png);
		type.set ("assets/images/tiles/Key.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Plain Block.png", __ASSET__assets_images_tiles_plain_block_png);
		type.set ("assets/images/tiles/Plain Block.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Ramp East.png", __ASSET__assets_images_tiles_ramp_east_png);
		type.set ("assets/images/tiles/Ramp East.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Ramp North.png", __ASSET__assets_images_tiles_ramp_north_png);
		type.set ("assets/images/tiles/Ramp North.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Ramp South.png", __ASSET__assets_images_tiles_ramp_south_png);
		type.set ("assets/images/tiles/Ramp South.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Ramp West.png", __ASSET__assets_images_tiles_ramp_west_png);
		type.set ("assets/images/tiles/Ramp West.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Rock.png", __ASSET__assets_images_tiles_rock_png);
		type.set ("assets/images/tiles/Rock.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Roof East.png", __ASSET__assets_images_tiles_roof_east_png);
		type.set ("assets/images/tiles/Roof East.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Roof North East.png", __ASSET__assets_images_tiles_roof_north_east_png);
		type.set ("assets/images/tiles/Roof North East.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Roof North West.png", __ASSET__assets_images_tiles_roof_north_west_png);
		type.set ("assets/images/tiles/Roof North West.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Roof North.png", __ASSET__assets_images_tiles_roof_north_png);
		type.set ("assets/images/tiles/Roof North.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Roof South East.png", __ASSET__assets_images_tiles_roof_south_east_png);
		type.set ("assets/images/tiles/Roof South East.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Roof South West.png", __ASSET__assets_images_tiles_roof_south_west_png);
		type.set ("assets/images/tiles/Roof South West.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Roof South.png", __ASSET__assets_images_tiles_roof_south_png);
		type.set ("assets/images/tiles/Roof South.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Roof West.png", __ASSET__assets_images_tiles_roof_west_png);
		type.set ("assets/images/tiles/Roof West.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Selector.png", __ASSET__assets_images_tiles_selector_png);
		type.set ("assets/images/tiles/Selector.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Shadow East.png", __ASSET__assets_images_tiles_shadow_east_png);
		type.set ("assets/images/tiles/Shadow East.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Shadow North East.png", __ASSET__assets_images_tiles_shadow_north_east_png);
		type.set ("assets/images/tiles/Shadow North East.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Shadow North West.png", __ASSET__assets_images_tiles_shadow_north_west_png);
		type.set ("assets/images/tiles/Shadow North West.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Shadow North.png", __ASSET__assets_images_tiles_shadow_north_png);
		type.set ("assets/images/tiles/Shadow North.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Shadow Side West.png", __ASSET__assets_images_tiles_shadow_side_west_png);
		type.set ("assets/images/tiles/Shadow Side West.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Shadow South East.png", __ASSET__assets_images_tiles_shadow_south_east_png);
		type.set ("assets/images/tiles/Shadow South East.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Shadow South West.png", __ASSET__assets_images_tiles_shadow_south_west_png);
		type.set ("assets/images/tiles/Shadow South West.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Shadow South.png", __ASSET__assets_images_tiles_shadow_south_png);
		type.set ("assets/images/tiles/Shadow South.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Shadow West.png", __ASSET__assets_images_tiles_shadow_west_png);
		type.set ("assets/images/tiles/Shadow West.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/SpeechBubble.png", __ASSET__assets_images_tiles_speechbubble_png);
		type.set ("assets/images/tiles/SpeechBubble.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Star.png", __ASSET__assets_images_tiles_star_png);
		type.set ("assets/images/tiles/Star.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Stone Block Tall.png", __ASSET__assets_images_tiles_stone_block_tall_png);
		type.set ("assets/images/tiles/Stone Block Tall.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Stone Block.png", __ASSET__assets_images_tiles_stone_block_png);
		type.set ("assets/images/tiles/Stone Block.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Tree Short.png", __ASSET__assets_images_tiles_tree_short_png);
		type.set ("assets/images/tiles/Tree Short.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Tree Tall.png", __ASSET__assets_images_tiles_tree_tall_png);
		type.set ("assets/images/tiles/Tree Tall.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Tree Ugly.png", __ASSET__assets_images_tiles_tree_ugly_png);
		type.set ("assets/images/tiles/Tree Ugly.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Wall Block Tall.png", __ASSET__assets_images_tiles_wall_block_tall_png);
		type.set ("assets/images/tiles/Wall Block Tall.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Wall Block.png", __ASSET__assets_images_tiles_wall_block_png);
		type.set ("assets/images/tiles/Wall Block.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Water Block.png", __ASSET__assets_images_tiles_water_block_png);
		type.set ("assets/images/tiles/Water Block.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Window Tall.png", __ASSET__assets_images_tiles_window_tall_png);
		type.set ("assets/images/tiles/Window Tall.png", AssetType.IMAGE);
		className.set ("assets/images/tiles/Wood Block.png", __ASSET__assets_images_tiles_wood_block_png);
		type.set ("assets/images/tiles/Wood Block.png", AssetType.IMAGE);
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/images-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/player.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Brown_Block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Character Boy.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Character Cat Girl.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Character Horn Girl.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Character Pink Girl.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Character Princess Girl.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Chest Closed.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Chest Lid.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Chest Open.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Dirt Block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Door Tall Closed.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Door Tall Open.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Enemy Bug.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Gem Blue.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Gem Green.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Gem Orange.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Grass_Block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Heart.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Key.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Plain Block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Ramp East.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Ramp North.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Ramp South.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Ramp West.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Rock.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Roof East.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Roof North East.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Roof North West.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Roof North.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Roof South East.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Roof South West.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Roof South.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Roof West.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Selector.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Shadow East.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Shadow North East.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Shadow North West.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Shadow North.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Shadow Side West.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Shadow South East.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Shadow South West.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Shadow South.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Shadow West.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/SpeechBubble.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Star.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Stone Block Tall.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Stone Block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Tree Short.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Tree Tall.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Tree Ugly.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Wall Block Tall.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Wall Block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Water Block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Window Tall.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles/Wood Block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		/*var useManifest = false;
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Brown_Block.png", __ASSET__assets_images_tiles_brown_block_png);
		type.set ("assets/images/tiles/Brown_Block.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Character Boy.png", __ASSET__assets_images_tiles_character_boy_png);
		type.set ("assets/images/tiles/Character Boy.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Character Cat Girl.png", __ASSET__assets_images_tiles_character_cat_girl_png);
		type.set ("assets/images/tiles/Character Cat Girl.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Character Horn Girl.png", __ASSET__assets_images_tiles_character_horn_girl_png);
		type.set ("assets/images/tiles/Character Horn Girl.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Character Pink Girl.png", __ASSET__assets_images_tiles_character_pink_girl_png);
		type.set ("assets/images/tiles/Character Pink Girl.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Character Princess Girl.png", __ASSET__assets_images_tiles_character_princess_girl_png);
		type.set ("assets/images/tiles/Character Princess Girl.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Chest Closed.png", __ASSET__assets_images_tiles_chest_closed_png);
		type.set ("assets/images/tiles/Chest Closed.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Chest Lid.png", __ASSET__assets_images_tiles_chest_lid_png);
		type.set ("assets/images/tiles/Chest Lid.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Chest Open.png", __ASSET__assets_images_tiles_chest_open_png);
		type.set ("assets/images/tiles/Chest Open.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Dirt Block.png", __ASSET__assets_images_tiles_dirt_block_png);
		type.set ("assets/images/tiles/Dirt Block.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Door Tall Closed.png", __ASSET__assets_images_tiles_door_tall_closed_png);
		type.set ("assets/images/tiles/Door Tall Closed.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Door Tall Open.png", __ASSET__assets_images_tiles_door_tall_open_png);
		type.set ("assets/images/tiles/Door Tall Open.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Enemy Bug.png", __ASSET__assets_images_tiles_enemy_bug_png);
		type.set ("assets/images/tiles/Enemy Bug.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Gem Blue.png", __ASSET__assets_images_tiles_gem_blue_png);
		type.set ("assets/images/tiles/Gem Blue.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Gem Green.png", __ASSET__assets_images_tiles_gem_green_png);
		type.set ("assets/images/tiles/Gem Green.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Gem Orange.png", __ASSET__assets_images_tiles_gem_orange_png);
		type.set ("assets/images/tiles/Gem Orange.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Grass_Block.png", __ASSET__assets_images_tiles_grass_block_png);
		type.set ("assets/images/tiles/Grass_Block.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Heart.png", __ASSET__assets_images_tiles_heart_png);
		type.set ("assets/images/tiles/Heart.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Key.png", __ASSET__assets_images_tiles_key_png);
		type.set ("assets/images/tiles/Key.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Plain Block.png", __ASSET__assets_images_tiles_plain_block_png);
		type.set ("assets/images/tiles/Plain Block.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Ramp East.png", __ASSET__assets_images_tiles_ramp_east_png);
		type.set ("assets/images/tiles/Ramp East.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Ramp North.png", __ASSET__assets_images_tiles_ramp_north_png);
		type.set ("assets/images/tiles/Ramp North.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Ramp South.png", __ASSET__assets_images_tiles_ramp_south_png);
		type.set ("assets/images/tiles/Ramp South.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Ramp West.png", __ASSET__assets_images_tiles_ramp_west_png);
		type.set ("assets/images/tiles/Ramp West.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Rock.png", __ASSET__assets_images_tiles_rock_png);
		type.set ("assets/images/tiles/Rock.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Roof East.png", __ASSET__assets_images_tiles_roof_east_png);
		type.set ("assets/images/tiles/Roof East.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Roof North East.png", __ASSET__assets_images_tiles_roof_north_east_png);
		type.set ("assets/images/tiles/Roof North East.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Roof North West.png", __ASSET__assets_images_tiles_roof_north_west_png);
		type.set ("assets/images/tiles/Roof North West.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Roof North.png", __ASSET__assets_images_tiles_roof_north_png);
		type.set ("assets/images/tiles/Roof North.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Roof South East.png", __ASSET__assets_images_tiles_roof_south_east_png);
		type.set ("assets/images/tiles/Roof South East.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Roof South West.png", __ASSET__assets_images_tiles_roof_south_west_png);
		type.set ("assets/images/tiles/Roof South West.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Roof South.png", __ASSET__assets_images_tiles_roof_south_png);
		type.set ("assets/images/tiles/Roof South.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Roof West.png", __ASSET__assets_images_tiles_roof_west_png);
		type.set ("assets/images/tiles/Roof West.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Selector.png", __ASSET__assets_images_tiles_selector_png);
		type.set ("assets/images/tiles/Selector.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Shadow East.png", __ASSET__assets_images_tiles_shadow_east_png);
		type.set ("assets/images/tiles/Shadow East.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Shadow North East.png", __ASSET__assets_images_tiles_shadow_north_east_png);
		type.set ("assets/images/tiles/Shadow North East.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Shadow North West.png", __ASSET__assets_images_tiles_shadow_north_west_png);
		type.set ("assets/images/tiles/Shadow North West.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Shadow North.png", __ASSET__assets_images_tiles_shadow_north_png);
		type.set ("assets/images/tiles/Shadow North.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Shadow Side West.png", __ASSET__assets_images_tiles_shadow_side_west_png);
		type.set ("assets/images/tiles/Shadow Side West.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Shadow South East.png", __ASSET__assets_images_tiles_shadow_south_east_png);
		type.set ("assets/images/tiles/Shadow South East.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Shadow South West.png", __ASSET__assets_images_tiles_shadow_south_west_png);
		type.set ("assets/images/tiles/Shadow South West.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Shadow South.png", __ASSET__assets_images_tiles_shadow_south_png);
		type.set ("assets/images/tiles/Shadow South.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Shadow West.png", __ASSET__assets_images_tiles_shadow_west_png);
		type.set ("assets/images/tiles/Shadow West.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/SpeechBubble.png", __ASSET__assets_images_tiles_speechbubble_png);
		type.set ("assets/images/tiles/SpeechBubble.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Star.png", __ASSET__assets_images_tiles_star_png);
		type.set ("assets/images/tiles/Star.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Stone Block Tall.png", __ASSET__assets_images_tiles_stone_block_tall_png);
		type.set ("assets/images/tiles/Stone Block Tall.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Stone Block.png", __ASSET__assets_images_tiles_stone_block_png);
		type.set ("assets/images/tiles/Stone Block.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Tree Short.png", __ASSET__assets_images_tiles_tree_short_png);
		type.set ("assets/images/tiles/Tree Short.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Tree Tall.png", __ASSET__assets_images_tiles_tree_tall_png);
		type.set ("assets/images/tiles/Tree Tall.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Tree Ugly.png", __ASSET__assets_images_tiles_tree_ugly_png);
		type.set ("assets/images/tiles/Tree Ugly.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Wall Block Tall.png", __ASSET__assets_images_tiles_wall_block_tall_png);
		type.set ("assets/images/tiles/Wall Block Tall.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Wall Block.png", __ASSET__assets_images_tiles_wall_block_png);
		type.set ("assets/images/tiles/Wall Block.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Water Block.png", __ASSET__assets_images_tiles_water_block_png);
		type.set ("assets/images/tiles/Water Block.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Window Tall.png", __ASSET__assets_images_tiles_window_tall_png);
		type.set ("assets/images/tiles/Window Tall.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles/Wood Block.png", __ASSET__assets_images_tiles_wood_block_png);
		type.set ("assets/images/tiles/Wood Block.png", AssetType.IMAGE);
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		*/
		var useManifest = true;
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && requestedType == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return AudioBuffer.fromFile (path.get (id));
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		//return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		//else 
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Dynamic /*Font*/ {
		
		// TODO: Complete Lime Font API
		
		#if openfl
		#if (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), openfl.text.Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			openfl.text.Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), openfl.text.Font);
			
		} else {
			
			return new openfl.text.Font (path.get (id));
			
		}
		
		#end
		#end
		
		return null;
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		return Image.fromFile (path.get (id));
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getAudioBuffer (id));
			
		//}
		
		#else
		
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_images_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_brown_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_character_boy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_character_cat_girl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_character_horn_girl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_character_pink_girl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_character_princess_girl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_chest_closed_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_chest_lid_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_chest_open_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_dirt_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_door_tall_closed_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_door_tall_open_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_enemy_bug_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_gem_blue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_gem_green_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_gem_orange_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_grass_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_heart_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_key_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_plain_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_ramp_east_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_ramp_north_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_ramp_south_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_ramp_west_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_rock_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_roof_east_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_roof_north_east_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_roof_north_west_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_roof_north_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_roof_south_east_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_roof_south_west_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_roof_south_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_roof_west_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_selector_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_shadow_east_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_shadow_north_east_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_shadow_north_west_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_shadow_north_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_shadow_side_west_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_shadow_south_east_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_shadow_south_west_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_shadow_south_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_shadow_west_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_speechbubble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_star_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_stone_block_tall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_stone_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_tree_short_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_tree_tall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_tree_ugly_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_wall_block_tall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_wall_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_water_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_window_tall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_wood_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }


#elseif html5

#if openfl































































#end

#else

#if openfl

#end

#if (windows || mac || linux)

//
//@:file("assets/data/data-goes-here.txt") class __ASSET__assets_data_data_goes_here_txt extends lime.utils.ByteArray {}
//@:file("assets/images/images-go-here.txt") class __ASSET__assets_images_images_go_here_txt extends lime.utils.ByteArray {}
//@:bitmap("assets/images/player.png") class __ASSET__assets_images_player_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Brown_Block.png") class __ASSET__assets_images_tiles_brown_block_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Character Boy.png") class __ASSET__assets_images_tiles_character_boy_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Character Cat Girl.png") class __ASSET__assets_images_tiles_character_cat_girl_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Character Horn Girl.png") class __ASSET__assets_images_tiles_character_horn_girl_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Character Pink Girl.png") class __ASSET__assets_images_tiles_character_pink_girl_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Character Princess Girl.png") class __ASSET__assets_images_tiles_character_princess_girl_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Chest Closed.png") class __ASSET__assets_images_tiles_chest_closed_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Chest Lid.png") class __ASSET__assets_images_tiles_chest_lid_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Chest Open.png") class __ASSET__assets_images_tiles_chest_open_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Dirt Block.png") class __ASSET__assets_images_tiles_dirt_block_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Door Tall Closed.png") class __ASSET__assets_images_tiles_door_tall_closed_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Door Tall Open.png") class __ASSET__assets_images_tiles_door_tall_open_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Enemy Bug.png") class __ASSET__assets_images_tiles_enemy_bug_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Gem Blue.png") class __ASSET__assets_images_tiles_gem_blue_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Gem Green.png") class __ASSET__assets_images_tiles_gem_green_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Gem Orange.png") class __ASSET__assets_images_tiles_gem_orange_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Grass_Block.png") class __ASSET__assets_images_tiles_grass_block_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Heart.png") class __ASSET__assets_images_tiles_heart_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Key.png") class __ASSET__assets_images_tiles_key_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Plain Block.png") class __ASSET__assets_images_tiles_plain_block_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Ramp East.png") class __ASSET__assets_images_tiles_ramp_east_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Ramp North.png") class __ASSET__assets_images_tiles_ramp_north_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Ramp South.png") class __ASSET__assets_images_tiles_ramp_south_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Ramp West.png") class __ASSET__assets_images_tiles_ramp_west_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Rock.png") class __ASSET__assets_images_tiles_rock_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Roof East.png") class __ASSET__assets_images_tiles_roof_east_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Roof North East.png") class __ASSET__assets_images_tiles_roof_north_east_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Roof North West.png") class __ASSET__assets_images_tiles_roof_north_west_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Roof North.png") class __ASSET__assets_images_tiles_roof_north_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Roof South East.png") class __ASSET__assets_images_tiles_roof_south_east_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Roof South West.png") class __ASSET__assets_images_tiles_roof_south_west_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Roof South.png") class __ASSET__assets_images_tiles_roof_south_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Roof West.png") class __ASSET__assets_images_tiles_roof_west_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Selector.png") class __ASSET__assets_images_tiles_selector_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Shadow East.png") class __ASSET__assets_images_tiles_shadow_east_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Shadow North East.png") class __ASSET__assets_images_tiles_shadow_north_east_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Shadow North West.png") class __ASSET__assets_images_tiles_shadow_north_west_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Shadow North.png") class __ASSET__assets_images_tiles_shadow_north_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Shadow Side West.png") class __ASSET__assets_images_tiles_shadow_side_west_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Shadow South East.png") class __ASSET__assets_images_tiles_shadow_south_east_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Shadow South West.png") class __ASSET__assets_images_tiles_shadow_south_west_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Shadow South.png") class __ASSET__assets_images_tiles_shadow_south_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Shadow West.png") class __ASSET__assets_images_tiles_shadow_west_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/SpeechBubble.png") class __ASSET__assets_images_tiles_speechbubble_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Star.png") class __ASSET__assets_images_tiles_star_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Stone Block Tall.png") class __ASSET__assets_images_tiles_stone_block_tall_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Stone Block.png") class __ASSET__assets_images_tiles_stone_block_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Tree Short.png") class __ASSET__assets_images_tiles_tree_short_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Tree Tall.png") class __ASSET__assets_images_tiles_tree_tall_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Tree Ugly.png") class __ASSET__assets_images_tiles_tree_ugly_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Wall Block Tall.png") class __ASSET__assets_images_tiles_wall_block_tall_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Wall Block.png") class __ASSET__assets_images_tiles_wall_block_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Water Block.png") class __ASSET__assets_images_tiles_water_block_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Window Tall.png") class __ASSET__assets_images_tiles_window_tall_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles/Wood Block.png") class __ASSET__assets_images_tiles_wood_block_png extends openfl.display.BitmapData {}
//@:file("assets/music/music-goes-here.txt") class __ASSET__assets_music_music_goes_here_txt extends lime.utils.ByteArray {}
//@:file("assets/sounds/sounds-go-here.txt") class __ASSET__assets_sounds_sounds_go_here_txt extends lime.utils.ByteArray {}
//@:sound("/usr/lib/haxe/flixel/3,3,6/assets/sounds/beep.mp3") class __ASSET__assets_sounds_beep_mp3 extends openfl.media.Sound {}
//@:sound("/usr/lib/haxe/flixel/3,3,6/assets/sounds/flixel.mp3") class __ASSET__assets_sounds_flixel_mp3 extends openfl.media.Sound {}
//
//

#end

#end
#end

