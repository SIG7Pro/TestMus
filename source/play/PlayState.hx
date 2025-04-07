package play;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import flixel.sound.FlxSound;
import play.Conductor;
class PlayState extends FlxState {
		var colorLocation : String = "assets/images/colors/";

		var test:FlxSprite;
		var mainFocus:FlxSprite;
		var songConductor:Conductor;
		var sprite:FlxSprite;
		var infoText:FlxText;

		// Ref: https://youtu.be/qR1OntJJVKk?t=349
		var currentSong:FlxSound;

		var songTime:Float;

		var songName:String;
		var songBeats:Float = 100; //BPM
		var inputBPM:Float; // BPM Input?

		override public function create():Void {
			mainFocus = new FlxSprite("assets/images/finder.png");
			// mainFocus.loadGraphic("assets/images/finder.png");
			mainFocus.scale.x = 0.6;
			mainFocus.scale.y = 0.6;
			mainFocus.updateHitbox();
			mainFocus.screenCenter();


			sprite = new FlxSprite();
			sprite.makeGraphic(256, 128, FlxColor.BLUE);
			sprite.screenCenter();
			sprite.alpha = 0.25;
			add(sprite);

			add(mainFocus);

			infoText = new FlxText(12, 12, FlxG.width - 8, "", 12);
			infoText.text = "Test State";
			infoText.color = FlxColor.WHITE;
			infoText.setBorderStyle(OUTLINE, 0xFF38348e, 1);
			infoText.font = "assets/fonts/Fairfax.ttf";
			add(infoText);

			songConductor = new Conductor();
			//add(songConductor);

			trace("Sprites Made");

			// BPM: 125

			if (FlxG.sound.music == null) {
					startSong("HE.ogg", 125); // Assumes its in "/assets/music" already.
					trace("Song Loaded.");
			}
		}

		override function update(elapsed:Float):Void {
		// 0/10000
		// BPM: 100 | Chrotchet: 0.1
		// Last Beat / Current Beat
			infoText.text = currentSong.time + " / " + currentSong.length +
			"\n(Position in Beats: " + songConductor.songBeatsPosition + " | Current Beat: " + songConductor.beatNumber + ")" +
			"\nBPM: " + songBeats + " (In) " + songConductor.bpm + " | Chrotchet: " + songConductor.crotchet +
			"\nLast Beat: " + songConductor.lastBeat + "\nAmount Bumped: " + songConductor.amountBumped;

			if (FlxG.sound.music != null) {
			trace("Music not null.");
				if (songConductor.isBump == false){
						mainFocus.alpha = 0.5;
						mainFocus.scale.set(1.5, 1.5);
						trace("Ah!");
				}else if (songConductor.isBump == true){
						mainFocus.alpha = 1;
						mainFocus.scale.set(1.0, 1.0);
				}
			}


			//songConductor.songPosition = currentSong.time;
			// songTime = currentSong.time;
			// songConductor.update(songTime);
			songConductor.updateInfo(currentSong.time, currentSong.length);

		}

		function startSong(songName:String, inputBPM:Float){
			// FlxG.sound.load stores a sound.
			// 		  .play("..."); plays a sound.
			//		 	  .playMusic("..."); Apparently plays music that loops. Relates to FlxG.sound.music. sound = new FlxSound;
			if (currentSong == null)
				currentSong = FlxG.sound.load("assets/music/" + songName);
			currentSong.play();
			songBeats = inputBPM;
			trace('BPM: $songBeats.');
			songConductor.activate(songBeats);
			trace("PlayState Conductor.");

		}
}
