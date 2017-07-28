//package component
//  package devices
//    class CommunicationState
package frontend.screen.component.devices 
{
    import core.general.*;
    import core.units.*;
    import core.units.interfaces.*;
    import de.pagecon.ane.nfc.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.menuList.editors.custom.*;
    import frontend.components.popup.*;
    import frontend.screen.mydevices.list.*;
    import handler.*;
    import handler.event.*;
    import mx.core.*;
    import service.*;
    import service.nfc.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class CommunicationState extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function CommunicationState()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._headline = utils.LanguageManager.getString("ACTIVITIESIMPORT.CONNECTDEVICEHEADLINE");
            this._1332942920videoText = utils.LanguageManager.getString("ADDDEVICE.VIDEOTEXT");
            this._268453978_infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.PLEASE_SELECT_DEVICE");
            this._loadingAtlas = frontend.AssetsManagerCustom.getInstance().getTextureAtlas("loaderAnimation");
            this._213927506_spacerHeight = 17 * SIGMALink.scaleFactor;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._CommunicationState_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_component_devices_CommunicationStateWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.component.devices.CommunicationState[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._CommunicationState_MenuListHeadline1_i(), this._CommunicationState_LayoutGroup2_i(), this._CommunicationState_LayoutGroup6_i()];
            this.addEventListener("addedToStage", this.___CommunicationState_LayoutGroup1_addedToStage);
            this.addEventListener("removedFromStage", this.___CommunicationState_LayoutGroup1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set connectPicture(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._376471732connectPicture;
            if (loc1 !== arg1) 
            {
                this._376471732connectPicture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "connectPicture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get movie():feathers.controls.LayoutGroup
        {
            return this._104087344movie;
        }

        public function set movie(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._104087344movie;
            if (loc1 !== arg1) 
            {
                this._104087344movie = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "movie", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get row1():frontend.components.menuList.MenuListHeadline
        {
            return this._3506583row1;
        }

        public function set row1(arg1:frontend.components.menuList.MenuListHeadline):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3506583row1;
            if (loc1 !== arg1) 
            {
                this._3506583row1 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "row1", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get row2():feathers.controls.LayoutGroup
        {
            return this._3506584row2;
        }

        public function set row2(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3506584row2;
            if (loc1 !== arg1) 
            {
                this._3506584row2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "row2", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get row3():feathers.controls.LayoutGroup
        {
            return this._3506585row3;
        }

        public function set row3(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3506585row3;
            if (loc1 !== arg1) 
            {
                this._3506585row3 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "row3", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set headline(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.headline;
            if (loc1 !== arg1) 
            {
                this._1115058732headline = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headline", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set loading(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.loading;
            if (loc1 !== arg1) 
            {
                this._336650556loading = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "loading", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set unitChangeable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.unitChangeable;
            if (loc1 !== arg1) 
            {
                this._1307373998unitChangeable = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitChangeable", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _useSmallLayout():Boolean
        {
            return this._478887639_useSmallLayout;
        }

        internal function set _useSmallLayout(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._478887639_useSmallLayout;
            if (loc1 !== arg1) 
            {
                this._478887639_useSmallLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_useSmallLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get videoText():String
        {
            return this._1332942920videoText;
        }

        public function set videoText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1332942920videoText;
            if (loc1 !== arg1) 
            {
                this._1332942920videoText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "videoText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _deviceName():String
        {
            return this._1869301664_deviceName;
        }

        internal function _CommunicationState_MenuListHeadline1_i():frontend.components.menuList.MenuListHeadline
        {
            var loc1:*=new frontend.components.menuList.MenuListHeadline();
            loc1.useLocalesForText = false;
            loc1.id = "row1";
            this.row1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "row1", this.row1);
            return loc1;
        }

        internal function set _deviceName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1869301664_deviceName;
            if (loc1 !== arg1) 
            {
                this._1869301664_deviceName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_deviceName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _deviceTexture():String
        {
            return this._975205350_deviceTexture;
        }

        internal function set _deviceTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._975205350_deviceTexture;
            if (loc1 !== arg1) 
            {
                this._975205350_deviceTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_deviceTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get headline():String
        {
            return this._headline;
        }

        internal function set _1115058732headline(arg1:String):void
        {
            this._headline = arg1;
            return;
        }

        public override function set height(arg1:Number):void
        {
            super.height = arg1;
            this.validateRowLayouts();
            return;
        }

        internal function get _howtoImageTextureName():String
        {
            return this._207045591_howtoImageTextureName;
        }

        public function get loading():Boolean
        {
            return this._loading;
        }

        internal function set _336650556loading(arg1:Boolean):void
        {
            this._loading = arg1;
            if (this.loading) 
            {
                if (this._loadingAtlas) 
                {
                    if (this._movieClip && this._movieClip.isPlaying) 
                    {
                        return;
                    }
                    this._movieClip = new starling.display.MovieClip(this._loadingAtlas.getTextures("frame_"), 30);
                    this.movie.addChild(this._movieClip);
                    this._movieClip.play();
                    if (!starling.core.Starling.juggler.contains(this._movieClip)) 
                    {
                        starling.core.Starling.juggler.add(this._movieClip);
                    }
                }
            }
            else 
            {
                if (!this._movieClip || !this._movieClip.isPlaying) 
                {
                    return;
                }
                if (this._movieClip) 
                {
                    this._movieClip.stop();
                    if (starling.core.Starling.juggler.contains(this._movieClip)) 
                    {
                        starling.core.Starling.juggler.remove(this._movieClip);
                    }
                }
                this.movie.removeChildren();
            }
            return;
        }

        internal function set _howtoImageTextureName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._207045591_howtoImageTextureName;
            if (loc1 !== arg1) 
            {
                this._207045591_howtoImageTextureName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_howtoImageTextureName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _infoStyleName():String
        {
            return this._358726863_infoStyleName;
        }

        internal function set _infoStyleName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._358726863_infoStyleName;
            if (loc1 !== arg1) 
            {
                this._358726863_infoStyleName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_infoStyleName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _infoText():String
        {
            return this._268453978_infoText;
        }

        public function get unitChangeable():Boolean
        {
            return this._unitChangeable;
        }

        internal function set _1307373998unitChangeable(arg1:Boolean):void
        {
            this._unitChangeable = arg1;
            return;
        }

        internal function set _infoText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._268453978_infoText;
            if (loc1 !== arg1) 
            {
                this._268453978_infoText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_infoText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set useSmallLayout(arg1:Boolean):void
        {
            this._useSmallLayout = arg1;
            this.validateRowLayouts();
            return;
        }

        internal function set _showConnectPicture(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._759566416_showConnectPicture;
            if (loc1 !== arg1) 
            {
                this._759566416_showConnectPicture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_showConnectPicture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _showEnableBLEButton():Boolean
        {
            return this._1699689810_showEnableBLEButton;
        }

        internal function set _showEnableBLEButton(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1699689810_showEnableBLEButton;
            if (loc1 !== arg1) 
            {
                this._1699689810_showEnableBLEButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_showEnableBLEButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _showEnableNFCButton():Boolean
        {
            return this._1261274370_showEnableNFCButton;
        }

        internal function set _showEnableNFCButton(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1261274370_showEnableNFCButton;
            if (loc1 !== arg1) 
            {
                this._1261274370_showEnableNFCButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_showEnableNFCButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _spacerHeight():uint
        {
            return this._213927506_spacerHeight;
        }

        internal function set _spacerHeight(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._213927506_spacerHeight;
            if (loc1 !== arg1) 
            {
                this._213927506_spacerHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_spacerHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.component.devices.CommunicationState._watcherSetupUtil = arg1;
            return;
        }

        internal static function get ICON_PADDING_LEFT():Number
        {
            return frontend.screen.component.devices.CommunicationState._810755685ICON_PADDING_LEFT;
        }

        internal static function set ICON_PADDING_LEFT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.screen.component.devices.CommunicationState._810755685ICON_PADDING_LEFT;
            if (loc1 !== arg1) 
            {
                frontend.screen.component.devices.CommunicationState._810755685ICON_PADDING_LEFT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ICON_PADDING_LEFT", loc1, arg1, frontend.screen.component.devices.CommunicationState);
                loc3 = frontend.screen.component.devices.CommunicationState.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static function get NAME_PADDING_LEFT():Number
        {
            return frontend.screen.component.devices.CommunicationState._78149431NAME_PADDING_LEFT;
        }

        internal static function set NAME_PADDING_LEFT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.screen.component.devices.CommunicationState._78149431NAME_PADDING_LEFT;
            if (loc1 !== arg1) 
            {
                frontend.screen.component.devices.CommunicationState._78149431NAME_PADDING_LEFT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "NAME_PADDING_LEFT", loc1, arg1, frontend.screen.component.devices.CommunicationState);
                loc3 = frontend.screen.component.devices.CommunicationState.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _810755685ICON_PADDING_LEFT = 15 * SIGMALink.scaleFactor;
            _78149431NAME_PADDING_LEFT = 120 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            flash.desktop.NativeApplication.nativeApplication.systemIdleMode = flash.desktop.SystemIdleMode.KEEP_AWAKE;
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            if (this._movieClip) 
            {
                this._movieClip.dispose();
            }
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.DeviceCommunicationHandler.EVENT_TRANSFER_START, this.onTransferStart);
            flash.desktop.NativeApplication.nativeApplication.systemIdleMode = flash.desktop.SystemIdleMode.NORMAL;
            return;
        }

        internal function validateRowLayouts():void
        {
            this.row1.layoutData = new feathers.layout.AnchorLayoutData(0, 0, NaN, 0);
            this.row2.layoutData = new feathers.layout.AnchorLayoutData(this._useSmallLayout ? 0 : frontend.components.menuList.MenuList.HEADLINE_HEIGHT, 0, frontend.components.menuList.MenuList.ROW_HEIGHT + 2 * this._spacerHeight, 0);
            this.row3.layoutData = new feathers.layout.AnchorLayoutData(NaN, 0, this._spacerHeight, 0);
            this.connectPicture.scale = this._useSmallLayout ? 0.7 : 1;
            return;
        }

        internal function onSelectDeviceClicked(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this._unitChangeable) 
            {
                this.openDeviceSelection();
            }
            return;
        }

        protected function onEnableBLEButtonHandler(arg1:starling.events.Event):void
        {
            flash.desktop.NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, this.onBLESettingChanged);
            service.DeviceCommunicationHandler.getInstance().askUserToEnableBLE();
            return;
        }

        internal function onBLESettingChanged(arg1:flash.events.Event):void
        {
            flash.desktop.NativeApplication.nativeApplication.removeEventListener(flash.events.Event.ACTIVATE, this.onBLESettingChanged);
            this.showUnitState(handler.CommunicationHandling.getInstance().currentDevice);
            handler.CommunicationHandling.getInstance().onBLESettingChangedByUser();
            return;
        }

        protected function onEnableNFCButtonHandler(arg1:starling.events.Event):void
        {
            flash.desktop.NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, this.onNFCSettingChanged);
            de.pagecon.ane.nfc.NfcController.instance.askForNfc();
            return;
        }

        internal function onNFCSettingChanged(arg1:flash.events.Event):void
        {
            flash.desktop.NativeApplication.nativeApplication.removeEventListener(flash.events.Event.ACTIVATE, this.onNFCSettingChanged);
            service.nfc.NFCHandler.getInstance().validateNFCStatus();
            this.showUnitState(handler.CommunicationHandling.getInstance().currentDevice);
            handler.CommunicationHandling.getInstance().onNFCSettingChangedByUser();
            return;
        }

        public function showUnitState(arg1:core.units.Unit):void
        {
            if (!arg1) 
            {
                return;
            }
            this._deviceTexture = frontend.Textures.getUnitTexture(arg1.type);
            this._deviceName = arg1.externalName;
            debug.Debug.debug("mode: " + handler.CommunicationHandling.getInstance().communicationMode);
            var loc1:*=handler.CommunicationHandling.getInstance().communicationMode;
            switch (loc1) 
            {
                case handler.CommunicationHandling.DEVICE_NFC_ONLY:
                {
                    if (service.DeviceCommunicationHandler.getInstance().isNFCEnabled()) 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NFC_ONLY");
                        this._infoStyleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                        this._showEnableNFCButton = false;
                    }
                    else 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NFC_ONLY_ACTIVATE_NFC");
                        this._infoStyleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_DASHBOARD_OPTION_TITLE;
                        this._showEnableNFCButton = true;
                    }
                    this._howtoImageTextureName = frontend.Textures.connectnfc;
                    this._showConnectPicture = true;
                    break;
                }
                case handler.CommunicationHandling.DEVICE_BLE_ONLY:
                {
                    if (service.DeviceCommunicationHandler.getInstance().isBLEEnabled()) 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_BLE_ONLY");
                        this._infoStyleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                        this._showEnableBLEButton = false;
                    }
                    else 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_BLE_ONLY_ACTIVATE_BLE");
                        this._infoStyleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_DASHBOARD_OPTION_TITLE;
                        this._showEnableBLEButton = true;
                    }
                    this._howtoImageTextureName = frontend.Textures.connectble;
                    this._showConnectPicture = true;
                    break;
                }
                case handler.CommunicationHandling.DEVICE_USB_ONLY:
                {
                    this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_USB_ONLY");
                    this._howtoImageTextureName = frontend.Textures.connectusb;
                    this._showConnectPicture = true;
                    break;
                }
                case handler.CommunicationHandling.DEVICE_DST_ONLY:
                {
                    this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_DST_ONLY");
                    this._howtoImageTextureName = frontend.Textures.connectds;
                    this._showConnectPicture = true;
                    break;
                }
                case handler.CommunicationHandling.DEVICE_USB_AND_BLE:
                {
                    if (service.DeviceCommunicationHandler.getInstance().isBLEEnabled()) 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_USB_AND_BLE");
                        this._showEnableBLEButton = false;
                    }
                    else 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_USB_AND_BLE_ACTIVATE_BLE");
                        this._showEnableBLEButton = true;
                    }
                    this._howtoImageTextureName = frontend.Textures.connectusbble;
                    this._showConnectPicture = true;
                    break;
                }
                case handler.CommunicationHandling.DEVICE_DST_AND_NFC:
                {
                    if (service.DeviceCommunicationHandler.getInstance().isNFCEnabled() || handler.CommunicationHandling.getInstance().ignoreUSB) 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_DST_AND_NFC");
                        this._showEnableNFCButton = false;
                    }
                    else 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_DST_AND_NFC_ACTIVATE_NFC");
                        this._showEnableNFCButton = true;
                    }
                    this._howtoImageTextureName = handler.CommunicationHandling.getInstance().ignoreUSB ? frontend.Textures.connectnfc : frontend.Textures.connectnfcds;
                    this._showConnectPicture = true;
                    break;
                }
                case handler.CommunicationHandling.DEVICE_USB_AND_NFC:
                {
                    if (service.DeviceCommunicationHandler.getInstance().isNFCEnabled() || handler.CommunicationHandling.getInstance().ignoreUSB) 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_USB_AND_NFC");
                        this._showEnableNFCButton = false;
                    }
                    else 
                    {
                        this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_USB_AND_NFC_ACTIVATE_NFC");
                        this._showEnableNFCButton = true;
                    }
                    this._howtoImageTextureName = handler.CommunicationHandling.getInstance().ignoreUSB ? frontend.Textures.connectnfc : frontend.Textures.connectnfcusb;
                    this._showConnectPicture = true;
                    break;
                }
                case handler.CommunicationHandling.DEVICE_UNKNOWN:
                {
                    this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_COMMUNICATION_TITLE") + "\n\n";
                    this._infoText = this._infoText + (utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_COMMUNICATION_DESCRIPTION") + "\n\n\n");
                    if (handler.CommunicationHandling.getInstance().currentDevice is core.units.interfaces.INFCDeviceInfo) 
                    {
                        this._infoText = this._infoText + ("\n" + utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_NFC"));
                    }
                    if (handler.CommunicationHandling.getInstance().currentDevice is core.units.interfaces.IBLEDeviceInfo) 
                    {
                        this._infoText = this._infoText + ("\n" + utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_BLE"));
                    }
                    if (handler.CommunicationHandling.getInstance().currentDevice is core.units.interfaces.IUSBDeviceInfo || handler.CommunicationHandling.getInstance().currentDevice is core.units.interfaces.IDSTDeviceInfo) 
                    {
                        this._infoText = this._infoText + ("\n" + utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_USB"));
                    }
                    this._infoStyleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_DASHBOARD_OPTION_TITLE;
                    this.loading = false;
                    this._showConnectPicture = false;
                    break;
                }
                case handler.CommunicationHandling.DEVICE_NOT_SUPPORTED:
                {
                    this._infoText = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_COMMUNICATION_TITLE") + "\n\n";
                    this._infoText = this._infoText + (utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NOT_SUPPORTED_DESCRIPTION") + "\n\n\n");
                    this._infoStyleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_DASHBOARD_OPTION_TITLE;
                    this.loading = false;
                    this._showConnectPicture = false;
                    break;
                }
            }
            return;
        }

        public function openDeviceSelection():void
        {
            var loc2:*=null;
            handler.CommunicationHandling.getInstance().stopCommunication();
            var loc1:*=new frontend.components.menuList.editors.custom.UnitEditor();
            loc1.dataProvider = handler.CommunicationHandling.getInstance().getCurrentDevicesDataProvider();
            loc1.showSaveButton = false;
            loc1.owner = new frontend.components.menuList.MenuListItem();
            loc1.saveCompleteCallback = this.onDeviceSelectionChanged;
            var loc3:*=0;
            var loc4:*=loc1.dataProvider.length;
            loc3 = 0;
            while (loc3 < loc4) 
            {
                loc2 = loc1.dataProvider.getItemAt(loc3) as frontend.screen.mydevices.list.MyDevicesListItem;
                if (loc2.unit == handler.CommunicationHandling.getInstance().currentDevice) 
                {
                    loc1.rawValue = loc2;
                    break;
                }
                ++loc3;
            }
            frontend.components.popup.PopUpBase.showModalPopUp(loc1, true, true);
            return;
        }

        internal function onDeviceSelectionChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            var loc1:*=null;
            if (!(arg2.rawValue == null) && !((arg2.rawValue as frontend.screen.mydevices.list.MyDevicesListItem).unit == handler.CommunicationHandling.getInstance().currentDevice)) 
            {
                loc1 = (arg2.rawValue as frontend.screen.mydevices.list.MyDevicesListItem).unit;
                handler.CommunicationHandling.getInstance().currentDevice = loc1;
            }
            return;
        }

        public function openProgressPopUp(arg1:String, arg2:String):void
        {
            this._progressPopUp = new frontend.components.popup.ProgressPopUp();
            this._progressPopUp.addEventListener(frontend.components.popup.ProgressPopUp.PROGRESS_COMPLETE, this.onProgressComplete);
            this._progressPopUp.title = arg1;
            this._progressPopUp.text = arg2;
            this._progressPopUp.imageTexture = frontend.Textures.linkIconWhite;
            handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(handler.event.ProgressStatusEvent.PROGRESS, this.onProgressStatusEvent);
            handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(service.DeviceCommunicationHandler.EVENT_TRANSFER_PROGRESS_AUTOMATIC, this.onAutoProgressStatusEvent);
            if (this.unitChangeable || service.DeviceCommunicationHandler.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_NFC) 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(service.DeviceCommunicationHandler.EVENT_TRANSFER_START, this.onTransferStart);
            }
            else 
            {
                this.updateNoResponseTimeout();
                frontend.components.popup.PopUpBase.showModalPopUp(this._progressPopUp);
            }
            return;
        }

        public function onCommunicationErrorCallback():void
        {
            this.closeProgressPopUp();
            return;
        }

        public function onCommunicationTimeoutCallback():void
        {
            this.closeProgressPopUp();
            return;
        }

        public function onDeviceNotMatchErrorCallback():void
        {
            this.closeProgressPopUp();
            return;
        }

        internal function onTransferStart(arg1:flash.events.Event):void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.DeviceCommunicationHandler.EVENT_TRANSFER_START, this.onTransferStart);
            if (this.unitChangeable || service.DeviceCommunicationHandler.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_NFC) 
            {
                this.updateNoResponseTimeout();
                frontend.components.popup.PopUpBase.showModalPopUp(this._progressPopUp);
            }
            return;
        }

        public function updateProgressPopUp(arg1:uint, arg2:String=null, arg3:String=null):void
        {
            if (!this._progressPopUp) 
            {
                debug.Debug.debug("kann nicht sein!!!");
                return;
            }
            debug.Debug.debug("updateProgressPopUp - " + arg1);
            if (arg2) 
            {
                this._progressPopUp.title = arg2;
            }
            if (arg3) 
            {
                this._progressPopUp.text = arg3;
            }
            this._progressPopUp.validatePopUpContent();
            this._progressPopUp.setProgressPercentage(arg1);
            this.updateNoResponseTimeout();
            return;
        }

        protected function onProgressComplete(arg1:starling.events.Event=null):void
        {
            debug.Debug.debug("onProgressComplete...");
            if (this.closeProgressOn100Percent) 
            {
                this.closePopupNow();
            }
            return;
        }

        internal function closePopupNow():void
        {
            debug.Debug.debug("closePopupNow...");
            this._progressPopUp.removeEventListener(frontend.components.popup.ProgressPopUp.PROGRESS_COMPLETE, this.onProgressComplete);
            frontend.components.popup.PopUpBase.removePopUps(this._progressPopUp);
            this._progressPopUp = null;
            this.stopNoResponseTimeout();
            if (this.onProgressPopUpClosed != null) 
            {
                this.onProgressPopUpClosed();
            }
            return;
        }

        public function closeProgressPopUp():void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(handler.event.ProgressStatusEvent.PROGRESS, this.onProgressStatusEvent);
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.DeviceCommunicationHandler.EVENT_TRANSFER_PROGRESS_AUTOMATIC, this.onAutoProgressStatusEvent);
            if (!this._progressPopUp) 
            {
                return;
            }
            if (this.closeProgressOn100Percent) 
            {
                this._progressPopUp.setProgressPercentage(100);
            }
            else 
            {
                this.closePopupNow();
            }
            return;
        }

        internal function onProgressStatusEvent(arg1:handler.event.ProgressStatusEvent):void
        {
            this.updateNoResponseTimeout();
            if (!this._progressPopUp) 
            {
                return;
            }
            var loc1:*=this.progressStatusBase / arg1.logSize;
            var loc2:*=this.progressStatusStart;
            loc2 = loc2 + (arg1.currentLogIndex - 1) * loc1;
            loc2 = loc2 + loc1 * arg1.statusPercentCurrentLog / 100;
            debug.Debug.debug("index: " + arg1.currentLogIndex + "/" + arg1.logSize + " (" + arg1.statusPercentCurrentLog + "), start: " + this.progressStatusStart + ", base: " + this.progressStatusBase + ", percentTotal: " + loc2);
            this._progressPopUp.setProgressPercentage(loc2);
            return;
        }

        internal function onAutoProgressStatusEvent(arg1:handler.event.CustomCommunicationServiceProgressEvent):void
        {
            var loc1:*=0;
            this.updateNoResponseTimeout();
            if (!this._progressPopUp) 
            {
                return;
            }
            if (service.DeviceCommunicationHandler.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_NFC) 
            {
                debug.Debug.debug("auto progress: " + arg1.progress);
                loc1 = 100 * arg1.progress / this.progressStatusBase;
                if (loc1 == 100 && this.closeProgressOn100Percent) 
                {
                    return;
                }
                this._progressPopUp.setProgressPercentage(loc1);
            }
            if (!(arg1.message == null) && !(arg1.message == null)) 
            {
                this._progressPopUp.text = this._progressPopUp.text + arg1.message;
            }
            return;
        }

        internal function updateNoResponseTimeout():void
        {
            flash.utils.clearTimeout(this._noResponseTimeout);
            var loc1:*=60000;
            this._noResponseTimeout = flash.utils.setTimeout(this.onNoResponse, loc1);
            return;
        }

        internal function stopNoResponseTimeout():void
        {
            flash.utils.clearTimeout(this._noResponseTimeout);
            return;
        }

        internal function onNoResponse():void
        {
            handler.CommunicationHandling.getInstance().dispatchEventWith(handler.CommunicationHandling.COMMUNICATION_TIMEOUT);
            return;
        }

        internal function get _showConnectPicture():Boolean
        {
            return this._759566416_showConnectPicture;
        }

        internal function _CommunicationState_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._CommunicationState_VerticalLayout1_i();
            loc1.mxmlContent = [this._CommunicationState_TextureImage1_i(), this._CommunicationState_Label1_i(), this._CommunicationState_LayoutGroup3_c(), this._CommunicationState_LayoutGroup5_i()];
            loc1.id = "row2";
            this.row2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "row2", this.row2);
            return loc1;
        }

        internal function _CommunicationState_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "center";
            loc1.verticalAlign = "middle";
            this._CommunicationState_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_VerticalLayout1", this._CommunicationState_VerticalLayout1);
            return loc1;
        }

        internal function _CommunicationState_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "connectPicture";
            this.connectPicture = loc1;
            feathers.binding.BindingManager.executeBindings(this, "connectPicture", this.connectPicture);
            return loc1;
        }

        internal function _CommunicationState_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_CommunicationState_Label1";
            this._CommunicationState_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_Label1", this._CommunicationState_Label1);
            return loc1;
        }

        internal function _CommunicationState_LayoutGroup3_c():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._CommunicationState_HorizontalLayout1_i();
            loc1.mxmlContent = [this._CommunicationState_LayoutGroup4_i(), this._CommunicationState_Button1_i(), this._CommunicationState_Button2_i()];
            return loc1;
        }

        internal function _CommunicationState_HorizontalLayout1_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._CommunicationState_HorizontalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_HorizontalLayout1", this._CommunicationState_HorizontalLayout1);
            return loc1;
        }

        internal function _CommunicationState_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "movie";
            this.movie = loc1;
            feathers.binding.BindingManager.executeBindings(this, "movie", this.movie);
            return loc1;
        }

        internal function _CommunicationState_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("triggered", this.___CommunicationState_Button1_triggered);
            loc1.id = "_CommunicationState_Button1";
            this._CommunicationState_Button1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_Button1", this._CommunicationState_Button1);
            return loc1;
        }

        public function ___CommunicationState_Button1_triggered(arg1:starling.events.Event):void
        {
            this.onEnableBLEButtonHandler(arg1);
            return;
        }

        internal function _CommunicationState_Button2_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("triggered", this.___CommunicationState_Button2_triggered);
            loc1.id = "_CommunicationState_Button2";
            this._CommunicationState_Button2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_Button2", this._CommunicationState_Button2);
            return loc1;
        }

        public function ___CommunicationState_Button2_triggered(arg1:starling.events.Event):void
        {
            this.onEnableNFCButtonHandler(arg1);
            return;
        }

        internal function _CommunicationState_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._CommunicationState_HorizontalLayout2_i();
            loc1.mxmlContent = [this._CommunicationState_TextureImage2_i(), this._CommunicationState_Label2_i()];
            loc1.id = "_CommunicationState_LayoutGroup5";
            this._CommunicationState_LayoutGroup5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_LayoutGroup5", this._CommunicationState_LayoutGroup5);
            return loc1;
        }

        internal function _CommunicationState_HorizontalLayout2_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.horizontalAlign = "center";
            loc1.verticalAlign = "middle";
            this._CommunicationState_HorizontalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_HorizontalLayout2", this._CommunicationState_HorizontalLayout2);
            return loc1;
        }

        internal function _CommunicationState_TextureImage2_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "_CommunicationState_TextureImage2";
            this._CommunicationState_TextureImage2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_TextureImage2", this._CommunicationState_TextureImage2);
            return loc1;
        }

        internal function _CommunicationState_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_CommunicationState_Label2";
            this._CommunicationState_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_Label2", this._CommunicationState_Label2);
            return loc1;
        }

        internal function _CommunicationState_LayoutGroup6_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._CommunicationState_TextureImage3_i(), this._CommunicationState_LayoutGroup7_i(), this._CommunicationState_TextureImage4_i()];
            loc1.addEventListener("touch", this.__row3_touch);
            loc1.id = "row3";
            this.row3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "row3", this.row3);
            return loc1;
        }

        internal function _CommunicationState_TextureImage3_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.touchable = false;
            loc1.id = "_CommunicationState_TextureImage3";
            this._CommunicationState_TextureImage3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_TextureImage3", this._CommunicationState_TextureImage3);
            return loc1;
        }

        internal function _CommunicationState_LayoutGroup7_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._CommunicationState_Label3_i(), this._CommunicationState_Label4_i()];
            loc1.id = "_CommunicationState_LayoutGroup7";
            this._CommunicationState_LayoutGroup7 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_LayoutGroup7", this._CommunicationState_LayoutGroup7);
            return loc1;
        }

        internal function _CommunicationState_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_CommunicationState_Label3";
            this._CommunicationState_Label3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_Label3", this._CommunicationState_Label3);
            return loc1;
        }

        internal function _CommunicationState_Label4_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_CommunicationState_Label4";
            this._CommunicationState_Label4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_Label4", this._CommunicationState_Label4);
            return loc1;
        }

        internal function _CommunicationState_TextureImage4_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.touchable = false;
            loc1.id = "_CommunicationState_TextureImage4";
            this._CommunicationState_TextureImage4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CommunicationState_TextureImage4", this._CommunicationState_TextureImage4);
            return loc1;
        }

        public function __row3_touch(arg1:starling.events.TouchEvent):void
        {
            this.onSelectDeviceClicked(arg1);
            return;
        }

        public function ___CommunicationState_LayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___CommunicationState_LayoutGroup1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _CommunicationState_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[3] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !_useSmallLayout;
            }, null, "row1.includeInLayout")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0, 0, NaN, 0);
            }, null, "row1.layoutData")
            result[5] = new feathers.binding.Binding(this, null, null, "row1.text", "headline");
            result[6] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !_useSmallLayout;
            }, null, "row1.visible")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "row1.width")
            result[8] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "row2.backgroundSkin")
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(_useSmallLayout ? 0 : frontend.components.menuList.MenuList.HEADLINE_HEIGHT, 0, frontend.components.menuList.MenuList.ROW_HEIGHT + 2 * _spacerHeight, 0);
            }, null, "row2.layoutData")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "row2.width")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return 40 * SIGMALink.scaleFactor;
            }, null, "_CommunicationState_VerticalLayout1.gap")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return ICON_PADDING_LEFT;
            }, null, "_CommunicationState_VerticalLayout1.padding")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return _useSmallLayout ? 0.7 : 1;
            }, null, "connectPicture.scale")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_howtoImageTextureName;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "connectPicture.textureName")
            result[15] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showConnectPicture;
            }, null, "connectPicture.visible")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * ICON_PADDING_LEFT;
            }, null, "_CommunicationState_Label1.maxWidth")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_infoStyleName;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_Label1.styleName")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_infoText;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_Label1.text")
            result[19] = new feathers.binding.Binding(this, function ():Number
            {
                return 40 * SIGMALink.scaleFactor;
            }, null, "_CommunicationState_HorizontalLayout1.gap")
            result[20] = new feathers.binding.Binding(this, null, null, "movie.includeInLayout", "loading");
            result[21] = new feathers.binding.Binding(this, null, null, "movie.visible", "loading");
            result[22] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showEnableBLEButton;
            }, null, "_CommunicationState_Button1.includeInLayout")
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SELECTOR.ENABLE_BLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_Button1.label")
            result[24] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showEnableBLEButton;
            }, null, "_CommunicationState_Button1.visible")
            result[25] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showEnableNFCButton;
            }, null, "_CommunicationState_Button2.includeInLayout")
            result[26] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SELECTOR.ENABLE_NFC");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_Button2.label")
            result[27] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showEnableNFCButton;
            }, null, "_CommunicationState_Button2.visible")
            result[28] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !_useSmallLayout;
            }, null, "_CommunicationState_LayoutGroup5.includeInLayout")
            result[29] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, NaN);
            }, null, "_CommunicationState_LayoutGroup5.layoutData")
            result[30] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !_useSmallLayout;
            }, null, "_CommunicationState_LayoutGroup5.visible")
            result[31] = new feathers.binding.Binding(this, function ():Number
            {
                return 10 * SIGMALink.scaleFactor;
            }, null, "_CommunicationState_HorizontalLayout2.gap")
            result[32] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.videoicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_TextureImage2.textureName")
            result[33] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_Label2.styleName")
            result[34] = new feathers.binding.Binding(this, null, null, "_CommunicationState_Label2.text", "videoText");
            result[35] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "row3.backgroundSkin")
            result[36] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "row3.height")
            result[37] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "row3.layout")
            result[38] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, 0, _spacerHeight, 0);
            }, null, "row3.layoutData")
            result[39] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "row3.width")
            result[40] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ICON_PADDING_LEFT, NaN, 0);
            }, null, "_CommunicationState_TextureImage3.layoutData")
            result[41] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_deviceTexture;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_TextureImage3.textureName")
            result[42] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.VerticalLayout();
            }, null, "_CommunicationState_LayoutGroup7.layout")
            result[43] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NAME_PADDING_LEFT, NaN, 0);
            }, null, "_CommunicationState_LayoutGroup7.layoutData")
            result[44] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_Label3.styleName")
            result[45] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SELECTOR.SELECTED_DEVICE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_Label3.text")
            result[46] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_Label4.styleName")
            result[47] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_deviceName;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_Label4.text")
            result[48] = new feathers.binding.Binding(this, null, null, "_CommunicationState_TextureImage4.includeInLayout", "unitChangeable");
            result[49] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(1, 1, NaN, NaN);
            }, null, "_CommunicationState_TextureImage4.layoutData")
            result[50] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.linkiconsmall;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CommunicationState_TextureImage4.textureName")
            result[51] = new feathers.binding.Binding(this, null, null, "_CommunicationState_TextureImage4.visible", "unitChangeable");
            return result;
        }

        public function get connectPicture():frontend.components.TextureImage
        {
            return this._376471732connectPicture;
        }

        public var _CommunicationState_Button1:feathers.controls.Button;

        public var _CommunicationState_Button2:feathers.controls.Button;

        public var _CommunicationState_HorizontalLayout1:feathers.layout.HorizontalLayout;

        public var _CommunicationState_HorizontalLayout2:feathers.layout.HorizontalLayout;

        public var _CommunicationState_Label1:feathers.controls.Label;

        public var _CommunicationState_Label2:feathers.controls.Label;

        public var _CommunicationState_Label3:feathers.controls.Label;

        public var _CommunicationState_Label4:feathers.controls.Label;

        public var _CommunicationState_LayoutGroup5:feathers.controls.LayoutGroup;

        public var _CommunicationState_LayoutGroup7:feathers.controls.LayoutGroup;

        public var _CommunicationState_TextureImage2:frontend.components.TextureImage;

        public var _CommunicationState_TextureImage3:frontend.components.TextureImage;

        public var _CommunicationState_TextureImage4:frontend.components.TextureImage;

        public var _CommunicationState_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _376471732connectPicture:frontend.components.TextureImage;

        internal var _104087344movie:feathers.controls.LayoutGroup;

        internal var _3506583row1:frontend.components.menuList.MenuListHeadline;

        internal var _3506585row3:feathers.controls.LayoutGroup;

        public var closeProgressOn100Percent:Boolean=true;

        internal var _headline:String;

        internal var _loading:Boolean;

        public var onProgressPopUpClosed:Function;

        public var progressStatusBase:int=100;

        public var progressStatusStart:Number=0;

        internal var _unitChangeable:Boolean=false;

        internal var _478887639_useSmallLayout:Boolean=true;

        internal var _1332942920videoText:String;

        internal var _1869301664_deviceName:String="";

        internal var _975205350_deviceTexture:String="unknown";

        internal var _207045591_howtoImageTextureName:String="connectnfc";

        internal var _358726863_infoStyleName:String="NORMAL";

        internal var _268453978_infoText:String;

        internal var _loadingAtlas:starling.textures.TextureAtlas;

        internal var _movieClip:starling.display.MovieClip;

        internal var _noResponseTimeout:uint=0;

        internal var _progressPopUp:frontend.components.popup.ProgressPopUp;

        internal var _759566416_showConnectPicture:Boolean=false;

        internal var _1699689810_showEnableBLEButton:Boolean=false;

        internal var _1261274370_showEnableNFCButton:Boolean=false;

        internal var _213927506_spacerHeight:uint;

        mx_internal var _watchers:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindingsByDestination:Object;

        internal var _3506584row2:feathers.controls.LayoutGroup;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        internal static var _810755685ICON_PADDING_LEFT:Number;

        internal static var _78149431NAME_PADDING_LEFT:Number;
    }
}


//    class DeviceList
package frontend.screen.component.devices 
{
    import backend.utils.dbUtils.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.components.list.*;
    import frontend.screen.mydevices.list.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class DeviceList extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function DeviceList()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._138694455_defaultHeight = SIGMALink.containerHeight;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._DeviceList_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_component_devices_DeviceListWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.component.devices.DeviceList[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceList_ListLoader1_i()];
            this.addEventListener("addedToStage", this.___DeviceList_LayoutGroup1_addedToStage);
            this.addEventListener("initialize", this.___DeviceList_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set listLoader(arg1:frontend.components.list.ListLoader):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._159473233listLoader;
            if (loc1 !== arg1) 
            {
                this._159473233listLoader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listLoader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _defaultHeight():Number
        {
            return this._138694455_defaultHeight;
        }

        internal function set _defaultHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._138694455_defaultHeight;
            if (loc1 !== arg1) 
            {
                this._138694455_defaultHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_defaultHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get dataProvider():feathers.data.ListCollection
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            this._dataProvider = arg1;
            return;
        }

        public override function set height(arg1:Number):void
        {
            super.height = arg1;
            this._defaultHeight = arg1;
            if (this._deviceList) 
            {
                this._deviceList.height = arg1;
            }
            if (this.listLoader) 
            {
                this.listLoader.height = arg1;
            }
            return;
        }

        internal function get _deviceList():frontend.components.list.CustomList
        {
            return this._1869249971_deviceList;
        }

        internal function set _deviceList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1869249971_deviceList;
            if (loc1 !== arg1) 
            {
                this._1869249971_deviceList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_deviceList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.component.devices.DeviceList._watcherSetupUtil = arg1;
            return;
        }

        protected function addedToStageHandler(arg1:starling.events.Event):void
        {
            this._deviceList.selectedItem = null;
            if (this.listLoader) 
            {
                this.listLoader.checkDataProvider();
            }
            return;
        }

        public function loadUnits(arg1:frontend.screen.component.devices.DeviceListEvent=null):void
        {
            this.listLoader.startLoading();
            handler.AppDeviceHandler.getInstance().loadUnits(new backend.utils.dbUtils.DBUtilObject(null, this.loadDevicesComplete, this.loadDevicesError, Workers.worker_DatabaseWorker));
            return;
        }

        public function setUnits(arg1:feathers.data.ListCollection):void
        {
            this._dataProvider = arg1;
            if (this.listLoader) 
            {
                this.listLoader.checkDataProvider();
            }
            return;
        }

        public function updateUnit(arg1:frontend.screen.component.devices.DeviceListEvent):void
        {
            if (!arg1.unit) 
            {
                return;
            }
            var loc1:*=this.getUnitIndex(arg1.unit);
            if (loc1 != -1) 
            {
                this._dataProvider.updateItemAt(loc1);
            }
            return;
        }

        public function deleteUnit(arg1:frontend.screen.component.devices.DeviceListEvent):void
        {
            if (!arg1.unit) 
            {
                return;
            }
            var loc1:*=this.getUnitIndex(arg1.unit);
            if (loc1 != -1) 
            {
                this._dataProvider.removeItemAt(loc1);
            }
            this.listLoader.checkDataProvider();
            if (this.completeCallback != null) 
            {
                this.completeCallback();
            }
            return;
        }

        internal function getUnitIndex(arg1:core.units.Unit):int
        {
            var loc2:*=0;
            var loc1:*=-1;
            var loc3:*=this._dataProvider.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (this._dataProvider.getItemAt(loc2).GUID == arg1.GUID) 
                {
                    loc1 = loc2;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        internal function loadDevicesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Devices konnten nicht geladen werden:\t " + arg1.message);
            return;
        }

        internal function loadDevicesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=null;
            this._dataProvider = new feathers.data.ListCollection();
            if (this._deviceList != null) 
            {
                this._deviceList.dataProvider = this._dataProvider;
            }
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = new frontend.screen.mydevices.list.MyDevicesListItem();
                loc4.unit = core.units.UnitFactory.createUnitFromDB(loc1[loc2]);
                loc4.GUID = loc4.unit.GUID;
                this._dataProvider.push(loc4);
                ++loc2;
            }
            if (this.completeCallback != null) 
            {
                this.completeCallback();
            }
            this.listLoader.stopLoading();
            return;
        }

        internal function initializeHandler(arg1:starling.events.Event):void
        {
            this._deviceList = new frontend.components.list.CustomList();
            this._deviceList.allowScrollingInPopUpMode = true;
            this._deviceList.allowMultipleSelection = false;
            this._deviceList.dataProvider = this._dataProvider;
            this._deviceList.height = this._defaultHeight;
            this._deviceList.itemRendererType = frontend.screen.mydevices.list.MyDevicesRenderer;
            this._deviceList.width = SIGMALink.appWidth;
            this._deviceList.addEventListener(starling.events.TouchEvent.TOUCH, this.onListTouch);
            this._deviceList.clipContent = true;
            this._deviceList.validateScrollPolicy();
            if (this._dataProvider == null) 
            {
                this.loadUnits();
            }
            return;
        }

        protected function onListTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.listLoader.listStateHandler.editState) 
            {
                return;
            }
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.triggeredHandler == null) 
            {
                debug.Debug.warning("callTriggeredHandler: No Trigger Function defined.");
            }
            else 
            {
                this.triggeredHandler(this._deviceList.selectedItem as frontend.screen.mydevices.list.MyDevicesListItem);
            }
            return;
        }

        internal function _DeviceList_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        public function ___DeviceList_LayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        public function ___DeviceList_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.initializeHandler(arg1);
            return;
        }

        internal function _DeviceList_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return _defaultHeight;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return _defaultHeight;
            }, null, "listLoader.height")
            result[4] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _deviceList;
            }, null, "listLoader.list")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            return result;
        }

        public function get listLoader():frontend.components.list.ListLoader
        {
            return this._159473233listLoader;
        }

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        public var completeCallback:Function;

        internal var _dataProvider:feathers.data.ListCollection;

        public var triggeredHandler:Function;

        internal var _138694455_defaultHeight:Number;

        internal var _1869249971_deviceList:frontend.components.list.CustomList;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class DeviceListEvent
package frontend.screen.component.devices 
{
    import core.units.*;
    import flash.events.*;
    
    public class DeviceListEvent extends flash.events.Event
    {
        public function DeviceListEvent(arg1:String, arg2:core.units.Unit=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.unit = arg2;
            return;
        }

        public static const DELETE:String="deleteDeviceEvent";

        public static const RELOAD:String="reloadDevicesEvent";

        public static const UPDATE:String="updateDeviceEvent";

        public var unit:core.units.Unit;
    }
}


//  class CustomScreen
package frontend.screen.component 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CustomScreen extends feathers.controls.Screen
    {
        public function CustomScreen()
        {
            super();
            layout = new feathers.layout.AnchorLayout();
            width = SIGMALink.appWidth;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        public function get title():String
        {
            return this._title;
        }

        internal function set _110371416title(arg1:String):void
        {
            this._title = arg1;
            handler.ViewHandler.getInstance().currentTitle = this._title;
            return;
        }

        protected override function initialize():void
        {
            if (this.initialized) 
            {
                return;
            }
            this.addContent();
            super.initialize();
            this.initialized = true;
            return;
        }

        public override function validate():void
        {
            var loc1:*=isInvalid(feathers.core.FeathersControl.INVALIDATION_FLAG_DATA);
            super.validate();
            if (loc1) 
            {
                this.validateProperties();
            }
            return;
        }

        protected function validateProperties():void
        {
            return;
        }

        protected function addContent():void
        {
            return;
        }

        public function set title(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.title;
            if (loc1 !== arg1) 
            {
                this._110371416title = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "title", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var allowCaching:Boolean=true;

        public var hasBackwardNavigation:Boolean=false;

        public var initialized:Boolean=false;

        public var saveAsOldScreen:Boolean=true;

        public var savePropertiesForBackNavigation:Boolean=false;

        internal var _title:String;
    }
}


//  class CustomScreenNavigator
package frontend.screen.component 
{
    import feathers.controls.*;
    
    public class CustomScreenNavigator extends feathers.controls.ScreenNavigator
    {
        public function CustomScreenNavigator()
        {
            super();
            return;
        }
    }
}


//  class Footer
package frontend.screen.component 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import frontend.*;
    import frontend.components.button.*;
    import handler.*;
    import helper.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    
    public class Footer extends feathers.controls.LayoutGroup
    {
        public function Footer()
        {
            this._buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this._padding = 10 * SIGMALink.scaleFactor;
            super();
            height = SIGMALink.footerHeight;
            width = SIGMALink.appWidth;
            layoutData = new feathers.layout.AnchorLayoutData(NaN, 0, 0, 0);
            layout = new feathers.layout.HorizontalLayout();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            this._groupLeftRightLayout = new feathers.layout.HorizontalLayout();
            this._groupLeftRightLayout.paddingLeft = this._padding;
            this._groupLeftRightLayout.paddingRight = this._padding;
            this._groupLeftRightLayout.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this._groupLeftRightLayout.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            this._groupCenterLayout = new feathers.layout.HorizontalLayout();
            this._groupCenterLayout.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this._groupCenterLayout.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            this._groupLeft = new feathers.controls.LayoutGroup();
            this._groupLeft.layout = this._groupLeftRightLayout;
            this._groupLeft.layoutData = new feathers.layout.HorizontalLayoutData(NaN, 100);
            addChild(this._groupLeft);
            this._groupCenter = new feathers.controls.LayoutGroup();
            this._groupCenter.layout = this._groupCenterLayout;
            this._groupCenter.layoutData = new feathers.layout.HorizontalLayoutData(100, 100);
            addChild(this._groupCenter);
            this._groupRight = new feathers.controls.LayoutGroup();
            this._groupRight.layout = this._groupLeftRightLayout;
            this._groupRight.layoutData = new feathers.layout.HorizontalLayoutData(NaN, 100);
            addChild(this._groupRight);
            addEventListener(feathers.events.FeathersEventType.INITIALIZE, this.onInit);
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddetToStage);
            return;
        }

        protected function onAddetToStage(arg1:starling.events.Event):void
        {
            this._saveYpos = this.y;
            this._saveXpos = this.x;
            return;
        }

        internal function tweenTo(arg1:Number, arg2:Number, arg3:Function=null):void
        {
            starling.core.Starling.juggler.remove(this._tween);
            this._tween = new starling.animation.Tween(this, this.animationDuration, this.animationTransition);
            if (arg3 != null) 
            {
                this._tween.onComplete = arg3;
            }
            this._tween.moveTo(arg1, arg2);
            starling.core.Starling.juggler.add(this._tween);
            return;
        }

        public function set backButtonIsEnabled(arg1:Boolean):void
        {
            if (!this._backButton) 
            {
                return;
            }
            this._backButton.isEnabled = arg1;
            return;
        }

        public function set buttonsEnabled(arg1:Boolean):void
        {
            if (!this._buttonGroup) 
            {
                return;
            }
            var loc1:*=0;
            while (loc1 < this._buttonGroup.length) 
            {
                this._buttonGroup[loc1].isEnabled = arg1;
                ++loc1;
            }
            return;
        }

        public function get showBackButton():Boolean
        {
            return this._showBackButton && !helper.Capabilities_helper.isAndroid();
        }

        public function get forceRightButton():Boolean
        {
            return this._forceRightButton;
        }

        public function set forceRightButton(arg1:Boolean):void
        {
            this._forceRightButton = arg1;
            this.reset();
            if (this._mxmlContentSet) 
            {
                this.drawContent();
            }
            return;
        }

        public override function set mxmlContent(arg1:Array):void
        {
            this._mxmlContentSet = true;
            this.addBackButton();
            var loc1:*=0;
            while (loc1 < arg1.length) 
            {
                if (arg1[loc1] is frontend.components.button.IconButton) 
                {
                    this._buttonGroup.push(arg1[loc1] as frontend.components.button.IconButton);
                }
                ++loc1;
            }
            this.drawContent();
            return;
        }

        public function reset():void
        {
            this._groupLeft.removeChildren();
            this._groupCenter.removeChildren();
            this._groupRight.removeChildren();
            this._backButtonAddet = false;
            this._initialized = false;
            return;
        }

        internal function drawContent():void
        {
            var loc1:*=0;
            if (this._initialized) 
            {
                return;
            }
            this._initialized = true;
            if (this._buttonGroup.length > 0) 
            {
                loc1 = 0;
                while (loc1 < this._buttonGroup.length) 
                {
                    var loc2:*=loc1;
                    switch (loc2) 
                    {
                        case 0:
                        {
                            if (this.showBackButton || !this.forceRightButton) 
                            {
                                this.addButton(this._buttonGroup[loc1], ORIENTATION_LEFT);
                            }
                            else if (this.forceRightButton) 
                            {
                                this.addButton(this._buttonGroup[loc1], ORIENTATION_RIGHT);
                            }
                            else 
                            {
                                this.addButton(this._buttonGroup[loc1], ORIENTATION_LEFT);
                            }
                            break;
                        }
                        case (this._buttonGroup.length - 1):
                        {
                            this.addButton(this._buttonGroup[loc1], ORIENTATION_RIGHT);
                            break;
                        }
                        default:
                        {
                            this.addButton(this._buttonGroup[loc1], ORIENTATION_CENTER);
                            break;
                        }
                    }
                    ++loc1;
                }
                this._groupLeft.validate();
                this._groupRight.validate();
                this._groupCenter.validate();
                this.refreshCenterGap();
            }
            return;
        }

        public function set showBackButton(arg1:Boolean):void
        {
            this._showBackButton = arg1 && !helper.Capabilities_helper.isAndroid();
            return;
        }

        public function refreshCenterGap():void
        {
            if (this._groupCenter.numChildren < 2) 
            {
                return;
            }
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            while (loc1 < this._groupCenter.numChildren) 
            {
                if (this._groupCenter.getChildAt(loc1).visible) 
                {
                    loc2 = loc2 + this._groupCenter.getChildAt(loc1).width;
                }
                ++loc1;
            }
            loc3 = this.width - this._groupLeft.width - this._groupRight.width - loc2;
            this._groupCenterLayout.gap = loc3 / (this._groupCenter.numChildren + 1);
            return;
        }

        internal function addBackButton():void
        {
            if (this.showBackButton && !this._backButtonAddet) 
            {
                this._backButton = new frontend.components.button.IconButton();
                this._backButton.image = frontend.Textures.backbutton;
                this._backButton.touchHandler = this.switchToLastScreen;
                this._buttonGroup.unshift(this._backButton);
                this._backButtonAddet = true;
            }
            return;
        }

        internal function switchToLastScreen(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function addButton(arg1:frontend.components.button.IconButton, arg2:String):void
        {
            var loc1:*=arg2;
            switch (loc1) 
            {
                case ORIENTATION_LEFT:
                {
                    if (this._groupLeft.numChildren == 0) 
                    {
                        this._groupLeft.addChild(arg1);
                    }
                    break;
                }
                case ORIENTATION_CENTER:
                {
                    this._groupCenter.addChild(arg1);
                    break;
                }
                case ORIENTATION_RIGHT:
                {
                    if (this._groupRight.numChildren == 0) 
                    {
                        this._groupRight.addChild(arg1);
                    }
                    break;
                }
            }
            arg1.validate();
            return;
        }

        public function setButtonGroup(arg1:__AS3__.vec.Vector.<frontend.components.button.IconButton>):void
        {
            if (this._initialized) 
            {
                this.reset();
            }
            this._buttonGroup = arg1;
            this.addBackButton();
            this.drawContent();
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            this.addBackButton();
            this.drawContent();
            return;
        }

        public function show(arg1:Function=null):void
        {
            this.tweenTo(this._saveXpos, this._saveYpos, arg1);
            return;
        }

        public function hide(arg1:Function=null):void
        {
            this.tweenTo(this._saveXpos, SIGMALink.appHeight, arg1);
            return;
        }

        public static const EVENT_TWEEN_COMPLETE:String="tweenComplete";

        internal static const ORIENTATION_CENTER:String="center";

        internal static const ORIENTATION_LEFT:String="left";

        internal static const ORIENTATION_RIGHT:String="right";

        public var animationDuration:Number=0.3;

        public var animationTransition:String="easeIn";

        internal var _showBackButton:Boolean=true;

        internal var _forceRightButton:Boolean=false;

        internal var _backButton:frontend.components.button.IconButton;

        internal var _backButtonAddet:Boolean=false;

        internal var _buttonGroup:__AS3__.vec.Vector.<frontend.components.button.IconButton>;

        internal var _groupCenter:feathers.controls.LayoutGroup;

        internal var _groupLeft:feathers.controls.LayoutGroup;

        internal var _groupLeftRightLayout:feathers.layout.HorizontalLayout;

        internal var _groupRight:feathers.controls.LayoutGroup;

        internal var _initialized:Boolean=false;

        internal var _padding:Number;

        internal var _saveXpos:Number;

        internal var _saveYpos:Number;

        internal var _tween:starling.animation.Tween;

        internal var _groupCenterLayout:feathers.layout.HorizontalLayout;

        internal var _mxmlContentSet:Boolean=false;
    }
}


