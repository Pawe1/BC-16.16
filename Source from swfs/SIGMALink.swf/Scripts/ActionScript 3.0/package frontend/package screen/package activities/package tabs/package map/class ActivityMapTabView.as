//class ActivityMapTabView
package frontend.screen.activities.tabs.map 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import feathers.binding.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
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
    import frontend.*;
    import frontend.components.map.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
    import frontend.screen.activities.tabs.laps.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ActivityMapTabView extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityMapTabView()
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
            bindings = this._ActivityMapTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_map_ActivityMapTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.map.ActivityMapTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ActivityMapTabView_MapView1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get activity():core.activities.Activity
        {
            return this._activity;
        }

        public function set activity(arg1:core.activities.Activity):void
        {
            this._activity = arg1;
            this._redrawFlag = true;
            return;
        }

        public override function showContent():void
        {
            this.mapView.touchable = true;
            this.mapView.showFocus();
            if (!this._redrawFlag) 
            {
                return;
            }
            this._redrawFlag = false;
            if (this.activity.entries.length == 0) 
            {
                this.mapView.showMap(this.activity.latitudeStartDefined ? this.activity.latitudeStart : 0, this.activity.longitudeStartDefined ? this.activity.longitudeStart : 0);
                this.mapView.showControls();
                return;
            }
            this._lapList = new feathers.data.ListCollection(this._activity.markerList.filter(filterLaps));
            this._autoLapList = new feathers.data.ListCollection(this._activity.markerList.filter(filterAutoLaps));
            var loc1:*=this.activity.entries[0].latitude;
            var loc2:*=this.activity.entries[0].longitude;
            var loc3:*=this.activity.entries[(this.activity.entries.length - 1)].latitude;
            var loc4:*=this.activity.entries[(this.activity.entries.length - 1)].longitude;
            this.mapView.showMap(loc1, loc2);
            this.mapView.showActivityTrack(this.activity.entries);
            this.mapView.showStartMarker(loc1, loc2);
            this.mapView.showEndMarker(loc3, loc4);
            this.mapView.showActivityMarkers(this.activity.markerList);
            this.mapView.showControls();
            return;
        }

        public override function hideContent():void
        {
            super.hideContent();
            if (this.mapView) 
            {
                this.mapView.touchable = false;
                this.mapView.hideFocus();
            }
            return;
        }

        internal function markerCalloutTouchCallback(arg1:core.marker.Marker):void
        {
            var loc1:*=null;
            if (!arg1) 
            {
                return;
            }
            if (arg1.type != core.general.MarkerType.LAP) 
            {
                if (arg1.type != core.general.MarkerType.AUTO_LAP) 
                {
                    return;
                }
                else 
                {
                    loc1 = this._autoLapList;
                }
            }
            else 
            {
                loc1 = this._lapList;
            }
            this.lapDetailsGroup = new frontend.screen.activities.tabs.laps.ActivityLapDetailsView();
            this.lapDetailsGroup.layoutData = new feathers.layout.AnchorLayoutData();
            this.lapDetailsGroup.markerList = loc1;
            this.lapDetailsGroup.lapCurrent = loc1.getItemIndex(arg1) + 1;
            addChild(this.lapDetailsGroup);
            handler.ViewHandler.getInstance().addBackFunction(this.closeLapDetails);
            return;
        }

        public function closeLapDetails():void
        {
            removeChild(this.lapDetailsGroup);
            this.lapDetailsGroup = null;
            return;
        }

        internal function _ActivityMapTabView_MapView1_i():frontend.components.map.MapView
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

        internal function _ActivityMapTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.mapicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.MAP.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight - SIGMALink.headerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - SIGMALink.footerHeight;
            }, null, "mapView.height")
            result[5] = new feathers.binding.Binding(this, function ():Function
            {
                return markerCalloutTouchCallback;
            }, null, "mapView.markerCalloutTouchCallback")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "mapView.width")
            result[7] = new feathers.binding.Binding(this, function ():Number
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

        internal function get contentHeight():Number
        {
            return this._655379712contentHeight;
        }

        internal function set contentHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._655379712contentHeight;
            if (loc1 !== arg1) 
            {
                this._655379712contentHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "contentHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static function filterLaps(arg1:core.marker.Marker, arg2:int, arg3:__AS3__.vec.Vector.<core.marker.Marker>):Boolean
        {
            return arg1.type == core.general.MarkerType.LAP;
        }

        internal static function filterAutoLaps(arg1:core.marker.Marker, arg2:int, arg3:__AS3__.vec.Vector.<core.marker.Marker>):Boolean
        {
            return arg1.type == core.general.MarkerType.AUTO_LAP;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.map.ActivityMapTabView._watcherSetupUtil = arg1;
            return;
        }

        internal static const PADDING:Number=10 * SIGMALink.scaleFactor;

        internal var _836781601mapView:frontend.components.map.MapView;

        internal var _activity:core.activities.Activity;

        internal var _autoLapList:feathers.data.ListCollection;

        internal var _lapList:feathers.data.ListCollection;

        internal var _redrawFlag:Boolean=true;

        internal var _655379712contentHeight:Number;

        internal var lapDetailsGroup:frontend.screen.activities.tabs.laps.ActivityLapDetailsView;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


