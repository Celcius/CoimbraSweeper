package game.levels;

class Level6 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "SSSSSSSSSSSSSSSSS",
		"St.._*tttt*..tttS",		
        "St..*______..tttS",
        "Sttt*___.._...*tS",
        "Sttt___**.*.*..tS",
        "SP___B_*b__._..tS",
        "Sttt___**..*_..tS",
        "Stt*_______._tttS",
        "St.*_*tttt*..tttS",		
        "SSSSSSSSSSSSSSSSS",

    ];
	/*
	 *         "t#t*ttttttt",
        "tP########t",
        "t#########t",
        "tB########t",
		"tb########t",
		"t#########t",
		"t#########t",
		"ttttttttttt",
		*/

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
