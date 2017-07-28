//package tabs
//  class TracksInformation
package frontend.screen.tracks.tabs.track.tabs 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.route.*;
    import core.sport.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
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
    import frontend.components.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.component.*;
    import frontend.screen.tracks.tabs.list.*;
    import handler.*;
    import handler.event.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class TracksInformation extends frontend.components.tabbarbase.TabLayoutScroller implements feathers.binding.IBindingClient
    {
        public function TracksInformation()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._3766vl = new feathers.layout.VerticalLayout();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._TracksInformation_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_track_tabs_TracksInformationWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TracksInformation[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.addEventListener("addedToStage", this.___TracksInformation_TabLayoutScroller1_addedToStage);
            this.addEventListener("removedFromStage", this.___TracksInformation_TabLayoutScroller1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function get routeDate():String
        {
            return this._167168407routeDate;
        }

        public function get myRoute():core.route.Route
        {
            return this._myRoute;
        }

        internal function set _1496932349myRoute(arg1:core.route.Route):void
        {
            this._myRoute = arg1;
            if (this._myRoute) 
            {
                this.validateValues();
            }
            return;
        }

        internal function set routeDate(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._167168407routeDate;
            if (loc1 !== arg1) 
            {
                this._167168407routeDate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeDate", loc1, arg1, this);
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

        internal function get routeAltitudeDifferencesDownhill():String
        {
            return this._1582889166routeAltitudeDifferencesDownhill;
        }

        internal function set routeAltitudeDifferencesDownhill(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1582889166routeAltitudeDifferencesDownhill;
            if (loc1 !== arg1) 
            {
                this._1582889166routeAltitudeDifferencesDownhill = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeAltitudeDifferencesDownhill", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get routeDistance():String
        {
            return this._566736546routeDistance;
        }

        internal function onAddedToStage():void
        {
            this.vl.gap = 1 * SIGMALink.scaleFactor;
            handler.RouteHandler.getInstance().addEventListener(handler.RouteHandlerCommon.ROUTE_POINTS_LOADED, this.onRoutePointsLoaded);
            return;
        }

        internal function set routeDistance(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._566736546routeDistance;
            if (loc1 !== arg1) 
            {
                this._566736546routeDistance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeDistance", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get vl():feathers.layout.VerticalLayout
        {
            return this._3766vl;
        }

        internal function get routeAltitudeDifferencesUphill():String
        {
            return this._1012859641routeAltitudeDifferencesUphill;
        }

        internal function set routeAltitudeDifferencesUphill(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1012859641routeAltitudeDifferencesUphill;
            if (loc1 !== arg1) 
            {
                this._1012859641routeAltitudeDifferencesUphill = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeAltitudeDifferencesUphill", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get routeRating():uint
        {
            return this._2135864646routeRating;
        }

        internal function set routeRating(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2135864646routeRating;
            if (loc1 !== arg1) 
            {
                this._2135864646routeRating = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeRating", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get routeCategorie():String
        {
            return this._824561902routeCategorie;
        }

        internal function set routeCategorie(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._824561902routeCategorie;
            if (loc1 !== arg1) 
            {
                this._824561902routeCategorie = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "routeCategorie", loc1, arg1, this);
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
            TracksInformation._watcherSetupUtil = arg1;
            return;
        }

        internal function onRemovedFromStage():void
        {
            handler.RouteHandler.getInstance().removeEventListener(handler.RouteHandlerCommon.ROUTE_POINTS_LOADED, this.onRoutePointsLoaded);
            return;
        }

        internal function onRoutePointsLoaded(arg1:handler.event.RouteEvent):void
        {
            if (arg1.route == this._myRoute) 
            {
                this.routeDistance = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.myRoute.distance));
                this.routeRating = this.myRoute.rating;
                this.routeAltitudeDifferencesDownhill = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.myRoute.altitudeDifferencesUphill));
                this.routeAltitudeDifferencesUphill = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.myRoute.altitudeDifferencesDownhill));
                this.routeDate = new Date(this.myRoute.creationTimestamp).toDateString();
                handler.RouteHandlerCommon.getInstance().calculateDistances(this.myRoute, true);
                this.chart.entries = handler.RouteHandlerCommon.getInstance().altitudeProfileDP;
            }
            return;
        }

        internal function addChart():void
        {
            this.chart = new frontend.screen.activities.component.ActivityGraphComp();
            this.chart.yAchseLabel = backend.utils.DataUtils.altitudeLabel + " [" + backend.utils.DataUtils.unitStringAltitude + "]";
            this.chart.yLabelConverter = backend.utils.DataUtils.altitudeConverter;
            this.chart.yLabelFormatter = backend.utils.DataUtils.altitudeFormatter;
            this.chart.yValueName = "altitude";
            this.chart.xValueName = "distance";
            this.chart.graphColor = core.general.Colors.ALTITUDE;
            this.chart.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            addChildAt(this.chart, 5);
            return;
        }

        protected function validateValues():void
        {
            removeChildren();
            this.addListItem("TRACKS_INFO_NAME", core.route.Route.COL_NAME, this.myRoute.name, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD);
            this.addRatingItem();
            this.addListItemNumberInput("TRACKS_INFO_DISTANCE", core.route.Route.COL_DISTANCE, this.myRoute.distance, 0, 0, backend.utils.DataUtils.distanceFormatter, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.unitStringDistance, false);
            this.addListItemNumberInput("TRACKS_INFO_ALTI_UP", core.route.Route.COL_ALTITUDE_DIFFERENCES_UPHILL, this.myRoute.altitudeDifferencesUphill, 0, 0, backend.utils.DataUtils.altitudeFormatter, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.unitStringAltitude, false);
            this.addListItemNumberInput("TRACKS_INFO_ALTI_DOWN", core.route.Route.COL_ALTITUDE_DIFFERENCES_UPHILL, this.myRoute.altitudeDifferencesDownhill, 0, 0, backend.utils.DataUtils.altitudeFormatter, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.unitStringAltitude, false);
            this.addChart();
            this.addCategoriesItem();
            this.addSuitableForItem();
            this.addListItemDateInput("TRACKS_INFO_CREATION_DATE", core.route.Route.COL_CREATIONTIMESTAMP, this.myRoute.creationTimestamp, 0, 0, backend.utils.DataUtils.dateFormatter, false);
            this.modificationItem = this.addListItemDateInput("TRACKS_INFO_LAST_MODIFICATION", core.route.Route.COL_MODIFICATION_DATE, this.myRoute.modificationDate, 0, 0, backend.utils.DataUtils.dateFormatter, false);
            this.addDescriptionItem();
            return;
        }

        internal function validateModificationItem():void
        {
            this.modificationItem.value = this.myRoute.modificationDate;
            return;
        }

        internal function addRatingItem():void
        {
            this.ratingItem = new frontend.components.menuList.MenuListItem();
            var loc1:*;
            this.ratingItem.title = loc1 = "TRACKS_INFO_RATING";
            this.ratingItem.text = loc1;
            this.ratingItem.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            this.ratingItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING;
            this.ratingItem.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this.ratingItem.saveCompleteCallback = this.onRatingChanged;
            this.ratingItem.saveToDbUseUpdate = false;
            this.ratingItem.useConfigCache = false;
            this.ratingItem.useLocalesForText = true;
            this.ratingItem.useLocalesForTitle = true;
            this.ratingItem.defaultValue = this.myRoute.rating;
            addChild(this.ratingItem);
            this.validateRatingItem();
            return;
        }

        internal function validateRatingItem():void
        {
            this.ratingItem.customLayoutContent.removeChildren();
            this.ratingItem.customLayoutContent.visible = true;
            this.ratingItem.customLayoutContent.includeInLayout = true;
            this.ratingItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.paddingRight = this.ratingItem.padding;
            this.ratingItem.customLayoutContent.layout = loc1;
            this.ratingItem.customLayoutContent.addChild(frontend.components.menuList.editors.RatingEditor.drawContent(this.myRoute.rating));
            return;
        }

        internal function onRatingChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.myRoute.rating = arg2.rawValue as int;
            this.validateRatingItem();
            this.updateRouteInDB();
            return;
        }

        internal function updateRouteInDB():void
        {
            this.myRoute.modificationDate = new Date().time;
            var loc1:*="UPDATE " + core.route.Route.TABLE_NAME + " SET " + core.route.Route.COL_RATING + " = " + this.myRoute.rating + ", " + core.route.Route.COL_MODIFICATION_DATE + " = " + this.myRoute.modificationDate + " WHERE " + core.route.Route.COL_ROUTE_ID + " = " + this.myRoute.routeId;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onRatingChangedComplete, this.onRatingChangedError);
            return;
        }

        internal function onRatingChangedComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.validateModificationItem();
            return;
        }

        internal function onRatingChangedError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onRatingChangedError");
            return;
        }

        internal function addDescriptionItem():void
        {
            this.descriptionItem = new frontend.components.menuList.MenuListItem();
            this.descriptionItem.leftLabelAlignTop = true;
            this.descriptionItem.text = "TRACKS_INFO_DESCRIPTION";
            this.descriptionItem.title = "TRACKS_INFO_DESCRIPTION";
            this.descriptionItem.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            this.descriptionItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA;
            this.descriptionItem.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL * 2;
            this.descriptionItem.saveToDbUseUpdate = true;
            this.descriptionItem.saveToDbUseUpdateObject = this.getDBObject(core.route.Route.COL_DESCRIPTION);
            this.descriptionItem.useConfigCache = false;
            this.descriptionItem.useLocalesForText = true;
            this.descriptionItem.useLocalesForTitle = true;
            this.descriptionItem.saveCompleteCallback = this.onDescriptionChanged;
            this.descriptionItem.defaultValue = this.myRoute.description;
            this.descriptionItem.height = SIGMALink.appHeight / 2;
            addChild(this.descriptionItem);
            this.descriptionItem.leftLabel.layoutData = new feathers.layout.AnchorLayoutData(this.descriptionItem.padding, NaN, NaN, this.descriptionItem.padding);
            this.descriptionItem.rightLabel.layoutData = new feathers.layout.AnchorLayoutData(frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL, this.descriptionItem.padding, this.descriptionItem.padding, this.descriptionItem.padding);
            return;
        }

        internal function onDescriptionChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.myRoute[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
            this.descriptionItem.defaultValue = arg2.rawValue;
            this.descriptionItem.rightLabel.text = arg2.rawValue as String;
            this.validateModificationItem();
            return;
        }

        internal function addCategoriesItem():void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=false;
            var loc1:*=[];
            loc4 = this.myRoute.routeOptions.length;
            loc3 = 0;
            while (loc3 < loc4) 
            {
                loc1[loc1.length] = this.myRoute.routeOptions[loc3];
                ++loc3;
            }
            var loc2:*=backend.utils.dataprovider.RouteOptionsDataProvider.getCharacteristicsDataProvider();
            loc4 = loc2.length;
            var loc5:*=new feathers.data.ListCollection();
            loc3 = 0;
            while (loc3 < loc4) 
            {
                loc6 = loc2.getItemAt(loc3);
                loc8 = loc1.length;
                loc9 = false;
                loc7 = 0;
                while (loc7 < loc8) 
                {
                    if ((loc1[loc7] as core.route.RouteOptions).param == loc6.param) 
                    {
                        loc9 = true;
                        break;
                    }
                    ++loc7;
                }
                loc5.push({"label":loc6.label, "data":loc6.param, "selected":loc9});
                ++loc3;
            }
            this.categoriesItem = new frontend.components.menuList.MenuListItem();
            this.categoriesItem.leftLabelAlignTop = true;
            var loc10:*;
            this.categoriesItem.title = loc10 = "TRACKS_INFO_CATEGORY";
            this.categoriesItem.text = loc10;
            this.categoriesItem.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            this.categoriesItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING;
            this.categoriesItem.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this.categoriesItem.saveCompleteCallback = this.onRouteCategoriesChanged;
            this.categoriesItem.saveToDbUseUpdate = false;
            this.categoriesItem.useConfigCache = false;
            this.categoriesItem.useLocalesForText = true;
            this.categoriesItem.useLocalesForTitle = true;
            this.categoriesItem.dataProvider = loc5;
            this.categoriesItem.defaultValues = loc1;
            addChild(this.categoriesItem);
            this.validateCategoriesItem();
            return;
        }

        internal function validateCategoriesItem():void
        {
            var loc3:*=0;
            var loc7:*=null;
            this.categoriesItem.customLayoutContent.removeChildren();
            this.categoriesItem.customLayoutContent.visible = true;
            this.categoriesItem.customLayoutContent.includeInLayout = true;
            this.categoriesItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.requestedColumnCount = 3;
            loc1.useSquareTiles = false;
            loc1.horizontalGap = this.categoriesItem.padding;
            loc1.verticalGap = this.categoriesItem.padding;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.tileHorizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.paddingRight = this.categoriesItem.padding;
            var loc2:*=new frontend.components.PropertyLabel();
            loc2.text = "XXXXXXXXX";
            loc2.validate();
            loc1.typicalItem = loc2;
            loc1.typicalItemHeight = loc2.height;
            loc1.typicalItemWidth = loc2.width;
            var loc4:*=this.categoriesItem.dataProvider.length;
            var loc5:*=[];
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (this.categoriesItem.dataProvider.getItemAt(loc3).selected) 
                {
                    loc7 = new frontend.components.PropertyLabel();
                    loc7.property = this.categoriesItem.dataProvider.getItemAt(loc3);
                    loc7.text = loc7.property.label;
                    loc7.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUVALUE;
                    this.categoriesItem.customLayoutContent.addChild(loc7);
                }
                ++loc3;
            }
            var loc6:*=Math.min(this.categoriesItem.customLayoutContent.numChildren, loc1.requestedColumnCount);
            this.categoriesItem.customLayoutContent.width = loc6 * loc1.typicalItemWidth + (loc6 + 1) * this.categoriesItem.padding;
            loc1.requestedRowCount = Math.max(1, Math.ceil(this.categoriesItem.customLayoutContent.numChildren / loc1.requestedColumnCount));
            this.categoriesItem.customLayoutContent.layout = loc1;
            this.categoriesItem.height = loc1.requestedRowCount * this.categoriesItem.minItemHeight;
            this.categoriesItem.customLayoutContent.height = this.categoriesItem.height;
            return;
        }

        internal function onRouteCategoriesChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            debug.Debug.debug("onRouteCategoriesChanged");
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.route.RouteOptions.generateDBDeleteAllCategories(this.myRoute.routeId), this.onDeleteRouteCategoriesComplete, this.onDeleteRouteCategoriesError, null, arg2);
            return;
        }

        internal function onDeleteRouteCategoriesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=0;
            var loc4:*=null;
            var loc5:*=null;
            this.myRoute.routeOptions = new Vector.<core.route.RouteOptions>();
            var loc2:*=this.categoriesItem.dataProvider.length;
            var loc3:*=[];
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (this.categoriesItem.dataProvider.getItemAt(loc1).selected) 
                {
                    loc4 = new core.route.RouteOptions();
                    loc4.param = this.categoriesItem.dataProvider.getItemAt(loc1).data;
                    loc4.routeId = this.myRoute.routeId;
                    this.myRoute.routeOptions.push(loc4);
                    loc5 = new backend.utils.dbUtils.DBUtilObject();
                    loc5.stmt = loc4.generateDBInsert().text;
                    loc3.push(loc5);
                }
                ++loc1;
            }
            if (loc3.length > 0) 
            {
                backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc3, this.onInsertRouteCategoryComplete, this.onInsertRouteCategoryError, null);
            }
            else 
            {
                this.onInsertRouteOptionComplete();
            }
            return;
        }

        internal function onInsertRouteCategoryComplete(arg1:backend.utils.dbUtils.DBUtilEvent=null):void
        {
            debug.Debug.debug("onInsertRouteCategoryComplete");
            this.validateCategoriesItem();
            this.updateRouteInDB();
            return;
        }

        internal function onInsertRouteCategoryError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertRouteCategoryError");
            return;
        }

        internal function onDeleteRouteCategoriesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteRouteCategoriesError");
            return;
        }

        internal function addSuitableForItem():void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=false;
            var loc1:*=[];
            loc4 = this.myRoute.routeOptions.length;
            loc3 = 0;
            while (loc3 < loc4) 
            {
                loc1[loc1.length] = this.myRoute.routeOptions[loc3];
                ++loc3;
            }
            var loc2:*=backend.utils.dataprovider.RouteOptionsDataProvider.getSuitableDataProvider();
            loc4 = loc2.length;
            var loc5:*=new feathers.data.ListCollection();
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (loc2.getItemAt(loc3).selectable) 
                {
                    loc6 = handler.SportHandler.getInstance().resolveSportById(loc2.getItemAt(loc3).sportId);
                    loc8 = loc1.length;
                    loc9 = false;
                    loc7 = 0;
                    while (loc7 < loc8) 
                    {
                        if ((loc1[loc7] as core.route.RouteOptions).sportId == loc6.sportId) 
                        {
                            loc9 = true;
                            break;
                        }
                        ++loc7;
                    }
                    loc5.push({"label":loc6.name, "data":loc6.sportId, "param":loc2.getItemAt(loc3).param, "selected":loc9});
                }
                ++loc3;
            }
            this.sportsItem = new frontend.components.menuList.MenuListItem();
            this.sportsItem.leftLabelAlignTop = true;
            var loc10:*;
            this.sportsItem.title = loc10 = "TRACKS_INFO_SPORTS";
            this.sportsItem.text = loc10;
            this.sportsItem.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            this.sportsItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT;
            this.sportsItem.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this.sportsItem.saveCompleteCallback = this.onRouteSportsChanged;
            this.sportsItem.saveToDbUseUpdate = false;
            this.sportsItem.useConfigCache = false;
            this.sportsItem.useLocalesForText = true;
            this.sportsItem.useLocalesForTitle = true;
            this.sportsItem.dataProvider = loc5;
            this.sportsItem.defaultValues = loc1;
            addChild(this.sportsItem);
            this.validateSportsItem();
            return;
        }

        internal function validateSportsItem():void
        {
            var loc3:*=0;
            var loc6:*=null;
            this.sportsItem.customLayoutContent.removeChildren();
            this.sportsItem.customLayoutContent.visible = true;
            this.sportsItem.customLayoutContent.includeInLayout = true;
            this.sportsItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.requestedColumnCount = 3;
            loc1.useSquareTiles = false;
            loc1.horizontalGap = this.sportsItem.padding;
            loc1.verticalGap = this.sportsItem.padding;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.paddingRight = this.sportsItem.padding;
            var loc2:*=new frontend.components.SportIcon();
            loc2.sportId = 1;
            loc2.validate();
            loc1.typicalItem = loc2;
            loc1.typicalItemHeight = loc2.height;
            loc1.typicalItemWidth = loc2.width;
            this.sportsItem.customLayoutContent.width = loc1.requestedColumnCount * loc1.typicalItemWidth + (loc1.requestedColumnCount + 1) * this.sportsItem.padding;
            var loc4:*=this.sportsItem.dataProvider.length;
            var loc5:*=[];
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (this.sportsItem.dataProvider.getItemAt(loc3).selected) 
                {
                    loc6 = new frontend.components.SportIcon();
                    loc6.sportId = this.sportsItem.dataProvider.getItemAt(loc3).data;
                    this.sportsItem.customLayoutContent.addChild(loc6);
                }
                ++loc3;
            }
            loc1.requestedRowCount = Math.max(1, Math.ceil(this.sportsItem.customLayoutContent.numChildren / loc1.requestedColumnCount));
            this.sportsItem.customLayoutContent.layout = loc1;
            this.sportsItem.height = loc1.requestedRowCount * this.sportsItem.minItemHeight;
            this.sportsItem.customLayoutContent.height = this.sportsItem.height;
            return;
        }

        internal function onRouteSportsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.route.RouteOptions.generateDBDeleteAllSports(this.myRoute.routeId), this.onDeleteRouteOptionsComplete, this.onDeleteRouteOptionsError, null, arg2);
            return;
        }

        internal function onDeleteRouteOptionsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=0;
            var loc4:*=null;
            var loc5:*=null;
            this.myRoute.routeOptions = new Vector.<core.route.RouteOptions>();
            var loc2:*=this.sportsItem.dataProvider.length;
            var loc3:*=[];
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (this.sportsItem.dataProvider.getItemAt(loc1).selected) 
                {
                    loc4 = new core.route.RouteOptions();
                    loc4.param = this.sportsItem.dataProvider.getItemAt(loc1).param;
                    loc4.routeId = this.myRoute.routeId;
                    this.myRoute.routeOptions.push(loc4);
                    loc5 = new backend.utils.dbUtils.DBUtilObject();
                    loc5.stmt = loc4.generateDBInsert().text;
                    loc3.push(loc5);
                }
                ++loc1;
            }
            if (loc3.length > 0) 
            {
                backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc3, this.onInsertRouteOptionComplete, this.onInsertRouteOptionError, null);
            }
            else 
            {
                this.onInsertRouteOptionComplete();
            }
            return;
        }

        internal function onInsertRouteOptionComplete(arg1:backend.utils.dbUtils.DBUtilEvent=null):void
        {
            debug.Debug.debug("onInsertRouteOptionComplete");
            this.validateSportsItem();
            this.updateRouteInDB();
            return;
        }

        internal function onDeleteRouteOptionsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertRouteOptionError");
            return;
        }

        internal function onInsertRouteOptionError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertRouteOptionError");
            return;
        }

        protected function addListItem(arg1:String, arg2:String, arg3:Object, arg4:String, arg5:feathers.data.ListCollection=null, arg6:utils.interfaces.ICustomFormatter=null, arg7:Boolean=false, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = this.myRoute.loadedFrom == core.route.Route.LOADED_FROM_DATABASE;
            loc1.type = arg4;
            loc1.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.saveToDbUseUpdateObject.dateAsString = arg7;
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.saveCompleteCallback = this.onRouteChanged;
            loc1.unitString = arg8;
            if (arg4 != frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE) 
            {
                if (arg5) 
                {
                    loc1.dataProvider = arg5;
                }
                loc1.defaultValue = arg3;
            }
            else 
            {
                loc1.checkable = true;
                loc1.checked = arg3;
            }
            if (arg6) 
            {
                loc1.formatter = arg6;
            }
            addChild(loc1);
            return loc1;
        }

        protected function addListItemNumberInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:utils.converter.IConverter=null, arg8:String="", arg9:Boolean=true):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = arg9;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER;
            loc1.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.saveCompleteCallback = this.onRouteChanged;
            loc1.defaultValue = arg3;
            loc1.formatter = arg6;
            loc1.converter = arg7;
            loc1.minimum = arg4;
            loc1.maximum = arg5;
            loc1.unitString = arg8;
            addChild(loc1);
            return loc1;
        }

        protected function addListItemDateInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=true):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = arg1;
            loc1.title = arg1;
            loc1.editable = arg7;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE;
            loc1.minItemHeight = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.getDBObject(arg2);
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.saveCompleteCallback = this.onRouteChanged;
            loc1.defaultValue = arg3;
            loc1.formatter = arg6;
            loc1.minimum = arg4;
            loc1.maximum = arg5;
            addChild(loc1);
            return loc1;
        }

        protected function getDBObject(arg1:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=new frontend.components.menuList.MenuListDbObject();
            loc1.keyField = core.route.Route.COL_GUID;
            loc1.keyValue = this.myRoute.GUID;
            loc1.updateField = arg1;
            loc1.table = core.route.Route.TABLE_NAME;
            loc1.updateModificationDate = true;
            return loc1;
        }

        protected function onRouteChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.myRoute[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
            this.validateModificationItem();
            handler.RouteHandler.getInstance().dispatchEvent(new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.UPDATE, this.myRoute));
            handler.RouteHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        public function ___TracksInformation_TabLayoutScroller1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        public function ___TracksInformation_TabLayoutScroller1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage();
            return;
        }

        internal function _TracksInformation_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.MYTRACKS.TRACK.INFORMATION.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            return result;
        }

        internal function set vl(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3766vl;
            if (loc1 !== arg1) 
            {
                this._3766vl = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vl", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal const ROW_HEIGHT:Number=65 * SIGMALink.scaleFactor;

        public static const TAB_NAME:String="MYTRACKS_TRACK_INFORMATION";

        internal var _myRoute:core.route.Route;

        internal var categoriesItem:frontend.components.menuList.MenuListItem;

        internal var chart:frontend.screen.activities.component.ActivityGraphComp;

        internal var descriptionItem:frontend.components.menuList.MenuListItem;

        internal var modificationItem:frontend.components.menuList.MenuListItem;

        internal var _1582889166routeAltitudeDifferencesDownhill:String="";

        internal var _1012859641routeAltitudeDifferencesUphill:String="";

        internal var _824561902routeCategorie:String="";

        internal var _167168407routeDate:String="";

        internal var _566736546routeDistance:String="";

        internal var _2135864646routeRating:uint=0;

        internal var sportsItem:frontend.components.menuList.MenuListItem;

        internal var _3766vl:feathers.layout.VerticalLayout;

        internal var ratingItem:frontend.components.menuList.MenuListItem;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class TracksMap
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


