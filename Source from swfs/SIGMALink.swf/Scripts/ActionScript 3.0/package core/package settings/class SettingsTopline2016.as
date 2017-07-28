//class SettingsTopline2016
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsTopline2016 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IWheelSize1Mode, core.settings.interfaces.ITireSize1, core.settings.interfaces.IWheelSize1
    {
        public function SettingsTopline2016(arg1:flash.events.IEventDispatcher=null)
        {
            _selectionMode = core.general.WheelSizeSelectionMode.TIRE;
            _tireSize = core.general.TireSize.S_16INCH;
            super(arg1);
            return;
        }

        public function get tireSize1():core.general.TireSize
        {
            return _tireSize;
        }

        public function set tireSize1(arg1:core.general.TireSize):void
        {
            _tireSize = arg1;
            if (arg1 && core.general.WheelSizeSelectionMode.TIRE.equals(wheelSize1Mode)) 
            {
                wheelSize1 = parseInt(arg1.data);
            }
            return;
        }

        public function set wheelSize1Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _selectionMode = arg1;
            return;
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
            return 500;
        }

        public function get wheelSize1Mode():core.general.WheelSizeSelectionMode
        {
            return _selectionMode;
        }

        public static const WHEEL_SIZE_1_MIN:int=500;

        public static const WHEEL_SIZE_2_MAX:int=3999;

        public static const DISTANCE2_MAX_KM:int=99999000;

        public static const WHEEL_SIZE_2_MIN:int=500;

        public static const ACT_ALTIFT_MAX:int=5181295;

        public static const ACT_ALTIFT_MIN:int=-304495;

        public static const ACT_ALTIM_MAX:int=4999000;

        public static const ACT_ALTIM_MIN:int=-999000;

        public static const CALORIES_MAX:int=99999;

        public static const CALORIES_MIN:int=0;

        public static const CONTRAST_MAX:int=3;

        public static const CONTRAST_MIN:int=1;

        public static const DISTANCE1_MAX_KM:int=99999000;

        protected static const NOW:Date=new Date();

        public static const DISTANCE1_MAX_MI:Number=160932790.656;

        public static const DISTANCE2_MAX_MI:Number=160932790.656;

        public static const ETA_DISTANCE_MAX:Number=160935121;

        public static const FUEL_CONSUMPTION_LITER_MAX:Number=30;

        public static const FUEL_CONSUMPTION_LITER_MIN:Number=1;

        public static const FUEL_CONSUMPTION_MPG_MAX:Number=23.52;

        public static const FUEL_CONSUMPTION_MPG_MIN:Number=0.98;

        public static const HOME_ALTIFT_MAX:int=3962095;

        public static const HOME_ALTIFT_MIN:int=-304495;

        public static const HOME_ALTIM_MAX:int=4999000;

        public static const HOME_ALTIM_MIN:int=-999000;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=40;

        public static const SEA_LEVEL_MAX:int=1050;

        public static const SEA_LEVEL_MIN:int=950;

        public static const SHOULDERWIDTH_CM_MAX:int=80;

        public static const SHOULDERWIDTH_CM_MIN:int=40;

        public static const SHOULDERWIDTH_INCH_MAX_IN_CM:int=76;

        public static const SHOULDERWIDTH_INCH_MIN_IN_CM:int=38;

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

        public static const TOTAL_FUEL_CONSUMPTION_MAX:Number=9999.9;

        public static const TOTAL_FUEL_CONSUMPTION_MIN:Number=0;

        public static const TOTAL_ODO_1_MAX_FT:Number=160932790.656;

        public static const TOTAL_ODO_1_MAX_M:int=99999000;

        public static const TOTAL_ODO_1_MIN:int=0;

        public static const TOTAL_ODO_2_MAX_FT:Number=160932790.656;

        public static const TOTAL_ODO_2_MAX_M:int=99999000;

        public static const TOTAL_ODO_2_MIN:int=0;

        public static const TRAININGTIME_BIKE1_MAX:uint=3599999900;

        public static const TRAININGTIME_BIKE2_MAX:uint=3599999900;

        public static const USERSIZE_CM_MAX:int=250;

        public static const USERSIZE_CM_MIN:int=100;

        public static const USERSIZE_INCH_MAX_IN_CM:int=254;

        public static const USERSIZE_INCH_MIN_IN_CM:int=102;

        public static const WEIGHTBIKE_KG_MAX_IN_G:int=50000;

        public static const WEIGHTBIKE_KG_MIN_IN_G:int=1000;

        public static const WEIGHTBIKE_LB_MAX_IN_G:int=45359;

        public static const WEIGHTBIKE_LB_MIN_IN_G:int=1361;

        public static const WEIGHT_KG_MAX_IN_G:int=200000;

        public static const WEIGHT_KG_MIN_IN_G:int=20000;

        public static const WEIGHT_LB_MAX_IN_G:int=181437;

        public static const WEIGHT_LB_MIN_IN_G:int=18144;

        public static const WHEEL_SIZE_1_MAX:int=3999;

        internal var _wheelSize1:int=1253;

        internal var _selectionMode:core.general.WheelSizeSelectionMode;

        internal var _tireSize:core.general.TireSize;

        internal var _speedUnit:String="kmh";
    }
}


