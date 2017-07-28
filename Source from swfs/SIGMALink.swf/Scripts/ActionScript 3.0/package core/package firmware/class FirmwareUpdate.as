//class FirmwareUpdate
package core.firmware 
{
    import core.*;
    import core.units.*;
    import flash.events.*;
    import flash.net.*;
    import mx.events.*;
    
    public class FirmwareUpdate extends flash.events.EventDispatcher
    {
        public function FirmwareUpdate(arg1:core.units.Unit, arg2:String, arg3:Boolean=false)
        {
            updateAvailable = false;
            _currentUnitRequests = {};
            super();
            _unit = arg1;
            _swVersionForFWRequest = arg2;
            _isBeta = arg3;
            return;
        }

        public function get updateAvailable():Boolean
        {
            return this.updateAvailable;
        }

        public function set updateAvailable(arg1:Boolean):void
        {
            var loc1:*=this.updateAvailable;
            if (loc1 !== arg1) 
            {
                this.updateAvailable = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "updateAvailable", loc1, arg1));
                }
            }
            return;
        }

        public function checkUpdate(arg1:Function=null, arg2:Function=null):void
        {
            _checkUpdateCallback = arg1;
            _errorCallback = arg2;
            var loc1:*=new flash.net.URLRequest();
            loc1.url = "https://firmwareupdate.sigma-dc-control.com/firmwareupdate.php";
            loc1.data = {"request":encodeRequest()};
            _urlLoader = new flash.net.URLLoader();
            _urlLoader.addEventListener("complete", loaderCompleteHandler);
            _urlLoader.addEventListener("httpStatus", httpStatusHandler);
            _urlLoader.addEventListener("securityError", securityErrorHandler);
            _urlLoader.addEventListener("ioError", ioErrorHandler);
            _urlLoader.load(loc1);
            return;
        }

        internal function loaderCompleteHandler(arg1:flash.events.Event):void
        {
            if (_checkUpdateCallback != null) 
            {
                _checkUpdateCallback();
            }
            return;
        }

        internal function httpStatusHandler(arg1:flash.events.HTTPStatusEvent):void
        {
            return;
        }

        internal function securityErrorHandler(arg1:flash.events.SecurityErrorEvent):void
        {
            if (_errorCallback != null) 
            {
                _errorCallback();
            }
            return;
        }

        internal function ioErrorHandler(arg1:flash.events.IOErrorEvent):void
        {
            if (_errorCallback != null) 
            {
                _errorCallback();
            }
            return;
        }

        internal function encodeRequest(arg1:Boolean=false):Object
        {
            var loc2:*=[];
            loc2.push({"device":getFirmwareUpdateUnitObject(_unit, arg1)});
            var loc1:*={};
            loc1.dataCenterVersion = _swVersionForFWRequest;
            loc1.beta = _isBeta.toString();
            loc1.language = core.MeasurementConfig.language;
            loc1.developmentMode = "false";
            loc1.deviceList = loc2;
            loc1.key = "1234567890";
            return loc1;
        }

        internal function isValidResponse(arg1:String):Boolean
        {
            return arg1 == "0987654321";
        }

        internal function decodeResponse(arg1:Object):void
        {
            if (!isValidResponse(arg1.key as String)) 
            {
            };
            return;
        }

        public static function getFirmwareUpdateUnitObject(arg1:core.units.Unit, arg2:Boolean=false):Object
        {
            var loc1:*=null;
            var loc2:*;
            (loc2 = {}).name = arg1.type.toString();
            loc2.externalName = arg1.externalName;
            loc2.dcID = arg1.unitId.toString();
            loc2.GUID = arg1.GUID;
            loc2.unitType = arg1.type.toString();
            if (arg1 is core.units.UnitROX100 || arg1 is core.units.UnitROX70) 
            {
                loc1 = arg1.softwareRevision.split("-");
                if (loc1.length > 0 && !arg2) 
                {
                    loc2.firmware = parseFloat(loc1[(loc1.length - 1)]).toString();
                }
                else 
                {
                    trace("hinterlegte FW-Version ungültig");
                    loc2.firmware = "0";
                }
            }
            else 
            {
                loc2.firmware = arg1.softwareRevision;
            }
            return loc2;
        }

        internal static const FW_REQUEST_KEY:String="1234567890";

        internal static const FW_REQUEST_URL:String="https://firmwareupdate.sigma-dc-control.com/firmwareupdate.php";

        internal static const FW_RESPONSE_KEY:String="0987654321";

        public var changeLog:String;

        public var changeLogURL:String;

        public var changeLogURLText:String;

        public var dcID:String;

        public var fileURL:String;

        public var newFirmware:String;

        public var newFirmwareDate:String;

        internal var updateAvailable:Boolean;

        internal var _checkUpdateCallback:Function;

        internal var _currentUnitRequests:Object;

        internal var _errorCallback:Function;

        internal var _isBeta:Boolean=false;

        internal var _swVersionForFWRequest:String="";

        internal var _unit:core.units.Unit;

        internal var _urlLoader:flash.net.URLLoader;
    }
}


