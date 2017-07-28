//class DeviceSettingView
package frontend.screen.mydevices.settings 
{
    import backend.utils.dbUtils.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
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
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.popup.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class DeviceSettingView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._altitudeInterfaces = [];
            this._bicyclesInterfaces = [];
            this._deviceInterfaces = [];
            this._favASettingInterfaces = [];
            this._favBSettingInterfaces = [];
            this._fuelConsumption = [];
            this._userInterfaces = [];
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._DeviceSettingView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._DeviceSettingView_CustomVScrollContainer1_i(), this._DeviceSettingView_Footer1_i()];
            this.addEventListener("addedToStage", this.___DeviceSettingView_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___DeviceSettingView_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().removeBackFunction(this.backButtonFunction);
            return;
        }

        internal function backButtonFunction():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS, {"unit":this.unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.deletePopUp = new frontend.components.popup.DeletePopUp();
            this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_SETTINGS_TITLE");
            this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_SETTINGS_TEXT");
            this.deletePopUp.cancelCallback = this.onPopUpClose;
            this.deletePopUp.deleteCallback = this.onPopUpDelete;
            frontend.components.popup.PopUpBase.showModalPopUp(this.deletePopUp, true, true);
            return;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onInit():void
        {
            this.validateCategoryInterfaces();
            return;
        }

        internal function validateCategoryInterfaces():void
        {
            this._deviceInterfaces = [core.settings.interfaces.ILanguage, core.settings.interfaces.IClock, core.settings.interfaces.IVolume, core.settings.interfaces.IDate, core.settings.interfaces.ITimeZone, core.settings.interfaces.ISummerTime, core.settings.interfaces.IContrast, core.settings.interfaces.IButtonInfo, core.settings.interfaces.IButtonTone, [core.settings.interfaces.IAlarmMode, core.settings.interfaces.IAlarm], core.settings.interfaces.IZoneAlarm, core.settings.interfaces.IPhaseAlarm, core.settings.interfaces.IKeyLock, core.settings.interfaces.ICountdown, core.settings.interfaces.IMyName, core.settings.interfaces.IAutoPause, core.settings.interfaces.IAutoScan, core.settings.interfaces.ISamplingRate, core.settings.interfaces.ISystemTone, core.settings.interfaces.IBacklightTime, core.settings.interfaces.IBacklightLevel, core.settings.interfaces.IGPSStatus, core.settings.interfaces.IGPSFormat, core.settings.interfaces.IOffTrackAlarm, core.settings.interfaces.IWayPointAlarm, core.settings.interfaces.IAutoZoomTrack, core.settings.interfaces.IAutoOffTime];
            this._bicyclesInterfaces = [core.settings.interfaces.IWheelSize1, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IWheelSize3];
            this._altitudeInterfaces = [core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IHomeAltitude3, core.settings.interfaces.IActualAltitude, core.settings.interfaces.ISeaLevel];
            this._userInterfaces = [core.settings.interfaces.IGender, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IBirthDate, core.settings.interfaces.IYearOfBirth, core.settings.interfaces.IHRmax, core.settings.interfaces.IThreeZones, core.settings.interfaces.IAge, core.settings.interfaces.IHeartrateLimits];
            this._favASettingInterfaces = [core.settings.interfaces.IFavoritesAltitude, core.settings.interfaces.IFavoritesLap, core.settings.interfaces.IFavoritesTrack, core.settings.interfaces.IFavoriteTrip1];
            this._favBSettingInterfaces = [core.settings.interfaces.IFavoritesAltitude, core.settings.interfaces.IFavoritesLap, core.settings.interfaces.IFavoritesTrack, core.settings.interfaces.IFavoriteTrip2];
            this._fuelConsumption = [core.settings.interfaces.IFuelConsumption];
            return;
        }

        internal function onPopUpDelete():void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.settings.SettingsMapper.prepareDelete(this.settings.GUID), this.onDeleteSettingsComplete, this.onDeleteSettingsError, Workers.worker_DatabaseWorker);
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onNameChanged(arg1:Object):void
        {
            var loc1:*;
            this.settings.name = loc1 = arg1 as String;
            title = loc1;
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        protected override function validateProperties():void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            this.menuList.removeChildren();
            title = this.settings.name;
            var loc1:*=new frontend.components.menuList.MenuListHeadline();
            loc1.useLocalesForText = false;
            loc1.text = this.settings.unit.externalName;
            this.menuList.addChild(loc1);
            this._saveNameObj = new frontend.components.menuList.MenuListDbObject();
            this._saveNameObj.keyField = "GUID";
            this._saveNameObj.keyValue = this.settings.GUID;
            this._saveNameObj.updateField = core.settings.SettingsMapper.col_name;
            this._saveNameObj.table = core.settings.SettingsMapper.table_name;
            this._saveNameObj.updateModificationDate = true;
            this._saveNameObj.completeCallback = this.onNameChanged;
            var loc2:*=new frontend.components.menuList.MenuListItem();
            loc2.defaultValue = this.settings.name;
            loc2.editable = true;
            loc2.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc2.saveToDbUseUpdate = true;
            loc2.saveToDbUseUpdateObject = this._saveNameObj;
            loc2.text = "DEVICE_SETTING.NAME";
            loc2.title = "DEVICE_SETTING.NAME";
            loc2.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
            loc2.useConfigCache = false;
            loc2.useLocalesForText = true;
            loc2.useLocalesForTitle = true;
            this.menuList.addChild(loc2);
            if (this.hasAnyInterface(this._deviceInterfaces)) 
            {
                loc4 = new frontend.components.menuList.MenuListItem();
                loc4.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc4.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_DEVICE;
                loc4.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc4.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc4.text = "DEVICE_SETTING_DEVICE";
                this.menuList.addChild(loc4);
            }
            var loc3:*=new frontend.components.menuList.MenuListItem();
            loc3.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
            loc3.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_UNIT;
            loc3.destinationObject = {"setting":this.settings, "unit":this.unit};
            loc3.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc3.text = "DEVICE_SETTING_UNIT";
            this.menuList.addChild(loc3);
            if (this.hasAnyInterface(this._bicyclesInterfaces)) 
            {
                loc5 = new frontend.components.menuList.MenuListItem();
                loc5.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc5.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_BYCICLES;
                loc5.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc5.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc5.text = "DEVICE_SETTING_BYCICLES";
                this.menuList.addChild(loc5);
            }
            if (this.hasAnyInterface(this._altitudeInterfaces)) 
            {
                loc6 = new frontend.components.menuList.MenuListItem();
                loc6.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc6.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_ALTITUDE;
                loc6.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc6.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc6.text = "DEVICE_SETTING_ALTITUDE";
                this.menuList.addChild(loc6);
            }
            if (this.hasAnyInterface(this._userInterfaces)) 
            {
                loc7 = new frontend.components.menuList.MenuListItem();
                loc7.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc7.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_USER;
                loc7.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc7.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc7.text = "DEVICE_SETTING_USER";
                this.menuList.addChild(loc7);
            }
            if (this.settings is core.settings.SettingsPC2814) 
            {
                loc8 = new frontend.components.menuList.MenuListItem();
                loc8.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc8.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_RC_MOVE_FAVORITES;
                loc8.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc8.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc8.text = "DEVICE_SETTING_RC_MOVE_FAVORITES";
                this.menuList.addChild(loc8);
                loc9 = new frontend.components.menuList.MenuListItem();
                loc9.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc9.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_RC_MOVE_TRAINING_FREE;
                loc9.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc9.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc9.text = "DEVICE_SETTING_RC_MOVE_TRAINING_FREE";
                this.menuList.addChild(loc9);
                loc10 = new frontend.components.menuList.MenuListItem();
                loc10.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc10.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_RC_MOVE_TRAINING_INTERVAL;
                loc10.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc10.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc10.text = "DEVICE_SETTING_RC_MOVE_TRAINING_INTERVAL";
                this.menuList.addChild(loc10);
                return;
            }
            if (this.hasAnyInterface(this._favASettingInterfaces)) 
            {
                loc11 = new frontend.components.menuList.MenuListItem();
                loc11.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc11.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_FAVORITES_A;
                loc11.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc11.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc11.text = "DEVICE_SETTING_FAVORITES_A";
                this.menuList.addChild(loc11);
            }
            if (this.hasAnyInterface(this._favBSettingInterfaces)) 
            {
                loc12 = new frontend.components.menuList.MenuListItem();
                loc12.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc12.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_FAVORITES_B;
                loc12.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc12.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc12.text = "DEVICE_SETTING_FAVORITES_B";
                this.menuList.addChild(loc12);
            }
            if (this.hasAnyInterface(this._fuelConsumption)) 
            {
                loc13 = new frontend.components.menuList.MenuListItem();
                loc13.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc13.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_FUEL_CONSUMPTION;
                loc13.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc13.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc13.text = "DEVICE_SETTING_FUEL_CONSUMPTION";
                this.menuList.addChild(loc13);
            }
            return;
        }

        internal function hasAnyInterface(arg1:Array):Boolean
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc1:*=false;
            var loc3:*=arg1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (arg1[loc2] is Array) 
                {
                    loc4 = arg1[loc2] as Array;
                    loc6 = (arg1[loc2] as Array).length;
                    loc5 = 0;
                    while (loc5 < loc6) 
                    {
                        loc1 = this.settings is loc4[loc5];
                        if (!loc1) 
                        {
                            break;
                        }
                        ++loc5;
                    }
                }
                else 
                {
                    loc1 = this.settings is arg1[loc2];
                }
                if (loc1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        internal function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS_TRANSFER, {"unit":this.unit, "settings":this.settings, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected function onAddetToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addBackFunction(this.backButtonFunction);
            return;
        }

        internal function onDeleteSettingsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function onDeleteSettingsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteSettingsError");
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function _DeviceSettingView_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.layout = this._DeviceSettingView_AnchorLayout1_c();
            loc1.mxmlContent = [this._DeviceSettingView_MenuList1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _DeviceSettingView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _DeviceSettingView_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "menuList";
            this.menuList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "menuList", this.menuList);
            return loc1;
        }

        internal function _DeviceSettingView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._DeviceSettingView_IconButton1_i(), this._DeviceSettingView_IconButton2_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _DeviceSettingView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSettingView_IconButton1";
            this._DeviceSettingView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSettingView_IconButton1", this._DeviceSettingView_IconButton1);
            return loc1;
        }

        internal function _DeviceSettingView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSettingView_IconButton2";
            this._DeviceSettingView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSettingView_IconButton2", this._DeviceSettingView_IconButton2);
            return loc1;
        }

        public function ___DeviceSettingView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddetToStage(arg1);
            return;
        }

        public function ___DeviceSettingView_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _DeviceSettingView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0);
            }, null, "menuList.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "menuList.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uploadicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSettingView_IconButton1.image")
            result[5] = new feathers.binding.Binding(this, function ():Function
            {
                return toDevice_handler;
            }, null, "_DeviceSettingView_IconButton1.touchHandler")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.trashicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSettingView_IconButton2.image")
            result[7] = new feathers.binding.Binding(this, function ():Function
            {
                return touchHandler;
            }, null, "_DeviceSettingView_IconButton2.touchHandler")
            return result;
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

        public function get settings():core.settings.Settings
        {
            return this._1434631203settings;
        }

        public function set settings(arg1:core.settings.Settings):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1434631203settings;
            if (loc1 !== arg1) 
            {
                this._1434631203settings = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "settings", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _saveNameObj():frontend.components.menuList.MenuListDbObject
        {
            return this._1790552176_saveNameObj;
        }

        internal function set _saveNameObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1790552176_saveNameObj;
            if (loc1 !== arg1) 
            {
                this._1790552176_saveNameObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveNameObj", loc1, arg1, this);
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
            DeviceSettingView._watcherSetupUtil = arg1;
            return;
        }

        internal static const padding:Number=20 * SIGMALink.scaleFactor;

        internal var _bicyclesInterfaces:Array;

        internal var _deviceInterfaces:Array;

        internal var _favASettingInterfaces:Array;

        internal var _favBSettingInterfaces:Array;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal var _fuelConsumption:Array;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _1790552176_saveNameObj:frontend.components.menuList.MenuListDbObject;

        internal var _userInterfaces:Array;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        public var unit:core.units.Unit;

        public var _DeviceSettingView_IconButton1:frontend.components.button.IconButton;

        mx_internal var _bindingsByDestination:Object;

        public var _DeviceSettingView_IconButton2:frontend.components.button.IconButton;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _604015971menuList:frontend.components.menuList.MenuList;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _1434631203settings:core.settings.Settings;

        internal var _altitudeInterfaces:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


