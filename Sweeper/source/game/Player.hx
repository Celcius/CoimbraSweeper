package game;

import flixel.FlxSprite;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private static var SPEED = 200;

	private var anchor:FlxSprite;
	public var collider:FlxSprite;

	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		loadGraphic( "assets/images/tiles/Character_Horn_Girl.png", true, 101, 171);

		anchor = new FlxSprite(anchorX, anchorY);
		anchor.makeGraphic(2,2, 0xFFFF0000);

		collider = new FlxSprite(0,0);
		collider.makeGraphic(80, 81, 0xFFFF0000);
	}

	override public function update():Void
	{
		super.update();

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

		collider.x = x + (width - collider.width)*0.5;
		collider.y = y + 51;

		if (Reg.bear != null && FlxG.collide(this.collider, Reg.bear))
		{
			if (FlxG.keys.anyPressed(["W","UP"]))
				Reg.bear.redirectBear(Bear.NORTH);
			else if (FlxG.keys.anyPressed(["S","DOWN"]))
				Reg.bear.redirectBear(Bear.SOUTH);
			else if (FlxG.keys.anyPressed(["A","LEFT"]))
				Reg.bear.redirectBear(Bear.WEST);
			else if (FlxG.keys.anyPressed(["D","RIGHT"]))
				Reg.bear.redirectBear(Bear.EAST);
		}


		anchor.x = anchorX;
		anchor.y = anchorY;

	}

	override public function draw():Void
	{
		super.draw();
		anchor.draw();
		collider.draw();
	}

	public var anchorX(get, never):Float;

	function get_anchorX() {
		return x + width/2;
	}

	public var anchorY(get, never):Float;
	function get_anchorY() {
		return y + 3*(height/4)+10;
	}

}