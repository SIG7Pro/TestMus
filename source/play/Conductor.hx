package play;
class Conductor{
// https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/
// https://www.gamedeveloper.com/audio/coding-to-the-beat---under-the-hood-of-a-rhythm-game-in-unity
    public var bpm:Float; // BPM of song.
    public var crotchet:Float = 0; // Duration of a beat calculated from BPM. // Beats per second.

    public var songPosition:Float; // in MS
    public var songBeatsPosition:Float; // in beats

    public var beatNumber:Float; // Current beat.
    public var lastBeat:Float; // Previous beat.

    public var amountBumped:Float = 0; // Variable dedicated to how many bumps occured.

    //public var songActive:Bool = true;
    public var isBump:Bool = false; /* Determines if the song is on a beat. */

    public var songLength:Float; // Determines the length of the song. It should be grabbed with the "length" variable of the FlxSound.

        var inputBPM:Float;
        public function activate(inputBPM:Float) {
            bpm = inputBPM;
            trace("Conductor Activated. BPM: " + bpm);
            //todo: figure out 4 beat - bump method
        }

        public function new(){}Z

        public function updateInfo(songPosition:Float, songLength:Float)
        {
        crotchet = ((60 / bpm) * 1000);
        songBeatsPosition = songPosition / crotchet;

                if (songBeatsPosition > (lastBeat + crotchet))
                {
                    bump(); // Bump, a way to signal a beat.
                    lastBeat += crotchet;
                }/*else if  (songPosition >= (songLength - 999)){ // Remember, the song's length and positions are declared via miliseconds.
                    songDone();
                }*/
                if (songPosition == 0)
                {
                    songDone();
                    return;
                }




        }

        public function bumpold(){

            if (amountBumped < 4){ // Apparently most songs go by beats of 4.
                trace("Bump!");
                amountBumped += 1;
                isBump = false;
            }else if (amountBumped >= 4){
                isBump = true;
                amountBumped = 0;
            }
        }

        public function bump(){
            if (amountBumped < 4){ // Apparently most songs go by beats of 4.
                amountBumped += 1;
                trace("Hold");
                isBump = false;
            }else if (amountBumped >= 4){
                amountBumped = 0;
                trace("Bump!");
                isBump = true;
            }
        }

        public function songDone(){
            trace("Hooray!");
        }
}
