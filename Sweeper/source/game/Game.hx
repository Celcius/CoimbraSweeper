package game;

import flixel.util.FlxSort;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.FlxObject;
import flixel.FlxCamera;
import game.levels.Level;
import game.tiles.*;

class Game extends FlxState {

    public static var instance:Game;

	private var player:Player;

    public static var BLOCK_WIDTH:Int = 101;
    public static var BLOCK_HEIGHT:Int = 83;

    private var gridW:Int;
    private var gridH:Int;
    public var _grid:Array<Array<Tile>>;
    private var _level:Level;

    private var numberGrid:Array<Array<Int>>;

    public static var GMAP:Map<String,Dynamic>;

    public static var _gridGroup:FlxSpriteGroup;

    public var playerColliderGroup:FlxGroup;

    public var layers:FlxGroup;
    public var groundLayer:FlxGroup;
    public var playerLayer:FlxSpriteGroup;
    public var topLayer:FlxGroup;


    public function new(level:Level)
    {
        super();
        _level = level;
        instance = this;

        groundLayer = new FlxGroup();
        playerLayer = new FlxSpriteGroup();
        topLayer = new FlxGroup();
        add(groundLayer);
        add(playerLayer);
        add(topLayer);

        playerColliderGroup = new FlxGroup();
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
        //add(_gridGroup);

		drawGrid(_level.getGrid());
        populateNumberGrid();

		createRageBar();
		createBear();

		player = new Player(BLOCK_WIDTH * 1, BLOCK_HEIGHT * 1.5);
		playerLayer.add(player);

		FlxG.camera.setBounds(BLOCK_WIDTH , 0, (_grid[0].length - 1) * BLOCK_WIDTH, _grid.length* BLOCK_HEIGHT, true);
		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN, 1);

        super.create();
    }

    private function drawGrid(grid:Array<String>):Void
    {
        _grid = new Array<Array<Tile>>();
        gridW = grid.length;
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
                groundLayer.add(tile);
            }
            gridH = row.length;
        }
    }

    private function populateNumberGrid():Void
    {
		for( i in 0... _grid.length)
        {
            var _row = _grid[i];
            for ( j in 0... _row.length )
            {
                var tile:Tile = _grid[i][j];

				var numBombs:Int = countBombs(i, j);
				tile.number = numBombs;
            }
        }
    }

	private function countBombs(i:Int, j:Int):Int
	{
		var numBombs:Int = 0;

		var prevLine:Array<Tile> = null;
		if (i > 0)
			prevLine = _grid[i - 1];

		var thisLine = _grid[i];

		var nextLine:Array<Tile> = null;
		if (i < _grid.length - 1)
			nextLine = _grid[i + 1];

		// i - 1
		if (prevLine != null)
		{
			// j - 1
			if (j > 0)
				numBombs += isBomb(prevLine[j-1]) ? 1 : 0;
			// j
			numBombs += isBomb(prevLine[j]) ? 1 : 0;
			// j + 1
			if (j < prevLine.length - 1)
				numBombs += isBomb(prevLine[j+1]) ? 1 : 0;
		}

		// i
		// j - 1
		if (j > 0)
			numBombs += isBomb(thisLine[j-1]) ? 1 : 0;
		// j + 1
		if (j < thisLine.length - 1)
			numBombs += isBomb(thisLine[j+1]) ? 1 : 0;

		// i + 1
		if (nextLine != null)
		{
			// j - 1
			if (j > 0)
				numBombs += isBomb(nextLine[j-1]) ? 1 : 0;
			// j
			numBombs += isBomb(nextLine[j]) ? 1 : 0;
			// j + 1
			if (j < nextLine.length - 1)
				numBombs += isBomb(nextLine[j+1]) ? 1 : 0;
		}

		return numBombs;
	}

	private function isBomb(tile:Tile):Bool
	{
		if (tile == null)
			return false;

		if (tile.className == "bomb")
			return true;

		return false;
	}

    public function getGridX(X:Float):Float
    {
        return Math.floor( X/BLOCK_WIDTH);
    }
    public function getGridY(Y:Float):Float
    {
        return Math.floor((Y+23)/BLOCK_HEIGHT);
    }

    public function getTile(X:Int, Y:Int):game.Tile
    {
        if (X >= 0 && X < gridW && Y >= 0 && Y < gridH){
            return _grid[Y][X];
        }
        return null;
    }

    /**
	 * Function that is called once every frame.
	 */
    override public function update():Void
    {
        //trace("Player X="+getGridX(player.anchorX) + " Y="+getGridY(player.anchorY));

        FlxG.collide(player, playerColliderGroup);
        super.update();

        playerLayer.sort(sortObjs, FlxSort.ASCENDING);
    }

    public static inline function sortObjs(Order:Int, Obj1:FlxObject, Obj2:FlxObject):Int
    {
        var obj1Offset =0;
        var obj2Offset =0;

        if (Std.is(Obj1, TreeSprite)){
            obj1Offset = 50;
        }
        if (Std.is(Obj2, TreeSprite)){
            obj2Offset = 50;
        }

        return FlxSort.byValues(Order, Obj1.y + obj1Offset, Obj2.y + obj2Offset);

}

	private function createRageBar():Void
	{
		Reg.rageBar = new RageBar();
		add(Reg.rageBar);
	}

	private function createBear():Void
	{
		Reg.bear = new Bear();
		playerLayer.add(Reg.bear);
		Reg.bear.y = FlxG.height / 2;
		Reg.bear.x = Reg.bear.width;

	}
}