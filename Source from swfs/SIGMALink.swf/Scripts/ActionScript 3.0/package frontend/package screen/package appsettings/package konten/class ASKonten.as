//class ASKonten
package frontend.screen.appsettings.konten 
{
    import backend.oauth.*;
    import feathers.binding.*;
    import feathers.events.*;
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
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import service.oauth.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASKonten extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASKonten()
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
            bindings = this._ASKonten_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_ASKontenWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.appsettings.konten.ASKonten[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASKonten_CustomVScrollContainer1_i(), this._ASKonten_Footer1_i()];
            this.addEventListener("initialize", this.___ASKonten_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
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

        public function __facebookBtn_touch(arg1:starling.events.TouchEvent):void
        {
            onTouch(arg1);
            return;
        }

        internal function get _destinationObject():Object
        {
            return this._1994196370_destinationObject;
        }

        internal function set _destinationObject(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1994196370_destinationObject;
            if (loc1 !== arg1) 
            {
                this._1994196370_destinationObject = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_destinationObject", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function validateTexture(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc1:*=arg1.helperObject;
            switch (loc1) 
            {
                case backend.oauth.StravaOAuth.getInstance():
                {
                    arg1.iconTexture = backend.oauth.StravaOAuth.getInstance().loggedOut ? frontend.Textures.shareStravaGrey : frontend.Textures.shareStrava;
                    break;
                }
                case backend.oauth.TrainingPeaksOAuth.getInstance():
                {
                    arg1.iconTexture = backend.oauth.TrainingPeaksOAuth.getInstance().loggedOut ? frontend.Textures.shareTrainingPeaksGrey : frontend.Textures.shareTrainingPeaks;
                    break;
                }
                case backend.oauth.TwoPeakOAuth.getInstance():
                {
                    arg1.iconTexture = backend.oauth.TwoPeakOAuth.getInstance().loggedOut ? frontend.Textures.shareTwoPeakGrey : frontend.Textures.shareTwoPeak;
                    break;
                }
                case backend.oauth.FacebookGoViralHandler.getInstance():
                {
                    arg1.iconTexture = backend.oauth.FacebookGoViralHandler.getInstance().loggedOut ? frontend.Textures.shareFacebookGrey : frontend.Textures.shareFacebook;
                    break;
                }
                case backend.oauth.TwitterOAuth.getInstance():
                {
                    arg1.iconTexture = backend.oauth.TwitterOAuth.getInstance().loggedOut ? frontend.Textures.shareTwitterGrey : frontend.Textures.shareTwitter;
                    break;
                }
            }
            return;
        }

        public function set gotoActivityId(arg1:uint):void
        {
            this._gotoActivityId = arg1;
            this._destinationObject = {"gotoActivityId":this._gotoActivityId};
            return;
        }

        public static function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=arg1.currentTarget as frontend.components.menuList.MenuListItem;
            if (loc1.hasTouchEvents) 
            {
                return;
            }
            if (!handler.ConnectionHandler.checkNoInternetPopUp()) 
            {
                return;
            }
            (loc1.helperObject as frontend.components.popup.oauth.CustomOAuth).checkLogin(starling.core.Starling.current.nativeStage, true);
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.appsettings.konten.ASKonten._watcherSetupUtil = arg1;
            return;
        }

        internal function addEvents(arg1:service.oauth.CommonOAuth):void
        {
            arg1.addEventListener(service.oauth.CommonOAuth.LOGGED_OUT, this.onLoggedOut);
            arg1.addEventListener(service.oauth.CommonOAuth.LOGGED_IN, this.onLoggedIn);
            return;
        }

        internal function onLoggedIn(arg1:flash.events.Event):void
        {
            var loc1:*=this.resolveBtn(arg1.currentTarget as frontend.components.popup.oauth.CustomOAuth);
            validateTexture(loc1);
            loc1.hasTouchEvents = true;
            if (handler.ViewHandler.getInstance().isActive(this)) 
            {
                handler.ViewHandler.getInstance().showScreen(loc1.destination, this._destinationObject, handler.ViewHandler.slideToLeftTransition());
            }
            return;
        }

        internal function onLoggedOut(arg1:flash.events.Event):void
        {
            var loc1:*=this.resolveBtn(arg1.currentTarget as frontend.components.popup.oauth.CustomOAuth);
            validateTexture(loc1);
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

        internal function onInit():void
        {
            validateTexture(this.stravaBtn);
            validateTexture(this.trainingPeaksBtn);
            validateTexture(this.twoPeakBtn);
            validateTexture(this.facebookBtn);
            validateTexture(this.twitterBtn);
            this.addEvents(backend.oauth.StravaOAuth.getInstance());
            this.addEvents(backend.oauth.TrainingPeaksOAuth.getInstance());
            this.addEvents(backend.oauth.TwoPeakOAuth.getInstance());
            this.addEvents(backend.oauth.FacebookGoViralHandler.getInstance());
            this.addEvents(backend.oauth.TwitterOAuth.getInstance());
            return;
        }

        internal function _ASKonten_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._ASKonten_MenuList1_i()];
            loc1.id = "_ASKonten_CustomVScrollContainer1";
            this._ASKonten_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKonten_CustomVScrollContainer1", this._ASKonten_CustomVScrollContainer1);
            return loc1;
        }

        internal function _ASKonten_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._ASKonten_MenuListItem1_i(), this._ASKonten_MenuListItem2_i(), this._ASKonten_MenuListItem3_i(), this._ASKonten_MenuListItem4_i(), this._ASKonten_MenuListItem5_i()];
            loc1.id = "_ASKonten_MenuList1";
            this._ASKonten_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKonten_MenuList1", this._ASKonten_MenuList1);
            return loc1;
        }

        internal function _ASKonten_MenuListItem1_i():frontend.components.menuList.MenuListItem
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
            onTouch(arg1);
            return;
        }

        internal function _ASKonten_MenuListItem2_i():frontend.components.menuList.MenuListItem
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
            onTouch(arg1);
            return;
        }

        internal function _ASKonten_MenuListItem3_i():frontend.components.menuList.MenuListItem
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
            onTouch(arg1);
            return;
        }

        internal function _ASKonten_MenuListItem4_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.FACEBOOK.TITLE";
            loc1.addEventListener("touch", this.__facebookBtn_touch);
            loc1.id = "facebookBtn";
            this.facebookBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "facebookBtn", this.facebookBtn);
            return loc1;
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

        internal function _ASKonten_MenuListItem5_i():frontend.components.menuList.MenuListItem
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
            onTouch(arg1);
            return;
        }

        internal function _ASKonten_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___ASKonten_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _ASKonten_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_ASKonten_CustomVScrollContainer1.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKonten_CustomVScrollContainer1.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKonten_MenuList1.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_STRAVA;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "stravaBtn.destination")
            result[5] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "stravaBtn.destinationObject")
            result[6] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.StravaOAuth.getInstance().loggedOut;
            }, null, "stravaBtn.hasTouchEvents")
            result[7] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.StravaOAuth.getInstance();
            }, null, "stravaBtn.helperObject")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "stravaBtn.minItemHeight")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "stravaBtn.type")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_TRAININGPEAKS;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainingPeaksBtn.destination")
            result[11] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "trainingPeaksBtn.destinationObject")
            result[12] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.TrainingPeaksOAuth.getInstance().loggedOut;
            }, null, "trainingPeaksBtn.hasTouchEvents")
            result[13] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.TrainingPeaksOAuth.getInstance();
            }, null, "trainingPeaksBtn.helperObject")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "trainingPeaksBtn.minItemHeight")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainingPeaksBtn.type")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_TWOPEAK;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twoPeakBtn.destination")
            result[17] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "twoPeakBtn.destinationObject")
            result[18] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.TwoPeakOAuth.getInstance().loggedOut;
            }, null, "twoPeakBtn.hasTouchEvents")
            result[19] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.TwoPeakOAuth.getInstance();
            }, null, "twoPeakBtn.helperObject")
            result[20] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "twoPeakBtn.minItemHeight")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twoPeakBtn.type")
            result[22] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_FACEBOOK;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "facebookBtn.destination")
            result[23] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "facebookBtn.destinationObject")
            result[24] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.FacebookGoViralHandler.getInstance().loggedOut;
            }, null, "facebookBtn.hasTouchEvents")
            result[25] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.FacebookGoViralHandler.getInstance();
            }, null, "facebookBtn.helperObject")
            result[26] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "facebookBtn.minItemHeight")
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "facebookBtn.type")
            result[28] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_TWITTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twitterBtn.destination")
            result[29] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "twitterBtn.destinationObject")
            result[30] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.TwitterOAuth.getInstance().loggedOut;
            }, null, "twitterBtn.hasTouchEvents")
            result[31] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.TwitterOAuth.getInstance();
            }, null, "twitterBtn.helperObject")
            result[32] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "twitterBtn.minItemHeight")
            result[33] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twitterBtn.type")
            return result;
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

        public function get stravaBtn():frontend.components.menuList.MenuListItem
        {
            return this._411132575stravaBtn;
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

        public var _ASKonten_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _ASKonten_MenuList1:frontend.components.menuList.MenuList;

        internal var _958082486facebookBtn:frontend.components.menuList.MenuListItem;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _411132575stravaBtn:frontend.components.menuList.MenuListItem;

        internal var _59022615twitterBtn:frontend.components.menuList.MenuListItem;

        internal var _510796527twoPeakBtn:frontend.components.menuList.MenuListItem;

        internal var _gotoActivityId:uint=0;

        internal var _1994196370_destinationObject:Object;

        internal var _oldScreen:String;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal var _1566496446trainingPeaksBtn:frontend.components.menuList.MenuListItem;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


