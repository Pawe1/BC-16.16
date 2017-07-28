//package gps
//  class DdMS
package core.gps 
{
    public class DdMS extends Object
    {
        public function DdMS()
        {
            super();
            return;
        }

        public static function decimalDegreesToDegreesMinutesSeconds(arg1:core.gps.LatLon):core.gps.DdMS
        {
            var loc1:*=new DdMS();
            loc1.latitude = arg1.latitude;
            loc1.longitude = arg1.longitude;
            loc1.latDegrees = arg1.latitude;
            loc1.latMinutes = (loc1.latitude - loc1.latDegrees) * 60;
            loc1.latSeconds = (loc1.latitude - loc1.latDegrees - loc1.latMinutes / 60) * 3600;
            loc1.lonDegrees = arg1.longitude;
            loc1.lonMinutes = (loc1.longitude - loc1.lonDegrees) * 60;
            loc1.lonSeconds = (loc1.longitude - loc1.lonDegrees - loc1.lonMinutes / 60) * 3600;
            return loc1;
        }

        public static function degreesMinutesSecondsToDecimalDegrees(arg1:core.gps.DdMS):core.gps.LatLon
        {
            var loc1:*=new core.gps.LatLon();
            loc1.latitude = arg1.latDegrees + arg1.latMinutes / 60 + arg1.latSeconds / 3600;
            loc1.longitude = arg1.lonDegrees + arg1.lonMinutes / 60 + arg1.lonSeconds / 3600;
            return loc1;
        }

        public var latDegrees:Number;

        public var latMinutes:Number;

        public var latSeconds:Number;

        public var latitude:Number;

        public var lonDegrees:Number;

        public var lonMinutes:Number;

        public var lonSeconds:Number;

        public var longitude:Number;

        internal var _point:core.gps.LatLon;
    }
}


//  class DdMmmmmm
package core.gps 
{
    public class DdMmmmmm extends Object
    {
        public function DdMmmmmm(arg1:uint=0, arg2:Number=0, arg3:uint=0)
        {
            super();
            degree = arg1;
            minutes = arg2;
            direction = arg3;
            return;
        }

        public function toLatLon():Number
        {
            var loc1:*=degree + minutes / 60;
        }

        public static function fromLatLon(arg1:Number, arg2:uint):core.gps.DdMmmmmm
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc2:*=NaN;
            var loc1:*=0;
            if (arg2 == 1 || arg2 == 2) 
            {
                loc4 = arg1;
                loc2 = (arg1 - loc4) * 1000000 * 0.6;
            }
            return loc3;
        }

        public static const DIRECTION_EAST:uint=1;

        public static const DIRECTION_NORTH:uint=0;

        public static const DIRECTION_SOUTH:uint=2;

        public static const DIRECTION_WEST:uint=3;

        public static const TYPE_LATITUDE:uint=2;

        public static const TYPE_LONGITUDE:uint=1;

        public var degree:uint;

        public var direction:uint;

        public var minutes:Number;
    }
}


//  class LatLon
package core.gps 
{
    import core.route.interfaces.*;
    
    public class LatLon extends Object implements core.route.interfaces.ILatLon
    {
        public function LatLon()
        {
            super();
            return;
        }

        public function get latitude():Number
        {
            return _latitude;
        }

        public function set latitude(arg1:Number):void
        {
            _latitude = arg1;
            return;
        }

        public function get longitude():Number
        {
            return _longitude;
        }

        public function set longitude(arg1:Number):void
        {
            _longitude = arg1;
            return;
        }

        public function equalsRoutePoint(arg1:core.route.interfaces.ILatLon):Boolean
        {
            if (arg1 == null) 
            {
                return false;
            }
            return this.latitude == arg1.latitude && this.longitude == arg1.longitude;
        }

        public function getLatDdMmmmmm():core.gps.DdMmmmmm
        {
            return core.gps.DdMmmmmm.fromLatLon(latitude, 2);
        }

        public function getLonDdMmmmmm():core.gps.DdMmmmmm
        {
            return core.gps.DdMmmmmm.fromLatLon(longitude, 1);
        }

        public function getDegreesToDegreesMinutesSeconds():core.gps.DdMS
        {
            return core.gps.DdMS.decimalDegreesToDegreesMinutesSeconds(this);
        }

        public function setDegreesFromDegreesMinutesSeconds(arg1:core.gps.DdMS):void
        {
            var loc1:*=core.gps.DdMS.degreesMinutesSecondsToDecimalDegrees(arg1);
            latitude = loc1.latitude;
            longitude = loc1.longitude;
            return;
        }

        internal var _latitude:Number;

        internal var _longitude:Number;
    }
}


//  class LatLonHelper
package core.gps 
{
    import avmplus.*;
    import core.route.interfaces.*;
    import flash.errors.*;
    
    public class LatLonHelper extends Object
    {
        public function LatLonHelper(arg1:core.route.interfaces.ILatLon, arg2:core.route.interfaces.ILatLon)
        {
            super();
            if (arg1 == null || arg2 == null) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Start- and End- Latitude and Longitude must not be empty :: " + avmplus.getQualifiedClassName(this));
            }
            _fromLatLong = arg1;
            _toLatLong = arg2;
            init();
            return;
        }

        internal function init():void
        {
            var loc4:*=_fromLatLong.latitude;
            var loc1:*=_toLatLong.latitude;
            var loc6:*=_fromLatLong.longitude;
            var loc8:*=_toLatLong.longitude;
            var loc2:*=angle2rad(90 - loc4);
            var loc3:*=angle2rad(90 - loc1);
            var loc11:*=angle2rad(Math.abs(loc8 - loc6));
            var loc5:*=Math.acos(Math.cos(loc2) * Math.cos(loc3) + Math.sin(loc2) * Math.sin(loc3) * Math.cos(loc11));
            var loc9:*=0;
            var loc12:*=0;
            loc9 = Math.acos((Math.cos(loc2) - Math.cos(loc3) * Math.cos(loc5)) / (Math.sin(loc5) * Math.sin(loc3)));
            loc12 = Math.acos((Math.cos(loc3) - Math.cos(loc5) * Math.cos(loc2)) / (Math.sin(loc5) * Math.sin(loc2)));
            var loc7:*=0 == loc12 ? 0 : 360 - rad2angle(loc12);
            var loc10:*=rad2angle(loc9);
            if (loc8 - loc6 > 0 || loc8 == loc6 && loc4 > loc1) 
            {
                loc7 = 360 - loc7;
                loc10 = 360 - loc10;
            }
            loc7 = Math.round(100 * loc7) / 100;
            loc10 = Math.round(100 * loc10) / 100;
            _startEntryBearing = loc7;
            return;
        }

        public function angle():Number
        {
            return _startEntryBearing;
        }

        internal function rad2angle(arg1:Number):Number
        {
            return 57.2957795131 * arg1;
        }

        internal function angle2rad(arg1:Number):Number
        {
            return 0.0174532925199 * arg1;
        }

        internal const EARTHPLATTUNG:Number=0.00335281066475;

        internal const M_PI:Number=3.14159265359;

        internal const NMFACTOR:Number=1.852216;

        internal const R_EARTH:Number=6371000.785;

        internal var _A:Number;

        internal var _a:Number;

        internal var _alpha:Number;

        internal var _b:Number;

        internal var _beta:Number;

        internal var _c:Number;

        internal var _e:Number;

        internal var _earthRadiusNm:Number=3439664.04836;

        internal var _fromLatLong:core.route.interfaces.ILatLon;

        internal var _gamma:Number;

        internal var _ka:Number;

        internal var _kb:Number;

        internal var _kc:Number;

        internal var _s:Number;

        internal var _ss:Number;

        internal var _startEntryBearing:uint=0;

        internal var _toLatLong:core.route.interfaces.ILatLon;
    }
}


//  class PointNavigation
package core.gps 
{
    import core.general.*;
    import core.general.interfaces.*;
    
    public class PointNavigation extends core.gps.LatLon implements core.general.interfaces.ISynchronisable
    {
        public function PointNavigation()
        {
            super();
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

        public function get isDeleted():Boolean
        {
            return _isDeleted;
        }

        public function set isDeleted(arg1:Boolean):void
        {
            _isDeleted = arg1;
            return;
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

        internal var _GUID:String="";

        internal var _isDeleted:Boolean=false;

        internal var _modificationDate:Number=0;

        public var pointNavigationId:int;

        public var selected:Boolean=false;

        public var text1:String="";

        public var text2:String="";

        public var unitGUID:String="";

        public var unitType:core.general.UnitType;
    }
}


//  class PointNavigationMapper
package core.gps 
{
    import core.general.*;
    import database.*;
    import utils.*;
    
    public class PointNavigationMapper extends Object
    {
        public function PointNavigationMapper()
        {
            super();
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS UnitGUIDonPointNavigation ON PointNavigation (unitGUID)";
            return loc1;
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.gps.PointNavigation):String
        {
            return "SELECT pointNavigationId FROM PointNavigation WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO PointNavigation (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectPointNavigation(arg1:String, arg2:String="text1", arg3:Boolean=false):String
        {
            return "SELECT * FROM PointNavigation where unitGUID = \'" + arg1 + "\' and isDeleted = false ORDER BY " + arg2 + (arg3 ? " ASC" : " DESC");
        }

        public static function generateXML(arg1:core.gps.PointNavigation):XML
        {
            var loc1:*=new XML("<PointNavigation/>");
            loc1.GUID = arg1.GUID;
            loc1.unitGUID = arg1.unitGUID;
            loc1.unitType = arg1.unitType.toString();
            loc1.modificationDate = arg1.modificationDate;
            loc1.latitude = arg1.latitude;
            loc1.longitude = arg1.longitude;
            loc1.text1 = arg1.text1;
            loc1.text2 = arg1.text2;
            return loc1;
        }

        public static function fromXML(arg1:XML):core.gps.PointNavigation
        {
            arg1.normalize();
            var loc1:*=arg1.name();
            if (loc1.localName != "PointNavigation") 
            {
                return null;
            }
            var loc2:*=new core.gps.PointNavigation();
            loc2.GUID = arg1.GUID;
            loc2.unitGUID = arg1.unitGUID;
            loc2.unitType = core.general.UnitType.fromString(arg1.unitType);
            loc2.modificationDate = arg1.modificationDate;
            loc2.latitude = arg1.latitude;
            loc2.longitude = arg1.longitude;
            loc2.text1 = arg1.text1;
            loc2.text2 = arg1.text2;
            return loc2;
        }

        public static function generateDBInsert(arg1:core.gps.PointNavigation, arg2:Array, arg3:Object):void
        {
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            var loc1:*=0;
            arg2.push("GUID");
            ++loc1;
            arg3[loc1] = arg1.GUID;
            arg2.push("unitGUID");
            ++loc1;
            arg3[loc1] = arg1.unitGUID;
            arg2.push("unitType");
            ++loc1;
            arg3[loc1] = arg1.unitType.toString();
            arg2.push("modificationDate");
            ++loc1;
            arg3[loc1] = arg1.modificationDate;
            arg2.push("isDeleted");
            ++loc1;
            arg3[loc1] = arg1.isDeleted;
            arg2.push("latitude");
            ++loc1;
            arg3[loc1] = arg1.latitude;
            arg2.push("longitude");
            ++loc1;
            arg3[loc1] = arg1.longitude;
            arg2.push("text1");
            ++loc1;
            arg3[loc1] = arg1.text1;
            arg2.push("text2");
            ++loc1;
            arg3[loc1] = arg1.text2;
            return;
        }

        public static function fromDB(arg1:Object):core.gps.PointNavigation
        {
            var loc1:*=new core.gps.PointNavigation();
            loc1.pointNavigationId = arg1["pointNavigationId"];
            loc1.GUID = arg1["GUID"];
            loc1.unitGUID = arg1["unitGUID"];
            loc1.unitType = core.general.UnitType.fromString(arg1["unitType"]);
            loc1.modificationDate = arg1["modificationDate"];
            loc1.isDeleted = arg1["isDeleted"];
            loc1.latitude = arg1["latitude"];
            loc1.longitude = arg1["longitude"];
            loc1.text1 = arg1["text1"];
            loc1.text2 = arg1["text2"];
            return loc1;
        }

        public static function generateDBDelete(arg1:core.gps.PointNavigation):String
        {
            return "delete from PointNavigation where PointNavigation.GUID = " + arg1.GUID;
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE PointNavigation SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public static const col_GUID:String="GUID";

        public static const col_isDeleted:String="isDeleted";

        public static const col_latitude:String="latitude";

        public static const col_longitude:String="longitude";

        public static const col_modificationDate:String="modificationDate";

        public static const col_pointNavigationId:String="pointNavigationId";

        public static const col_text1:String="text1";

        public static const col_text2:String="text2";

        public static const col_unitGUID:String="unitGUID";

        public static const col_unitType:String="unitType";

        public static const index_name:String="UnitGUIDonPointNavigation";

        public static const table_name:String="PointNavigation";

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


