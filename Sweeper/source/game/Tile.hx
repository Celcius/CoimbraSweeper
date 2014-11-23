package game;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.input.touch.FlxTouch;
import flixel.util.FlxPoint;
import game.tiles.FlagSprite;

class Tile extends FlxSprite
{

    public var className:String = "";
    public var number:Int = 0;
    public var explored:Bool = false;
    public var blocking:Bool = false;
    public var showNumber:Bool = true;

    private var grassNumber:FlxSprite;
    private var overlayNumber:FlxSprite;

	private var flag : FlagSprite;

	public function new(X:Float, Y:Float, name:String)
	{
		super (X, Y);
		className = name;

		grassNumber = new FlxSprite(X,Y);
		grassNumber.blend = flash.display.BlendMode.OVERLAY;
		grassNumber.alpha = 0.7;

		overlayNumber = new FlxSprite(X, Y);
	}

	public function setExplored(explored:Bool):Void
	{

		if (showNumber && this.explored != explored && explored){
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

		if (explored){
			grassNumber.draw();
		}

	}

	override public function update() : Void
	{
		super.update();
	}

	public function canPlantFlag() : Bool
	{
		return false;
	}

	public function plantFlag() : Void
	{
		if (canPlantFlag())
		{
			if (flag == null)
			{
				flag = new FlagSprite(x+width / 2+5,y+5);
				Game.instance.playerLayer.add(flag);
				this.blocking = true;
			}
			else
			{
				flag.visible = ! flag.visible;
				this.blocking = flag.visible;

			}
		}

	}

}