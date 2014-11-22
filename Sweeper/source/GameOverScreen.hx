package  ;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
/**
 * ...
 * @author Ivo Capelo
 */
class GameOverScreen extends FlxState 
{

	public function new() 
	{
		super();
		
	
		
	}
	
	
    override public function create():Void
    {
		makeLabel( "Good job Ranger!\nThe bear rested all winter...", FlxG.width / 2, FlxG.height * 1 / 4-100, 40,3,"center");
		makeLabel( "Press R to play again", FlxG.width / 2, FlxG.height * 3 / 6-100, 20,3,"center");
		makeLabel("By: Auguste Cunha, Bruno Santos and Ivo Capelo", 240, FlxG.height - 60,15,2,"left");
		makeLabel("For 'The GAME of GAMES 2014' game jam @Coimbra", 250, FlxG.height - 30,15,2,"left");
        super.create();
    }
	
	function makeLabel(text:String, x:Float, y:Float, size:Int, borderSize:Int,align:String) : Void
	{
		var label: FlxText = new FlxText(x, y, 0, text,size);

		label.color = 0xff000000;
		label.scrollFactor.x = label.scrollFactor.y = 0;
		label.alignment = align;
		label.borderStyle = FlxText.BORDER_OUTLINE;
		label.borderColor = 0xffffffff;
		label.borderSize = borderSize;
		label.x -= label.width / 2;
		
		add(label);

	}
	
}