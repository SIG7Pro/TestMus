package play;
class Conductor{
// https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/
// https://www.gamedeveloper.com/audio/coding-to-the-beat---under-the-hood-of-a-rhythm-game-in-unity
// https://fizzd.me/posts/how-to-make-a-rhythm-game-a-quick-and-dirty-guide-to-setting-up-your-project (Turns out to be a duplicate of the Reddit post but with some extra stuff too.)
    public var bpm:Float = 100;
    // BPM of song.
    public var crotchet:Float = 0;
    // BPM divided by 60. Beats per second.
    public var offset:Float = 0;
    // Offset likely won't be accounted as of writing.
    public var songPosition:Float;
    // Current time of the song. (In MS.)
        public var songPositionBeats:Float;
        // Ditto but in beats.
        public var songLength:Float;
        // Determines the length of the song. It should be grabbed with the "length" variable or "endTime" variable (if one is set) of the FlxSound.
    public var lastBeat:Float;
    // Previous beat. // Sort of the "delayed" beat.
    public var amountBumped:Float = 0;
    // Variable dedicated to how many bumps occured.
    public var isBump:Bool = true;
    // Determines if the song is on a beat
     public var bigBump:Bool = true;
    // Goes off when a song hits every four beats.

        var inputBPM:Float;
        public function activate(inputBPM:Float) {
            bpm = inputBPM;
            trace("Conductor Activated. BPM: " + bpm);
            crotchet = ((60 / bpm) * 1);
            //todo: figure out 4 beat - bump method
        }

        public function new(){}

        public function updateInfo(songPosition:Float, songLength:Float)
        {
            crotchet = ((60 / bpm) * 1000);
            songPositionBeats = songPosition / crotchet;

                if (Math.ffloor(songPosition / 1000) >= Math.ffloor(songLength / 1000))
                {
                    songDone();
                    return;
                }

                //trace("if " + (Math.ffloor(songPositionBeats) == Math.ffloor(lastBeat + 4) ) );
                // trace("songPositionBeats: " + songPositionBeats + "(Floored: " + Math.ffloor(songPositionBeats) + ") | lastBeat Floored: " + Math.ffloor(lastBeat) + " | Combined: " + Math.ffloor(songPositionBeats + lastBeat));

                if (Math.ffloor(songPositionBeats) == Math.ffloor(lastBeat + 1) ){ // Plays on every beat.
                    isBump = true;
                    lastBeat = songPositionBeats;
                    trace("Bump!");
                    amountBumped += 1;
                }else{
                    isBump = false;
                }

               /* if (Math.ffloor(songPositionBeats) == Math.ffloor(lastBeat + 4) ){
                    bigBump = true;
                    lastBeat = songPositionBeats;
                    trace("Big Bump!");
                    //amountBumped += 1;
                }else{
                    bigBump = false;
                }*/
        }

        public function songDone(){
            trace("Hooray!");
            return;
        }
}
