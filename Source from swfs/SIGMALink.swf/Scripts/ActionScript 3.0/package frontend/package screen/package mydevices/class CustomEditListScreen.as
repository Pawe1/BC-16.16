//class CustomEditListScreen
package frontend.screen.mydevices 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.settings.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
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
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.popup.*;
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
    
    use namespace mx_internal;
    
    public class CustomEditListScreen extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function CustomEditListScreen()
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
            bindings = this._CustomEditListScreen_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_CustomEditListScreenWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return CustomEditListScreen[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._CustomEditListScreen_ListLoader1_i(), this._CustomEditListScreen_Footer1_i(), this._CustomEditListScreen_Footer2_i()];
            this.addEventListener("addedToStage", this.___CustomEditListScreen_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___CustomEditListScreen_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___CustomEditListScreen_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.initializeHandler(arg1);
            return;
        }

        internal function _CustomEditListScreen_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "listLoader.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0, 0, SIGMALink.footerHeight, 0);
            }, null, "listLoader.layoutData")
            result[2] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _customList;
            }, null, "listLoader.list")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            result[4] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !listLoader.listStateHandler.editState;
            }, null, "footer.includeInLayout")
            result[5] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !listLoader.listStateHandler.editState;
            }, null, "footer.visible")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.downloadbutton;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "downloadButton.image")
            result[7] = new feathers.binding.Binding(this, function ():Function
            {
                return fromDevice_handler;
            }, null, "downloadButton.touchHandler")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.sortbutton;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "sortButton.image")
            result[9] = new feathers.binding.Binding(this, null, null, "sortButton.includeInLayout", "isSortable");
            result[10] = new feathers.binding.Binding(this, function ():Function
            {
                return sortList_handler;
            }, null, "sortButton.touchHandler")
            result[11] = new feathers.binding.Binding(this, null, null, "sortButton.visible", "isSortable");
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.editbutton;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "editButton.image")
            result[13] = new feathers.binding.Binding(this, function ():Function
            {
                return edit_handler;
            }, null, "editButton.touchHandler")
            result[14] = new feathers.binding.Binding(this, function ():Boolean
            {
                return listLoader.listStateHandler.editState;
            }, null, "footerEdit.includeInLayout")
            result[15] = new feathers.binding.Binding(this, function ():Boolean
            {
                return listLoader.listStateHandler.editState;
            }, null, "footerEdit.visible")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.trashicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CustomEditListScreen_IconButton4.image")
            result[17] = new feathers.binding.Binding(this, function ():Function
            {
                return delete_handler;
            }, null, "_CustomEditListScreen_IconButton4.touchHandler")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.closeicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_CustomEditListScreen_IconButton5.image")
            result[19] = new feathers.binding.Binding(this, function ():Function
            {
                return edit_handler;
            }, null, "_CustomEditListScreen_IconButton5.touchHandler")
            return result;
        }

        public function get downloadButton():frontend.components.button.IconButton
        {
            return this._159077850downloadButton;
        }

        public function set downloadButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._159077850downloadButton;
            if (loc1 !== arg1) 
            {
                this._159077850downloadButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "downloadButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get editButton():frontend.components.button.IconButton
        {
            return this._1454002652editButton;
        }

        public function set editButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1454002652editButton;
            if (loc1 !== arg1) 
            {
                this._1454002652editButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editButton", loc1, arg1, this);
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

        public function get footerEdit():frontend.screen.component.Footer
        {
            return this._1420120645footerEdit;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        public function set footerEdit(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1420120645footerEdit;
            if (loc1 !== arg1) 
            {
                this._1420120645footerEdit = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footerEdit", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get listLoader():frontend.components.list.ListLoader
        {
            return this._159473233listLoader;
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

        public function get sortButton():frontend.components.button.IconButton
        {
            return this._1198925200sortButton;
        }

        public function set sortButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1198925200sortButton;
            if (loc1 !== arg1) 
            {
                this._1198925200sortButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sortButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get isSortable():Boolean
        {
            return this._868954946isSortable;
        }

        public function get noDataText():String
        {
            return this._1346902824noDataText;
        }

        public function set noDataText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1346902824noDataText;
            if (loc1 !== arg1) 
            {
                this._1346902824noDataText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "noDataText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unit():core.units.Unit
        {
            return this._3594628unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3594628unit;
            if (loc1 !== arg1) 
            {
                this._3594628unit = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unit", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _customList():frontend.components.list.CustomList
        {
            return this._493623986_customList;
        }

        protected function set _customList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._493623986_customList;
            if (loc1 !== arg1) 
            {
                this._493623986_customList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_customList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _dataProvider():feathers.data.ListCollection
        {
            return this._1763739238_dataProvider;
        }

        protected function set _dataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1763739238_dataProvider;
            if (loc1 !== arg1) 
            {
                this._1763739238_dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_dataProvider", loc1, arg1, this);
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
            CustomEditListScreen._watcherSetupUtil = arg1;
            return;
        }

        protected function loadData():void
        {
            debug.Debug.warning("please override");
            return;
        }

        protected function loadDataError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Daten konnten nicht geladen werden:\t " + arg1.message);
            return;
        }

        protected function loadDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this._dataProvider = new feathers.data.ListCollection();
            this._currentData = arg1.getResult();
            this.prepareCompletedData();
            this.sortButton.isEnabled = this.isSortable && this._dataProvider.length > 1;
            this.editButton.isEnabled = this._dataProvider.length > 0;
            if (this._customList != null) 
            {
                this._customList.dataProvider = this._dataProvider;
            }
            this.listLoader.stopLoading();
            this.listLoader.setNormalState();
            this.validateNoDataInfo();
            return;
        }

        protected function validateNoDataInfo():void
        {
            this.listLoader.noDataText = this.noDataText;
            this.listLoader.noDataIconButtonAnchor = this._dataProvider.length != 0 ? null : this.downloadButton;
            return;
        }

        protected function prepareCompletedData():void
        {
            return;
        }

        internal function initializeHandler(arg1:starling.events.Event):void
        {
            this._customList = new frontend.components.list.CustomList();
            this._customList.allowMultipleSelection = false;
            this._customList.autoHideBackground = false;
            this._customList.dataProvider = this._dataProvider;
            this._customList.height = SIGMALink.containerHeight;
            this._customList.itemRendererFactory = this.itemRenderer;
            this._customList.width = SIGMALink.appWidth;
            this._customList.addEventListener(starling.events.Event.TRIGGERED, this.triggeredHandler);
            this.initializeSortfields();
            return;
        }

        protected function itemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            debug.Debug.warning("please override");
            return new frontend.components.list.SelectableListItemRenderer();
        }

        protected function initializeSortfields():void
        {
            debug.Debug.warning("please override");
            return;
        }

        protected function sortList_handler(arg1:starling.events.TouchEvent):void
        {
            if (!this.sortPopUp) 
            {
                if (!this._sortFields) 
                {
                    return;
                }
                this.sortPopUp = new frontend.components.popup.SortPopUp(this._sortFields, this._currentSortField, this._currentAscending);
                this.sortPopUp.sortCallback = this.sortList;
            }
            frontend.components.popup.PopUpBase.showModalPopUp(this.sortPopUp, true, true, false, true);
            return;
        }

        protected function addedToStageHandler(arg1:starling.events.Event):void
        {
            this._customList.selectedItem = null;
            this._currentSortField = configCache.ConfigCache.getInstance().getValue(this.configCacheSortField, core.settings.SettingsMapper.col_modificationDate);
            this._currentAscending = configCache.ConfigCache.getInstance().getValue(this.configCacheSortField + this._currentSortField + this.configCacheSortAscending, false);
            this.loadData();
            handler.ViewHandler.getInstance().addBackFunction(this.backButtonFunction);
            return;
        }

        protected function triggeredHandler(arg1:starling.events.Event):void
        {
            debug.Debug.warning("please override");
            return;
        }

        internal function sortList(arg1:frontend.components.list.ListSortItem):void
        {
            this._currentSortField = arg1.sortField;
            configCache.ConfigCache.getInstance().setValue(this.configCacheSortField, this._currentSortField);
            this._currentAscending = arg1.ascending;
            configCache.ConfigCache.getInstance().setValue(this.configCacheSortField + this._currentSortField + this.configCacheSortAscending, this._currentAscending);
            this.loadData();
            return;
        }

        protected function delete_handler(arg1:starling.events.TouchEvent):void
        {
            if (!this.deletePopUp) 
            {
                this.deletePopUp = new frontend.components.popup.DeletePopUp();
                this.deletePopUp.title = this.deletePopUpTitle;
                this.deletePopUp.text = this.deletePopUpText;
                this.deletePopUp.cancelCallback = this.onPopUpClose;
                this.deletePopUp.deleteCallback = this.onPopUpDelete;
            }
            frontend.components.popup.PopUpBase.showModalPopUp(this.deletePopUp, true, true);
            return;
        }

        protected function onPopUpDelete():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            this.listLoader.swapState();
            return;
        }

        protected function onDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this._dataProvider.removeItem((arg1.data as backend.utils.dbUtils.DBUtilObject).data);
            this.listLoader.checkDataProvider();
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        protected function onDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteUnitError");
            return;
        }

        public function set isSortable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._868954946isSortable;
            if (loc1 !== arg1) 
            {
                this._868954946isSortable = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "isSortable", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function backButtonFunction():void
        {
            debug.Debug.warning("please override");
            return;
        }

        protected function edit_handler(arg1:starling.events.TouchEvent=null):void
        {
            this.listLoader.swapState();
            return;
        }

        internal function fromDevice_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(this.transferScreen, {"unit":this.unit, "transferModeDownload":true, "backScreenName":this.backScreenName}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _CustomEditListScreen_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        internal function _CustomEditListScreen_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._CustomEditListScreen_IconButton1_i(), this._CustomEditListScreen_IconButton2_i(), this._CustomEditListScreen_IconButton3_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _CustomEditListScreen_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "downloadButton";
            this.downloadButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "downloadButton", this.downloadButton);
            return loc1;
        }

        internal function _CustomEditListScreen_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "sortButton";
            this.sortButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sortButton", this.sortButton);
            return loc1;
        }

        internal function _CustomEditListScreen_IconButton3_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "editButton";
            this.editButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "editButton", this.editButton);
            return loc1;
        }

        internal function _CustomEditListScreen_Footer2_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.showBackButton = false;
            loc1.mxmlContent = [this._CustomEditListScreen_IconButton4_i(), this._CustomEditListScreen_IconButton5_i()];
            loc1.id = "footerEdit";
            this.footerEdit = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footerEdit", this.footerEdit);
            return loc1;
        }

        internal function _CustomEditListScreen_IconButton4_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_CustomEditListScreen_IconButton4";
            this._CustomEditListScreen_IconButton4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CustomEditListScreen_IconButton4", this._CustomEditListScreen_IconButton4);
            return loc1;
        }

        internal function _CustomEditListScreen_IconButton5_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_CustomEditListScreen_IconButton5";
            this._CustomEditListScreen_IconButton5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_CustomEditListScreen_IconButton5", this._CustomEditListScreen_IconButton5);
            return loc1;
        }

        public function ___CustomEditListScreen_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        public var _CustomEditListScreen_IconButton4:frontend.components.button.IconButton;

        public var _CustomEditListScreen_IconButton5:frontend.components.button.IconButton;

        internal var _159077850downloadButton:frontend.components.button.IconButton;

        internal var _1454002652editButton:frontend.components.button.IconButton;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1420120645footerEdit:frontend.screen.component.Footer;

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        internal var _1198925200sortButton:frontend.components.button.IconButton;

        public var backScreenName:String="";

        public var configCacheSortField:String="";

        public var deletePopUpText:String="";

        public var deletePopUpTitle:String="";

        internal var _868954946isSortable:Boolean=true;

        internal var _1346902824noDataText:String="no data";

        public var transferScreen:String="";

        internal var _3594628unit:core.units.Unit;

        protected var _currentAscending:Boolean;

        protected var _currentData:Array;

        protected var _currentSortField:String;

        protected var _493623986_customList:frontend.components.list.CustomList;

        protected var _1763739238_dataProvider:feathers.data.ListCollection;

        protected var _sortFields:__AS3__.vec.Vector.<frontend.components.list.ListSortItem>;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var sortPopUp:frontend.components.popup.SortPopUp;

        public var configCacheSortAscending:String="";

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


