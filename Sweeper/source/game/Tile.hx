package game;

import flixel.FlxSprite;

class Tile extends FlxSprite
{

    public var className:String = "";
    public var number:Int = 0;
    public var explored:Bool = false;
    public var blocking:Bool = false;

    private var _underSprite:Tile;

    private var overGrass:FlxSprite;

	public function new(X:Float, Y:Float, name:String)
	{
		super (X, Y);
		className = name;

		overGrass = new FlxSprite(X,Y);
		overGrass.loadGraphic( "assets/images/tiles/grass_smaller.png", true, 101, 171);
		overGrass.y -= 37;
	}

	override public function draw():Void
	{
		super.draw();
		if (!explored){
			overGrass.draw();
		}

	}
}