//package init
//  package interfaces
//    class IBackendInitializer
package init.interfaces 
{
    import core.user.interfaces.*;
    import utils.interfaces.*;
    
    public dynamic interface IBackendInitializer
    {
        function createDateTimeFormatter():utils.interfaces.ICustomDateTimeFormatter;

        function createAltitudeFormatter():utils.interfaces.ICustomFormatter;

        function createCaloriesFormatter():utils.interfaces.ICustomFormatterBase;

        function createDateFormatterMx():utils.interfaces.ICustomFormatter;

        function createDistanceFormatter():utils.interfaces.ICustomFormatter;

        function createHeartrateFormatter():utils.interfaces.ICustomFormatterBase;

        function createPowerFormatter():utils.interfaces.ICustomFormatterBase;

        function createSpeedFormatter():utils.interfaces.ICustomFormatter;

        function createSpeedTimeFormatter():utils.interfaces.ICustomTimeFormatter;

        function createTimeFormatterHHMM():utils.interfaces.ICustomTimeFormatter;

        function createTimeFormatter():utils.interfaces.ICustomTimeFormatter;

        function createCadenceFormatter():utils.interfaces.ICustomFormatterBase;

        function createInclineFormatter():utils.interfaces.ICustomFormatterBase;

        function createGhostDistanceDecoderFormatter():utils.interfaces.ICustomFormatterBase;

        function createVectorList(arg1:*=null):init.interfaces.IVectorList;

        function getSportHandler():init.interfaces.ISportHandler;

        function getUserhandler():core.user.interfaces.IUserHandler;
    }
}


//    class ISportHandler
package init.interfaces 
{
    import core.general.*;
    import core.sport.*;
    import flash.utils.*;
    
    public dynamic interface ISportHandler
    {
        function get sportsInUseDic():flash.utils.Dictionary;

        function resolveSportById(arg1:uint=0):core.sport.Sport;

        function resolveSportByKeyName(arg1:String):core.sport.Sport;

        function resolveSportByShortName(arg1:String):core.sport.Sport;

        function resolveSportByType(arg1:core.general.UnitType):core.sport.Sport;
    }
}


//    class IVectorList
package init.interfaces 
{
    import flash.events.*;
    
    public dynamic interface IVectorList extends flash.events.IEventDispatcher
    {
        function get length():int;

        function get source():*;

        function toArray():Array;

        function addItem(arg1:Object):void;

        function contains(arg1:Object):Boolean;

        function getItemAt(arg1:int, arg2:int=0):Object;

        function createVectorList(arg1:*=null):init.interfaces.IVectorList;
    }
}


//  class BackendInitializer
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


