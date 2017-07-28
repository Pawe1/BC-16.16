//class BackendInitializer
package init 
{
    import core.user.interfaces.*;
    import debug.*;
    import flash.events.*;
    import init.interfaces.*;
    import utils.interfaces.*;
    
    public class BackendInitializer extends flash.events.EventDispatcher implements init.interfaces.IBackendInitializer
    {
        public function BackendInitializer()
        {
            super();
            return;
        }

        public function createAltitudeFormatter():utils.interfaces.ICustomFormatter
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createCadenceFormatter():utils.interfaces.ICustomFormatterBase
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createCaloriesFormatter():utils.interfaces.ICustomFormatterBase
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createDateFormatterMx():utils.interfaces.ICustomFormatter
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createDateTimeFormatter():utils.interfaces.ICustomDateTimeFormatter
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createDistanceFormatter():utils.interfaces.ICustomFormatter
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createGhostDistanceDecoderFormatter():utils.interfaces.ICustomFormatterBase
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createHeartrateFormatter():utils.interfaces.ICustomFormatterBase
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createInclineFormatter():utils.interfaces.ICustomFormatterBase
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createPowerFormatter():utils.interfaces.ICustomFormatterBase
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createSpeedFormatter():utils.interfaces.ICustomFormatter
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createSpeedTimeFormatter():utils.interfaces.ICustomTimeFormatter
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function getSportHandler():init.interfaces.ISportHandler
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createTimeFormatter():utils.interfaces.ICustomTimeFormatter
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createTimeFormatterHHMM():utils.interfaces.ICustomTimeFormatter
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function getUserhandler():core.user.interfaces.IUserHandler
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public function createVectorList(arg1:*=null):init.interfaces.IVectorList
        {
            debug.Debug.warning("[ACHTUNG] DRINGEND ÜBERSCHREIBEN ...");
            return null;
        }

        public static function getInstance():init.BackendInitializer
        {
            if (!_instance) 
            {
                _instance = new BackendInitializer();
            }
            return _instance;
        }

        public static function setInstance(arg1:init.BackendInitializer):void
        {
            _instance = arg1;
            return;
        }

        internal static var _instance:init.BackendInitializer;
    }
}


