//class MyDeviceView
package frontend.screen.mydevices 
{
    import backend.utils.*;
    import configCache.*;
    import core.general.*;
    import core.units.*;
    import core.units.interfaces.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
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
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.list.*;
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
    
    public class MyDeviceView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function MyDeviceView()
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
            bindings = this._MyDeviceView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_MyDeviceViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyDeviceView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._MyDeviceView_CustomVScrollContainer1_i(), this._MyDeviceView_Footer1_i()];
            this.addEventListener("addedToStage", this.___MyDeviceView_CustomScreen1_addedToStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected override function validateProperties():void
        {
            this.validateMenuItems();
            return;
        }

        internal function validateMenuItems():void
        {
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=null;
            this.menuList.removeChildren(0);
            title = this.unit.externalName;
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
            loc1.destination = handler.ViewHandler.VIEW_DEVICE_GENERAL;
            loc1.destinationObject = {"unit":this.unit};
            loc1.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
            loc1.text = "DEVICEVIEW.GENERAL";
            loc1.iconTexture = frontend.Textures.settingsiconred;
            this.menuList.addChild(loc1);
            var loc2:*=new frontend.components.menuList.MenuListItem();
            loc2.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
            loc2.destination = handler.ViewHandler.VIEW_DEVICE_SETTINGS;
            loc2.destinationObject = {"unit":this.unit, "backScreenName":handler.ViewHandler.VIEW_DEVICE_VIEW};
            loc2.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
            loc2.text = "DEVICEVIEW.DEVICE_SETTINGS";
            loc2.iconTexture = frontend.Textures.devicesettingsiconred;
            this.menuList.addChild(loc2);
            if (this.unit is core.units.interfaces.IAgpsSupported) 
            {
                loc7 = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.AGPS_LAST_SYNC_DATE, null);
                loc8 = new frontend.components.menuList.MenuListItem();
                loc8.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc8.destination = handler.ViewHandler.VIEW_AGPS_TRANSFER;
                loc8.destinationObject = {"unit":this.unit};
                loc8.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
                loc8.text = "DEVICEVIEW.DEVICE_AGPS";
                loc8.leftSubLabelText = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_AGPS_SUBTEXT_1");
                loc8.iconTexture = frontend.Textures.satellitIcon;
                if (loc7 != null) 
                {
                    loc8.leftSubLabelText2 = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_AGPS_SUBTEXT_2") + " " + backend.utils.DataUtils.dateFormatter.format(loc7);
                }
                this.menuList.addChild(loc8);
            }
            if (this.unit is core.units.interfaces.IPointNavigationsList) 
            {
                loc9 = new frontend.components.menuList.MenuListItem();
                loc9.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc9.destination = handler.ViewHandler.VIEW_DEVICE_POINT_NAVIGATIONS;
                loc9.destinationObject = {"unit":this.unit};
                loc9.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
                loc9.text = "DEVICEVIEW.DEVICE_POINT_NAVIGATION";
                loc9.leftSubLabelText = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_POINT_NAVIGATION_SUBTEXT");
                loc9.iconTexture = frontend.Textures.pointNavigationIcon;
                this.menuList.addChild(loc9);
            }
            if (this.unit is core.units.interfaces.ITrainingsList) 
            {
                loc10 = new frontend.components.menuList.MenuListItem();
                loc10.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc10.destination = handler.ViewHandler.VIEW_DEVICE_TRAINING_PROGRAM;
                loc10.destinationObject = {"unit":this.unit};
                loc10.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
                loc10.text = "DEVICEVIEW.TRAINING_PROGRAM";
                loc10.iconTexture = frontend.Textures.trainingsprogrammeiconred;
                this.menuList.addChild(loc10);
            }
            if (this.unit is core.units.interfaces.ISportProfiles) 
            {
                loc11 = new frontend.components.menuList.MenuListItem();
                loc11.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc11.destination = handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES;
                loc11.destinationObject = {"unit":this.unit};
                loc11.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
                loc11.text = "DEVICEVIEW.DEVICE_SPORT_PROFILES";
                loc11.iconTexture = frontend.Textures.shoeiconred;
                this.menuList.addChild(loc11);
            }
            if (this.unit is core.units.interfaces.ISleepScreen) 
            {
                loc12 = new frontend.components.menuList.MenuListItem();
                loc12.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc12.destination = handler.ViewHandler.VIEW_DEVICE_SLEEP_SCREEN;
                loc12.destinationObject = {"unit":this.unit};
                loc12.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
                loc12.text = "DEVICEVIEW.DEVICE_SLEEP_SCREEN";
                loc12.iconTexture = frontend.Textures.sleepScreenIcon;
                this.menuList.addChild(loc12);
            }
            var loc3:*=new frontend.screen.mydevices.list.MyDevicesListItem();
            loc3.unit = this.unit;
            loc3.GUID = this.unit.GUID;
            var loc4:*=new frontend.components.menuList.MenuListItem();
            loc4.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
            loc4.destination = handler.ViewHandler.VIEW_ACTIVITIES_TRANSFER;
            loc4.destinationObject = {"unit":this.unit, "backScreenName":handler.ViewHandler.VIEW_DEVICE_VIEW};
            loc4.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
            loc4.text = "DASHBOARD.SHORTCUT_IMPORT_ACTIVITIES";
            loc4.iconTexture = frontend.Textures.downloadiconred;
            this.menuList.addChild(loc4);
            if (this.unit is core.units.interfaces.ITrackList) 
            {
                loc13 = new frontend.components.menuList.MenuListItem();
                loc13.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc13.destination = handler.ViewHandler.VIEW_TRACKS_TRANSFER;
                loc13.destinationObject = {"unit":this.unit, "transferModeDownload":true, "backScreenName":handler.ViewHandler.VIEW_DEVICE_VIEW};
                loc13.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
                loc13.text = "DASHBOARD.SHORTCUT_IMPORT_TRACKS";
                loc13.iconTexture = frontend.Textures.trackred;
                this.menuList.addChild(loc13);
            }
            if (this.unit is core.units.interfaces.IStravaSegmentsSupported) 
            {
                loc14 = new frontend.components.menuList.MenuListItem();
                loc14.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc14.destination = handler.ViewHandler.VIEW_STRAVA_SEGMENTS_TRANSFER;
                loc14.destinationObject = {"unit":this.unit, "transferModeDownload":false};
                loc14.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
                loc14.text = "DASHBOARD.SHORTCUT_STRAVA_SEGMENTS";
                loc14.iconTexture = frontend.Textures.strava;
                this.menuList.addChild(loc14);
            }
            var loc5:*=new feathers.controls.LayoutGroup();
            loc5.height = 60 * SIGMALink.scaleFactor;
            loc5.width = SIGMALink.appWidth;
            this.menuList.addChild(loc5);
            var loc6:*=new frontend.components.menuList.MenuListItem();
            loc6.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK;
            loc6.clickCallback = this.navigateToInfos;
            loc6.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT;
            loc6.text = "DEVICEVIEW.DEVICE_HELP";
            loc6.iconTexture = frontend.Textures.infobuttonred;
            this.menuList.addChild(loc6);
            return;
        }

        internal function navigateToInfos():void
        {
            var loc1:*=null;
            if (configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.SOFTWARE_LANGUAGE, core.general.LanguageSoftware.EN_US) != core.general.LanguageSoftware.DE_DE) 
            {
                loc1 = "http://www.sigmasport.com/en/produkte";
            }
            else 
            {
                loc1 = "http://www.sigmasport.com/de/produkte";
            }
            flash.net.navigateToURL(new flash.net.URLRequest(loc1));
            return;
        }

        protected function onAddetToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addBackFunction(this.backButton);
            return;
        }

        internal function backButton():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_MYDEVICES, {"clearHistory":true}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function _MyDeviceView_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._MyDeviceView_MenuList1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _MyDeviceView_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "menuList";
            this.menuList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "menuList", this.menuList);
            return loc1;
        }

        internal function _MyDeviceView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___MyDeviceView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddetToStage(arg1);
            return;
        }

        internal function _MyDeviceView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "menuList.width")
            return result;
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

        public function get menuList():frontend.components.menuList.MenuList
        {
            return this._604015971menuList;
        }

        public function set menuList(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._604015971menuList;
            if (loc1 !== arg1) 
            {
                this._604015971menuList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "menuList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scroller():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._402164678scroller;
        }

        public function set scroller(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._402164678scroller;
            if (loc1 !== arg1) 
            {
                this._402164678scroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scroller", loc1, arg1, this);
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
            MyDeviceView._watcherSetupUtil = arg1;
            return;
        }

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _604015971menuList:frontend.components.menuList.MenuList;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        public var unit:core.units.Unit;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


