package play;
class Conductor{
// https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/
// https://www.gamedeveloper.com/audio/coding-to-the-beat---under-the-hood-of-a-rhythm-game-in-unity
    public var bpm:Float = 100;
    // BPM of song.
    public var crotchet:Float = 0;
    // Duration of a beat calculated from BPM. // BPS
    public var offset:Float = 0;
    // Offset likely won't be accounted for in this file as of writing.
    public var songPosition:Float;
    // Current song placement. Ex: 102.9 seconds.
    public var beatNumber:Float;
    // Current beat.
    public var lastBeat:Float;
    // Previous beat.

    public var amountBumped:Float = 0;
    // Variable dedicated to how many bumps occured.

    public var songActive:Bool = true;
    public var isBump:Bool = false; /* Determines if the song is on a beat. */

        public function activate(bpm:Float, songActive:Bool) {

            crotchet = 60 / bpm; // Beats per sec.
            if (songActive){ // Requires a loaded FlxSound.
                update();
            }
        }

        public function new(){

        }

        public function update()
        {
            if (songActive)
            {
                if (songPosition > lastBeat + crotchet)
                {
                    bump(); // Bump, a way to signal a beat.
                    lastBeat += crotchet;
                }
            }

        }

        public function bump(){
            isBump = true;
            trace("Bump!");
            amountBumped += 1;
            isBump = false;
        }

        public function songDone(){
            trace("Hooray!");
        }
}
