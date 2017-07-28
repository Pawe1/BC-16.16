//class SettingsTopline2009
package core.settings 
{
    import core.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsTopline2009 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IWheelSize1
    {
        public function SettingsTopline2009(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get actualAltitudeMax():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get actualAltitudeMin():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get bodyWeightMax():int
        {
            return 199000;
        }

        public function get bodyWeightMin():int
        {
            return 20000;
        }

        public function get homeAltitude1Max():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get homeAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public function get seaLevelMax():Number
        {
            return 1050;
        }

        public function get seaLevelMin():Number
        {
            return 950;
        }

        public function get wheelSize2Min():int
        {
            return 1000;
        }

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public function set wheelSize1(arg1:int):void
        {
            if (_wheelSize1 !== arg1) 
            {
                _wheelSize1 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize1Change"));
            }
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public function get wheelSize1Min():int
        {
            return 1000;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public static const WHEEL_SIZE_2_MIN:int=1000;

        public static const ACT_ALTIFT_MAX:int=3962095;

        public static const ACT_ALTIFT_MIN:int=-304495;

        public static const ACT_ALTIM_MAX:int=4999000;

        public static const ACT_ALTIM_MIN:int=-999000;

        public static const AGE_MAX:int=99;

        public static const AGE_MIN:int=10;

        public static const AUTO_SCAN_MAX:int=1;

        public static const AUTO_SCAN_MIN:int=0;

        public static const CLOCK_MAX:int=89999;

        public static const CLOCK_MIN:int=0;

        public static const CONTRAST_MAX:int=3;

        public static const CONTRAST_MIN:int=1;

        public static const GENDER_MAX:int=1;

        public static const GENDER_MIN:int=0;

        public static const HIKING_ACTI_MAX_FT:Number=160932790.656;

        public static const HIKING_ACTI_MAX_M:int=99999000;

        public static const HIKING_ACTI_MIN:int=0;

        public static const HIKING_TIME_HOURS_MAX:int=9999;

        public static const HIKING_TIME_HOURS_MIN:int=0;

        public static const HIKING_TIME_MAX:uint=3599999900;

        public static const HIKING_TIME_MIN:int=0;

        public static const HIKING_TIME_MINUTES_MAX:int=59;

        public static const HIKING_TIME_MINUTES_MIN:int=0;

        public static const HIKING_TIME_SECONDS_MAX:int=59;

        public static const HIKING_TIME_SECONDS_MIN:int=0;

        public static const HOME_ALTIFT_MAX:int=3962095;

        public static const HOME_ALTIFT_MIN:int=-304495;

        public static const HOME_ALTIM_MAX:int=4999000;

        public static const HOME_ALTIM_MIN:int=-999000;

        public static const LANGUAGE_MAX:int=7;

        public static const LANGUAGE_MIN:int=1;

        public static const LBD_LEVEL_MAX:int=15;

        public static const LBD_LEVEL_MIN:int=0;

        public static const LOWER_LIMIT_MAX:int=235;

        public static const LOWER_LIMIT_MIN:int=40;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=40;

        public static const MAX_ALTI_1_MAX_FT:Number=160932790.656;

        public static const MAX_ALTI_1_MAX_M:int=99999000;

        public static const MAX_ALTI_1_MIN:int=0;

        public static const MEASUREMENT_MAX:int=1;

        public static const MEASUREMENT_MIN:int=0;

        public static const POWER_ON_MODE_MAX:int=2;

        public static const POWER_ON_MODE_MIN:int=0;

        public static const SEA_LEVEL_MAX:int=1050;

        public static const SEA_LEVEL_MIN:int=950;

        public static const SERVICE_INT_MAX:int=99999;

        public static const SERVICE_INT_MIN:int=50;

        public static const SERVICE_STATUS_MAX:int=1;

        public static const SERVICE_STATUS_MIN:int=0;

        public static const TOTALTIMEBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE2_SECONDS_MIN:int=0;

        public static const TOTAL_ALTI_1_MAX_FT:Number=160932790.656;

        public static const TOTAL_ALTI_1_MAX_M:int=99999000;

        public static const TOTAL_ALTI_1_MIN:int=0;

        public static const TOTAL_ALTI_2_MAX_FT:Number=160932790.656;

        public static const TOTAL_ALTI_2_MAX_M:int=99999000;

        public static const TOTAL_ALTI_2_MIN:int=0;

        public static const TOTAL_ODO_1_MAX_FT:Number=160932790.656;

        public static const TOTAL_ODO_1_MAX_M:int=99999000;

        public static const TOTAL_ODO_1_MIN:int=0;

        public static const TOTAL_ODO_2_MAX_FT:Number=160932790.656;

        public static const TOTAL_ODO_2_MAX_M:int=99999000;

        public static const TOTAL_ODO_2_MIN:int=0;

        public static const TOTAL_TIME_2_MIN:int=0;

        public static const UPPER_LIMIT_MAX:int=240;

        public static const UPPER_LIMIT_MIN:int=45;

        public static const WEIGHTLB_MAX:int=399;

        public static const WEIGHTLB_MIN:int=40;

        public static const WEIGHT_G_MAX:int=199000;

        public static const WEIGHT_G_MIN:int=20000;

        public static const WHEEL_SIZE_1_MAX:int=3999;

        public static const WHEEL_SIZE_1_MIN:int=1000;

        public static const WHEEL_SIZE_2_MAX:int=3999;

        internal var _wheelSize1:int=2155;
    }
}


