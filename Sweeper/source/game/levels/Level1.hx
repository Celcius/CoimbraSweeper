package game.levels;

class Level1 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "SSSSSSSwSSSSSSSSSwSSSS",
        "#___#*#v####*####v####",
        "#_*_t#tv#*######tvt###",
        "#___###v##^##t##tvtt##",
        "#PB####>>>^##**ttvtt##",
        "######ttt#**###v<<####",
        "###########*##*v#ttt##",
        "##b#########*##t#ttt##",
		"######t#t###*##t#t#t##",
		"#######t####*##t#t#t##",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
