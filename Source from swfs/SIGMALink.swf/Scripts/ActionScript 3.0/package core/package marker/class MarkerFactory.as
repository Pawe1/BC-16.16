//class MarkerFactory
package core.marker 
{
    import core.activities.*;
    import core.general.*;
    
    public class MarkerFactory extends Object
    {
        public function MarkerFactory()
        {
            super();
            return;
        }

        public static function createMarker():core.marker.Marker
        {
            return new core.marker.Marker(INSTANCE_CHECK_OBJECT);
        }

        public static function createMarkerFromDB(arg1:Object, arg2:core.activities.Activity):core.marker.Marker
        {
            var loc1:*=new core.marker.Marker(INSTANCE_CHECK_OBJECT);
            loc1.logReference = arg2;
            core.marker.MarkerMapper.fromDB(arg1, loc1);
            if (!(arg2.unitType == null) && core.general.UnitType.RC1411.toString() == arg2.unitType.toString()) 
            {
                loc1.calculateMarkerCalories = false;
            }
            return loc1;
        }

        public static function createMarkerFromLog(arg1:core.activities.Activity, arg2:String=""):core.marker.Marker
        {
            var loc1:*=new core.marker.Marker(INSTANCE_CHECK_OBJECT);
            if (!(arg1 == null) && !(arg1.unitType == null) && core.general.UnitType.RC1411.toString() == arg1.unitType.toString()) 
            {
                loc1.calculateMarkerCalories = false;
            }
            loc1.logReference = arg1;
            configMarkerDefinitions(loc1, arg1.unitType, arg1.logType, arg2);
            return loc1;
        }

        public static function isFactoryInstance(arg1:Object):Boolean
        {
            return INSTANCE_CHECK_OBJECT == arg1;
        }

        internal static function configMarkerDefinitions(arg1:core.marker.Marker, arg2:core.general.UnitType, arg3:core.general.LogType=null, arg4:String=""):void
        {
            var loc1:*=null;
            var loc2:*=arg2;
            while (core.general.UnitType.RC1411.toString() === loc2) 
            {
                arg1.calculateMarkerCalories = false;
                arg1.minimumHeartrateDefined = true;
                arg1.maximumHeartrateDefined = true;
                arg1.averageHeartrateDefined = true;
                arg1.caloriesDefined = true;
                arg1.tXSensorPositionDefined = true;
                if ("p".toString() == arg4 && true) 
                {
                };
                arg1.minimumSpeedDefined = true;
                arg1.maximumSpeedDefined = true;
                arg1.averageSpeedDefined = true;
                arg1.fastLapDefined = true;
                arg1.distanceDefined = true;
                arg1.distanceAbsoluteDefined = true;
            }
        }

        public static const LIMITED_PAUSE_MARKER_CONTENT:Boolean=true;

        internal static const INSTANCE_CHECK_OBJECT:Object={};
    }
}


