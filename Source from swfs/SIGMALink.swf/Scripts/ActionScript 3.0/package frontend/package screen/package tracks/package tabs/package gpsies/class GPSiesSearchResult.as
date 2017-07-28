//class GPSiesSearchResult
package frontend.screen.tracks.tabs.gpsies 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.route.*;
    import debug.*;
    import flash.geom.*;
    import utils.*;
    
    public class GPSiesSearchResult extends Object
    {
        public function GPSiesSearchResult()
        {
            this.trackCharacters = new Array();
            this.trackData = new Array();
            this.trackPoints = new Array();
            this.trackTypes = new Array();
            this.waypointData = new Array();
            super();
            return;
        }

        internal function convertGPSiesDateStringToDate(arg1:String):Date
        {
            var loc1:*=arg1.split(" ");
            var loc2:*=loc1[0].toString().split("-");
            var loc3:*=loc1[1].toString().split(":");
            return new Date(loc2[0], (loc2[1] - 1), loc2[2], loc3[0], loc3[1], loc3[2].toString().substr(0, 2));
        }

        public function routeFromJSON(arg1:Object, arg2:core.route.Route):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (!arg1.data.hasOwnProperty("fileId")) 
            {
                return;
            }
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            if (arg1.data.hasOwnProperty("changedDate")) 
            {
                this.changedDate = this.convertGPSiesDateStringToDate(arg1.data.changedDate);
            }
            this.client = arg1.client;
            this.countTrackpoints = arg1.data.countTrackpoints;
            if (arg1.data.hasOwnProperty("createdDate")) 
            {
                this.createdDate = this.convertGPSiesDateStringToDate(arg1.data.createdDate);
            }
            if (arg1.data.hasOwnProperty("description")) 
            {
                this.description = arg1.data.description == null ? "" : arg1.data.description;
            }
            this.fileId = arg1.data.fileId;
            if (arg1.data.hasOwnProperty("startPoint")) 
            {
                this.startPoint = new flash.geom.Point(arg1.data.lon, arg1.data.lat);
            }
            if (arg1.data.hasOwnProperty("distance")) 
            {
                this.distance = arg1.data.length * 1000;
            }
            if (arg1.data.hasOwnProperty("maxHeight")) 
            {
                this.maxHeight = arg1.data.maxHeight * 1000;
            }
            if (arg1.data.hasOwnProperty("minHeight")) 
            {
                this.minHeight = arg1.data.minHeight * 1000;
            }
            this.property = arg1.data.property;
            this.status = arg1.data.status;
            if (arg1.data.hasOwnProperty("totalAscent")) 
            {
                this.totalAscent = arg1.data.totalAscent * 1000;
            }
            if (arg1.data.hasOwnProperty("totalDescent")) 
            {
                this.totalDescent = arg1.data.totalDescent * 1000;
            }
            this.trackName = arg1.data.trackname;
            arg2.creationTimestamp = this.createdDate;
            arg2.modificationDate = this.changedDate.time;
            arg2.routeOptions = new Vector.<core.route.RouteOptions>();
            if (arg1.data.hasOwnProperty("trackTypes")) 
            {
                this.trackTypes = arg1.data.trackTypes as Array;
                loc3 = this.trackTypes.length;
                loc1 = 0;
                while (loc1 < loc3) 
                {
                    loc4 = new core.route.RouteOptions();
                    loc4.param = this.trackTypes[loc1].toString();
                    arg2.routeOptions.push(loc4);
                    ++loc1;
                }
            }
            if (arg1.data.hasOwnProperty("waypointData")) 
            {
                this.waypointData = arg1.data.waypointData as Array;
            }
            if (arg1.data.hasOwnProperty("trackCharacters")) 
            {
                this.trackCharacters = arg1.data.trackCharacters as Array;
                loc3 = this.trackCharacters.length;
                loc1 = 0;
                while (loc1 < loc3) 
                {
                    loc4 = new core.route.RouteOptions();
                    loc4.param = this.trackCharacters[loc1].toString();
                    arg2.routeOptions.push(loc4);
                    ++loc1;
                }
            }
            if (arg1.data.hasOwnProperty("trackData")) 
            {
                this.trackData = arg1.data.trackData as Array;
                arg2.routePoints = new Vector.<core.route.RoutePoint>();
                loc2 = 0;
                while (loc2 < this.trackData.length) 
                {
                    this.trackPoints = this.trackData[loc2] as Array;
                    loc3 = this.trackPoints.length;
                    loc1 = 0;
                    while (loc1 < loc3) 
                    {
                        loc6 = this.trackPoints[loc1] as Object;
                        loc5 = new core.route.RoutePoint();
                        loc5.routeId = arg2.routeId;
                        loc5.altitude = loc6.ele * 1000;
                        loc5.latitude = loc6.lat;
                        loc5.longitude = loc6.lon;
                        loc5.routingType = core.route.RoutingType.IMPORTED;
                        loc5.userPoint = false;
                        arg2.routePoints.push(loc5);
                        ++loc1;
                    }
                    ++loc2;
                }
                core.route.Route.setImportedRouteStartPoints(arg2);
            }
            this.userName = arg1.data.username;
            debug.Debug.debug("track details (" + this.fileId + ")");
            return;
        }

        public function headerFromJSON(arg1:Object):void
        {
            if (!arg1.hasOwnProperty("fileId")) 
            {
                return;
            }
            this.changedDate = this.convertGPSiesDateStringToDate(arg1.changedDate);
            this.client = arg1.client;
            this.createdDate = this.convertGPSiesDateStringToDate(arg1.createdDate);
            this.fileId = arg1.fileId;
            this.startPoint = new flash.geom.Point(arg1.lon, arg1.lat);
            this.distance = arg1.length * 1000;
            this.distanceFormatted = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.distance));
            this.property = arg1.property;
            this.trackName = arg1.trackname;
            this.userName = arg1.username;
            this.tmpRoute = new core.route.Route();
            this.tmpRoute.GUID = utils.GUID.create();
            this.tmpRoute.routeId = 0;
            this.tmpRoute.ownTrack = false;
            this.tmpRoute.distance = this.distance;
            this.tmpRoute.distanceOutputString = this.distanceFormatted;
            this.tmpRoute.creationTimestamp = this.createdDate;
            this.tmpRoute.name = this.trackName;
            this.tmpRoute.isCircuit = this.property == 1;
            this.tmpRoute.webPortalId = this.fileId;
            this.tmpRoute.latitudeStart = this.startPoint.y;
            this.tmpRoute.longitudeStart = this.startPoint.x;
            this.tmpRoute.loadedFrom = core.route.Route.LOADED_FROM_GPSIES;
            return;
        }

        public static const COL_NAME:String="trackName";

        public static const COL_DISTANCE:String="distance";

        public static const COL_DISTANCE_TO_TRACK:String="distanceToTrack";

        public static const COL_MODIFICATION_DATE:String="changedDate";

        public var changedDate:Date;

        public var client:String;

        public var countTrackpoints:int;

        public var createdDate:Date;

        public var description:String;

        public var distance:Number;

        public var distanceFormatted:String;

        public var distanceToTrack:Number;

        public var distanceToTrackFormatted:String;

        public var fileId:String;

        public var maxHeight:Number;

        public var minHeight:Number;

        public var trackData:Array;

        public var trackName:String;

        public var trackPoints:Array;

        public var trackTypes:Array;

        public var userName:String;

        public var waypointData:Array;

        public var status:int;

        public var startPoint:flash.geom.Point;

        public var property:int;

        public var totalAscent:Number;

        public var totalDescent:Number;

        public var trackCharacters:Array;

        public var tmpRoute:core.route.Route;
    }
}


