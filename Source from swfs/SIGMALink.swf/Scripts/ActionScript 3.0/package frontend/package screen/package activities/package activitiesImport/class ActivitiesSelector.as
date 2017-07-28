//class ActivitiesSelector
package frontend.screen.activities.activitiesImport 
{
    import __AS3__.vec.*;
    import backend.events.*;
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import core.general.*;
    import core.sport.*;
    import core.units.*;
    import core.units.interfaces.*;
    import core.user.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.*;
    import frontend.components.*;
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.*;
    import handler.*;
    import init.*;
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
    import utils.sort.*;
    
    use namespace mx_internal;
    
    public class ActivitiesSelector extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ActivitiesSelector()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1872440022_userDp = new feathers.data.ListCollection();
            this.shareIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.shareicon);
            this.sharedIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.sharedicon);
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivitiesSelector_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_activitiesImport_ActivitiesSelectorWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ActivitiesSelector[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._ActivitiesSelector_LayoutGroup1_i(), this._ActivitiesSelector_Footer1_i()];
            this.addEventListener("addedToStage", this.___ActivitiesSelector_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___ActivitiesSelector_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___ActivitiesSelector_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get attention_label():feathers.controls.Label
        {
            return this._1786852499attention_label;
        }

        public function set attention_label(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1786852499attention_label;
            if (loc1 !== arg1) 
            {
                this._1786852499attention_label = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "attention_label", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
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

        public function get list():frontend.components.list.CustomGroupedList
        {
            return this._3322014list;
        }

        public function set list(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3322014list;
            if (loc1 !== arg1) 
            {
                this._3322014list = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "list", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get nextButton():frontend.components.button.IconButton
        {
            return this._1749722107nextButton;
        }

        public function set nextButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1749722107nextButton;
            if (loc1 !== arg1) 
            {
                this._1749722107nextButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "nextButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get row1():feathers.controls.LayoutGroup
        {
            return this._3506583row1;
        }

        public function set row1(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3506583row1;
            if (loc1 !== arg1) 
            {
                this._3506583row1 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "row1", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get row2():feathers.controls.LayoutGroup
        {
            return this._3506584row2;
        }

        public function set row2(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3506584row2;
            if (loc1 !== arg1) 
            {
                this._3506584row2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "row2", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get row3():frontend.components.menuList.MenuList
        {
            return this._3506585row3;
        }

        public function set row3(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3506585row3;
            if (loc1 !== arg1) 
            {
                this._3506585row3 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "row3", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get user():frontend.components.menuList.MenuListItem
        {
            return this._3599307user;
        }

        internal function _ActivitiesSelector_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_ActivitiesSelector_Label1";
            this._ActivitiesSelector_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivitiesSelector_Label1", this._ActivitiesSelector_Label1);
            return loc1;
        }

        public function set user(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3599307user;
            if (loc1 !== arg1) 
            {
                this._3599307user = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "user", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get _selectedUserId():int
        {
            return this._894772512_selectedUserId;
        }

        public function set _selectedUserId(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._894772512_selectedUserId;
            if (loc1 !== arg1) 
            {
                this._894772512_selectedUserId = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_selectedUserId", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _activiesCount():uint
        {
            return this._1849967800_activiesCount;
        }

        internal function set _activiesCount(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1849967800_activiesCount;
            if (loc1 !== arg1) 
            {
                this._1849967800_activiesCount = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_activiesCount", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _isLog():Boolean
        {
            return this._1474725701_isLog;
        }

        internal function set _isLog(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1474725701_isLog;
            if (loc1 !== arg1) 
            {
                this._1474725701_isLog = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_isLog", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function set _nextButtonVisible(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1486981586_nextButtonVisible;
            if (loc1 !== arg1) 
            {
                this._1486981586_nextButtonVisible = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_nextButtonVisible", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _userDp():feathers.data.ListCollection
        {
            return this._1872440022_userDp;
        }

        internal function set _userDp(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1872440022_userDp;
            if (loc1 !== arg1) 
            {
                this._1872440022_userDp = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_userDp", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get listDataProvider():feathers.data.HierarchicalCollection
        {
            return this._1399580807listDataProvider;
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

        internal function get listStateHandler():frontend.components.list.ListStateHandler
        {
            return this._873259721listStateHandler;
        }

        internal function set listStateHandler(arg1:frontend.components.list.ListStateHandler):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._873259721listStateHandler;
            if (loc1 !== arg1) 
            {
                this._873259721listStateHandler = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listStateHandler", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function set showRow2(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.showRow2;
            if (loc1 !== arg1) 
            {
                this._338884043showRow2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "showRow2", loc1, arg1, this);
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
            ActivitiesSelector._watcherSetupUtil = arg1;
            return;
        }

        internal static function get ROW_PADDING():Number
        {
            return ActivitiesSelector._25669012ROW_PADDING;
        }

        internal static function set ROW_PADDING(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=ActivitiesSelector._25669012ROW_PADDING;
            if (loc1 !== arg1) 
            {
                ActivitiesSelector._25669012ROW_PADDING = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_PADDING", loc1, arg1, ActivitiesSelector);
                loc3 = ActivitiesSelector.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        internal function get showRow2():Boolean
        {
            return this._showRow2;
        }

        internal function set _338884043showRow2(arg1:Boolean):void
        {
            this._showRow2 = arg1;
            this.recalculateAttentionRow();
            return;
        }

        
        {
            _25669012ROW_PADDING = 15 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal function onAddedToStage():void
        {
            handler.ViewHandler.getInstance().addBackFunction(this.backButtonFunction);
            return;
        }

        internal function onRemovedFromStage():void
        {
            handler.ViewHandler.getInstance().removeBackFunction(this.backButtonFunction);
            return;
        }

        protected function backButtonFunction():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        protected override function validateProperties():void
        {
            this._isLog = this.unit is core.units.interfaces.ILogList;
            this.showRow2 = this.unit is core.units.interfaces.IOnlyFinishedActivitiesLoadable;
            this._activities = this.loadedData;
            this._activities.sort(this.sortActivities);
            this._activiesCount = this._activities.length;
            this._nextButtonVisible = this._activiesCount > 0;
            if (this._isLog) 
            {
                this.nextButton.touchHandler = this.nextStepLoadActivities;
            }
            else 
            {
                this.nextButton.touchHandler = this.nextStepSave;
            }
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < this._activiesCount) 
            {
                loc1.push("\'" + this._activities[loc2].GUID + "\'");
                ++loc2;
            }
            var loc3:*="SELECT " + core.activities.ActivityMapper.col_GUID + ", " + core.activities.ActivityMapper.col_name + ", " + core.activities.ActivityMapper.col_trainingTime + ", " + core.activities.ActivityMapper.col_isDeleted + " FROM " + core.activities.ActivityMapper.table_name + " WHERE " + core.activities.ActivityMapper.col_GUID + " IN (" + loc1.join(",") + ")";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc3, this.onLoadNamesComplete, this.onLoadNamesError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function sortActivities(arg1:core.activities.Activity, arg2:core.activities.Activity):Number
        {
            return utils.sort.SortUtil.sortOnDate(arg1, arg2, core.activities.ActivityMapper.col_startDate, true);
        }

        internal function onLoadNamesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc3:*=0;
            var loc1:*=arg1.getResult();
            var loc2:*=0;
            var loc4:*=loc1.length;
            while (loc2 < this._activiesCount) 
            {
                this._activities[loc2].isNew = true;
                if (loc1.length != 0) 
                {
                    loc3 = 0;
                    while (loc3 < loc4) 
                    {
                        if (!loc1[loc3][core.activities.ActivityMapper.col_isDeleted]) 
                        {
                            if (loc1[loc3][core.activities.ActivityMapper.col_GUID] == this._activities[loc2].GUID) 
                            {
                                this._activities[loc2].name = loc1[loc3][core.activities.ActivityMapper.col_name];
                                this._activities[loc2].alreadySaved = true;
                                this._activities[loc2].isNew = false;
                                this._activities[loc2].isUpdate = loc1[loc3][core.activities.ActivityMapper.col_trainingTime] < this._activities[loc2].trainingTime;
                            }
                        }
                        ++loc3;
                    }
                }
                ++loc2;
            }
            this.createDataProvider();
            return;
        }

        internal function onLoadNamesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.createDataProvider();
            return;
        }

        internal function getHeaderLabel(arg1:Date):String
        {
            var loc1:*=backend.utils.DataUtils.monthLabelsLong[arg1.month] + " " + arg1.fullYear;
            return loc1;
        }

        internal function createDataProvider():void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc6:*=null;
            if (!this.list) 
            {
                debug.Debug.warning("CANT CREATE DATAPROVIDER! LIST IS NOT READY! TRY AGAIN LATER!");
                flash.utils.setTimeout(this.createDataProvider, 300);
                return;
            }
            this.listDataProvider = new feathers.data.HierarchicalCollection();
            this.listStateHandler = new frontend.components.list.ListStateHandler(this.list);
            frontend.components.list.SelectableListItem.reset();
            this.oldListGroupKey = "";
            loc1 = 0;
            while (loc1 < this._activiesCount) 
            {
                loc2 = this._activities[loc1];
                if (loc2.GUID == "") 
                {
                    loc2.GUID = utils.GUID.create();
                }
                if (loc2.modificationDate == 0) 
                {
                    loc2.modificationDate = new Date().time;
                }
                this.currentListGroupKey = loc2.startDate.fullYear + "_" + (loc2.startDate.month + 1);
                if (this.currentListGroupKey != this.oldListGroupKey) 
                {
                    loc6 = this.getHeaderLabel(loc2.startDate);
                    loc3 = new frontend.screen.activities.list.ActivitiesListGroup(this.currentListGroupKey, loc6);
                    this.oldListGroupKey = this.currentListGroupKey;
                    this.listDataProvider.addItemAt(loc3, (this.listDataProvider.data as Array).length);
                }
                else 
                {
                    loc3 = this.listDataProvider.getItemAt(((this.listDataProvider.data as Array).length - 1)) as frontend.screen.activities.list.ActivitiesListGroup;
                }
                loc4 = new frontend.screen.activities.list.ActivityListItem();
                loc4.startDate = loc2.startDate;
                loc4.activityId = loc2.activityId;
                loc4.GUID = loc2.GUID;
                loc4.name = loc2.name;
                loc4.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(loc2.sportId);
                loc4.distance = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc2.distance));
                loc4.distanceValue = loc2.distance;
                loc4.trainingTime = backend.utils.DataUtils.timeFormatter.format(loc2.trainingTime);
                loc4.trainingTimeValue = loc2.trainingTime;
                loc4.shareIcon = null;
                loc4.sportIcon = handler.SportHandler.getSportIcon(loc4.sport);
                loc4.sportBackgroundSkin = handler.SportHandler.getSportBackgroundSkin(loc4.sport);
                loc4.activity = loc2;
                loc4.defaultSelected = loc2.isNew || loc2.isUpdate;
                loc4.isNew = loc2.isNew;
                loc4.isUpdate = loc2.isUpdate;
                loc2.trainingTime;
                loc3.addItem(loc4);
                loc3.footer = null;
                ++loc1;
            }
            if (this._activiesCount > 0) 
            {
                this.list.typicalItem = this.typicalItem;
            }
            this.list.dataProvider = this.listDataProvider;
            var loc5:*=new backend.utils.dbUtils.DBUtilObject(null, this.loadUsersComplete, this.loadUsersError, Workers.worker_DatabaseWorker);
            handler.UserHandler.getInstance().loadUsers(loc5);
            flash.utils.setTimeout(this.swap, 300);
            return;
        }

        internal function swap():void
        {
            if (!this.listStateHandler.editState) 
            {
                this.listStateHandler.swapState();
            }
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            var loc1:*=handler.SportHandler.getInstance().resolveSportByKeyName(core.sport.Sport.CYCLING);
            var loc2:*=new Array();
            loc2.push({"activityId":1, "distance":"1,50 km", "name":"Activity-Name", "shared":false, "shareIcon":frontend.AssetsManagerCustom.getInstance().getTexture("shareIcon"), "sport":loc1, "sportBackgroundSkin":handler.SportHandler.getSportBackgroundSkin(loc1), "sportIcon":handler.SportHandler.getSportIcon(loc1), "startDate":new Date(), "trainingTime":"01:00:00 h"});
            loc2.push({"activityId":2, "distance":"15,50 km", "name":"Activity-Name 2", "shared":true, "shareIcon":frontend.AssetsManagerCustom.getInstance().getTexture("sharedIcon"), "sport":loc1, "sportBackgroundSkin":handler.SportHandler.getSportBackgroundSkin(loc1), "sportIcon":handler.SportHandler.getSportIcon(loc1), "startDate":new Date(), "trainingTime":"02:30:00 h"});
            this.typicalItem = {"header":{"date":"2016_1", "title":"JAN"}, "children":loc2, "footer":{"distance":22.5, "distanceIcon":frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalldistance), "length":2, "statisticIcon":frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmallcount), "trainingTime":36000, "timeIcon":frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalltime)}};
            return;
        }

        internal function loadUsersComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc4:*=null;
            var loc1:*=0;
            var loc2:*=arg1.getResult();
            var loc3:*=loc2.length;
            this._userDp = new feathers.data.ListCollection();
            while (loc1 < loc3) 
            {
                this._userDp.push({"label":loc2[loc1].name, "data":loc2[loc1].userId});
                ++loc1;
            }
            if (this._userDp.length == 0) 
            {
                loc4 = new core.user.User();
                loc4.name = utils.LanguageManager.getString("DEFAULT_USER_NAME");
                handler.UserHandler.getInstance().saveUser(loc4);
                this._userDp.push({"label":loc4.name, "data":loc4.userId});
            }
            this.user.dataProvider = this._userDp;
            if (this._userDp.length > 0) 
            {
                this._selectedUserId = this._userDp.getItemAt(0).data;
                this.user.value = this._userDp.getItemAt(0).data;
            }
            return;
        }

        internal function loadUsersError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("loadUsersError");
            return;
        }

        internal function nextStepLoadActivities(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc5:*=null;
            if (this._activiesCount == 0) 
            {
                return;
            }
            this._nextButtonVisible = false;
            var loc1:*=frontend.components.list.SelectableListItem.selectedItems;
            var loc4:*=new Vector.<core.activities.Activity>();
            var loc6:*=0;
            var loc7:*=loc1;
            for (loc5 in loc7) 
            {
                if (!loc1.hasOwnProperty(loc5)) 
                {
                    continue;
                }
                loc2 = loc1[loc5];
                if (!loc2.isSelected()) 
                {
                    continue;
                }
                if (loc2.activity == null) 
                {
                    debug.Debug.error("ACHTUNG! Activity is null +++");
                    continue;
                }
                loc2.activity.userId = this.user.value as uint;
                loc4.push(loc2.activity);
            }
            if (this._isLog) 
            {
                if (this.unit is core.units.interfaces.IDataToDecode) 
                {
                    (this.unit as core.units.interfaces.IDataToDecode).activitiesToDecode = loc4;
                }
                else 
                {
                    (this.unit as core.units.interfaces.ILogList).loadedLogs = loc4;
                }
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_TRANSFER, {"loadHeader":false, "unit":this.unit, "loadedData":this.loadedData, "backScreenName":this.backScreenName}, handler.ViewHandler.slideToLeftTransition());
            }
            return;
        }

        internal function nextStepSave(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (this._activiesCount == 0) 
            {
                return;
            }
            this._nextButtonVisible = false;
            var loc1:*=frontend.components.list.SelectableListItem.selectedItems;
            this._activitiesToSave = new Vector.<backend.utils.dbUtils.DBUtilObject>();
            var loc5:*=0;
            var loc6:*=loc1;
            for (loc4 in loc6) 
            {
                if (!loc1.hasOwnProperty(loc4)) 
                {
                    continue;
                }
                loc2 = loc1[loc4];
                if (loc2.activity == null) 
                {
                    debug.Debug.error("ACHTUNG! Activity is null +++");
                    continue;
                }
                loc2.activity.userId = this.user.value as uint;
                loc3 = new backend.utils.dbUtils.DBUtilObject(loc2.activity, this.onSaveActivityComplete, this.onSaveActivityError, null);
                this._activitiesToSave.push(loc3);
            }
            this._activitiesToSaveCount = this._activitiesToSave.length;
            this._progressPopUp = new frontend.components.popup.ProgressPopUp();
            this._progressPopUp.title = utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_ACTIVITIES_TITLE");
            this._progressPopUp.text = utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_ACTIVITIES_TEXT");
            this._progressPopUp.imageTexture = frontend.Textures.linkIconWhite;
            this._progressPopUp.addEventListener(frontend.components.popup.ProgressPopUp.PROGRESS_COMPLETE, this.onProgressComplete);
            frontend.components.popup.PopUpBase.showModalPopUp(this._progressPopUp);
            this.saveNextActivity();
            return;
        }

        internal function onProgressComplete(arg1:starling.events.Event):void
        {
            this._progressPopUp.removeEventListener(frontend.components.popup.ProgressPopUp.PROGRESS_COMPLETE, this.onProgressComplete);
            var loc1:*=new frontend.screen.activities.list.ActivityListEvent(frontend.screen.activities.list.ActivityListEvent.RELOAD);
            loc1.resetLastScrollPosition = true;
            handler.ActivityHandler.getInstance().dispatchEvent(loc1);
            frontend.components.popup.PopUpBase.removePopUps(this._progressPopUp);
            handler.ActivityHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            if (this._activitiesToSaveCount == 1 && !(this._actualActivity == null)) 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITY, {"activity":this._actualActivity}, handler.ViewHandler.slideToLeftTransition());
            }
            else 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_LIST, null, handler.ViewHandler.slideToLeftTransition());
            }
            return;
        }

        internal function saveNextActivity():void
        {
            if (this._activitiesToSave.length == 0) 
            {
                this._progressPopUp.setProgressPercentage(100);
                return;
            }
            this._actualActivity = null;
            var loc1:*=this._activitiesToSave.shift();
            if (loc1.data is core.activities.Activity) 
            {
                this._actualActivity = loc1.data as core.activities.Activity;
            }
            handler.ActivityHandler.getInstance().saveActivity(loc1);
            return;
        }

        internal function onSaveActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=100 / this._activitiesToSaveCount * (this._activitiesToSaveCount - this._activitiesToSave.length);
            this._progressPopUp.setProgressPercentage(loc1);
            var loc2:*=new backend.events.UnitDataEvent(backend.events.UnitDataEvent.SHARING_DATA_ADDED, arg1.data.data);
            handler.ActivityHandler.getInstance().dispatchEvent(loc2);
            this.saveNextActivity();
            return;
        }

        internal function onSaveActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onSaveActivityError");
            return;
        }

        internal function onUserSelected(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this._selectedUserId = arg1.value as int;
            this.user.value = this._selectedUserId;
            return;
        }

        protected function onResizeRow(arg1:starling.events.Event):void
        {
            this.list.height = SIGMALink.containerHeight - this.row1.height - this.row3.height;
            if (this.showRow2) 
            {
                this.list.height = this.list.height - this.row2.height;
            }
            this.recalculateAttentionRow();
            return;
        }

        internal function recalculateAttentionRow():void
        {
            if (this.showRow2 && !(this.attention_icon == null) && !(this.attention_label == null)) 
            {
                this.row2.height = Math.max(this.attention_icon.height, this.attention_label.height) + ROW_PADDING * 2;
                this.attention_label.width = this.row2.width - this.attention_icon.width - ROW_PADDING * 4;
            }
            return;
        }

        internal function _ActivitiesSelector_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivitiesSelector_VerticalLayout1_c();
            loc1.mxmlContent = [this._ActivitiesSelector_LayoutGroup2_i(), this._ActivitiesSelector_LayoutGroup3_i(), this._ActivitiesSelector_MenuList1_i(), this._ActivitiesSelector_CustomGroupedList1_i()];
            loc1.id = "_ActivitiesSelector_LayoutGroup1";
            this._ActivitiesSelector_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivitiesSelector_LayoutGroup1", this._ActivitiesSelector_LayoutGroup1);
            return loc1;
        }

        internal function _ActivitiesSelector_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            loc1.useVirtualLayout = true;
            return loc1;
        }

        internal function _ActivitiesSelector_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._ActivitiesSelector_Label1_i()];
            loc1.addEventListener("resize", this.__row1_resize);
            loc1.id = "row1";
            this.row1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "row1", this.row1);
            return loc1;
        }

        internal function get _nextButtonVisible():Boolean
        {
            return this._1486981586_nextButtonVisible;
        }

        public function __row1_resize(arg1:starling.events.Event):void
        {
            this.onResizeRow(arg1);
            return;
        }

        internal function _ActivitiesSelector_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivitiesSelector_HorizontalLayout1_i();
            loc1.mxmlContent = [this._ActivitiesSelector_TextureImage1_i(), this._ActivitiesSelector_Label2_i()];
            loc1.addEventListener("resize", this.__row2_resize);
            loc1.id = "row2";
            this.row2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "row2", this.row2);
            return loc1;
        }

        internal function _ActivitiesSelector_HorizontalLayout1_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._ActivitiesSelector_HorizontalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivitiesSelector_HorizontalLayout1", this._ActivitiesSelector_HorizontalLayout1);
            return loc1;
        }

        internal function _ActivitiesSelector_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.scale = 0.5;
            loc1.addEventListener("resize", this.__attention_icon_resize);
            loc1.id = "attention_icon";
            this.attention_icon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "attention_icon", this.attention_icon);
            return loc1;
        }

        public function __attention_icon_resize(arg1:starling.events.Event):void
        {
            this.onResizeRow(arg1);
            return;
        }

        internal function _ActivitiesSelector_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.addEventListener("resize", this.__attention_label_resize);
            loc1.id = "attention_label";
            this.attention_label = loc1;
            feathers.binding.BindingManager.executeBindings(this, "attention_label", this.attention_label);
            return loc1;
        }

        public function __attention_label_resize(arg1:starling.events.Event):void
        {
            this.onResizeRow(arg1);
            return;
        }

        public function __row2_resize(arg1:starling.events.Event):void
        {
            this.onResizeRow(arg1);
            return;
        }

        internal function _ActivitiesSelector_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._ActivitiesSelector_MenuListItem1_i()];
            loc1.addEventListener("resize", this.__row3_resize);
            loc1.id = "row3";
            this.row3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "row3", this.row3);
            return loc1;
        }

        internal function _ActivitiesSelector_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onUserSelected;
            loc1.text = "APPSETTINGS.BENUTZER";
            loc1.title = "APPSETTINGS.BENUTZER";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "user";
            this.user = loc1;
            feathers.binding.BindingManager.executeBindings(this, "user", this.user);
            return loc1;
        }

        public function __row3_resize(arg1:starling.events.Event):void
        {
            this.onResizeRow(arg1);
            return;
        }

        internal function _ActivitiesSelector_CustomGroupedList1_i():frontend.components.list.CustomGroupedList
        {
            var loc1:*=new frontend.components.list.CustomGroupedList();
            loc1.clipContent = true;
            loc1.headerField = "header";
            loc1.stickyHeader = false;
            loc1.id = "list";
            this.list = loc1;
            feathers.binding.BindingManager.executeBindings(this, "list", this.list);
            return loc1;
        }

        internal function _ActivitiesSelector_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._ActivitiesSelector_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ActivitiesSelector_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "nextButton";
            this.nextButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "nextButton", this.nextButton);
            return loc1;
        }

        public function ___ActivitiesSelector_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        public function ___ActivitiesSelector_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___ActivitiesSelector_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage();
            return;
        }

        internal function _ActivitiesSelector_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.IMPORT_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_ActivitiesSelector_LayoutGroup1.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_ActivitiesSelector_LayoutGroup1.height")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ActivitiesSelector_LayoutGroup1.width")
            result[4] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "row1.backgroundSkin")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            }, null, "row1.height")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "row1.layout")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "row1.width")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(ROW_PADDING, ROW_PADDING, ROW_PADDING, ROW_PADDING, NaN, 0);
            }, null, "_ActivitiesSelector_Label1.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivitiesSelector_Label1.styleName")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIESIMPORT.SELECTACTIVITIES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivitiesSelector_Label1.text")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            }, null, "row2.height")
            result[12] = new feathers.binding.Binding(this, function ():Boolean
            {
                return showRow2;
            }, null, "row2.includeInLayout")
            result[13] = new feathers.binding.Binding(this, function ():Boolean
            {
                return showRow2;
            }, null, "row2.visible")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "row2.width")
            result[15] = new feathers.binding.Binding(this, function ():Number
            {
                return ROW_PADDING * 2;
            }, null, "_ActivitiesSelector_HorizontalLayout1.gap")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return ROW_PADDING;
            }, null, "_ActivitiesSelector_HorizontalLayout1.padding")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return ROW_PADDING * 2;
            }, null, "_ActivitiesSelector_HorizontalLayout1.paddingLeft")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.attentionbig;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "attention_icon.textureName")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "attention_label.styleName")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIESIMPORT.SELECTACTIVITIES.NOTE_ONLY_FINISHED_ACTIVITIES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "attention_label.text")
            result[21] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "row3.backgroundSkin")
            result[22] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return _userDp;
            }, null, "user.dataProvider")
            result[23] = new feathers.binding.Binding(this, null, null, "user.defaultValue", "_selectedUserId");
            result[24] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "user.itemWidth")
            result[25] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "user.minItemHeight")
            result[26] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "user.type")
            result[27] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "list.backgroundSkin")
            result[28] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.list.ActivityListItemHeaderRenderer;
            }, null, "list.headerRendererType")
            result[29] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "list.height")
            result[30] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.list.ActivitiesSelectorItemRenderer;
            }, null, "list.itemRendererType")
            result[31] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "list.width")
            result[32] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_isLog ? frontend.Textures.arrowRight : frontend.Textures.saveiconwhite;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "nextButton.image")
            result[33] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _nextButtonVisible;
            }, null, "nextButton.includeInLayout")
            result[34] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _nextButtonVisible;
            }, null, "nextButton.visible")
            return result;
        }

        public function get attention_icon():frontend.components.TextureImage
        {
            return this._1443026682attention_icon;
        }

        public function set attention_icon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1443026682attention_icon;
            if (loc1 !== arg1) 
            {
                this._1443026682attention_icon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "attention_icon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var _ActivitiesSelector_HorizontalLayout1:feathers.layout.HorizontalLayout;

        public var _ActivitiesSelector_Label1:feathers.controls.Label;

        public var _ActivitiesSelector_LayoutGroup1:feathers.controls.LayoutGroup;

        internal var _1443026682attention_icon:frontend.components.TextureImage;

        internal var _1786852499attention_label:feathers.controls.Label;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _3322014list:frontend.components.list.CustomGroupedList;

        internal var _1749722107nextButton:frontend.components.button.IconButton;

        internal var _3506583row1:feathers.controls.LayoutGroup;

        internal var _3506584row2:feathers.controls.LayoutGroup;

        internal var _3506585row3:frontend.components.menuList.MenuList;

        internal var _3599307user:frontend.components.menuList.MenuListItem;

        internal var _894772512_selectedUserId:int;

        public var backScreenName:String;

        public var loadedData:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _1849967800_activiesCount:uint;

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _activitiesToSave:__AS3__.vec.Vector.<backend.utils.dbUtils.DBUtilObject>;

        internal var _activitiesToSaveCount:uint=0;

        internal var _actualActivity:core.activities.Activity;

        internal var _1474725701_isLog:Boolean=false;

        internal var _1486981586_nextButtonVisible:Boolean=false;

        internal var _progressPopUp:frontend.components.popup.ProgressPopUp;

        internal var _selectedUser:core.user.User;

        internal var _showActivity:Boolean=false;

        internal var _1872440022_userDp:feathers.data.ListCollection;

        internal var currentListGroupKey:String="";

        internal var limit:int=50;

        internal var _1399580807listDataProvider:feathers.data.HierarchicalCollection;

        internal var _873259721listStateHandler:frontend.components.list.ListStateHandler;

        internal var oldListGroupKey:String="";

        internal var shareIcon:starling.textures.Texture;

        internal var sharedIcon:starling.textures.Texture;

        internal var _showRow2:Boolean=false;

        internal var typicalItem:Object;

        internal static var _25669012ROW_PADDING:Number;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        public var unit:core.units.Unit;

        mx_internal var _bindings:Array;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;
    }
}


