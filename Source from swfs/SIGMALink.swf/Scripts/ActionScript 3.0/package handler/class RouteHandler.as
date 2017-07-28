//class RouteHandler
package handler 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import com.logging.*;
    import core.route.*;
    import database.*;
    import debug.*;
    import flash.data.*;
    import flash.events.*;
    import service.cloud.*;
    
    public class RouteHandler extends handler.RouteHandlerCommon
    {
        public function RouteHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            return;
        }

        public function generateLoadRoutePoints(arg1:int):String
        {
            return "SELECT * FROM RoutePoint WHERE routeId = " + arg1;
        }

        public function generateLoadOptions(arg1:int):String
        {
            return "SELECT * FROM RouteOptions WHERE routeId = " + arg1;
        }

        public function generateLoadPOIs(arg1:int):String
        {
            return "SELECT * FROM RoutePois WHERE routeId = " + arg1;
        }

        public function generateLoadRouteByGUIDStatement(arg1:String):String
        {
            return "SELECT * FROM Route WHERE GUID = \'" + arg1 + "\'";
        }

        public function loadRoutePointsComplete(arg1:Array, arg2:core.route.Route):void
        {
            var loc2:*=null;
            var loc4:*=0;
            if (!arg1) 
            {
                return;
            }
            var loc1:*=new Vector.<core.route.RoutePoint>();
            var loc3:*=arg1.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc2 = new core.route.RoutePoint();
                loc2.fromDB(arg1[loc4]);
                loc1.push(loc2);
                ++loc4;
            }
            arg2.routePoints = loc1;
            return;
        }

        public function loadRouteOptionsComplete(arg1:Array, arg2:core.route.Route):void
        {
            var loc2:*=null;
            var loc4:*=0;
            if (!arg1) 
            {
                return;
            }
            var loc1:*=new Vector.<core.route.RouteOptions>();
            var loc3:*=arg1.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc2 = new core.route.RouteOptions();
                loc2.fromDB(arg1[loc4]);
                loc1.push(loc2);
                ++loc4;
            }
            arg2.routeOptions = loc1;
            return;
        }

        public function loadRoutePOIsComplete(arg1:Array, arg2:core.route.Route):void
        {
            var loc2:*=null;
            var loc4:*=0;
            if (!arg1) 
            {
                return;
            }
            var loc1:*=new Vector.<core.route.RoutePoi>();
            var loc3:*=arg1.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc2 = new core.route.RoutePoi();
                loc2.fromDB(arg1[loc4]);
                loc1.push(loc2);
                ++loc4;
            }
            arg2.pois = loc1;
            return;
        }

        public function downloadRoute(arg1:XML, arg2:service.cloud.CloudURLStream):void
        {
            var loc1:*=new core.route.Route();
            loc1.fromXML(arg1);
            loc1.GUID = arg2.data.GUID;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1.selectPrimaryKeyFromGUID(), this.onGetRouteGUIDComplete, this.onGetRouteGUIDError, null, [loc1, arg2]);
            return;
        }

        internal function onGetRouteGUIDComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data[0] as core.route.Route;
            var loc2:*=arg1.data.data[1] as service.cloud.CloudURLStream;
            var loc3:*=arg1.getResult();
            if (loc3.length != 1) 
            {
                this.saveDownloadedRoute(loc1, loc2);
            }
            else 
            {
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1.generateDBDeleteStatement(), this.onDeleteRouteComplete, this.onDeleteRouteError, null, [loc1, loc2]);
            }
            return;
        }

        internal function onGetRouteGUIDError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onGetRouteGUIDError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_TRACK);
            return;
        }

        internal function onDeleteRouteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onDeleteRouteComplete");
            var loc1:*=arg1.data.data[0] as core.route.Route;
            var loc2:*=arg1.data.data[1] as service.cloud.CloudURLStream;
            this.saveDownloadedRoute(loc1, loc2);
            return;
        }

        internal function onDeleteRouteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteRouteError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_TRACK);
            return;
        }

        internal function saveDownloadedRoute(arg1:core.route.Route, arg2:service.cloud.CloudURLStream):void
        {
            debug.Debug.debug("saveDownloadedRoute");
            arg1.modificationDate = arg2.data.modificationDate;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject(arg1, this.saveRouteComplete, this.saveRouteError, null, true);
            this.saveRoute(loc1);
            return;
        }

        internal function saveRouteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("saveRouteComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_TRACK);
            return;
        }

        internal function saveRouteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveRouteError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_TRACK);
            return;
        }

        public function saveRoute(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc1:*=[];
            var loc2:*=[];
            var loc3:*=(arg1.data as core.route.Route).generateDBInsert();
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc3.text, this.onInsertRouteComplete, this.onInsertRouteError, arg1.workerTarget, arg1, loc3.parameters);
            return;
        }

        internal function onInsertRouteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Route saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            if (arg1.data.lastInsertRowId != 0) 
            {
                (loc1.data as core.route.Route).routeId = arg1.data.lastInsertRowId;
            }
            if (loc1.parameters) 
            {
                this.saveRouteOptions(loc1);
            }
            else 
            {
                loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            }
            return;
        }

        internal function onInsertRouteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        public function saveRouteOptions(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc2:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=arg1.data as core.route.Route;
            var loc3:*=loc1.routeOptions.length;
            var loc4:*=new Array();
            if (loc3 != 0) 
            {
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc1.routeOptions[loc2];
                    loc5.routeId = loc1.routeId;
                    loc6 = loc5.generateDBInsert();
                    loc7 = new backend.utils.dbUtils.DBUtilObject();
                    loc7.stmt = loc6.text;
                    loc7.parameters = loc6.parameters;
                    loc4.push(loc7);
                    ++loc2;
                }
                backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc4, this.onInsertRouteOptionComplete, this.onInsertRouteOptionError, arg1.workerTarget, arg1);
            }
            else if (arg1.parameters) 
            {
                this.saveRoutePoints(arg1);
            }
            else 
            {
                arg1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            }
            return;
        }

        internal function onInsertRouteOptionComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Route Options saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            if (loc1.parameters) 
            {
                this.saveRoutePoints(loc1);
            }
            else 
            {
                loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            }
            return;
        }

        internal function onInsertRouteOptionError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        public function loadRoute(arg1:backend.utils.dbUtils.DBUtilObject, arg2:uint=0):void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.route.Route.statementGetRoutes(arg2), arg1.completeCallback, arg1.errorCallback, arg1.workerTarget);
            return;
        }

        public function loadRoutePoints(arg1:backend.utils.dbUtils.DBUtilObject, arg2:uint=0):void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, handler.RouteHandler.getInstance().generateLoadRoutePoints(arg2), arg1.completeCallback, arg1.errorCallback, arg1.workerTarget);
            return;
        }

        public function saveRoutePoints(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc2:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=arg1.data as core.route.Route;
            var loc3:*=loc1.routePoints.length;
            var loc4:*=new Array();
            if (loc3 != 0) 
            {
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc1.routePoints[loc2];
                    loc5.routeId = loc1.routeId;
                    loc6 = loc5.generateDBInsert()[0];
                    loc7 = new backend.utils.dbUtils.DBUtilObject();
                    loc7.stmt = loc6.text;
                    loc7.parameters = loc6.parameters;
                    loc4.push(loc7);
                    ++loc2;
                }
                backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc4, this.onInsertRoutePointComplete, this.onInsertRoutePointError, arg1.workerTarget, arg1);
            }
            else if (arg1.parameters) 
            {
                this.saveRoutePOIs(arg1);
            }
            else 
            {
                arg1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            }
            return;
        }

        internal function onInsertRoutePointComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Route points saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            if (loc1.parameters) 
            {
                this.saveRoutePOIs(loc1);
            }
            else 
            {
                loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            }
            return;
        }

        internal function onInsertRoutePointError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertRoutePointError");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        public function saveRoutePOIs(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc2:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=arg1.data as core.route.Route;
            var loc3:*=loc1.pois.length;
            var loc4:*=new Array();
            if (loc3 != 0) 
            {
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc1.pois[loc2];
                    loc5.routeId = loc1.routeId;
                    loc6 = loc5.generateDBInsert()[0];
                    loc7 = new backend.utils.dbUtils.DBUtilObject();
                    loc7.stmt = loc6.text;
                    loc7.parameters = loc6.parameters;
                    loc4.push(loc7);
                    ++loc2;
                }
                backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc4, this.onInsertRoutePOIComplete, this.onInsertRoutePOIError, arg1.workerTarget, arg1);
            }
            else 
            {
                arg1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            }
            return;
        }

        internal function onInsertRoutePOIComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Route POIs saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            return;
        }

        internal function onInsertRoutePOIError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertRoutePOIError");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        public function deleteRoutes(arg1:Array):void
        {
            var loc1:*="DELETE FROM Route WHERE GUID in (" + arg1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onRoutesDeleteComplete, this.onRoutesDeleteError, null, arg1);
            return;
        }

        internal function onRoutesDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onRoutesDeleteComplete");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_TRACK, arg1.data.data as Array);
            return;
        }

        internal function onRoutesDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onRoutesDeleteError");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_TRACK, arg1.data.data as Array);
            return;
        }

        public static function getInstance():handler.RouteHandler
        {
            if (_instance == null) 
            {
                _instance = new RouteHandler();
                handler.RouteHandlerCommon.setInstace(_instance);
            }
            return _instance as handler.RouteHandler;
        }

        internal static var _instance:handler.RouteHandler;
    }
}


