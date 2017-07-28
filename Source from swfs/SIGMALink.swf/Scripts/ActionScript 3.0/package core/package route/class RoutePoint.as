//class RoutePoint
package core.route 
{
    import core.route.interfaces.*;
    import database.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import route.json.geometry.*;
    import utils.*;
    import utils.format.*;
    
    public class RoutePoint extends flash.events.EventDispatcher implements core.route.interfaces.ILatLon, core.route.interfaces.IAltitude, core.route.interfaces.IUserPoint, core.route.interfaces.IRoutePointType
    {
        public function RoutePoint(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function fromXML(arg1:XML):void
        {
            latitude = arg1.latitude;
            longitude = arg1.longitude;
            altitude = arg1.altitude;
            userPoint = arg1.userPoint != 1 ? false : true;
            routingType = arg1.routingType;
            direction = arg1.direction;
            street = arg1.street;
            return;
        }

        public function get altitude():Number
        {
            return _altitude;
        }

        public function set altitude(arg1:Number):void
        {
            if (arg1 != _altitude) 
            {
                _altitude = arg1;
                dispatchEvent(new flash.events.Event("altitudeChange"));
            }
            return;
        }

        public function generateDBInsert():Array
        {
            var loc3:*="routePointId, routeId, latitude, longitude, altitude, userPoint, routingType, direction, street";
            var loc1:*=routePointId > 0 ? "\"" + routePointId + "\"," : "NULL,";
            loc1 = loc1 + ("\"" + (isNaN(routeId) ? 0 : routeId) + "\", \"" + (isNaN(latitude) ? 0 : latitude) + "\", \"" + (isNaN(longitude) ? 0 : longitude) + "\", \"" + (isNaN(altitude) ? 0 : altitude) + "\", " + (userPoint != false ? 1 : 0) + ", " + "\"" + routingType + "\", \"" + (isNaN(direction) ? 0 : direction) + "\", " + ":street");
            var loc2:*=new database.DCSQLStatement();
            loc2.text = "insert or replace into RoutePoint (" + loc3 + ") values (" + loc1 + ")";
            loc2.data = this;
            loc2.parameters[":street"] = street;
            return [loc2];
        }

        public function get direction():Number
        {
            return _direction;
        }

        public function set direction(arg1:Number):void
        {
            if (arg1 != _direction) 
            {
                _direction = arg1;
                dispatchEvent(new flash.events.Event("directionChange"));
            }
            return;
        }

        public function generateDBSelectPerRoute(arg1:int):Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "select routePointId as pk, * from RoutePoint where routeId = " + arg1.toString();
            return [loc1];
        }

        public function get latitude():Number
        {
            return _latitude;
        }

        public function set latitude(arg1:Number):void
        {
            if (arg1 != _latitude) 
            {
                _latitude = arg1;
                dispatchEvent(new flash.events.Event("latitudeChange"));
            }
            return;
        }

        public function selectMin(arg1:int):Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "SELECT * FROM RoutePoint WHERE routeId = " + arg1.toString() + "  AND longitude LIKE \"" + this.longitude.toFixed(2) + "%\" AND latitude LIKE \"" + this.latitude.toFixed(2) + "%\"  ORDER BY longitude DESC, latitude DESC LIMIT 1";
            return [loc1];
        }

        public function get longitude():Number
        {
            return _longitude;
        }

        public function set longitude(arg1:Number):void
        {
            if (arg1 != _longitude) 
            {
                _longitude = arg1;
                dispatchEvent(new flash.events.Event("longitudeChange"));
            }
            return;
        }

        public function generateDBSelect():Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "select routePointId as pk, * from RoutePoint where routeId = @fk";
            return [loc1];
        }

        public function generateDBDelete():Array
        {
            var loc3:*=[];
            var loc2:*=new database.DCSQLStatement();
            loc2.text = "delete from RoutePoint where RoutePoint.routePointId = " + routePointId;
            loc3.push(loc2);
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "delete from RoutePointInstruction where RoutePointInstruction.routePointId = " + routePointId;
            loc3.push(loc1);
            return loc3;
        }

        public function get routeId():int
        {
            return _routeId;
        }

        public function set routeId(arg1:int):void
        {
            _routeId = arg1;
            return;
        }

        public function generateDBDeleteByRouteId(arg1:int):Array
        {
            var loc2:*=[];
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "delete from RoutePoint where RoutePoint.routeId = " + arg1;
            loc2.push(loc1);
            return loc2;
        }

        public function get routePointId():int
        {
            return _routePointId;
        }

        public function set routePointId(arg1:int):void
        {
            _routePointId = arg1;
            return;
        }

        public function getLoggingInfo():String
        {
            return "\t-routeId " + routeId.toString() + "\t-latitude " + latitude.toString() + "\t-longitude " + longitude.toString() + "\t-altitude " + altitude.toString() + "\t-userPoint " + userPoint.toString() + "\t-routingType " + routingType.toString() + "\t-direction " + direction.toString() + "\t-street " + street;
        }

        public function get routePointType():String
        {
            return _routePointType;
        }

        public function set routePointType(arg1:String):void
        {
            if (_routePointType !== arg1) 
            {
                _routePointType = arg1;
                dispatchEvent(new flash.events.Event("routePointTypeChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[RoutePoint extends EventDispatcher implements ILatLon, IAltitude, IUserPoint]";
        }

        public function get routingType():String
        {
            if (_routingType == "") 
            {
                _routingType = "beeline";
            }
            return _routingType;
        }

        public function set routingType(arg1:String):void
        {
            if (arg1 != _routingType) 
            {
                _routingType = arg1;
                dispatchEvent(new flash.events.Event("routingTypeChange"));
            }
            return;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS RouteIdOnRoutePoint ON RoutePoint (routeId)";
            return loc1;
        }

        public function get street():String
        {
            return _street;
        }

        public function set street(arg1:String):void
        {
            if (arg1 != _street) 
            {
                _street = arg1;
                dispatchEvent(new flash.events.Event("streetChange"));
            }
            return;
        }

        public static function copy(arg1:core.route.RoutePoint):core.route.RoutePoint
        {
            var loc1:*=flash.utils.getQualifiedClassName(arg1);
            flash.net.registerClassAlias(loc1, flash.utils.getDefinitionByName(loc1) as Class);
            return utils.BackendUtil.copy(arg1) as RoutePoint;
        }

        public function get userPoint():Boolean
        {
            return _userPoint;
        }

        public function set userPoint(arg1:Boolean):void
        {
            if (arg1 != _userPoint) 
            {
                _userPoint = arg1;
                dispatchEvent(new flash.events.Event("userPointChange"));
            }
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("RoutePoint");
                DB_TABLE_400.addColumns([["routePointId", "INTEGER", false, true, true], ["routeId", "INTEGER", false], ["latitude", "NUMERIC", false], ["longitude", "NUMERIC", false], ["altitude", "NUMERIC", false], ["userPoint", "BOOL", false], ["routingType", "VARCHAR", false], ["direction", "NUMERIC", false], ["street", "VARCHAR", false], ["emptyField1", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public function get waypointIndex():int
        {
            return _waypointIndex;
        }

        public function set waypointIndex(arg1:int):void
        {
            if (_waypointIndex !== arg1) 
            {
                _waypointIndex = arg1;
                dispatchEvent(new flash.events.Event("waypointIndexChange"));
            }
            return;
        }

        public function setPrimaryKey(arg1:int):void
        {
            if (routePointId == 0) 
            {
                routePointId = arg1;
            }
            return;
        }

        public function asGjPoint():route.json.geometry.GjPoint
        {
            return new route.json.geometry.GjPoint(this.longitude, this.latitude, this.altitude);
        }

        public function equalsRoutePoint(arg1:core.route.interfaces.ILatLon):Boolean
        {
            if (arg1 == null) 
            {
                return false;
            }
            return this.latitude == arg1.latitude && this.longitude == arg1.longitude;
        }

        public function fromDB(arg1:Object):void
        {
            routePointId = arg1.routePointId;
            routeId = arg1.routeId;
            latitude = arg1.latitude;
            longitude = arg1.longitude;
            altitude = arg1.altitude;
            userPoint = arg1.userPoint != 1 ? false : true;
            routingType = arg1.routingType;
            direction = arg1.direction;
            street = arg1.street;
            return;
        }

        public function generateXML():XML
        {
            var loc1:*=new XML("<RoutePoint/>");
            loc1.latitude = latitude;
            loc1.longitude = longitude;
            loc1.altitude = altitude;
            loc1.userPoint = userPoint ? 1 : 0;
            loc1.routingType = routingType;
            loc1.direction = direction;
            loc1.street = utils.format.CDATAFormat.getCDataAsXMLNode("street", street);
            return loc1;
        }

        public static const col_altitude:String="altitude";

        public static const col_direction:String="direction";

        public static const col_latitude:String="latitude";

        public static const col_longitude:String="longitude";

        public static const col_routeId:String="routeId";

        public static const col_routePointId:String="routePointId";

        public static const col_routingType:String="routingType";

        public static const col_street:String="street";

        public static const col_userPoint:String="userPoint";

        public static const table_name:String="RoutePoint";

        protected var _altitude:Number=0;

        protected var _direction:Number=0;

        protected var _latitude:Number=0;

        protected var _longitude:Number=0;

        public var newRoutingType:String="";

        protected var _routeId:int;

        protected var _routePointId:int;

        protected var _routePointType:String="";

        protected var _routingType:String="";

        protected var _street:String="";

        protected var _userPoint:Boolean=false;

        internal var _waypointIndex:int=0;

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_400:database.DatabaseTable;
    }
}


