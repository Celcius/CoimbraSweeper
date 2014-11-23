package game.levels;

class Level0C extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "TTTTSwSTTTT",
        "TtP.BvttttT",
		"Tt..tvttttT",
        "Tt.t..btttT",
		"T..*.tttttT",
        "Tt...tttttT",
		"TT...TTTTTT",
        "TTTTTTTTTTT",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
