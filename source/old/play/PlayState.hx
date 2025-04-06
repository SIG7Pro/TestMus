package play;
import flixel.sound.FlxSound;
import play.Conductor;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;


class PlayState extends FlxState
{
	var colorLocation:String = "assets/images/colors/";

	var test:FlxSprite;
	var mainFocus:FlxSprite;
    var condoCt:Conductor;
    var sprite:FlxSprite;

	//var darkShad:ByteArray = new Darken(openfl.display.BitmapData);
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{

		mainFocus = new FlxSprite("assets/finder.png");
		mainFocus.loadGraphic("assets/finder.png");
		mainFocus.scale.x = 0.6;
		mainFocus.scale.y = 0.6;
		mainFocus.updateHitbox();
		mainFocus.screenCenter();
		add(mainFocus);

        sprite = new FlxSprite();
		sprite.makeGraphic(128, 64, FlxColor.BLUE);
		sprite.screenCenter();
		//add(sprite);

		var myText = new FlxText(12, 12, FlxG.width - 8, "", 12);
        myText.text = "Test State";
        myText.color = FlxColor.WHITE;
        myText.setBorderStyle(OUTLINE, 0xFF38348e, 1);
        myText.font = "fairfax";
        add(myText);

        // Song Loaded: High Erect (Instrumental) - Friday Night Funkin' OST
        // Arrangement: Kohta T., Kawai Sprite
        // BPM: 125

        //Song Loaded: Freshurms
        // Song Length: 35:55 seconds.
        // BPM: 135

        //public function new(loadedSongFile:String, bpm:Float) {
        condoCt = new Conductor("assets/Freshurms-Scrap.mp3", 125);
       // add(condoCt);
        condoCt.songStart("assets/Freshurms-Scrap.mp3");

	}

	override function update(elapsed:Float):Void
    {

    }


}
