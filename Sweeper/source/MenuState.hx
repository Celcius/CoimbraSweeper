package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import game.Game;
using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{

    private var _btnPlay:FlxButton;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

        //FlxG.sound.playMusic("assets/music/Bird-Battle.mp3", 1, true);
        FlxG.sound.playMusic("assets/music/Nature-Mood3.mp3", 1, true);
        FlxG.switchState(new Game(0));
	}

    private function clickPlay():Void
    {
        FlxG.switchState(new Game(0));
    }

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}
}