//class InitialSocialNetworkConnect
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


