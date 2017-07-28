//class FullScreenToggleButton
package feathers.media 
{
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.skins.*;
    import starling.events.*;
    
    public class FullScreenToggleButton extends feathers.controls.ToggleButton implements feathers.media.IMediaPlayerControl
    {
        public function FullScreenToggleButton()
        {
            super();
            this.isToggle = false;
            this.addEventListener(starling.events.Event.TRIGGERED, this.fullScreenButton_triggeredHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return FullScreenToggleButton.globalStyleProvider;
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
                this._mediaPlayer.removeEventListener(feathers.events.MediaPlayerEventType.DISPLAY_STATE_CHANGE, this.mediaPlayer_displayStageChangeHandler);
            }
            this._mediaPlayer = arg1 as feathers.media.VideoPlayer;
            if (this._mediaPlayer) 
            {
                this.isSelected = this._mediaPlayer.isFullScreen;
                this._mediaPlayer.addEventListener(feathers.events.MediaPlayerEventType.DISPLAY_STATE_CHANGE, this.mediaPlayer_displayStageChangeHandler);
            }
            return;
        }

        protected function fullScreenButton_triggeredHandler(arg1:starling.events.Event):void
        {
            this._mediaPlayer.toggleFullScreen();
            return;
        }

        protected function mediaPlayer_displayStageChangeHandler(arg1:starling.events.Event):void
        {
            this.isSelected = this._mediaPlayer.isFullScreen;
            return;
        }

        protected var _mediaPlayer:feathers.media.VideoPlayer;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


