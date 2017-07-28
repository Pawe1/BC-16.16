//class CommunicationHandling
package handler 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.general.*;
    import core.units.*;
    import core.units.interfaces.*;
    import de.pagecon.ane.nfc.*;
    import de.pagecon.ane.nfc.events.*;
    import debug.*;
    import feathers.data.*;
    import flash.data.*;
    import flash.events.*;
    import flash.utils.*;
    import frontend.screen.mydevices.list.*;
    import handler.dockingstation.*;
    import handler.event.*;
    import handler.interfaces.*;
    import service.*;
    import service.ble.*;
    import service.ble.event.*;
    import service.event.*;
    import service.nfc.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class CommunicationHandling extends starling.events.EventDispatcher
    {
        public function CommunicationHandling()
        {
            this.currentDevices = new Vector.<core.units.Unit>();
            super();
            service.DeviceCommunicationHandler.handleConnectionModeAutomatically = false;
            return;
        }

        internal function initNFC():void
        {
            debug.Debug.debug("+++ initNFC");
            handler.DeviceCommunicationHandlerLink.getInstance().initNFCService();
            handler.DeviceCommunicationHandlerLink.getInstance().useNfcCommunicationHandler();
            de.pagecon.ane.nfc.NfcController.instance.addEventListener(de.pagecon.ane.nfc.events.NfcEvent.EVENT_NFC_ON_INVOKE, this.onNfcInvoke, false, 100);
            de.pagecon.ane.nfc.NfcController.instance.addEventListener(de.pagecon.ane.nfc.events.NfcEvent.EVENT_NFC_STATUS_CHANGED, this.onNfcStatusChanged);
            return;
        }

        internal function onNfcInvoke(arg1:flash.events.Event):void
        {
            debug.Debug.debug("+++ onNfcInvoke");
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener(de.pagecon.ane.nfc.events.NfcEvent.EVENT_NFC_ON_INVOKE, this.onNfcInvoke);
            handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_NFC;
            this.onNfcStatusChanged();
            return;
        }

        public function get communicationMode():int
        {
            return this._communicationMode;
        }

        public function set communicationMode(arg1:int):void
        {
            this._communicationMode = arg1;
            return;
        }

        internal function onOnlineUnitHandlerChanged(arg1:flash.events.Event):void
        {
            debug.Debug.debug("+++ onOnlineUnitHandlerChanged");
            if (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler) 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.EVENT_UNIT_SERIALNUMBER_DO_NOT_MATCH, this.onDeviceNotMatch);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.EVENT_UNIT_TYPE_DO_NOT_MATCH, this.onDeviceNotMatch);
            }
            return;
        }

        public function get currentDevice():core.units.Unit
        {
            return this._currentDevice;
        }

        public function set currentDevice(arg1:core.units.Unit):void
        {
            if (this._currentDevice != arg1) 
            {
                this._currentDevice = arg1;
                configCache.ConfigCache.getInstance().setValue(LAST_SELECTED_CURRENT_DEVICE_TYPE, this._currentDevice.GUID);
                dispatchEventWith(CURRENT_DEVICE_CHANGED);
            }
            return;
        }

        internal function scanForNewBLEDevice():void
        {
            debug.Debug.debug("+++ scanForNewBLEDevice");
            this.waitForPairingRequest = true;
            handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(service.ble.event.BLEDeviceEvent.DEVICE_FOUND, this.onBleDeviceFound);
            handler.DeviceCommunicationHandlerLink.getInstance().initBLEService(false);
            this._connectBLETimeout = flash.utils.setTimeout(handler.DeviceCommunicationHandlerLink.getInstance().startScanForNewWirelessDevices, 3000, [(this.currentDevice as core.units.interfaces.IBLEDeviceInfo).primaryServiceUUID]);
            return;
        }

        internal function validateConnectionMode():void
        {
            debug.Debug.debug("+++ validateConnectionMode");
            handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(service.event.DeviceCommunicationEvent.EVENT_COMMUNICATION_ERROR, this.onError);
            handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(handler.DeviceCommunicationHandlerLink.EVENT_CURRENT_ONLINE_UNIT_HANDLER_CHANGED, this.onOnlineUnitHandlerChanged);
            var loc1:*=service.DeviceCommunicationHandler.getInstance().isNfcSupported() && service.DeviceCommunicationHandler.getInstance().isNFCEnabled();
            var loc2:*=service.DeviceCommunicationHandler.getInstance().isBleSupported() && service.DeviceCommunicationHandler.getInstance().isBLEEnabled();
            var loc3:*=service.DeviceCommunicationHandler.getInstance().isUsbSupported();
            var loc4:*=false;
            var loc5:*=false;
            var loc6:*=this._communicationMode;
            switch (loc6) 
            {
                case DEVICE_NFC_ONLY:
                {
                    if (loc1) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_NFC;
                    }
                    break;
                }
                case DEVICE_BLE_ONLY:
                {
                    if (loc2) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_BLE;
                    }
                    break;
                }
                case DEVICE_USB_AND_BLE:
                {
                    if (this.ignoreUSB && loc3) 
                    {
                        loc3 = false;
                    }
                    if (loc2 && loc3) 
                    {
                        loc4 = true;
                    }
                    else if (loc3) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_USB;
                    }
                    else if (loc2) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_BLE;
                    }
                    break;
                }
                case DEVICE_USB_AND_NFC:
                {
                    if (this.ignoreUSB && loc3) 
                    {
                        loc3 = false;
                    }
                    if (loc1 && loc3) 
                    {
                        loc5 = true;
                    }
                    else if (loc3) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_USB;
                    }
                    else if (loc1) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_NFC;
                    }
                    break;
                }
                case DEVICE_USB_ONLY:
                case DEVICE_DST_ONLY:
                {
                    if (loc3) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_USB;
                    }
                    break;
                }
                case DEVICE_DST_AND_NFC:
                {
                    if (this.ignoreUSB && loc3) 
                    {
                        loc3 = false;
                    }
                    if (loc1 && loc3) 
                    {
                        loc5 = true;
                    }
                    else if (loc3) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_USB;
                    }
                    else if (loc1) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_NFC;
                    }
                    break;
                }
                default:
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_NONE;
                }
            }
            if (handler.DeviceCommunicationHandlerLink.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_NFC || loc5) 
            {
                this.initNFC();
            }
            if (handler.DeviceCommunicationHandlerLink.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_BLE || loc4) 
            {
                if (!this._bleScanComplete && this._isNewDevice) 
                {
                    this.scanForNewBLEDevice();
                }
                else 
                {
                    this.tryToConnectBLEDevice(true);
                }
            }
            if (handler.DeviceCommunicationHandlerLink.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_USB || loc4 || loc5) 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(service.event.DeviceConnectionEvent.DEVICE_CONNECTED, this.onUSBConnected);
                handler.DeviceCommunicationHandlerLink.getInstance().initUSBService(false);
                handler.DeviceCommunicationHandlerLink.getInstance().checkConnectedUSBDevice();
            }
            return;
        }

        internal function onBleDeviceFound(arg1:service.ble.event.BLEDeviceEvent):void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.ble.event.BLEDeviceEvent.DEVICE_FOUND, this.onBleDeviceFound);
            debug.Debug.debug("+++ BLE DEVICE FOUND " + arg1.bleDevice.localName);
            (this.currentDevice as core.units.interfaces.IBLEDeviceInfo).deviceID = arg1.bleDevice.deviceID;
            (this.currentDevice as core.units.interfaces.IBLEDeviceInfo).dsHandler = arg1.bleDevice.dsHandler;
            (this.currentDevice as core.units.interfaces.IBLEDeviceInfo).localName = arg1.bleDevice.localName;
            (this.currentDevice as core.units.interfaces.IBLEDeviceInfo).primaryServiceUUID = arg1.bleDevice.primaryServiceUUID;
            this._bleScanComplete = true;
            this.tryToConnectBLEDevice(false);
            return;
        }

        internal function tryToConnectBLEDevice(arg1:Boolean=false):void
        {
            debug.Debug.debug("+++ tryToConnectBLEDevice");
            handler.DeviceCommunicationHandlerLink.getInstance().addDeviceToDeviceList(this.currentDevice as core.units.interfaces.IBLEDeviceInfo);
            handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(service.event.DeviceConnectionEvent.DEVICE_CONNECTED, this.onBLEConnected);
            handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(service.event.DeviceConnectionEvent.DEVICE_ALREADY_CONNECTED, this.onBLEConnected);
            if (arg1) 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().initBLEService(false);
            }
            handler.DeviceCommunicationHandlerLink.getInstance().checkIDsAndConnect();
            this._connectBLETimeout = flash.utils.setTimeout(this.onInitCommunicationTimeout, 30000);
            return;
        }

        public function stopCommunication():void
        {
            if (this._communicationStopped) 
            {
                debug.Debug.debug("stopCommunication > already stopped");
                return;
            }
            debug.Debug.debug("stopCommunication...");
            this._communicationStopped = true;
            flash.utils.clearTimeout(this._communicationFunctionTimeout);
            handler.DeviceCommunicationHandlerLink.deviceCommunicationMode = false;
            service.ble.BLEHandler.loadUnitInformationOnConnect = true;
            this._bleScanComplete = false;
            this._isNewDevice = false;
            this.waitForPairingRequest = false;
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.event.DeviceCommunicationEvent.EVENT_COMMUNICATION_ERROR, this.onError);
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(handler.DeviceCommunicationHandlerLink.EVENT_CURRENT_ONLINE_UNIT_HANDLER_CHANGED, this.onOnlineUnitHandlerChanged);
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.event.DeviceConnectionEvent.DEVICE_CONNECTED, this.onBLEConnected);
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.event.DeviceConnectionEvent.DEVICE_CONNECTED, this.onUSBConnected);
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.event.DeviceConnectionEvent.DEVICE_ALREADY_CONNECTED, this.onBLEConnected);
            if (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler) 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.EVENT_UNIT_SERIALNUMBER_DO_NOT_MATCH, this.onDeviceNotMatch);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.EVENT_UNIT_TYPE_DO_NOT_MATCH, this.onDeviceNotMatch);
            }
            this._communicationMode = DEVICE_UNKNOWN;
            this.stopNFCCommunication();
            this.stopBLECommunication();
            this.stopUSBCommunication();
            if (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler is handler.interfaces.IHandlerDispose) 
            {
                (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler as handler.interfaces.IHandlerDispose).disposeHandler();
            }
            handler.DeviceCommunicationHandlerLink.getInstance().resetCommunicationService();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler = null;
            this._currentDevice = null;
            return;
        }

        protected function stopNFCCommunication():void
        {
            var loc1:*;
            debug.Debug.debug("+++ stopNFCCommunication");
            try 
            {
                if (service.nfc.NFCHandler.getInstance() && service.nfc.NFCHandler.getInstance().isNfcSupported) 
                {
                    de.pagecon.ane.nfc.NfcController.instance.removeEventListener(de.pagecon.ane.nfc.events.NfcEvent.EVENT_NFC_ON_INVOKE, this.onNfcInvoke);
                    de.pagecon.ane.nfc.NfcController.instance.removeEventListener(de.pagecon.ane.nfc.events.NfcEvent.EVENT_NFC_STATUS_CHANGED, this.onNfcStatusChanged);
                    handler.DeviceCommunicationHandlerLink.getInstance().destroyNFCService();
                }
            }
            catch (e:Error)
            {
                debug.Debug.error("stopNFCCommunication ERROR: " + e.message);
            }
            return;
        }

        protected function stopBLECommunication():void
        {
            var loc1:*;
            debug.Debug.debug("+++ stopBLECommunication");
            flash.utils.clearTimeout(this._connectBLETimeout);
            try 
            {
                if (service.DeviceCommunicationHandler.getInstance().isBleSupported() && this.currentDevice is core.units.interfaces.IBLEDeviceInfo) 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().removeDeviceFromDeviceList(this.currentDevice as core.units.interfaces.IBLEDeviceInfo);
                    handler.DeviceCommunicationHandlerLink.getInstance().disconnect(this.currentDevice as core.units.interfaces.IBLEDeviceInfo);
                    handler.DeviceCommunicationHandlerLink.getInstance().destroyBLEService();
                }
            }
            catch (e:Error)
            {
                debug.Debug.error("stopBLECommunication ERROR: " + e.message);
            }
            return;
        }

        protected function stopUSBCommunication():void
        {
            var loc1:*;
            debug.Debug.debug("+++ stopUSBCommunication");
            flash.utils.clearTimeout(this._connectUSBTimeout);
            try 
            {
                if (service.DeviceCommunicationHandler.getInstance().isUsbSupported()) 
                {
                    if (handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.scanDockingStationStopped = false;
                        handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.destructor();
                    }
                    if (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler) 
                    {
                        handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.destructor();
                    }
                    handler.DeviceCommunicationHandlerLink.getInstance().destroyUSBService();
                }
            }
            catch (e:Error)
            {
                debug.Debug.error("stopUSBCommunication ERROR: " + e.message);
            }
            return;
        }

        public function onDeviceDisconnected(arg1:flash.events.Event):void
        {
            if (this._communicationStopped) 
            {
                return;
            }
            debug.Debug.debug("onDeviceDisconnected");
            dispatchEventWith(COMMUNICATION_ERROR);
            return;
        }

        protected function onNfcStatusChanged(arg1:flash.events.Event=null):void
        {
            debug.Debug.debug("+++ onNfcStatusChanged");
            if (this.communicationFunction != null) 
            {
                this.communicationFunction();
            }
            return;
        }

        protected function onBLEConnected(arg1:service.event.DeviceConnectionEvent):void
        {
            if (!service.DeviceCommunicationHandler.getInstance().isBleConnected) 
            {
                debug.Debug.debug("+++ onBLEConnected > USBConnectedEvent???");
                return;
            }
            debug.Debug.debug("+++ onBLEConnected");
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.event.DeviceConnectionEvent.DEVICE_CONNECTED, this.onBLEConnected);
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.event.DeviceConnectionEvent.DEVICE_CONNECTED, this.onUSBConnected);
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.event.DeviceConnectionEvent.DEVICE_ALREADY_CONNECTED, this.onBLEConnected);
            flash.utils.clearTimeout(this._connectBLETimeout);
            flash.utils.clearTimeout(this._communicationFunctionTimeout);
            this.stopUSBCommunication();
            this.stopNFCCommunication();
            handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_BLE;
            if (this._isNewDevice) 
            {
                this._communicationFunctionTimeout = flash.utils.setTimeout(this.onBLEStatusChanged, SEND_COMMAND_NEW_DEVICE_DELAY);
            }
            else 
            {
                this._communicationFunctionTimeout = flash.utils.setTimeout(this.onBLEStatusChanged, SEND_COMMAND_DELAY);
            }
            return;
        }

        protected function onBLEStatusChanged(arg1:service.event.DeviceConnectionEvent=null, arg2:Boolean=true):void
        {
            debug.Debug.debug("+++ onBLEStatusChanged");
            if (this.communicationFunction != null) 
            {
                if (arg2) 
                {
                    this._communicationFunctionTimeout = flash.utils.setTimeout(this.communicationFunction, SEND_COMMAND_DELAY);
                }
                else 
                {
                    this.communicationFunction();
                }
            }
            return;
        }

        protected function onUSBConnected(arg1:service.event.DeviceConnectionEvent):void
        {
            if (service.DeviceCommunicationHandler.getInstance().isBleConnected || !handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler) 
            {
                debug.Debug.debug("+++ onUSBConnected > BLE");
                return;
            }
            if (arg1.dockingStation == core.general.DockingStations.DS_NFC) 
            {
                debug.Debug.debug("+++ onUSBConnected > NFC");
                return;
            }
            debug.Debug.debug("+++ onUSBConnected");
            flash.utils.clearTimeout(this._connectUSBTimeout);
            flash.utils.clearTimeout(this._communicationFunctionTimeout);
            this.stopBLECommunication();
            this.stopNFCCommunication();
            handler.DeviceCommunicationHandlerLink.getInstance().connectionMode = service.DeviceCommunicationHandler.CONNECTION_MODE_USB;
            handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.stopScanDockingStation();
            handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.resetCheckConnectionTimeOut();
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.event.DeviceConnectionEvent.DEVICE_CONNECTED, this.onUSBConnected);
            handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.event.DeviceConnectionEvent.DEVICE_CONNECTED, this.onBLEConnected);
            if (de.pagecon.ane.nfc.NfcController.instance) 
            {
                de.pagecon.ane.nfc.NfcController.instance.removeEventListener(de.pagecon.ane.nfc.events.NfcEvent.EVENT_NFC_ON_INVOKE, this.onNfcInvoke);
            }
            handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.addEventListener(handler.dockingstation.DockingStationHandler.UNIT_INITIALISED_EVENT, this.onUnitInitialised);
            return;
        }

        internal function onUnitInitialised(arg1:handler.event.UnitEvent):void
        {
            debug.Debug.debug("+++ onUnitInitialised");
            handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.removeEventListener(handler.dockingstation.DockingStationHandler.UNIT_INITIALISED_EVENT, this.onUnitInitialised);
            if (arg1.unit.type == this.currentDevice.type && (this._isNewDevice || arg1.unit.serialNumber == this.currentDevice.serialNumber)) 
            {
                if (arg1.unit.softwareRevision != this.currentDevice.softwareRevision) 
                {
                    this.currentDevice.softwareRevision = arg1.unit.softwareRevision;
                    this.updateFirmwareInDB();
                }
                this.currentUSBEvent = arg1;
                this.onUSBStatusChanged();
            }
            else 
            {
                this.onDeviceNotMatch();
            }
            return;
        }

        internal function updateFirmwareInDB():void
        {
            var loc1:*="UPDATE " + core.units.Unit.table_name + " SET " + core.units.Unit.col_softwareRevision + " = \'" + this.currentDevice.softwareRevision + "\' WHERE " + core.units.Unit.col_GUID + " = \'" + this.currentDevice.GUID + "\'";
            new backend.utils.dbUtils.DBUtil().call(flash.data.SQLMode.UPDATE, loc1, this.onUpdateUnitComplete, this.onUpdateUnitErrore);
            return;
        }

        internal function onUpdateUnitComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onUpdateUnitComplete");
            return;
        }

        internal function onUpdateUnitErrore(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onUpdateUnitErrore");
            return;
        }

        protected function onUSBStatusChanged():void
        {
            debug.Debug.debug("+++ onUSBStatusChanged");
            if (this.communicationFunction != null) 
            {
                this._communicationFunctionTimeout = flash.utils.setTimeout(this.communicationFunction, SEND_COMMAND_DELAY);
            }
            return;
        }

        public function getSelectedDeviceFromCache():core.units.Unit
        {
            var loc3:*=0;
            var loc1:*=handler.CommunicationHandling.getInstance().currentDevices[0].GUID.toString();
            var loc2:*=configCache.ConfigCache.getInstance().getValue(handler.CommunicationHandling.LAST_SELECTED_CURRENT_DEVICE_TYPE, loc1) as String;
            var loc4:*=this.currentDevices.length;
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (this.currentDevices[loc3].GUID == loc2) 
                {
                    return this.currentDevices[loc3];
                }
                ++loc3;
            }
            return handler.CommunicationHandling.getInstance().currentDevices[0];
        }

        public function onNFCSettingChangedByUser():void
        {
            debug.Debug.debug("+++ onNFCSettingChangedByUser");
            var loc1:*=this._isNewDevice;
            this.stopCommunication();
            this.initCurrentDeviceCommunication(loc1);
            return;
        }

        public function onBLESettingChangedByUser():void
        {
            debug.Debug.debug("+++ onBLESettingChangedByUser");
            var loc1:*=this._isNewDevice;
            this.stopCommunication();
            flash.utils.setTimeout(this.initCurrentDeviceCommunication, 1000, loc1);
            return;
        }

        public function initCurrentDeviceCommunication(arg1:Boolean=false):void
        {
            debug.Debug.debug("+++ initCurrentDeviceCommunication");
            if (this._communicationStopped) 
            {
                this._communicationStopped = false;
                this._isNewDevice = arg1;
                this.checkCommunicationMode();
                this.initCommunication();
            }
            else if (this.communicationFunction != null) 
            {
                this._communicationFunctionTimeout = flash.utils.setTimeout(this.communicationFunction, SEND_COMMAND_DELAY);
            }
            return;
        }

        public function loadSavedDevices(arg1:Function, arg2:Boolean=true):void
        {
            this._loadDevicedCompleteCallback = arg1;
            if (this.reloadSavedDevicesFlag) 
            {
                this.reloadSavedDevicesFlag = false;
                handler.AppDeviceHandler.getInstance().loadUnits(new backend.utils.dbUtils.DBUtilObject(null, this.loadDevicesComplete, this.loadDevicesError, arg2 ? Workers.worker_DatabaseWorker : null));
            }
            else if (this._loadDevicedCompleteCallback != null) 
            {
                this._loadDevicedCompleteCallback();
            }
            return;
        }

        internal function loadDevicesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=null;
            this.currentDevices = new Vector.<core.units.Unit>();
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = core.units.UnitFactory.createUnitFromType(core.general.UnitType.fromString(loc1[loc2].type));
                loc4.fromDB(loc1[loc2]);
                this.currentDevices.push(loc4);
                ++loc2;
            }
            if (this._loadDevicedCompleteCallback != null) 
            {
                this._loadDevicedCompleteCallback();
            }
            return;
        }

        internal function loadDevicesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Fehler beim laden der Devices");
            return;
        }

        public function getCurrentDevicesDataProvider():feathers.data.ListCollection
        {
            var loc2:*=0;
            var loc4:*=null;
            this.reloadSavedDevicesFlag = true;
            this.loadSavedDevices(null, false);
            var loc1:*=new feathers.data.ListCollection();
            var loc3:*=this.currentDevices.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = new frontend.screen.mydevices.list.MyDevicesListItem();
                loc4.unit = this.currentDevices[loc2];
                loc1.push(loc4);
                ++loc2;
            }
            return loc1;
        }

        internal function checkCommunicationMode():void
        {
            if (!this.currentDevice) 
            {
                return;
            }
            debug.Debug.debug("checkCommunicationMode...");
            if (!utils.dataprovider.CommonUnitsDataProvider.isSupported(this.currentDevice.type)) 
            {
                this._communicationMode = DEVICE_NOT_SUPPORTED;
                return;
            }
            this._hasNfc = this.currentDevice is core.units.interfaces.INFCDeviceInfo && service.DeviceCommunicationHandler.getInstance().isNfcSupported();
            this._hasBle = this.currentDevice is core.units.interfaces.IBLEDeviceInfo && service.DeviceCommunicationHandler.getInstance().isBleSupported();
            this._hasUsb = this.currentDevice is core.units.interfaces.IUSBDeviceInfo && service.DeviceCommunicationHandler.getInstance().isUsbSupported();
            this._hasDst = this.currentDevice is core.units.interfaces.IDSTDeviceInfo && service.DeviceCommunicationHandler.getInstance().isUsbSupported();
            if (this._hasNfc) 
            {
                this._communicationMode = DEVICE_NFC_ONLY;
            }
            if (this._hasBle) 
            {
                this._communicationMode = DEVICE_BLE_ONLY;
            }
            if (this._hasUsb) 
            {
                this._communicationMode = DEVICE_USB_ONLY;
            }
            if (this._hasDst) 
            {
                this._communicationMode = DEVICE_DST_ONLY;
            }
            if (this._hasUsb && this._hasBle) 
            {
                this._communicationMode = DEVICE_USB_AND_BLE;
            }
            if (this._hasUsb && this._hasNfc) 
            {
                this._communicationMode = DEVICE_USB_AND_NFC;
            }
            if (this._hasDst && this._hasNfc) 
            {
                this._communicationMode = DEVICE_DST_AND_NFC;
            }
            if (this.currentDevice is core.units.interfaces.INFCDeviceInfo && (this._hasDst || this._hasUsb) && this.ignoreUSB) 
            {
                this._communicationMode = DEVICE_NFC_ONLY;
            }
            return;
        }

        internal function initCommunication():void
        {
            debug.Debug.debug("initCommunication...");
            handler.DeviceCommunicationHandlerLink.deviceCommunicationMode = true;
            service.ble.BLEHandler.loadUnitInformationOnConnect = false;
            this.validateConnectionMode();
            return;
        }

        internal function onInitCommunicationTimeout():void
        {
            debug.Debug.debug("onInitCommunicationTimeout");
            dispatchEventWith(COMMUNICATION_TIMEOUT);
            return;
        }

        internal function onDeviceNotMatch(arg1:flash.events.Event=null):void
        {
            debug.Debug.debug("onDeviceNotMatch");
            dispatchEventWith(CURRENT_DEVICE_NOT_MATCH);
            return;
        }

        public function onError(arg1:service.event.DeviceCommunicationEvent):void
        {
            debug.Debug.debug("onCommunicationError");
            dispatchEventWith(COMMUNICATION_ERROR);
            return;
        }

        public static function getInstance():handler.CommunicationHandling
        {
            if (!_instance) 
            {
                _instance = new CommunicationHandling();
            }
            return _instance;
        }

        public static const DEVICE_NOT_SUPPORTED:int=-2;

        public static const COMMUNICATION_ERROR:String="communicationError";

        public static const COMMUNICATION_TIMEOUT:String="communicationTimeout";

        public static const CURRENT_DEVICE_CHANGED:String="currentDeviceChanged";

        public static const CURRENT_DEVICE_NOT_MATCH:String="currentDeviceNotMatch";

        public static const DEVICE_BLE_ONLY:int=2;

        public static const DEVICE_DST_AND_NFC:int=11;

        public static const DEVICE_DST_ONLY:int=4;

        public static const DEVICE_NFC_ONLY:int=1;

        public static const DEVICE_UNKNOWN:int=-1;

        public static const DEVICE_USB_AND_BLE:int=10;

        public static const DEVICE_USB_AND_NFC:int=12;

        public static const DEVICE_USB_ONLY:int=3;

        public static const LAST_SELECTED_CURRENT_DEVICE_TYPE:String="lastSelectedCurrentDeviceType";

        internal static const SEND_COMMAND_DELAY:uint=1000;

        internal static const SEND_COMMAND_NEW_DEVICE_DELAY:uint=2000;

        internal var _hasUsb:Boolean=false;

        internal var _initCommunicationTimeoutInterval:uint=10000;

        internal var _isNewDevice:Boolean=false;

        public var communicationFunction:Function;

        internal var _communicationMode:int=-1;

        internal var _currentDevice:core.units.Unit;

        public var currentDevices:__AS3__.vec.Vector.<core.units.Unit>;

        public var ignoreUSB:Boolean=false;

        public var reloadSavedDevicesFlag:Boolean=true;

        public var waitForPairingRequest:Boolean=false;

        internal var _bleDeviceConnected:Boolean=false;

        internal var _bleScanComplete:Boolean=false;

        public var currentUSBEvent:handler.event.UnitEvent;

        internal var _communicationFunctionTimeout:uint=0;

        internal var _communicationStopped:Boolean=true;

        internal var _connectBLETimeout:uint=0;

        internal var _connectUSBTimeout:uint=0;

        internal var _hasBle:Boolean=false;

        internal var _hasDst:Boolean=false;

        internal var _hasNfc:Boolean=false;

        internal static var _instance:handler.CommunicationHandling;

        internal var _loadDevicedCompleteCallback:Function;
    }
}


