//class Route
package core.route 
{
    import __AS3__.vec.*;
    import core.general.interfaces.*;
    import core.route.interfaces.*;
    import database.*;
    import flash.events.*;
    import mx.events.*;
    import utils.*;
    import utils.format.*;
    import utils.validator.*;
    
    public class Route extends flash.events.EventDispatcher implements core.route.interfaces.ILatLonStart, core.route.interfaces.ILatLonEnd, core.route.interfaces.IGeneralRouteInformation, core.route.interfaces.IDownloadFrom, core.route.interfaces.IGhostRace, core.route.interfaces.IDistance, core.route.interfaces.IAltitudeDifferencesUphill, core.route.interfaces.IAltitudeDifferencesDownhill, core.general.interfaces.ISynchronisable
    {
        public function Route(arg1:flash.events.IEventDispatcher=null)
        {
            _creationTimestamp = new Date();
            _ghostData = [];
            maximumAltitude = NaN;
            minimumAltitude = NaN;
            ownTrack = true;
            pois = new __AS3__.vec.Vector.<core.route.RoutePoi>();
            routeOptions = new __AS3__.vec.Vector.<core.route.RouteOptions>();
            routePoints = new __AS3__.vec.Vector.<core.route.RoutePoint>();
            routePointsLoaded = [];
            routePointsReduced = new __AS3__.vec.Vector.<core.route.RoutePoint>();
            routePointsToSend = [];
            routePoisToSend = new __AS3__.vec.Vector.<core.route.RoutePoi>();
            waypointsLoaded = [];
            super(arg1);
            return;
        }

        public function setPrimaryKey(arg1:int):void
        {
            if (routeId == 0) 
            {
                routeId = arg1;
            }
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

        public function startTrack():Boolean
        {
            return routePoints.length == 0;
        }

        public function get altitudeDifferencesDownhill():int
        {
            return _altitudeDifferencesDownhill;
        }

        public function set altitudeDifferencesDownhill(arg1:int):void
        {
            if (arg1 != _altitudeDifferencesDownhill) 
            {
                _altitudeDifferencesDownhill = arg1;
                dispatchEvent(new flash.events.Event("altitudeDifferencesDownhillChange"));
            }
            return;
        }

        public function getStartPoint():core.route.RoutePoint
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < routePoints.length) 
            {
                if (routePoints[loc1].userPoint) 
                {
                    return routePoints[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public function get altitudeDifferencesUphill():int
        {
            return _altitudeDifferencesUphill;
        }

        public function set altitudeDifferencesUphill(arg1:int):void
        {
            if (arg1 != _altitudeDifferencesUphill) 
            {
                _altitudeDifferencesUphill = arg1;
                dispatchEvent(new flash.events.Event("altitudeDifferencesUphillChange"));
            }
            return;
        }

        public function fromDB(arg1:Object):void
        {
            loadedFrom = "loadedFromDataBase";
            routeId = arg1.routeId;
            GUID = arg1.GUID;
            modificationDate = arg1.modificationDate;
            latitudeStart = arg1.latitudeStart;
            longitudeStart = arg1.longitudeStart;
            latitudeEnd = arg1.latitudeEnd;
            longitudeEnd = arg1.longitudeEnd;
            name = utils.validator.TextInputRestrictions.getValidSingleLineText(arg1.name);
            description = arg1.description;
            distance = arg1.distance;
            altitudeDifferencesUphill = arg1.altitudeDifferencesUphill;
            altitudeDifferencesDownhill = arg1.altitudeDifferencesDownhill;
            rating = arg1.rating;
            autor = arg1.autor;
            webPortalId = arg1.webPortalId;
            downloadId = "0";
            if (arg1["ghostData"] != null) 
            {
                ghostData = arg1.ghostData.toString().split(",");
            }
            isCircuit = arg1.isCircuit != 0 ? true : false;
            modifiedSinceUploadToDevice = arg1.modifiedSinceUploadToDevice != 0 ? true : false;
            creationTimestamp = new Date(arg1.creationTimestamp);
            timestamp = arg1.timestamp;
            isDeleted = arg1.isDeleted != 0 ? true : false;
            return;
        }

        public function get autor():String
        {
            return _autor;
        }

        public function set autor(arg1:String):void
        {
            if (arg1 != _autor) 
            {
                _autor = arg1;
                dispatchEvent(new flash.events.Event("autorChange"));
            }
            return;
        }

        public function generateDBInsert():database.DCSQLStatement
        {
            var loc2:*=ghostData.join(",");
            var loc4:*="routeId, GUID, modificationDate, latitudeStart, longitudeStart, latitudeEnd, longitudeEnd, name, description, distance, altitudeDifferencesUphill, altitudeDifferencesDownhill, rating, autor, webPortalId, downloadId, ghostData,isCircuit,modifiedSinceUploadToDevice,creationTimestamp,isDeleted";
            var loc1:*=routeId > 0 ? "\"" + routeId + "\"," : "NULL,";
            loc1 = loc1 + ("\"" + GUID + "\", \"" + modificationDate + "\", \"" + (isNaN(latitudeStart) ? 0 : latitudeStart) + "\", \"" + (isNaN(longitudeStart) ? 0 : longitudeStart) + "\", \"" + (isNaN(latitudeEnd) ? 0 : latitudeEnd) + "\", \"" + (isNaN(longitudeEnd) ? 0 : longitudeEnd) + "\", " + ":name, " + ":description, " + "\"" + (isNaN(distance) ? 0 : distance) + "\", \"" + (isNaN(altitudeDifferencesUphill) ? 0 : altitudeDifferencesUphill) + "\", \"" + (isNaN(altitudeDifferencesDownhill) ? 0 : altitudeDifferencesDownhill) + "\", \"" + (isNaN(rating) ? 0 : rating) + "\", \"" + autor.toString() + "\", \"" + webPortalId.toString() + "\", \"" + downloadId.toString() + "\", \"" + loc2.toString() + "\", " + (isCircuit != false ? 1 : 0) + ", " + (modifiedSinceUploadToDevice != false ? 1 : 0) + ", \"" + creationTimestamp.toString() + "\", " + (isDeleted != false ? 1 : 0));
            var loc3:*=new database.DCSQLStatement();
            loc3.data = this;
            loc3.text = "insert or replace into Route (" + loc4 + ") values (" + loc1 + ")";
            loc3.parameters[":name"] = name;
            loc3.parameters[":description"] = description;
            return loc3;
        }

        public function generateXML():XML
        {
            var loc1:*=new XML("<Route/>");
            loc1.GUID = GUID;
            loc1.latitudeStart = latitudeStart;
            loc1.longitudeStart = longitudeStart;
            loc1.latitudeEnd = latitudeEnd;
            loc1.longitudeEnd = longitudeEnd;
            loc1.name = utils.format.CDATAFormat.getCDataAsXMLNode("name", name);
            loc1.description = utils.format.CDATAFormat.getCDataAsXMLNode("description", description);
            loc1.distance = distance;
            loc1.altitudeDifferencesUphill = altitudeDifferencesUphill;
            loc1.altitudeDifferencesDownhill = altitudeDifferencesDownhill;
            loc1.rating = rating;
            loc1.autor = utils.format.CDATAFormat.getCDataAsXMLNode("autor", autor);
            loc1.webPortalId = webPortalId;
            loc1.downloadId = downloadId;
            loc1.ghostData = ghostData.toString().split(",");
            loc1.isCircuit = isCircuit ? 1 : 0;
            loc1.creationTimestamp = creationTimestamp.toString();
            loc1.timestamp = timestamp;
            generateRouteOptionsXML(loc1);
            loc1.appendChild(generateRoutePointsXML());
            loc1.appendChild(generatePOIXML());
            return loc1;
        }

        public function get creationTimestamp():Date
        {
            return _creationTimestamp;
        }

        public function set creationTimestamp(arg1:Date):void
        {
            if (arg1 != _creationTimestamp) 
            {
                _creationTimestamp = arg1;
                dispatchEvent(new flash.events.Event("creationTimestampChange"));
            }
            return;
        }

        public function fromXML(arg1:XML):void
        {
            arg1.normalize();
            loadedFrom = "loadedFromDataBase";
            GUID = arg1.GUID;
            modificationDate = new Date().time;
            latitudeStart = arg1.latitudeStart;
            longitudeStart = arg1.longitudeStart;
            latitudeEnd = arg1.latitudeEnd;
            longitudeEnd = arg1.longitudeEnd;
            name = arg1.name;
            description = arg1.description;
            distance = arg1.distance;
            altitudeDifferencesUphill = arg1.altitudeDifferencesUphill;
            altitudeDifferencesDownhill = arg1.altitudeDifferencesDownhill;
            rating = arg1.rating;
            autor = arg1.autor;
            webPortalId = arg1.webPortalId;
            downloadId = arg1.downloadId;
            var loc1:*=arg1.ghostData;
            if (loc1.length > 0) 
            {
                ghostData = loc1.split(",");
            }
            isCircuit = isCircuit != 1 ? false : true;
            creationTimestamp = new Date(arg1.creationTimestamp.text().toString());
            timestamp = timestamp;
            routeOptions = routeOptionsFromXML(arg1);
            routePoints = routePointsFromXML(arg1);
            pois = routePOIsFromXML(arg1);
            return;
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

        public function get webPortalId():String
        {
            return _webPortalId;
        }

        public function get distance():Number
        {
            return _distance;
        }

        public function set distance(arg1:Number):void
        {
            if (arg1 != _distance) 
            {
                _distance = arg1;
                dispatchEvent(new flash.events.Event("distanceChange"));
            }
            return;
        }

        public function generateDBUpdateDescription(arg1:String, arg2:int):Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "UPDATE Route set description =\"" + arg1 + "\"" + " WHERE routeId = " + arg2.toString();
            return [loc1];
        }

        public function generateDBUpdateIsCircuit():Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "UPDATE Route set isCircuit = " + (this.isCircuit != true ? 0 : 1) + " WHERE routeId = " + this.routeId.toString();
            return [loc1];
        }

        public function generateDBSelect():Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "select routeId as pk, * from Route";
            return [loc1];
        }

        public function get downloadId():String
        {
            return _downloadId;
        }

        public function set downloadId(arg1:String):void
        {
            if (arg1 != _downloadId) 
            {
                _downloadId = arg1;
                dispatchEvent(new flash.events.Event("downloadIdChange"));
            }
            return;
        }

        public function generateDBSelectDescription(arg1:int):Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "SELECT description from Route WHERE routeId = " + arg1;
            return [loc1];
        }

        public function get ghostData():Array
        {
            return _ghostData;
        }

        public function set ghostData(arg1:Array):void
        {
            if (arg1 != _ghostData) 
            {
                _ghostData = arg1;
                dispatchEvent(new flash.events.Event("ghostDataChange"));
            }
            return;
        }

        public function generateDBDelete():Array
        {
            var loc2:*=[];
            var loc1:*=new database.DCSQLStatement();
            loc1.text = generateDBDeleteStatement();
            loc2.push(loc1);
            return loc2;
        }

        public function get ghostName():String
        {
            return _ghostName;
        }

        public function set ghostName(arg1:String):void
        {
            if (arg1 != _ghostName) 
            {
                _ghostName = arg1;
                dispatchEvent(new flash.events.Event("ghostNameChange"));
            }
            return;
        }

        public function generateDBDeleteStatement():String
        {
            return "delete from Route where GUID = \'" + GUID + "\'";
        }

        public function get isCircuit():Boolean
        {
            return _isCircuit;
        }

        public function set isCircuit(arg1:Boolean):void
        {
            _isCircuit = arg1;
            return;
        }

        public function getLoggingInfo():String
        {
            return "\t-routeId " + routeId.toString() + "\t-latitudeStart " + latitudeStart.toString() + "\t-longitudeStart " + longitudeStart.toString() + "\t-latitudeEnd " + latitudeEnd.toString() + "\t-longitudeEnd " + longitudeEnd.toString();
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
            return "[Route extends EventDispatcher implements IDatabase, ILatLonStart, ILatLonEnd, IGeneralRouteInformation, IDownloadFrom, IGhostRace, IDistance, IAltitudeDifferencesUphill, IAltitudeDifferencesDownhill]";
        }

        public function get latitudeEnd():Number
        {
            return _latitudeEnd;
        }

        public function set latitudeEnd(arg1:Number):void
        {
            if (arg1 != _latitudeEnd) 
            {
                _latitudeEnd = arg1;
                dispatchEvent(new flash.events.Event("latitudeEndChange"));
            }
            return;
        }

        public function selectPrimaryKeyFromGUID():String
        {
            return "SELECT routeId FROM Route WHERE GUID = \'" + GUID + "\'";
        }

        public function get latitudeStart():Number
        {
            return _latitudeStart;
        }

        public function set latitudeStart(arg1:Number):void
        {
            if (arg1 != _latitudeStart) 
            {
                _latitudeStart = arg1;
                dispatchEvent(new flash.events.Event("latitudeStartChange"));
            }
            return;
        }

        internal function generateRoutePointsXML():XML
        {
            var loc4:*=0;
            var loc3:*=null;
            var loc1:*=new XML("<RoutePoints/>");
            var loc2:*=routePoints.length;
            loc4 = 0;
            while (loc4 < loc2) 
            {
                loc3 = routePoints[loc4];
                loc1.appendChild(loc3.generateXML());
                ++loc4;
            }
            return loc1;
        }

        public function get loadedFrom():String
        {
            return _loadedFrom;
        }

        public function set loadedFrom(arg1:String):void
        {
            _loadedFrom = arg1;
            return;
        }

        internal function generateRouteOptionsXML(arg1:XML):XML
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc1:*=routeOptions.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                (loc3 = new XML("<RouteOption/>")).@param = routeOptions[loc2].param;
                arg1.appendChild(loc3);
                ++loc2;
            }
            return loc3;
        }

        public function get longitudeEnd():Number
        {
            return _longitudeEnd;
        }

        public function set longitudeEnd(arg1:Number):void
        {
            if (arg1 != _longitudeEnd) 
            {
                _longitudeEnd = arg1;
                dispatchEvent(new flash.events.Event("longitudeEndChange"));
            }
            return;
        }

        internal function generatePOIXML():XML
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc2:*=new XML("<RoutePOIs/>");
            var loc1:*=pois.length;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc4 = pois[loc3];
                loc2.appendChild(loc4.generateXML());
                ++loc3;
            }
            return loc2;
        }

        public function get longitudeStart():Number
        {
            return _longitudeStart;
        }

        public function set longitudeStart(arg1:Number):void
        {
            if (arg1 != _longitudeStart) 
            {
                _longitudeStart = arg1;
                dispatchEvent(new flash.events.Event("longitudeStartChange"));
            }
            return;
        }

        internal function routeOptionsFromXML(arg1:XML):__AS3__.vec.Vector.<core.route.RouteOptions>
        {
            var loc3:*=0;
            var loc5:*=null;
            var loc2:*=arg1.RouteOption;
            var loc1:*=(arg1.RouteOption as XMLList).length();
            var loc4:*=new __AS3__.vec.Vector.<core.route.RouteOptions>();
            loc3 = 0;
            while (loc3 < loc1) 
            {
                (loc5 = new core.route.RouteOptions()).param = loc2[loc3].@param;
                loc4.push(loc5);
                ++loc3;
            }
            return loc4;
        }

        public function get maximumAltitude():Number
        {
            return this.maximumAltitude;
        }

        public function set maximumAltitude(arg1:Number):void
        {
            var loc1:*=this.maximumAltitude;
            if (loc1 !== arg1) 
            {
                this.maximumAltitude = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maximumAltitude", loc1, arg1));
                }
            }
            return;
        }

        internal function routePointsFromXML(arg1:XML):__AS3__.vec.Vector.<core.route.RoutePoint>
        {
            var loc1:*=null;
            var loc5:*=new __AS3__.vec.Vector.<core.route.RoutePoint>();
            var loc2:*=arg1.RoutePoints.RoutePoint;
            var loc3:*=loc2.length();
            var loc4:*=0;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc1 = new core.route.RoutePoint();
                loc1.fromXML(loc2[loc4]);
                loc5.push(loc1);
                ++loc4;
            }
            return loc5;
        }

        public function get minimumAltitude():Number
        {
            return this.minimumAltitude;
        }

        public function set minimumAltitude(arg1:Number):void
        {
            var loc1:*=this.minimumAltitude;
            if (loc1 !== arg1) 
            {
                this.minimumAltitude = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "minimumAltitude", loc1, arg1));
                }
            }
            return;
        }

        internal function routePOIsFromXML(arg1:XML):__AS3__.vec.Vector.<core.route.RoutePoi>
        {
            var loc1:*=null;
            var loc5:*=new __AS3__.vec.Vector.<core.route.RoutePoi>();
            var loc2:*=arg1.RoutePOIs.POI;
            var loc3:*=loc2.length();
            var loc4:*=0;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc1 = new core.route.RoutePoi();
                loc1.fromXML(loc2[loc4]);
                loc5.push(loc1);
                ++loc4;
            }
            return loc5;
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

        public static function copy(arg1:core.route.Route):core.route.Route
        {
            var loc1:*=new Route();
            loc1.GUID = arg1.GUID;
            loc1.loadedFrom = arg1.loadedFrom;
            loc1.ownTrack = arg1.ownTrack;
            loc1.modificationDate = arg1.modificationDate;
            loc1.latitudeStart = arg1.latitudeStart;
            loc1.latitudeEnd = arg1.latitudeEnd;
            loc1.longitudeStart = arg1.longitudeStart;
            loc1.longitudeEnd = arg1.longitudeEnd;
            loc1.name = arg1.name;
            loc1.description = arg1.description;
            loc1.distance = arg1.distance;
            loc1.altitudeDifferencesUphill = arg1.altitudeDifferencesUphill;
            loc1.altitudeDifferencesDownhill = arg1.altitudeDifferencesDownhill;
            loc1.rating = arg1.rating;
            loc1.autor = arg1.autor;
            loc1.webPortalId = arg1.webPortalId;
            loc1.downloadId = arg1.downloadId;
            loc1.isCircuit = arg1.isCircuit;
            loc1.modifiedSinceUploadToDevice = arg1.modifiedSinceUploadToDevice;
            loc1.creationTimestamp = arg1.creationTimestamp;
            loc1.isDeleted = arg1.isDeleted;
            loc1.routePoints = arg1.routePoints.concat();
            loc1.routeOptions = arg1.routeOptions.concat();
            loc1.pois = arg1.pois.concat();
            return loc1;
        }

        public function get modifiedSinceUploadToDevice():Boolean
        {
            return _modifiedSinceUploadToDevice;
        }

        public function set modifiedSinceUploadToDevice(arg1:Boolean):void
        {
            _modifiedSinceUploadToDevice = arg1;
            return;
        }

        public static function reducePoints(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>, arg2:int, arg3:int, arg4:int, arg5:int=1):__AS3__.vec.Vector.<core.route.RoutePoint>
        {
            var loc2:*=undefined;
            var loc1:*;
            if ((loc1 = arg3) > 0) 
            {
                if (!(loc2 = utils.Calculations.simplify(arg1, loc1))) 
                {
                    return arg1;
                }
                while (loc2.length > arg2) 
                {
                    if ((loc1 = loc1 + arg5) <= arg4 || arg4 == 0) 
                    {
                        loc2 = utils.Calculations.simplify(loc2, loc1);
                        continue;
                    }
                    break;
                }
            }
            else 
            {
                loc2 = arg1;
            }
            return loc2;
        }

        public function get name():String
        {
            return _name;
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

        public static function generateSTF(arg1:core.route.Route):String
        {
            var loc1:*="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
            loc1 = loc1 + arg1.generateXML().toString();
            return loc1;
        }

        public function get ownTrack():Boolean
        {
            return this.ownTrack;
        }

        public function set ownTrack(arg1:Boolean):void
        {
            var loc1:*=this.ownTrack;
            if (loc1 !== arg1) 
            {
                this.ownTrack = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "ownTrack", loc1, arg1));
                }
            }
            return;
        }

        public static function fromSTF(arg1:XML):core.route.Route
        {
            var loc1:*=new Route();
            loc1.fromXML(arg1);
            loc1.GUID = utils.GUID.create();
            return loc1;
        }

        public static function generateDBCreateTrigger(arg1:uint):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                loc1 = "CREATE TRIGGER IF NOT EXISTS RouteTrigger AFTER DELETE ON Route FOR EACH ROW BEGIN DELETE FROM RoutePoint WHERE RoutePoint.routeId = OLD.routeId; DELETE FROM RoutePois WHERE RoutePois.routeId = OLD.routeId; DELETE FROM RouteOptions WHERE RouteOptions.routeId = OLD.routeId;END";
            }
        }

        public function get rating():int
        {
            return _rating;
        }

        public function set rating(arg1:int):void
        {
            if (arg1 != _rating) 
            {
                _rating = arg1;
                dispatchEvent(new flash.events.Event("ratingChange"));
            }
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Route");
                DB_TABLE_400.addColumns([["routeId", "INTEGER", false, true, true], ["GUID", "VARCHAR UNIQUE", false], ["modificationDate", "NUMERIC", true], ["latitudeStart", "NUMERIC", false], ["longitudeStart", "NUMERIC", false], ["latitudeEnd", "NUMERIC", false], ["longitudeEnd", "NUMERIC", false], ["name", "VARCHAR", true], ["description", "TEXT", true], ["distance", "NUMERIC", true], ["altitudeDifferencesUphill", "NUMERIC", false], ["altitudeDifferencesDownhill", "NUMERIC", false], ["rating", "INTEGER", false], ["autor", "VARCHAR", false], ["webPortalId", "VARCHAR", true], ["downloadId", "VARCHAR", true], ["ghostData", "TEXT", true], ["isCircuit", "BOOL", true], ["modifiedSinceUploadToDevice", "BOOL", true], ["creationTimestamp", "VARCHAR", false], ["isDeleted", "BOOL", true], ["emptyField1", "VARCHAR", true], ["emptyField2", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function setImportedRouteStartPoints(arg1:core.route.Route):void
        {
            var loc2:*=null;
            var loc1:*=null;
            if (arg1.routePoints.length > 2) 
            {
                arg1.routePoints[0].userPoint = true;
                arg1.routePoints[0].routingType = "imported";
                loc2 = new core.route.RoutePoint();
                loc2.routeId = arg1.routeId;
                loc2.longitude = arg1.routePoints[0].longitude;
                loc2.latitude = arg1.routePoints[0].latitude;
                loc2.altitude = arg1.routePoints[0].altitude;
                loc2.routingType = "imported";
                loc2.userPoint = true;
                arg1.latitudeStart = arg1.routePoints[0].latitude;
                arg1.longitudeStart = arg1.routePoints[0].longitude;
                arg1.routePoints[(arg1.routePoints.length - 1)].userPoint = true;
                loc1 = new core.route.RoutePoint();
                loc1.routeId = arg1.routeId;
                loc1.longitude = arg1.routePoints[(arg1.routePoints.length - 1)].longitude;
                loc1.latitude = arg1.routePoints[(arg1.routePoints.length - 1)].latitude;
                loc1.altitude = arg1.routePoints[(arg1.routePoints.length - 1)].altitude;
                loc1.routingType = "imported";
                loc1.userPoint = true;
                arg1.latitudeEnd = arg1.routePoints[(arg1.routePoints.length - 1)].latitude;
                arg1.longitudeEnd = arg1.routePoints[(arg1.routePoints.length - 1)].longitude;
            }
            else 
            {
                if (arg1.routePoints.length > 0) 
                {
                    arg1.routePoints[0].userPoint = true;
                    arg1.routePoints[0].routingType = "imported";
                }
                if (arg1.routePoints.length > 1) 
                {
                    arg1.routePoints[(arg1.routePoints.length - 1)].userPoint = true;
                    arg1.routePoints[(arg1.routePoints.length - 1)].routingType = "imported";
                }
            }
            return;
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

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Route (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function statementGetRoutes(arg1:int=0, arg2:String="modificationDate", arg3:Boolean=false):String
        {
            var loc1:*="";
            loc1 = "SELECT * FROM Route";
            if (arg1 > 0) 
            {
                loc1 = loc1 + (" WHERE routeId = " + arg1);
            }
            else 
            {
                loc1 = loc1 + (" WHERE isDeleted = false ORDER BY " + arg2);
            }
            if (arg2 == "name") 
            {
                loc1 = loc1 + " COLLATE NOCASE";
            }
            return loc1 = loc1 + (arg3 ? " ASC" : " DESC");
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE Route SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE " + "GUID" + " = \'" + arg1 + "\'";
            return loc2;
        }

        public function get selected():Boolean
        {
            return _selected;
        }

        public function set selected(arg1:Boolean):void
        {
            _selected = arg1;
            return;
        }

        public function get timestamp():int
        {
            if (_timestamp == 0) 
            {
                if (creationTimestamp != null) 
                {
                    _timestamp = creationTimestamp.time / 1000;
                }
                else 
                {
                    _timestamp = new Date().time / 1000;
                }
            }
            return _timestamp;
        }

        public function set timestamp(arg1:int):void
        {
            _timestamp = arg1;
            return;
        }

        public function set webPortalId(arg1:String):void
        {
            if (arg1 != _webPortalId) 
            {
                _webPortalId = arg1;
                dispatchEvent(new flash.events.Event("webPortalIdChange"));
            }
            return;
        }

        public static const COL_LATITUDE_START:String="latitudeStart";

        public static const COL_LONGITUDE_END:String="longitudeEnd";

        public static const COL_LONGITUDE_START:String="longitudeStart";

        public static const COL_MODIFICATION_DATE:String="modificationDate";

        public static const COL_ALTITUDE_DIFFERENCES_DOWNHILL:String="altitudeDifferencesDownhill";

        public static const COL_MODIFIED_SINCE_UPLOAD_TO_DEVICE:String="modifiedSinceUploadToDevice";

        public static const COL_NAME:String="name";

        public static const COL_ROUTE_ID:String="routeId";

        public static const COL_WEB_PORTAL_ID:String="webPortalId";

        public static const COL_IS_CIRCUIT:String="isCircuit";

        public static const LOADED_FROM_DATABASE:String="loadedFromDataBase";

        public static const LOADED_FROM_DEVCIE:String="loadedFromDevice";

        public static const LOADED_FROM_GPSIES:String="loadedFromGPSies";

        public static const TABLE_NAME:String="Route";

        public static const COL_RATING:String="rating";

        public static const COL_ALTITUDE_DIFFERENCES_UPHILL:String="altitudeDifferencesUphill";

        public static const COL_AUTOR:String="autor";

        public static const COL_CREATIONTIMESTAMP:String="creationTimestamp";

        public static const COL_DESCRIPTION:String="description";

        public static const COL_DISTANCE:String="distance";

        public static const COL_DOWNLOAD_ID:String="downloadId";

        public static const COL_GHOST_DATA:String="ghostData";

        public static const COL_GUID:String="GUID";

        public static const COL_IS_DELETED:String="isDeleted";

        public static const COL_LATITUDE_END:String="latitudeEnd";

        internal var _GUID:String="";

        protected var _altitudeDifferencesDownhill:int=0;

        protected var _altitudeDifferencesUphill:int=0;

        protected var _autor:String="";

        public var bikeIconMatches:int=0;

        internal var _creationTimestamp:Date;

        protected var _description:String="";

        public var distanceOutputString:String="";

        public var downhillOutputString:String;

        internal var _ghostData:Array;

        internal var _ghostName:String="";

        internal var _isCircuit:Boolean=false;

        internal var _isDeleted:Boolean=false;

        protected var _latitudeEnd:Number;

        protected var _latitudeStart:Number;

        internal var _loadedFrom:String="loadedFromDataBase";

        protected var _longitudeEnd:Number;

        protected var _longitudeStart:Number;

        internal var maximumAltitude:Number;

        internal var minimumAltitude:Number;

        internal var _modificationDate:Number=0;

        internal var _modifiedSinceUploadToDevice:Boolean=false;

        protected var _name:String="";

        internal var ownTrack:Boolean;

        public var pois:__AS3__.vec.Vector.<core.route.RoutePoi>;

        protected var _rating:int=0;

        public var routeHeader:Array;

        protected var _routeId:int;

        public var routePoints:__AS3__.vec.Vector.<core.route.RoutePoint>;

        public var routePoisToLoad:int=0;

        public var routePoisToSend:__AS3__.vec.Vector.<core.route.RoutePoi>;

        public var runningIconMatches:int=0;

        internal var _selected:Boolean=false;

        public var routePointsReduced:__AS3__.vec.Vector.<core.route.RoutePoint>;

        public var routePointsSend:int=0;

        protected var _timestamp:int=0;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        public var routeOptions:__AS3__.vec.Vector.<core.route.RouteOptions>;

        protected var _distance:Number=0;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        protected var _downloadId:String="0";

        public var routePointsToSend:Array;

        public var uphillOutputString:String;

        public var validateTypeIconFlag:Boolean=true;

        public var wayTTP_curId:Number=0;

        public var wayTTP_wayTTP:Number=0;

        public var waypointsLoaded:Array;

        protected var _webPortalId:String="";

        public var routePointsLoaded:Array;

        public var routePointsToLoad:int=0;
    }
}


