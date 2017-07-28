//class ActivitiesList
package frontend.screen.activities 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import core.sport.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.popup.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.*;
    import handler.*;
    import init.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ActivitiesList extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ActivitiesList()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.buttonCancel = new frontend.components.button.IconButton();
            this.buttonDelete = new frontend.components.button.IconButton();
            this.buttonEdit = new frontend.components.button.IconButton();
            this._358315832buttonLoad = new frontend.components.button.IconButton();
            this._1399580807listDataProvider = new feathers.data.HierarchicalCollection();
            this.shareIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.shareicon);
            this.sharedIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.sharedicon);
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivitiesList_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_ActivitiesListWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ActivitiesList[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ActivitiesList_ListLoader1_i(), this._ActivitiesList_Footer1_i()];
            this.addEventListener("addedToStage", this.___ActivitiesList_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___ActivitiesList_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ActivitiesList_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___ActivitiesList_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___ActivitiesList_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.initializeHandler(arg1);
            return;
        }

        internal function _ActivitiesList_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIESLIST.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "listLoader.height")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0, 0, SIGMALink.footerHeight, 0);
            }, null, "listLoader.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _activityList;
            }, null, "listLoader.list")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("NO_DATA_ACTIVITIES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "listLoader.noDataText")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
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

        internal function downloadActivities_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_TRANSFER, {"backScreenName":handler.ViewHandler.VIEW_ACTIVITIES_LIST}, handler.ViewHandler.slideToLeftTransition());
            return;
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

        internal function get _activityList():frontend.components.list.CustomGroupedList
        {
            return this._474914260_activityList;
        }

        internal function set _activityList(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._474914260_activityList;
            if (loc1 !== arg1) 
            {
                this._474914260_activityList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_activityList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get buttonLoad():frontend.components.button.IconButton
        {
            return this._358315832buttonLoad;
        }

        internal function set buttonLoad(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._358315832buttonLoad;
            if (loc1 !== arg1) 
            {
                this._358315832buttonLoad = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "buttonLoad", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function set listDataProvider(arg1:feathers.data.HierarchicalCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1399580807listDataProvider;
            if (loc1 !== arg1) 
            {
                this._1399580807listDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listDataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function loadActivity(arg1:int):void
        {
            var loc1:*=handler.ActivityHandler.getInstance().generateLoadActivityStatement(arg1);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, loadActivityComplete, loadActivityError, Workers.worker_DatabaseWorker);
            return;
        }

        internal static function loadActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activitiesError");
            return;
        }

        internal static function loadActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.getResult();
            if (loc1.length == 0) 
            {
                return;
            }
            _selectedActivity = core.activities.ActivityFactory.createLogFromDB(loc1[0], false);
            frontend.screen.activities.ActivityView.initialTabIndex = -1;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITY, {"activity":_selectedActivity}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal static function getGroupKey(arg1:Date):String
        {
            return arg1.fullYear + "_" + (arg1.month + 1);
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ActivitiesList._watcherSetupUtil = arg1;
            return;
        }

        internal function initializeHandler(arg1:starling.events.Event):void
        {
            this._activityList = new frontend.components.list.CustomGroupedList();
            this._activityList.footerField = "footer";
            this._activityList.footerRendererType = frontend.screen.activities.list.ActivityListItemFooterRenderer;
            this._activityList.headerField = "header";
            this._activityList.headerRendererType = frontend.screen.activities.list.ActivityListItemHeaderRenderer;
            this._activityList.height = SIGMALink.containerHeight;
            this._activityList.itemRendererType = frontend.screen.activities.list.ActivityListItemRenderer;
            this._activityList.layoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            this._activityList.stickyHeader = true;
            this._activityList.width = SIGMALink.appWidth;
            this._activityList.addEventListener(starling.events.TouchEvent.TOUCH, this.onListTouch);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.RELOAD, this.activityListEventHandler);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.UPDATE, this.activityListEventHandler);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.DELETE, this.activityListEventHandler);
            this.buttonLoad = new frontend.components.button.IconButton();
            this.buttonLoad.image = frontend.Textures.downloadbutton;
            this.buttonLoad.touchHandler = this.downloadActivities_handler;
            this.buttonEdit = new frontend.components.button.IconButton();
            this.buttonEdit.image = frontend.Textures.editbutton;
            this.buttonEdit.touchHandler = this.editActivities_handler;
            this.buttonDelete = new frontend.components.button.IconButton();
            this.buttonDelete.image = frontend.Textures.trashicon;
            this.buttonDelete.touchHandler = this.deleteActivities_handler;
            this.buttonCancel = new frontend.components.button.IconButton();
            this.buttonCancel.image = frontend.Textures.closeicon;
            this.buttonCancel.touchHandler = this.cancelEditActivities_handler;
            var loc1:*=handler.SportHandler.getInstance().resolveSportByKeyName(core.sport.Sport.CYCLING);
            var loc2:*=new Array();
            loc2.push({"activityId":1, "distance":"1,50 km", "name":"Activity-Name", "shared":false, "shareIcon":frontend.AssetsManagerCustom.getInstance().getTexture("shareIcon"), "sport":loc1, "sportBackgroundSkin":handler.SportHandler.getSportBackgroundSkin(loc1), "sportIcon":handler.SportHandler.getSportIcon(loc1), "startDate":new Date(), "trainingTime":"01:00:00 h"});
            loc2.push({"activityId":2, "distance":"15,50 km", "name":"Activity-Name 2", "shared":true, "shareIcon":frontend.AssetsManagerCustom.getInstance().getTexture("sharedIcon"), "sport":loc1, "sportBackgroundSkin":handler.SportHandler.getSportBackgroundSkin(loc1), "sportIcon":handler.SportHandler.getSportIcon(loc1), "startDate":new Date(), "trainingTime":"02:30:00 h"});
            this.typicalItem = {"header":{"date":"2016_1", "title":"JAN"}, "children":loc2, "footer":{"distance":22.5, "distanceIcon":frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalldistance), "length":2, "statisticIcon":frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmallcount), "trainingTime":36000, "timeIcon":frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalltime)}};
            this.setFooterButtons();
            return;
        }

        internal function activityListEventHandler(arg1:frontend.screen.activities.list.ActivityListEvent):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=0;
            var loc10:*=0;
            var loc1:*=this.listDataProvider.getLength();
            var loc11:*=arg1.type;
            switch (loc11) 
            {
                case frontend.screen.activities.list.ActivityListEvent.RELOAD:
                {
                    this.currentOffset = 0;
                    this.setVPosAfterReload = arg1.resetLastScrollPosition ? 0 : this._activityList.viewPort.verticalScrollPosition;
                    this._activityList.viewPort.verticalScrollPosition = 0;
                    this.listDataProvider.removeAll();
                    this._activityList.dataProvider = null;
                    this._activityList.selectedItem = null;
                    this.oldListGroupKey = "";
                    this.loadActivities(this.limit, this.currentOffset);
                    break;
                }
                case frontend.screen.activities.list.ActivityListEvent.UPDATE:
                case frontend.screen.activities.list.ActivityListEvent.DELETE:
                {
                    loc2 = 0;
                    while (loc2 < loc1) 
                    {
                        loc5 = this.listDataProvider.getItemAt(loc2) as frontend.screen.activities.list.ActivitiesListGroup;
                        loc4 = loc5.children.length;
                        loc3 = 0;
                        while (loc3 < loc4) 
                        {
                            loc6 = loc5.children[loc3] as frontend.screen.activities.list.ActivityListItem;
                            if (arg1.activity && loc6.activityId == arg1.activity.activityId || loc6.GUID == arg1.GUID) 
                            {
                                loc5.removeItem(loc3);
                                if (arg1.activity && arg1.type == frontend.screen.activities.list.ActivityListEvent.UPDATE) 
                                {
                                    loc7 = new frontend.screen.activities.list.ActivityListItem();
                                    loc7.startDate = arg1.activity.startDate;
                                    loc7.activityId = arg1.activity.activityId;
                                    loc7.GUID = arg1.activity.GUID;
                                    loc7.name = arg1.activity.name;
                                    loc7.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(arg1.activity.sportId);
                                    loc7.distance = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(arg1.activity.distance));
                                    loc7.distanceValue = arg1.activity.distance;
                                    loc7.trainingTime = backend.utils.DataUtils.timeFormatter.format(arg1.activity.trainingTime);
                                    loc7.trainingTimeValue = arg1.activity.trainingTime;
                                    loc7.shareIcon = arg1.activity.shared ? this.sharedIcon : this.shareIcon;
                                    loc7.sportIcon = handler.SportHandler.getSportIcon(loc7.sport);
                                    loc7.sportBackgroundSkin = handler.SportHandler.getSportBackgroundSkin(loc7.sport);
                                    loc8 = this.findGroup(arg1.activity);
                                    loc9 = this.findActivityIndex(loc8, arg1.activity);
                                    loc8.addItemAt(loc7, loc9);
                                    if (loc8 != loc5) 
                                    {
                                        loc10 = this.findGroupIndex(loc8);
                                        if (this.hasGroup(loc8)) 
                                        {
                                            this.listDataProvider.updateItemAt(loc10);
                                        }
                                        else 
                                        {
                                            this.listDataProvider.addItemAt(loc8, loc10);
                                        }
                                    }
                                }
                                if (loc5.children.length != 0) 
                                {
                                    this.listDataProvider.updateItemAt(loc2);
                                }
                                else 
                                {
                                    this.listDataProvider.removeItem(loc5);
                                }
                                this.listLoader.checkDataProvider();
                                return;
                            }
                            ++loc3;
                        }
                        ++loc2;
                    }
                    break;
                }
            }
            this.listLoader.checkDataProvider();
            return;
        }

        internal function findGroup(arg1:core.activities.Activity):frontend.screen.activities.list.ActivitiesListGroup
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=this.listDataProvider.getLength();
            var loc2:*=getGroupKey(arg1.startDate);
            loc4 = 0;
            while (loc4 < loc1) 
            {
                loc6 = this.listDataProvider.getItemAt(loc4) as frontend.screen.activities.list.ActivitiesListGroup;
                if (loc6.header.date == loc2) 
                {
                    loc3 = loc6;
                    break;
                }
                ++loc4;
            }
            if (!loc3) 
            {
                loc7 = this.getHeaderLabel(arg1.startDate);
                loc3 = new frontend.screen.activities.list.ActivitiesListGroup(loc2, loc7);
            }
            return loc3;
        }

        internal function findGroupIndex(arg1:frontend.screen.activities.list.ActivitiesListGroup):int
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=this.listDataProvider.getLength();
            var loc5:*=loc1;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc4 = this.listDataProvider.getItemAt(loc2) as frontend.screen.activities.list.ActivitiesListGroup;
                if (loc4.header.date != arg1.header.date) 
                {
                    if (loc4.header.date < arg1.header.date) 
                    {
                        loc5 = loc2;
                        break;
                    }
                }
                else 
                {
                    loc5 = loc2;
                    break;
                }
                ++loc2;
            }
            return loc5;
        }

        internal function hasGroup(arg1:frontend.screen.activities.list.ActivitiesListGroup):Boolean
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=this.listDataProvider.getLength();
            var loc5:*=false;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc4 = this.listDataProvider.getItemAt(loc2) as frontend.screen.activities.list.ActivitiesListGroup;
                if (loc4.header.date == arg1.header.date) 
                {
                    loc5 = true;
                    break;
                }
                ++loc2;
            }
            return loc5;
        }

        internal function findActivityIndex(arg1:frontend.screen.activities.list.ActivitiesListGroup, arg2:core.activities.Activity):int
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc4:*=null;
            var loc3:*=arg1.children.length;
            var loc5:*=loc3;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = arg1.children[loc2] as frontend.screen.activities.list.ActivityListItem;
                if (loc4.startDate.time < arg2.startDate.time) 
                {
                    loc5 = loc2;
                    break;
                }
                ++loc2;
            }
            return loc5;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            this._activityList.selectedItem = null;
            this.listLoader.setNormalState();
            this.setFooterButtons();
            return;
        }

        internal function setFooterButtons():void
        {
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            if (this.listLoader.listStateHandler.editState) 
            {
                this.listLoader.noDataIconButtonAnchor = null;
                this.buttonGroup.push(this.buttonDelete);
                this.buttonGroup.push(this.buttonCancel);
            }
            else 
            {
                this.listLoader.noDataIconButtonAnchor = this.buttonLoad;
                this.buttonGroup.push(this.buttonLoad);
                this.buttonGroup.push(this.buttonEdit);
            }
            this.footer.showBackButton = !this.listLoader.listStateHandler.editState;
            this.footer.setButtonGroup(this.buttonGroup);
            return;
        }

        protected override function addContent():void
        {
            this.loadActivities(this.limit, this.currentOffset);
            return;
        }

        internal function loadActivities(arg1:int, arg2:int):void
        {
            this.listLoader.startLoading();
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.activities.ActivityMapper.generateLoadActivitiesStatement(arg1, arg2, ["sportID != 16"]), this.loadActivitiesComplete, this.loadActivitiesError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function loadActivitiesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activitiesError");
            return;
        }

        internal function loadActivitiesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=arg1.getResult();
            var loc2:*=loc1.length;
            this.ignoreNextScrollEvents = loc1.length < this.limit;
            this.currentOffset = this.currentOffset + this.limit;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                this.currentListGroupKey = getGroupKey(loc4[core.activities.ActivityMapper.col_startDate] as Date);
                if (this.currentListGroupKey != this.oldListGroupKey) 
                {
                    loc7 = this.getHeaderLabel(loc4[core.activities.ActivityMapper.col_startDate] as Date);
                    loc5 = new frontend.screen.activities.list.ActivitiesListGroup(this.currentListGroupKey, loc7);
                    this.oldListGroupKey = this.currentListGroupKey;
                    this.listDataProvider.addItemAt(loc5, (this.listDataProvider.data as Array).length);
                }
                else 
                {
                    loc5 = this.listDataProvider.getItemAt(((this.listDataProvider.data as Array).length - 1)) as frontend.screen.activities.list.ActivitiesListGroup;
                }
                loc6 = new frontend.screen.activities.list.ActivityListItem();
                loc6.startDate = loc4[core.activities.ActivityMapper.col_startDate] as Date;
                loc6.activityId = loc4[core.activities.ActivityMapper.col_activityId];
                loc6.GUID = loc4[core.activities.ActivityMapper.col_GUID];
                loc6.name = loc4[core.activities.ActivityMapper.col_name];
                loc6.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(loc4.sportId);
                loc6.distance = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc4[core.activities.ActivityMapper.col_distance]));
                loc6.distanceValue = loc4[core.activities.ActivityMapper.col_distance];
                loc6.trainingTime = backend.utils.DataUtils.timeFormatter.format(loc4[core.activities.ActivityMapper.col_trainingTime]);
                loc6.trainingTimeValue = loc4[core.activities.ActivityMapper.col_trainingTime];
                loc6.shareIcon = core.activities.ActivityMapper.isShared(loc4[core.activities.ActivityMapper.col_sharingInformations]) ? this.sharedIcon : this.shareIcon;
                loc6.sportIcon = handler.SportHandler.getSportIcon(loc6.sport);
                loc6.sportBackgroundSkin = handler.SportHandler.getSportBackgroundSkin(loc6.sport);
                loc5.addItem(loc6);
                ++loc3;
            }
            if (this._activityList.dataProvider == null) 
            {
                if (loc2 > 0) 
                {
                    this._activityList.typicalItem = this.typicalItem;
                }
                this._activityList.dataProvider = this.listDataProvider;
            }
            if (!(this.setVPosAfterReload == 0) && loc2 > 0) 
            {
                this._activityList.scrollToPosition(0, this.setVPosAfterReload, 0);
                this.setVPosAfterReload = 0;
            }
            this.buttonEdit.isEnabled = loc2 > 0;
            this.listLoader.stopLoading();
            this.listLoader.setNormalState();
            return;
        }

        internal function getHeaderLabel(arg1:Date):String
        {
            var loc1:*=backend.utils.DataUtils.monthLabelsLong[arg1.month] + " " + arg1.fullYear;
            return loc1;
        }

        internal function onListTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.listLoader.listStateHandler.editState) 
            {
                return;
            }
            var loc1:*=this._activityList.selectedItem;
            if (!loc1) 
            {
                return;
            }
            loadActivity(loc1.activityId);
            return;
        }

        internal function get listDataProvider():feathers.data.HierarchicalCollection
        {
            return this._1399580807listDataProvider;
        }

        internal function editActivities_handler(arg1:starling.events.TouchEvent):void
        {
            this.listLoader.swapState();
            this.setFooterButtons();
            return;
        }

        internal function deleteActivities_handler(arg1:starling.events.TouchEvent):void
        {
            this.deletePopUp = new frontend.components.popup.DeletePopUp();
            this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_ACTIVITIES_TITLE");
            this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_ACTIVITIES_TEXT");
            this.deletePopUp.cancelCallback = this.onPopUpClose;
            this.deletePopUp.deleteCallback = this.onPopUpDelete;
            frontend.components.popup.PopUpBase.showModalPopUp(this.deletePopUp, true, true);
            return;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onPopUpDelete():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=frontend.components.list.SelectableListItem.selectedItems;
            for (loc1 in loc3) 
            {
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, handler.ActivityHandler.prepareDelete(loc1), this.onDeleteActivityComplete, this.onDeleteActivityError, Workers.worker_DatabaseWorker, loc1);
            }
            this.listLoader.swapState();
            this.setFooterButtons();
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onDeleteActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().dispatchEvent(new frontend.screen.activities.list.ActivityListEvent(frontend.screen.activities.list.ActivityListEvent.DELETE, null, arg1.data.data as String));
            return;
        }

        internal function onDeleteActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteActivityError");
            return;
        }

        internal function cancelEditActivities_handler(arg1:starling.events.TouchEvent):void
        {
            this.listLoader.swapState();
            this.setFooterButtons();
            frontend.components.list.SelectableListItem.reset();
            return;
        }

        internal function _ActivitiesList_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        protected var buttonGroup:__AS3__.vec.Vector.<frontend.components.button.IconButton>;

        internal var _474914260_activityList:frontend.components.list.CustomGroupedList;

        internal var buttonCancel:frontend.components.button.IconButton;

        internal var buttonDelete:frontend.components.button.IconButton;

        internal var buttonEdit:frontend.components.button.IconButton;

        internal var currentListGroupKey:String="";

        internal var currentOffset:int=0;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var ignoreNextScrollEvents:Boolean;

        internal var limit:int=50;

        internal var _1399580807listDataProvider:feathers.data.HierarchicalCollection;

        internal var oldListGroupKey:String="";

        internal var setVPosAfterReload:Number=0;

        internal var shareIcon:starling.textures.Texture;

        internal var sharedIcon:starling.textures.Texture;

        internal var typicalItem:Object;

        internal static var _selectedActivity:core.activities.Activity;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _358315832buttonLoad:frontend.components.button.IconButton;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


