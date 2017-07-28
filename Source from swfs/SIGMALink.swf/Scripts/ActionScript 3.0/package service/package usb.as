//package usb
//  package event
//    class DeviceDataCompleteEvent
package service.usb.event 
{
    import flash.events.*;
    
    public class DeviceDataCompleteEvent extends flash.events.Event
    {
        public function DeviceDataCompleteEvent(arg1:String, arg2:String, arg3:Array, arg4:String=null, arg5:Boolean=false)
        {
            super(arg1, arg5);
            command = arg2;
            data = arg3;
            startAdress = arg4;
            return;
        }

        public override function toString():String
        {
            return "[DataCompleteEvent extends Event]";
        }

        public static const DATA_COMPLETE:String="usbComplete";

        public var command:String;

        public var data:Array;

        public var startAdress:String;
    }
}


//    class USBConnectedEvent
package service.usb.event 
{
    import flash.events.*;
    
    public class USBConnectedEvent extends flash.events.Event
    {
        public function USBConnectedEvent(arg1:String, arg2:uint, arg3:String, arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            _usbPort = arg2;
            _dockingStation = arg3;
            return;
        }

        public function get dockingStation():String
        {
            return _dockingStation;
        }

        public function set dockingStation(arg1:String):void
        {
            _dockingStation = arg1;
            return;
        }

        public function get usbPort():uint
        {
            return _usbPort;
        }

        public function set usbPort(arg1:uint):void
        {
            _usbPort = arg1;
            return;
        }

        public static const USB_CONNECTED:String="usbConnected";

        public static const USB_DISCONNECTED:String="usbDisconnected";

        internal var _dockingStation:String;

        internal var _usbPort:uint;
    }
}


//  class USBHandler
package service.usb 
{
    import avmplus.*;
    import com.logging.*;
    import de.pagecon.usb.*;
    import debug.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.*;
    import handler.event.*;
    import helper.*;
    import service.*;
    import service.event.*;
    import service.usb.event.*;
    
    public class USBHandler extends flash.events.EventDispatcher implements de.pagecon.usb.UsbListener, service.ICommunicationService
    {
        public function USBHandler(arg1:flash.events.IEventDispatcher=null)
        {
            var loc1:*=null;
            _receiveBuffer = [];
            commandArray = [];
            super(arg1);
            _usbController = new de.pagecon.usb.UsbController();
            _usbController.debugMode = false;
            if (_usbController.isSupported()) 
            {
                loc1 = [];
                loc1.push(new de.pagecon.usb.SigmaDevice(7581, 4112, 269491613), new de.pagecon.usb.SigmaDevice(7581, 4113, 269557149), new de.pagecon.usb.SigmaDevice(7581, 4114, 269622685), new de.pagecon.usb.SigmaDevice(1155, 22336, 1463813251), new de.pagecon.usb.SigmaDevice(7581, 4176, 273685917), new de.pagecon.usb.SigmaDevice(7581, 4177, 273751453), new de.pagecon.usb.SigmaDevice(7581, 4096, 268443037), new de.pagecon.usb.SigmaDevice(7581, 4144, 271588765), new de.pagecon.usb.SigmaDevice(7581, 8192, 536878493), new de.pagecon.usb.SigmaDevice(7581, 4129, 270605725), new de.pagecon.usb.SigmaDevice(7581, 4178, 273816989));
                _usbController.setSupportedDevices(loc1);
            }
            return;
        }

        public function resetLastReceveidData():void
        {
            debug.Debug.usb("_receiveBuffer on reset: " + _receiveBuffer.toString());
            _receiveBuffer = [];
            return;
        }

        public function get connectedDevice():de.pagecon.usb.SigmaDevice
        {
            return _connectedDevice;
        }

        public function set connectedDevice(arg1:de.pagecon.usb.SigmaDevice):void
        {
            _connectedDevice = arg1;
            return;
        }

        public function getLastReceivedData():Array
        {
            return _receiveBuffer;
        }

        public function get currentDeviceHandler():handler.DeviceHandler
        {
            return _currentDeviceHandler;
        }

        public function set currentDeviceHandler(arg1:handler.DeviceHandler):void
        {
            _currentDeviceHandler = arg1;
            return;
        }

        public function reset():void
        {
            resetUSBService();
            return;
        }

        public function get dockingStation():String
        {
            return _dockingStation;
        }

        internal function connectMobilDevice(arg1:de.pagecon.usb.SigmaDevice):void
        {
            if (!_usbController) 
            {
                return;
            }
            var loc1:*=_usbController.connectDevice(arg1.id);
        }

        public function get port():int
        {
            return _port;
        }

        public function closeApplication():void
        {
            return;
        }

        public function isReady():Boolean
        {
            return false;
        }

        public function initMobileUSBService(arg1:Boolean=true):void
        {
            _autoConnect = arg1;
            if (helper.Capabilities_helper.isAndroid() || helper.Capabilities_helper.isWindows() || helper.Capabilities_helper.isMac()) 
            {
                _usbController.usbListener = this;
                if (arg1) 
                {
                    searchAttachedDevices();
                }
            }
            else 
            {
                debug.Debug.usb("Keine USB unterstützung vorhanden");
            }
            return;
        }

        public function destroyUSBController():void
        {
            if (!_usbController) 
            {
                return;
            }
            if (_connectedDevice) 
            {
                _usbController.disconnectDevice(_connectedDevice.id);
            }
            _usbController.usbListener = null;
            return;
        }

        public function searchAttachedDevices():void
        {
            if (!_usbController) 
            {
                return;
            }
            var loc1:*=_usbController.getAttachedDevices();
            if (loc1.length == 1) 
            {
                _doActionTimeout = flash.utils.setTimeout(connectMobilDevice, 1000, loc1[0]);
            }
            return;
        }

        public function dataReceived(arg1:int, arg2:Array):void
        {
            var loc3:*=0;
            var loc4:*=null;
            if (currentDeviceHandler == null) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 117, "USB > standardOutputDataHandler: current unit handler is null, , ds: " + _dockingStation + ", port: " + _port));
                dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", ""));
                return;
            }
            _receiveBuffer = _receiveBuffer.concat(arg2);
            var loc2:*=_receiveBuffer.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (_receiveBuffer[loc3] < 0) 
                {
                    var loc5:*=loc3;
                    var loc6:*=_receiveBuffer[loc5] + 256;
                    _receiveBuffer[loc5] = loc6;
                }
                ++loc3;
            }
            var loc1:*=currentDeviceHandler.currentBytesToReceive + currentDeviceHandler.currentReceiveChecksumLength;
            dispatchEvent(new handler.event.CustomCommunicationServiceProgressEvent("EVENT_USB_TRANSFER_PROGRESS", 100 / _receiveBuffer.length * loc1));
            if (currentDeviceHandler.currentCommand != 244) 
            {
                debug.Debug.usb("Received data \tfrom \t" + arg1 + " \t(" + avmplus.getQualifiedClassName(currentDeviceHandler) + "): " + "\tCommand: " + currentDeviceHandler.currentCommand + " \treceived length: " + _receiveBuffer.length + " - expected length: " + loc1 + "\n" + "\t\t\tdata: [" + arg2 + "]");
            }
            if (_receiveBuffer.length != loc1) 
            {
                if (_receiveBuffer.length > currentDeviceHandler.currentBytesToReceive) 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 115, "USB > standardOutputDataHandler: , ds: " + _dockingStation + ", port: " + _port + ", unitHandler: " + currentDeviceHandler.toString()));
                    dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", ""));
                }
                else 
                {
                    dispatchEvent(new flash.events.Event("waitForDataEvent"));
                }
            }
            else 
            {
                loc4 = new service.usb.event.DeviceDataCompleteEvent("usbComplete", currentDeviceHandler.currentCommand.toString(), _receiveBuffer, currentDeviceHandler.currentStartAdrr);
                _receiveBuffer = [];
                dispatchEvent(loc4);
                dispatchEvent(new flash.events.Event("EVENT_USB_TRANSFER_END"));
            }
            return;
        }

        public function connectionEvent(arg1:int, arg2:de.pagecon.usb.SigmaDevice):void
        {
            var loc1:*=null;
            flash.utils.clearTimeout(_doActionTimeout);
        }

        internal function disconnect(arg1:de.pagecon.usb.SigmaDevice):void
        {
            if (_usbController) 
            {
                _usbController.disconnectDevice(arg1.id);
            }
            _connectedDevice = null;
            return;
        }

        public function debugInfo(arg1:String):void
        {
            debug.Debug.usb("[UsbListener] " + arg1);
            return;
        }

        public function isSupported():Boolean
        {
            return _usbController.isSupported();
        }

        internal function onErrorPopupClose(arg1:flash.events.Event):void
        {
            _tooManyDSPopupVisible = false;
            return;
        }

        public function resetUSBService(arg1:Boolean=true):void
        {
            if (currentDeviceHandler == null || !(currentDeviceHandler is service.usb.USBHandler)) 
            {
                return;
            }
            debug.Debug.usb(" --------- resetUSBService  --------- ( and restart:" + arg1);
            if (!(_connectedDevice == null) && _usbController) 
            {
                _usbController.disconnectDevice(_connectedDevice.id);
            }
            if (currentDeviceHandler != null) 
            {
                currentDeviceHandler.destructor();
                currentDeviceHandler = null;
            }
            return;
        }

        public function send(arg1:flash.utils.ByteArray, arg2:handler.DeviceHandler, arg3:Boolean=false):void
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=false;
            if (connectedDevice == null) 
            {
                arg2.resetCheckConnectionTimeOut();
            }
            else 
            {
                currentDeviceHandler = arg2;
                if (currentDeviceHandler.currentBytesToReceive > 0) 
                {
                    dispatchEvent(new flash.events.Event("waitForDataEvent"));
                }
                _receiveBuffer = [];
                if (!arg3) 
                {
                    try 
                    {
                        dispatchEvent(new flash.events.Event("EVENT_USB_TRANSFER_START"));
                        loc3 = [];
                        loc1 = 0;
                        arg1.position = 0;
                        while (arg1.bytesAvailable) 
                        {
                            loc1 = arg1.readUnsignedByte();
                            loc3[loc3.length] = loc1;
                        }
                        loc2 = _usbController.sendData(currentDeviceHandler.port, loc3);
                        if (loc1 != 244) 
                        {
                            debug.Debug.usb("Sending data \tto  \t" + arg2.port + " \t(" + avmplus.getQualifiedClassName(arg2) + "): " + "\tCommand: [" + loc3.toString() + "]");
                        }
                        commandArray.push(loc3.toString());
                    }
                    catch (e:Error)
                    {
                        dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", e.message));
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 116, e.message));
                    }
                }
            }
            return;
        }

        public function sendMultipackage(arg1:flash.utils.ByteArray, arg2:handler.DeviceHandler, arg3:uint, arg4:uint):void
        {
            currentDeviceHandler = arg2;
            if (currentDeviceHandler.currentBytesToReceive > 0) 
            {
                dispatchEvent(new flash.events.Event("waitForDataEvent"));
            }
            _receiveBuffer = [];
            arg1.position = 0;
            sendLoop(arg1, arg3, 1, arg4);
            return;
        }

        internal function sendLoop(arg1:flash.utils.ByteArray, arg2:uint, arg3:uint, arg4:uint):void
        {
            var loc5:*=0;
            if (arg1.bytesAvailable == 0) 
            {
                return;
            }
            var loc4:*=[];
            var loc6:*=new flash.utils.ByteArray();
            var loc2:*=0;
            var loc1:*=0;
            loc5 = 0;
            while (loc5 < arg2) 
            {
                if (arg1.bytesAvailable >= 1) 
                {
                    loc1 = arg1.readUnsignedByte();
                    loc6.writeByte(loc1);
                    loc4.push(loc1);
                    ++loc2;
                }
                ++loc5;
            }
            var loc3:*=_usbController.sendData(currentDeviceHandler.port, loc4);
            ++arg3;
            return;
        }

        public static const VID_PID_ROX:uint=268443037;

        public static const VID_PID_ROX_10:uint=1463813251;

        public static const VID_PID_ROX_2011:uint=271588765;

        public static const VID_PID_ROX_7:uint=273685917;

        public static const VID_PID_RUN1:uint=537927069;

        public static const VID_PID_RUN2:uint=537992605;

        public static const VID_PID_TOPLINE_2009:uint=269491613;

        public static const VID_PID_TOPLINE_2012:uint=269557149;

        public static const VID_PID_TOPLINE_2016:uint=269622685;

        public static const VID_PID_UFSB:uint=270605725;

        public static const VID_SIGMASPORT:uint=7581;

        public static const VID_PID_ROX_11:uint=273751453;

        public static const COMMAND_MODE_LOAD:String="loadCommand";

        public static const COMMAND_MODE_SEND:String="sendCommand";

        public static const EVENT_USB_TRANSFER_END:String="EVENT_USB_TRANSFER_END";

        public static const EVENT_USB_TRANSFER_PROGRESS:String="EVENT_USB_TRANSFER_PROGRESS";

        public static const EVENT_USB_TRANSFER_START:String="EVENT_USB_TRANSFER_START";

        public static const PID_GPS_10:uint=4178;

        public static const PID_RC_2011:uint=8192;

        public static const PID_ROX:uint=4096;

        public static const PID_ROX_10:uint=22336;

        public static const PID_ROX_11:uint=4177;

        public static const PID_ROX_2011:uint=4144;

        public static const PID_ROX_7:uint=4176;

        public static const PID_TOPLINE_2009:uint=4112;

        public static const PID_TOPLINE_2012:uint=4113;

        public static const PID_TOPLINE_2016:uint=4114;

        public static const PID_UFSB:uint=4129;

        public static const TOO_MANY_DOCKING_STATIONS_CONNECTED:String="tooManyDockingStationsConnected";

        public static const USB_SERVICE_CLOSED:String="usbServiceClosed";

        public static const USB_SERVICE_FOUND:String="usbServiceFound";

        public static const USB_SERVICE_NOT_FOUND:String="usbServiceNotFound";

        public static const VID_PID_ACTIVO_HEALTH:uint=538975645;

        public static const VID_PID_GPS_10:uint=273816989;

        public static const VID_PID_RC_2011:uint=536878493;

        internal var _connectedDevice:de.pagecon.usb.SigmaDevice;

        internal var _currentDeviceHandler:handler.DeviceHandler;

        internal var _dockingStation:String="";

        internal var _autoConnect:Boolean=true;

        internal var _doActionTimeout:uint=0;

        internal var _nextQueueCommandInterval:uint=1000;

        internal var _receiveBuffer:Array;

        internal var _scanDockingStationInterval:uint=1000;

        internal var _scanUSBPortInterval:uint=1000;

        internal var _tooManyDSPopupVisible:Boolean=false;

        internal var _usbController:de.pagecon.usb.UsbController;

        internal var _port:int=-1;

        internal var commandArray:Array;
    }
}


//  class USBSendTimer
package service.usb 
{
    import flash.utils.*;
    
    public class USBSendTimer extends flash.utils.Timer
    {
        public function USBSendTimer(arg1:Number, arg2:uint=0, arg3:String="", arg4:int=0, arg5:Array=null, arg6:int=0, arg7:int=0)
        {
            super(arg1, arg7);
            usbPort = arg2;
            command = arg3;
            bytesToReceive = arg4;
            packageSize = arg6;
            data = arg5;
            return;
        }

        public var bytesToReceive:int;

        public var command:String;

        public var data:Array;

        public var packageSize:int;

        public var sentBytes:int=0;

        public var usbPort:uint;
    }
}


