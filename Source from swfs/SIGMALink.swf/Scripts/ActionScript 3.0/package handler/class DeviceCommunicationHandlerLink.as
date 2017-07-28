//class DeviceCommunicationHandlerLink
package handler 
{
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
    import flash.data.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import handler.dockingstation.*;
    import handler.event.*;
    import service.*;
    import service.ble.*;
    import service.event.*;
    
    public class DeviceCommunicationHandlerLink extends service.DeviceCommunicationHandler
    {
        public function DeviceCommunicationHandlerLink(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            this.startServices();
            return;
        }

        public function reinitCurrentOnlineUnit():void
        {
            this.resetInitialisedUnit();
            this.loadRequiredUnitData();
            return;
        }

        internal function onBatteryStatusChange(arg1:flash.events.Event):void
        {
            this.currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.BATTERY_INFORMATION_LOADED_FROM_UNIT_COMPLETE, this.onBatteryStatusChange);
            debug.Debug.debug("Battery Status geladen");
            this._batteryStatusInitialised = true;
            if (this.checkUnitIfInitalised()) 
            {
                dispatchEvent(new flash.events.Event(CURRENT_ONLINE_UNIT_INITIALISED));
            }
            return;
        }

        public function get currentDSHandler():handler.dockingstation.DockingStationHandler
        {
            return this._currentDSHandler;
        }

        public function set currentDSHandler(arg1:handler.dockingstation.DockingStationHandler):void
        {
            this._currentDSHandler = arg1;
            return;
        }

        internal function onUnitInitialised(arg1:flash.events.Event):void
        {
            removeEventListener(CURRENT_ONLINE_UNIT_INITIALISED, this.onUnitInitialised);
            debug.Debug.debug("unit initialised");
            return;
        }

        public function get currentOnlineUnit():core.units.Unit
        {
            return this._currentOnlineUnit;
        }

        public function set currentOnlineUnit(arg1:core.units.Unit):void
        {
            if (this._currentOnlineUnit !== arg1) 
            {
                this._currentOnlineUnit = arg1;
                dispatchEvent(new flash.events.Event(CURRENT_ONLINE_UNIT_CHANGE));
            }
            return;
        }

        public function get currentOnlineUnitHandler():handler.UnitHandler
        {
            return this._currentUnitHandler;
        }

        public function set currentOnlineUnitHandler(arg1:handler.UnitHandler):void
        {
            if (this._currentUnitHandler != arg1) 
            {
                if (this._currentUnitHandler != null) 
                {
                    this._currentUnitHandler.removeEventListener(handler.event.ProgressStatusEvent.PROGRESS, this.onProgressStatusEvent);
                }
                this._currentUnitHandler = arg1;
                if (this._currentUnitHandler != null) 
                {
                    this._currentUnitHandler.addEventListener(handler.event.ProgressStatusEvent.PROGRESS, this.onProgressStatusEvent);
                }
                dispatchEvent(new flash.events.Event(EVENT_CURRENT_ONLINE_UNIT_HANDLER_CHANGED));
            }
            return;
        }

        internal function loadRequiredUnitData():void
        {
            if (!this.currentOnlineUnit) 
            {
            };
            return;
        }

        public function checkUnitIfInitalised():Boolean
        {
            if (this.currentOnlineUnit == null) 
            {
                return false;
            }
            if ((this.currentOnlineUnit is core.units.UnitROX || this.currentOnlineUnit is core.units.UnitROX2010 || this.currentOnlineUnit is core.units.UnitTopline2009 || this.currentOnlineUnit is core.units.UnitTopline2012) && !this._memoryInitialised) 
            {
                return false;
            }
            if (this.currentOnlineUnit is core.units.interfaces.ILogList && !this._pageHeaderInitialised) 
            {
                return false;
            }
            if (this.currentOnlineUnit is core.units.interfaces.ILogStatus && !this._logStatusInitialised) 
            {
                return false;
            }
            if (this.currentOnlineUnit is core.units.interfaces.ITrackList && !this._tracksInitialised) 
            {
                return false;
            }
            this.currentOnlineUnit.isOnline = true;
            if (this.currentOnlineUnit.unitId <= 0) 
            {
                return false;
            }
            return true;
        }

        internal function onLogPageHeaderLoadFromDeviceComplete(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.currentTarget as handler.UnitHandler;
            loc1.removeEventListener(handler.UnitHandler.PAGE_HEADER_CHANGE, this.onLogPageHeaderLoadFromDeviceComplete);
            if (this.currentOnlineUnit != null) 
            {
                this._pageHeaderInitialised = true;
                if (this.currentOnlineUnit is core.units.UnitROX || this.currentOnlineUnit is core.units.UnitROX2010 || this.currentOnlineUnit is core.units.UnitRC1411 || this.currentOnlineUnit is core.units.UnitROX2012) 
                {
                    this._logStatusInitialised = true;
                }
                if (this.checkUnitIfInitalised()) 
                {
                    dispatchEvent(new flash.events.Event(CURRENT_ONLINE_UNIT_INITIALISED));
                }
            }
            return;
        }

        internal function onTrackFileHeaderLoadFromDeviceComplete(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.currentTarget as handler.UnitHandler;
            loc1.removeEventListener(handler.UnitHandler.PLANED_TRACKS_LOADED_COMPLETE, this.onTrackFileHeaderLoadFromDeviceComplete);
            if (this.currentOnlineUnit != null) 
            {
                this._tracksInitialised = true;
                if (this.checkUnitIfInitalised()) 
                {
                    dispatchEvent(new flash.events.Event(CURRENT_ONLINE_UNIT_INITIALISED));
                }
            }
            return;
        }

        internal function onLogStatusLoaded(arg1:flash.events.Event):void
        {
            (arg1.currentTarget as handler.UnitHandler).removeEventListener(handler.UnitHandler.LOG_STATUS_LOADED_FROM_UNIT_COMPLETE, this.onLogStatusLoaded);
            this._logStatusInitialised = true;
            if (this.checkUnitIfInitalised()) 
            {
                dispatchEvent(new flash.events.Event(CURRENT_ONLINE_UNIT_INITIALISED));
            }
            return;
        }

        internal function onMemoriesLoadedFromDeviceComplete(arg1:flash.events.Event):void
        {
            this.currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.MEMORIES_LOADED_FROM_UNIT_COMPLETE, this.onMemoriesLoadedFromDeviceComplete);
            if (this.currentOnlineUnit != null) 
            {
                this._memoryInitialised = true;
                if (this.checkUnitIfInitalised()) 
                {
                    dispatchEvent(new flash.events.Event(CURRENT_ONLINE_UNIT_INITIALISED));
                }
            }
            return;
        }

        
        {
            deviceCommunicationMode = false;
        }

        public static function getInstance():handler.DeviceCommunicationHandlerLink
        {
            if (_instance == null) 
            {
                _instance = new DeviceCommunicationHandlerLink();
                service.DeviceCommunicationHandler.setInstance(_instance);
            }
            return _instance;
        }

        protected override function initServices():void
        {
            return;
        }

        internal function onProgressStatusEvent(arg1:handler.event.ProgressStatusEvent):void
        {
            var loc1:*=new handler.event.ProgressStatusEvent(arg1.type, arg1.statusPercentCurrentLog, arg1.currentLogIndex, arg1.logSize, arg1.description, arg1.bubbles, arg1.cancelable);
            dispatchEvent(loc1);
            return;
        }

        public function startServices():void
        {
            debug.Debug.debug("startServices");
            addEventListener(service.event.DeviceConnectionEvent.DEVICE_CONNECTED, this.onDockingstationConnected);
            addEventListener(service.event.DeviceConnectionEvent.DEVICE_ALREADY_CONNECTED, this.onDockingstationConnected);
            addEventListener(service.event.DeviceConnectionEvent.DEVICE_DISCONNECTED, this.onDockingstationDisconnected);
            return;
        }

        public override function initCommunicationServices(arg1:Boolean=true):void
        {
            return;
        }

        public function getUnitBySerialNumberAndType(arg1:String, arg2:core.general.UnitType, arg3:Function, arg4:Object=null):void
        {
            var serialNumber:String;
            var type:core.general.UnitType;
            var callBack:Function;
            var p_data:Object=null;
            var stmt:String;
            var onComplete:Function;
            var loadActivityError:Function;

            var loc1:*;
            onComplete = null;
            loadActivityError = null;
            serialNumber = arg1;
            type = arg2;
            callBack = arg3;
            p_data = arg4;
            onComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
            {
                var loc1:*=arg1.getResult();
                var loc2:*=null;
                if (!(loc1 == null) && loc1.length > 0) 
                {
                    loc2 = core.units.UnitFactory.createUnitFromDB(loc1.shift());
                }
                callBack(loc2, p_data);
                return;
            }
            loadActivityError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
            {
                debug.Debug.error("activityEntriesError");
                callBack(null, p_data);
                return;
            }
            stmt = handler.AppDeviceHandler.getInstance().generateLoadUnitBySerialNumberAndType(serialNumber, type.toString());
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onComplete, loadActivityError, null);
            return;
        }

        internal function onStartScanDockingStation(arg1:flash.events.Event):void
        {
            debug.Debug.debug("onStartScanDockingStation");
            if (this.currentDSHandler) 
            {
                this.currentDSHandler.startScanDockingStation();
            }
            return;
        }

        internal function onStopScanDockingStation(arg1:flash.events.Event):void
        {
            debug.Debug.debug("onStopScanDockingStation");
            if (this.currentDSHandler) 
            {
                this.currentDSHandler.stopScanDockingStation();
            }
            return;
        }

        internal function onDockingstationConnected(arg1:service.event.DeviceConnectionEvent):void
        {
            debug.Debug.debug("onDockingstationConnected");
            this.currentDSHandler = handler.HandlerFactory.getImplementationFromDS(arg1.dockingStation);
            this.currentDSHandler.port = arg1.usbPort;
            if (this.currentOnlineUnitHandler) 
            {
                this.currentOnlineUnitHandler.port = arg1.usbPort;
            }
            if (this.currentDSHandler is handler.dockingstation.BLEDSHandler || this.currentDSHandler is handler.dockingstation.BLERox11DSHandler) 
            {
                this.currentDSHandler.addEventListener(handler.dockingstation.DockingStationHandler.UNIT_DISCONNECTED_EVENT, this.onUnitOnDSDisconnected, false, 0, true);
                if (arg1.type == service.event.DeviceConnectionEvent.DEVICE_CONNECTED) 
                {
                    if (service.ble.BLEHandler.loadUnitInformationOnConnect) 
                    {
                        debug.Debug.debug("BLE Gerät verbunden... Lade LOAD_UNIT_INFORMATION verzögert mit 2sek.");
                        flash.utils.setTimeout(this.currentDSHandler.loadFromDC, 2000, handler.dockingstation.DockingStationHandler.LOAD_UNIT_INFORMATION);
                    }
                }
            }
            else if (!(this.currentDSHandler is handler.dockingstation.NFCDSHandler)) 
            {
                if (this.FWUpdateMode) 
                {
                    this.currentDSHandler.stopScanDockingStation();
                }
                else 
                {
                    this.currentDSHandler.addEventListener(handler.dockingstation.DockingStationHandler.UNIT_DISCONNECTED_EVENT, this.onUnitOnDSDisconnected, false, 0, true);
                    this.currentDSHandler.scanDockingStation();
                }
            }
            return;
        }

        internal function onDockingstationDisconnected(arg1:service.event.DeviceConnectionEvent):void
        {
            debug.Debug.debug("onDockingstationDisconnected");
            if (this.currentDSHandler != null) 
            {
                this.currentDSHandler.destructor();
                this.currentDSHandler.removeEventListener(handler.dockingstation.DockingStationHandler.UNIT_DISCONNECTED_EVENT, this.onUnitOnDSDisconnected);
            }
            if (this.currentOnlineUnitHandler != null) 
            {
                this.currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.PAGE_HEADER_CHANGE, this.onLogPageHeaderLoadFromDeviceComplete);
                this.currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.MEMORIES_LOADED_FROM_UNIT_COMPLETE, this.onMemoriesLoadedFromDeviceComplete);
                this.currentOnlineUnitHandler = null;
            }
            this.currentDSHandler = null;
            if (this.currentOnlineUnit != null) 
            {
                this.currentOnlineUnit.isOnline = false;
                this.currentOnlineUnit = null;
            }
            this.resetInitialisedUnit();
            return;
        }

        internal function onUnitOnDSDisconnected(arg1:flash.events.Event):void
        {
            debug.Debug.debug("onUnitOnDSDisconnected");
            if (this.currentOnlineUnit != null) 
            {
                this.currentOnlineUnit.isOnline = false;
            }
            if (this.currentOnlineUnitHandler != null) 
            {
                this.currentOnlineUnitHandler.destructor();
                this.currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.PAGE_HEADER_CHANGE, this.onLogPageHeaderLoadFromDeviceComplete);
                this.currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.MEMORIES_LOADED_FROM_UNIT_COMPLETE, this.onMemoriesLoadedFromDeviceComplete);
                this.currentOnlineUnitHandler = null;
            }
            this.currentOnlineUnit = null;
            this.resetInitialisedUnit();
            return;
        }

        protected override function onDeviceDisconnected(arg1:flash.events.Event):void
        {
            arg1.stopImmediatePropagation();
            handler.CommunicationHandling.getInstance().onDeviceDisconnected(arg1);
            return;
        }

        internal function resetInitialisedUnit():void
        {
            this._memoryInitialised = false;
            this._pageHeaderInitialised = false;
            this._logStatusInitialised = false;
            this._batteryStatusInitialised = false;
            this._tracksInitialised = false;
            return;
        }

        public static const EVENT_CURRENT_ONLINE_UNIT_HANDLER_CHANGED:String="EVENT_CURRENT_ONLINE_UNIT_HANDLER_CHANGED";

        public static const CURRENT_ONLINE_UNIT_CHANGE:String="currentOnlineUnitChange";

        public static const ROUTE_DISTANCE_CALCULATED:String="routeDistanceCalculated";

        public static const TRACK_LIST_CHANGED:String="currentOnlineUnitTrackListChanged";

        public static const CURRENT_ONLINE_UNIT_INITIALISED:String="currentOnlineUnitInitialised";

        public static const RESTART_COMPLETE:String="restartCompleteEvent";

        public var FWUpdateMode:Boolean=false;

        internal var _currentDSHandler:handler.dockingstation.DockingStationHandler;

        internal var _currentOnlineUnit:core.units.Unit;

        internal var _batteryStatusInitialised:Boolean=false;

        internal var _currentUnitHandler:handler.UnitHandler;

        internal var _logStatusInitialised:Boolean=false;

        internal var _memoryInitialised:Boolean=false;

        internal var _pageHeaderInitialised:Boolean=false;

        internal var _toBGChannel:flash.system.MessageChannel;

        internal var _toMainChannel:flash.system.MessageChannel;

        internal var _tracksInitialised:Boolean=false;

        public static var deviceCommunicationMode:Boolean=false;

        internal static var _instance:handler.DeviceCommunicationHandlerLink;
    }
}


