package game.levels;

class Level2 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "t#t*ttttttt",
        "tP########t",
        "t#########t",
        "t#########t",
		"t#########t",
		"tR########t",
		"t#########t",
		"ttttttttttt",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
