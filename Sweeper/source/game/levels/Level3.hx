package game.levels;

class Level3 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "tttttttttttt",
		"tv<<<*...ttt",
		"tvS*...*...t",
		"tvSP.B.v*..t",
		"tvS...**__.t",
		"t>>_>>>^._*t",
		"tb.._.....St",
        "tttttttttttt",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
