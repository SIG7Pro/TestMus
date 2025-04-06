package play;
import flixel.sound.FlxSound;
import play.Conductor;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;

// Shoutouts to formatter.org. Formatted with Chromium Style with an Indent of 5. Though I did move some variables and functions back one.
	class PlayState extends FlxState {
	var colorLocation : String = "assets/images/colors/";

	var test:FlxSprite;
	var mainFocus:FlxSprite;
	var condoCt:Conductor;
	var sprite:FlxSprite;
	var myText:FlxText;

	// Ref: https://youtu.be/qR1OntJJVKk?t=349
	var currentSong:FlxSound;

     // var darkShad:ByteArray = new Darken(openfl.display.BitmapData);
     /**
      * Function that is called up when to state is created to set it up.
      */
	override public function create():Void {
          mainFocus = new FlxSprite("assets/images/finder.png");
          // mainFocus.loadGraphic("assets/images/finder.png");
          mainFocus.scale.x = 0.6;
          mainFocus.scale.y = 0.6;
          mainFocus.updateHitbox();
          mainFocus.screenCenter();
          add(mainFocus);

          sprite = new FlxSprite();
          sprite.makeGraphic(128, 64, FlxColor.BLUE);
          sprite.screenCenter();
          // add(sprite);

          myText = new FlxText(12, 12, FlxG.width - 8, "", 12);
          myText.text = "Test State";
          myText.color = FlxColor.WHITE;
          myText.setBorderStyle(OUTLINE, 0xFF38348e, 1);
          myText.font = "assets/fonts/Fairfax.ttf";
          add(myText);

          // Song 1: High Erect (Instrumental) - Friday Night Funkin' OST
          // Arrangement: Kohta T., Kawai Sprite
          // BPM: 125

          // Song 2: Freshurms (Can't be loaded on SYS because MP3.)
          // Song Length: 35:55 seconds.
          // BPM: 135

          if (FlxG.sound.music == null) {
               startSong("assets/music/Inst-erect.ogg");
          }
	}

	override function update(elapsed : Float) : Void {
          // myText.text =
	}

	var songName:String;
	function startSong(songName:String) {
          // FlxG.sound.load stores a sound.
          // 		  .play("..."); plays a sound.
          //		 	  .playMusic("..."); Apparently plays music that
          //loops. Relates to FlxG.sound.music. sound = new FlxSound;
          // FlxG.sound.playMusic("assets/music/Inst-erect.ogg");
          if (currentSong == null)
               currentSong = FlxG.sound.load(songName);
          currentSong.play();
	}
}
