//package media
//  class BaseMediaPlayer
package feathers.media 
{
    import feathers.controls.*;
    import feathers.layout.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.events.*;
    
    public class BaseMediaPlayer extends feathers.controls.LayoutGroup implements feathers.media.IMediaPlayer
    {
        public function BaseMediaPlayer()
        {
            super();
            if (Object(this).constructor === feathers.media.BaseMediaPlayer) 
            {
                throw new starling.errors.AbstractClassError();
            }
            this.addEventListener(starling.events.Event.ADDED, this.mediaPlayer_addedHandler);
            this.addEventListener(starling.events.Event.REMOVED, this.mediaPlayer_removedHandler);
            return;
        }

        protected override function initialize():void
        {
            if (this._layout === null) 
            {
                this._layout = new feathers.layout.AnchorLayout();
            }
            super.initialize();
            return;
        }

        protected function handleAddedChild(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (arg1 is feathers.media.IMediaPlayerControl) 
            {
                feathers.media.IMediaPlayerControl(arg1).mediaPlayer = this;
            }
            if (arg1 is starling.display.DisplayObjectContainer) 
            {
                loc1 = starling.display.DisplayObjectContainer(arg1);
                loc2 = loc1.numChildren;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    arg1 = loc1.getChildAt(loc3);
                    this.handleAddedChild(arg1);
                    ++loc3;
                }
            }
            return;
        }

        protected function handleRemovedChild(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (arg1 is feathers.media.IMediaPlayerControl) 
            {
                feathers.media.IMediaPlayerControl(arg1).mediaPlayer = null;
            }
            if (arg1 is starling.display.DisplayObjectContainer) 
            {
                loc1 = starling.display.DisplayObjectContainer(arg1);
                loc2 = loc1.numChildren;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    arg1 = loc1.getChildAt(loc3);
                    this.handleRemovedChild(arg1);
                    ++loc3;
                }
            }
            return;
        }

        protected function mediaPlayer_addedHandler(arg1:starling.events.Event):void
        {
            var loc1:*=starling.display.DisplayObject(arg1.target);
            this.handleAddedChild(loc1);
            return;
        }

        protected function mediaPlayer_removedHandler(arg1:starling.events.Event):void
        {
            var loc1:*=starling.display.DisplayObject(arg1.target);
            this.handleRemovedChild(loc1);
            return;
        }
    }
}


//  class BaseTimedMediaPlayer
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


//  class FullScreenToggleButton
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


//  class IAudioPlayer
package feathers.media 
{
    import flash.media.*;
    
    public interface IAudioPlayer extends feathers.media.ITimedMediaPlayer
    {
        function get soundTransform():flash.media.SoundTransform;

        function set soundTransform(arg1:flash.media.SoundTransform):void;
    }
}


//  class IMediaPlayer
package feathers.media 
{
    import feathers.core.*;
    
    public interface IMediaPlayer extends feathers.core.IFeathersEventDispatcher
    {
    }
}


//  class IMediaPlayerControl
package feathers.media 
{
    public interface IMediaPlayerControl
    {
        function get mediaPlayer():feathers.media.IMediaPlayer;

        function set mediaPlayer(arg1:feathers.media.IMediaPlayer):void;
    }
}


//  class IProgressiveMediaPlayer
package feathers.media 
{
    public interface IProgressiveMediaPlayer extends feathers.media.IMediaPlayer
    {
        function get bytesLoaded():uint;

        function get bytesTotal():uint;
    }
}


//  class ITimedMediaPlayer
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


//  class IVideoPlayer
package feathers.media 
{
    public interface IVideoPlayer extends feathers.media.IAudioPlayer
    {
        function get nativeWidth():Number;

        function get nativeHeight():Number;
    }
}


//  class MuteToggleButton
package feathers.media 
{
    import feathers.controls.*;
    import feathers.controls.popups.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import flash.media.*;
    import starling.events.*;
    
    public class MuteToggleButton extends feathers.controls.ToggleButton implements feathers.media.IMediaPlayerControl
    {
        public function MuteToggleButton()
        {
            super();
            this.addEventListener(starling.events.Event.CHANGE, this.muteToggleButton_changeHandler);
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.muteToggleButton_touchHandler);
            return;
        }

        protected function createVolumeSlider():void
        {
            if (this.slider) 
            {
                this.slider.removeFromParent(false);
                this.slider.dispose();
                this.slider = null;
            }
            if (!this._showVolumeSliderOnHover) 
            {
                return;
            }
            var loc1:*=this._volumeSliderFactory == null ? defaultVolumeSliderFactory : this._volumeSliderFactory;
            var loc2:*=this._customVolumeSliderStyleName == null ? this.volumeSliderStyleName : this._customVolumeSliderStyleName;
            this.slider = feathers.media.VolumeSlider(loc1());
            this.slider.focusOwner = this;
            this.slider.styleNameList.add(loc2);
            return;
        }

        protected function refreshVolumeSliderProperties():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._volumeSliderProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._volumeSliderProperties[loc1];
                this.slider[loc1] = loc2;
            }
            this.slider.mediaPlayer = this._mediaPlayer;
            return;
        }

        protected function handlePendingActions():void
        {
            if (this._isOpenPopUpPending) 
            {
                this.openPopUp();
            }
            if (this._isClosePopUpPending) 
            {
                this.closePopUp();
            }
            return;
        }

        protected function refreshVolumeFromMediaPlayer():void
        {
            var loc1:*=this._ignoreChanges;
            this._ignoreChanges = true;
            if (this._mediaPlayer) 
            {
                this.isSelected = this._mediaPlayer.soundTransform.volume == 0;
            }
            else 
            {
                this.isSelected = false;
            }
            this._ignoreChanges = loc1;
            return;
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

        protected function mediaPlayer_soundTransformChangeHandler(arg1:starling.events.Event):void
        {
            this.refreshVolumeFromMediaPlayer();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return MuteToggleButton.globalStyleProvider;
        }

        protected function muteToggleButton_changeHandler(arg1:starling.events.Event):void
        {
            var loc2:*=NaN;
            if (this._ignoreChanges || !this._mediaPlayer) 
            {
                return;
            }
            var loc1:*=this._mediaPlayer.soundTransform;
            if (this._isSelected) 
            {
                this._oldVolume = loc1.volume;
                if (this._oldVolume === 0) 
                {
                    this._oldVolume = 1;
                }
                loc1.volume = 0;
                this._mediaPlayer.soundTransform = loc1;
            }
            else 
            {
                loc2 = this._oldVolume;
                if (loc2 !== loc2) 
                {
                    loc2 = 1;
                }
                loc1.volume = loc2;
                this._mediaPlayer.soundTransform = loc1;
            }
            return;
        }

        public function get mediaPlayer():feathers.media.IMediaPlayer
        {
            return this._mediaPlayer;
        }

        protected function muteToggleButton_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this.slider) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, null, this._touchPointID);
                if (loc1) 
                {
                    return;
                }
                this._touchPointID = -1;
                loc1 = arg1.getTouch(this.slider);
                if (this._popUpTouchPointID < 0 && !loc1) 
                {
                    this.closePopUp();
                }
            }
            else 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.HOVER);
                if (!loc1) 
                {
                    return;
                }
                this._touchPointID = loc1.id;
                this.openPopUp();
            }
            return;
        }

        protected function volumeSlider_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (this._popUpTouchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this.slider, null, this._popUpTouchPointID);
                if (loc1) 
                {
                    return;
                }
                this._popUpTouchPointID = -1;
                loc1 = arg1.getTouch(this);
                if (this._touchPointID < 0 && !loc1) 
                {
                    this.closePopUp();
                }
            }
            else 
            {
                loc1 = arg1.getTouch(this.slider, starling.events.TouchPhase.HOVER);
                if (!loc1) 
                {
                    return;
                }
                this._popUpTouchPointID = loc1.id;
            }
            return;
        }

        public function get popUpContentManager():feathers.controls.popups.IPopUpContentManager
        {
            return this._popUpContentManager;
        }

        public function set popUpContentManager(arg1:feathers.controls.popups.IPopUpContentManager):void
        {
            var loc1:*=null;
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._popUpContentManager === arg1) 
            {
                return;
            }
            if (this._popUpContentManager is starling.events.EventDispatcher) 
            {
                loc1 = starling.events.EventDispatcher(this._popUpContentManager);
                loc1.removeEventListener(starling.events.Event.OPEN, this.popUpContentManager_openHandler);
                loc1.removeEventListener(starling.events.Event.CLOSE, this.popUpContentManager_closeHandler);
            }
            this._popUpContentManager = arg1;
            if (this._popUpContentManager is starling.events.EventDispatcher) 
            {
                loc1 = starling.events.EventDispatcher(this._popUpContentManager);
                loc1.addEventListener(starling.events.Event.OPEN, this.popUpContentManager_openHandler);
                loc1.addEventListener(starling.events.Event.CLOSE, this.popUpContentManager_closeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function popUpContentManager_openHandler(arg1:starling.events.Event):void
        {
            this.dispatchEventWith(starling.events.Event.OPEN);
            return;
        }

        public function get showVolumeSliderOnHover():Boolean
        {
            return this._showVolumeSliderOnHover;
        }

        public function set showVolumeSliderOnHover(arg1:Boolean):void
        {
            if (this._showVolumeSliderOnHover == arg1) 
            {
                return;
            }
            this._showVolumeSliderOnHover = arg1;
            this.invalidate(INVALIDATION_FLAG_VOLUME_SLIDER_FACTORY);
            return;
        }

        protected function popUpContentManager_closeHandler(arg1:starling.events.Event):void
        {
            this.slider.removeEventListener(starling.events.TouchEvent.TOUCH, this.volumeSlider_touchHandler);
            this.dispatchEventWith(starling.events.Event.CLOSE);
            return;
        }

        public function get volumeSliderFactory():Function
        {
            return this._volumeSliderFactory;
        }

        public function set volumeSliderFactory(arg1:Function):void
        {
            if (this._volumeSliderFactory == arg1) 
            {
                return;
            }
            this._volumeSliderFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_VOLUME_SLIDER_FACTORY);
            return;
        }

        protected static function defaultVolumeSliderFactory():feathers.media.VolumeSlider
        {
            var loc1:*=new feathers.media.VolumeSlider();
            loc1.direction = feathers.layout.Direction.VERTICAL;
            return loc1;
        }

        public function get customVolumeSliderStyleName():String
        {
            return this._customVolumeSliderStyleName;
        }

        public function set customVolumeSliderStyleName(arg1:String):void
        {
            if (this._customVolumeSliderStyleName == arg1) 
            {
                return;
            }
            this._customVolumeSliderStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_VOLUME_SLIDER_FACTORY);
            return;
        }

        public function openPopUp():void
        {
            this._isClosePopUpPending = false;
            if (this._popUpContentManager.isOpen) 
            {
                return;
            }
            if (!this._isValidating && this.isInvalid()) 
            {
                this._isOpenPopUpPending = true;
                return;
            }
            this._isOpenPopUpPending = false;
            this._popUpContentManager.open(this.slider, this);
            this.slider.validate();
            this._popUpTouchPointID = -1;
            this.slider.addEventListener(starling.events.TouchEvent.TOUCH, this.volumeSlider_touchHandler);
            return;
        }

        public function get volumeSliderProperties():Object
        {
            if (!this._volumeSliderProperties) 
            {
                this._volumeSliderProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._volumeSliderProperties;
        }

        public function set volumeSliderProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._volumeSliderProperties == arg1) 
            {
                return;
            }
            if (!arg1) 
            {
                arg1 = new feathers.core.PropertyProxy();
            }
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                loc1 = new feathers.core.PropertyProxy();
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                {
                    loc1[loc2] = arg1[loc2];
                }
                arg1 = loc1;
            }
            if (this._volumeSliderProperties) 
            {
                this._volumeSliderProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._volumeSliderProperties = feathers.core.PropertyProxy(arg1);
            if (this._volumeSliderProperties) 
            {
                this._volumeSliderProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function closePopUp():void
        {
            this._isOpenPopUpPending = false;
            if (!this._popUpContentManager.isOpen) 
            {
                return;
            }
            if (!this._isValidating && this.isInvalid()) 
            {
                this._isClosePopUpPending = true;
                return;
            }
            this._isClosePopUpPending = false;
            this.slider.validate();
            this._popUpContentManager.close();
            return;
        }

        public override function dispose():void
        {
            if (this.slider) 
            {
                this.closePopUp();
                this.slider.mediaPlayer = null;
                this.slider.dispose();
                this.slider = null;
            }
            if (this._popUpContentManager) 
            {
                this._popUpContentManager.dispose();
                this._popUpContentManager = null;
            }
            super.dispose();
            return;
        }

        protected override function initialize():void
        {
            var loc1:*=null;
            if (this._popUpContentManager === null) 
            {
                loc1 = new feathers.controls.popups.DropDownPopUpContentManager();
                loc1.fitContentMinWidthToOrigin = false;
                loc1.primaryDirection = feathers.controls.popups.DropDownPopUpContentManager.PRIMARY_DIRECTION_UP;
                this._popUpContentManager = loc1;
            }
            super.initialize();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_VOLUME_SLIDER_FACTORY);
            if (loc2) 
            {
                this.createVolumeSlider();
            }
            if (this.slider && (loc2 || loc1)) 
            {
                this.refreshVolumeSliderProperties();
            }
            super.draw();
            this.handlePendingActions();
            return;
        }

        protected static const INVALIDATION_FLAG_VOLUME_SLIDER_FACTORY:String="volumeSliderFactory";

        public static const DEFAULT_CHILD_STYLE_NAME_VOLUME_SLIDER:String="feathers-volume-toggle-button-volume-slider";

        protected var volumeSliderStyleName:String="feathers-volume-toggle-button-volume-slider";

        protected var slider:feathers.media.VolumeSlider;

        protected var _oldVolume:Number;

        protected var _ignoreChanges:Boolean=false;

        protected var _popUpTouchPointID:int=-1;

        protected var _mediaPlayer:feathers.media.IAudioPlayer;

        protected var _touchPointID:int=-1;

        protected var _popUpContentManager:feathers.controls.popups.IPopUpContentManager;

        protected var _showVolumeSliderOnHover:Boolean=false;

        protected var _volumeSliderFactory:Function;

        protected var _customVolumeSliderStyleName:String;

        protected var _isOpenPopUpPending:Boolean=false;

        protected var _isClosePopUpPending:Boolean=false;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _volumeSliderProperties:feathers.core.PropertyProxy;
    }
}


//  class PlayPauseToggleButton
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


//  class SeekSlider
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


//  class VideoPlayer
package feathers.media 
{
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.display.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.textures.*;
    
    public class VideoPlayer extends feathers.media.BaseTimedMediaPlayer implements feathers.media.IVideoPlayer, feathers.media.IProgressiveMediaPlayer
    {
        public function VideoPlayer()
        {
            this._netConnectionFactory = defaultNetConnectionFactory;
            super();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.media.VideoPlayer.globalStyleProvider;
        }

        protected function disposeNetConnection():void
        {
            if (this._netConnection === null) 
            {
                return;
            }
            this._netConnection.removeEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netConnection_netStatusHandler);
            this._netConnection.close();
            this._netConnection = null;
            return;
        }

        protected function disposeNetStream():void
        {
            if (this._netStream === null) 
            {
                return;
            }
            this._netStream.removeEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netStream_netStatusHandler);
            this._netStream.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.netStream_ioErrorHandler);
            this._netStream.close();
            this._netStream = null;
            return;
        }

        protected function videoPlayer_enterFrameHandler(arg1:starling.events.Event):void
        {
            this._currentTime = this._netStream.time;
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.CURRENT_TIME_CHANGE);
            return;
        }

        public function get soundTransform():flash.media.SoundTransform
        {
            if (!this._soundTransform) 
            {
                this._soundTransform = new flash.media.SoundTransform();
            }
            return this._soundTransform;
        }

        public function set soundTransform(arg1:flash.media.SoundTransform):void
        {
            this._soundTransform = arg1;
            if (this._netStream) 
            {
                this._netStream.soundTransform = this._soundTransform;
            }
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.SOUND_TRANSFORM_CHANGE);
            return;
        }

        protected function videoPlayer_progress_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc2:*=false;
            var loc3:*=NaN;
            var loc1:*=this._netStream.bytesTotal;
            if (loc1 > 0) 
            {
                loc2 = false;
                loc3 = this._netStream.bytesLoaded;
                if (this._bytesTotal !== loc1) 
                {
                    this._bytesTotal = loc1;
                    loc2 = true;
                }
                if (this._bytesLoaded !== loc3) 
                {
                    this._bytesLoaded = loc3;
                    loc2 = true;
                }
                if (loc2) 
                {
                    this.dispatchEventWith(feathers.events.MediaPlayerEventType.LOAD_PROGRESS, false, loc3 / loc1);
                }
                if (loc3 === loc1) 
                {
                    this.removeEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_progress_enterFrameHandler);
                }
            }
            return;
        }

        protected function videoTexture_onRestore():void
        {
            this.pauseMedia();
            this._isWaitingForTextureReady = true;
            this._texture.root.attachNetStream(this._netStream, this.videoTexture_onComplete);
            this._netStream.play(this._videoSource);
            return;
        }

        public function get texture():starling.textures.Texture
        {
            if (this._isWaitingForTextureReady) 
            {
                return null;
            }
            return this._texture;
        }

        public function get nativeWidth():Number
        {
            if (this._texture) 
            {
                return this._texture.nativeWidth;
            }
            return 0;
        }

        public function get nativeHeight():Number
        {
            if (this._texture) 
            {
                return this._texture.nativeHeight;
            }
            return 0;
        }

        protected function videoTexture_onComplete():void
        {
            this._isWaitingForTextureReady = false;
            this.dispatchEventWith(starling.events.Event.READY);
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            var loc1:*=this._netStream.bytesTotal;
            if (this._bytesTotal === 0 && loc1 > 0) 
            {
                this._bytesLoaded = this._netStream.bytesLoaded;
                this._bytesTotal = loc1;
                this.dispatchEventWith(feathers.events.MediaPlayerEventType.LOAD_PROGRESS, false, this._bytesLoaded / loc1);
                if (this._bytesLoaded !== this._bytesTotal) 
                {
                    this.addEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_progress_enterFrameHandler);
                }
            }
            return;
        }

        protected function netConnection_netStatusHandler(arg1:flash.events.NetStatusEvent):void
        {
            var loc1:*=arg1.info.code;
            var loc2:*=loc1;
            switch (loc2) 
            {
                case NET_STATUS_CODE_NETCONNECTION_CONNECT_SUCCESS:
                {
                    this.playMedia();
                    break;
                }
            }
            return;
        }

        public function get netStream():flash.net.NetStream
        {
            return this._netStream;
        }

        protected function netStream_onMetaData(arg1:Object):void
        {
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.DIMENSIONS_CHANGE);
            this._totalTime = arg1.duration;
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.TOTAL_TIME_CHANGE);
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.METADATA_RECEIVED, false, arg1);
            return;
        }

        protected function netStream_onCuePoint(arg1:Object):void
        {
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.CUE_POINT, false, arg1);
            return;
        }

        public function get videoSource():String
        {
            return this._videoSource;
        }

        public function set videoSource(arg1:String):void
        {
            if (this._videoSource === arg1) 
            {
                return;
            }
            if (this._isPlaying) 
            {
                this.stop();
            }
            this.disposeNetStream();
            if (!arg1) 
            {
                this.disposeNetConnection();
            }
            if (this._texture !== null) 
            {
                this._texture.dispose();
                this._texture = null;
                this.dispatchEventWith(feathers.events.FeathersEventType.CLEAR);
            }
            this._videoSource = arg1;
            if (this._currentTime !== 0) 
            {
                this._currentTime = 0;
                this.dispatchEventWith(feathers.events.MediaPlayerEventType.CURRENT_TIME_CHANGE);
            }
            if (this._totalTime !== 0) 
            {
                this._totalTime = 0;
                this.dispatchEventWith(feathers.events.MediaPlayerEventType.TOTAL_TIME_CHANGE);
            }
            this._bytesLoaded = 0;
            this._bytesTotal = 0;
            if (this._autoPlay && this._videoSource) 
            {
                this.play();
            }
            return;
        }

        protected function netStream_onXMPData(arg1:Object):void
        {
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.XMP_DATA, false, arg1);
            return;
        }

        public function get autoPlay():Boolean
        {
            return this._autoPlay;
        }

        public function set autoPlay(arg1:Boolean):void
        {
            this._autoPlay = arg1;
            return;
        }

        protected function netStream_ioErrorHandler(arg1:flash.events.IOErrorEvent):void
        {
            this.dispatchEventWith(arg1.type, false, arg1);
            return;
        }

        public function get isFullScreen():Boolean
        {
            return this._isFullScreen;
        }

        protected function netStream_netStatusHandler(arg1:flash.events.NetStatusEvent):void
        {
            var loc1:*=arg1.info.code;
            var loc2:*=loc1;
            switch (loc2) 
            {
                case NET_STATUS_CODE_NETSTREAM_PLAY_STREAMNOTFOUND:
                {
                    this.dispatchEventWith(feathers.events.FeathersEventType.ERROR, false, loc1);
                    break;
                }
                case NET_STATUS_CODE_NETSTREAM_PLAY_NOSUPPORTEDTRACKFOUND:
                {
                    this.dispatchEventWith(feathers.events.FeathersEventType.ERROR, false, loc1);
                    break;
                }
                case NET_STATUS_CODE_NETSTREAM_PLAY_START:
                {
                    if (this._netStream.time !== this._currentTime) 
                    {
                        this._netStream.seek(this._currentTime);
                    }
                    if (this._isPlaying) 
                    {
                        this.addEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_enterFrameHandler);
                    }
                    else 
                    {
                        this.pauseMedia();
                    }
                    break;
                }
                case NET_STATUS_CODE_NETSTREAM_PLAY_STOP:
                {
                    if (this._hasPlayedToEnd) 
                    {
                        return;
                    }
                    this.removeEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_enterFrameHandler);
                    if (starling.core.Starling.context.driverInfo !== "Disposed") 
                    {
                        this.stop();
                        this._hasPlayedToEnd = true;
                        this.dispatchEventWith(starling.events.Event.COMPLETE);
                    }
                    break;
                }
            }
            return;
        }

        public function get normalDisplayState():String
        {
            return this._normalDisplayState;
        }

        public function set normalDisplayState(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._normalDisplayState == arg1) 
            {
                return;
            }
            this._normalDisplayState = arg1;
            if (!this._isFullScreen && this.stage) 
            {
                loc1 = feathers.utils.display.stageToStarling(this.stage);
                loc2 = loc1.nativeStage;
                loc2.displayState = this._normalDisplayState;
            }
            return;
        }

        protected override function playMedia():void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (!this._videoSource) 
            {
                throw new flash.errors.IllegalOperationError(NO_VIDEO_SOURCE_PLAY_ERROR);
            }
            if (this._netConnection === null) 
            {
                loc2 = this._netConnectionFactory === null ? defaultNetConnectionFactory : this._netConnectionFactory;
                this._netConnection = flash.net.NetConnection(loc2());
            }
            if (this._netStream === null) 
            {
                if (!this._netConnection.connected) 
                {
                    this._netConnection.addEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netConnection_netStatusHandler);
                    return;
                }
                this._netStream = new flash.net.NetStream(this._netConnection);
                this._netStream.client = new VideoPlayerNetStreamClient(this.netStream_onMetaData, this.netStream_onCuePoint, this.netStream_onXMPData);
                this._netStream.addEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netStream_netStatusHandler);
                this._netStream.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.netStream_ioErrorHandler);
            }
            if (this._soundTransform === null) 
            {
                this._soundTransform = new flash.media.SoundTransform();
            }
            this._netStream.soundTransform = this._soundTransform;
            var loc1:*=this.videoTexture_onComplete;
            if (this._texture === null) 
            {
                this._isWaitingForTextureReady = true;
                loc3 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                this._texture = starling.textures.Texture.fromNetStream(this._netStream, loc3.contentScaleFactor, loc1);
                this._texture.root.onRestore = this.videoTexture_onRestore;
                this._netStream.play(this._videoSource);
            }
            else if (this._hasPlayedToEnd) 
            {
                this._netStream.play(this._videoSource);
            }
            else 
            {
                this.addEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_enterFrameHandler);
                this._netStream.resume();
            }
            this._hasPlayedToEnd = false;
            return;
        }

        public function get fullScreenDisplayState():String
        {
            return this._fullScreenDisplayState;
        }

        public function set fullScreenDisplayState(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._fullScreenDisplayState == arg1) 
            {
                return;
            }
            this._fullScreenDisplayState = arg1;
            if (this._isFullScreen && this.stage) 
            {
                loc1 = feathers.utils.display.stageToStarling(this.stage);
                loc2 = loc1.nativeStage;
                loc2.displayState = this._fullScreenDisplayState;
            }
            return;
        }

        protected override function mediaPlayer_addedHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreDisplayListEvents) 
            {
                return;
            }
            super.mediaPlayer_addedHandler(arg1);
            return;
        }

        public function get hideRootWhenFullScreen():Boolean
        {
            return this._hideRootWhenFullScreen;
        }

        public function set hideRootWhenFullScreen(arg1:Boolean):void
        {
            this._hideRootWhenFullScreen = arg1;
            return;
        }

        protected override function mediaPlayer_removedHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreDisplayListEvents) 
            {
                return;
            }
            super.mediaPlayer_removedHandler(arg1);
            return;
        }

        public function get netConnectionFactory():Function
        {
            return this._netConnectionFactory;
        }

        public function set netConnectionFactory(arg1:Function):void
        {
            if (this._netConnectionFactory === arg1) 
            {
                return;
            }
            this._netConnectionFactory = arg1;
            this.stop();
            this.disposeNetStream();
            this.disposeNetConnection();
            return;
        }

        protected static function defaultNetConnectionFactory():flash.net.NetConnection
        {
            var loc1:*=new flash.net.NetConnection();
            loc1.connect(null);
            return loc1;
        }

        public function get bytesLoaded():uint
        {
            return this._bytesLoaded;
        }

        public function get bytesTotal():uint
        {
            return this._bytesTotal;
        }

        public override function dispose():void
        {
            this.videoSource = null;
            super.dispose();
            return;
        }

        public override function play():void
        {
            if (this._videoSource === null) 
            {
                return;
            }
            super.play();
            return;
        }

        public override function stop():void
        {
            if (this._videoSource === null) 
            {
                return;
            }
            super.stop();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (this._isFullScreen) 
            {
                return;
            }
            super.render(arg1);
            return;
        }

        public function toggleFullScreen():void
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            if (!this.stage) 
            {
                throw new flash.errors.IllegalOperationError("Cannot enter full screen mode if the video player does not have access to the Starling stage.");
            }
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            var loc2:*=loc1.nativeStage;
            var loc3:*=this._ignoreDisplayListEvents;
            this._ignoreDisplayListEvents = true;
            if (this._isFullScreen) 
            {
                this.root.visible = true;
                feathers.core.PopUpManager.removePopUp(this._fullScreenContainer, false);
                loc4 = this._fullScreenContainer.numChildren;
                loc5 = 0;
                while (loc5 < loc4) 
                {
                    loc6 = this._fullScreenContainer.getChildAt(0);
                    this.addChild(loc6);
                    ++loc5;
                }
                loc2.displayState = this._normalDisplayState;
            }
            else 
            {
                if (this._hideRootWhenFullScreen) 
                {
                    this.root.visible = false;
                }
                loc2.displayState = this._fullScreenDisplayState;
                if (!this._fullScreenContainer) 
                {
                    this._fullScreenContainer = new feathers.controls.LayoutGroup();
                    this._fullScreenContainer.autoSizeMode = feathers.controls.AutoSizeMode.STAGE;
                }
                this._fullScreenContainer.layout = this._layout;
                loc4 = this.numChildren;
                loc5 = 0;
                while (loc5 < loc4) 
                {
                    loc6 = this.getChildAt(0);
                    this._fullScreenContainer.addChild(loc6);
                    ++loc5;
                }
                feathers.core.PopUpManager.addPopUp(this._fullScreenContainer, true, false);
            }
            this._ignoreDisplayListEvents = loc3;
            this._isFullScreen = !this._isFullScreen;
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.DISPLAY_STATE_CHANGE);
            return;
        }

        protected override function pauseMedia():void
        {
            if (!this._videoSource) 
            {
                throw new flash.errors.IllegalOperationError(NO_VIDEO_SOURCE_PAUSE_ERROR);
            }
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_enterFrameHandler);
            this._netStream.pause();
            return;
        }

        protected override function seekMedia(arg1:Number):void
        {
            if (!this._videoSource) 
            {
                throw new flash.errors.IllegalOperationError(NO_VIDEO_SOURCE_SEEK_ERROR);
            }
            this._currentTime = arg1;
            if (this._hasPlayedToEnd) 
            {
                this.playMedia();
                return;
            }
            this._netStream.seek(arg1);
            return;
        }

        protected static const NET_STATUS_CODE_NETSTREAM_PLAY_START:String="NetStream.Play.Start";

        protected static const NET_STATUS_CODE_NETSTREAM_PLAY_STOP:String="NetStream.Play.Stop";

        protected static const NET_STATUS_CODE_NETSTREAM_PLAY_STREAMNOTFOUND:String="NetStream.Play.StreamNotFound";

        protected static const NET_STATUS_CODE_NETSTREAM_PLAY_NOSUPPORTEDTRACKFOUND:String="NetStream.Play.NoSupportedTrackFound";

        protected static const NO_VIDEO_SOURCE_PLAY_ERROR:String="Cannot play media when videoSource property has not been set.";

        protected static const NO_VIDEO_SOURCE_PAUSE_ERROR:String="Cannot pause media when videoSource property has not been set.";

        protected static const NO_VIDEO_SOURCE_SEEK_ERROR:String="Cannot seek media when videoSource property has not been set.";

        protected static const NET_STATUS_CODE_NETCONNECTION_CONNECT_SUCCESS:String="NetConnection.Connect.Success";

        protected var _fullScreenContainer:feathers.controls.LayoutGroup;

        protected var _ignoreDisplayListEvents:Boolean=false;

        protected var _soundTransform:flash.media.SoundTransform;

        protected var _isWaitingForTextureReady:Boolean=false;

        protected var _texture:starling.textures.Texture;

        protected var _netConnection:flash.net.NetConnection;

        protected var _netStream:flash.net.NetStream;

        protected var _hasPlayedToEnd:Boolean=false;

        protected var _videoSource:String;

        protected var _autoPlay:Boolean=true;

        protected var _isFullScreen:Boolean=false;

        protected var _normalDisplayState:String="normal";

        protected var _hideRootWhenFullScreen:Boolean=true;

        protected var _netConnectionFactory:Function;

        protected var _bytesTotal:uint=0;

        protected var _bytesLoaded:uint=0;

        protected var _fullScreenDisplayState:String="fullScreenInteractive";

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


dynamic class VideoPlayerNetStreamClient extends Object
{
    public function VideoPlayerNetStreamClient(arg1:Function, arg2:Function, arg3:Function)
    {
        super();
        this.onMetaDataCallback = arg1;
        this.onCuePointCallback = arg2;
        this.onXMPDataCallback = arg3;
        return;
    }

    public function onMetaData(arg1:Object):void
    {
        this.onMetaDataCallback(arg1);
        return;
    }

    public function onCuePoint(arg1:Object):void
    {
        this.onCuePointCallback(arg1);
        return;
    }

    public function onXMPData(arg1:Object):void
    {
        this.onXMPDataCallback(arg1);
        return;
    }

    public var onMetaDataCallback:Function;

    public var onCuePointCallback:Function;
}

//  class VolumeSlider
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


