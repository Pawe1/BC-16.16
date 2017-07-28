//class BaseTimedMediaPlayer
package feathers.media 
{
    import feathers.events.*;
    import starling.errors.*;
    
    public class BaseTimedMediaPlayer extends feathers.media.BaseMediaPlayer implements feathers.media.ITimedMediaPlayer
    {
        public function BaseTimedMediaPlayer()
        {
            super();
            if (Object(this).constructor === feathers.media.BaseTimedMediaPlayer) 
            {
                throw new starling.errors.AbstractClassError();
            }
            return;
        }

        public function get isPlaying():Boolean
        {
            return this._isPlaying;
        }

        public function get currentTime():Number
        {
            return this._currentTime;
        }

        public function get totalTime():Number
        {
            return this._totalTime;
        }

        public function togglePlayPause():void
        {
            if (this._isPlaying) 
            {
                this.pause();
            }
            else 
            {
                this.play();
            }
            return;
        }

        public function play():void
        {
            if (this._isPlaying) 
            {
                return;
            }
            this.playMedia();
            this._isPlaying = true;
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.PLAYBACK_STATE_CHANGE);
            return;
        }

        public function pause():void
        {
            if (!this._isPlaying) 
            {
                return;
            }
            this.pauseMedia();
            this._isPlaying = false;
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.PLAYBACK_STATE_CHANGE);
            return;
        }

        public function stop():void
        {
            this.pause();
            this.seek(0);
            return;
        }

        public function seek(arg1:Number):void
        {
            this.seekMedia(arg1);
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.CURRENT_TIME_CHANGE);
            return;
        }

        protected function playMedia():void
        {
            return;
        }

        protected function pauseMedia():void
        {
            return;
        }

        protected function seekMedia(arg1:Number):void
        {
            return;
        }

        protected var _isPlaying:Boolean=false;

        protected var _currentTime:Number=0;

        protected var _totalTime:Number=0;
    }
}


