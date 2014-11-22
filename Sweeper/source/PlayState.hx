package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.misc.ColorTween;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.ui.FlxBar;
import flixel.util.FlxPoint;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

        var text:FlxText = new FlxText(10, 10, 100, "Let's Play!");
		add(text);
		Reg.rageBar = new RageBar(400,350);
		add(Reg.rageBar);
		Reg.rageBar.incrementRage();
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