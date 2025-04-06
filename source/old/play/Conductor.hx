package play;
import flixel.sound.FlxSound;
class Conductor{
// https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/
    public var bpm:Float = 100; // BPM of song.
    public var crotchet:Float = 0; // Duration of a beat calculated from BPM.
    public var offset:Float = 0; // Because I'm // MP3 crap.
    public var songPosition:Float; // ???
    public var beatNumber:Float; // Was gonna be an int but I feel like the reference was using all floats and I don't wanna mess things up more than usual.
    public var lastBeat:Float; // Ditto.
// https://www.gamedeveloper.com/audio/coding-to-the-beat---under-the-hood-of-a-rhythm-game-in-unity
    public var song:FlxSound;
    public var curSongTime:Float;
// Solo Vars
    public var amountBumped:Float = 0; // Variable dedicated to how many bumps occured.
    public var loadedSongFile:String = "Freshurms-Scrap.mp3";
    //todo: ref fnfs old conductor https://github.com/FunkinCrew/Funkin/blob/v0.2.7.1/source/Conductor.hx

        public function new(loadedSongFile:String, bpm:Float) {
            crotchet = 60 / bpm;
            //songStart(loadedSongFile);
        }

        public function update(){

            songPosition = song.time;

            if (songPosition > lastBeat + crotchet){
                bump(); // Bump
                lastBeat += crotchet;
            }

        }
        public function bump(){
            trace("Bump!");
            amountBumped += 1;
        }

        public function songStart(songFile:String){
            song.loadEmbedded("Freshurms-Scrap.mp3");
            song.play();
        }

        public function songDone(){
            trace("Hooray!");
        }
}
