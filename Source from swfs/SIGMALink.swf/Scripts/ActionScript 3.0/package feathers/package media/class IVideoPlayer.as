//class IVideoPlayer
package feathers.media 
{
    public interface IVideoPlayer extends feathers.media.IAudioPlayer
    {
        function get nativeWidth():Number;

        function get nativeHeight():Number;
    }
}


