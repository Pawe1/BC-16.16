//package cloud
//  class CloudView
package frontend.screen.cloud 
{
    import backend.oauth.*;
    import backend.utils.*;
    import configCache.*;
    import core.general.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
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
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import service.cloud.*;
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
    import utils.formatter.*;
    
    use namespace mx_internal;
    
    public class CloudView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function CloudView()
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
            bindings = this._CloudView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_cloud_CloudViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.cloud.CloudView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._CloudView_LayoutGroup1_i(), this._CloudView_LayoutGroup3_i(), this._CloudView_LayoutGroup4_i(), this._CloudView_Footer1_i()];
            this._CloudView_AnchorLayoutData1_i();
            this._CloudView_Button1_i();
            this._CloudView_AnchorLayoutData4_i();
            this._CloudView_Button4_i();
            this._CloudView_Button2_i();
            this._CloudView_AnchorLayoutData2_i();
            this._CloudView_AnchorLayoutData3_i();
            this._CloudView_AnchorLayoutData5_i();
            this._CloudView_Label1_i();
            this._CloudView_Button3_i();
            this._CloudView_AnchorLayoutData6_i();
            this._CloudView_MenuListItem1_i();
            this.addEventListener("addedToStage", this.___CloudView_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___CloudView_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get registerBtn():feathers.controls.Button
        {
            return this._2133315399registerBtn;
        }

        public function set registerBtn(arg1:feathers.controls.Button):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2133315399registerBtn;
            if (loc1 !== arg1) 
            {
                this._2133315399registerBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "registerBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get rightBtnLayout():feathers.layout.AnchorLayoutData
        {
            return this._1023749610rightBtnLayout;
        }

        public function set rightBtnLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1023749610rightBtnLayout;
            if (loc1 !== arg1) 
            {
                this._1023749610rightBtnLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "rightBtnLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get shapeLayout():feathers.layout.AnchorLayoutData
        {
            return this._655964715shapeLayout;
        }

        public function set shapeLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._655964715shapeLayout;
            if (loc1 !== arg1) 
            {
                this._655964715shapeLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "shapeLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get statusGroup():feathers.controls.LayoutGroup
        {
            return this._913416787statusGroup;
        }

        public function set statusGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._913416787statusGroup;
            if (loc1 !== arg1) 
            {
                this._913416787statusGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "statusGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get statusGroupLayout():feathers.layout.AnchorLayoutData
        {
            return this._781545673statusGroupLayout;
        }

        public function set statusGroupLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._781545673statusGroupLayout;
            if (loc1 !== arg1) 
            {
                this._781545673statusGroupLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "statusGroupLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get statusText():feathers.controls.Label
        {
            return this._248004671statusText;
        }

        public function set statusText(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._248004671statusText;
            if (loc1 !== arg1) 
            {
                this._248004671statusText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "statusText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get syncBtn():feathers.controls.Button
        {
            return this._1742528063syncBtn;
        }

        public function set syncBtn(arg1:feathers.controls.Button):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1742528063syncBtn;
            if (loc1 !== arg1) 
            {
                this._1742528063syncBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "syncBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function validateState(arg1:flash.events.Event=null):void
        {
            var loc1:*=this._currentState;
            if (handler.ApplicationHandler.isSimulator) 
            {
                if (backend.oauth.SigmaOAuth.getInstance().loggedOut) 
                {
                    this._currentState = LOGGED_OUT;
                }
                else if (handler.CloudHandler.getInstance().syncRunning) 
                {
                    this._currentState = SYNC_RUNNING;
                }
                else 
                {
                    this._currentState = SYNC_COMPLETE;
                }
            }
            else if (handler.NetworkCommunicationHandler.online) 
            {
                if (backend.oauth.SigmaOAuth.getInstance().loggedOut) 
                {
                    this._currentState = LOGGED_OUT;
                }
                else if (handler.CloudHandler.getInstance().syncRunning) 
                {
                    this._currentState = SYNC_RUNNING;
                }
                else 
                {
                    this._currentState = SYNC_COMPLETE;
                }
            }
            else 
            {
                this._currentState = NOT_CONNECTED;
            }
            debug.Debug.debug("CloudView state: " + this._currentState);
            if (loc1 != this._currentState) 
            {
                setInvalidationFlag(INVALIDATION_FLAG_STATE);
                setInvalidationFlag(INVALIDATION_FLAG_STYLES);
                this.draw();
            }
            return;
        }

        public function get verticalCenterLayout():feathers.layout.AnchorLayoutData
        {
            return this._1906678389verticalCenterLayout;
        }

        public function set verticalCenterLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1906678389verticalCenterLayout;
            if (loc1 !== arg1) 
            {
                this._1906678389verticalCenterLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "verticalCenterLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get wifiOption():frontend.components.menuList.MenuListItem
        {
            return this._25870314wifiOption;
        }

        public function set wifiOption(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._25870314wifiOption;
            if (loc1 !== arg1) 
            {
                this._25870314wifiOption = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "wifiOption", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static function statusTextCenterRenderer():feathers.core.ITextRenderer
        {
            var loc1:*=new feathers.controls.text.TextFieldTextRenderer();
            loc1.textFormat = new flash.text.TextFormat(feathers.themes.BaseSIGMATheme.FONT_NAME_ARIAL, 22 * SIGMALink.scaleFactor, core.general.Colors.WHITE);
            loc1.textFormat.align = flash.text.TextFormatAlign.CENTER;
            loc1.wordWrap = true;
            loc1.antiAliasType = flash.text.AntiAliasType.NORMAL;
            return loc1;
        }

        internal static function statusTextLeftRenderer():feathers.core.ITextRenderer
        {
            var loc1:*=new feathers.controls.text.TextFieldTextRenderer();
            loc1.textFormat = new flash.text.TextFormat(feathers.themes.BaseSIGMATheme.FONT_NAME_ARIAL, 22 * SIGMALink.scaleFactor, core.general.Colors.WHITE);
            loc1.textFormat.align = flash.text.TextFormatAlign.LEFT;
            loc1.wordWrap = true;
            loc1.antiAliasType = flash.text.AntiAliasType.NORMAL;
            return loc1;
        }

        public static function checkLogin(arg1:Boolean=false):void
        {
            if (handler.NetworkCommunicationHandler.online) 
            {
                backend.oauth.SigmaOAuth.getInstance().checkLogin(starling.core.Starling.current.nativeOverlay.stage, arg1);
            }
            return;
        }

        internal function onInit():void
        {
            handler.NetworkCommunicationHandler.getInstance().addEventListener(handler.NetworkCommunicationHandler.NETWORK_CHANGE, this.onNetworkStatusChanged);
            backend.oauth.SigmaOAuth.getInstance().addEventListener(service.oauth.CommonOAuth.LOGGED_IN, this.onLoggedIn);
            backend.oauth.SigmaOAuth.getInstance().addEventListener(service.oauth.CommonOAuth.LOGGED_OUT, this.onLoggedOut);
            if (!backend.oauth.SigmaOAuth.getInstance().loggedOut) 
            {
                this.addCloudEvents();
            }
            return;
        }

        internal function onAddedToStage():void
        {
            this.validateState();
            if (this._currentState == SYNC_RUNNING) 
            {
                this.draw();
                this.onTypeSyncStarted();
            }
            return;
        }

        internal function onLoggedIn(arg1:flash.events.Event=null):void
        {
            this.addCloudEvents();
            this.validateState();
            return;
        }

        internal function onLoggedOut(arg1:flash.events.Event=null):void
        {
            this.removeCloudEvents();
            this.validateState();
            return;
        }

        internal function onNetworkStatusChanged(arg1:flash.events.Event=null):void
        {
            this.validateState();
            if (handler.NetworkCommunicationHandler.online) 
            {
                if (backend.oauth.SigmaOAuth.getInstance().loggedOut) 
                {
                    checkLogin(false);
                }
                else 
                {
                    handler.CloudHandler.getInstance().startManualSync();
                }
            }
            else if (handler.CloudHandler.getInstance().syncRunning) 
            {
                handler.CloudHandler.getInstance().stopSync();
            }
            return;
        }

        internal function addCloudEvents():void
        {
            service.cloud.CommonCloudHandler.getInstance().addEventListener(service.cloud.CloudEvent.START_SYNC, this.onTypeSyncStarted);
            service.cloud.CommonCloudHandler.getInstance().addEventListener(service.cloud.CloudConfig.SYNC_STARTED, this.validateState);
            service.cloud.CommonCloudHandler.getInstance().addEventListener(service.cloud.CloudConfig.SYNC_COMPLETE, this.validateState);
            service.cloud.CommonCloudHandler.getInstance().addEventListener(service.cloud.CloudConfig.SYNC_END, this.validateState);
            service.cloud.CommonCloudHandler.getInstance().addEventListener(service.cloud.CloudEvent.PROGRESS, this.validateProgress);
            return;
        }

        internal function removeCloudEvents():void
        {
            service.cloud.CommonCloudHandler.getInstance().removeEventListener(service.cloud.CloudEvent.START_SYNC, this.onTypeSyncStarted);
            service.cloud.CommonCloudHandler.getInstance().removeEventListener(service.cloud.CloudConfig.SYNC_STARTED, this.validateState);
            service.cloud.CommonCloudHandler.getInstance().removeEventListener(service.cloud.CloudConfig.SYNC_COMPLETE, this.validateState);
            service.cloud.CommonCloudHandler.getInstance().removeEventListener(service.cloud.CloudConfig.SYNC_END, this.validateState);
            service.cloud.CommonCloudHandler.getInstance().removeEventListener(service.cloud.CloudEvent.PROGRESS, this.validateProgress);
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.cloud.CloudView._watcherSetupUtil = arg1;
            return;
        }

        internal function login(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (!handler.ConnectionHandler.checkNoInternetPopUp()) 
            {
                return;
            }
            checkLogin(true);
            return;
        }

        internal function register(arg1:starling.events.TouchEvent):void
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

        internal function logout(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (!handler.ConnectionHandler.checkNoInternetPopUp()) 
            {
                return;
            }
            backend.oauth.SigmaOAuth.getInstance().logout();
            return;
        }

        internal function sync(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (!handler.ConnectionHandler.checkNoInternetPopUp()) 
            {
                return;
            }
            handler.CloudHandler.getInstance().startManualSync();
            return;
        }

        protected override function draw():void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            super.draw();
            this.content.backgroundSkin = new frontend.screen.cloud.CloudViewBackgroundSkin();
            this.buttons.removeChildren();
            this.options.removeChildren();
            this.statusGroup.removeChildren();
            this.statusText.width = this.redShape.width - 30 * SIGMALink.scaleFactor;
            this.statusText.maxWidth = this.redShape.width;
            var loc1:*=false;
            var loc2:*=false;
            var loc8:*=this._currentState;
            switch (loc8) 
            {
                case LOGGED_OUT:
                {
                    this.removeMovie();
                    this.statusText.textRendererFactory = statusTextLeftRenderer;
                    this.statusText.text = utils.LanguageManager.getString("CLOUDVIEW.DESCRIPTION_LOGGED_OUT");
                    this.buttons.addChild(this.loginBtn);
                    this.buttons.addChild(this.registerBtn);
                    break;
                }
                case SYNC_COMPLETE:
                {
                    this.createOrStopMovie();
                    loc1 = false;
                    loc2 = true;
                    this.statusText.textRendererFactory = statusTextCenterRenderer;
                    this.statusText.text = utils.LanguageManager.getString("CLOUDVIEW.DESCRIPTION_SYNC_COMPLETE");
                    loc3 = new Date();
                    loc4 = configCache.ConfigCache.getInstance().configCacheObject.lastSyncDate();
                    loc3.setTime(loc4 + configCache.ConfigCache.getSyncDateCorrection());
                    loc5 = new utils.formatter.DateFormatterMx();
                    loc5.formatString = backend.utils.DataUtils.dateFormatter.formatString + " - " + backend.utils.DataUtils.clockFormat;
                    this.statusText.text = this.statusText.text + ("\n" + loc5.format(loc3));
                    this.syncBtn.isEnabled = true;
                    this.buttons.addChild(this.syncBtn);
                    this.buttons.addChild(this.logoutBtn);
                    break;
                }
                case SYNC_RUNNING:
                {
                    this.createOrStopMovie();
                    loc1 = true;
                    loc2 = true;
                    this.statusText.textRendererFactory = statusTextCenterRenderer;
                    this.updateStatus(-1);
                    this.syncBtn.isEnabled = false;
                    this.buttons.addChild(this.syncBtn);
                    this.buttons.addChild(this.logoutBtn);
                    break;
                }
                case NOT_CONNECTED:
                {
                    loc1 = false;
                    loc2 = true;
                    this.statusText.textRendererFactory = statusTextCenterRenderer;
                    this.statusText.text = utils.LanguageManager.getString("CLOUDVIEW.DESCRIPTION_NO_INTERNET");
                    this.syncBtn.isEnabled = false;
                }
            }
            if (this.buttons.numChildren > 0) 
            {
                this.buttons.visible = true;
                this.buttons.includeInLayout = true;
                this.buttons.y = SIGMALink.appHeight - SIGMALink.headerHeight - this.footer.height - this.buttons.height;
                this.buttons.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            }
            else 
            {
                this.buttons.visible = false;
                this.buttons.includeInLayout = false;
            }
            if (loc2) 
            {
                this.options.visible = true;
                this.options.includeInLayout = true;
                this.options.addChild(this.wifiOption);
                loc6 = new starling.display.Quad(SIGMALink.appWidth, 1, 10066329);
                this.options.addChild(loc6);
                this.options.y = this.buttons.visible ? this.buttons.y - this.options.height : SIGMALink.appHeight - SIGMALink.headerHeight - this.footer.height - this.buttons.height;
                this.options.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
                if (this.buttons.visible) 
                {
                    loc7 = new starling.display.Quad(SIGMALink.appWidth, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
                    loc7.y = this.options.height - loc7.height;
                    this.options.addChild(loc7);
                }
            }
            else 
            {
                this.options.visible = false;
                this.options.includeInLayout = false;
                this.options.backgroundSkin = null;
            }
            if (this._currentState != NOT_CONNECTED) 
            {
                if (this.movie) 
                {
                    this.statusGroup.addChild(this.movie);
                    if (loc1) 
                    {
                        this.movie.play();
                        if (!starling.core.Starling.juggler.contains(this.movie)) 
                        {
                            starling.core.Starling.juggler.add(this.movie);
                        }
                    }
                }
            }
            this.statusGroup.addChild(this.statusText);
            return;
        }

        internal function removeMovie():void
        {
            if (this.movie) 
            {
                this.movie.stop();
                if (starling.core.Starling.juggler.contains(this.movie)) 
                {
                    starling.core.Starling.juggler.remove(this.movie);
                }
                this.movie = null;
            }
            return;
        }

        internal function createOrStopMovie():void
        {
            var loc1:*=null;
            if (this.movie) 
            {
                this.movie.stop();
            }
            else 
            {
                loc1 = frontend.AssetsManagerCustom.getInstance().getTextureAtlas("cloudAnimation");
                if (loc1) 
                {
                    this.movie = new starling.display.MovieClip(loc1.getTextures("frame_"), 30);
                }
            }
            return;
        }

        internal function onTypeSyncStarted(arg1:service.cloud.CloudEvent=null):void
        {
            this.draw();
            return;
        }

        internal function validateProgress(arg1:service.cloud.CloudEvent):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            if (this._currentState == LOGGED_OUT || this._currentState == NOT_CONNECTED) 
            {
                return;
            }
            if ((arg1 as service.cloud.CloudEvent).syncStatus) 
            {
                loc1 = (arg1 as service.cloud.CloudEvent).syncStatus[0] + (arg1 as service.cloud.CloudEvent).syncStatus[2] + (arg1 as service.cloud.CloudEvent).syncStatus[4];
                loc2 = (arg1 as service.cloud.CloudEvent).syncStatus[1] + (arg1 as service.cloud.CloudEvent).syncStatus[3] + (arg1 as service.cloud.CloudEvent).syncStatus[5];
                loc3 = loc1 - loc2;
                this.updateStatus(loc3);
            }
            return;
        }

        internal function updateStatus(arg1:int):void
        {
            var loc1:*=utils.LanguageManager.getString("CLOUDVIEW.PROGRESS");
            if (arg1 == -1) 
            {
                loc1 = loc1.replace("##num", "");
            }
            else 
            {
                loc1 = loc1.replace("##num", arg1);
            }
            loc1 = loc1.replace("##data", handler.CloudHandler.getInstance().getCurrentTypeDisplayLabel());
            this.statusText.text = loc1;
            return;
        }

        internal function _CloudView_AnchorLayoutData1_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            this.leftBtnLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftBtnLayout", this.leftBtnLayout);
            return loc1;
        }

        internal function _CloudView_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("touch", this.__loginBtn_touch);
            loc1.id = "loginBtn";
            this.loginBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "loginBtn", this.loginBtn);
            return loc1;
        }

        public function __loginBtn_touch(arg1:starling.events.TouchEvent):void
        {
            this.login(arg1);
            return;
        }

        internal function _CloudView_AnchorLayoutData4_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            this.logoLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "logoLayout", this.logoLayout);
            return loc1;
        }

        internal function _CloudView_Button4_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("touch", this.__logoutBtn_touch);
            loc1.id = "logoutBtn";
            this.logoutBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "logoutBtn", this.logoutBtn);
            return loc1;
        }

        public function __logoutBtn_touch(arg1:starling.events.TouchEvent):void
        {
            this.logout(arg1);
            return;
        }

        internal function _CloudView_Button2_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("touch", this.__registerBtn_touch);
            loc1.id = "registerBtn";
            this.registerBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "registerBtn", this.registerBtn);
            return loc1;
        }

        public function __registerBtn_touch(arg1:starling.events.TouchEvent):void
        {
            this.register(arg1);
            return;
        }

        internal function _CloudView_AnchorLayoutData2_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            this.rightBtnLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "rightBtnLayout", this.rightBtnLayout);
            return loc1;
        }

        internal function _CloudView_AnchorLayoutData3_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.left = 0;
            this.shapeLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "shapeLayout", this.shapeLayout);
            return loc1;
        }

        internal function _CloudView_AnchorLayoutData5_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            this.statusGroupLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "statusGroupLayout", this.statusGroupLayout);
            return loc1;
        }

        internal function _CloudView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "statusText";
            this.statusText = loc1;
            feathers.binding.BindingManager.executeBindings(this, "statusText", this.statusText);
            return loc1;
        }

        internal function _CloudView_Button3_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("touch", this.__syncBtn_touch);
            loc1.id = "syncBtn";
            this.syncBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "syncBtn", this.syncBtn);
            return loc1;
        }

        public function __syncBtn_touch(arg1:starling.events.TouchEvent):void
        {
            this.sync(arg1);
            return;
        }

        internal function _CloudView_AnchorLayoutData6_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.verticalCenter = 0;
            this.verticalCenterLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "verticalCenterLayout", this.verticalCenterLayout);
            return loc1;
        }

        internal function _CloudView_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.useConfigCache = true;
            loc1.useLocalesForText = false;
            loc1.addEventListener("completeEvent", this.__wifiOption_completeEvent);
            loc1.id = "wifiOption";
            this.wifiOption = loc1;
            feathers.binding.BindingManager.executeBindings(this, "wifiOption", this.wifiOption);
            return loc1;
        }

        public function __wifiOption_completeEvent(arg1:starling.events.Event):void
        {
            this.onNetworkStatusChanged();
            return;
        }

        internal function _CloudView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._CloudView_AnchorLayout1_c();
            loc1.mxmlContent = [this._CloudView_TextureImage1_i(), this._CloudView_TextureImage2_i(), this._CloudView_LayoutGroup2_i()];
            loc1.id = "content";
            this.content = loc1;
            feathers.binding.BindingManager.executeBindings(this, "content", this.content);
            return loc1;
        }

        internal function _CloudView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _CloudView_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "redShape";
            this.redShape = loc1;
            feathers.binding.BindingManager.executeBindings(this, "redShape", this.redShape);
            return loc1;
        }

        internal function _CloudView_TextureImage2_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "_CloudView_TextureImage2";
            this._CloudView_TextureImage2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CloudView_TextureImage2", this._CloudView_TextureImage2);
            return loc1;
        }

        internal function _CloudView_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._CloudView_VerticalLayout1_i();
            loc1.id = "statusGroup";
            this.statusGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "statusGroup", this.statusGroup);
            return loc1;
        }

        internal function _CloudView_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "center";
            loc1.verticalAlign = "top";
            this._CloudView_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CloudView_VerticalLayout1", this._CloudView_VerticalLayout1);
            return loc1;
        }

        internal function _CloudView_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._CloudView_AnchorLayout2_c();
            loc1.id = "options";
            this.options = loc1;
            feathers.binding.BindingManager.executeBindings(this, "options", this.options);
            return loc1;
        }

        internal function _CloudView_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _CloudView_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._CloudView_AnchorLayout3_c();
            loc1.id = "buttons";
            this.buttons = loc1;
            feathers.binding.BindingManager.executeBindings(this, "buttons", this.buttons);
            return loc1;
        }

        internal function _CloudView_AnchorLayout3_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _CloudView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___CloudView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        public function ___CloudView_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _CloudView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("CLOUDVIEW.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("CLOUDVIEW.LOGIN_BUTTON");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "loginBtn.label")
            result[2] = new feathers.binding.Binding(this, null, null, "loginBtn.layoutData", "leftBtnLayout");
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("CLOUDVIEW.REGISTER_BUTTON");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "registerBtn.label")
            result[4] = new feathers.binding.Binding(this, null, null, "registerBtn.layoutData", "rightBtnLayout");
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("CLOUDVIEW.SYNC_BUTTON");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "syncBtn.label")
            result[6] = new feathers.binding.Binding(this, null, null, "syncBtn.layoutData", "leftBtnLayout");
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("CLOUDVIEW.LOGOUT_BUTTON");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "logoutBtn.label")
            result[8] = new feathers.binding.Binding(this, null, null, "logoutBtn.layoutData", "rightBtnLayout");
            result[9] = new feathers.binding.Binding(this, function ():feathers.skins.IStyleProvider
            {
                return null;
            }, null, "statusText.styleProvider")
            result[10] = new feathers.binding.Binding(this, function ():Boolean
            {
                return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.CLOUD_SYNC_WIFI_ONLY, true);
            }, null, "wifiOption.checked")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheObject.CLOUD_SYNC_WIFI_ONLY;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "wifiOption.configCacheAttribute")
            result[12] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, NaN, 0);
            }, null, "wifiOption.layoutData")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("CLOUD_AUTO_SYNC_WITH_WIFI");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "wifiOption.text")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "wifiOption.type")
            result[15] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "leftBtnLayout.bottom")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "leftBtnLayout.left")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "leftBtnLayout.top")
            result[18] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "rightBtnLayout.bottom")
            result[19] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "rightBtnLayout.right")
            result[20] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "rightBtnLayout.top")
            result[21] = new feathers.binding.Binding(this, function ():Number
            {
                return 88 * SIGMALink.scaleFactor;
            }, null, "shapeLayout.top")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "logoLayout.left")
            result[23] = new feathers.binding.Binding(this, function ():Number
            {
                return 158 * SIGMALink.scaleFactor;
            }, null, "logoLayout.top")
            result[24] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "statusGroupLayout.left")
            result[25] = new feathers.binding.Binding(this, function ():Number
            {
                return 235 * SIGMALink.scaleFactor;
            }, null, "statusGroupLayout.top")
            result[26] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "verticalCenterLayout.left")
            result[27] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "content.height")
            result[28] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "content.width")
            result[29] = new feathers.binding.Binding(this, null, null, "redShape.layoutData", "shapeLayout");
            result[30] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.cloudViewShape;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "redShape.textureName")
            result[31] = new feathers.binding.Binding(this, null, null, "_CloudView_TextureImage2.layoutData", "logoLayout");
            result[32] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.sigmacloudwhite;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CloudView_TextureImage2.textureName")
            result[33] = new feathers.binding.Binding(this, null, null, "statusGroup.layoutData", "statusGroupLayout");
            result[34] = new feathers.binding.Binding(this, function ():Number
            {
                return 360 * SIGMALink.scaleFactor;
            }, null, "statusGroup.width")
            result[35] = new feathers.binding.Binding(this, function ():Number
            {
                return 10 * SIGMALink.scaleFactor;
            }, null, "_CloudView_VerticalLayout1.gap")
            result[36] = new feathers.binding.Binding(this, function ():Number
            {
                return ROW_HEIGHT;
            }, null, "options.height")
            result[37] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "options.width")
            result[38] = new feathers.binding.Binding(this, function ():Number
            {
                return ROW_HEIGHT;
            }, null, "buttons.height")
            result[39] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "buttons.width")
            return result;
        }

        public function get buttons():feathers.controls.LayoutGroup
        {
            return this._241352577buttons;
        }

        public function set buttons(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._241352577buttons;
            if (loc1 !== arg1) 
            {
                this._241352577buttons = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "buttons", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get content():feathers.controls.LayoutGroup
        {
            return this._951530617content;
        }

        public function set content(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._951530617content;
            if (loc1 !== arg1) 
            {
                this._951530617content = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "content", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
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

        public function get leftBtnLayout():feathers.layout.AnchorLayoutData
        {
            return this._983418975leftBtnLayout;
        }

        public function set leftBtnLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._983418975leftBtnLayout;
            if (loc1 !== arg1) 
            {
                this._983418975leftBtnLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftBtnLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get loginBtn():feathers.controls.Button
        {
            return this._2022732339loginBtn;
        }

        public function set loginBtn(arg1:feathers.controls.Button):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2022732339loginBtn;
            if (loc1 !== arg1) 
            {
                this._2022732339loginBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "loginBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get logoLayout():feathers.layout.AnchorLayoutData
        {
            return this._1688960843logoLayout;
        }

        public function set logoLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1688960843logoLayout;
            if (loc1 !== arg1) 
            {
                this._1688960843logoLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "logoLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get logoutBtn():feathers.controls.Button
        {
            return this._1540125582logoutBtn;
        }

        public function set logoutBtn(arg1:feathers.controls.Button):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1540125582logoutBtn;
            if (loc1 !== arg1) 
            {
                this._1540125582logoutBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "logoutBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get options():feathers.controls.LayoutGroup
        {
            return this._1249474914options;
        }

        public function set options(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1249474914options;
            if (loc1 !== arg1) 
            {
                this._1249474914options = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "options", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get redShape():frontend.components.TextureImage
        {
            return this._796763760redShape;
        }

        public function set redShape(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._796763760redShape;
            if (loc1 !== arg1) 
            {
                this._796763760redShape = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "redShape", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static const LOGGED_OUT:String="loggedOutState";

        internal static const MAX_STATUS_TEXT_WIDTH:Number=390 * SIGMALink.scaleFactor;

        internal static const NOT_CONNECTED:String="notConnectedState";

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        internal static const ROW_HEIGHT:Number=100 * SIGMALink.scaleFactor;

        internal static const SYNC_COMPLETE:String="syncCompleteState";

        internal static const SYNC_RUNNING:String="syncRunningState";

        internal var _1688960843logoLayout:feathers.layout.AnchorLayoutData;

        internal var _1540125582logoutBtn:feathers.controls.Button;

        internal var _1249474914options:feathers.controls.LayoutGroup;

        internal var _796763760redShape:frontend.components.TextureImage;

        internal var _2133315399registerBtn:feathers.controls.Button;

        internal var _1023749610rightBtnLayout:feathers.layout.AnchorLayoutData;

        internal var _655964715shapeLayout:feathers.layout.AnchorLayoutData;

        internal var _781545673statusGroupLayout:feathers.layout.AnchorLayoutData;

        internal var _248004671statusText:feathers.controls.Label;

        internal var _1742528063syncBtn:feathers.controls.Button;

        internal var _1906678389verticalCenterLayout:feathers.layout.AnchorLayoutData;

        internal var _25870314wifiOption:frontend.components.menuList.MenuListItem;

        internal var _currentState:String="loggedOutState";

        internal var movie:starling.display.MovieClip;

        internal var _913416787statusGroup:feathers.controls.LayoutGroup;

        public var _CloudView_TextureImage2:frontend.components.TextureImage;

        public var _CloudView_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _241352577buttons:feathers.controls.LayoutGroup;

        internal var _951530617content:feathers.controls.LayoutGroup;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _983418975leftBtnLayout:feathers.layout.AnchorLayoutData;

        internal var _2022732339loginBtn:feathers.controls.Button;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class CloudViewBackgroundSkin
package frontend.screen.cloud 
{
    import frontend.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class CloudViewBackgroundSkin extends starling.display.Sprite
    {
        public function CloudViewBackgroundSkin()
        {
            super();
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.bgCloud);
            var loc2:*=new starling.display.Image(loc1);
            addChild(loc2);
            return;
        }
    }
}


