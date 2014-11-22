package game;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxRandom;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.FlxCamera;
import game.levels.Level;
import game.tiles.*;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxEmitter;

class Game extends FlxState {

	private var player:Player;

    public static var BLOCK_WIDTH:Int = 101;
    public static var BLOCK_HEIGHT:Int = 83;

    public var _grid:Array<Array<Tile>>;
    private var _level:Level;

    private var numberGrid:Array<Array<Int>>;

    public static var GMAP:Map<String,Dynamic>;

    public static var _gridGroup:FlxSpriteGroup;

	public var _gameOver:Bool;

    public function new(level:Level)
    {
        super();
        _level = level;
    }

    override public function create():Void
    {

        GMAP = new Map<String, Dynamic>();
        GMAP.set('#', Grass);
        GMAP.set('_', Terrain);
        GMAP.set('*', Bomb);
        GMAP.set('t', Tree);
        GMAP.set('.', Empty);

        _gridGroup = new FlxSpriteGroup();
        add(_gridGroup);

		drawGrid(_level.getGrid());
        populateNumberGrid();
		createRageBar();
		createBear();

		_gameOver = false;
		
		player = new Player(BLOCK_WIDTH * 0, BLOCK_HEIGHT * 1.5);
		add(player);

		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN, 1);

		Reg.game = this;
        super.create();
    }

    private function drawGrid(grid:Array<String>):Void
    {
        _grid = new Array<Array<Tile>>();
        for( i in 0... grid.length)
        {
            var row = grid[i];
            _grid[i] = new Array<Tile>();
            for ( j in 0...row.length )
            {
                var classType= GMAP.get(row.charAt(j));
                var tile:Tile = Type.createInstance(classType, [j*BLOCK_WIDTH, i*BLOCK_HEIGHT - 51] );
                _grid[i][j] = tile;
                _gridGroup.add(tile);
            }
        }
    }

    private function populateNumberGrid():Void
    {

    }

    public static function getGridX(X:Float):Float
    {
        return Math.floor( X/BLOCK_WIDTH);
    }
    public static function getGridY(Y:Float):Float
    {
        return Math.floor((Y+23)/BLOCK_HEIGHT);
    }

    /**
	 * Function that is called once every frame.
	 */
    override public function update():Void
    {
        trace("Player X="+getGridX(player.anchorX) + " Y="+getGridY(player.anchorY));

		if (_gameOver && FlxG.keys.anyPressed(["R"]))
		{
			for ( member in members)
				remove(member);
			create();
			return;
		}
        super.update();
    }

	private function createRageBar():Void
	{
		Reg.rageBar = new RageBar();
		add(Reg.rageBar);
	}

	private function createBear():Void
	{
		Reg.bear = new Bear();
		add(Reg.bear);
		Reg.bear.y = FlxG.height / 2;
		Reg.bear.x = Reg.bear.width;
	}
	
	public function killPlayerBear():Void
	{
		if (!_gameOver)
		{
			var player : Player = Reg.player;
			bloodExplosion(player.x+ player.width/2 , player.y+ player.height/2 , 2);
			remove(Reg.player);
			gameOver("You woke the Bear!\nHis stomach feels warm...");
		}
	}

	public function killPlayerMine():Void
	{
		if (!_gameOver)
		{
			var player : Player = Reg.player;
			mineExplosion(player.x+ player.width/2 , player.y+ player.height/2, 2);
			remove(Reg.player);
			gameOver("You woke the Bear!\nWhen your torso flew into him...");
		}
	}
	
	public function killBear():Void
	{
		if (!_gameOver)
		{
			var bear : Bear = Reg.bear;
			bloodExplosion(bear.x + bear.width / 2 , bear.y + bear.height / 2 , 2);
			remove(Reg.bear);
			gameOver("You woke the Bear!\nFor the last time...");
		}
	}
	
	function gameOver(text : String) : Void
	{
		_gameOver = true;
		Reg.player.setStopped(true);
		Reg.bear.setStopped(true);
		
		var label1: FlxText = new FlxText(FlxG.width / 2, FlxG.height * 1 / 3, text,30);
		var label2: FlxText = new FlxText(FlxG.width / 2, FlxG.height * 3/ 6, "Press R to retry...", 25);
		
		label1.color = 0xff000000;
		label1.scrollFactor.x = label1.scrollFactor.y = 0;
		label1.alignment = "center";
		label1.borderStyle = FlxText.BORDER_OUTLINE;
		label1.borderColor = 0xffffffff;
		label1.borderSize = 3;
		label1.x -= label1.width / 2;

		label2.color = 0xff000000;		
		label2.scrollFactor.x = label2.scrollFactor.y = 0;
		label2.alignment = "center";
		label2.x -= label2.width / 2;
		label2.borderStyle = FlxText.BORDER_OUTLINE;
		label2.borderColor = 0xffffffff;
		label2.borderSize = 3;
		
		add(label1);
		add(label2);
		
	}
	
	public function bloodExplosion(x:Float,y:Float,depth:Int) : Void
	{
			var xp : Explosion =  new Explosion(x, y, depth);
			xp.createBloodParticles();
			add(xp);
			xp.start(Explosion.TIME_SPAN);
	}
	
	public function mineExplosion(x:Float,y:Float,depth:Int) : Void
	{
			var xp : Explosion =  new Explosion(x, y, depth);
			xp.createMineParticles();
			add(xp);
			xp.start(Explosion.TIME_SPAN);
	}
}