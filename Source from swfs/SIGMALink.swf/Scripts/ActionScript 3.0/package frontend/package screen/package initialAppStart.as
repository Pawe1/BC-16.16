//package initialAppStart
//  class InitialAppSettings
package frontend.screen.initialAppStart 
{
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.*;
    import frontend.components.menuList.*;
    import frontend.screen.appsettings.allgemein.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class InitialAppSettings extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialAppSettings()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._InitialAppSettings_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialAppSettingsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialAppSettings[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._InitialAppSettings_MenuListItem1_i(), this._InitialAppSettings_GeneralAppSettings1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public override function set height(arg1:Number):void
        {
            super.height = arg1;
            this._scrollerHeight = height - frontend.screen.initialAppStart.InitialAppStart.FOOTER_HEIGHT - frontend.screen.initialAppStart.InitialAppStart.PADDING - 6 * SIGMALink.scaleFactor;
            return;
        }

        internal function _InitialAppSettings_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "INITIAL_APP_SETTINGS_TITLE";
            loc1.touchable = false;
            loc1.id = "_InitialAppSettings_MenuListItem1";
            this._InitialAppSettings_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialAppSettings_MenuListItem1", this._InitialAppSettings_MenuListItem1);
            return loc1;
        }

        internal function _InitialAppSettings_GeneralAppSettings1_i():frontend.screen.appsettings.allgemein.GeneralAppSettings
        {
            var loc1:*=new frontend.screen.appsettings.allgemein.GeneralAppSettings();
            loc1.clipContent = true;
            loc1.id = "_InitialAppSettings_GeneralAppSettings1";
            this._InitialAppSettings_GeneralAppSettings1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialAppSettings_GeneralAppSettings1", this._InitialAppSettings_GeneralAppSettings1);
            return loc1;
        }

        internal function _InitialAppSettings_bindingsSetup():Array
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
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.settingsiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialAppSettings_MenuListItem1.iconTexture")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_InitialAppSettings_MenuListItem1.minItemHeight")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return _scrollerHeight;
            }, null, "_InitialAppSettings_GeneralAppSettings1.height")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT + frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialAppSettings_GeneralAppSettings1.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialAppSettings_GeneralAppSettings1.width")
            return result;
        }

        internal function get _scrollerHeight():Number
        {
            return this._1361851360_scrollerHeight;
        }

        internal function set _scrollerHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1361851360_scrollerHeight;
            if (loc1 !== arg1) 
            {
                this._1361851360_scrollerHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_scrollerHeight", loc1, arg1, this);
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
            frontend.screen.initialAppStart.InitialAppSettings._watcherSetupUtil = arg1;
            return;
        }

        public var _InitialAppSettings_GeneralAppSettings1:frontend.screen.appsettings.allgemein.GeneralAppSettings;

        public var _InitialAppSettings_MenuListItem1:frontend.components.menuList.MenuListItem;

        internal var _1361851360_scrollerHeight:Number=0;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class InitialAppStart
package frontend.screen.initialAppStart 
{
    import backend.oauth.*;
    import configCache.*;
    import core.general.*;
    import core.units.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
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
    import frontend.screen.cloud.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import service.oauth.*;
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
    
    public class InitialAppStart extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function InitialAppStart()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._InitialAppStart_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialAppStartWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialAppStart[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.hasBackwardNavigation = false;
            this.layout = this._InitialAppStart_AnchorLayout1_c();
            this.mxmlContent = [this._InitialAppStart_InitialAppStartProgress1_i(), this._InitialAppStart_LayoutGroup1_i(), this._InitialAppStart_LayoutGroup2_i()];
            this.addEventListener("creationComplete", this.___InitialAppStart_CustomScreen1_creationComplete);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set footer(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get holder():feathers.controls.LayoutGroup
        {
            return this._1211707988holder;
        }

        public function set holder(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1211707988holder;
            if (loc1 !== arg1) 
            {
                this._1211707988holder = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "holder", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get progress():frontend.screen.initialAppStart.InitialAppStartProgress
        {
            return this._1001078227progress;
        }

        public function set progress(arg1:frontend.screen.initialAppStart.InitialAppStartProgress):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1001078227progress;
            if (loc1 !== arg1) 
            {
                this._1001078227progress = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "progress", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _InitialAppStart_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "holder";
            this.holder = loc1;
            feathers.binding.BindingManager.executeBindings(this, "holder", this.holder);
            return loc1;
        }

        internal function get _currentStep():int
        {
            return this._20827610_currentStep;
        }

        internal function set _currentStep(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._20827610_currentStep;
            if (loc1 !== arg1) 
            {
                this._20827610_currentStep = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_currentStep", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get PADDING():Number
        {
            return frontend.screen.initialAppStart.InitialAppStart._88356879PADDING;
        }

        public static function set PADDING(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.screen.initialAppStart.InitialAppStart._88356879PADDING;
            if (loc1 !== arg1) 
            {
                frontend.screen.initialAppStart.InitialAppStart._88356879PADDING = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "PADDING", loc1, arg1, frontend.screen.initialAppStart.InitialAppStart);
                loc3 = frontend.screen.initialAppStart.InitialAppStart.staticEventDispatcher;
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
            _88356879PADDING = 17 * SIGMALink.scaleFactor;
            BUTTON_HEIGHT = 60 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        protected override function validateProperties():void
        {
            super.validateProperties();
            if (savePropertiesForBackNavigation) 
            {
                this.continueHandler();
            }
            return;
        }

        internal function continueHandler(arg1:starling.events.TouchEvent=null):void
        {
            if (arg1 != null) 
            {
                if (!handler.TouchHandler.isTouch(arg1)) 
                {
                    return;
                }
            }
            if (this._currentStep != 5) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this)._currentStep + 1);
                loc1._currentStep = loc2;
                this.validateContent(this._currentStep);
            }
            else 
            {
                saveAsOldScreen = false;
                configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.INITIAL_APP_START, false);
                handler.ViewHandler.getInstance().initComplete();
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DASHBOARD);
            }
            return;
        }

        internal function selectDeviceHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.CommunicationHandling.getInstance().stopCommunication();
            if (this.initialDevice != null) 
            {
                (arg1.currentTarget as feathers.controls.Button).visible = false;
                this.initialDevice.showDeviceList();
                this._holderHeight = SIGMALink.containerHeight + SIGMALink.footerHeight - frontend.screen.initialAppStart.InitialAppStartProgress.HEIGHT;
                this.validateFooterHeight();
                this.initialDevice.height = this._holderHeight;
            }
            return;
        }

        internal function cloudLoginHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (!handler.ConnectionHandler.checkNoInternetPopUp()) 
            {
                return;
            }
            backend.oauth.SigmaOAuth.getInstance().addEventListener(service.oauth.CommonOAuth.LOGGED_IN, this.onLoggedIn);
            frontend.screen.cloud.CloudView.checkLogin(true);
            return;
        }

        internal function onLoggedIn(arg1:flash.events.Event=null):void
        {
            var loc1:*;
            var loc2:*=((loc1 = this)._currentStep + 1);
            loc1._currentStep = loc2;
            this.validateContent(this._currentStep);
            return;
        }

        internal function cloudRegisterHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (!handler.ConnectionHandler.checkNoInternetPopUp()) 
            {
                return;
            }
            flash.net.navigateToURL(new flash.net.URLRequest(backend.oauth.SigmaOAuth.getInstance().REGISTER_URL), "_blank");
            return;
        }

        internal function onComplete():void
        {
            this._currentStep = 1;
            this.validateContent(this._currentStep);
            return;
        }

        internal function validateFooterHeight():void
        {
            var loc3:*=0;
            var loc1:*=0;
            var loc2:*=this.footer.numChildren;
            while (loc1 < loc2) 
            {
                if (this.footer.getChildAt(loc1) is feathers.controls.Button && this.footer.getChildAt(loc1).visible) 
                {
                    ++loc3;
                }
                ++loc1;
            }
            FOOTER_HEIGHT = loc3 * BUTTON_HEIGHT + (loc3 + 1) * PADDING;
            this._holderHeight = this._holderHeight - FOOTER_HEIGHT;
            this.holder.y = frontend.screen.initialAppStart.InitialAppStartProgress.HEIGHT;
            this.holder.height = this._holderHeight;
            this.updateElement(this.footer, frontend.screen.initialAppStart.InitialAppStartProgress.HEIGHT + this._holderHeight, FOOTER_HEIGHT);
            return;
        }

        internal function validateContent(arg1:int):void
        {
            var p_step:int;
            var buttonWidth:Number;
            var continue1:feathers.controls.Button;
            var selectDevice:feathers.controls.Button;
            var skipDeviceSelection:feathers.controls.Button;
            var onUnitSelectedCallback:Function;
            var onDeviceAddetCallback:Function;
            var cloudLogin:feathers.controls.Button;
            var cloudRegister:feathers.controls.Button;
            var cloudSkip:feathers.controls.Button;
            var socialNetworkSkip:feathers.controls.Button;
            var complete:feathers.controls.Button;

            var loc1:*;
            continue1 = null;
            selectDevice = null;
            skipDeviceSelection = null;
            cloudLogin = null;
            cloudRegister = null;
            cloudSkip = null;
            socialNetworkSkip = null;
            complete = null;
            p_step = arg1;
            if (isNaN(SIGMALink.containerHeight)) 
            {
                flash.utils.setTimeout(this.validateContent, 100, p_step);
                return;
            }
            buttonWidth = SIGMALink.appWidth - 2 * PADDING;
            this._holderHeight = SIGMALink.containerHeight + SIGMALink.footerHeight - frontend.screen.initialAppStart.InitialAppStartProgress.HEIGHT;
            var loc2:*=p_step;
            switch (loc2) 
            {
                case 1:
                {
                    this.clearFooter();
                    continue1 = new feathers.controls.Button();
                    continue1.width = buttonWidth;
                    continue1.label = utils.LanguageManager.getString("INITIAL_APP_START_CONTINUE");
                    continue1.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
                    continue1.addEventListener(starling.events.TouchEvent.TOUCH, this.continueHandler);
                    this.footer.addChild(continue1);
                    this.validateFooterHeight();
                    this.initialAppSettings = new frontend.screen.initialAppStart.InitialAppSettings();
                    this.initialAppSettings.clipContent = true;
                    this.initialAppSettings.height = this._holderHeight;
                    this.initialAppSettings.width = SIGMALink.appWidth;
                    this.holder.addChild(this.initialAppSettings);
                    break;
                }
                case 2:
                {
                    onUnitSelectedCallback = function (arg1:core.units.Unit):void
                    {
                        selectDevice.visible = true;
                        _holderHeight = SIGMALink.containerHeight + SIGMALink.footerHeight - frontend.screen.initialAppStart.InitialAppStartProgress.HEIGHT;
                        validateFooterHeight();
                        initialDevice.height = _holderHeight;
                        handler.CommunicationHandling.getInstance().currentDevice = arg1;
                        return;
                    }
                    onDeviceAddetCallback = function ():void
                    {
                        savePropertiesForBackNavigation = true;
                        handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ADD_DEVICE_SET_NAME, {"unit":handler.CommunicationHandling.getInstance().currentDevice, "initialAppStart":true}, handler.ViewHandler.slideToLeftTransition());
                        return;
                    }
                    this.clearFooter();
                    selectDevice = new feathers.controls.Button();
                    selectDevice.width = buttonWidth;
                    selectDevice.label = utils.LanguageManager.getString("INITIAL_APP_START_SELECT_DEVICE");
                    selectDevice.layoutData = new feathers.layout.AnchorLayoutData(PADDING, NaN, NaN, NaN, 0);
                    selectDevice.addEventListener(starling.events.TouchEvent.TOUCH, this.selectDeviceHandler);
                    this.footer.addChild(selectDevice);
                    skipDeviceSelection = new feathers.controls.Button();
                    skipDeviceSelection.width = buttonWidth;
                    skipDeviceSelection.label = utils.LanguageManager.getString("INITIAL_APP_START_SKIP");
                    skipDeviceSelection.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, PADDING, NaN, 0);
                    skipDeviceSelection.addEventListener(starling.events.TouchEvent.TOUCH, this.continueHandler);
                    this.footer.addChild(skipDeviceSelection);
                    this.validateFooterHeight();
                    handler.ViewHandler.getInstance().currentTitle = utils.LanguageManager.getString("INITIAL_APP_START_CONNECT_DEVICE");
                    this.initialDevice = new frontend.screen.initialAppStart.InitialConnectDevice();
                    this.initialDevice.x = SIGMALink.appWidth;
                    this.initialDevice.width = SIGMALink.appWidth;
                    this.initialDevice.height = this._holderHeight;
                    this.initialDevice.unitSelectedCallback = onUnitSelectedCallback;
                    this.initialDevice.deviceAddetCallback = onDeviceAddetCallback;
                    this.holder.addChild(this.initialDevice);
                    this.showNextContent(this.initialAppSettings, this.initialDevice);
                    break;
                }
                case 3:
                {
                    this.clearFooter();
                    cloudLogin = new feathers.controls.Button();
                    cloudLogin.width = buttonWidth;
                    cloudLogin.label = utils.LanguageManager.getString("INITIAL_APP_START_CLOUD_LOGIN");
                    cloudLogin.layoutData = new feathers.layout.AnchorLayoutData(PADDING, NaN, NaN, NaN, 0);
                    cloudLogin.addEventListener(starling.events.TouchEvent.TOUCH, this.cloudLoginHandler);
                    this.footer.addChild(cloudLogin);
                    cloudRegister = new feathers.controls.Button();
                    cloudRegister.width = buttonWidth;
                    cloudRegister.label = utils.LanguageManager.getString("INITIAL_APP_START_CLOUD_REGISTER");
                    cloudRegister.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
                    cloudRegister.addEventListener(starling.events.TouchEvent.TOUCH, this.cloudRegisterHandler);
                    this.footer.addChild(cloudRegister);
                    cloudSkip = new feathers.controls.Button();
                    cloudSkip.width = buttonWidth;
                    cloudSkip.label = utils.LanguageManager.getString("INITIAL_APP_START_SKIP");
                    cloudSkip.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, PADDING, NaN, 0);
                    cloudSkip.addEventListener(starling.events.TouchEvent.TOUCH, this.continueHandler);
                    this.footer.addChild(cloudSkip);
                    this.validateFooterHeight();
                    handler.ViewHandler.getInstance().currentTitle = utils.LanguageManager.getString("INITIAL_APP_START_CLOUD");
                    this.initialCloud = new frontend.screen.initialAppStart.InitialCloudConnect();
                    this.initialCloud.x = SIGMALink.appWidth;
                    this.initialCloud.width = SIGMALink.appWidth;
                    this.initialCloud.height = this._holderHeight;
                    this.holder.addChild(this.initialCloud);
                    this.showNextContent(this.initialDevice, this.initialCloud);
                    break;
                }
                case 4:
                {
                    this.clearFooter();
                    socialNetworkSkip = new feathers.controls.Button();
                    socialNetworkSkip.width = buttonWidth;
                    socialNetworkSkip.label = utils.LanguageManager.getString("INITIAL_APP_START_CONTINUE");
                    socialNetworkSkip.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
                    socialNetworkSkip.addEventListener(starling.events.TouchEvent.TOUCH, this.continueHandler);
                    this.footer.addChild(socialNetworkSkip);
                    this.validateFooterHeight();
                    handler.ViewHandler.getInstance().currentTitle = utils.LanguageManager.getString("INITIAL_APP_START_SOCIAL_NETWORKS");
                    this.initialSocialNetworks = new frontend.screen.initialAppStart.InitialSocialNetworkConnect();
                    this.initialSocialNetworks.x = SIGMALink.appWidth;
                    this.initialSocialNetworks.width = SIGMALink.appWidth;
                    this.initialSocialNetworks.height = this._holderHeight;
                    this.holder.addChild(this.initialSocialNetworks);
                    this.showNextContent(this.initialCloud, this.initialSocialNetworks);
                    break;
                }
                case 5:
                {
                    this.clearFooter();
                    complete = new feathers.controls.Button();
                    complete.width = buttonWidth;
                    complete.label = utils.LanguageManager.getString("INITIAL_APP_START_NOW");
                    complete.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
                    complete.addEventListener(starling.events.TouchEvent.TOUCH, this.continueHandler);
                    this.footer.addChild(complete);
                    this.validateFooterHeight();
                    handler.ViewHandler.getInstance().currentTitle = "";
                    this.initialStartComplete = new frontend.screen.initialAppStart.InitialStartComplete();
                    this.initialStartComplete.x = SIGMALink.appWidth;
                    this.initialStartComplete.width = SIGMALink.appWidth;
                    this.initialStartComplete.height = this._holderHeight;
                    this.holder.addChild(this.initialStartComplete);
                    this.showNextContent(this.initialSocialNetworks, this.initialStartComplete);
                    return;
                }
            }
            this.progress.setCurrentStep(this._currentStep);
            return;
        }

        internal function showNextContent(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
        {
            var p_obj1:starling.display.DisplayObject;
            var p_obj2:starling.display.DisplayObject;
            var tween1:starling.animation.Tween;
            var tween2:starling.animation.Tween;

            var loc1:*;
            tween1 = null;
            tween2 = null;
            p_obj1 = arg1;
            p_obj2 = arg2;
            tween1 = new starling.animation.Tween(p_obj1, frontend.screen.initialAppStart.InitialAppStartProgress.TWEEN_DURATION, starling.animation.Transitions.LINEAR);
            tween1.animate("x", -SIGMALink.appWidth);
            tween1.onComplete = function ():void
            {
                starling.core.Starling.juggler.remove(tween1);
                holder.removeChild(p_obj1);
                return;
            }
            starling.core.Starling.juggler.add(tween1);
            tween2 = new starling.animation.Tween(p_obj2, frontend.screen.initialAppStart.InitialAppStartProgress.TWEEN_DURATION, starling.animation.Transitions.LINEAR);
            tween2.animate("x", 0);
            tween2.onComplete = function ():void
            {
                starling.core.Starling.juggler.remove(tween2);
                return;
            }
            starling.core.Starling.juggler.add(tween2);
            return;
        }

        internal function updateElement(arg1:starling.display.DisplayObject, arg2:Number, arg3:Number):void
        {
            var p_element:starling.display.DisplayObject;
            var p_yTo:Number;
            var p_heightTo:Number;
            var tween1:starling.animation.Tween;

            var loc1:*;
            tween1 = null;
            p_element = arg1;
            p_yTo = arg2;
            p_heightTo = arg3;
            tween1 = new starling.animation.Tween(this.footer, frontend.screen.initialAppStart.InitialAppStartProgress.TWEEN_DURATION, starling.animation.Transitions.LINEAR);
            tween1.animate("height", p_heightTo);
            tween1.animate("y", p_yTo);
            tween1.onComplete = function ():void
            {
                starling.core.Starling.juggler.remove(tween1);
                return;
            }
            starling.core.Starling.juggler.add(tween1);
            return;
        }

        internal function clearFooter():void
        {
            while (this.footer.numChildren >= 2) 
            {
                this.footer.removeChildAt((this.footer.numChildren - 1));
            }
            return;
        }

        internal function _InitialAppStart_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _InitialAppStart_InitialAppStartProgress1_i():frontend.screen.initialAppStart.InitialAppStartProgress
        {
            var loc1:*=new frontend.screen.initialAppStart.InitialAppStartProgress();
            loc1.id = "progress";
            this.progress = loc1;
            feathers.binding.BindingManager.executeBindings(this, "progress", this.progress);
            return loc1;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.initialAppStart.InitialAppStart._watcherSetupUtil = arg1;
            return;
        }

        internal function _InitialAppStart_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialAppStart_LayoutGroup3_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _InitialAppStart_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "_InitialAppStart_LayoutGroup3";
            this._InitialAppStart_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialAppStart_LayoutGroup3", this._InitialAppStart_LayoutGroup3);
            return loc1;
        }

        public function ___InitialAppStart_CustomScreen1_creationComplete(arg1:starling.events.Event):void
        {
            this.onComplete();
            return;
        }

        internal function _InitialAppStart_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_SETTINGS_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "progress.width")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new frontend.screen.cloud.CloudViewBackgroundSkin();
            }, null, "holder.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "holder.width")
            result[4] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "footer.backgroundSkin")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "footer.layout")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "footer.width")
            result[7] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.RED);
            }, null, "_InitialAppStart_LayoutGroup3.backgroundSkin")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return 6 * SIGMALink.scaleFactor;
            }, null, "_InitialAppStart_LayoutGroup3.height")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialAppStart_LayoutGroup3.width")
            return result;
        }

        public function get footer():feathers.controls.LayoutGroup
        {
            return this._1268861541footer;
        }

        public var _InitialAppStart_LayoutGroup3:feathers.controls.LayoutGroup;

        internal var _1268861541footer:feathers.controls.LayoutGroup;

        internal var _1211707988holder:feathers.controls.LayoutGroup;

        internal var _1001078227progress:frontend.screen.initialAppStart.InitialAppStartProgress;

        public var isBackNavigation:Boolean=false;

        internal var _holderHeight:Number;

        internal var initialAppSettings:frontend.screen.initialAppStart.InitialAppSettings;

        internal var initialCloud:frontend.screen.initialAppStart.InitialCloudConnect;

        internal var initialDevice:frontend.screen.initialAppStart.InitialConnectDevice;

        internal var initialSocialNetworks:frontend.screen.initialAppStart.InitialSocialNetworkConnect;

        internal var initialStartComplete:frontend.screen.initialAppStart.InitialStartComplete;

        public static var FOOTER_HEIGHT:Number;

        internal static var _88356879PADDING:Number;

        internal static var BUTTON_HEIGHT:Number;

        internal var _20827610_currentStep:int=1;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;
    }
}


//  class InitialAppStartProgress
package frontend.screen.initialAppStart 
{
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class InitialAppStartProgress extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialAppStartProgress()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._InitialAppStartProgress_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialAppStartProgressWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return InitialAppStartProgress[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.addEventListener("initialize", this.___InitialAppStartProgress_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onInit():void
        {
            var loc1:*=null;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.drawBackground();
            loc1 = new starling.display.Quad(width, this.BOTTOM_GAP, core.general.Colors.LIGHTGREY);
            loc1.y = HEIGHT - this.BOTTOM_GAP;
            addChild(loc1);
            return;
        }

        internal function drawBackground():void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < this.steps) 
            {
                this.addBackgroundCircle(loc1);
                ++loc1;
            }
            this.addBackgroundBar();
            this.setCurrentStep(1);
            return;
        }

        internal function addBackgroundCircle(arg1:int):void
        {
            var loc1:*=new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.InitialStartCircleBackground));
            if (this.CIRCLE_WIDTH == 1) 
            {
                this.CIRCLE_WIDTH = loc1.width;
                this.circleGAP = width - 2 * this.GAP - this.steps * this.CIRCLE_WIDTH;
                this.circleGAP = this.circleGAP / (this.steps - 1);
            }
            loc1.x = this.getCircleX(arg1);
            loc1.y = this.getCircleY();
            addChild(loc1);
            return;
        }

        internal function getCircleX(arg1:int):Number
        {
            return this.GAP + arg1 * this.circleGAP + arg1 * this.CIRCLE_WIDTH;
        }

        internal function getCircleY():Number
        {
            return (height - this.BOTTOM_GAP - this.CIRCLE_WIDTH) / 2;
        }

        internal function drawForegroundCircle():void
        {
            var xTo:Number;
            var tween:starling.animation.Tween;

            var loc1:*;
            tween = null;
            xTo = this.getCircleX((_currentStep - 1));
            if (this._currentStepCircle) 
            {
                tween = new starling.animation.Tween(this._currentStepCircle, TWEEN_DURATION, starling.animation.Transitions.LINEAR);
                tween.animate("x", xTo);
                tween.onComplete = function ():void
                {
                    starling.core.Starling.juggler.remove(tween);
                    return;
                }
                starling.core.Starling.juggler.add(tween);
            }
            else 
            {
                this._currentStepCircle = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.InitialStartCircleForeground));
                this._currentStepCircle.x = xTo;
                this._currentStepCircle.y = this.getCircleY();
                addChild(this._currentStepCircle);
            }
            return;
        }

        internal function addBackgroundBar():void
        {
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.InitialStartRectBackground);
            var loc2:*=new flash.geom.Rectangle(1, 1, 2, 2);
            var loc3:*=new starling.display.Image(loc1);
            loc3.scale9Grid = loc2;
            loc3.width = width - 2 * this.GAP - this.CIRCLE_WIDTH;
            loc3.height = loc1.height;
            loc3.x = this.GAP + this.CIRCLE_WIDTH / 2;
            loc3.y = (height - this.BOTTOM_GAP - loc3.height) / 2;
            addChild(loc3);
            return;
        }

        public function setCurrentStep(arg1:int):void
        {
            _currentStep = arg1;
            this.drawForegroundCircle();
            return;
        }

        public function ___InitialAppStartProgress_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _InitialAppStartProgress_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return HEIGHT;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            InitialAppStartProgress._watcherSetupUtil = arg1;
            return;
        }

        
        {
            _currentStep = 1;
        }

        internal const BOTTOM_GAP:Number=20 * SIGMALink.scaleFactor;

        internal const GAP:Number=52 * SIGMALink.scaleFactor;

        internal const steps:int=4;

        public static const HEIGHT:Number=103 * SIGMALink.scaleFactor;

        public static const TWEEN_DURATION:Number=0.3;

        internal var CIRCLE_WIDTH:Number=1;

        internal var _currentStepCircle:starling.display.Image;

        internal var circleGAP:Number=1;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _currentStep:int=1;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class InitialCloudConnect
package frontend.screen.initialAppStart 
{
    import core.general.*;
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
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class InitialCloudConnect extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialCloudConnect()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._InitialCloudConnect_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialCloudConnectWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialCloudConnect[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._InitialCloudConnect_LayoutGroup2_i()];
            this.addEventListener("initialize", this.___InitialCloudConnect_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this.hl = new feathers.layout.HorizontalLayout();
            this.hl.gap = frontend.screen.initialAppStart.InitialAppStart.PADDING;
            this.hl.verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            this.vl = new feathers.layout.VerticalLayout();
            this.vl.gap = frontend.screen.initialAppStart.InitialAppStart.PADDING;
            return;
        }

        protected function onLinkTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*="https://www.youtube.com/watch?v=" + utils.LanguageManager.getString("YOUTUBE_SIGMA_CLOUD");
            flash.net.navigateToURL(new flash.net.URLRequest("https://www.youtube.com/watch?v=" + utils.LanguageManager.getString("YOUTUBE_SIGMA_CLOUD")), "_blank");
            return;
        }

        internal function _InitialCloudConnect_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialCloudConnect_ImageLoader1_i(), this._InitialCloudConnect_LayoutGroup3_i()];
            loc1.id = "_InitialCloudConnect_LayoutGroup2";
            this._InitialCloudConnect_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_LayoutGroup2", this._InitialCloudConnect_LayoutGroup2);
            return loc1;
        }

        internal function _InitialCloudConnect_ImageLoader1_i():feathers.controls.ImageLoader
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.id = "_InitialCloudConnect_ImageLoader1";
            this._InitialCloudConnect_ImageLoader1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_ImageLoader1", this._InitialCloudConnect_ImageLoader1);
            return loc1;
        }

        internal function _InitialCloudConnect_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialCloudConnect_Label1_i(), this._InitialCloudConnect_LayoutGroup4_i()];
            loc1.id = "_InitialCloudConnect_LayoutGroup3";
            this._InitialCloudConnect_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_LayoutGroup3", this._InitialCloudConnect_LayoutGroup3);
            return loc1;
        }

        internal function _InitialCloudConnect_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialCloudConnect_Label1";
            this._InitialCloudConnect_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_Label1", this._InitialCloudConnect_Label1);
            return loc1;
        }

        internal function _InitialCloudConnect_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.touchGroup = true;
            loc1.mxmlContent = [this._InitialCloudConnect_ImageLoader2_i(), this._InitialCloudConnect_Label2_i()];
            loc1.addEventListener("touch", this.___InitialCloudConnect_LayoutGroup4_touch);
            loc1.id = "_InitialCloudConnect_LayoutGroup4";
            this._InitialCloudConnect_LayoutGroup4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_LayoutGroup4", this._InitialCloudConnect_LayoutGroup4);
            return loc1;
        }

        internal function _InitialCloudConnect_ImageLoader2_i():feathers.controls.ImageLoader
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.id = "_InitialCloudConnect_ImageLoader2";
            this._InitialCloudConnect_ImageLoader2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_ImageLoader2", this._InitialCloudConnect_ImageLoader2);
            return loc1;
        }

        internal function _InitialCloudConnect_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialCloudConnect_Label2";
            this._InitialCloudConnect_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_Label2", this._InitialCloudConnect_Label2);
            return loc1;
        }

        public function ___InitialCloudConnect_LayoutGroup4_touch(arg1:starling.events.TouchEvent):void
        {
            this.onLinkTouch(arg1);
            return;
        }

        public function ___InitialCloudConnect_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _InitialCloudConnect_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_InitialCloudConnect_LayoutGroup2.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_InitialCloudConnect_LayoutGroup2.layout")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialCloudConnect_LayoutGroup2.width")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(2 * frontend.screen.initialAppStart.InitialAppStart.PADDING, NaN, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialCloudConnect_ImageLoader1.layoutData")
            result[4] = new feathers.binding.Binding(this, function ():Object
            {
                return frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.sigmacloudlogo);
            }, null, "_InitialCloudConnect_ImageLoader1.source")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return vl;
            }, null, "_InitialCloudConnect_LayoutGroup3.layout")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(100 * SIGMALink.scaleFactor, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialCloudConnect_LayoutGroup3.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialCloudConnect_LayoutGroup3.width")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_CLOUD_CONNECT_DESC");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialCloudConnect_Label1.text")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialCloudConnect_Label1.width")
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hl;
            }, null, "_InitialCloudConnect_LayoutGroup4.layout")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialCloudConnect_LayoutGroup4.width")
            result[12] = new feathers.binding.Binding(this, function ():Object
            {
                return frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.videoicon);
            }, null, "_InitialCloudConnect_ImageLoader2.source")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialCloudConnect_Label2.paddingRight")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialCloudConnect_Label2.styleName")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("VIDEO_LINK_TEXT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialCloudConnect_Label2.text")
            return result;
        }

        internal function get hl():feathers.layout.HorizontalLayout
        {
            return this._3332hl;
        }

        internal function set hl(arg1:feathers.layout.HorizontalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3332hl;
            if (loc1 !== arg1) 
            {
                this._3332hl = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hl", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get vl():feathers.layout.VerticalLayout
        {
            return this._3766vl;
        }

        internal function set vl(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3766vl;
            if (loc1 !== arg1) 
            {
                this._3766vl = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vl", loc1, arg1, this);
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
            frontend.screen.initialAppStart.InitialCloudConnect._watcherSetupUtil = arg1;
            return;
        }

        public var _InitialCloudConnect_ImageLoader1:feathers.controls.ImageLoader;

        public var _InitialCloudConnect_ImageLoader2:feathers.controls.ImageLoader;

        public var _InitialCloudConnect_Label1:feathers.controls.Label;

        public var _InitialCloudConnect_Label2:feathers.controls.Label;

        public var _InitialCloudConnect_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _InitialCloudConnect_LayoutGroup3:feathers.controls.LayoutGroup;

        public var _InitialCloudConnect_LayoutGroup4:feathers.controls.LayoutGroup;

        internal var _3332hl:feathers.layout.HorizontalLayout;

        internal var _3766vl:feathers.layout.VerticalLayout;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class InitialConnectDevice
package frontend.screen.initialAppStart 
{
    import core.general.*;
    import core.units.*;
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
    import frontend.screen.mydevices.components.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class InitialConnectDevice extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialConnectDevice()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._483870027_compHeight = height;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._InitialConnectDevice_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialConnectDeviceWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialConnectDevice[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._InitialConnectDevice_VerticalLayout1_c();
            this.mxmlContent = [this._InitialConnectDevice_LayoutGroup2_i(), this._InitialConnectDevice_PossibleDevicesList1_i(), this._InitialConnectDevice_AddNewDeviceComponent1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get headline():feathers.controls.LayoutGroup
        {
            return this._1115058732headline;
        }

        public function set headline(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1115058732headline;
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

        public function get possibleDevicesList():frontend.screen.mydevices.components.PossibleDevicesList
        {
            return this._916539158possibleDevicesList;
        }

        public function set possibleDevicesList(arg1:frontend.screen.mydevices.components.PossibleDevicesList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._916539158possibleDevicesList;
            if (loc1 !== arg1) 
            {
                this._916539158possibleDevicesList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "possibleDevicesList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _compHeight():Number
        {
            return this._483870027_compHeight;
        }

        internal function set _compHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._483870027_compHeight;
            if (loc1 !== arg1) 
            {
                this._483870027_compHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_compHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public override function set height(arg1:Number):void
        {
            debug.Debug.debug("[InitialConnectdevice.height] " + arg1);
            debug.Debug.debug("[headline.height] " + this.headline.height);
            super.height = arg1;
            this._compHeight = (arg1 - this.headline.height - 1);
            debug.Debug.debug("[_compHeight] " + this._compHeight);
            return;
        }

        internal function get _selectUnitState():Boolean
        {
            return this._2011851154_selectUnitState;
        }

        internal function set _selectUnitState(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2011851154_selectUnitState;
            if (loc1 !== arg1) 
            {
                this._2011851154_selectUnitState = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_selectUnitState", loc1, arg1, this);
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
            frontend.screen.initialAppStart.InitialConnectDevice._watcherSetupUtil = arg1;
            return;
        }

        protected function onHeadlineResize(arg1:starling.events.Event):void
        {
            this._compHeight = (height - this.headline.height - 1);
            return;
        }

        internal function onDeviceExistCallback():void
        {
            if (this.deviceExistsCallback != null) 
            {
                this.deviceExistsCallback();
            }
            return;
        }

        internal function onUnitSelectedCallback(arg1:core.units.Unit):void
        {
            if (arg1 != null) 
            {
                this._selectUnitState = false;
            }
            this.addDeviceComponent.unit = arg1;
            this.possibleDevicesList.validate();
            this.addDeviceComponent.validate();
            if (this.unitSelectedCallback != null) 
            {
                this.unitSelectedCallback(arg1);
            }
            return;
        }

        internal function onDeviceAddetCallback():void
        {
            if (this.deviceAddetCallback != null) 
            {
                this.deviceAddetCallback();
            }
            return;
        }

        public function showDeviceList():void
        {
            this._selectUnitState = true;
            this.possibleDevicesList.validate();
            this.addDeviceComponent.validate();
            return;
        }

        internal function _InitialConnectDevice_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            return loc1;
        }

        internal function _InitialConnectDevice_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialConnectDevice_Label1_i()];
            loc1.addEventListener("resize", this.__headline_resize);
            loc1.id = "headline";
            this.headline = loc1;
            feathers.binding.BindingManager.executeBindings(this, "headline", this.headline);
            return loc1;
        }

        internal function _InitialConnectDevice_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialConnectDevice_Label1";
            this._InitialConnectDevice_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialConnectDevice_Label1", this._InitialConnectDevice_Label1);
            return loc1;
        }

        public function __headline_resize(arg1:starling.events.Event):void
        {
            this.onHeadlineResize(arg1);
            return;
        }

        internal function _InitialConnectDevice_PossibleDevicesList1_i():frontend.screen.mydevices.components.PossibleDevicesList
        {
            var loc1:*=new frontend.screen.mydevices.components.PossibleDevicesList();
            loc1.callBack = this.onUnitSelectedCallback;
            loc1.id = "possibleDevicesList";
            this.possibleDevicesList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "possibleDevicesList", this.possibleDevicesList);
            return loc1;
        }

        internal function _InitialConnectDevice_AddNewDeviceComponent1_i():frontend.screen.mydevices.components.AddNewDeviceComponent
        {
            var loc1:*=new frontend.screen.mydevices.components.AddNewDeviceComponent();
            loc1.deviceAddetCallback = this.onDeviceAddetCallback;
            loc1.deviceExistsCallback = this.onDeviceExistCallback;
            loc1.useSmallLayout = true;
            loc1.id = "addDeviceComponent";
            this.addDeviceComponent = loc1;
            feathers.binding.BindingManager.executeBindings(this, "addDeviceComponent", this.addDeviceComponent);
            return loc1;
        }

        internal function _InitialConnectDevice_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "headline.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "headline.layout")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "headline.width")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(2 * frontend.screen.initialAppStart.InitialAppStart.PADDING, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialConnectDevice_Label1.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUVALUE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialConnectDevice_Label1.styleName")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_DEVICE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialConnectDevice_Label1.text")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialConnectDevice_Label1.width")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return _compHeight;
            }, null, "possibleDevicesList.height")
            result[9] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _selectUnitState;
            }, null, "possibleDevicesList.includeInLayout")
            result[10] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _selectUnitState;
            }, null, "possibleDevicesList.visible")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return _compHeight;
            }, null, "addDeviceComponent.height")
            result[12] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !_selectUnitState;
            }, null, "addDeviceComponent.includeInLayout")
            result[13] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !_selectUnitState;
            }, null, "addDeviceComponent.visible")
            return result;
        }

        public function get addDeviceComponent():frontend.screen.mydevices.components.AddNewDeviceComponent
        {
            return this._1192405094addDeviceComponent;
        }

        public function set addDeviceComponent(arg1:frontend.screen.mydevices.components.AddNewDeviceComponent):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1192405094addDeviceComponent;
            if (loc1 !== arg1) 
            {
                this._1192405094addDeviceComponent = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "addDeviceComponent", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var _InitialConnectDevice_Label1:feathers.controls.Label;

        internal var _1192405094addDeviceComponent:frontend.screen.mydevices.components.AddNewDeviceComponent;

        internal var _1115058732headline:feathers.controls.LayoutGroup;

        internal var _916539158possibleDevicesList:frontend.screen.mydevices.components.PossibleDevicesList;

        public var deviceAddetCallback:Function;

        public var deviceExistsCallback:Function;

        public var unitSelectedCallback:Function;

        internal var _483870027_compHeight:Number;

        internal var _2011851154_selectUnitState:Boolean=false;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class InitialSocialNetworkConnect
package frontend.screen.initialAppStart 
{
    import backend.oauth.*;
    import core.general.*;
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
    import frontend.components.menuList.*;
    import frontend.components.popup.oauth.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.appsettings.konten.*;
    import mx.core.*;
    import service.oauth.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class InitialSocialNetworkConnect extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialSocialNetworkConnect()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1449614849scrollerHeight = SIGMALink.containerHeight;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._InitialSocialNetworkConnect_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialSocialNetworkConnectWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialSocialNetworkConnect[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._InitialSocialNetworkConnect_LayoutGroup2_i(), this._InitialSocialNetworkConnect_CustomVScrollContainer1_i()];
            this.addEventListener("creationComplete", this.___InitialSocialNetworkConnect_LayoutGroup1_creationComplete);
            this.addEventListener("initialize", this.___InitialSocialNetworkConnect_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set stravaBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._411132575stravaBtn;
            if (loc1 !== arg1) 
            {
                this._411132575stravaBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "stravaBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get trainingPeaksBtn():frontend.components.menuList.MenuListItem
        {
            return this._1566496446trainingPeaksBtn;
        }

        public function set trainingPeaksBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1566496446trainingPeaksBtn;
            if (loc1 !== arg1) 
            {
                this._1566496446trainingPeaksBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "trainingPeaksBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get twitterBtn():frontend.components.menuList.MenuListItem
        {
            return this._59022615twitterBtn;
        }

        public function set twitterBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._59022615twitterBtn;
            if (loc1 !== arg1) 
            {
                this._59022615twitterBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "twitterBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get twoPeakBtn():frontend.components.menuList.MenuListItem
        {
            return this._510796527twoPeakBtn;
        }

        public function set twoPeakBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._510796527twoPeakBtn;
            if (loc1 !== arg1) 
            {
                this._510796527twoPeakBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "twoPeakBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get hl():feathers.layout.HorizontalLayout
        {
            return this._3332hl;
        }

        internal function addEvents(arg1:service.oauth.CommonOAuth):void
        {
            arg1.addEventListener(service.oauth.CommonOAuth.LOGGED_OUT, this.onLoggedOut);
            arg1.addEventListener(service.oauth.CommonOAuth.LOGGED_IN, this.onLoggedIn);
            return;
        }

        internal function set hl(arg1:feathers.layout.HorizontalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3332hl;
            if (loc1 !== arg1) 
            {
                this._3332hl = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hl", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get scrollerHeight():Number
        {
            return this._1449614849scrollerHeight;
        }

        internal function set scrollerHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1449614849scrollerHeight;
            if (loc1 !== arg1) 
            {
                this._1449614849scrollerHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scrollerHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get vl():feathers.layout.VerticalLayout
        {
            return this._3766vl;
        }

        internal function set vl(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3766vl;
            if (loc1 !== arg1) 
            {
                this._3766vl = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vl", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get vl2():feathers.layout.VerticalLayout
        {
            return this._116796vl2;
        }

        internal function set vl2(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._116796vl2;
            if (loc1 !== arg1) 
            {
                this._116796vl2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vl2", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this.hl = new feathers.layout.HorizontalLayout();
            this.hl.gap = frontend.screen.initialAppStart.InitialAppStart.PADDING;
            this.hl.verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            this.vl = new feathers.layout.VerticalLayout();
            this.vl.gap = frontend.screen.initialAppStart.InitialAppStart.PADDING;
            frontend.screen.appsettings.konten.ASKonten.validateTexture(this.stravaBtn);
            frontend.screen.appsettings.konten.ASKonten.validateTexture(this.trainingPeaksBtn);
            frontend.screen.appsettings.konten.ASKonten.validateTexture(this.twoPeakBtn);
            frontend.screen.appsettings.konten.ASKonten.validateTexture(this.facebookBtn);
            frontend.screen.appsettings.konten.ASKonten.validateTexture(this.twitterBtn);
            this.addEvents(backend.oauth.StravaOAuth.getInstance());
            this.addEvents(backend.oauth.TrainingPeaksOAuth.getInstance());
            this.addEvents(backend.oauth.TwoPeakOAuth.getInstance());
            this.addEvents(backend.oauth.FacebookGoViralHandler.getInstance());
            this.addEvents(backend.oauth.TwitterOAuth.getInstance());
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.initialAppStart.InitialSocialNetworkConnect._watcherSetupUtil = arg1;
            return;
        }

        internal function onLoggedIn(arg1:flash.events.Event):void
        {
            var loc1:*=this.resolveBtn(arg1.currentTarget as frontend.components.popup.oauth.CustomOAuth);
            frontend.screen.appsettings.konten.ASKonten.validateTexture(loc1);
            loc1.hasTouchEvents = true;
            return;
        }

        internal function onLoggedOut(arg1:flash.events.Event):void
        {
            var loc1:*=this.resolveBtn(arg1.currentTarget as frontend.components.popup.oauth.CustomOAuth);
            frontend.screen.appsettings.konten.ASKonten.validateTexture(loc1);
            loc1.hasTouchEvents = false;
            return;
        }

        internal function resolveBtn(arg1:frontend.components.popup.oauth.CustomOAuth):frontend.components.menuList.MenuListItem
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case backend.oauth.StravaOAuth.getInstance():
                {
                    loc1 = this.stravaBtn;
                    break;
                }
                case backend.oauth.TrainingPeaksOAuth.getInstance():
                {
                    loc1 = this.trainingPeaksBtn;
                    break;
                }
                case backend.oauth.TwoPeakOAuth.getInstance():
                {
                    loc1 = this.twoPeakBtn;
                    break;
                }
                case backend.oauth.FacebookGoViralHandler.getInstance():
                {
                    loc1 = this.facebookBtn;
                    break;
                }
                case backend.oauth.TwitterOAuth.getInstance():
                {
                    loc1 = this.twitterBtn;
                    break;
                }
            }
            return loc1;
        }

        protected function onComplete(arg1:starling.events.Event):void
        {
            this.headerGroup.validate();
            this.descLabel.validate();
            this.scrollerHeight = SIGMALink.containerHeight - this.headerGroup.height - this.descLabel.height - this.vl.gap;
            return;
        }

        internal function _InitialSocialNetworkConnect_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialSocialNetworkConnect_LayoutGroup3_i(), this._InitialSocialNetworkConnect_Label2_i()];
            loc1.id = "_InitialSocialNetworkConnect_LayoutGroup2";
            this._InitialSocialNetworkConnect_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialSocialNetworkConnect_LayoutGroup2", this._InitialSocialNetworkConnect_LayoutGroup2);
            return loc1;
        }

        internal function _InitialSocialNetworkConnect_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialSocialNetworkConnect_ImageLoader1_i(), this._InitialSocialNetworkConnect_Label1_i()];
            loc1.id = "headerGroup";
            this.headerGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "headerGroup", this.headerGroup);
            return loc1;
        }

        internal function _InitialSocialNetworkConnect_ImageLoader1_i():feathers.controls.ImageLoader
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.id = "_InitialSocialNetworkConnect_ImageLoader1";
            this._InitialSocialNetworkConnect_ImageLoader1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialSocialNetworkConnect_ImageLoader1", this._InitialSocialNetworkConnect_ImageLoader1);
            return loc1;
        }

        internal function _InitialSocialNetworkConnect_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialSocialNetworkConnect_Label1";
            this._InitialSocialNetworkConnect_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialSocialNetworkConnect_Label1", this._InitialSocialNetworkConnect_Label1);
            return loc1;
        }

        internal function _InitialSocialNetworkConnect_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "descLabel";
            this.descLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "descLabel", this.descLabel);
            return loc1;
        }

        internal function _InitialSocialNetworkConnect_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._InitialSocialNetworkConnect_MenuList1_i()];
            loc1.id = "list";
            this.list = loc1;
            feathers.binding.BindingManager.executeBindings(this, "list", this.list);
            return loc1;
        }

        internal function _InitialSocialNetworkConnect_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._InitialSocialNetworkConnect_MenuListItem1_i(), this._InitialSocialNetworkConnect_MenuListItem2_i(), this._InitialSocialNetworkConnect_MenuListItem3_i(), this._InitialSocialNetworkConnect_MenuListItem4_i(), this._InitialSocialNetworkConnect_MenuListItem5_i()];
            loc1.id = "_InitialSocialNetworkConnect_MenuList1";
            this._InitialSocialNetworkConnect_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialSocialNetworkConnect_MenuList1", this._InitialSocialNetworkConnect_MenuList1);
            return loc1;
        }

        internal function _InitialSocialNetworkConnect_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.STRAVA.TITLE";
            loc1.addEventListener("touch", this.__stravaBtn_touch);
            loc1.id = "stravaBtn";
            this.stravaBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "stravaBtn", this.stravaBtn);
            return loc1;
        }

        public function __stravaBtn_touch(arg1:starling.events.TouchEvent):void
        {
            frontend.screen.appsettings.konten.ASKonten.onTouch(arg1);
            return;
        }

        internal function _InitialSocialNetworkConnect_MenuListItem2_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.TRAININGPEAKS.TITLE";
            loc1.addEventListener("touch", this.__trainingPeaksBtn_touch);
            loc1.id = "trainingPeaksBtn";
            this.trainingPeaksBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "trainingPeaksBtn", this.trainingPeaksBtn);
            return loc1;
        }

        public function __trainingPeaksBtn_touch(arg1:starling.events.TouchEvent):void
        {
            frontend.screen.appsettings.konten.ASKonten.onTouch(arg1);
            return;
        }

        internal function _InitialSocialNetworkConnect_MenuListItem3_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.TWOPEAK.TITLE";
            loc1.addEventListener("touch", this.__twoPeakBtn_touch);
            loc1.id = "twoPeakBtn";
            this.twoPeakBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "twoPeakBtn", this.twoPeakBtn);
            return loc1;
        }

        public function __twoPeakBtn_touch(arg1:starling.events.TouchEvent):void
        {
            frontend.screen.appsettings.konten.ASKonten.onTouch(arg1);
            return;
        }

        internal function _InitialSocialNetworkConnect_MenuListItem4_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.FACEBOOK.TITLE";
            loc1.addEventListener("touch", this.__facebookBtn_touch);
            loc1.id = "facebookBtn";
            this.facebookBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "facebookBtn", this.facebookBtn);
            return loc1;
        }

        public function __facebookBtn_touch(arg1:starling.events.TouchEvent):void
        {
            frontend.screen.appsettings.konten.ASKonten.onTouch(arg1);
            return;
        }

        internal function _InitialSocialNetworkConnect_MenuListItem5_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.TWITTER.TITLE";
            loc1.addEventListener("touch", this.__twitterBtn_touch);
            loc1.id = "twitterBtn";
            this.twitterBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "twitterBtn", this.twitterBtn);
            return loc1;
        }

        public function __twitterBtn_touch(arg1:starling.events.TouchEvent):void
        {
            frontend.screen.appsettings.konten.ASKonten.onTouch(arg1);
            return;
        }

        public function ___InitialSocialNetworkConnect_LayoutGroup1_creationComplete(arg1:starling.events.Event):void
        {
            this.onComplete(arg1);
            return;
        }

        public function ___InitialSocialNetworkConnect_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _InitialSocialNetworkConnect_bindingsSetup():Array
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
                return vl;
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_InitialSocialNetworkConnect_LayoutGroup2.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_InitialSocialNetworkConnect_LayoutGroup2.layout")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialSocialNetworkConnect_LayoutGroup2.width")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hl;
            }, null, "headerGroup.layout")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(2 * frontend.screen.initialAppStart.InitialAppStart.PADDING, NaN, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "headerGroup.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "headerGroup.width")
            result[8] = new feathers.binding.Binding(this, function ():Object
            {
                return frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.shareiconred);
            }, null, "_InitialSocialNetworkConnect_ImageLoader1.source")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialSocialNetworkConnect_Label1.paddingRight")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialSocialNetworkConnect_Label1.styleName")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_SOCIAL_NETWORKS");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialSocialNetworkConnect_Label1.text")
            result[12] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(100 * SIGMALink.scaleFactor, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "descLabel.layoutData")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_SOCIAL_NETWORKS_DESC");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "descLabel.text")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "descLabel.width")
            result[15] = new feathers.binding.Binding(this, function ():Number
            {
                return scrollerHeight;
            }, null, "list.height")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "list.width")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialSocialNetworkConnect_MenuList1.width")
            result[18] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.StravaOAuth.getInstance().loggedOut;
            }, null, "stravaBtn.hasTouchEvents")
            result[19] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.StravaOAuth.getInstance();
            }, null, "stravaBtn.helperObject")
            result[20] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "stravaBtn.minItemHeight")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "stravaBtn.type")
            result[22] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.TrainingPeaksOAuth.getInstance().loggedOut;
            }, null, "trainingPeaksBtn.hasTouchEvents")
            result[23] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.TrainingPeaksOAuth.getInstance();
            }, null, "trainingPeaksBtn.helperObject")
            result[24] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "trainingPeaksBtn.minItemHeight")
            result[25] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainingPeaksBtn.type")
            result[26] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.TwoPeakOAuth.getInstance().loggedOut;
            }, null, "twoPeakBtn.hasTouchEvents")
            result[27] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.TwoPeakOAuth.getInstance();
            }, null, "twoPeakBtn.helperObject")
            result[28] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "twoPeakBtn.minItemHeight")
            result[29] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twoPeakBtn.type")
            result[30] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.FacebookGoViralHandler.getInstance().loggedOut;
            }, null, "facebookBtn.hasTouchEvents")
            result[31] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.FacebookGoViralHandler.getInstance();
            }, null, "facebookBtn.helperObject")
            result[32] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "facebookBtn.minItemHeight")
            result[33] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "facebookBtn.type")
            result[34] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.TwitterOAuth.getInstance().loggedOut;
            }, null, "twitterBtn.hasTouchEvents")
            result[35] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.TwitterOAuth.getInstance();
            }, null, "twitterBtn.helperObject")
            result[36] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "twitterBtn.minItemHeight")
            result[37] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twitterBtn.type")
            return result;
        }

        public function get descLabel():feathers.controls.Label
        {
            return this._1464533731descLabel;
        }

        public function set descLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1464533731descLabel;
            if (loc1 !== arg1) 
            {
                this._1464533731descLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "descLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get facebookBtn():frontend.components.menuList.MenuListItem
        {
            return this._958082486facebookBtn;
        }

        public function set facebookBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._958082486facebookBtn;
            if (loc1 !== arg1) 
            {
                this._958082486facebookBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "facebookBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get headerGroup():feathers.controls.LayoutGroup
        {
            return this._1161933810headerGroup;
        }

        public function set headerGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1161933810headerGroup;
            if (loc1 !== arg1) 
            {
                this._1161933810headerGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headerGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get list():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._3322014list;
        }

        public function set list(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3322014list;
            if (loc1 !== arg1) 
            {
                this._3322014list = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "list", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get stravaBtn():frontend.components.menuList.MenuListItem
        {
            return this._411132575stravaBtn;
        }

        public var _InitialSocialNetworkConnect_ImageLoader1:feathers.controls.ImageLoader;

        public var _InitialSocialNetworkConnect_Label1:feathers.controls.Label;

        public var _InitialSocialNetworkConnect_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _InitialSocialNetworkConnect_MenuList1:frontend.components.menuList.MenuList;

        internal var _1464533731descLabel:feathers.controls.Label;

        internal var _958082486facebookBtn:frontend.components.menuList.MenuListItem;

        internal var _1161933810headerGroup:feathers.controls.LayoutGroup;

        internal var _3322014list:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _1566496446trainingPeaksBtn:frontend.components.menuList.MenuListItem;

        internal var _59022615twitterBtn:frontend.components.menuList.MenuListItem;

        internal var _510796527twoPeakBtn:frontend.components.menuList.MenuListItem;

        internal var _3332hl:feathers.layout.HorizontalLayout;

        internal var _1449614849scrollerHeight:Number;

        internal var _3766vl:feathers.layout.VerticalLayout;

        internal var _116796vl2:feathers.layout.VerticalLayout;

        internal var _411132575stravaBtn:frontend.components.menuList.MenuListItem;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class InitialStartComplete
package frontend.screen.initialAppStart 
{
    import core.general.*;
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
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class InitialStartComplete extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialStartComplete()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._InitialStartComplete_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialStartCompleteWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialStartComplete[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._InitialStartComplete_LayoutGroup2_i()];
            this.addEventListener("initialize", this.___InitialStartComplete_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this.vl = new feathers.layout.VerticalLayout();
            this.vl.gap = frontend.screen.initialAppStart.InitialAppStart.PADDING;
            return;
        }

        internal function _InitialStartComplete_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialStartComplete_Label1_i(), this._InitialStartComplete_LayoutGroup3_i()];
            loc1.id = "_InitialStartComplete_LayoutGroup2";
            this._InitialStartComplete_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_LayoutGroup2", this._InitialStartComplete_LayoutGroup2);
            return loc1;
        }

        internal function _InitialStartComplete_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialStartComplete_Label1";
            this._InitialStartComplete_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_Label1", this._InitialStartComplete_Label1);
            return loc1;
        }

        internal function _InitialStartComplete_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialStartComplete_Label2_i(), this._InitialStartComplete_Label3_i()];
            loc1.id = "_InitialStartComplete_LayoutGroup3";
            this._InitialStartComplete_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_LayoutGroup3", this._InitialStartComplete_LayoutGroup3);
            return loc1;
        }

        internal function _InitialStartComplete_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialStartComplete_Label2";
            this._InitialStartComplete_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_Label2", this._InitialStartComplete_Label2);
            return loc1;
        }

        internal function _InitialStartComplete_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialStartComplete_Label3";
            this._InitialStartComplete_Label3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_Label3", this._InitialStartComplete_Label3);
            return loc1;
        }

        public function ___InitialStartComplete_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _InitialStartComplete_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return vl;
            }, null, "this.layout")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_InitialStartComplete_LayoutGroup2.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_InitialStartComplete_LayoutGroup2.layout")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialStartComplete_LayoutGroup2.width")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(2 * frontend.screen.initialAppStart.InitialAppStart.PADDING, NaN, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialStartComplete_Label1.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUVALUE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialStartComplete_Label1.styleName")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_HEADLINE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialStartComplete_Label1.text")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialStartComplete_Label1.width")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return vl;
            }, null, "_InitialStartComplete_LayoutGroup3.layout")
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(100 * SIGMALink.scaleFactor, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialStartComplete_LayoutGroup3.layoutData")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialStartComplete_LayoutGroup3.width")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_TEXT_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialStartComplete_Label2.text")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialStartComplete_Label2.width")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_TEXT_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialStartComplete_Label3.text")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialStartComplete_Label3.width")
            return result;
        }

        internal function get vl():feathers.layout.VerticalLayout
        {
            return this._3766vl;
        }

        internal function set vl(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3766vl;
            if (loc1 !== arg1) 
            {
                this._3766vl = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vl", loc1, arg1, this);
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
            frontend.screen.initialAppStart.InitialStartComplete._watcherSetupUtil = arg1;
            return;
        }

        public var _InitialStartComplete_Label1:feathers.controls.Label;

        public var _InitialStartComplete_Label2:feathers.controls.Label;

        public var _InitialStartComplete_Label3:feathers.controls.Label;

        public var _InitialStartComplete_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _InitialStartComplete_LayoutGroup3:feathers.controls.LayoutGroup;

        internal var _3766vl:feathers.layout.VerticalLayout;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


