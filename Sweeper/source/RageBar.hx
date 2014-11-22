package ;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.ui.FlxBar;
import flixel.FlxG;
/**
 * ...
 * @author Ivo Capelo
 */
class RageBar extends FlxGroup
{
	private var rageBar:FlxBar;
	private var MAX_RAGE:Int = 9; 
	private var elapsed:Float = 0;
	private var MAX_ELAPSED:Float = 4;
/**
	 * Function that is called up when to state is created to set it up. 
	 */
    public function new(x: Int, y:Int)
	{
		super();

		rageBar  = new FlxBar(x, y, FlxBar.FILL_LEFT_TO_RIGHT, 200, 52, null, "", 0, MAX_RAGE,false);
		rageBar.createGradientBar([0x00000000], [ 0xFFE3175E, 0xFFE3BE17], 50, 180, true, 0xffffffff);
		rageBar.currentValue = 9;
		rageBar.scrollFactor.x = rageBar.scrollFactor.y = 0;
		add(rageBar);
	}
	
	public function incrementRage():Void
	{
		if (rageBar.currentValue < MAX_RAGE)
		{
			rageBar.currentValue ++;
		}
		
	}
	public function decrementRage():Void
	{
	    if (rageBar.currentValue >0)
		{
			rageBar.currentValue --;
		}
	}
	
	public function isMaxRage():Bool
	{
		return rageBar.currentValue == MAX_RAGE;
	}
	
	override public function update():Void
	{
		elapsed = elapsed+ FlxG.elapsed;
		if (elapsed > MAX_ELAPSED)
			{
				elapsed = 0;
				decrementRage();
			}
	}
}