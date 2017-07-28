//class TracksMap
package frontend.screen.tracks.tabs.track.tabs 
{
    import backend.utils.dbUtils.*;
    import core.route.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.events.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.components.map.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import handler.*;
    import handler.event.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class TracksMap extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function TracksMap()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._TracksMap_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_track_tabs_TracksMapWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TracksMap[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._TracksMap_MapView1_i()];
            this.addEventListener("addedToStage", this.___TracksMap_TabLayoutGroup1_addedToStage);
            this.addEventListener("removedFromStage", this.___TracksMap_TabLayoutGroup1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get myRoute():core.route.Route
        {
            return this._myRoute;
        }

        internal function set _1496932349myRoute(arg1:core.route.Route):void
        {
            this._myRoute = arg1;
            if (this._drawTrackTimeout != 0) 
            {
                flash.utils.clearTimeout(this._drawTrackTimeout);
                this._drawTrackTimeout = 0;
            }
            if (this._myRoute) 
            {
                this.showContent();
            }
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            this.mapView.mapLockActivated = true;
            this.myRoute = null;
            return;
        }

        public override function showContent():void
        {
            if (handler.ViewHandler.getInstance().navigator.isTransitionActive) 
            {
                debug.Debug.debug("draw track later...");
                this._drawTrackTimeout = flash.utils.setTimeout(this.showContent, 100);
                return;
            }
            this.mapView.showMap(this.myRoute.latitudeStart, this.myRoute.latitudeEnd);
            this.mapView.showControls();
            if (this.myRoute.routePoints.length != 0) 
            {
                this.drawTrack();
            }
            else 
            {
                handler.RouteHandler.getInstance().loadRoutePoints(new backend.utils.dbUtils.DBUtilObject(null, this.loadRoutePointsComplete, this.loadRoutePointsError, Workers.worker_DatabaseWorker), this.myRoute.routeId);
            }
            return;
        }

        internal function loadRoutePointsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.RouteHandler.getInstance().loadRoutePointsComplete(arg1.getResult(), this.myRoute);
            this.drawTrack();
            return;
        }

        internal function drawTrack():void
        {
            if (this.myRoute.routePoints.length == 0) 
            {
                return;
            }
            var loc1:*=this.myRoute.routePoints[0].latitude;
            var loc2:*=this.myRoute.routePoints[0].longitude;
            var loc3:*=this.myRoute.routePoints[(this.myRoute.routePoints.length - 1)].latitude;
            var loc4:*=this.myRoute.routePoints[(this.myRoute.routePoints.length - 1)].longitude;
            this.mapView.showRouteTrack(this.myRoute.routePoints);
            this.mapView.showStartMarker(loc1, loc2);
            this.mapView.showEndMarker(loc3, loc4);
            this.mapView.focusTrack();
            var loc5:*=new handler.event.RouteEvent(handler.RouteHandlerCommon.ROUTE_POINTS_LOADED);
            loc5.route = this.myRoute;
            handler.RouteHandler.getInstance().dispatchEvent(loc5);
            return;
        }

        internal function loadRoutePointsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("loadRoutePointsError");
            return;
        }

        internal function _TracksMap_MapView1_i():frontend.components.map.MapView
        {
            var loc1:*=new frontend.components.map.MapView();
            loc1.showFocusButton = true;
            loc1.showLayerButton = true;
            loc1.showLockButton = true;
            loc1.id = "mapView";
            this.mapView = loc1;
            feathers.binding.BindingManager.executeBindings(this, "mapView", this.mapView);
            return loc1;
        }

        public function ___TracksMap_TabLayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___TracksMap_TabLayoutGroup1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _TracksMap_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.MYTRACKS.TRACK.MAP.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight - SIGMALink.headerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - SIGMALink.footerHeight;
            }, null, "mapView.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "mapView.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.headerHeight + frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "mapView.yStartCorrection")
            return result;
        }

        public function get mapView():frontend.components.map.MapView
        {
            return this._836781601mapView;
        }

        public function set mapView(arg1:frontend.components.map.MapView):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._836781601mapView;
            if (loc1 !== arg1) 
            {
                this._836781601mapView = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "mapView", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set myRoute(arg1:core.route.Route):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.myRoute;
            if (loc1 !== arg1) 
            {
                this._1496932349myRoute = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "myRoute", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            TracksMap._watcherSetupUtil = arg1;
            return;
        }

        public static const TAB_NAME:String="MYTRACKS_TRACK_MAP";

        internal var _836781601mapView:frontend.components.map.MapView;

        internal var _myRoute:core.route.Route;

        internal var _drawTrackTimeout:uint=0;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


