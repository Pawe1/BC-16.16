//class VolumeSlider
package feathers.media 
{
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.skins.*;
    import flash.media.*;
    import starling.events.*;
    
    public class VolumeSlider extends feathers.controls.Slider implements feathers.media.IMediaPlayerControl
    {
        public function VolumeSlider()
        {
            super();
            this.thumbStyleName = feathers.media.VolumeSlider.DEFAULT_CHILD_STYLE_NAME_THUMB;
            this.minimumTrackStyleName = feathers.media.VolumeSlider.DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK;
            this.maximumTrackStyleName = feathers.media.VolumeSlider.DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK;
            this.minimum = 0;
            this.maximum = 1;
            this.addEventListener(starling.events.Event.CHANGE, this.volumeSlider_changeHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.media.VolumeSlider.globalStyleProvider;
        }

        public function get mediaPlayer():feathers.media.IMediaPlayer
        {
            return this._mediaPlayer;
        }

        public function set mediaPlayer(arg1:feathers.media.IMediaPlayer):void
        {
            if (this._mediaPlayer == arg1) 
            {
                return;
            }
            this._mediaPlayer = arg1 as feathers.media.IAudioPlayer;
            this.refreshVolumeFromMediaPlayer();
            if (this._mediaPlayer) 
            {
                this._mediaPlayer.addEventListener(feathers.events.MediaPlayerEventType.SOUND_TRANSFORM_CHANGE, this.mediaPlayer_soundTransformChangeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function refreshVolumeFromMediaPlayer():void
        {
            var loc1:*=this._ignoreChanges;
            this._ignoreChanges = true;
            if (this._mediaPlayer) 
            {
                this.value = this._mediaPlayer.soundTransform.volume;
            }
            else 
            {
                this.value = 0;
            }
            this._ignoreChanges = loc1;
            return;
        }

        protected function mediaPlayer_soundTransformChangeHandler(arg1:starling.events.Event):void
        {
            this.refreshVolumeFromMediaPlayer();
            return;
        }

        protected function volumeSlider_changeHandler(arg1:starling.events.Event):void
        {
            if (!this._mediaPlayer || this._ignoreChanges) 
            {
                return;
            }
            var loc1:*=this._mediaPlayer.soundTransform;
            loc1.volume = this._value;
            this._mediaPlayer.soundTransform = loc1;
            return;
        }

        public static const DIRECTION_HORIZONTAL:String="horizontal";

        public static const DIRECTION_VERTICAL:String="vertical";

        public static const TRACK_LAYOUT_MODE_SINGLE:String="single";

        public static const TRACK_LAYOUT_MODE_MIN_MAX:String="minMax";

        public static const TRACK_SCALE_MODE_EXACT_FIT:String="exactFit";

        public static const TRACK_SCALE_MODE_DIRECTIONAL:String="directional";

        public static const TRACK_INTERACTION_MODE_TO_VALUE:String="toValue";

        public static const TRACK_INTERACTION_MODE_BY_PAGE:String="byPage";

        public static const DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK:String="feathers-volume-slider-minimum-track";

        public static const DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK:String="feathers-volume-slider-maximum-track";

        public static const DEFAULT_CHILD_STYLE_NAME_THUMB:String="feathers-volume-slider-thumb";

        protected var _ignoreChanges:Boolean=false;

        protected var _mediaPlayer:feathers.media.IAudioPlayer;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


