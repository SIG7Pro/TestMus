package play;
class Conductor{
// https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/
    public var bpm:Float = 100; // BPM of song.
    public var crotchet:Float = 0; // Duration of a beat calculated from BPM.
    public var offset:Float = 0;
    public var songPosition:Float; // Where you are in the song.
    public var beatNumber:Float;
    public var lastBeat:Float;
// https://www.gamedeveloper.com/audio/coding-to-the-beat---under-the-hood-of-a-rhythm-game-in-unity
    public var curSongTime:Float;
// Solo Vars
    public var amountBumped:Float = 0; // Variable dedicated to how many bumps occured.
    public var loadedSongFile:String;
    //todo: ref fnfs old conductor https://github.com/FunkinCrew/Funkin/blob/v0.2.7.1/source/Conductor.hx

        //public function new(loadedSongFile:String, bpm:Float) {
       //     crotchet = 60 / bpm;
       //     //songStart(loadedSongFile);
       // }

       public function new(bpm:Float) {

            crotchet = 60 / bpm; // Beats per sec.
        }

        public function update(){

            //songPosition = song.time;

            if (songPosition > lastBeat + crotchet){
                bump(); // Bump
                lastBeat += crotchet;
            }

        }
        public function bump(){
            trace("Bump!");
            amountBumped += 1;
        }

        /*public function songStart(songFile:String){
            song.loadEmbedded("Freshurms-Scrap.mp3");
            song.play();
        }*/

        public function songDone(){
            trace("Hooray!");
        }
}
