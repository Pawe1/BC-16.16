//class TotalsROX60
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsROX60 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalTrainingTime2, core.totals.interfaces.ITotalDistance2, core.totals.interfaces.ITotalCal1, core.totals.interfaces.ITotalCal2, core.totals.interfaces.ITotalClimbMeter1, core.totals.interfaces.ITotalClimbMeter2, core.totals.interfaces.ITotalHikingAltitude, core.totals.interfaces.ITotalHikingCalories, core.totals.interfaces.ITotalHikingTime
    {
        public function TotalsROX60(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get totalTrainingTime2Max():uint
        {
            return 3599999900;
        }

        public function get age():int
        {
            return _age;
        }

        public function set age(arg1:int):void
        {
            if (arg1 != _age) 
            {
                _age = arg1;
                dispatchEvent(new flash.events.Event("AgeChange"));
            }
            return;
        }

        public function get weight():int
        {
            return _weight;
        }

        public function get totalCal1():int
        {
            return _totalCal1;
        }

        public function set totalCal1(arg1:int):void
        {
            if (arg1 != _totalCal1) 
            {
                _totalCal1 = arg1;
                dispatchEvent(new flash.events.Event("totalCal1Change"));
            }
            return;
        }

        public function get totalCal1Max():int
        {
            return 99999;
        }

        public function get totalCal1Min():int
        {
            return 0;
        }

        public function set weight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get totalCal2():int
        {
            return _totalCal2;
        }

        public function set totalCal2(arg1:int):void
        {
            if (arg1 != _totalCal2) 
            {
                _totalCal2 = arg1;
                dispatchEvent(new flash.events.Event("totalCal2Change"));
            }
            return;
        }

        public function get totalCal2Max():int
        {
            return 99999;
        }

        public function get totalCal2Min():int
        {
            return 0;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-totalTrainingTime1 " + totalTrainingTime1.toString();
        }

        public function get totalClimbMeter1():int
        {
            return _totalClimbMeter1;
        }

        public function set totalClimbMeter1(arg1:int):void
        {
            if (arg1 != _totalClimbMeter1) 
            {
                _totalClimbMeter1 = arg1;
                dispatchEvent(new flash.events.Event("totalClimbMeter1Change"));
            }
            return;
        }

        public function get totalClimbMeter1Max():int
        {
            if (core.MeasurementConfig.distanceFormat == "feet") 
            {
                return 160932790.656;
            }
            return 99999000;
        }

        public function get totalClimbMeter1Min():int
        {
            return 0;
        }

        public override function resetValues():void
        {
            super.resetValues();
            totalTrainingTime1 = 0;
            totalTrainingTime2 = 0;
            totalDistance2 = 0;
            totalClimbMeter1 = 0;
            totalClimbMeter2 = 0;
            totalCal1 = 0;
            totalCal2 = 0;
            totalHikingTime = 0;
            totalHikingAltitude = 0;
            totalHikingCalories = 0;
            return;
        }

        public function get totalClimbMeter2():int
        {
            return _totalClimbMeter2;
        }

        public function set totalClimbMeter2(arg1:int):void
        {
            if (arg1 != _totalClimbMeter2) 
            {
                _totalClimbMeter2 = arg1;
                dispatchEvent(new flash.events.Event("totalClimbMeter2Change"));
            }
            return;
        }

        public function get totalClimbMeter2Max():int
        {
            if (core.MeasurementConfig.distanceFormat == "feet") 
            {
                return 160932790.656;
            }
            return 99999000;
        }

        public function get totalClimbMeter2Min():int
        {
            return 0;
        }

        public override function get totalDistance1Max():Number
        {
            if (core.MeasurementConfig.distanceFormat == "kilometer") 
            {
                return 99999000;
            }
            return 160932790.656;
        }

        public override function get totalDistance1Min():Number
        {
            return 0;
        }

        public override function toString():String
        {
            return "[TotalsROX60]";
        }

        public function get totalDistance2():Number
        {
            return _totalDistance2;
        }

        public function set totalDistance2(arg1:Number):void
        {
            if (arg1 != _totalDistance2) 
            {
                _totalDistance2 = arg1;
                dispatchEvent(new flash.events.Event("totalDistance2Change"));
            }
            return;
        }

        public function get totalDistance2Max():Number
        {
            if (core.MeasurementConfig.distanceFormat == "kilometer") 
            {
                return 99999000;
            }
            return 160932790.656;
        }

        public function get totalDistance2Min():Number
        {
            return 0;
        }

        public function get totalHikingAltitude():int
        {
            return _totalHikingAltitude;
        }

        public function set totalHikingAltitude(arg1:int):void
        {
            if (arg1 != _totalHikingAltitude) 
            {
                _totalHikingAltitude = arg1;
                dispatchEvent(new flash.events.Event("totalHikingAltitudeChange"));
            }
            return;
        }

        public function get totalHikingAltitudeMax():int
        {
            return 99999000;
        }

        public function get totalHikingAltitudeMin():int
        {
            return 0;
        }

        public function get totalHikingCalories():int
        {
            return _totalHikingCalories;
        }

        public function set totalHikingCalories(arg1:int):void
        {
            if (arg1 != _totalHikingCalories) 
            {
                _totalHikingCalories = arg1;
                dispatchEvent(new flash.events.Event("totalHikingCaloriesChange"));
            }
            return;
        }

        public function get totalHikingCaloriesMax():int
        {
            return 99999;
        }

        public function get totalHikingCaloriesMin():int
        {
            return 0;
        }

        public function get totalHikingTime():uint
        {
            return _totalHikingTime;
        }

        public function set totalHikingTime(arg1:uint):void
        {
            if (arg1 != totalHikingTime) 
            {
                _totalHikingTime = arg1;
                dispatchEvent(new flash.events.Event("totalHikingTimeChange"));
            }
            return;
        }

        public function get totalHikingTimeMax():uint
        {
            return 3599999900;
        }

        public function get totalTrainingTime1():uint
        {
            return _totalTrainingTime1;
        }

        public function set totalTrainingTime1(arg1:uint):void
        {
            if (arg1 != _totalTrainingTime1) 
            {
                _totalTrainingTime1 = arg1;
                dispatchEvent(new flash.events.Event("totalTrainingTime1Change"));
            }
            return;
        }

        public function get totalTrainingTime1Max():uint
        {
            return 3599999900;
        }

        public function get totalTrainingTime2():uint
        {
            return _totalTrainingTime2;
        }

        public function set totalTrainingTime2(arg1:uint):void
        {
            if (arg1 != _totalTrainingTime2) 
            {
                _totalTrainingTime2 = arg1;
                dispatchEvent(new flash.events.Event("totalTrainingTime2Change"));
            }
            return;
        }

        internal var _age:int;

        internal var _totalCal1:int;

        internal var _totalCal2:int;

        internal var _totalClimbMeter1:int;

        internal var _totalClimbMeter2:int;

        internal var _totalDistance2:Number;

        internal var _weight:int;

        internal var _totalHikingTime:int;

        internal var _totalTrainingTime2:uint;

        internal var _totalTrainingTime1:uint;

        internal var _totalHikingAltitude:int;

        internal var _totalHikingCalories:int;
    }
}


