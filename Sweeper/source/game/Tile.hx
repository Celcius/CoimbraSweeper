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

    private var grassNumber:FlxSprite;
    private var overlayNumber:FlxSprite;

	public function new(X:Float, Y:Float, name:String)
	{
		super (X, Y);
		className = name;

		text = new FlxText(X + 50, Y + 83, 0);
		text.color = 0xFFFFFF;

		grassNumber = new FlxSprite(X,Y);
		grassNumber.blend = flash.display.BlendMode.OVERLAY;
		grassNumber.alpha = 0.7;

		overlayNumber = new FlxSprite(X,Y);
	}

	public function setExplored(explored:Bool):Void
	{
		if (this.explored != explored && explored){
			grassNumber.loadGraphic( "assets/images/tiles/Grass_Block_"+number+".png", true, 101, 171);
			overlayNumber.loadGraphic( "assets/images/tiles/Grass_Block_"+number+".png", true, 101, 171);

			Game.instance.topLayer.add(overlayNumber);
			overlayNumber.scale.x = overlayNumber.scale.y = 2;
			motion.Actuate.tween(overlayNumber.scale, 2.5, { x:1, y:1} );
			motion.Actuate.tween(overlayNumber, 3, { alpha: 0.0 } ).onComplete(Game.instance.topLayer.remove, [overlayNumber]);

		}
		this.explored = explored;

	}

	override public function draw():Void
	{
		super.draw();

		text.draw();
		if (explored){
			grassNumber.draw();
		}

	}

	override public function update()
	{
		super.update();

		//text.text = "" + number;
	}
}