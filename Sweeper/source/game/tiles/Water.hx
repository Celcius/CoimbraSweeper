package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Water extends Tile
{
	public static var NONE:Int = 0;
	public static var UP:Int = 1;
	public static var RIGHT:Int = 2;
	public static var DOWN:Int = 3;
	public static var LEFT:Int = 4;

	public var direction:Int = 0;

	public function new (X:Float , Y:Float, direction:Int = 0)
	{
		super(X,Y, "water");
		loadGraphic( "assets/images/tiles/Water_Block.png", true, 101, 171);
		setDirection(direction);
		showNumber = false;
	}

	public function setDirection(dir:Int):Void
	{
		direction = dir;
	}

	override public function setExplored(explored:Bool):Void
	{

	}
}