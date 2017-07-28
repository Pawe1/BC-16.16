//class DeviceList
package frontend.screen.component.devices 
{
    import backend.utils.dbUtils.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.list.*;
    import frontend.screen.mydevices.list.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class DeviceList extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function DeviceList()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._138694455_defaultHeight = SIGMALink.containerHeight;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._DeviceList_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_component_devices_DeviceListWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.component.devices.DeviceList[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceList_ListLoader1_i()];
            this.addEventListener("addedToStage", this.___DeviceList_LayoutGroup1_addedToStage);
            this.addEventListener("initialize", this.___DeviceList_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
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

        internal function get _defaultHeight():Number
        {
            return this._138694455_defaultHeight;
        }

        internal function set _defaultHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._138694455_defaultHeight;
            if (loc1 !== arg1) 
            {
                this._138694455_defaultHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_defaultHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get dataProvider():feathers.data.ListCollection
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            this._dataProvider = arg1;
            return;
        }

        public override function set height(arg1:Number):void
        {
            super.height = arg1;
            this._defaultHeight = arg1;
            if (this._deviceList) 
            {
                this._deviceList.height = arg1;
            }
            if (this.listLoader) 
            {
                this.listLoader.height = arg1;
            }
            return;
        }

        internal function get _deviceList():frontend.components.list.CustomList
        {
            return this._1869249971_deviceList;
        }

        internal function set _deviceList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1869249971_deviceList;
            if (loc1 !== arg1) 
            {
                this._1869249971_deviceList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_deviceList", loc1, arg1, this);
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
            frontend.screen.component.devices.DeviceList._watcherSetupUtil = arg1;
            return;
        }

        protected function addedToStageHandler(arg1:starling.events.Event):void
        {
            this._deviceList.selectedItem = null;
            if (this.listLoader) 
            {
                this.listLoader.checkDataProvider();
            }
            return;
        }

        public function loadUnits(arg1:frontend.screen.component.devices.DeviceListEvent=null):void
        {
            this.listLoader.startLoading();
            handler.AppDeviceHandler.getInstance().loadUnits(new backend.utils.dbUtils.DBUtilObject(null, this.loadDevicesComplete, this.loadDevicesError, Workers.worker_DatabaseWorker));
            return;
        }

        public function setUnits(arg1:feathers.data.ListCollection):void
        {
            this._dataProvider = arg1;
            if (this.listLoader) 
            {
                this.listLoader.checkDataProvider();
            }
            return;
        }

        public function updateUnit(arg1:frontend.screen.component.devices.DeviceListEvent):void
        {
            if (!arg1.unit) 
            {
                return;
            }
            var loc1:*=this.getUnitIndex(arg1.unit);
            if (loc1 != -1) 
            {
                this._dataProvider.updateItemAt(loc1);
            }
            return;
        }

        public function deleteUnit(arg1:frontend.screen.component.devices.DeviceListEvent):void
        {
            if (!arg1.unit) 
            {
                return;
            }
            var loc1:*=this.getUnitIndex(arg1.unit);
            if (loc1 != -1) 
            {
                this._dataProvider.removeItemAt(loc1);
            }
            this.listLoader.checkDataProvider();
            if (this.completeCallback != null) 
            {
                this.completeCallback();
            }
            return;
        }

        internal function getUnitIndex(arg1:core.units.Unit):int
        {
            var loc2:*=0;
            var loc1:*=-1;
            var loc3:*=this._dataProvider.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (this._dataProvider.getItemAt(loc2).GUID == arg1.GUID) 
                {
                    loc1 = loc2;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        internal function loadDevicesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Devices konnten nicht geladen werden:\t " + arg1.message);
            return;
        }

        internal function loadDevicesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=null;
            this._dataProvider = new feathers.data.ListCollection();
            if (this._deviceList != null) 
            {
                this._deviceList.dataProvider = this._dataProvider;
            }
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = new frontend.screen.mydevices.list.MyDevicesListItem();
                loc4.unit = core.units.UnitFactory.createUnitFromDB(loc1[loc2]);
                loc4.GUID = loc4.unit.GUID;
                this._dataProvider.push(loc4);
                ++loc2;
            }
            if (this.completeCallback != null) 
            {
                this.completeCallback();
            }
            this.listLoader.stopLoading();
            return;
        }

        internal function initializeHandler(arg1:starling.events.Event):void
        {
            this._deviceList = new frontend.components.list.CustomList();
            this._deviceList.allowScrollingInPopUpMode = true;
            this._deviceList.allowMultipleSelection = false;
            this._deviceList.dataProvider = this._dataProvider;
            this._deviceList.height = this._defaultHeight;
            this._deviceList.itemRendererType = frontend.screen.mydevices.list.MyDevicesRenderer;
            this._deviceList.width = SIGMALink.appWidth;
            this._deviceList.addEventListener(starling.events.TouchEvent.TOUCH, this.onListTouch);
            this._deviceList.clipContent = true;
            this._deviceList.validateScrollPolicy();
            if (this._dataProvider == null) 
            {
                this.loadUnits();
            }
            return;
        }

        protected function onListTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.listLoader.listStateHandler.editState) 
            {
                return;
            }
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.triggeredHandler == null) 
            {
                debug.Debug.warning("callTriggeredHandler: No Trigger Function defined.");
            }
            else 
            {
                this.triggeredHandler(this._deviceList.selectedItem as frontend.screen.mydevices.list.MyDevicesListItem);
            }
            return;
        }

        internal function _DeviceList_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        public function ___DeviceList_LayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        public function ___DeviceList_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.initializeHandler(arg1);
            return;
        }

        internal function _DeviceList_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return _defaultHeight;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return _defaultHeight;
            }, null, "listLoader.height")
            result[4] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _deviceList;
            }, null, "listLoader.list")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            return result;
        }

        public function get listLoader():frontend.components.list.ListLoader
        {
            return this._159473233listLoader;
        }

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        public var completeCallback:Function;

        internal var _dataProvider:feathers.data.ListCollection;

        public var triggeredHandler:Function;

        internal var _138694455_defaultHeight:Number;

        internal var _1869249971_deviceList:frontend.components.list.CustomList;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


