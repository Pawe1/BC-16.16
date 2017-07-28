//class RouteHandlerCommon
package handler 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.route.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.events.*;
    import utils.*;
    
    public class RouteHandlerCommon extends flash.events.EventDispatcher
    {
        public function RouteHandlerCommon(arg1:flash.events.IEventDispatcher=null)
        {
            altitudeProfileDP = new __AS3__.vec.Vector.<Object>();
            super(arg1);
            return;
        }

        public static function getInstance():handler.RouteHandlerCommon
        {
            if (_instance == null) 
            {
                _instance = new RouteHandlerCommon();
            }
            return _instance as RouteHandlerCommon;
        }

        public function get altitudeProfileDP():__AS3__.vec.Vector.<Object>
        {
            return this.altitudeProfileDP;
        }

        public function set altitudeProfileDP(arg1:__AS3__.vec.Vector.<Object>):void
        {
            var loc1:*=this.altitudeProfileDP;
            if (loc1 !== arg1) 
            {
                this.altitudeProfileDP = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "altitudeProfileDP", loc1, arg1));
                }
            }
            return;
        }

        
        {
            routesDicGUID = new flash.utils.Dictionary(true);
        }

        public function calculateDistances(arg1:core.route.Route, arg2:Boolean=false):void
        {
            var loc3:*=false;
            var loc4:*=null;
            var loc11:*=NaN;
            var loc8:*=NaN;
            var loc1:*=NaN;
            var loc5:*=NaN;
            var loc6:*=0;
            var loc13:*=0;
            var loc2:*=null;
            var loc7:*=undefined;
            var loc14:*=NaN;
            var loc12:*=NaN;
            var loc10:*=undefined;
            var loc9:*=null;
            if (!(sendRouteToWorkerFunction == null) && !arg2) 
            {
                sendRouteToWorkerFunction(arg1);
            }
            else 
            {
                arg1.distance = 0;
                arg1.altitudeDifferencesUphill = 0;
                arg1.altitudeDifferencesDownhill = 0;
                arg1.minimumAltitude = NaN;
                arg1.maximumAltitude = NaN;
                loc3 = true;
                loc4 = null;
                loc13 = arg1.routePoints.length;
                loc7 = new __AS3__.vec.Vector.<Object>();
                loc6 = 0;
                while (loc6 < loc13) 
                {
                    loc12 = (loc2 = arg1.routePoints[loc6]).altitude;
                    if (loc3) 
                    {
                        loc3 = false;
                    }
                    else 
                    {
                        arg1.distance = arg1.distance + utils.Calculations.distanceBetweenRoutePoints(loc4, loc2);
                    }
                    loc7.push({"distance":arg1.distance.toString(), "altitude":loc12, "userPoint":loc2.userPoint, "lat":loc2.latitude, "lon":loc2.longitude});
                    loc4 = loc2;
                    ++loc6;
                }
                if (loc13 > 0) 
                {
                    altitudeProfileDP = core.general.DouglasPeucker.simplify(loc7, "distance", "altitude", arg1.distance / 200, true);
                    loc13 = (loc10 = core.general.DouglasPeucker.simplify(loc7, "distance", "altitude", 1500, true)).length;
                    loc3 = true;
                    loc9 = {};
                    var loc15:*={};
                    loc6 = 0;
                    while (loc6 < loc13) 
                    {
                        loc12 = (loc9 = loc10[loc6]).altitude;
                        if (loc3) 
                        {
                            loc3 = false;
                        }
                        else 
                        {
                            loc14 = loc15.altitude;
                            if (loc15.altitude < loc12) 
                            {
                                arg1.altitudeDifferencesUphill = arg1.altitudeDifferencesUphill + (loc12 - loc15.altitude);
                            }
                            else if (loc15.altitude > loc12) 
                            {
                                arg1.altitudeDifferencesDownhill = arg1.altitudeDifferencesDownhill + (loc15.altitude - loc12);
                            }
                            if (isNaN(arg1.minimumAltitude)) 
                            {
                                arg1.minimumAltitude = loc12;
                            }
                            else 
                            {
                                arg1.minimumAltitude = Math.min(arg1.minimumAltitude, loc12);
                            }
                            if (isNaN(arg1.maximumAltitude)) 
                            {
                                arg1.maximumAltitude = loc12;
                            }
                            else 
                            {
                                arg1.maximumAltitude = Math.max(arg1.maximumAltitude, loc12);
                            }
                        }
                        loc15 = loc9;
                        ++loc6;
                    }
                }
                onFinishedCalculatingDistances(arg1);
            }
            return;
        }

        public function validateRouteStartEnd(arg1:core.route.Route):void
        {
            if (arg1.routePoints.length > 0) 
            {
                arg1.latitudeStart = arg1.routePoints[0].latitude;
                arg1.longitudeStart = arg1.routePoints[0].longitude;
                arg1.latitudeEnd = arg1.routePoints[(arg1.routePoints.length - 1)].latitude;
                arg1.longitudeEnd = arg1.routePoints[(arg1.routePoints.length - 1)].longitude;
            }
            return;
        }

        public function checkIsCircuit(arg1:core.route.Route):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            if (arg1.routePoints.length > 1) 
            {
                loc1 = arg1.routePoints[0];
                loc2 = arg1.routePoints[(arg1.routePoints.length - 1)];
                loc3 = utils.Calculations.distanceBetweenRoutePoints(loc1, loc2);
                arg1.isCircuit = loc3 <= 100 ? true : false;
            }
            else 
            {
                arg1.isCircuit = false;
            }
            return;
        }

        public function onFinishedCalculatingDistances(arg1:core.route.Route):void
        {
            validateRouteStartEnd(arg1);
            checkIsCircuit(arg1);
            addFormattedValues(arg1);
            if (currentRouteType != arg1.loadedFrom) 
            {
                trace("routen-type zur Zeit nicht sichtbar...");
                return;
            }
            if (hasEventListener("profileValuesChanged")) 
            {
                dispatchEvent(new flash.events.Event("profileValuesChanged"));
            }
            return;
        }

        public function addFormattedValues(arg1:core.route.Route):void
        {
            return;
        }

        public static function setInstace(arg1:handler.RouteHandlerCommon):void
        {
            _instance = arg1;
            return;
        }

        public static function calculateAltitudeChartEntries(arg1:core.route.Route, arg2:Number=60):__AS3__.vec.Vector.<Object>
        {
            var p_route:core.route.Route;
            var p_maxEntries:Number;
            var everyEntry:int;
            var lastUsedIndex:int;
            var res:__AS3__.vec.Vector.<core.route.RoutePoint>;
            var i:int;
            var len:int;
            var objVec:__AS3__.vec.Vector.<Object>;

            var loc1:*;
            p_route = arg1;
            p_maxEntries = arg2;
            everyEntry = p_route.routePoints.length / p_maxEntries;
            lastUsedIndex = 0;
            res = p_route.routePoints.filter(function (arg1:core.route.RoutePoint, arg2:int=0, arg3:*=null):Boolean
            {
                var loc1:*=false;
                if (arg2 == 0 || arg2 == (p_route.routePoints.length - 1)) 
                {
                    loc1 = true;
                }
                else if (arg2 % everyEntry != 0) 
                {
                    if (arg1.hasOwnProperty("altitude") && arg1["altitude"] == p_route.maximumAltitude && !(p_route.maximumAltitude == 0)) 
                    {
                        loc1 = true;
                    }
                }
                else 
                {
                    loc1 = true;
                }
                if (loc1) 
                {
                    lastUsedIndex = arg2;
                }
                return loc1;
            })
            objVec = new __AS3__.vec.Vector.<Object>();
            len = res.length;
            i = 0;
            while (i < len) 
            {
                objVec.push(res[i]);
                ++i;
            }
            return objVec;
        }

        public static const DELETE_ROUTE_ON_UNIT_COMPLETE:String="deleteRouteOnUnitComplete";

        public static const DELETE_ROUTE_POINTS_FROM_DB_COMPLETE:String="deleteRoutePointsFromDBComplete";

        public static const DELETE_ROUTE_POIS_FROM_DB_COMPLETE:String="deleteRoutePoisFromDBComplete";

        public static const DELETE_SAVE_ERROR:String="deleteRouteError";

        public static const EXPORT_TO_UNIT:String="exportToUnitEvent";

        public static const EXPORT_TO_UNIT_COMPLETE:String="exportToUnitComplete";

        public static const EXPORT_TO_UNIT_COMPLETE_CALLBACK:String="exportToUnitCompleteCallback";

        public static const LIST_RENDERER_PROPERTY_CHANGED:String="listRendererPropertyChangedEvent";

        public static const NEW_POI_SAVE_ERROR:String="newPoiSaveError";

        public static const NEW_ROUTE_SAVE_ERROR:String="newRouteSaveError";

        public static const POI_DELETE_COMPLETE:String="poiDeleteCompleteEvent";

        public static const POI_SAVED_COMPLETE:String="poiSavedCompleteEvent";

        public static const PROFILE_VALUES_CHANGED:String="profileValuesChanged";

        public static const READ_ROUTES_ERROR:String="readRoutesError";

        public static const READ_ROUTE_POINTS_ERROR:String="readRoutePointsError";

        public static const READ_ROUTE_POIS_ERROR:String="readRoutePoisError";

        public static const ROUTES_CHANGED:String="routesChanged";

        public static const ROUTES_DELETED:String="routesDeleted";

        public static const ROUTES_FILTERED:String="routesFiltered";

        public static const ROUTES_LOADED_COMPLETE:String="routesLoadedComplete";

        public static const ROUTE_ADDED:String="routeAdded";

        public static const ROUTE_DELETED:String="routeDeleted";

        public static const ROUTE_DELETE_ERROR:String="routeDeleteError";

        public static const ROUTE_OPTIONS_ADDED:String="routeOptionsAdded";

        public static const ROUTE_OPTIONS_ADD_ERROR:String="routeOptionsAddError";

        public static const ROUTE_OPTIONS_DELETED:String="routeOptionsDeleted";

        public static const ROUTE_OPTIONS_DELETE_ERROR:String="routeOptionsDeleteError";

        public static const ROUTE_OPTIONS_LOADED:String="routeOptionsLoaded";

        public static const ROUTE_OPTIONS_LOAD_ERROR:String="routeOptionsLoadError";

        public static const ROUTE_POINTS_SAVED:String="routePointsSaved";

        public static const ROUTE_POINTS_SAVE_ERROR:String="routePointSaveError";

        public static const ROUTE_POINT_SAVE_COMPLETE:String="routePointSaveCompleteChanged";

        public static const ROUTE_POINT_SAVE_ERROR:String="routePointSaveCompleteERROR";

        public static const ROUTE_SAVED:String="routeSaved";

        public static const ROUTE_SELECTED:String="routeSelectedEvent";

        public static const ROUTE_POINTS_LOADED:String="routePointsLoadedEvent";

        public static const DELETE_POI_ERROR:String="deletePoiError";

        public static const DELETE_ROUTE_ON_UNIT:String="deleteRouteOnUnit";

        public static const USER_POIS_LOADED_FROM_DB:String="userPoisLoadedFromDBComplete";

        internal static var _instance:handler.RouteHandlerCommon;

        internal var altitudeProfileDP:__AS3__.vec.Vector.<Object>;

        public var currentRouteType:String="";

        public static var routesDicGUID:flash.utils.Dictionary;

        public static var sendRouteToWorkerFunction:Function;
    }
}


