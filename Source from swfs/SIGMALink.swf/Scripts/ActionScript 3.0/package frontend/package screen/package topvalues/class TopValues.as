//class TopValues
package frontend.screen.topvalues 
{
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.activities.*;
    import core.sport.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.data.*;
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
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
    import frontend.screen.activities.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.*;
    import frontend.screen.topvalues.list.*;
    import handler.*;
    import init.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import statistic.*;
    import utils.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class TopValues extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function TopValues()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._selectedYear = new Date().fullYear;
            this._1797417381_buttonIconOffsetX = 52 * SIGMALink.scaleFactor;
            this._1495257986_buttonLabelOffsetX = -52 * SIGMALink.scaleFactor;
            this._1495257987_buttonLabelOffsetY = 2 * SIGMALink.scaleFactor;
            this._1684178472_listDataProvider = new feathers.data.HierarchicalCollection();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._TopValues_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_topvalues_TopValuesWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TopValues[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._TopValues_ListLoader1_i(), this._TopValues_Footer1_i()];
            this.addEventListener("addedToStage", this.___TopValues_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___TopValues_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set yearSelection(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._160103887yearSelection;
            if (loc1 !== arg1) 
            {
                this._160103887yearSelection = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "yearSelection", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set selectedYear(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.selectedYear;
            if (loc1 !== arg1) 
            {
                this._1754322568selectedYear = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "selectedYear", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _buttonIconOffsetX():Number
        {
            return this._1797417381_buttonIconOffsetX;
        }

        internal function set _buttonIconOffsetX(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1797417381_buttonIconOffsetX;
            if (loc1 !== arg1) 
            {
                this._1797417381_buttonIconOffsetX = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_buttonIconOffsetX", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get selectedYear():int
        {
            return configCache.ConfigCache.getInstance().getValue(SELECTED_YEAR_FROM_CACHE, this._selectedYear);
        }

        internal function set _1754322568selectedYear(arg1:int):void
        {
            this._selectedYear = arg1;
            configCache.ConfigCache.getInstance().setValue(SELECTED_YEAR_FROM_CACHE, this._selectedYear);
            return;
        }

        internal function _TopValues_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        internal function get _buttonLabelOffsetX():Number
        {
            return this._1495257986_buttonLabelOffsetX;
        }

        internal function set _buttonLabelOffsetX(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1495257986_buttonLabelOffsetX;
            if (loc1 !== arg1) 
            {
                this._1495257986_buttonLabelOffsetX = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_buttonLabelOffsetX", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _buttonLabelOffsetY():Number
        {
            return this._1495257987_buttonLabelOffsetY;
        }

        internal function get _listDataProvider():feathers.data.HierarchicalCollection
        {
            return this._1684178472_listDataProvider;
        }

        internal function set _listDataProvider(arg1:feathers.data.HierarchicalCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1684178472_listDataProvider;
            if (loc1 !== arg1) 
            {
                this._1684178472_listDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_listDataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _topValuesList():feathers.controls.GroupedList
        {
            return this._1348856342_topValuesList;
        }

        internal function set _topValuesList(arg1:feathers.controls.GroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1348856342_topValuesList;
            if (loc1 !== arg1) 
            {
                this._1348856342_topValuesList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_topValuesList", loc1, arg1, this);
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
            TopValues._watcherSetupUtil = arg1;
            return;
        }

        internal function itemRenderer():feathers.controls.renderers.IGroupedListItemRenderer
        {
            return new frontend.screen.topvalues.list.TopValuesListRenderer();
        }

        internal function headerRendererFactory():feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
        {
            return new frontend.screen.topvalues.list.TopValuesListHeaderRenderer();
        }

        internal function footerRendererFactory():feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
        {
            return new frontend.screen.topvalues.list.TopValuesListFooterRenderer();
        }

        internal function onInit():void
        {
            this._topValuesList = new feathers.controls.GroupedList();
            this._topValuesList.autoHideBackground = true;
            this._topValuesList.dataProvider = this._listDataProvider;
            this._topValuesList.footerRendererFactory = this.footerRendererFactory;
            this._topValuesList.headerField = "header";
            this._topValuesList.headerRendererFactory = this.headerRendererFactory;
            this._topValuesList.height = SIGMALink.containerHeight;
            this._topValuesList.itemRendererFactory = this.itemRenderer;
            this._topValuesList.width = SIGMALink.appWidth;
            this._topValuesList.addEventListener(starling.events.TouchEvent.TOUCH, this.onListTouch);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.RELOAD, this.activityEventHandler);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.DELETE, this.activityEventHandler);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.UPDATE, this.activityEventHandler);
            this._yearsWithData = new feathers.data.ListCollection(handler.ApplicationHandler.getInstance().yearsWithData);
            this.loadTopValues(this.selectedYear);
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onSpeedFormatChanged(arg1:starling.events.Event):void
        {
            this.loadTopValues(this.selectedYear);
            return;
        }

        internal function activityEventHandler(arg1:frontend.screen.activities.list.ActivityListEvent):void
        {
            this._yearsWithData = new feathers.data.ListCollection(handler.ApplicationHandler.getInstance().yearsWithData);
            this.loadTopValues(this.selectedYear);
            return;
        }

        protected function addedToStageHandler(arg1:starling.events.Event):void
        {
            this._topValuesList.selectedItem = null;
            return;
        }

        internal function onYearsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onYearsError");
            this.selectedYear = new Date().fullYear;
            this.loadTopValues(this.selectedYear);
            return;
        }

        internal function loadTopValues(arg1:int):void
        {
            this.listLoader.startLoading();
            backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.READ, handler.ActivityHandler.getInstance().generateTopValuesStatement(arg1), this.onTopValuesComplete, this.onTopValuesError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function onTopValuesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=0;
            var loc6:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            this._listDataProvider = new feathers.data.HierarchicalCollection();
            if (this._topValuesList != null) 
            {
                this._topValuesList.dataProvider = this._listDataProvider;
            }
            this.yearSelection.label = this.selectedYear.toString();
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            var loc5:*=statistic.Statistic.TOP_VALUES.length;
            var loc7:*=new flash.utils.Dictionary();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc8 = loc1[loc2];
                loc11 = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(loc8.sportId);
                if (loc7[loc8.sportId]) 
                {
                    loc9 = loc7[loc8.sportId];
                }
                else 
                {
                    loc9 = new frontend.screen.topvalues.list.TopValuesListGroup(frontend.Textures.sportTextureByKeyName(loc11.keyName), loc11.color);
                    loc7[loc8.sportId] = loc9;
                    this._listDataProvider.addItemAt(loc9, (this._listDataProvider.data as Array).length);
                }
                loc10 = new frontend.screen.topvalues.list.TopValuesListItem();
                loc10.activityId = loc8.activityId;
                loc10.date = backend.utils.DataUtils.dateFormatter.format(loc8.startDate as Date);
                loc4 = 0;
                while (loc4 < loc5) 
                {
                    loc6 = statistic.Statistic.TOP_VALUES[loc4].value;
                    if (loc8.hasOwnProperty(loc6)) 
                    {
                        loc10.title = statistic.Statistic.TOP_VALUES[loc4].label;
                        loc10.field = loc6;
                        var loc12:*=loc6;
                        switch (loc12) 
                        {
                            case statistic.Statistic.MAX_SPEED:
                            {
                                if (configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc11) != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
                                {
                                    loc10.value = backend.utils.DataUtils.timeFormatter_MM_SS.format(backend.utils.DataUtils.speedTimeConverter.convert(loc8[loc6]));
                                    loc10.unit = backend.utils.DataUtils.unitStringSpeedTime;
                                }
                                else 
                                {
                                    loc10.value = backend.utils.DataUtils.speedFormatter.format(backend.utils.DataUtils.speedConverter.convert(loc8[loc6]));
                                    loc10.unit = backend.utils.DataUtils.unitStringSpeed;
                                }
                                loc10.iconSource = frontend.Textures.IconSpeed;
                                break;
                            }
                            case statistic.Statistic.DISTANCE:
                            {
                                loc10.value = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc8[loc6]));
                                loc10.unit = backend.utils.DataUtils.unitStringDistance;
                                loc10.iconSource = frontend.Textures.strecke;
                                break;
                            }
                            case statistic.Statistic.TRAINING_TIME:
                            {
                                loc10.value = backend.utils.DataUtils.timeFormatter.format(loc8[loc6]);
                                loc10.unit = backend.utils.DataUtils.unitStringTimeHours;
                                loc10.iconSource = frontend.Textures.laengstezeit;
                                break;
                            }
                            case statistic.Statistic.CALORIES:
                            {
                                loc10.value = backend.utils.DataUtils.caloriesFormatter.format(loc8[loc6]);
                                loc10.unit = backend.utils.DataUtils.unitStringCalories;
                                loc10.iconSource = frontend.Textures.kcal;
                                break;
                            }
                            case statistic.Statistic.ALTITUDE_UPHILL:
                            {
                                loc10.value = backend.utils.DataUtils.altitudeFormatter.format(backend.utils.DataUtils.altitudeConverter.convert(loc8[loc6]));
                                loc10.unit = backend.utils.DataUtils.unitStringAltitude;
                                loc10.iconSource = frontend.Textures.hohenmeter;
                                break;
                            }
                        }
                        loc9.addItem(loc10);
                        break;
                    }
                    ++loc4;
                }
                ++loc2;
            }
            this.listLoader.stopLoading();
            return;
        }

        internal function onTopValuesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onTopValuesError");
            return;
        }

        internal function onListTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=this._topValuesList.selectedItem as frontend.screen.topvalues.list.TopValuesListItem;
            if (loc1) 
            {
                frontend.screen.activities.ActivitiesList.loadActivity(loc1.activityId);
            }
            return;
        }

        internal function onCalenderIconClick(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (!this._yearSelectEditor) 
            {
                loc1 = new frontend.components.menuList.editors.SpinnerEditor();
                loc1.title = utils.LanguageManager.getString("TOP_VALUES.YEAR_SELECT");
                loc1.rightHeaderText = utils.LanguageManager.getString("TOP_VALUES.YEAR_SELECT_CONFIRM");
                loc1.saveCompleteCallback = this.onYearSelectComplete;
                loc1.dataProvider = this._yearsWithData;
                loc1.rawValue = this.selectedYear.toString();
            }
            loc1.dataProvider = this._yearsWithData;
            frontend.components.popup.PopUpBase.showModalPopUp(loc1, true, false);
            return;
        }

        internal function onYearSelectComplete(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.selectedYear = int(arg2.rawValue);
            this.loadTopValues(this.selectedYear);
            return;
        }

        internal function set _buttonLabelOffsetY(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1495257987_buttonLabelOffsetY;
            if (loc1 !== arg1) 
            {
                this._1495257987_buttonLabelOffsetY = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_buttonLabelOffsetY", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _TopValues_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._TopValues_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _TopValues_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.verticalAlign = "middle";
            loc1.id = "yearSelection";
            this.yearSelection = loc1;
            feathers.binding.BindingManager.executeBindings(this, "yearSelection", this.yearSelection);
            return loc1;
        }

        public function ___TopValues_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        public function ___TopValues_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _TopValues_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TOP_VALUES.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "listLoader.height")
            result[2] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _topValuesList;
            }, null, "listLoader.list")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return _buttonIconOffsetX;
            }, null, "yearSelection.iconOffsetX")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.calendericon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "yearSelection.image")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=selectedYear.toString();
                return loc1 != undefined ? String(loc1) : null;
            }, null, "yearSelection.label")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return _buttonLabelOffsetX;
            }, null, "yearSelection.labelOffsetX")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return _buttonLabelOffsetY;
            }, null, "yearSelection.labelOffsetY")
            result[9] = new feathers.binding.Binding(this, function ():Function
            {
                return onCalenderIconClick;
            }, null, "yearSelection.touchHandler")
            return result;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get listLoader():frontend.components.list.ListLoader
        {
            return this._159473233listLoader;
        }

        public function set listLoader(arg1:frontend.components.list.ListLoader):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._159473233listLoader;
            if (loc1 !== arg1) 
            {
                this._159473233listLoader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listLoader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get yearSelection():frontend.components.button.IconButton
        {
            return this._160103887yearSelection;
        }

        public static const SELECTED_YEAR_FROM_CACHE:String="topValuesSelectedYear";

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        internal var _160103887yearSelection:frontend.components.button.IconButton;

        internal var _selectedYear:int;

        internal var _1495257986_buttonLabelOffsetX:Number;

        internal var _1495257987_buttonLabelOffsetY:Number;

        internal var _firstAddedToStage:Boolean=true;

        internal var _1684178472_listDataProvider:feathers.data.HierarchicalCollection;

        internal var _selectedActivity:core.activities.Activity;

        internal var _1348856342_topValuesList:feathers.controls.GroupedList;

        internal var _yearSelectEditor:frontend.components.menuList.editors.SpinnerEditor;

        internal var _yearsWithData:feathers.data.ListCollection;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _1797417381_buttonIconOffsetX:Number;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


