package play;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import haxe.io.Path;
import flixel.FlxState;

import flixel.util.FlxColor;
import flixel.FlxCamera;

import flixel.ui.FlxBar; // Health Bar Stuff
import flixel.ui.FlxButton; // Health Bar Testing
import flixel.text.FlxText;
import flixel.input.keyboard.FlxKey;

import Std;

import play.Conductor;
import play.ArrowStaff;
import flixel.sound.FlxSound;

import flixel.math.FlxRandom;

// Reference code: https://github.com/yophlox/Moon4K/blob/main/source/states/PlayState.hx
// (Hard to understand.)

class PlayState extends FlxState {
	//static inline var placeholderLocation = 'assets/images/Placeholder/';

	var hudCam:FlxCamera;
	var gameCam:FlxCamera;

	//var healthBar:FlxBar;
	var health:Float = 50;
	var scoreValue:Float = 0;

	var strumLine:FlxTypedGroup<FlxSprite>;
	var mainKeys:Array<Array<FlxKey>> = [[A, LEFT], [S, DOWN], [W, UP], [D, RIGHT]];
	var downscroll:Bool = false;
	
	// Experimenting with note spawning.
	var notes:FlxTypedGroup<ArrowStaff>;

	var songConductor:Conductor;
	var currentSong:FlxSound;
	var metronomeSFX:FlxSound;
	var infoText:FlxText;

	// Song Data
	public var songName:String;
	public var songTime:Float; // In miliseconds, how much time has passed in the song.
	public var songBPM:Float = 100; // Beats per minute.
	public var curBeat:Float; // songPositionBeats
	public var songChrotchet:Float; // Beats per second.
	public var noteTime:Float; // Time when a note is spawned. Temporary functionality.
	public var songSpeed:Float; // Time when a note is spawned. Temporary functionality.

	public var notesMade:Int = 0; // Tracks how many arrows have been made, not how many arrows are on screen and/or exist in the scene.

	override function create() {
		trace("PlayState.hx initiated.");

		var sprite = new FlxSprite();
		sprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
		sprite.screenCenter();
		sprite.alpha = 0.5;
		add(sprite);

		strumLine = new FlxTypedGroup<FlxSprite>();
		add(strumLine);
		notes = new FlxTypedGroup<ArrowStaff>();
		add(notes);

		hudCam = new FlxCamera();
		hudCam.bgColor.alpha = 0;
		FlxG.cameras.add(hudCam);

		gameCam = new FlxCamera();
		gameCam.bgColor.alpha = 0;
		FlxG.cameras.add(gameCam);

		makeStrumline();
		//makePlayNote(3, 2);

		infoText = new FlxText(12, 12, FlxG.width - 8, "", 12);
			infoText.text = "Test State";
			infoText.color = FlxColor.WHITE;
			infoText.setBorderStyle(OUTLINE, 0xFF38348e, 1);
			infoText.font = "assets/fonts/Fairfax.ttf";
			add(infoText);

		super.create();

		songConductor = new Conductor();
		metronomeSFX = FlxG.sound.load("assets/sounds/metronome1.ogg");
			if (FlxG.sound.music == null || currentSong == null) {
					startSong("Monster_Inst.ogg", 95); // Assumes its in "/assets/music" already.
					songSpeed = 1;
					trace("Song Loaded.");
			}

	}

	public function makeStrumline()
	{
		for (i in 0...2) 
		{
			for (j in 0...4) 
			{
					var makeStrumInsertID:Int = (i * j);
					var makeStrumInsX:Float = (33 + (120 * j) + (FlxG.width / 1.875) * i);
					var makeStrumInsY:Float = (downscroll ? FlxG.height - 150 : 50);
					
					// x = 50 + (120 * j) + (FlxG.width / 1.875) * i
					// y = downscroll ? 50 : FlxG.height - 150 // If upscroll then Y = 50, if downscroll then 150.

					var babyArrow:ArrowStaff = new ArrowStaff(makeStrumInsX, makeStrumInsY, 154, 157, 0xff87a3ad, 0);
					babyArrow.id = makeStrumInsertID;
					babyArrow.scale.set(0.75, 0.75);
					babyArrow.updateHitbox();
					strumLine.add(babyArrow);
			}
		}
	}	

	public var ran58:Int;
	override function update(elapsed:Float){
		songUtils();
		// trace("Note Time: " + noteTime + ", Current Song Time: " + songTime);
		// My guess on how one would make a chart format would to have makePlayNote be ran on a specific time, granted the game doesn't skip over it.

		if (FlxG.keys.justPressed.W)
			{
				//
				//ran58 = Math.floor(FlxG.random.int(5, 8));
				makePlayNote(3, 2);
				trace("Launch!");
			}
		if (FlxG.keys.justPressed.A)
			{
				//
				//ran58 = Math.floor(FlxG.random.int(5, 8));
				makePlayNote(1, 2);
				trace("Launch!");
			}
		if (FlxG.keys.justPressed.S)
			{
				//
				//ran58 = Math.floor(FlxG.random.int(5, 8));
				makePlayNote(2, 2);
				trace("Launch!");
			}
		if (FlxG.keys.justPressed.D)
			{
				//
				//ran58 = Math.floor(FlxG.random.int(5, 8));
				makePlayNote(4, 2);
				trace("Launch!");
			}
		if (FlxG.keys.justPressed.SPACE)
			{
				//
				ran58 = Math.floor(FlxG.random.int(5, 8));
				makePlayNote(ran58, 2);
				trace("Launch!");
			}
		if (FlxG.keys.justPressed.UP)
			{
				//
				//ran58 = Math.floor(FlxG.random.int(5, 8));
				makePlayNote(7, 2);
				trace("Launch!");
			}
		if (FlxG.keys.justPressed.LEFT)
			{
				//
				//ran58 = Math.floor(FlxG.random.int(5, 8));
				makePlayNote(5, 2);
				trace("Launch!");
			}
		if (FlxG.keys.justPressed.DOWN)
			{
				//
				//ran58 = Math.floor(FlxG.random.int(5, 8));
				makePlayNote(6, 2);
				trace("Launch!");
			}
		if (FlxG.keys.justPressed.RIGHT)
			{
				makePlayNote(8, 2);
			}


		changeColor();
		//keyCheck(1);
		for (i in 0...mainKeys.length) {
			keyCheck(i);
		}

		if (songConductor.isBump)
			infoText.scale.set(1.1, 1.1);
		else
			infoText.scale.set(1.0, 1.0);

		if (notesMade > 0){
			for (arrow in notes.members){
				arrow.savedNoteTime = (songTime / 1);
				if (downscroll)
					//arrow.y += Std.int(songConductor.songPositionBeats);
					arrow.y += (songSpeed * 12.5) + (songSpeed * ((arrow.savedNoteTime - songTime) * songSpeed * (0.45)) ) ;
				else // So glad I can do ifelses without brackets too!
					//arrow.y -= Std.int(songConductor.songPositionBeats);
					arrow.y -= (songSpeed * 12.5) + (songSpeed * ((arrow.savedNoteTime - songTime) * songSpeed * (0.45)) );
				//arrow.y -= 150;
				//trace("Note Time: " + noteTime + ",  Saved Note Time: " + arrow.savedNoteTime + ", Current Song Time: " + songTime);
			}
		}

	}

	//public var makePlayNotesInsX:Float;

	public function makePlayNote(value:Int, speed:Float) // 1-4 Opp / 5-8 Play //
	{
					//scrollSpeed = speed;
					var makePlayNotesID:Int = value;
					var makePlayNotesInsX:Float;
					switch makePlayNotesID {
						case 1: makePlayNotesInsX = (33 + (FlxG.width / 1.875) * 0);
						case 2: makePlayNotesInsX = (153 + (FlxG.width / 1.875) * 0);
						case 3: makePlayNotesInsX = (273 + (FlxG.width / 1.875) * 0);
						case 4: makePlayNotesInsX = (393 + (FlxG.width / 1.875) * 0);

						case 5: makePlayNotesInsX = (33 + (FlxG.width / 1.875));
						case 6: makePlayNotesInsX = (33 + 120 + (FlxG.width / 1.875));
						case 7: makePlayNotesInsX = (33 + 240 + (FlxG.width / 1.875));
						case 8: makePlayNotesInsX = (33 + 360 + (FlxG.width / 1.875));
						default: makePlayNotesInsX = FlxG.width / 2;
					}

					//noteTime = songTime;
					trace(noteTime);
					var childPlayArrow:ArrowStaff = new ArrowStaff(makePlayNotesInsX, -10, 154, 157, 0xff87a3ad, noteTime);
					childPlayArrow.scale.set(0.75, 0.75);
					childPlayArrow.updateHitbox();
					childPlayArrow.color = FlxColor.BLUE;
					notesMade += 1;
					childPlayArrow.id = notesMade;

					/*if (downscroll)
							childPlayArrow.y = FlxG.height - ((songConductor.songPositionBeats) * (10 * 2));
					}else{
							childPlayArrow.y = (FlxG.height + (childPlayArrow.height) - 200) * -1;
					}*/
					if (downscroll){
						childPlayArrow.y = -1 * (FlxG.height + (157 * 1.5));
					}else{
						childPlayArrow.y = FlxG.height + (157 * 1.5);
					}

					notes.add(childPlayArrow);
					//childPlayArrow.y = FlxG.height - ((songConductor.songPositionBeats) * (10 * scrollSpeed));

	}

	public function keyCheck(data:Int)
	{
		if (FlxG.keys.anyPressed(mainKeys[data])) 
		{
			strumLine.members[data+4].scale.set(0.65, 0.65);
		} else {
			strumLine.members[data+4].scale.set(0.75, 0.75);
		}
	}

	function changeColor(){
			// Strum members start from zero.
			strumLine.members[0].color = FlxColor.RED;
			strumLine.members[1].color = FlxColor.RED;
			strumLine.members[2].color = FlxColor.RED;
			strumLine.members[3].color = FlxColor.RED;
			strumLine.members[4].color = FlxColor.GREEN;
			strumLine.members[5].color = FlxColor.GREEN;
			strumLine.members[6].color = FlxColor.GREEN;
			strumLine.members[7].color = FlxColor.GREEN;
	}
	function startSong(songName:String, inputBPM:Float){
			// FlxG.sound.load stores a sound.
			// 		  .play("..."); plays a sound.
			currentSong = FlxG.sound.load("assets/music/" + songName);
			currentSong.play();
			songBPM = inputBPM;
			trace('BPM: $songBPM.');
			songConductor.activate(songBPM);
			trace("PlayState Conductor.");

		}
	function songUtils(){
		songConductor.updateInfo(currentSong.time, currentSong.length); // MOST IMPORTANT LINE. WITHOUT IT, THE SONG WILL BE IN LIMBO!
		songTime = currentSong.time;

		curBeat = Math.ffloor(songConductor.songPositionBeats); // Setting the current beat.
		songChrotchet = songConductor.crotchet;

		if (songConductor.isBump == true)
				metronomeSFX.play(true);

		infoText.text = "" +
		Math.ffloor(currentSong.time / 1000) + " / " + Math.ffloor(currentSong.length / 1000) + "(Position in Beats: " + curBeat + " | Current Beat: " + curBeat + ")" +
		"\nBPM: " + songBPM + " (In) " + songConductor.bpm + " | Chrotchet: " + songConductor.crotchet +
		"\nLast Beat: " + Math.ffloor(songConductor.lastBeat) + " + 4 = " + Math.ffloor(songConductor.lastBeat + 4) + " | Amount Bumped: " + songConductor.amountBumped  + /*"\nLast Tracked Note Time: " + noteTime; // Placed here so it isn't an eyesore in update();*/
		"\nScroll Speed: " + songSpeed;



	}
}
