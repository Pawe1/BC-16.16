//class Topline2009Decoder
package decoder 
{
    import __AS3__.vec.*;
    import core.*;
    import core.activities.*;
    import core.general.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.totals.*;
    import core.totals.interfaces.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import utils.converter.*;
    
    public class Topline2009Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings
    {
        public function Topline2009Decoder()
        {
            super();
            return;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc31:*;
            (loc31 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.SettingsTopline2009).unit = arg2;
            var loc15:*=false;
            var loc28:*;
            if (!(loc15 = (loc28 = arg1[0]) == 0)) 
            {
                dispatchEvent(new flash.events.Event("data_not_valid"));
                return null;
            }
            var loc32:*=arg1[1];
            var loc4:*="";
            var loc11:*;
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc3:*;
            (loc3 = core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type) as core.totals.TotalsBikeComputer).unit = arg2;
            var loc4:*=false;
            var loc12:*;
            if (!(loc4 = (loc12 = arg1[0]) == 0)) 
            {
                dispatchEvent(new flash.events.Event("data_not_valid"));
                return null;
            }
            var loc15:*;
            (loc15 = new utils.converter.DistanceConverter()).inputFormat = core.MeasurementConfig.distanceFormat;
            loc15.outputFormat = "meter";
            var loc13:*;
            (loc13 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc13.outputFormat = "millimeter";
            var loc5:*=parseInt(arg1[46].toString() + arg1[47].toString() + arg1[48].toString() + arg1[49].toString() + arg1[50].toString());
            if (loc3 is core.totals.interfaces.ITotalDistance1) 
            {
                (loc3 as core.totals.interfaces.ITotalDistance1).totalDistance1 = loc15.convert(loc5);
            }
            var loc10:*=parseInt(arg1[51].toString() + arg1[52].toString() + arg1[53].toString() + arg1[54].toString() + arg1[55].toString());
            if (loc3 is core.totals.interfaces.ITotalDistance2) 
            {
                (loc3 as core.totals.interfaces.ITotalDistance2).totalDistance2 = loc15.convert(loc10);
            }
            var loc14:*=parseInt(arg1[56].toString() + arg1[57].toString() + arg1[58].toString() + arg1[59].toString()) * 3600;
            var loc8:*=parseInt(arg1[60].toString() + arg1[61].toString()) * 60;
            if (loc3 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                (loc3 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = (loc14 + loc8) * 100;
            }
            var loc2:*=parseInt(arg1[62].toString() + arg1[63].toString() + arg1[64].toString() + arg1[65].toString()) * 3600;
            var loc9:*=parseInt(arg1[66].toString() + arg1[67].toString()) * 60;
            if (loc3 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                (loc3 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = (loc2 + loc9) * 100;
            }
            var loc7:*=parseInt(arg1[68].toString() + arg1[69].toString() + arg1[70].toString() + arg1[71].toString() + arg1[72].toString());
            if (loc3 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                (loc3 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = loc13.convert(loc7);
            }
            var loc6:*=parseInt(arg1[73].toString() + arg1[74].toString() + arg1[75].toString() + arg1[76].toString() + arg1[77].toString());
            if (loc3 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                (loc3 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 = loc13.convert(loc6);
            }
            var loc1:*=parseInt(arg1[86].toString() + arg1[87].toString() + arg1[88].toString() + arg1[89].toString());
            loc1 = loc1 * 3600;
            loc1 = loc1 + parseInt(arg1[90].toString() + arg1[91].toString()) * 60;
            var loc11:*=parseInt(arg1[92].toString() + arg1[93].toString() + arg1[94].toString() + arg1[95].toString() + arg1[96].toString());
            if (loc3 is core.totals.interfaces.ITotalHikingTime) 
            {
                (loc3 as core.totals.interfaces.ITotalHikingTime).totalHikingTime = loc1 * 100;
            }
            if (loc3 is core.totals.interfaces.ITotalHikingAltitude) 
            {
                (loc3 as core.totals.interfaces.ITotalHikingAltitude).totalHikingAltitude = loc13.convert(loc11);
            }
            return loc3;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc89:*=null;
            var loc70:*=null;
            var loc86:*=NaN;
            var loc35:*=null;
            var loc109:*=null;
            var loc94:*=[];
            var loc28:*=arg1.currentSettings as core.settings.SettingsTopline2009;
            var loc75:*=(arg1 as core.units.UnitTopline2009).currentTotals as core.totals.TotalsBikeComputer;
            var loc83:*=0;
            loc94.push(loc83);
            var loc80:*=parseInt(1.toString(), 16);
        }

        public function decodeMemory(arg1:Object, arg2:core.units.UnitTopline2009):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc17:*=NaN;
            var loc1:*=core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory");
            loc1.unit = arg2;
            loc1.serialNumber = arg2.serialNumber;
            var loc22:*;
            var loc15:*;
            if (!(loc15 = (loc22 = arg1[0]) == 0)) 
            {
                dispatchEvent(new flash.events.Event("data_not_valid"));
                return null;
            }
            var loc11:*;
            (loc11 = new utils.converter.DistanceConverter()).inputFormat = core.MeasurementConfig.distanceFormat;
            loc11.outputFormat = "meter";
            var loc5:*=new Number(arg1[1].toString() + arg1[2].toString() + arg1[3].toString() + arg1[4].toString() + "." + arg1[5].toString() + arg1[6].toString());
            if (loc1.distanceDefined) 
            {
                loc1.distance = loc11.convert(loc5);
            }
            var loc13:*=parseInt(arg1[7].toString() + arg1[8].toString() + arg1[9].toString());
            var loc7:*=parseInt(arg1[10].toString() + arg1[11].toString());
            var loc10:*=parseInt(arg1[12].toString() + arg1[13].toString());
            var loc12:*=loc13 * 3600 + loc7 * 60 + loc10;
            if (loc1.trainingTimeDefined) 
            {
                loc1.trainingTime = loc12 * 100;
            }
            loc1.dateCode = loc5 + "_" + loc12;
            var loc2:*;
            (loc2 = new utils.converter.SpeedConverter()).inputFormat = core.MeasurementConfig.speedFormat;
            loc2.outputFormat = "ms";
            var loc19:*=new Number(arg1[14].toString() + arg1[15].toString() + arg1[16].toString() + "." + arg1[17].toString() + arg1[18].toString());
            if (loc1.averageSpeedDefined) 
            {
                loc1.averageSpeed = loc2.convert(loc19);
            }
            if (core.general.UnitType.BC509 == loc1.unitType) 
            {
                if (loc1.trainingTime != 0) 
                {
                    loc17 = loc1.distance / loc1.trainingTime;
                    loc1.averageSpeed = loc17;
                }
            }
            var loc18:*=new Number(arg1[19].toString() + arg1[20].toString() + arg1[21].toString() + "." + arg1[22].toString() + arg1[23].toString());
            if (loc1.maximumSpeedDefined) 
            {
                loc1.maximumSpeed = loc2.convert(loc18);
            }
            var loc14:*=parseInt(arg1[24].toString() + arg1[25].toString() + arg1[26].toString());
            if (loc1.averageCadenceDefined) 
            {
                loc1.averageCadence = loc14;
            }
            var loc4:*=parseInt(arg1[27].toString() + arg1[28].toString() + arg1[29].toString());
            if (loc1.averageHeartrateDefined) 
            {
                loc1.averageHeartrate = loc4;
            }
            var loc8:*=parseInt(arg1[30].toString() + arg1[31].toString() + arg1[32].toString());
            if (loc1.maximumHeartrateDefined) 
            {
                loc1.maximumHeartrate = loc8;
            }
            var loc20:*=parseInt(arg1[33].toString() + arg1[34].toString() + arg1[35].toString() + arg1[36].toString());
            if (loc1.caloriesDefined) 
            {
                loc1.calories = loc20;
            }
            var loc9:*;
            (loc9 = new utils.converter.AltitudeConverter()).inputFormat = core.MeasurementConfig.altitudeFormat;
            loc9.outputFormat = "millimeter";
            var loc3:*=parseInt(arg1[37].toString() + arg1[38].toString() + arg1[39].toString() + arg1[40].toString() + arg1[41].toString());
            var loc6:*;
            var loc23:*=(loc6 = arg1[42]) == 0;
            if (loc1.altitudeDifferencesDownhillDefined && loc23) 
            {
                loc1.altitudeDifferencesDownhill = loc9.convert(loc3);
            }
            else if (loc1.altitudeDifferencesUphillDefined) 
            {
                loc1.altitudeDifferencesUphill = loc9.convert(loc3);
            }
            var loc16:*=parseInt(arg1[43].toString() + arg1[44].toString() + arg1[45].toString() + arg1[46].toString() + arg1[47].toString());
            if (loc1.maximumAltitudeDefined) 
            {
                loc1.maximumAltitude = loc9.convert(loc16);
            }
            loc1.startDate = new Date();
            var loc21:*;
            (loc21 = new __AS3__.vec.Vector.<core.activities.Activity>()).push(loc1);
            return loc21;
        }

        internal function push(arg1:Array, arg2:Array):void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < arg1.length) 
            {
                arg2.push(arg1[loc1]);
                ++loc1;
            }
            return;
        }

        public static function getInstance():decoder.Topline2009Decoder
        {
            if (_instance == null) 
            {
                _instance = new Topline2009Decoder();
            }
            return _instance as Topline2009Decoder;
        }

        public static const DATA_INVALID:String="data_not_valid";

        internal static var _instance:decoder.Topline2009Decoder;
    }
}


