package game;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import game.levels.Level;
import game.tiles.Grass;
import game.tiles.Terrain;
import game.tiles.Bomb;

class Game extends FlxState {

    public static var BLOCK_WIDTH:Int = 101;
    public static var BLOCK_HEIGHT:Int = 83;

    public var _grid:Array<Array<Tile>>;
    private var _level:Level;

    private var numberGrid:Array<Array<Int>>;

    public static var GMAP:Map<String,Dynamic>;

    public static var _gridGroup:FlxSpriteGroup;


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
        GMAP.set('t', Grass);

        _gridGroup = new FlxSpriteGroup();
        add(_gridGroup);


        drawGrid(_level.getGrid());
        populateNumberGrid();

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

    /**
	 * Function that is called once every frame.
	 */
    override public function update():Void
    {
        super.update();
    }
}