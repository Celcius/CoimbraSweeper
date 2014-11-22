package game.levels;

class Level1 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "#___#*######*#########",
        "#_*_t#t##*######ttt###",
        "#___t########t##tttt##",
        "####t#___####**ttttt##",
        "###t##ttt#**##########",
        "##*#*######*##*t#ttt##",
        "############*##t#ttt##",
		"######t#t###*##t#t#t##",
		"#######t####*##t#t#t##",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
