//class DeviceSportprofileView
package frontend.screen.mydevices.sportprofiles 
{
    import core.settings.interfaces.*;
    import core.sport.*;
    import core.sportprofiles.*;
    import feathers.binding.*;
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
    import frontend.*;
    import frontend.components.*;
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
    
    public class DeviceSportprofileView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSportprofileView()
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
            bindings = this._DeviceSportprofileView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_DeviceSportprofileViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSportprofileView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._DeviceSportprofileView_CustomVScrollContainer1_i(), this._DeviceSportprofileView_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
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

        internal function get _saveSportObj():frontend.components.menuList.MenuListDbObject
        {
            return this._294660959_saveSportObj;
        }

        internal function set _saveSportObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._294660959_saveSportObj;
            if (loc1 !== arg1) 
            {
                this._294660959_saveSportObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveSportObj", loc1, arg1, this);
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
            DeviceSportprofileView._watcherSetupUtil = arg1;
            return;
        }

        internal function onNameChanged(arg1:Object):void
        {
            var loc1:*;
            this.sportprofile.profileName = loc1 = arg1 as String;
            title = loc1;
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        internal function onSportChanged(arg1:Object):void
        {
            this.sportprofile.sportId = arg1 as uint;
            this.validateSportsItem();
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        protected override function validateProperties():void
        {
            var loc3:*=0;
            var loc7:*=null;
            this.menuList.removeChildren();
            title = this.sportprofile.profileName;
            var loc1:*=new frontend.components.menuList.MenuListHeadline();
            loc1.useLocalesForText = false;
            loc1.text = this.sportprofile.unit.externalName;
            this.menuList.addChild(loc1);
            this._saveNameObj = new frontend.components.menuList.MenuListDbObject();
            this._saveNameObj.keyField = "GUID";
            this._saveNameObj.keyValue = this.sportprofile.GUID;
            this._saveNameObj.updateField = core.sportprofiles.SportprofileMapper.col_profileName;
            this._saveNameObj.table = core.sportprofiles.SportprofileMapper.TABLE_NAME;
            this._saveNameObj.updateModificationDate = true;
            this._saveNameObj.completeCallback = this.onNameChanged;
            var loc2:*=new frontend.components.menuList.MenuListItem();
            loc2.defaultValue = this.sportprofile.profileName;
            loc2.editable = true;
            loc2.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc2.saveToDbUseUpdate = true;
            loc2.saveToDbUseUpdateObject = this._saveNameObj;
            loc2.text = "DEVICE_SPORTPROFILE.NAME";
            loc2.title = "DEVICE_SPORTPROFILE.NAME";
            loc2.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
            loc2.useConfigCache = false;
            loc2.useLocalesForText = true;
            loc2.useLocalesForTitle = true;
            this.menuList.addChild(loc2);
            var loc4:*=handler.SportHandler.getInstance().sports.length;
            var loc5:*=new feathers.data.ListCollection();
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (handler.SportHandler.getInstance().sports[loc3].keyName != core.sport.Sport.ACTIVITY_TRACKER) 
                {
                    loc5.push({"label":handler.SportHandler.getInstance().sports[loc3].name, "data":handler.SportHandler.getInstance().sports[loc3].sportId, "selected":handler.SportHandler.getInstance().sports[loc3].sportId == this.sportprofile.sportId});
                }
                ++loc3;
            }
            this._saveSportObj = new frontend.components.menuList.MenuListDbObject();
            this._saveSportObj.keyField = "GUID";
            this._saveSportObj.keyValue = this.sportprofile.GUID;
            this._saveSportObj.updateField = core.sportprofiles.SportprofileMapper.col_sportId;
            this._saveSportObj.table = core.sportprofiles.SportprofileMapper.TABLE_NAME;
            this._saveSportObj.updateModificationDate = true;
            this._saveSportObj.completeCallback = this.onSportChanged;
            this.sportsItem = new frontend.components.menuList.MenuListItem();
            this.sportsItem.dataProvider = loc5;
            this.sportsItem.defaultValue = this.sportprofile.sportId;
            this.sportsItem.editable = true;
            this.sportsItem.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            this.sportsItem.saveToDbUseUpdate = true;
            this.sportsItem.saveToDbUseUpdateObject = this._saveSportObj;
            this.sportsItem.text = "ACTIVITYVIEW.EDIT_SPORT";
            this.sportsItem.title = "ACTIVITYVIEW.EDIT_SPORT";
            this.sportsItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT;
            this.sportsItem.useConfigCache = false;
            this.sportsItem.useLocalesForText = true;
            this.sportsItem.useLocalesForTitle = true;
            this.validateSportsItem();
            this.menuList.addChild(this.sportsItem);
            var loc6:*=new frontend.components.menuList.MenuListItem();
            loc6.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
            loc6.destination = handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_SETTINGS;
            loc6.destinationObject = {"sportprofile":this.sportprofile};
            loc6.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc6.text = "DEVICE_SPORTPROFILE.SETTINGS";
            this.menuList.addChild(loc6);
            if (this.sportprofile is core.settings.interfaces.IFavSets) 
            {
                loc4 = (this.sportprofile as core.settings.interfaces.IFavSets).favSetMaxCount;
                loc3 = 1;
                while (loc3 <= loc4) 
                {
                    loc7 = new frontend.components.menuList.MenuListItem();
                    loc7.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                    loc7.destination = handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET;
                    loc7.destinationObject = {"sportprofile":this.sportprofile, "favsetNr":loc3};
                    loc7.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                    loc7.useLocalesForText = false;
                    loc7.text = utils.LanguageManager.getString("DEVICE_SPORTPROFILE.FAVSET") + " " + loc3;
                    this.menuList.addChild(loc7);
                    ++loc3;
                }
            }
            return;
        }

        internal function validateSportsItem():void
        {
            var loc3:*=0;
            var loc6:*=null;
            this.sportsItem.customLayoutContent.removeChildren();
            this.sportsItem.customLayoutContent.visible = true;
            this.sportsItem.customLayoutContent.includeInLayout = true;
            this.sportsItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.requestedColumnCount = 1;
            loc1.useSquareTiles = false;
            loc1.horizontalGap = this.sportsItem.padding;
            loc1.verticalGap = this.sportsItem.padding;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.paddingRight = this.sportsItem.padding;
            var loc2:*=new frontend.components.SportIcon();
            loc2.sportId = 1;
            loc2.validate();
            loc1.typicalItem = loc2;
            loc1.typicalItemHeight = loc2.height;
            loc1.typicalItemWidth = loc2.width;
            this.sportsItem.customLayoutContent.width = loc1.requestedColumnCount * loc1.typicalItemWidth + (loc1.requestedColumnCount + 1) * this.sportsItem.padding;
            var loc4:*=this.sportsItem.dataProvider.length;
            var loc5:*=[];
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (this.sportsItem.dataProvider.getItemAt(loc3).data == this.sportprofile.sportId) 
                {
                    loc6 = new frontend.components.SportIcon();
                    loc6.sportId = this.sportsItem.dataProvider.getItemAt(loc3).data;
                    this.sportsItem.customLayoutContent.addChild(loc6);
                }
                ++loc3;
            }
            loc1.requestedRowCount = Math.max(1, Math.ceil(this.sportsItem.customLayoutContent.numChildren / loc1.requestedColumnCount));
            this.sportsItem.customLayoutContent.layout = loc1;
            this.sportsItem.height = loc1.requestedRowCount * this.sportsItem.minItemHeight;
            this.sportsItem.customLayoutContent.height = this.sportsItem.height;
            return;
        }

        internal function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES_TRANSFER, {"unit":this.sportprofile.unit, "sportprofile":this.sportprofile, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _DeviceSportprofileView_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._DeviceSportprofileView_MenuList1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _DeviceSportprofileView_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "menuList";
            this.menuList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "menuList", this.menuList);
            return loc1;
        }

        internal function _DeviceSportprofileView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._DeviceSportprofileView_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _DeviceSportprofileView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSportprofileView_IconButton1";
            this._DeviceSportprofileView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileView_IconButton1", this._DeviceSportprofileView_IconButton1);
            return loc1;
        }

        internal function _DeviceSportprofileView_bindingsSetup():Array
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
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "menuList.width")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uploadicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileView_IconButton1.image")
            result[4] = new feathers.binding.Binding(this, function ():Function
            {
                return toDevice_handler;
            }, null, "_DeviceSportprofileView_IconButton1.touchHandler")
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

        internal static const padding:Number=20 * SIGMALink.scaleFactor;

        public var _DeviceSportprofileView_IconButton1:frontend.components.button.IconButton;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _604015971menuList:frontend.components.menuList.MenuList;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        public var sportprofile:core.sportprofiles.Sportprofile;

        internal var _1790552176_saveNameObj:frontend.components.menuList.MenuListDbObject;

        internal var _294660959_saveSportObj:frontend.components.menuList.MenuListDbObject;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var sportsItem:frontend.components.menuList.MenuListItem;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


