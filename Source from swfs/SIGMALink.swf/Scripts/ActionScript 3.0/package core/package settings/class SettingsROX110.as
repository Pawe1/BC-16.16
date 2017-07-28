//class SettingsROX110
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX110 extends core.settings.SettingsROX70 implements core.settings.interfaces.ISamplingRate, core.settings.interfaces.IWeightUnit, core.settings.interfaces.IYearOfBirth, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyHeight, core.settings.interfaces.IShoulderWidth, core.settings.interfaces.IHRmax, core.settings.interfaces.IStravaSegmentsEnabled
    {
        public function SettingsROX110(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            timeZone = 8;
            contrast = 3;
            myName = "ROX GPS 11.0";
            return;
        }

        public function set yearOfBirth(arg1:int):void
        {
            if (arg1 != _yearOfBirth) 
            {
                _yearOfBirth = arg1;
                dispatchEvent(new flash.events.Event("yearOfBirthChange"));
            }
            return;
        }

        public function get bodyHeight():Number
        {
            return _bodyHeight;
        }

        public function set bodyHeight(arg1:Number):void
        {
            if (arg1 != _bodyHeight) 
            {
                _bodyHeight = arg1;
                dispatchEvent(new flash.events.Event("bodyHeightChange"));
            }
            return;
        }

        public function get bodyHeightMax():Number
        {
            if (weightUnit == "kg") 
            {
                return 250;
            }
            return 254;
        }

        public function get bodyHeightMin():Number
        {
            if (weightUnit == "kg") 
            {
                return 100;
            }
            return 102;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            if (weightUnit == "kg") 
            {
                return 200000;
            }
            return 181437;
        }

        public function get bodyWeightMin():int
        {
            if (weightUnit == "kg") 
            {
                return 20000;
            }
            return 18144;
        }

        public override function toString():String
        {
            return "[SettingsROX110 extends SettingsBikeComputer]";
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-settingsROX100Id " + settingsROX70Id;
        }

        public function get samplingRate():Number
        {
            return _samplingRate;
        }

        public function set samplingRate(arg1:Number):void
        {
            if (arg1 != _samplingRate) 
            {
                _samplingRate = arg1;
            }
            return;
        }

        public function get yearOfBirthMin():int
        {
            return 1900;
        }

        public function get shoulderWidth():Number
        {
            return _shoulderWidth;
        }

        public function set shoulderWidth(arg1:Number):void
        {
            if (arg1 != _shoulderWidth) 
            {
                _shoulderWidth = arg1;
                dispatchEvent(new flash.events.Event("shoulderWidthChange"));
            }
            return;
        }

        public function get shoulderWidthMax():Number
        {
            if (distanceUnit == "kilometer") 
            {
                return 80;
            }
            return 76;
        }

        public function get shoulderWidthMin():Number
        {
            if (distanceUnit == "kilometer") 
            {
                return 40;
            }
            return 38;
        }

        public function get yearOfBirth():int
        {
            return _yearOfBirth;
        }

        public function get stravaSegmentsEnabled():Boolean
        {
            return _stravaSegmentsEnabled;
        }

        public function set stravaSegmentsEnabled(arg1:Boolean):void
        {
            _stravaSegmentsEnabled = arg1;
            return;
        }

        public function get yearOfBirthMax():int
        {
            return YEAR_OF_BIRTH_MAX;
        }

        public function get weightUnit():String
        {
            return _weightUnit;
        }

        public function set weightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        internal static const NOW:Date=new Date();

        public static const CONTRAST_MAX:int=10;

        public static const CONTRAST_MIN:int=1;

        public static const HOME_ALTITUDE_FT_MAX_IN_MM:int=5181295;

        public static const HOME_ALTITUDE_FT_MIN_IN_MM:int=-304495;

        public static const HOME_ALTITUDE_M_MAX_IN_MM:int=4999000;

        public static const HOME_ALTITUDE_M_MIN_IN_MM:int=-9990000;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        public static const SHOULDERWIDTH_CM_MAX:int=80;

        public static const SHOULDERWIDTH_CM_MIN:int=40;

        public static const SHOULDERWIDTH_INCH_MAX_IN_CM:int=76;

        public static const SHOULDERWIDTH_INCH_MIN_IN_CM:int=38;

        public static const USERSIZE_CM_MAX:int=250;

        public static const USERSIZE_CM_MIN:int=100;

        public static const USERSIZE_INCH_MAX_IN_CM:int=254;

        public static const USERSIZE_INCH_MIN_IN_CM:int=102;

        public static const WEIGHT_KG_MAX_IN_G:int=200000;

        public static const WEIGHT_KG_MIN_IN_G:int=20000;

        public static const WEIGHT_LB_MAX_IN_G:int=181437;

        public static const WEIGHT_LB_MIN_IN_G:int=18144;

        public static const YEAR_OF_BIRTH_MAX:int=new Date().fullYear - 6;

        public static const YEAR_OF_BIRTH_MIN:int=1900;

        internal var _bodyHeight:Number=180;

        internal var _weightUnit:String="kg";

        internal var _shoulderWidth:Number=44;

        internal var _weight:int=70000;

        internal var _samplingRate:Number=5;

        internal var _hrMax:int=191;

        internal var _stravaSegmentsEnabled:Boolean=true;

        internal var _yearOfBirth:int=1980;
    }
}


