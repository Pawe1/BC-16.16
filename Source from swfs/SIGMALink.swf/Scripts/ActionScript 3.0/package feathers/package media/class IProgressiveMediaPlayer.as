//class IProgressiveMediaPlayer
package feathers.media 
{
    public interface IProgressiveMediaPlayer extends feathers.media.IMediaPlayer
    {
        function get bytesLoaded():uint;

        function get bytesTotal():uint;
    }
}


