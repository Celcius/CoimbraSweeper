package game.tiles;
import game.Tile;

/**
 * ...
 * @author Ivo Capelo
 */
class Bed extends Tile
{

	public function new (X:Float , Y:Float)
	{
		super(X,Y, "bed");
		loadGraphic( "assets/images/tiles/bed.png", true, 101, 171);
	}

	override public function draw():Void
	{
		super.draw();
	}
	
}