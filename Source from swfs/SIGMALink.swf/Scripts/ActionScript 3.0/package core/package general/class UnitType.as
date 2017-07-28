//class UnitType
package core.general 
{
    import debug.*;
    import utils.*;
    
    public class UnitType extends core.general.BaseType
    {
        public function UnitType(arg1:String=null)
        {
            super(arg1);
            typeString = arg1;
            return;
        }

        public static function hashtag(arg1:core.general.UnitType):String
        {
            var loc1:*="";
            var loc2:*=arg1;
            while (BC509 === loc2) 
            {
                loc1 = "#SIGMA #BC509";
            }
        }

        public function getLabel():String
        {
            return utils.LanguageManager.getString("UNIT_" + typeString.toUpperCase());
        }

        public static function fromString(arg1:String):core.general.UnitType
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            if (arg1 != "") 
            {
                debug.Debug.warning("Warning: Unknown UnitType: \'" + arg1 + "\'");
            }
            else 
            {
                debug.Debug.warning("Warning: No UnitType defined");
            }
            return null;
        }

        public static function formatUnit(arg1:core.general.UnitType):String
        {
            var loc1:*="";
            var loc2:*=arg1;
            while (BC509 === loc2) 
            {
                loc1 = utils.LanguageManager.getString("UNIT_BC509");
            }
        }

        public static const BC1009STS:core.general.UnitType=new UnitType("bc1009sts");

        public static const BC1212:core.general.UnitType=new UnitType("bc1212");

        public static const BC1212STS:core.general.UnitType=new UnitType("bc1212sts");

        public static const BC1412:core.general.UnitType=new UnitType("bc1412");

        public static const BC1416:core.general.UnitType=new UnitType("bc1416");

        public static const BC1416STS:core.general.UnitType=new UnitType("bc1416sts");

        public static const BC1609:core.general.UnitType=new UnitType("bc1609");

        public static const BC1609STS:core.general.UnitType=new UnitType("bc1609sts");

        public static const BC1612:core.general.UnitType=new UnitType("bc1612");

        public static const BC1612STS:core.general.UnitType=new UnitType("bc1612sts");

        public static const BC1616:core.general.UnitType=new UnitType("bc1616");

        public static const BC1616STS:core.general.UnitType=new UnitType("bc1616sts");

        public static const BC1909HR:core.general.UnitType=new UnitType("bc1909hr");

        public static const BC2209MHR:core.general.UnitType=new UnitType("bc2209mhr");

        public static const BC2316STS:core.general.UnitType=new UnitType("bc2316sts");

        public static const BC416:core.general.UnitType=new UnitType("bc416");

        public static const BC416ATS:core.general.UnitType=new UnitType("bc416ats");

        public static const BC509:core.general.UnitType=new UnitType("bc509");

        public static const BC512:core.general.UnitType=new UnitType("bc512");

        public static const BC516:core.general.UnitType=new UnitType("bc516");

        public static const BC716:core.general.UnitType=new UnitType("bc716");

        public static const BC716ATS:core.general.UnitType=new UnitType("bc716ats");

        public static const BC812:core.general.UnitType=new UnitType("bc812");

        public static const BC812W:core.general.UnitType=new UnitType("bc812w");

        public static const BC916:core.general.UnitType=new UnitType("bc916");

        public static const BC916ATS:core.general.UnitType=new UnitType("bc916ats");

        public static const GPS10:core.general.UnitType=new UnitType("gps10");

        public static const PC2814:core.general.UnitType=new UnitType("pc2814");

        public static const RC1209:core.general.UnitType=new UnitType("rc1209");

        public static const RC1411:core.general.UnitType=new UnitType("rc1411");

        public static const ROX100:core.general.UnitType=new UnitType("rox100");

        public static const ROX110:core.general.UnitType=new UnitType("rox110");

        public static const ROX50:core.general.UnitType=new UnitType("rox50");

        public static const ROX60:core.general.UnitType=new UnitType("rox60");

        public static const ROX8:core.general.UnitType=new UnitType("rox8");

        public static const ROX80:core.general.UnitType=new UnitType("rox80");

        public static const ROX81:core.general.UnitType=new UnitType("rox81");

        public static const ROX9:core.general.UnitType=new UnitType("rox9");

        public static const ROX90:core.general.UnitType=new UnitType("rox90");

        public static const ROX70:core.general.UnitType=new UnitType("rox70");

        public static const SigmaMove:core.general.UnitType=new UnitType("SIGMA MOVE");

        public static const TYPES:Array=[BC509, BC1009, BC1009STS, BC1609, BC1609STS, BC1909HR, BC2209MHR, BC512, BC812, BC1212, BC1412, BC1612, BC1612STS, BC812W, BC1212STS, BC416, BC416ATS, BC516, BC716, BC716ATS, BC916, BC916ATS, BC1616, BC1616STS, BC1416, BC1416STS, BC2316STS, ROX80, ROX8, ROX90, ROX9, ROX81, ROX91, ROX50, ROX60, ROX70, ROX100, ROX110, RC1209, RC1411, PC2814, GPS10, SigmaMove, Activo];

        public static const Activo:core.general.UnitType=new UnitType("ACTIVO");

        public static const BC1009:core.general.UnitType=new UnitType("bc1009");

        public static const ROX91:core.general.UnitType=new UnitType("rox91");

        public static var _dataProvider:Array;

        internal var typeString:String;
    }
}


