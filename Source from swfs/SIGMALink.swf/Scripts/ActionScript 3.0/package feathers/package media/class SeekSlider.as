//class SeekSlider
package feathers.media 
{
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SeekSlider extends feathers.controls.Slider implements feathers.media.IMediaPlayerControl
    {
        public function SeekSlider()
        {
            super();
            this.thumbStyleName = SeekSlider.DEFAULT_CHILD_STYLE_NAME_THUMB;
            this.minimumTrackStyleName = SeekSlider.DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK;
            this.maximumTrackStyleName = SeekSlider.DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK;
            this.addEventListener(starling.events.Event.CHANGE, this.seekSlider_changeHandler);
            this.addEventListener(feathers.events.FeathersEventType.END_INTERACTION, this.seekSlider_endInteractionHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return SeekSlider.globalStyleProvider;
        }

        public function get mediaPlayer():feathers.media.IMediaPlayer
        {
            return this._mediaPlayer;
        }

        public function set mediaPlayer(arg1:feathers.media.IMediaPlayer):void
        {
            var loc1:*=null;
            if (this._mediaPlayer == arg1) 
            {
                return;
            }
            if (this._mediaPlayer) 
            {
                this._mediaPlayer.removeEventListener(feathers.events.MediaPlayerEventType.LOAD_PROGRESS, this.mediaPlayer_loadProgressHandler);
                this._mediaPlayer.removeEventListener(feathers.events.MediaPlayerEventType.CURRENT_TIME_CHANGE, this.mediaPlayer_currentTimeChangeHandler);
                this._mediaPlayer.removeEventListener(feathers.events.MediaPlayerEventType.TOTAL_TIME_CHANGE, this.mediaPlayer_totalTimeChangeHandler);
            }
            this._mediaPlayer = arg1 as feathers.media.ITimedMediaPlayer;
            if (this._mediaPlayer) 
            {
                this._mediaPlayer.addEventListener(feathers.events.MediaPlayerEventType.CURRENT_TIME_CHANGE, this.mediaPlayer_currentTimeChangeHandler);
                this._mediaPlayer.addEventListener(feathers.events.MediaPlayerEventType.TOTAL_TIME_CHANGE, this.mediaPlayer_totalTimeChangeHandler);
                if (this._mediaPlayer is feathers.media.IProgressiveMediaPlayer) 
                {
                    loc1 = feathers.media.IProgressiveMediaPlayer(this._mediaPlayer);
                    loc1.addEventListener(feathers.events.MediaPlayerEventType.LOAD_PROGRESS, this.mediaPlayer_loadProgressHandler);
                    if (loc1.bytesTotal > 0) 
                    {
                        this._progress = loc1.bytesLoaded / loc1.bytesTotal;
                    }
                    else 
                    {
                        this._progress = 0;
                    }
                }
                else 
                {
                    this._progress = 0;
                }
                this.minimum = 0;
                this.maximum = this._mediaPlayer.totalTime;
                this.value = this._mediaPlayer.currentTime;
            }
            else 
            {
                this.minimum = 0;
                this.maximum = 0;
                this.value = 0;
            }
            return;
        }

        public function get progressSkin():starling.display.DisplayObject
        {
            return this._progressSkin;
        }

        public function set progressSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._progressSkin == arg1) 
            {
                return;
            }
            if (this._progressSkin) 
            {
                this.removeChild(this._progressSkin);
            }
            this._progressSkin = arg1;
            if (this._progressSkin) 
            {
                if (this._progressSkin.parent != this) 
                {
                    this._progressSkin.visible = false;
                    this.addChild(this._progressSkin);
                }
                this._progressSkin.touchable = false;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function layoutChildren():void
        {
            super.layoutChildren();
            this.layoutProgressSkin();
            return;
        }

        protected function layoutProgressSkin():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            if (this._progressSkin === null) 
            {
                return;
            }
            if (this._minimum !== this._maximum) 
            {
                loc1 = (this._value - this._minimum) / (this._maximum - this._minimum);
                if (loc1 < 0) 
                {
                    loc1 = 0;
                }
                else if (loc1 > 1) 
                {
                    loc1 = 1;
                }
            }
            else 
            {
                loc1 = 1;
            }
            if (this._progress === 0 || this._progress <= loc1) 
            {
                this._progressSkin.visible = false;
                return;
            }
            this._progressSkin.visible = true;
            if (this._progressSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this._progressSkin).validate();
            }
            if (this._direction !== feathers.layout.Direction.VERTICAL) 
            {
                loc5 = this.actualWidth - this._minimumPadding - this._maximumPadding;
                this._progressSkin.x = Math.round(this.thumb.x + this.thumb.width / 2);
                this._progressSkin.y = Math.round((this.actualHeight - this._progressSkin.height) / 2);
                loc6 = Math.round(loc5 * this._progress - this._progressSkin.x);
                if (loc6 < 0) 
                {
                    loc6 = 0;
                }
                else 
                {
                    loc7 = Math.round(this.actualWidth - this._progressSkin.x);
                    if (loc6 > loc7) 
                    {
                        loc6 = loc7;
                    }
                }
                this._progressSkin.width = loc6;
            }
            else 
            {
                loc2 = this.actualHeight - this.thumb.height / 2 - this._minimumPadding - this._maximumPadding;
                this._progressSkin.x = Math.round((this.actualWidth - this._progressSkin.width) / 2);
                loc3 = Math.round(loc2 * this._progress);
                loc4 = Math.round(this.thumb.y + this.thumb.height / 2);
                if (loc3 < 0) 
                {
                    loc3 = 0;
                }
                else if (loc3 > loc4) 
                {
                    loc3 = loc4;
                }
                this._progressSkin.height = loc3;
                this._progressSkin.y = loc4 - loc3;
            }
            return;
        }

        protected function updateValueFromMediaPlayerCurrentTime():void
        {
            if (this.isDragging) 
            {
                return;
            }
            this._value = this._mediaPlayer.currentTime;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function seekSlider_changeHandler(arg1:starling.events.Event):void
        {
            if (!this._mediaPlayer) 
            {
                return;
            }
            this._mediaPlayer.seek(this._value);
            return;
        }

        protected function seekSlider_endInteractionHandler(arg1:starling.events.Event):void
        {
            this.updateValueFromMediaPlayerCurrentTime();
            return;
        }

        protected function mediaPlayer_currentTimeChangeHandler(arg1:starling.events.Event):void
        {
            this.updateValueFromMediaPlayerCurrentTime();
            return;
        }

        protected function mediaPlayer_totalTimeChangeHandler(arg1:starling.events.Event):void
        {
            this.maximum = this._mediaPlayer.totalTime;
            return;
        }

        protected function mediaPlayer_loadProgressHandler(arg1:starling.events.Event, arg2:Number):void
        {
            if (this._progress === arg2) 
            {
                return;
            }
            this._progress = arg2;
            this.invalidate(INVALIDATION_FLAG_DATA);
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

        public static const DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK:String="feathers-seek-slider-minimum-track";

        public static const DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK:String="feathers-seek-slider-maximum-track";

        public static const DEFAULT_CHILD_STYLE_NAME_THUMB:String="feathers-seek-slider-thumb";

        protected var _mediaPlayer:feathers.media.ITimedMediaPlayer;

        protected var _progress:Number=0;

        protected var _progressSkin:starling.display.DisplayObject;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


