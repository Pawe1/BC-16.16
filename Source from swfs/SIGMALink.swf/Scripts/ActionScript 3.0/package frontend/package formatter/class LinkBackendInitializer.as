//class LinkBackendInitializer
package frontend.formatter 
{
    import backend.utils.container.*;
    import core.user.interfaces.*;
    import handler.*;
    import init.*;
    import init.interfaces.*;
    import utils.formatter.*;
    import utils.interfaces.*;
    
    public class LinkBackendInitializer extends init.BackendInitializer
    {
        public function LinkBackendInitializer()
        {
            super();
            return;
        }

        public override function createAltitudeFormatter():utils.interfaces.ICustomFormatter
        {
            return new frontend.formatter.AltitudeFormatter();
        }

        public override function createCadenceFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.CadenceFormatter();
        }

        public override function createCaloriesFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.CaloriesFormatter();
        }

        public override function createDateFormatterMx():utils.interfaces.ICustomFormatter
        {
            return new utils.formatter.DateFormatterMx();
        }

        public override function createDateTimeFormatter():utils.interfaces.ICustomDateTimeFormatter
        {
            return new frontend.formatter.CustomDateTimeFormatter();
        }

        public override function createDistanceFormatter():utils.interfaces.ICustomFormatter
        {
            return new frontend.formatter.DistanceFormatter();
        }

        public override function createGhostDistanceDecoderFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.GhostDistanceDecoderFormatter();
        }

        public override function createHeartrateFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.HeartrateFormatter();
        }

        public override function createInclineFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.InclineFormatter();
        }

        public override function createPowerFormatter():utils.interfaces.ICustomFormatterBase
        {
            return new frontend.formatter.PowerFormatter();
        }

        public override function createSpeedFormatter():utils.interfaces.ICustomFormatter
        {
            return new frontend.formatter.SpeedFormatter();
        }

        public override function createSpeedTimeFormatter():utils.interfaces.ICustomTimeFormatter
        {
            var loc1:*=new frontend.formatter.TimeFormatter();
            loc1.formatString = "MM:SS";
            return loc1;
        }

        public override function createTimeFormatter():utils.interfaces.ICustomTimeFormatter
        {
            return new frontend.formatter.TimeFormatter();
        }

        public override function createTimeFormatterHHMM():utils.interfaces.ICustomTimeFormatter
        {
            var loc1:*=new frontend.formatter.TimeFormatter();
            loc1.formatString = "HH:MM";
            return loc1;
        }

        public override function createVectorList(arg1:*=null):init.interfaces.IVectorList
        {
            return new backend.utils.container.CustomListCollection(arg1);
        }

        public override function getSportHandler():init.interfaces.ISportHandler
        {
            return handler.SportHandler.getInstance();
        }

        public override function getUserhandler():core.user.interfaces.IUserHandler
        {
            return handler.UserHandler.getInstance();
        }

        public static function getInstance():frontend.formatter.LinkBackendInitializer
        {
            if (!_instance) 
            {
                _instance = new LinkBackendInitializer();
                init.BackendInitializer.setInstance(_instance);
            }
            return _instance;
        }

        internal static var _instance:frontend.formatter.LinkBackendInitializer;
    }
}


