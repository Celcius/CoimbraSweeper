package game;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxPoint;


import motion.Actuate;


/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private static var SPEED = 200;

	private var anchor:FlxSprite;

	public var collider:FlxSprite;
	public var colliderOffset:FlxPoint;

	private var oppositeAnchor:FlxPoint;

	var isStopped : Bool = false;
	var canMove:Bool = true;
	
	private var SPRITE_WIDTH = 68;
	private var SPRITE_HEIGHT = 78;


	public function new(X:Float, Y:Float)
	{
		
		
		super(X + (Game.BLOCK_WIDTH - SPRITE_WIDTH) / 2, Y + 25);
		loadGraphic("assets/images/ranger_sheet.png", false, 92, 99);
				
		this.animation.add("iddle", [0, 1, 2,3,4,5,6,7,8,9,10,11,12], 5, true);
		this.animation.play("iddle");
		anchor = new FlxSprite(anchorX, anchorY);
		anchor.makeGraphic(2,2, 0xFFFF0000);
		anchor.makeGraphic(2, 2, 0xFFFF0000);


		Reg.player = this;

		oppositeAnchor = new FlxPoint();
	}

	override public function update():Void
	{
		super.update();

		if (isStopped)
			return;

		var duration:Float = 0.5;
		
		var horDiff:Float = Game.BLOCK_WIDTH;
		var verDiff:Float = Game.BLOCK_HEIGHT;
		
		var horMove:Float = 0.0;
		var verMove:Float = 0.0;
		
		
		
		if (canMove)
		{
			// left movement
			if (FlxG.keys.anyPressed(["A", "LEFT"]))
			{
				horMove = -horDiff;
			}
			else if (FlxG.keys.anyPressed(["D", "RIGHT"]))
			{
				horMove = horDiff;
			}
			else if (FlxG.keys.anyPressed(["W", "UP"]))
			{
				verMove = -verDiff;
			}
			else if (FlxG.keys.anyPressed(["S", "DOWN"]))
			{
				verMove = verDiff;
			}
			
			// check if should move - create action to move if yes
			if (horMove != 0 || verMove != 0)
			{
				canMove = false;
				var xPath = this.x + horMove;
				var yPath = this.y + verMove;

				Actuate.tween(this, duration, { x:xPath, y:yPath } ).onComplete(this.setCanMove);
			}
		
			handleCollision(duration, horMove, verMove);

			anchor.x = anchorX;
			anchor.y = anchorY;
		}

		var currentTile:Tile = Game.instance.getTileFromWorld(anchorX, anchorY);
		if (currentTile != null){
			currentTile.setExplored(true);
		}

		super.update();

		if (Game.instance.isBomb( Game.instance.getTile(Game.instance.getGridX(anchorX), Game.instance.getGridY(anchorY))))
		{
			Game.instance.killPlayerMine();
		}
	}
	
	public function setCanMove()
	{
		this.canMove = true;
	}

	public function handleCollision(duration:Float, horMove:Float, verMove:Float):Void
	{
		oppositeAnchor.x = x + width;
		oppositeAnchor.y = y + height;// = new FlxPoint(x + width, y + height);

		var bear:Bear = Reg.bear;
		if (bear != null && FlxG.collide(this, bear))
		{
			if (verMove > 0 && y <= bear.y + bear.height ){
				bear.redirectBear(Bear.NORTH, duration, horMove, verMove);
			}
			else if (verMove < 0 && oppositeAnchor.y >= bear.y ){
				bear.redirectBear(Bear.SOUTH, duration, horMove, verMove);
			}
			else if (horMove < 0 && x >= bear.x + bear.width){
				bear.redirectBear(Bear.WEST, duration, horMove, verMove);
			}
			else if (horMove > 0 && oppositeAnchor.x <= bear.x){
				bear.redirectBear(Bear.EAST, duration, horMove, verMove);
			}
		}
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
		return y + height-5;
	}

	public function setStopped(stopped : Bool):Void
	{
		isStopped = stopped;
		if(stopped)
			this.velocity  = new FlxPoint(0, 0);
	}

}