//class IAudioPlayer
package feathers.media 
{
    import flash.media.*;
    
    public interface IAudioPlayer extends feathers.media.ITimedMediaPlayer
    {
        function get soundTransform():flash.media.SoundTransform;

        function set soundTransform(arg1:flash.media.SoundTransform):void;
    }
}


