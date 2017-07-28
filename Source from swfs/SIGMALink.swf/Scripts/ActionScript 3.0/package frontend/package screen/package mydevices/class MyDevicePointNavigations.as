//class MyDevicePointNavigations
package frontend.screen.mydevices 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import backend.utils.gps.*;
    import configCache.*;
    import core.gps.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
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
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.list.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class MyDevicePointNavigations extends frontend.screen.mydevices.CustomEditListScreen implements feathers.binding.IBindingClient
    {
        public function MyDevicePointNavigations()
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
            bindings = this._MyDevicePointNavigations_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_MyDevicePointNavigationsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyDevicePointNavigations[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._MyDevicePointNavigations_ListLoader1_i(), this._MyDevicePointNavigations_Footer1_i(), this._MyDevicePointNavigations_Footer2_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get addButton():frontend.components.button.IconButton
        {
            return this._484847821addButton;
        }

        public function set addButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._484847821addButton;
            if (loc1 !== arg1) 
            {
                this._484847821addButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "addButton", loc1, arg1, this);
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
            MyDevicePointNavigations._watcherSetupUtil = arg1;
            return;
        }

        protected override function prepareCompletedData():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc2:*=_currentData.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = core.gps.PointNavigationMapper.fromDB(_currentData[loc1]);
                loc4 = new frontend.screen.mydevices.list.MyDevicePointNavigationListItem();
                loc4.pointNavigation = loc3;
                loc4.GUID = loc3.GUID;
                _dataProvider.push(loc4);
                ++loc1;
            }
            return;
        }

        protected override function validateNoDataInfo():void
        {
            listLoader.noDataText = noDataText;
            listLoader.noDataIconButtonAnchor = _dataProvider.length != 0 ? null : this.addButton;
            return;
        }

        protected override function backButtonFunction():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_VIEW, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        protected override function itemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.list.MyDevicePointNavigationRenderer();
            loc1.callBackFunction = this.uploadItemClickCallback;
            return loc1;
        }

        internal function uploadItemClickCallback(arg1:frontend.screen.mydevices.list.MyDevicePointNavigationListItem):void
        {
            if (listLoader.listStateHandler.editState) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_POINT_NAVIGATION_TRANSFER, {"unit":unit, "pointNavigation":arg1.pointNavigation, "transferModeDownload":false, "backScreenName":handler.ViewHandler.VIEW_DEVICE_POINT_NAVIGATIONS}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected override function triggeredHandler(arg1:starling.events.Event):void
        {
            if (listLoader.listStateHandler.editState) 
            {
                return;
            }
            if (!(arg1.data is frontend.screen.mydevices.list.MyDevicePointNavigationListItem)) 
            {
                debug.Debug.error("p_event.data is not a MyDevicePointNavigationListItem");
                return;
            }
            (arg1.data as frontend.screen.mydevices.list.MyDevicePointNavigationListItem).pointNavigation.unitGUID = unit.GUID;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_POINT_NAVIGATION, {"pointNavigation":(arg1.data as frontend.screen.mydevices.list.MyDevicePointNavigationListItem).pointNavigation, "unit":unit}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected override function loadData():void
        {
            handler.AppDeviceHandler.getInstance().loadPointNavigations(new backend.utils.dbUtils.DBUtilObject(unit, loadDataComplete, loadDataError, Workers.worker_DatabaseWorker), _currentSortField, _currentAscending);
            return;
        }

        protected override function onPopUpDelete():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc2:*=_dataProvider.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = _dataProvider.data[loc1] as frontend.screen.mydevices.list.MyDevicePointNavigationListItem;
                if (loc3 && loc3.isSelected()) 
                {
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.gps.PointNavigationMapper.prepareDelete(loc3.pointNavigation.GUID), this.onDeleteComplete, onDeleteError, Workers.worker_DatabaseWorker, loc3);
                }
                ++loc1;
            }
            super.onPopUpDelete();
            return;
        }

        protected override function onDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            ((arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.mydevices.list.MyDevicePointNavigationListItem).removeSelection();
            super.onDeleteComplete(arg1);
            return;
        }

        protected override function initializeSortfields():void
        {
            _sortFields = new Vector.<frontend.components.list.ListSortItem>();
            _sortFields.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.NAME"), "text1", true));
            _sortFields.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.MODIFICATION_DATE"), "modificationDate", true));
            return;
        }

        internal function createNew_handler(arg1:starling.events.TouchEvent):void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSDisabled);
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onGPSLocationChanged);
            backend.utils.gps.GeoLocationHelper.getInstance().updateGPSPosition();
            return;
        }

        internal function createNewPoint():core.gps.PointNavigation
        {
            var loc1:*=new core.gps.PointNavigation();
            loc1.modificationDate = new Date().time;
            loc1.unitGUID = unit.GUID;
            loc1.unitType = unit.type;
            return loc1;
        }

        internal function onGPSDisabled(arg1:starling.events.Event):void
        {
            var loc1:*=this.createNewPoint();
            loc1.latitude = 49;
            loc1.longitude = 8;
            this.openPointNavigationView(loc1);
            return;
        }

        internal function onGPSLocationChanged(arg1:starling.events.Event):void
        {
            var loc1:*=this.createNewPoint();
            loc1.latitude = backend.utils.gps.GeoLocationHelper.getInstance().currentLat;
            loc1.longitude = backend.utils.gps.GeoLocationHelper.getInstance().currentLon;
            this.openPointNavigationView(loc1);
            return;
        }

        internal function openPointNavigationView(arg1:core.gps.PointNavigation):void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSDisabled);
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onGPSLocationChanged);
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_POINT_NAVIGATION, {"pointNavigation":arg1, "unit":unit}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function onCreatePointError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onCreatePointError");
            return;
        }

        internal function _MyDevicePointNavigations_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", listLoader);
            return loc1;
        }

        internal function _MyDevicePointNavigations_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._MyDevicePointNavigations_IconButton1_i(), this._MyDevicePointNavigations_IconButton2_i(), this._MyDevicePointNavigations_IconButton3_i()];
            loc1.id = "footer";
            footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", footer);
            return loc1;
        }

        internal function _MyDevicePointNavigations_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "addButton";
            this.addButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "addButton", this.addButton);
            return loc1;
        }

        internal function _MyDevicePointNavigations_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "sortButton";
            sortButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sortButton", sortButton);
            return loc1;
        }

        internal function _MyDevicePointNavigations_IconButton3_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "editButton";
            editButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "editButton", editButton);
            return loc1;
        }

        internal function _MyDevicePointNavigations_Footer2_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.showBackButton = false;
            loc1.mxmlContent = [this._MyDevicePointNavigations_IconButton4_i(), this._MyDevicePointNavigations_IconButton5_i()];
            loc1.id = "footerEdit";
            footerEdit = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footerEdit", footerEdit);
            return loc1;
        }

        internal function _MyDevicePointNavigations_IconButton4_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_MyDevicePointNavigations_IconButton4";
            this._MyDevicePointNavigations_IconButton4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MyDevicePointNavigations_IconButton4", this._MyDevicePointNavigations_IconButton4);
            return loc1;
        }

        internal function _MyDevicePointNavigations_IconButton5_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_MyDevicePointNavigations_IconButton5";
            this._MyDevicePointNavigations_IconButton5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MyDevicePointNavigations_IconButton5", this._MyDevicePointNavigations_IconButton5);
            return loc1;
        }

        internal function _MyDevicePointNavigations_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheObject.DEVICE_POINT_NAVIGATION_SORT_ASCENDING;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.configCacheSortAscending")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheObject.DEVICE_POINT_NAVIGATION_SORT_FIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.configCacheSortField")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DELETE_POPUP.DELETE_POINT_NAVIGATION_TEXT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.deletePopUpText")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DELETE_POPUP.DELETE_POINT_NAVIGATION_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.deletePopUpTitle")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("NO_DATA_POINT_NAVIGATIONS");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.noDataText")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.DEVICE_POINT_NAVIGATION");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_POINT_NAVIGATION_TRANSFER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.transferScreen")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "listLoader.height")
            result[8] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _customList;
            }, null, "listLoader.list")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            result[10] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !listLoader.listStateHandler.editState;
            }, null, "footer.includeInLayout")
            result[11] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !listLoader.listStateHandler.editState;
            }, null, "footer.visible")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.addiconwhite;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "addButton.image")
            result[13] = new feathers.binding.Binding(this, function ():Function
            {
                return createNew_handler;
            }, null, "addButton.touchHandler")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.sortbutton;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "sortButton.image")
            result[15] = new feathers.binding.Binding(this, function ():Function
            {
                return sortList_handler;
            }, null, "sortButton.touchHandler")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.editbutton;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "editButton.image")
            result[17] = new feathers.binding.Binding(this, function ():Function
            {
                return edit_handler;
            }, null, "editButton.touchHandler")
            result[18] = new feathers.binding.Binding(this, function ():Boolean
            {
                return listLoader.listStateHandler.editState;
            }, null, "footerEdit.includeInLayout")
            result[19] = new feathers.binding.Binding(this, function ():Boolean
            {
                return listLoader.listStateHandler.editState;
            }, null, "footerEdit.visible")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.trashicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDevicePointNavigations_IconButton4.image")
            result[21] = new feathers.binding.Binding(this, function ():Function
            {
                return delete_handler;
            }, null, "_MyDevicePointNavigations_IconButton4.touchHandler")
            result[22] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.closeicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDevicePointNavigations_IconButton5.image")
            result[23] = new feathers.binding.Binding(this, function ():Function
            {
                return edit_handler;
            }, null, "_MyDevicePointNavigations_IconButton5.touchHandler")
            return result;
        }

        public var _MyDevicePointNavigations_IconButton4:frontend.components.button.IconButton;

        public var _MyDevicePointNavigations_IconButton5:frontend.components.button.IconButton;

        internal var _484847821addButton:frontend.components.button.IconButton;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


