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

        _btnPlay = new FlxButton(0,0, "Play", clickPlay);
        _btnPlay.setSize( 100 , 40 );
        _btnPlay.screenCenter();
        add(_btnPlay);

        FlxG.switchState(new Game(new game.levels.Level1()));
	}

    private function clickPlay():Void
    {
        FlxG.switchState(new Game(new game.levels.Level1()));
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