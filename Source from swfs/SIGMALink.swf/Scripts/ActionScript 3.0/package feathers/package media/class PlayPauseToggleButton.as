//class PlayPauseToggleButton
package feathers.media 
{
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.skins.*;
    import starling.events.*;
    
    public class PlayPauseToggleButton extends feathers.controls.ToggleButton implements feathers.media.IMediaPlayerControl
    {
        public function PlayPauseToggleButton()
        {
            super();
            this.isToggle = false;
            this.addEventListener(starling.events.Event.TRIGGERED, this.playPlayButton_triggeredHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return PlayPauseToggleButton.globalStyleProvider;
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
            if (this._mediaPlayer) 
            {
                this._mediaPlayer.removeEventListener(feathers.events.MediaPlayerEventType.PLAYBACK_STATE_CHANGE, this.mediaPlayer_playbackStateChangeHandler);
            }
            this._mediaPlayer = arg1 as feathers.media.ITimedMediaPlayer;
            this.refreshState();
            if (this._mediaPlayer) 
            {
                this._mediaPlayer.addEventListener(feathers.events.MediaPlayerEventType.PLAYBACK_STATE_CHANGE, this.mediaPlayer_playbackStateChangeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get touchableWhenPlaying():Boolean
        {
            return this._touchableWhenPlaying;
        }

        public function set touchableWhenPlaying(arg1:Boolean):void
        {
            if (this._touchableWhenPlaying == arg1) 
            {
                return;
            }
            this._touchableWhenPlaying = arg1;
            return;
        }

        protected function refreshState():void
        {
            if (!this._mediaPlayer) 
            {
                this.isSelected = false;
                return;
            }
            this.isSelected = this._mediaPlayer.isPlaying;
            this.touchable = !this._isSelected || this._touchableWhenPlaying;
            return;
        }

        protected function playPlayButton_triggeredHandler(arg1:starling.events.Event):void
        {
            this._mediaPlayer.togglePlayPause();
            return;
        }

        protected function mediaPlayer_playbackStateChangeHandler(arg1:starling.events.Event):void
        {
            this.refreshState();
            return;
        }

        public static const ALTERNATE_STYLE_NAME_OVERLAY_PLAY_PAUSE_TOGGLE_BUTTON:String="feathers-overlay-play-pause-toggle-button";

        protected var _mediaPlayer:feathers.media.ITimedMediaPlayer;

        protected var _touchableWhenPlaying:Boolean=true;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


