package play;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import flixel.sound.FlxSound;
import play.Conductor;
// Shoutouts to formatter.org. Formatted with Chromium Style with an Indent of 5. Though I did move some variables and functions back one.
	class PlayState extends FlxState {
	var colorLocation : String = "assets/images/colors/";

	var test:FlxSprite;
	var mainFocus:FlxSprite;
	var songConductor:Conductor;
	var sprite:FlxSprite;
	var myText:FlxText;

	// Ref: https://youtu.be/qR1OntJJVKk?t=349
	var currentSong:FlxSound;

	var songTime:Float;

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

          trace("Sprites Made");

          // BPM: 125

          if (FlxG.sound.music == null) {
                startSong("HE.ogg", 125); // Assumes its in "/assets/music" already.
					trace("Song Loaded?");
				//songConductor.activate(bpm, true);
					trace("Conductor.");
         }
	}

	override function update(elapsed : Float) : Void {
          // myText.text =
         /* if (songConductor.isBump == false){
				mainFocus.alpha = 0.5;
          }else if (songConductor.isBump == true){
				mainFocus.alpha = 1;
          }*/


		 //songConductor.songPosition = currentSong.time;
         // songTime = currentSong.time;
         // songConductor.update(songTime);
         //songConductor.updateInfo(currentSong.time);

	}

	var songName:String;
	var bpm:Float;
	function startSong(songName:String, bpm:Float) {
          // FlxG.sound.load stores a sound.
          // 		  .play("..."); plays a sound.
          //		 	  .playMusic("..."); Apparently plays music that loops. Relates to FlxG.sound.music. sound = new FlxSound;
          if (currentSong == null)
               currentSong = FlxG.sound.load("assets/music/" + songName);
          currentSong.play();

	}
}
