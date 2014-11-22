package game;

import flixel.FlxSprite;
import flixel.text.FlxText;

class Tile extends FlxSprite
{

    public var className:String = "";
	public var text:FlxText;
    public var number:Int = 0;
    public var explored:Bool = false;
    public var blocking:Bool = false;

    private var overGrass:FlxSprite;

	public function new(X:Float, Y:Float, name:String)
	{
		super (X, Y);
		className = name;

		text = new FlxText(X + 50, Y + 83, 0);
		text.color = 0xFFFFFF;

		overGrass = new FlxSprite(X,Y);
		overGrass.blend = flash.display.BlendMode.OVERLAY;
		overGrass.alpha = 0.7;
	}

	public function setExplored(explored:Bool):Void
	{
		if (this.explored != explored && explored){
			overGrass.loadGraphic( "assets/images/tiles/Grass_Block_"+number+".png", true, 101, 171);
		}
		this.explored = explored;

	}

	override public function draw():Void
	{
		super.draw();

		text.draw();
		if (explored){
			overGrass.draw();
		}

	}

	override public function update()
	{
		super.update();

		text.text = "" + number;
	}
}