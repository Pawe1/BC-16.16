//class UnitFactory
package core.units 
{
    import core.general.*;
    
    public final class UnitFactory extends Object
    {
        public function UnitFactory()
        {
            super();
            return;
        }

        public static function createUnitFromSUF(arg1:XML):core.units.Unit
        {
            var loc1:*=core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
            var loc2:*=unitSwitch(loc1);
            loc2.fromSUF(arg1);
            return loc2;
        }

        public static function createUnitFromDB(arg1:Object):core.units.Unit
        {
            var loc2:*=null;
            var loc1:*=core.general.UnitType.fromString(arg1.type);
            if (loc1 != null) 
            {
                loc2 = unitSwitch(loc1);
                loc2.fromDB(arg1);
            }
            return loc2;
        }

        public static function createUnitFromType(arg1:core.general.UnitType):core.units.Unit
        {
            return unitSwitch(arg1);
        }

        public static function calculateFitWithBreaks(arg1:core.general.UnitType):Boolean
        {
            return arg1.equals(core.general.UnitType.ROX100) || arg1.equals(core.general.UnitType.ROX110) || arg1.equals(core.general.UnitType.ROX70);
        }

        public static function notificationsSupported():Array
        {
            if (!_notificationTypes) 
            {
                _notificationTypes = [core.general.UnitType.ROX110];
            }
            return _notificationTypes;
        }

        public static function ghostRaceSupported():Array
        {
            if (!_ghostRaceTypes) 
            {
                _ghostRaceTypes = [core.general.UnitType.BC2316STS];
            }
            return _ghostRaceTypes;
        }

        public static function nfcSupported():Array
        {
            if (!_nfcTypes) 
            {
                _nfcTypes = [core.general.UnitType.BC1416, core.general.UnitType.BC1416STS, core.general.UnitType.BC1616, core.general.UnitType.BC1616STS, core.general.UnitType.BC2316STS, core.general.UnitType.GPS10];
            }
            return _nfcTypes;
        }

        public static function bleSupported():Array
        {
            if (!_bleTypes) 
            {
                _bleTypes = [core.general.UnitType.ROX110, core.general.UnitType.PC2814];
            }
            return _bleTypes;
        }

        public static function usbSupported():Array
        {
            var loc3:*=0;
            var loc1:*=null;
            if (!_usbTypes) 
            {
                _usbTypes = core.general.UnitType.TYPES.concat();
                loc1 = [core.general.UnitType.RC1209, core.general.UnitType.PC2814, core.general.UnitType.SigmaMove, core.general.UnitType.Activo];
                var loc2:*=loc1.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    _usbTypes.removeAt(_usbTypes.indexOf(loc1[loc3]));
                    ++loc3;
                }
            }
            return _usbTypes;
        }

        internal static function unitSwitch(arg1:core.general.UnitType):core.units.Unit
        {
            var loc2:*=null;
            var loc1:*=core.general.UnitType.ROX60;
            var loc3:*=arg1.toString();
            while (core.general.UnitType.BC509.toString() === loc3) 
            {
                loc2 = new core.units.UnitBC509();
            }
        }

        public static function getFITProductId(arg1:core.general.UnitType):int
        {
            var loc1:*=0;
            var loc2:*=arg1.toString();
            while (core.general.UnitType.BC509.toString() === loc2) 
            {
                loc1 = 1;
            }
        }

        internal static var _bleTypes:Array;

        internal static var _ghostRaceTypes:Array;

        internal static var _nfcTypes:Array;

        internal static var _notificationTypes:Array;

        internal static var _usbTypes:Array;
    }
}


