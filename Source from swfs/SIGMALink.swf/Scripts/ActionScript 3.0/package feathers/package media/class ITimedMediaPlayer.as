//class ITimedMediaPlayer
package feathers.media 
{
    public interface ITimedMediaPlayer extends feathers.media.IMediaPlayer
    {
        function get currentTime():Number;

        function get totalTime():Number;

        function get isPlaying():Boolean;

        function togglePlayPause():void;

        function play():void;

        function pause():void;

        function stop():void;

        function seek(arg1:Number):void;
    }
}


