package game;

import flixel.FlxSprite;
import flixel.text.FlxText;

class Tile extends FlxSprite
{

    public var className:String = "";
    public var number:Int;
	
	public var text:FlxText;

    private var _underSprite:Tile;

	public function new(X:Float, Y:Float, name:String)
	{
		super (X, Y);
		className = name;

		text = new FlxText(X + 50, Y + 83, 0);
		text.color = 0xFFFFFF;

		//loadGraphic( "assets/images/tiles/Stone_Block.png", true, 101, 171);
	}
	
	override public function draw()
	{
		super.draw();
		
		text.draw();
	}
	
	override public function update()
	{
		super.update();
		
		text.text = "" + number;
	}
}