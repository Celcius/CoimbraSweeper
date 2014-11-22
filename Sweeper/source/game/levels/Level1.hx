package game.levels;

class Level1 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "#___########",
        "#_*_t#######",
        "#___t#######",
        "####t#######",
        "###t########",
        "############",
        "############",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
