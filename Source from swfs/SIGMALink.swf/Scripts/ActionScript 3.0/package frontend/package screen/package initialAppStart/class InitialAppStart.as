//class InitialAppStart
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


