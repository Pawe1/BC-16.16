//class MuteToggleButton
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


