//class DockingStationHandler
package handler.dockingstation 
{
    import com.logging.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.*;
    import service.*;
    
    public class DockingStationHandler extends handler.DeviceHandler
    {
        public function DockingStationHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        protected function resolveDSVersion(arg1:Object):uint
        {
            return 0;
        }

        public function get dsMode():String
        {
            return _dsMode;
        }

        public function set dsMode(arg1:String):void
        {
            _dsMode = arg1;
            return;
        }

        public function getDSVersionString():String
        {
            return "0";
        }

        public function get dsVersion():uint
        {
            return _dsVersion;
        }

        public function set dsVersion(arg1:uint):void
        {
            _dsVersion = arg1;
            return;
        }

        public override function destructor():void
        {
            flash.utils.clearTimeout(_scanDocingstationTimeOutId);
            unitInitialised = false;
            super.destructor();
            return;
        }

        public function checkConnectionTimeout():void
        {
            removeEvents();
            service.DeviceCommunicationHandler.getInstance().resetCommunicationService();
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 120, "Unit Handler > checkConnectionTimeout "));
            return;
        }

        public function loadUnitInformation():void
        {
            return;
        }

        public function scanDockingStation():void
        {
            return;
        }

        public function stopScanDockingStation():void
        {
            scanDockingStationStopped = true;
            return;
        }

        public function startScanDockingStation():void
        {
            scanDockingStationStopped = false;
            return;
        }

        public function get unitInitialised():Boolean
        {
            return _unitInitialised;
        }

        public function set unitInitialised(arg1:Boolean):void
        {
            _unitInitialised = arg1;
            return;
        }

        public function getValidFileRows():int
        {
            return 0;
        }

        public function isBLEHandler():Boolean
        {
            return this is handler.dockingstation.BLEDSHandler || this is handler.dockingstation.BLERox11DSHandler;
        }

        public function goToBootloader():void
        {
            return;
        }

        public function startUpdate(arg1:Array):void
        {
            return;
        }

        public function isValidFWFile(arg1:Array):Boolean
        {
            return false;
        }

        public static const BOOTLOADER_MODE_CHANGED_EVENT:String="bootloaderModeChangedEvent";

        public static const CHECK_DS_VERSION:String="checkDSVersion";

        public static const CHECK_UNIT_CONNECTED:String="checkUnitConnected";

        public static const DS_MODE_BOOTLOADER:String="bootloaderMode";

        public static const DS_MODE_NORMAL:String="normalMode";

        public static const DS_MODE_UNKNOWN:String="unknownMode";

        public static const END_PROG_AND_RUN_EVENT:String="endProgAndRunEvent";

        public static const ERASE_FLASH_ROM_EVENT:String="eraseFlashRomEvent";

        public static const LOAD_SERIALNUMBER_BACKUP_INFORMATION:String="loadSerialnumberBackupInformation";

        public static const LOAD_SERIALNUMBER_INFORMATION:String="loadSerialnumberInformation";

        public static const LOAD_UNIT_INFORMATION:String="loadUnitInformation";

        public static const SEND_A_LINE_EVENT:String="sendALineEvent";

        public static const START_PROGRAM_EVENT:String="startProgramEvent";

        public static const START_SCAN_DOCKING_STATION:String="startScanDockingStationEvent";

        public static const START_VERIFICATION_EVENT:String="startVerificationEvent";

        public static const STOP_SCAN_DOCKING_STATION:String="stopScanDockingStationEvent";

        public static const UNIT_CONNECTED_EVENT:String="unitConnectedEvent";

        public static const UNIT_DISCONNECTED_EVENT:String="unitDisconnectedEvent";

        public static const UNIT_INITIALISED_EVENT:String="unitInitialisedEvent";

        internal var _dsMode:String="unknownMode";

        internal var _dsVersion:uint=0;

        public var installUpdateProgress:Function;

        public var installUpdateSuccess:Function;

        public var installVerificationProgress:Function;

        public var readyForFWUpdate:Boolean=false;

        public var scanDockingStationStopped:Boolean=false;

        protected var _unitInitialised:Boolean;

        protected var _scanDocingstationTimeOutId:uint=0;

        protected var afterVerification:Boolean=false;

        protected var linesSentCount:int=0;

        protected var updateFileArray:Array;
    }
}


