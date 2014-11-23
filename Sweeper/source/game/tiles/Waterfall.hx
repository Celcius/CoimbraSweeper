package game.tiles;

import flixel.FlxSprite;
import game.Tile;
import flixel.effects.particles.FlxEmitterExt;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxColor;

class Waterfall extends Tile
{
	var emitter:FlxEmitterExt;
	private var _whitePixel:FlxParticle;

	public function new (X:Float , Y:Float)
	{
		super(X,Y+5, "waterfall");
		loadGraphic( "assets/images/tiles/WaterfallAnim.png", true, 101, 171);
		animation.add("flow", [1, 2, 3, 4, 5 ,6], 8, true);
		animation.play("flow");
		this.blocking = true;

		emitter = new FlxEmitterExt(x, Y + height - 40, 200);
		emitter.setAlpha(1,0.7,0,0);
		emitter.setSize( Math.floor(width) , 1 );
		emitter.setScale(1, 2, 0.5, 1);
		emitter.setYSpeed( -0.3, 0.3);
		emitter.setXSpeed(0, 0);

		for (i in 0...200)
		{
			_whitePixel = new FlxParticle();
			_whitePixel.makeGraphic(6, 6, FlxColor.WHITE);
			// Make sure the particle doesn't show up at (0, 0)
			_whitePixel.visible = false;
			emitter.add(_whitePixel);
		}

		Game.instance.topLayer.add(emitter);
		emitter.start(false, 1, .04);
	}

	override public function update():Void
	{
		super.update();
		//emitter.update();
	}
	override public function draw():Void
	{
		super.draw();
		//emitter.draw();
	}
}