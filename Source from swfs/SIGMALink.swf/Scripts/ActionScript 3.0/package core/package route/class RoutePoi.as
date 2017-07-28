//class RoutePoi
package core.route 
{
    import core.route.interfaces.*;
    import database.*;
    import flash.events.*;
    import utils.format.*;
    
    public class RoutePoi extends flash.events.EventDispatcher implements core.route.interfaces.ILatLon
    {
        public function RoutePoi(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function fromDB(arg1:Object):void
        {
            routePoisId = arg1.routePoisId;
            routeId = arg1.routeId;
            latitude = arg1.latitude;
            longitude = arg1.longitude;
            altitude = arg1.altitude;
            name = arg1.name;
            description = arg1.description;
            type = arg1.type;
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

        public function generateXML():XML
        {
            var loc1:*=new XML("<POI/>");
            loc1.latitude = latitude;
            loc1.longitude = longitude;
            loc1.altitude = altitude;
            loc1.name = utils.format.CDATAFormat.getCDataAsXMLNode("name", name);
            loc1.description = utils.format.CDATAFormat.getCDataAsXMLNode("description", description);
            loc1.type = type;
            return loc1;
        }

        public function get description():String
        {
            return _description;
        }

        public function set description(arg1:String):void
        {
            if (arg1 != _description) 
            {
                _description = arg1;
                dispatchEvent(new flash.events.Event("descriptionChange"));
            }
            return;
        }

        public function get name():String
        {
            return _name;
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

        public function fromXML(arg1:XML):void
        {
            latitude = arg1.latitude;
            longitude = arg1.longitude;
            altitude = arg1.altitude;
            name = arg1.name;
            description = arg1.description;
            type = arg1.type;
            return;
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

        public function generateDBInsert():Array
        {
            if (isNaN(latitude)) 
            {
                latitude = 0;
            }
            if (isNaN(longitude)) 
            {
                longitude = 0;
            }
            if (isNaN(altitude)) 
            {
                altitude = 0;
            }
            var loc1:*=[];
            var loc2:*=new database.DCSQLStatement();
            if (routePoisId > 0) 
            {
                loc1.push("routePoisId");
                loc2.parameters[":routePoisId"] = routePoisId;
            }
            loc1.push("routeId");
            loc2.parameters[":routeId"] = routeId;
            loc1.push("latitude");
            loc2.parameters[":latitude"] = latitude;
            loc1.push("longitude");
            loc2.parameters[":longitude"] = longitude;
            loc1.push("altitude");
            loc2.parameters[":altitude"] = altitude;
            loc1.push("name");
            loc2.parameters[":name"] = name;
            loc1.push("description");
            loc2.parameters[":description"] = description;
            loc1.push("type");
            loc2.parameters[":type"] = type;
            loc2.text = "insert or replace into RoutePois (" + loc1.join(",") + ") values (:" + loc1.join(", :") + ")";
            loc2.data = this;
            return [loc2];
        }

        public function generateDBSelect():Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "select routePoisId as pk, * from RoutePois where routeId = @fk";
            return [loc1];
        }

        public function set name(arg1:String):void
        {
            if (arg1 != _name) 
            {
                _name = arg1;
                dispatchEvent(new flash.events.Event("nameChange"));
            }
            return;
        }

        public function generateDBSelectPerRoute(arg1:int):Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "select routePoisId as pk, * from RoutePois where routeId = " + arg1.toString();
            return [loc1];
        }

        public function generateDBDelete():Array
        {
            var loc2:*=[];
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "delete from RoutePois where RoutePois.routePoisId = " + routePoisId;
            loc2.push(loc1);
            return loc2;
        }

        public function getLoggingInfo():String
        {
            return "\t-routeId " + routeId.toString() + "\t-latitude " + latitude.toString() + "\t-longitude " + longitude.toString() + "\t-altitude " + altitude.toString() + "\t-name " + name.toString() + "\t-description " + description.toString() + "\t-type " + type.toString();
        }

        public override function toString():String
        {
            return "[RoutePois extends EventDispatcher implements ILatLon, IAltitude]";
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

        public static function copy(arg1:core.route.RoutePoi):core.route.RoutePoi
        {
            var loc1:*=new RoutePoi();
            loc1.altitude = arg1.altitude;
            loc1.description = arg1.description;
            loc1.latitude = arg1.latitude;
            loc1.longitude = arg1.longitude;
            loc1.name = arg1.name;
            loc1.poiFeature = arg1.poiFeature;
            loc1.poiLineFeature = arg1.poiLineFeature;
            loc1.referencePoint = arg1.referencePoint;
            loc1.routeId = arg1.routeId;
            loc1.routePointReferenceId = arg1.routePointReferenceId;
            loc1.routePoisId = arg1.routePoisId;
            loc1.type = arg1.type;
            loc1.waypointNumber = arg1.waypointNumber;
            loc1.waypointPointNumber = arg1.waypointPointNumber;
            loc1.wayTTPId_curId = arg1.wayTTPId_curId;
            return loc1;
        }

        public function get routePointReferenceId():int
        {
            return _routePointReferenceId;
        }

        public function set routePointReferenceId(arg1:int):void
        {
            _routePointReferenceId = arg1;
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("RoutePois");
                DB_TABLE_400.addColumns([["routePoisId", "INTEGER", false, true, true], ["routeId", "INTEGER", false], ["latitude", "NUMERIC", false], ["longitude", "NUMERIC", false], ["altitude", "NUMERIC", false], ["name", "VARCHAR", false], ["description", "VARCHAR", false], ["type", "VARCHAR", false], ["emptyField1", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public function get routePoisId():int
        {
            return _routePoisId;
        }

        public function set routePoisId(arg1:int):void
        {
            _routePoisId = arg1;
            return;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS RouteIdOnRoutePois ON RoutePois (routeId)";
            return loc1;
        }

        public function get type():String
        {
            return _type;
        }

        public function set type(arg1:String):void
        {
            if (arg1 != _type) 
            {
                _type = arg1;
                dispatchEvent(new flash.events.Event("typeChange"));
            }
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

        public function setPrimaryKey(arg1:int):void
        {
            if (routePoisId == 0) 
            {
                routePoisId = arg1;
            }
            return;
        }

        public static const col_altitude:String="altitude";

        public static const col_description:String="description";

        public static const col_latitude:String="latitude";

        public static const col_longitude:String="longitude";

        public static const col_name:String="name";

        public static const col_routeId:String="routeId";

        public static const col_routePoisId:String="routePoisId";

        public static const col_type:String="type";

        public static const table_name:String="RoutePois";

        protected var _altitude:Number=0;

        protected var _description:String="";

        protected var _longitude:Number=0;

        protected var _name:String="";

        protected var _latitude:Number=0;

        public var poiFeature:*;

        public var poiLineFeature:*;

        public var referencePoint:core.route.RoutePoint;

        protected var _routeId:int;

        protected var _routePointReferenceId:int;

        protected var _routePoisId:int;

        protected var _type:String="";

        public static var DB_TABLE_400:database.DatabaseTable;

        public var waypointPointNumber:int=0;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        public var wayTTPId_curId:int=0;

        public var waypointNumber:int=0;

        public static var DB_TABLE_500:database.DatabaseTable;
    }
}


