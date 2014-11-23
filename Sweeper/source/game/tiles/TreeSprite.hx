package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class TreeSprite extends FlxSprite
{
	private var bombSprite:FlxSprite;

	public function new (X:Float , Y:Float, spriteAsset:String)
	{
		super(X,Y);
		loadGraphic( "assets/images/tiles/"+spriteAsset, true, 101, 171);
	}
}