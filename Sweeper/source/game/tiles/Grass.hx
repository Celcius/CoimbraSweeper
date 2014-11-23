package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Grass extends Tile
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, "grass");
		loadGraphic( "assets/images/tiles/Grass_Block.png", true, 101, 171);
		setExplored(false);
	}

	override public function setExplored(explored:Bool):Void
	{
		var changed:Bool = this.explored!=explored;

		if (changed){
			trace("loading graphic");
			loadGraphic( "assets/images/tiles/Grass"+(explored ? "2":"")+"_Block.png", true, 101, 171);
		}
		super.setExplored(explored);

	}
}