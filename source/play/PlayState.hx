package play;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import flixel.sound.FlxSound;
import play.Conductor;
import Math;
class PlayState extends FlxState {
		var colorLocation : String = "assets/images/colors/";

		var test:FlxSprite;
		var mainFocus:FlxSprite;
		var songConductor:Conductor;
		var sprite:FlxSprite;
		var infoText:FlxText;

		// Ref: https://youtu.be/qR1OntJJVKk?t=349
		var currentSong:FlxSound;
		var neededSound:FlxSound;

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

			// High (Erect) BPM: 125
			// Tutorial & Bopeebo: 100
			// Monster: 95
			// Thorns: 190
			// https://www.reddit.com/r/FridayNightFunkin/comments/m6xcrg/fnf_bpm_i_will_update_when_week_7_comes_out/
			// https://www.reddit.com/r/FridayNightFunkin/comments/1hhkd41/uhhhhhhhhhhhhhhh/ perfect for rickroll
			neededSound = FlxG.sound.load("assets/sounds/metronome1.ogg");
			if (FlxG.sound.music == null) {
					startSong("Bopeebo_Inst.ogg", 100); // Assumes its in "/assets/music" already.
					trace("Song Loaded.");
			}
		}

		var sBP:Float; // songBeatsPosition
		//vz
		var moreThanLessBumps:Float;
		override function update(elapsed:Float):Void {
		// 0/10000
		// BPM: 100 | Chrotchet: 0.1
		// Last Beat / Current Beat
		sBP = Math.ffloor(songConductor.songBeatsPosition);

			infoText.text = Math.ffloor(currentSong.time / 1000) + " / " + Math.ffloor(currentSong.length / 1000) +
			"\n(Position in Beats: " + sBP + " | Current Beat: " + sBP + ")" +
			"\nBPM: " + songBeats + " (In) " + songConductor.bpm + " | Chrotchet: " + songConductor.crotchet +
			"\nLast Beat: " + Math.ffloor(songConductor.lastBeat) + " + 4 = " + Math.ffloor(songConductor.lastBeat + 4) +
			"\nAmount Bumped: " + songConductor.amountBumped;

		//	//if (FlxG.sound.music != null) {
		//	trace("Music not null.");
				if (songConductor.isBump == true){
						mainFocus.alpha = 0.5;
						mainFocus.scale.set(1.125, 1.125);
						trace("Ah!");

				}else if (songConductor.isBump == false){
						mainFocus.alpha = 1;
						mainFocus.scale.set(1.0, 1.0);
				}
			//}

			if (songConductor.isBump == true)
				neededSound.play(true);

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
