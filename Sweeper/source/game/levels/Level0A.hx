package game.levels;

class Level0A extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "SSSSSSSSSSS",
        "TwSSSwSSSwT",
		"T^>>>^<<<^T",
        "TttttttttbT",
		"T.P.B.....T",
        "Tttttttt..T",
		"Tt.tttttttT",
        "TTTTTTTTTTT",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
