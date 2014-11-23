package game;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.util.FlxRandom;
/**
 * ...
 * @author Ivo Capelo
 */
class Explosion extends FlxEmitter
{
	public static var TIME_SPAN:Float = 1.5;
	public static var MINE_XP:Int = 0;
	public static var BLOOD_XP:Int = 1;
	public static var WATER_XP:Int = 2;
	public var _depth:Int;
	public var _elapsed:Float;
	var _spawned :Bool = false;
	var _type :Int = MINE_XP;
	public function new(x:Float,y:Float, depth:Int) 
	{
		_depth = depth;
		_elapsed = 0;
		super(x, y);

	}
	
	public function createMineParticles() : Void
	{
				for(i in  0 ... 20)
		{
			var particle:FlxParticle = new FlxParticle();
			var color :Int;
			var rand : Float =  FlxRandom.intRanged(0, 10);
			if (rand < 5)
				color = 0x99111111;
			else if (rand < 10)
				color = 0x99ff0000;
			else
				color = 0x99ffff00;
				
			particle.makeGraphic(15,15,color);
			particle.exists = false;
			particle.useFading = true;
			add(particle);

			}
				_type = MINE_XP;
	}
	
		public function createWaterParticles() : Void
	{
				for(i in  0 ... 20)
		{
			var particle:FlxParticle = new FlxParticle();
			var color :Int;
			var rand : Float =  FlxRandom.intRanged(0, 10);
			if (rand < 5)
				color = 0x992C5AC7;
			else if (rand < 10)
				color = 0x9945E3F7;
			else
				color = 0x99F0F5FA;
				
			particle.makeGraphic(15,15,color);
			particle.exists = false;
			particle.useFading = true;
			add(particle);
				
			}
			_type = WATER_XP;
	}
	
	public function createBloodParticles() : Void
	{
		
		for(i in  0 ... 20)
		{
			var particle:FlxParticle = new FlxParticle();
			var color :Int;
			var rand : Float =  FlxRandom.intRanged(0, 10);
			if (rand < 5)
				color = 0x99FF1111;
			else if (rand < 10)
				color = 0x99ff1130;
			else
				color = 0x99ff3310;
				
			particle.makeGraphic(15, 15,color);
			particle.exists = false;
			particle.useFading = true;

			add(particle);
				
			}
				_type = WATER_XP;			
	}
	override public function update():Void
	{
		_elapsed += FlxG.elapsed;
		if (_elapsed >= TIME_SPAN *0.1 && _depth > 0 && !_spawned)
		{
			if(_type == BLOOD_XP)
				Reg.game.bloodExplosion(x, y, _depth - 1);
			else if (_type == WATER_XP)
				Reg.game.waterExplosion(x, y, _depth-1);
			else 
				Reg.game.mineExplosion(x, y, _depth - 1);             	 
			_spawned = true;
		}

		super.update();
	}
	
}