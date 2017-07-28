//class Totals
package core.totals 
{
    import core.general.*;
    import core.general.interfaces.*;
    import core.settings.interfaces.*;
    import core.totals.interfaces.*;
    import core.units.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import handler.*;
    import utils.*;
    
    public class Totals extends flash.events.EventDispatcher implements core.settings.interfaces.IDate, core.general.interfaces.ISynchronisable
    {
        public function Totals(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            entity = new core.totals.TotalsEntity(this, arg1);
            return;
        }

        public function resetValues():void
        {
            date = DEFAULT_TOTAL_DATE;
            return;
        }

        public function get GUID():String
        {
            return _GUID;
        }

        public function set GUID(arg1:String):void
        {
            _GUID = arg1;
            return;
        }

        public function setCurrentPrimaryKeys(arg1:core.totals.Totals):void
        {
            totalsId = arg1.totalsId;
            return;
        }

        public function get date():Date
        {
            return _date;
        }

        public function set date(arg1:Date):void
        {
            if (_date !== arg1) 
            {
                _date = arg1;
                dispatchEvent(new flash.events.Event("dateChange"));
            }
            return;
        }

        public function setPrimaryKey(arg1:int):void
        {
            if (totalsId == 0) 
            {
                totalsId = arg1;
            }
            return;
        }

        public function get isDeleted():Boolean
        {
            return _isDeleted;
        }

        public function set isDeleted(arg1:Boolean):void
        {
            _isDeleted = arg1;
            return;
        }

        public override function toString():String
        {
            return "[Totals extends EventDispatcher implements IDate";
        }

        public function get modificationDate():Number
        {
            return _modificationDate;
        }

        public function set modificationDate(arg1:Number):void
        {
            _modificationDate = arg1;
            return;
        }

        public static function copy(arg1:core.totals.Totals):core.totals.Totals
        {
            var loc2:*=flash.utils.getQualifiedClassName(arg1);
            flash.net.registerClassAlias(loc2, flash.utils.getDefinitionByName(loc2) as Class);
            var loc1:*=arg1.unit;
            arg1.unit = null;
            var loc3:*=utils.BackendUtil.copy(arg1) as Totals;
            arg1.unit = loc1;
            loc3.unit = loc1;
            return loc3;
        }

        public function get totalsId():int
        {
            return _totalsId;
        }

        public function set totalsId(arg1:int):void
        {
            _totalsId = arg1;
            return;
        }

        public static function generateXML(arg1:core.totals.Totals):XML
        {
            var loc1:*=new XML("<Totals/>");
            loc1.date = arg1.date.toString();
            loc1.GUID = arg1.GUID;
            loc1.modificationDate = arg1.modificationDate;
            loc1.type = arg1.unitType.toString();
            loc1.unitGUID = arg1.unit.GUID;
            if (arg1 is core.totals.interfaces.ITotalCal1) 
            {
                loc1.totalCal1 = (arg1 as core.totals.interfaces.ITotalCal1).totalCal1;
            }
            if (arg1 is core.totals.interfaces.ITotalCal2) 
            {
                loc1.totalCal2 = (arg1 as core.totals.interfaces.ITotalCal2).totalCal2;
            }
            if (arg1 is core.totals.interfaces.ITotalCal3) 
            {
                loc1.totalCal3 = (arg1 as core.totals.interfaces.ITotalCal3).totalCal3;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                loc1.totalClimbMeter1 = (arg1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                loc1.totalClimbMeter2 = (arg1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter3) 
            {
                loc1.totalClimbMeter3 = (arg1 as core.totals.interfaces.ITotalClimbMeter3).totalClimbMeter3;
            }
            if (arg1 is core.totals.interfaces.ITotalDescent1) 
            {
                loc1.totalDescent1 = (arg1 as core.totals.interfaces.ITotalDescent1).totalDescent1;
            }
            if (arg1 is core.totals.interfaces.ITotalDescent2) 
            {
                loc1.totalDescent2 = (arg1 as core.totals.interfaces.ITotalDescent2).totalDescent2;
            }
            if (arg1 is core.totals.interfaces.ITotalDescent3) 
            {
                loc1.totalDescent3 = (arg1 as core.totals.interfaces.ITotalDescent3).totalDescent3;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance1) 
            {
                loc1.totalDistance1 = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance2) 
            {
                loc1.totalDistance2 = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance3) 
            {
                loc1.totalDistance3 = (arg1 as core.totals.interfaces.ITotalDistance3).totalDistance3;
            }
            if (arg1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                loc1.totalFuelConsumption = (arg1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1;
            }
            if (arg1 is core.totals.interfaces.ITotalHikingAltitude) 
            {
                loc1.totalHikingAltitude = (arg1 as core.totals.interfaces.ITotalHikingAltitude).totalHikingAltitude;
            }
            if (arg1 is core.totals.interfaces.ITotalHikingCalories) 
            {
                loc1.totalHikingCalories = (arg1 as core.totals.interfaces.ITotalHikingCalories).totalHikingCalories;
            }
            if (arg1 is core.totals.interfaces.ITotalHikingTime) 
            {
                loc1.totalHikingTime = (arg1 as core.totals.interfaces.ITotalHikingTime).totalHikingTime;
            }
            if (arg1 is core.totals.interfaces.IMaxAltitude1) 
            {
                loc1.maxAltitude1 = (arg1 as core.totals.interfaces.IMaxAltitude1).maxAltitude1;
            }
            if (arg1 is core.totals.interfaces.IMaxAltitude2) 
            {
                loc1.maxAltitude2 = (arg1 as core.totals.interfaces.IMaxAltitude2).maxAltitude2;
            }
            if (arg1 is core.totals.interfaces.IMaxAltitude3) 
            {
                loc1.maxAltitude3 = (arg1 as core.totals.interfaces.IMaxAltitude3).maxAltitude3;
            }
            if (arg1 is core.totals.interfaces.IResetDate) 
            {
                loc1.resetDate = (arg1 as core.totals.interfaces.IResetDate).resetDate.toString();
            }
            if (arg1 is core.totals.interfaces.ITotalTimeDown1) 
            {
                loc1.totalTimeDown1 = (arg1 as core.totals.interfaces.ITotalTimeDown1).totalTimeDown1;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeDown2) 
            {
                loc1.totalTimeDown2 = (arg1 as core.totals.interfaces.ITotalTimeDown2).totalTimeDown2;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeDown3) 
            {
                loc1.ITotalTimeDown3 = (arg1 as core.totals.interfaces.ITotalTimeDown3).totalTimeDown3;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeUp1) 
            {
                loc1.totalTimeUp1 = (arg1 as core.totals.interfaces.ITotalTimeUp1).totalTimeUp1;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeUp2) 
            {
                loc1.totalTimeUp2 = (arg1 as core.totals.interfaces.ITotalTimeUp2).totalTimeUp2;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeUp3) 
            {
                loc1.totalTimeUp3 = (arg1 as core.totals.interfaces.ITotalTimeUp3).totalTimeUp3;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainings) 
            {
                loc1.totalTrainings = (arg1 as core.totals.interfaces.ITotalTrainings).totalTrainings;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                loc1.totalTrainingTime1 = (arg1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                loc1.totalTrainingTime2 = (arg1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime3) 
            {
                loc1.totalTrainingTime3 = (arg1 as core.totals.interfaces.ITotalTrainingTime3).totalTrainingTime3;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown1) 
            {
                loc1.totalTripDistDown1 = (arg1 as core.totals.interfaces.ITotalTripDistDown1).totalTripDistDown1;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown2) 
            {
                loc1.totalTripDistDown2 = (arg1 as core.totals.interfaces.ITotalTripDistDown2).totalTripDistDown2;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown3) 
            {
                loc1.totalTripDistDown3 = (arg1 as core.totals.interfaces.ITotalTripDistDown3).totalTripDistDown3;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp1) 
            {
                loc1.totalTripDistUp1 = (arg1 as core.totals.interfaces.ITotalTripDistUp1).totalTripDistUp1;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp2) 
            {
                loc1.totalTripDistUp2 = (arg1 as core.totals.interfaces.ITotalTripDistUp2).totalTripDistUp2;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp3) 
            {
                loc1.totalTripDistUp3 = (arg1 as core.totals.interfaces.ITotalTripDistUp3).totalTripDistUp3;
            }
            return loc1;
        }

        public function get unit():core.units.Unit
        {
            return _unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            if (_unit !== arg1) 
            {
                _unit = arg1;
                dispatchEvent(new flash.events.Event("unitChange"));
            }
            return;
        }

        public static function fromXML(arg1:XML):core.totals.Totals
        {
            var loc1:*=core.totals.TotalsFactory.createTotalsFromUnitType(core.general.UnitType.fromString(arg1.type));
            loc1.date = new Date(arg1.date.text().toString());
            loc1.GUID = arg1.GUID;
            loc1.modificationDate = arg1.modificationDate;
            loc1.unitGUID = arg1.unitGUID;
            loc1.unit = handler.AppDeviceHandlerCommon.deviceDicGUID[loc1.unitGUID];
            if (loc1 is core.totals.interfaces.ITotalCal1) 
            {
                (loc1 as core.totals.interfaces.ITotalCal1).totalCal1 = arg1.totalCal1;
            }
            if (loc1 is core.totals.interfaces.ITotalCal2) 
            {
                (loc1 as core.totals.interfaces.ITotalCal2).totalCal2 = arg1.totalCal2;
            }
            if (loc1 is core.totals.interfaces.ITotalCal3) 
            {
                (loc1 as core.totals.interfaces.ITotalCal3).totalCal3 = arg1.totalCal3;
            }
            if (loc1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                (loc1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = arg1.totalClimbMeter1;
            }
            if (loc1 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                (loc1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 = arg1.totalClimbMeter2;
            }
            if (loc1 is core.totals.interfaces.ITotalClimbMeter3) 
            {
                (loc1 as core.totals.interfaces.ITotalClimbMeter3).totalClimbMeter3 = arg1.totalClimbMeter3;
            }
            if (loc1 is core.totals.interfaces.ITotalDescent1) 
            {
                (loc1 as core.totals.interfaces.ITotalDescent1).totalDescent1 = arg1.totalDescent1;
            }
            if (loc1 is core.totals.interfaces.ITotalDescent2) 
            {
                (loc1 as core.totals.interfaces.ITotalDescent2).totalDescent2 = arg1.totalDescent2;
            }
            if (loc1 is core.totals.interfaces.ITotalDescent3) 
            {
                (loc1 as core.totals.interfaces.ITotalDescent3).totalDescent3 = arg1.totalDescent3;
            }
            if (loc1 is core.totals.interfaces.ITotalDistance1) 
            {
                (loc1 as core.totals.interfaces.ITotalDistance1).totalDistance1 = arg1.totalDistance1;
            }
            if (loc1 is core.totals.interfaces.ITotalDistance2) 
            {
                (loc1 as core.totals.interfaces.ITotalDistance2).totalDistance2 = arg1.totalDistance2;
            }
            if (loc1 is core.totals.interfaces.ITotalDistance3) 
            {
                (loc1 as core.totals.interfaces.ITotalDistance3).totalDistance3 = arg1.totalDistance3;
            }
            if (loc1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                (loc1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1 = arg1.totalFuelConsumption;
            }
            if (loc1 is core.totals.interfaces.ITotalHikingAltitude) 
            {
                (loc1 as core.totals.interfaces.ITotalHikingAltitude).totalHikingAltitude = arg1.totalHikingAltitude;
            }
            if (loc1 is core.totals.interfaces.ITotalHikingCalories) 
            {
                (loc1 as core.totals.interfaces.ITotalHikingCalories).totalHikingCalories = arg1.totalHikingCalories;
            }
            if (loc1 is core.totals.interfaces.ITotalHikingTime) 
            {
                (loc1 as core.totals.interfaces.ITotalHikingTime).totalHikingTime = arg1.totalHikingTime;
            }
            if (loc1 is core.totals.interfaces.IMaxAltitude1) 
            {
                (loc1 as core.totals.interfaces.IMaxAltitude1).maxAltitude1 = arg1.maxAltitude1;
            }
            if (loc1 is core.totals.interfaces.IMaxAltitude2) 
            {
                (loc1 as core.totals.interfaces.IMaxAltitude2).maxAltitude2 = arg1.maxAltitude2;
            }
            if (loc1 is core.totals.interfaces.IMaxAltitude3) 
            {
                (loc1 as core.totals.interfaces.IMaxAltitude3).maxAltitude3 = arg1.maxAltitude3;
            }
            if (loc1 is core.totals.interfaces.IResetDate) 
            {
                (loc1 as core.totals.interfaces.IResetDate).resetDate = new Date();
                (loc1 as core.totals.interfaces.IResetDate).resetDate.setTime(Date.parse(arg1.resetDate));
            }
            if (loc1 is core.totals.interfaces.ITotalTimeDown1) 
            {
                (loc1 as core.totals.interfaces.ITotalTimeDown1).totalTimeDown1 = arg1.totalTimeDown1;
            }
            if (loc1 is core.totals.interfaces.ITotalTimeDown2) 
            {
                (loc1 as core.totals.interfaces.ITotalTimeDown2).totalTimeDown2 = arg1.totalTimeDown2;
            }
            if (loc1 is core.totals.interfaces.ITotalTimeDown3) 
            {
                (loc1 as core.totals.interfaces.ITotalTimeDown3).totalTimeDown3 = arg1.ITotalTimeDown3;
            }
            if (loc1 is core.totals.interfaces.ITotalTimeUp1) 
            {
                (loc1 as core.totals.interfaces.ITotalTimeUp1).totalTimeUp1 = arg1.totalTimeUp1;
            }
            if (loc1 is core.totals.interfaces.ITotalTimeUp2) 
            {
                (loc1 as core.totals.interfaces.ITotalTimeUp2).totalTimeUp2 = arg1.totalTimeUp2;
            }
            if (loc1 is core.totals.interfaces.ITotalTimeUp3) 
            {
                (loc1 as core.totals.interfaces.ITotalTimeUp3).totalTimeUp3 = arg1.totalTimeUp3;
            }
            if (loc1 is core.totals.interfaces.ITotalTrainings) 
            {
                (loc1 as core.totals.interfaces.ITotalTrainings).totalTrainings = arg1.totalTrainings;
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                (loc1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = arg1.totalTrainingTime1;
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                (loc1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = arg1.totalTrainingTime2;
            }
            if (loc1 is core.totals.interfaces.ITotalTrainingTime3) 
            {
                (loc1 as core.totals.interfaces.ITotalTrainingTime3).totalTrainingTime3 = arg1.totalTrainingTime3;
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistDown1) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistDown1).totalTripDistDown1 = arg1.totalTripDistDown1;
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistDown2) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistDown2).totalTripDistDown2 = arg1.totalTripDistDown2;
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistDown3) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistDown3).totalTripDistDown3 = arg1.totalTripDistDown3;
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistUp1) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistUp1).totalTripDistUp1 = arg1.totalTripDistUp1;
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistUp2) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistUp2).totalTripDistUp2 = arg1.totalTripDistUp2;
            }
            if (loc1 is core.totals.interfaces.ITotalTripDistUp3) 
            {
                (loc1 as core.totals.interfaces.ITotalTripDistUp3).totalTripDistUp3 = arg1.totalTripDistUp3;
            }
            return loc1;
        }

        public function get unitGUID():String
        {
            return _unitGUID;
        }

        public function set unitGUID(arg1:String):void
        {
            _unitGUID = arg1;
            return;
        }

        public function get unitType():core.general.UnitType
        {
            return _unitType;
        }

        public function set unitType(arg1:core.general.UnitType):void
        {
            if (arg1 != _unitType) 
            {
                _unitType = arg1;
                dispatchEvent(new flash.events.Event("unitTypeChange"));
            }
            return;
        }

        public function fromDB(arg1:Object):void
        {
            entity.fromDB(this, arg1);
            return;
        }

        public final function generateDBDelete():Array
        {
            return entity.generateDBDelete();
        }

        public final function generateDBInsert():Array
        {
            return entity.generateDBInsert();
        }

        public final function generateDBSelect():Array
        {
            return entity.generateDBSelect();
        }

        public function getLoggingInfo():String
        {
            return "\t-totalsId " + totalsId;
        }

        public function resetPrimaryKey():void
        {
            totalsId = 0;
            return;
        }

        public static const DEFAULT_TOTAL_DATE:Date=new Date();

        internal var _GUID:String="";

        internal var _date:Date;

        internal var _isDeleted:Boolean=false;

        internal var _modificationDate:Number=0;

        internal var _totalsId:int;

        internal var _unit:core.units.Unit;

        internal var _unitGUID:String="";

        internal var _unitType:core.general.UnitType;

        internal var entity:core.totals.TotalsEntity;
    }
}


