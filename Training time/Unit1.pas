unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  Arg1: array [0..27] of Byte = (
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0);

procedure TForm1.FormCreate(Sender: TObject);
begin

loc3.trainingTime = ((arg1[5] & 7) << 16 | arg1[4] << 8 | arg1[3]) * 100;
            var loc5:*=(arg1[6] & 63) + 2000;
            var loc4:*=arg1[14] >> 4;
            var loc7:*=arg1[5] >> 3;
            var loc6:*=arg1[21] >> 3;
            var loc2:*=arg1[7] & 63;
            var loc1:*=arg1[27] & 63;
            loc3.startDate = new Date(loc5, (loc4 - 1), loc7, loc6, loc2, loc1);

end;


//public function decodeSettingsNFC(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings
//{
//    var loc8:*=NaN;
//    var loc10:*;
//    (loc10 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.Settings).unit = arg2;
//    var loc2:*=(arg1[9] & 63) + 2000;
//    var loc7:*=arg1[10] & 15;
//    var loc11:*=arg1[11] & 31;
//    var loc1:*=arg1[0] & 31;
//    var loc3:*=arg1[3] >> 2 & 63;
//    var loc6:*=arg1[4] & 63;
//    if (loc10 as core.settings.interfaces.IClock)
//    {
//        (loc10 as core.settings.interfaces.IClock).clock = new Date();
//        (loc10 as core.settings.interfaces.IClock).clock.setHours(loc1, loc3, loc6);
//        (loc10 as core.settings.interfaces.IClock).clock.setFullYear(loc2, (loc7 - 1), loc11);
//    }
//    if (loc10 is core.settings.interfaces.IDate)
//    {
//        loc10.date = new Date(loc2, (loc7 - 1), loc11, loc1, loc3, loc6, 0);
//    }
//    var loc4:*="";
//}
// public function decodeActivityNFC(arg1:Array, arg2:core.units.Unit):__AS3__.vec.Vector.<core.activities.Activity>
//{
//    var loc3:*;
//    (loc3 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
//    loc3.serialNumber = arg2.serialNumber;
//    if (loc3.distanceDefined)
//    {
//        loc3.distance = arg1[2] << 16 | arg1[1] << 8 | arg1[0];
//    }
//    loc3.trainingTime = ((arg1[5] & 7) << 16 | arg1[4] << 8 | arg1[3]) * 100;
//    var loc5:*=(arg1[6] & 63) + 2000;
//    var loc4:*=arg1[14] >> 4;
//    var loc7:*=arg1[5] >> 3;
//    var loc6:*=arg1[21] >> 3;
//    var loc2:*=arg1[7] & 63;
//    var loc1:*=arg1[27] & 63;
//    loc3.startDate = new Date(loc5, (loc4 - 1), loc7, loc6, loc2, loc1);
//    if (loc3.averageSpeedDefined)
//    {
//        loc3.averageSpeed = (arg1[9] << 8 | arg1[8]) / 360;
//    }
//    if (loc3.maximumSpeedDefined)
//    {
//        loc3.maximumSpeed = (arg1[11] << 8 | arg1[10]) / 360;
//    }
//    loc3.bike = arg1[11] >> 7 != 0 ? "bike2" : "bike1";
//    if (loc3.fuelEconomyDefined)
//    {
//        loc3.fuelEconomy = ((arg1[14] & 15) << 16 | arg1[13] << 8 | arg1[12]) / 100;
//    }
//    if (loc3.averageCadenceDefined)
//    {
//        loc3.averageCadence = arg1[15];
//    }
//    if (loc3.altitudeDifferencesUphillDefined)
//    {
//        loc3.altitudeDifferencesUphill = ((arg1[18] & 15) << 16 | arg1[17] << 8 | arg1[16]) * 100;
//    }
//    if (loc3.tripSectionTimeDefined)
//    {
//        loc3.tripSectionTime = ((arg1[21] & 7) << 16 | arg1[20] << 8 | arg1[19]) * 100;
//    }
//    if (loc3.tripSectionDistanceDefined)
//    {
//        loc3.tripSectionDistance = arg1[24] << 16 | arg1[23] << 8 | arg1[22];
//    }
//    if (loc3.maximumAltitudeDefined)
//    {
//        loc3.maximumAltitude = ((arg1[26] << 8 | arg1[25]) - 10000) * 100;
//    }
//    loc3 = generateGUID(loc3);
//    new __AS3__.vec.Vector.<core.activities.Activity>(1)[0] = loc3;
//    return new __AS3__.vec.Vector.<core.activities.Activity>(1);
//}
//
//public function decodeTotalsNFC(arg1:Array, arg2:core.units.Unit):core.totals.Totals
//{
//    var loc1:*=core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type);
//    loc1.unit = arg2;
//    if (loc1 is core.totals.interfaces.ITotalDistance1)
//    {
//        (loc1 as core.totals.interfaces.ITotalDistance1).totalDistance1 = (arg1[3] & 15) << 24 | arg1[2] << 16 | arg1[1] << 8 | arg1[0];
//    }
//    if (loc1 is core.totals.interfaces.ITotalTrainingTime1)
//    {
//        (loc1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = ((arg1[9] & 3) << 24 | arg1[8] << 16 | arg1[7] << 8 | arg1[6]) * 100;
//    }
//    if (loc1 is core.totals.interfaces.ITotalDistance2)
//    {
//        (loc1 as core.totals.interfaces.ITotalDistance2).totalDistance2 = (arg1[13] & 15) << 24 | arg1[12] << 16 | arg1[11] << 8 | arg1[10];
//    }
//    if (loc1 is core.totals.interfaces.ITotalTrainingTime2)
//    {
//        (loc1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = ((arg1[19] & 3) << 24 | arg1[18] << 16 | arg1[17] << 8 | arg1[16]) * 100;
//    }
//    if (loc1 is core.totals.interfaces.ITotalCal1)
//    {
//        (loc1 as core.totals.interfaces.ITotalCal1).totalCal1 = (arg1[22] & 1) << 16 | arg1[21] << 8 | arg1[20];
//    }
//    if (loc1 is core.totals.interfaces.ITotalCal2)
//    {
//        (loc1 as core.totals.interfaces.ITotalCal2).totalCal2 = (arg1[25] & 1) << 16 | arg1[24] << 8 | arg1[23];
//    }
//    return loc1;
//}

//public function decodeTotalsAdvancedNFC(arg1:Array, arg2:core.totals.Totals):core.totals.Totals
//{
//    var loc1:*=arg2;
//    if (loc1 is core.totals.interfaces.ITotalClimbMeter1)
//    {
//        (loc1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = ((arg1[2] & 15) << 16 | arg1[1] << 8 | arg1[0]) * 10;
//    }
//    if (loc1 is core.totals.interfaces.ITotalClimbMeter2)
//    {
//        (loc1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 = ((arg1[5] & 15) << 16 | arg1[4] << 8 | arg1[3]) * 10;
//    }
//    if (loc1 is core.totals.interfaces.ITotalDescent1)
//    {
//        (loc1 as core.totals.interfaces.ITotalDescent1).totalDescent1 = ((arg1[8] & 15) << 16 | arg1[7] << 8 | arg1[6]) * 10;
//    }
//    if (loc1 is core.totals.interfaces.ITotalDescent2)
//    {
//        (loc1 as core.totals.interfaces.ITotalDescent2).totalDescent2 = ((arg1[11] & 15) << 16 | arg1[10] << 8 | arg1[9]) * 10;
//    }
//    if (loc1 is core.totals.interfaces.ITotalTripDistUp1)
//    {
//        (loc1 as core.totals.interfaces.ITotalTripDistUp1).totalTripDistUp1 = (arg1[15] & 15) << 24 | arg1[14] << 16 | arg1[13] << 8 | arg1[12];
//    }
//    if (loc1 is core.totals.interfaces.ITotalTripDistUp2)
//    {
//        (loc1 as core.totals.interfaces.ITotalTripDistUp2).totalTripDistUp2 = (arg1[21] & 15) << 24 | arg1[20] << 16 | arg1[19] << 8 | arg1[18];
//    }
//    if (loc1 is core.totals.interfaces.ITotalTripDistDown1)
//    {
//        (loc1 as core.totals.interfaces.ITotalTripDistDown1).totalTripDistDown1 = (arg1[27] & 15) << 24 | arg1[26] << 16 | arg1[25] << 8 | arg1[24];
//    }
//    if (loc1 is core.totals.interfaces.ITotalTripDistDown2)
//    {
//        (loc1 as core.totals.interfaces.ITotalTripDistDown2).totalTripDistDown2 = (arg1[33] & 15) << 24 | arg1[32] << 16 | arg1[31] << 8 | arg1[30];
//    }
//    return loc1;
//}

// public function decodeInitialInformationNFC(arg1:Array, arg2:Array):core.units.Unit
//{
//    var loc2:*=null;
//    if (arg2 == null || arg2.length == 0 || !calculateChecksumm(arg2))
//    {
//        return null;
//    }
//    var loc1:*=parseInt((arg2[0] as int).toString(16), 10);
//}//public function decodeAdvancedSettingsNFC(arg1:Object, arg2:core.settings.Settings):core.settings.Settings//{
//    var loc3:*=0;
//    var loc2:*=0;
//    var loc5:*=0;
//    var loc7:*=null;
//    var loc8:*=0;
//    var loc6:*=0;
//    var loc1:*=null;
//    var loc12:*=null;
//    var loc11:*;
//    if ((loc11 = arg2) is core.settings.interfaces.IHomeAltitude1)
//    {
//        (loc11 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = ((arg1[1] << 8 | arg1[0]) - 10000) * 100;
//    }
//    if (loc11 is core.settings.interfaces.IHomeAltitude2)
//    {
//        (loc11 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = ((arg1[3] << 8 | arg1[2]) - 10000) * 100;
//    }
//    if (loc11 is core.settings.interfaces.IETADistance)
//    {
//        (loc11 as core.settings.interfaces.IETADistance).etaDistance = arg1[6] << 16 | arg1[5] << 8 | arg1[4];
//    }
//    if (arg2 is core.settings.interfaces.IMyName)
//    {
//        loc3 = 7;
//        var loc10:*="";
//        while (loc3 <= 15)
//        {
//            if (arg1[loc3] == 0)
//            {
//                break;
//            }
//            loc10 = loc10 + com.hurlant.util.Hex.toString(arg1[loc3].toString(16));
//            ++loc3;
//        }
//        (arg2 as core.settings.interfaces.IMyName).myName = loc10;
//    }
//    if (loc11 is core.settings.interfaces.IBacklight)
//    {
//        (loc11 as core.settings.interfaces.IBacklight).backlightActive = (arg1[17] >> 7 & 1) != 1 ? false : true;
//    }
//    if (loc11 is core.settings.interfaces.IBacklightTimeOn)
//    {
//        loc2 = arg1[16] & 31;
//        loc5 = arg1[17] & 63;
//        loc7 = new Date(null, null, null, loc2, loc5);
//        (loc11 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn = loc7;
//    }
//    if (loc11 is core.settings.interfaces.IBacklightTimeOff)
//    {
//        loc8 = arg1[18] & 31;
//        loc6 = arg1[19] & 63;
//        loc1 = new Date(null, null, null, loc8, loc6);
//        (loc11 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff = loc1;
//    }
//    if (loc11 is core.settings.interfaces.ICadenceSensor)
//    {
//        (loc11 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive = (arg1[17] >> 6 & 1) != 1 ? false : true;
//    }
//    if (loc11 is core.settings.interfaces.IFuelConsumption)
//    {
//        (loc12 = new utils.converter.FuelConsumptionConverter()).inputFormat = (arg2 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
//        loc12.outputFormat = "l/100km";
//        (loc11 as core.settings.interfaces.IFuelConsumption).fuelConsumption = loc12.convert(((arg1[21] & 15) << 8 | arg1[20]) / 10);
//    }
//    if (loc11 is core.settings.interfaces.IPowerSaveMode)
//    {
//        (loc11 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive = (arg1[21] >> 4 & 1) != 1 ? false : true;
//    }
//    if (loc11 is core.settings.interfaces.IETAArivalFlag)
//    {
//        (loc11 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = (arg1[21] >> 5 & 1) != 1 ? false : true;
//    }
//    var loc4:*=0;
//    var loc9:*=0;
//    while (loc4 <= 21)
//    {
//        loc9 = loc9 + arg1[loc4];
//        ++loc4;
//    }
//    if ((loc9 = ++loc9 & 255) != arg1[22])
//    {
//        debug.Debug.warning("wrong checksum");
//    }
//    return loc11;
//}//        public function decodeSettingsNFC(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings//        {
//            var loc8:*=NaN;
//            var loc10:*;
//            (loc10 = core.settings.SettingsFactory.createSettingsFromUnitType(arg2.type) as core.settings.Settings).unit = arg2;
//            var loc2:*=(arg1[9] & 63) + 2000;
//            var loc7:*=arg1[10] & 15;
//            var loc11:*=arg1[11] & 31;
//            var loc1:*=arg1[0] & 31;
//            var loc3:*=arg1[3] >> 2 & 63;
//            var loc6:*=arg1[4] & 63;
//            if (loc10 as core.settings.interfaces.IClock)
//            {
//                (loc10 as core.settings.interfaces.IClock).clock = new Date();
//                (loc10 as core.settings.interfaces.IClock).clock.setHours(loc1, loc3, loc6);
//                (loc10 as core.settings.interfaces.IClock).clock.setFullYear(loc2, (loc7 - 1), loc11);
//            }
//            if (loc10 is core.settings.interfaces.IDate)
//            {
//                loc10.date = new Date(loc2, (loc7 - 1), loc11, loc1, loc3, loc6, 0);
//            }
//            var loc4:*="";
//        }
//
// public function decodeActivityNFC(arg1:Array, arg2:core.units.Unit):__AS3__.vec.Vector.<core.activities.Activity>
//        {
//            var loc3:*;
//            (loc3 = core.activities.ActivityFactory.createActivityFromUnitType(arg2.type, "memory")).unit = arg2;
//            loc3.serialNumber = arg2.serialNumber;
//            if (loc3.distanceDefined)
//            {
//                loc3.distance = arg1[2] << 16 | arg1[1] << 8 | arg1[0];
//            }
//            loc3.trainingTime = ((arg1[5] & 7) << 16 | arg1[4] << 8 | arg1[3]) * 100;
//            var loc5:*=(arg1[6] & 63) + 2000;
//            var loc4:*=arg1[14] >> 4;
//            var loc7:*=arg1[5] >> 3;
//            var loc6:*=arg1[21] >> 3;
//            var loc2:*=arg1[7] & 63;
//            var loc1:*=arg1[27] & 63;
//            loc3.startDate = new Date(loc5, (loc4 - 1), loc7, loc6, loc2, loc1);
//            if (loc3.averageSpeedDefined)
//            {
//                loc3.averageSpeed = (arg1[9] << 8 | arg1[8]) / 360;
//            }
//            if (loc3.maximumSpeedDefined)
//            {
//                loc3.maximumSpeed = (arg1[11] << 8 | arg1[10]) / 360;
//            }
//            loc3.bike = arg1[11] >> 7 != 0 ? "bike2" : "bike1";
//            if (loc3.fuelEconomyDefined)
//            {
//                loc3.fuelEconomy = ((arg1[14] & 15) << 16 | arg1[13] << 8 | arg1[12]) / 100;
//            }
//            if (loc3.averageCadenceDefined)
//            {
//                loc3.averageCadence = arg1[15];
//            }
//            if (loc3.altitudeDifferencesUphillDefined)
//            {
//                loc3.altitudeDifferencesUphill = ((arg1[18] & 15) << 16 | arg1[17] << 8 | arg1[16]) * 100;
//            }
//            if (loc3.tripSectionTimeDefined)
//            {
//                loc3.tripSectionTime = ((arg1[21] & 7) << 16 | arg1[20] << 8 | arg1[19]) * 100;
//            }
//            if (loc3.tripSectionDistanceDefined)
//            {
//                loc3.tripSectionDistance = arg1[24] << 16 | arg1[23] << 8 | arg1[22];
//            }
//            if (loc3.maximumAltitudeDefined)
//            {
//                loc3.maximumAltitude = ((arg1[26] << 8 | arg1[25]) - 10000) * 100;
//            }
//            loc3 = generateGUID(loc3);
//            new __AS3__.vec.Vector.<core.activities.Activity>(1)[0] = loc3;
//            return new __AS3__.vec.Vector.<core.activities.Activity>(1);
//        }
//
//        public function decodeTotalsNFC(arg1:Array, arg2:core.units.Unit):core.totals.Totals
//        {
//            var loc1:*=core.totals.TotalsFactory.createTotalsFromUnitType(arg2.type);
//            loc1.unit = arg2;
//            if (loc1 is core.totals.interfaces.ITotalDistance1)
//            {
//                (loc1 as core.totals.interfaces.ITotalDistance1).totalDistance1 = (arg1[3] & 15) << 24 | arg1[2] << 16 | arg1[1] << 8 | arg1[0];
//            }
//            if (loc1 is core.totals.interfaces.ITotalTrainingTime1)
//            {
//                (loc1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = ((arg1[9] & 3) << 24 | arg1[8] << 16 | arg1[7] << 8 | arg1[6]) * 100;
//            }
//            if (loc1 is core.totals.interfaces.ITotalDistance2)
//            {
//                (loc1 as core.totals.interfaces.ITotalDistance2).totalDistance2 = (arg1[13] & 15) << 24 | arg1[12] << 16 | arg1[11] << 8 | arg1[10];
//            }
//            if (loc1 is core.totals.interfaces.ITotalTrainingTime2)
//            {
//                (loc1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = ((arg1[19] & 3) << 24 | arg1[18] << 16 | arg1[17] << 8 | arg1[16]) * 100;
//            }
//            if (loc1 is core.totals.interfaces.ITotalCal1)
//            {
//                (loc1 as core.totals.interfaces.ITotalCal1).totalCal1 = (arg1[22] & 1) << 16 | arg1[21] << 8 | arg1[20];
//            }
//            if (loc1 is core.totals.interfaces.ITotalCal2)
//            {
//                (loc1 as core.totals.interfaces.ITotalCal2).totalCal2 = (arg1[25] & 1) << 16 | arg1[24] << 8 | arg1[23];
//            }
//            return loc1;
//        }
//
//          public function decodeTotalsAdvancedNFC(arg1:Array, arg2:core.totals.Totals):core.totals.Totals
//        {
//            var loc1:*=arg2;
//            if (loc1 is core.totals.interfaces.ITotalClimbMeter1)
//            {
//                (loc1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = ((arg1[2] & 15) << 16 | arg1[1] << 8 | arg1[0]) * 10;
//            }
//            if (loc1 is core.totals.interfaces.ITotalClimbMeter2)
//            {
//                (loc1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 = ((arg1[5] & 15) << 16 | arg1[4] << 8 | arg1[3]) * 10;
//            }
//            if (loc1 is core.totals.interfaces.ITotalDescent1)
//            {
//                (loc1 as core.totals.interfaces.ITotalDescent1).totalDescent1 = ((arg1[8] & 15) << 16 | arg1[7] << 8 | arg1[6]) * 10;
//            }
//            if (loc1 is core.totals.interfaces.ITotalDescent2)
//            {
//                (loc1 as core.totals.interfaces.ITotalDescent2).totalDescent2 = ((arg1[11] & 15) << 16 | arg1[10] << 8 | arg1[9]) * 10;
//            }
//            if (loc1 is core.totals.interfaces.ITotalTripDistUp1)
//            {
//                (loc1 as core.totals.interfaces.ITotalTripDistUp1).totalTripDistUp1 = (arg1[15] & 15) << 24 | arg1[14] << 16 | arg1[13] << 8 | arg1[12];
//            }
//            if (loc1 is core.totals.interfaces.ITotalTripDistUp2)
//            {
//                (loc1 as core.totals.interfaces.ITotalTripDistUp2).totalTripDistUp2 = (arg1[21] & 15) << 24 | arg1[20] << 16 | arg1[19] << 8 | arg1[18];
//            }
//            if (loc1 is core.totals.interfaces.ITotalTripDistDown1)
//            {
//                (loc1 as core.totals.interfaces.ITotalTripDistDown1).totalTripDistDown1 = (arg1[27] & 15) << 24 | arg1[26] << 16 | arg1[25] << 8 | arg1[24];
//            }
//            if (loc1 is core.totals.interfaces.ITotalTripDistDown2)
//            {
//                (loc1 as core.totals.interfaces.ITotalTripDistDown2).totalTripDistDown2 = (arg1[33] & 15) << 24 | arg1[32] << 16 | arg1[31] << 8 | arg1[30];
//            }
//            return loc1;
//        }
//
//
//            public function decodeInitialInformationNFC(arg1:Array, arg2:Array):core.units.Unit
//        {
//            var loc2:*=null;
//            if (arg2 == null || arg2.length == 0 || !calculateChecksumm(arg2))
//            {
//                return null;
//            }
//            var loc1:*=parseInt((arg2[0] as int).toString(16), 10);
//        }
//
//
//
//  public function decodeAdvancedSettingsNFC(arg1:Object, arg2:core.settings.Settings):core.settings.Settings
//        {
//            var loc3:*=0;
//            var loc2:*=0;
//            var loc5:*=0;
//            var loc7:*=null;
//            var loc8:*=0;
//            var loc6:*=0;
//            var loc1:*=null;
//            var loc12:*=null;
//            var loc11:*;
//            if ((loc11 = arg2) is core.settings.interfaces.IHomeAltitude1)
//            {
//                (loc11 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = ((arg1[1] << 8 | arg1[0]) - 10000) * 100;
//            }
//            if (loc11 is core.settings.interfaces.IHomeAltitude2)
//            {
//                (loc11 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = ((arg1[3] << 8 | arg1[2]) - 10000) * 100;
//            }
//            if (loc11 is core.settings.interfaces.IETADistance)
//            {
//                (loc11 as core.settings.interfaces.IETADistance).etaDistance = arg1[6] << 16 | arg1[5] << 8 | arg1[4];
//            }
//            if (arg2 is core.settings.interfaces.IMyName)
//            {
//                loc3 = 7;
//                var loc10:*="";
//                while (loc3 <= 15)
//                {
//                    if (arg1[loc3] == 0)
//                    {
//                        break;
//                    }
//                    loc10 = loc10 + com.hurlant.util.Hex.toString(arg1[loc3].toString(16));
//                    ++loc3;
//                }
//                (arg2 as core.settings.interfaces.IMyName).myName = loc10;
//            }
//            if (loc11 is core.settings.interfaces.IBacklight)
//            {
//                (loc11 as core.settings.interfaces.IBacklight).backlightActive = (arg1[17] >> 7 & 1) != 1 ? false : true;
//            }
//            if (loc11 is core.settings.interfaces.IBacklightTimeOn)
//            {
//                loc2 = arg1[16] & 31;
//                loc5 = arg1[17] & 63;
//                loc7 = new Date(null, null, null, loc2, loc5);
//                (loc11 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn = loc7;
//            }
//            if (loc11 is core.settings.interfaces.IBacklightTimeOff)
//            {
//                loc8 = arg1[18] & 31;
//                loc6 = arg1[19] & 63;
//                loc1 = new Date(null, null, null, loc8, loc6);
//                (loc11 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff = loc1;
//            }
//            if (loc11 is core.settings.interfaces.ICadenceSensor)
//            {
//                (loc11 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive = (arg1[17] >> 6 & 1) != 1 ? false : true;
//            }
//            if (loc11 is core.settings.interfaces.IFuelConsumption)
//            {
//                (loc12 = new utils.converter.FuelConsumptionConverter()).inputFormat = (arg2 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
//                loc12.outputFormat = "l/100km";
//                (loc11 as core.settings.interfaces.IFuelConsumption).fuelConsumption = loc12.convert(((arg1[21] & 15) << 8 | arg1[20]) / 10);
//            }
//            if (loc11 is core.settings.interfaces.IPowerSaveMode)
//            {
//                (loc11 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive = (arg1[21] >> 4 & 1) != 1 ? false : true;
//            }
//            if (loc11 is core.settings.interfaces.IETAArivalFlag)
//            {
//                (loc11 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = (arg1[21] >> 5 & 1) != 1 ? false : true;
//            }
//            var loc4:*=0;
//            var loc9:*=0;
//            while (loc4 <= 21)
//            {
//                loc9 = loc9 + arg1[loc4];
//                ++loc4;
//            }
//            if ((loc9 = ++loc9 & 255) != arg1[22])
//            {
//                debug.Debug.warning("wrong checksum");
//            }
//            return loc11;
//        }
end.
