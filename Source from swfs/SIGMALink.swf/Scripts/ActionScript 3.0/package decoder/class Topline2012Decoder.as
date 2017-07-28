//class Topline2012Decoder
package decoder 
{
    import __AS3__.vec.*;
    import com.logging.*;
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
    import utils.date.*;
    
    public class Topline2012Decoder extends flash.events.EventDispatcher implements core.units.interfaces.ICodingSettings, core.units.interfaces.ICodingTotals
    {
        public function Topline2012Decoder()
        {
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (_instance) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10123, "Topline2012Decoder > Constructor: This is a Singleton. Use the getInstace() methode!"));
            }
            return;
        }

        public function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
        {
            var loc26:*;
            (loc26 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.SettingsTopline2012).unit = arg2;
            var loc12:*=false;
            var loc24:*;
            if (!(loc12 = (loc24 = arg1[0]) == 0)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 124, "Topline2012Decoder > decodeSettings: data is not valid"));
                return null;
            }
            var loc3:*="";
            var loc9:*;
        }

        public function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals
        {
            var loc10:*=0;
            var loc7:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc9:*=null;
            var loc6:*=0;
            var loc8:*=0;
            var loc1:*=core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type);
            loc1.unit = arg2;
            var loc2:*=false;
            var loc3:*;
            if (!(loc2 = (loc3 = arg1[0]) == 0)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 124, "Topline2012Decoder > decodeSettings: data is not valid"));
                return null;
            }
            if (loc1 is core.totals.interfaces.ITotalDistance1) 
            {
                loc10 = arg1[1] << 24 | arg1[2] << 16 | arg1[3] << 8 | arg1[4];
                (loc1 as core.totals.interfaces.ITotalDistance1).totalDistance1 = loc10;
            }
            if (loc1 is core.totals.interfaces.ITotalDistance2) 
            {
                loc7 = arg1[5] << 24 | arg1[6] << 16 | arg1[7] << 8 | arg1[8];
                (loc1 as core.totals.interfaces.ITotalDistance2).totalDistance2 = loc7;
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                loc4 = arg1[9] << 24 | arg1[10] << 16 | arg1[11] << 8 | arg1[12];
                (loc1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = loc4 * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                loc5 = arg1[13] << 24 | arg1[14] << 16 | arg1[15] << 8 | arg1[16];
                (loc1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = loc5 * 100;
            }
            if (loc1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                loc9 = new utils.converter.AltitudeConverter("meter", "millimeter");
                loc6 = arg1[17] << 16 | arg1[18] << 8 | arg1[19];
                (loc1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = loc9.convert(loc6 / 10);
            }
            if (loc1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                loc8 = arg1[20] << 16 | arg1[21] << 8 | arg1[22];
                (loc1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1 = loc8 / 100;
            }
            return loc1;
        }

        public function encodeSettings(arg1:core.units.Unit):Array
        {
            var loc4:*=null;
            var loc13:*=[];
            var loc14:*=arg1.currentSettings as core.settings.SettingsTopline2012;
            var loc5:*=1;
        }

        public function encodeTotals(arg1:core.totals.Totals):Array
        {
            var loc4:*=[];
            var loc6:*=0;
            if (arg1 is core.totals.interfaces.ITotalDistance1) 
            {
                loc6 = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1;
            }
            loc4.push(loc6 >> 24 & 255);
            loc4.push(loc6 >> 16 & 255);
            loc4.push(loc6 >> 8 & 255);
            loc4.push(loc6 & 255);
            var loc5:*=0;
            if (arg1 is core.totals.interfaces.ITotalDistance2) 
            {
                loc5 = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2;
            }
            loc4.push(loc5 >> 24 & 255);
            loc4.push(loc5 >> 16 & 255);
            loc4.push(loc5 >> 8 & 255);
            loc4.push(loc5 & 255);
            var loc1:*=0;
            if (arg1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                loc1 = (arg1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 / 100;
            }
            loc4.push(loc1 >> 24 & 255);
            loc4.push(loc1 >> 16 & 255);
            loc4.push(loc1 >> 8 & 255);
            loc4.push(loc1 & 255);
            var loc2:*=0;
            if (arg1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                loc2 = (arg1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 / 100;
            }
            loc4.push(loc2 >> 24 & 255);
            loc4.push(loc2 >> 16 & 255);
            loc4.push(loc2 >> 8 & 255);
            loc4.push(loc2 & 255);
            var loc8:*=new utils.converter.AltitudeConverter("millimeter", "meter");
            var loc3:*=0;
            if (arg1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                loc3 = Math.floor(loc8.convert((arg1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1) * 10);
            }
            loc4.push(loc3 >> 16 & 255);
            loc4.push(loc3 >> 8 & 255);
            loc4.push(loc3 & 255);
            var loc7:*=0;
            if (arg1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                loc7 = (arg1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1 * 100;
            }
            loc4.push(loc7 >> 16 & 255);
            loc4.push(loc7 >> 8 & 255);
            loc4.push(loc7 & 255);
            return loc4;
        }

        public function decodeMemory(arg1:Object, arg2:core.units.Unit):__AS3__.vec.Vector.<core.activities.Activity>
        {
            var loc9:*=NaN;
            var loc3:*;
            (loc3 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
            loc3.serialNumber = arg2.serialNumber;
            var loc14:*;
            var loc4:*;
            if (!(loc4 = (loc14 = arg1[0]) == 0)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 107, "ToplineDecoder > decodeMemory: data is not valid"));
                return null;
            }
            var loc8:*=arg1[1] << 16 | arg1[2] << 8 | arg1[3];
            if (loc3.distanceDefined) 
            {
                loc3.distance = loc8;
            }
            var loc18:*=arg1[4] << 16 | arg1[5] << 8 | arg1[6];
            if (loc3.trainingTimeDefined) 
            {
                loc3.trainingTime = loc18 * 100;
            }
            loc3.dateCode = loc8 + "_" + loc18;
            var loc5:*;
            (loc5 = new utils.converter.SpeedConverter()).inputFormat = "kmh";
            loc5.outputFormat = "ms";
            var loc11:*=arg1[7] << 8 | arg1[8];
            if (loc3.averageSpeedDefined) 
            {
                loc3.averageSpeed = loc5.convert(loc11 / 100);
            }
            if (core.general.UnitType.BC512 == loc3.unitType) 
            {
                if (loc3.trainingTime != 0) 
                {
                    loc9 = loc3.distance / (loc3.trainingTime / 100);
                    loc3.averageSpeed = loc9;
                }
            }
            var loc10:*=arg1[9] << 8 | arg1[10];
            if (loc3.maximumSpeedDefined) 
            {
                loc3.maximumSpeed = loc5.convert(loc10 / 100);
            }
            var loc1:*=arg1[11];
            if (loc3.averageCadenceDefined) 
            {
                loc3.averageCadence = loc1;
            }
            var loc16:*=arg1[12] >> 7 != 0 ? -1 : 1;
            var loc6:*=(arg1[12] & -129) << 8 | arg1[13];
            if (loc3.maximumAltitudeDefined) 
            {
                loc3.maximumAltitude = loc6 * loc16 * 1000;
            }
            var loc7:*=arg1[14] << 16 | arg1[15] << 8 | arg1[16];
            if (loc3.tripSectionDistanceDefined) 
            {
                loc3.tripSectionDistance = loc7;
            }
            var loc2:*=arg1[17] << 16 | arg1[18] << 8 | arg1[19];
            if (loc3.tripSectionTimeDefined) 
            {
                loc3.tripSectionTime = loc2 * 100;
            }
            var loc15:*=(loc15 = arg1[20] << 16 | arg1[21] << 8 | arg1[22]) / 10;
            if (loc3.altitudeDifferencesUphillDefined) 
            {
                loc3.altitudeDifferencesUphill = loc15 * 1000;
            }
            var loc12:*;
            if ((loc12 = arg1[23]) != 0) 
            {
                if (loc12 == 1) 
                {
                    loc3.bike = "bike2";
                }
            }
            else 
            {
                loc3.bike = "bike1";
            }
            var loc13:*=arg1[24] << 16 | arg1[25] << 8 | arg1[26];
            if (loc3.fuelEconomyDefined) 
            {
                loc3.fuelEconomy = loc13 / 100;
            }
            loc3.startDate = new Date();
            var loc17:*;
            (loc17 = new __AS3__.vec.Vector.<core.activities.Activity>()).push(loc3);
            return loc17;
        }

        public static function getInstance():decoder.Topline2012Decoder
        {
            if (_instance == null) 
            {
                _instance = new Topline2012Decoder();
            }
            return _instance as Topline2012Decoder;
        }

        internal static var _instance:decoder.Topline2012Decoder;
    }
}


