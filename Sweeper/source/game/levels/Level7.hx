package game.levels;

class Level7 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
		"STTTTSSTTTTS",	
		"STTTTSSTT..S",
		"STTTTSS....S",
		"STTttww....S",
		"SP.B>>>>.*bS",
		"S....tt...*S",
		"S..*....*..S",
		"SttttttttttS",
		"SttttttttttS",
		"SttttttttttS",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
