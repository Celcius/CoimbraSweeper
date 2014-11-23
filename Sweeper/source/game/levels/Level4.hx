package game.levels;

class Level4 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "tttttttttttt",
		"tv<<<*....tt",
		"tvSS._.*...t",
		"tvSP.B.v*..t",
		"tvS...*.__.t",
		"t>>_>>>^._*t",
		"tb...*....St",
        "ttt*.*....tt",
		"ttt*...*.*tt",
		"tttttttttttt",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
