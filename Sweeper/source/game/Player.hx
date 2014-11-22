package game;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxPoint;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private static var SPEED = 200;

	private var anchor:FlxSprite;
	private var oppositeAnchor:FlxPoint;
	var isStopped : Bool = false;
	
	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		loadGraphic( "assets/images/tiles/Character_Horn_Girl.png", true, 101, 171);

		anchor = new FlxSprite(anchorX, anchorY);
		anchor.makeGraphic(2, 2, 0xFFFF0000);
		oppositeAnchor = new FlxPoint(x + width, y + height);
		Reg.player = this;
	}

	override public function update():Void
	{
		super.update();
		
		if (isStopped)
			return;

		// left right movement
		if (FlxG.keys.anyPressed(["A", "LEFT", "D", "RIGHT"]))
		{
			if ( (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) &&
				 (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) )
				this.velocity.x = 0;
			else
			{

				if (FlxG.keys.anyPressed(["A", "LEFT"]))
				{
					this.velocity.x = -SPEED;
				}
				if (FlxG.keys.anyPressed(["D", "RIGHT"]))
				{
					this.velocity.x = SPEED;
				}
			}
		}
		else
		{
			this.velocity.x = 0;
		}


		// up down movement
		if (FlxG.keys.anyPressed(["W", "UP", "S", "DOWN"]))
		{
			if ( (FlxG.keys.pressed.W || FlxG.keys.pressed.UP) &&
				 (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN))
				this.velocity.y = 0;
			else
			{
				if (FlxG.keys.anyPressed(["W", "UP"]))
				{
					this.velocity.y = -SPEED;
				}
				if (FlxG.keys.anyPressed(["S", "DOWN"]))
				{
					this.velocity.y = SPEED;
				}
			}
		}
		else
		{
			this.velocity.y = 0;
		}
		var bear:Bear = Reg.bear;
		if (bear != null && FlxG.collide(this, bear))
		{
			if (FlxG.keys.anyPressed(["W", "UP"]) && y <= bear.y + bear.height )
				bear.redirectBear(Bear.NORTH);
			else if (FlxG.keys.anyPressed(["S","DOWN"]) && oppositeAnchor.y >= bear.y )
				bear.redirectBear(Bear.SOUTH);
			else if (FlxG.keys.anyPressed(["A","LEFT"]) && x >= bear.x + bear.width)
				bear.redirectBear(Bear.WEST);
			else if (FlxG.keys.anyPressed(["D","RIGHT"]) && oppositeAnchor.x <= bear.x)
				bear.redirectBear(Bear.EAST);
		}
		

		anchor.x = anchorX;
		anchor.y = anchorY;
	}

	override public function draw():Void
	{
		super.draw();
		anchor.draw();
	}

	public var anchorX(get, never):Float;

	function get_anchorX() {
		return x + width/2;
	}

	public var anchorY(get, never):Float;
	function get_anchorY() {
		return y + 3*(height/4)+10;
	}
	
	public function setStopped(stopped : Bool):Void
	{
		isStopped = stopped;
		if(stopped)
			this.velocity  = new FlxPoint(0, 0);
	}

}