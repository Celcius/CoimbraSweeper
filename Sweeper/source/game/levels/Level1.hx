package game.levels;

class Level1 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "#___#*#v####*#########",
        "#_*_t#tv#*######tvt###",
        "#___###v##^##t##tvtt##",
        "#PR####>>>^##**ttvtt##",
        "######ttt#**###v<<####",
        "###########*##*v#ttt##",
        "############*##t#ttt##",
		"######t#t###*##t#t#t##",
		"#######t####*##t#t#t##",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
