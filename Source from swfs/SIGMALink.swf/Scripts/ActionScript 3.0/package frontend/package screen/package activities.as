//package activities
//  package activitiesImport
//    class ActivitiesSelector
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


//  package component
//    class ActivityGraphComp
package frontend.screen.activities.component 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.activities.*;
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.display.*;
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
    import frontend.components.tab.*;
    import frontend.screen.activities.*;
    import handler.*;
    import mx.core.*;
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
    
    public class ActivityGraphComp extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityGraphComp()
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
            bindings = this._ActivityGraphComp_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_component_ActivityGraphCompWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.component.ActivityGraphComp[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._ActivityGraphComp_AnchorLayout1_c();
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ActivityGraphComp_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        public function get entries():__AS3__.vec.Vector.<Object>
        {
            return this._entries;
        }

        internal function set _1591573360entries(arg1:__AS3__.vec.Vector.<Object>):void
        {
            this._entries = arg1;
            if (this._entries) 
            {
                this.validateChart();
            }
            return;
        }

        internal function _ActivityGraphComp_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return CHART_COMP_HEIGHT;
            }, null, "this.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            return result;
        }

        public function set entries(arg1:__AS3__.vec.Vector.<Object>):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.entries;
            if (loc1 !== arg1) 
            {
                this._1591573360entries = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "entries", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get yAchseLabel():String
        {
            return this._1691484629yAchseLabel;
        }

        public function set yAchseLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1691484629yAchseLabel;
            if (loc1 !== arg1) 
            {
                this._1691484629yAchseLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "yAchseLabel", loc1, arg1, this);
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
            frontend.screen.activities.component.ActivityGraphComp._watcherSetupUtil = arg1;
            return;
        }

        internal function validateChart():void
        {
            var loc2:*=0;
            var loc3:*=NaN;
            var loc4:*=null;
            var loc10:*=null;
            var loc14:*=null;
            var loc15:*=NaN;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=NaN;
            var loc26:*=null;
            var loc27:*=NaN;
            var loc28:*=NaN;
            var loc29:*=NaN;
            var loc1:*=this.entries.length;
            loc4 = new feathers.controls.Label();
            loc4.text = this.yAchseLabel;
            loc4.styleProvider = null;
            loc4.textRendererFactory = this.yHeadLabelFactory;
            addChild(loc4);
            loc4.validate();
            loc4.layoutData = new feathers.layout.AnchorLayoutData((GUTTER_TOP - loc4.height) / 2, NaN, NaN, CHART_HEADLINE_PADDING_LEFT);
            var loc5:*=handler.ActivityHandler.calculateVerticalAxisProperties(this.entries, this.yValueName);
            if (isNaN(this.yMinFix)) 
            {
                this.yMin = loc5[0];
            }
            else 
            {
                this.yMin = this.yMinFix;
            }
            if (isNaN(this.yMaxFix)) 
            {
                this.yMax = this.speedTime ? utils.Calculations.speedTimeMaximum() : loc5[1];
            }
            else 
            {
                this.yMax = this.yMaxFix;
            }
            if (isNaN(this.yIntervalFix)) 
            {
                this.yInterval = this.speedTime ? utils.Calculations.speedTimeMaximum() / 2 : loc5[2];
            }
            else 
            {
                this.yInterval = this.yIntervalFix;
            }
            var loc6:*=SIGMALink.appWidth - GUTTER_LEFT - GUTTER_RIGHT;
            var loc7:*=height - GUTTER_TOP - GUTTER_BOTTOM;
            var loc8:*=this.speedTime ? handler.ActivityHandler.calcDiffAbs(utils.Calculations.speedTimeMaximum(), 0) : handler.ActivityHandler.calcDiffAbs(this.yMax, this.yMin);
            var loc9:*=loc7 / loc8;
            var loc11:*=this.yMax - this.yMin;
            var loc12:*=Math.floor(loc11 / this.yInterval);
            var loc13:*=loc7 / loc12;
            loc2 = 0;
            while (loc2 <= loc12) 
            {
                if (this.speedTime) 
                {
                    loc3 = GUTTER_TOP + loc2 * loc13;
                }
                else 
                {
                    loc3 = GUTTER_TOP + loc7 - loc2 * loc13;
                }
                loc15 = this.yMin + loc2 * this.yInterval;
                if (this.yLabelConverter) 
                {
                    loc15 = this.speedTime ? loc15 * 100 : this.yLabelConverter.convert(loc15);
                }
                loc14 = new feathers.controls.Label();
                if (this.yLabelFormatter) 
                {
                    loc14.text = this.yLabelFormatter.format(loc15);
                }
                else 
                {
                    loc14.text = loc15.toFixed(0);
                }
                loc14.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
                addChild(loc14);
                loc14.validate();
                loc14.layoutData = new feathers.layout.AnchorLayoutData(loc3 - loc14.height / 3, NaN, NaN, GUTTER_LEFT - loc14.width - CHART_AXIS_INTERVAL_LINE_SIZE * 2);
                loc10 = new starling.display.Quad(loc6, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
                loc10.y = loc3;
                loc10.x = GUTTER_LEFT;
                addChild(loc10);
                loc10 = new starling.display.Quad(CHART_AXIS_INTERVAL_LINE_SIZE, CHART_AXIS_THICKNESS, CHART_AXIS_COLOR);
                loc10.y = loc3;
                loc10.x = GUTTER_LEFT - CHART_AXIS_INTERVAL_LINE_SIZE;
                addChild(loc10);
                ++loc2;
            }
            var loc16:*=new starling.display.Quad(loc6, CHART_AXIS_THICKNESS, CHART_AXIS_COLOR);
            loc16.x = GUTTER_LEFT;
            loc16.y = GUTTER_TOP + loc7;
            addChild(loc16);
            var loc17:*=new starling.display.Quad(CHART_AXIS_THICKNESS, loc7, CHART_AXIS_COLOR);
            loc17.x = GUTTER_LEFT;
            loc17.y = GUTTER_TOP;
            addChild(loc17);
            loc5 = handler.ActivityHandler.calculateHorizontalAxisProperties(this.entries, this.xValueName);
            var loc18:*=loc5[0];
            var loc19:*=loc5[1];
            var loc20:*=loc5[2];
            var loc21:*=Math.ceil(loc19 / loc20);
            var loc22:*=loc6 / loc19;
            if (loc1 > 0) 
            {
                loc23 = this.entries[0][this.xValueName] * loc22;
                loc24 = handler.ActivityHandler.calcDiffAbs(this.yMax, this.speedTime ? this.entries[0].speedTime : this.entries[0][this.yValueName]) * loc9;
                loc25 = 0;
                loc26 = new flash.display.Sprite();
                loc26.graphics.lineStyle(CHART_GRAPH_THICKNESS, this.graphColor);
                loc26.graphics.moveTo(loc23, loc24);
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    loc25 = this.entries[loc2][this.xValueName] * loc22;
                    loc3 = handler.ActivityHandler.calcDiffAbs(this.yMax, this.speedTime ? this.entries[loc2].speedTime : this.entries[loc2][this.yValueName]) * loc9;
                    if (this.speedTime) 
                    {
                        loc3 = loc7 - loc3;
                    }
                    loc26.graphics.cubicCurveTo((loc25 + loc23) * 0.5, loc24, (loc25 + loc23) * 0.5, loc3, loc25, loc3);
                    loc23 = loc25;
                    loc24 = loc3;
                    ++loc2;
                }
                loc26.graphics.endFill();
                loc26.width = loc6;
                loc26.height = loc7;
                addChild(DrawerUtil.getImageFromSprite(loc26, GUTTER_LEFT, GUTTER_TOP));
                loc27 = 0;
                loc2 = 0;
                while (loc2 <= loc21) 
                {
                    loc28 = loc20 * loc2;
                    if (loc28 > loc19) 
                    {
                        loc28 = loc19;
                    }
                    loc29 = GUTTER_LEFT + loc6 * loc28 / loc19;
                    loc10 = new starling.display.Quad(CHART_AXIS_THICKNESS, CHART_AXIS_INTERVAL_LINE_SIZE, CHART_AXIS_COLOR);
                    loc10.y = loc16.y;
                    loc10.x = GUTTER_LEFT + loc6 * loc28 / loc19;
                    addChild(loc10);
                    if (!(loc29 < loc27)) 
                    {
                        loc14 = new feathers.controls.Label();
                        loc14.styleName = "SMALLLISTLABEL";
                        if (this.xValueName != core.activities.ActivityEntryMapper.col_trainingTimeAbsolute) 
                        {
                            if (this.xValueName == core.activities.ActivityEntryMapper.col_distanceAbsolute || this.xValueName == "distance") 
                            {
                                loc14.text = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc28));
                            }
                        }
                        else 
                        {
                            loc14.text = backend.utils.DataUtils.timeFormatterHHMM.format(loc28);
                        }
                        addChild(loc14);
                        loc14.validate();
                        loc14.layoutData = new feathers.layout.AnchorLayoutData(loc10.y + loc10.height * 2, NaN, NaN, loc10.x - loc14.width / 2);
                        loc27 = loc10.x + loc14.width;
                    }
                    ++loc2;
                }
            }
            return;
        }

        internal function yHeadLabelFactory():feathers.core.ITextRenderer
        {
            var loc1:*=new feathers.controls.text.TextFieldTextRenderer();
            loc1.textFormat = new flash.text.TextFormat(feathers.themes.BaseSIGMATheme.FONT_NAME, 22 * SIGMALink.scaleFactor, this.graphColor);
            return loc1;
        }

        public static const CHART_COMP_HEIGHT:Number=(SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT) / 2;

        public static const GUTTER_TOP:Number=55 * SIGMALink.scaleFactor;

        internal static const CHART_AXIS_COLOR:Number=3028545;

        internal static const CHART_AXIS_INTERVAL_LINE_SIZE:Number=8 * SIGMALink.scaleFactor;

        internal static const CHART_AXIS_THICKNESS:Number=2 * SIGMALink.scaleFactor;

        internal static const CHART_GRAPH_THICKNESS:Number=4 * SIGMALink.scaleFactor;

        internal static const CHART_HEADLINE_PADDING_LEFT:Number=20 * SIGMALink.scaleFactor;

        internal static const GUTTER_BOTTOM:Number=50 * SIGMALink.scaleFactor;

        internal static const GUTTER_LEFT:Number=90 * SIGMALink.scaleFactor;

        internal static const GUTTER_RIGHT:Number=35 * SIGMALink.scaleFactor;

        internal var _entries:__AS3__.vec.Vector.<Object>;

        public var graphColor:uint;

        public var speedTime:Boolean=false;

        public var xValueName:String="trainingTimeAbsolute";

        internal var _1691484629yAchseLabel:String;

        public var yIntervalFix:Number;

        public var yLabelConverter:utils.converter.IConverter;

        public var yLabelFormatter:utils.interfaces.ICustomFormatterBase;

        public var yMaxFix:Number=NaN;

        public var yMinFix:Number=NaN;

        public var yValueName:String;

        internal var yInterval:Number;

        internal var yMax:Number;

        internal var yMin:Number;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class ActivityValueComp
package frontend.screen.activities.component 
{
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class ActivityValueComp extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityValueComp()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1852194636ROW_HEIGHT = 100 * SIGMALink.scaleFactor;
            this._102102gap = 10 * SIGMALink.scaleFactor;
            this._806339567padding = 10 * SIGMALink.scaleFactor;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityValueComp_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_component_ActivityValueCompWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ActivityValueComp[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ActivityValueComp_LayoutGroup2_i()];
            this._ActivityValueComp_AnchorLayoutData1_i();
            this._ActivityValueComp_AnchorLayoutData3_i();
            this._ActivityValueComp_AnchorLayoutData2_i();
            this.addEventListener("initialize", this.___ActivityValueComp_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___ActivityValueComp_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _ActivityValueComp_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, null, null, "this.height", "ROW_HEIGHT");
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[3] = new feathers.binding.Binding(this, null, null, "iconAndLabelLayout.left", "padding");
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return COL_UNIT_WIDTH + padding;
            }, null, "valueLayout.right")
            result[5] = new feathers.binding.Binding(this, null, null, "unitLayout.right", "padding");
            result[6] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_LayoutGroup2.height", "ROW_HEIGHT");
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ActivityValueComp_LayoutGroup2.width")
            result[8] = new feathers.binding.Binding(this, null, null, "iconAndLabelGroup.layoutData", "iconAndLabelLayout");
            result[9] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout1.gap", "gap");
            result[10] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout1.paddingLeft", "padding");
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout1.verticalAlign")
            result[12] = new feathers.binding.Binding(this, null, null, "valueGroup.layoutData", "valueLayout");
            result[13] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout2.gap", "gap");
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.RIGHT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout2.horizontalAlign")
            result[15] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout2.paddingRight", "padding");
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout2.verticalAlign")
            result[17] = new feathers.binding.Binding(this, null, null, "unitGroup.layoutData", "unitLayout");
            result[18] = new feathers.binding.Binding(this, function ():Number
            {
                return COL_UNIT_WIDTH;
            }, null, "unitGroup.width")
            result[19] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout3.gap", "gap");
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.LEFT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout3.horizontalAlign")
            result[21] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout3.paddingLeft", "padding");
            result[22] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout3.paddingRight", "padding");
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout3.verticalAlign")
            return result;
        }

        public function get iconAndLabelGroup():feathers.controls.LayoutGroup
        {
            return this._1856091433iconAndLabelGroup;
        }

        public function set iconAndLabelGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1856091433iconAndLabelGroup;
            if (loc1 !== arg1) 
            {
                this._1856091433iconAndLabelGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconAndLabelGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get iconAndLabelLayout():feathers.layout.AnchorLayoutData
        {
            return this._1831997888iconAndLabelLayout;
        }

        public function set iconAndLabelLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1831997888iconAndLabelLayout;
            if (loc1 !== arg1) 
            {
                this._1831997888iconAndLabelLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconAndLabelLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ActivityValueComp_HorizontalLayout1_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._ActivityValueComp_HorizontalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityValueComp_HorizontalLayout1", this._ActivityValueComp_HorizontalLayout1);
            return loc1;
        }

        public function get unitGroup():feathers.controls.LayoutGroup
        {
            return this._494502053unitGroup;
        }

        public function set unitGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._494502053unitGroup;
            if (loc1 !== arg1) 
            {
                this._494502053unitGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unitLayout():feathers.layout.AnchorLayoutData
        {
            return this._1978043854unitLayout;
        }

        public function set unitLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1978043854unitLayout;
            if (loc1 !== arg1) 
            {
                this._1978043854unitLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get valueGroup():feathers.controls.LayoutGroup
        {
            return this._2021110670valueGroup;
        }

        public function set valueGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2021110670valueGroup;
            if (loc1 !== arg1) 
            {
                this._2021110670valueGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "valueGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get valueLayout():feathers.layout.AnchorLayoutData
        {
            return this._1642340357valueLayout;
        }

        public function set valueLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1642340357valueLayout;
            if (loc1 !== arg1) 
            {
                this._1642340357valueLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "valueLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get ROW_HEIGHT():uint
        {
            return this._1852194636ROW_HEIGHT;
        }

        public function get gap():Number
        {
            return this._102102gap;
        }

        public function set gap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._102102gap;
            if (loc1 !== arg1) 
            {
                this._102102gap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "gap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get padding():Number
        {
            return this._806339567padding;
        }

        public function set padding(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._806339567padding;
            if (loc1 !== arg1) 
            {
                this._806339567padding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "padding", loc1, arg1, this);
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
            ActivityValueComp._watcherSetupUtil = arg1;
            return;
        }

        public function setValue(arg1:Object, arg2:utils.converter.IConverter=null, arg3:utils.interfaces.ICustomFormatterBase=null):void
        {
            if (arg2) 
            {
                if (arg3) 
                {
                    this.value = arg3.format(arg2.convert(arg1));
                }
                else 
                {
                    this.value = arg2.convert(arg1);
                }
            }
            else if (arg3) 
            {
                this.value = arg3.format(arg1);
            }
            else 
            {
                this.value = arg1;
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (this.iconSource) 
            {
                loc3 = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(this.iconSource));
                this.iconAndLabelGroup.addChild(loc3);
            }
            if (this.iconText) 
            {
                loc4 = new frontend.components.LangLabel();
                loc4.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
                loc4.text = this.iconText;
                this.iconAndLabelGroup.addChild(loc4);
            }
            if (this.iconTextTranslated) 
            {
                loc5 = new feathers.controls.Label();
                loc5.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
                loc5.text = this.iconTextTranslated;
                this.iconAndLabelGroup.addChild(loc5);
            }
            if (this.valueIconSource != null) 
            {
                loc6 = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(this.valueIconSource));
                this.valueGroup.addChild(loc6);
            }
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            loc1.text = this.value as String;
            this.valueGroup.addChild(loc1);
            var loc2:*=new feathers.controls.Label();
            loc2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            loc2.width = COL_UNIT_WIDTH;
            loc2.text = this.unit;
            loc2.addEventListener(starling.events.TouchEvent.TOUCH, this.onUnitLabelTouch);
            this.unitGroup.addChild(loc2);
            return;
        }

        internal function onUnitLabelTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.clickCallback != null) 
            {
                this.clickCallback();
            }
            return;
        }

        internal function _ActivityValueComp_AnchorLayoutData1_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.bottom = 0;
            loc1.top = 0;
            this.iconAndLabelLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "iconAndLabelLayout", this.iconAndLabelLayout);
            return loc1;
        }

        internal function _ActivityValueComp_AnchorLayoutData3_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.bottom = 0;
            loc1.top = 0;
            this.unitLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "unitLayout", this.unitLayout);
            return loc1;
        }

        internal function _ActivityValueComp_AnchorLayoutData2_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.bottom = 0;
            loc1.top = 0;
            this.valueLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "valueLayout", this.valueLayout);
            return loc1;
        }

        internal function _ActivityValueComp_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityValueComp_AnchorLayout1_c();
            loc1.mxmlContent = [this._ActivityValueComp_LayoutGroup3_i(), this._ActivityValueComp_LayoutGroup4_i(), this._ActivityValueComp_LayoutGroup5_i()];
            loc1.id = "_ActivityValueComp_LayoutGroup2";
            this._ActivityValueComp_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityValueComp_LayoutGroup2", this._ActivityValueComp_LayoutGroup2);
            return loc1;
        }

        internal function _ActivityValueComp_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityValueComp_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityValueComp_HorizontalLayout1_i();
            loc1.id = "iconAndLabelGroup";
            this.iconAndLabelGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "iconAndLabelGroup", this.iconAndLabelGroup);
            return loc1;
        }

        public function set ROW_HEIGHT(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1852194636ROW_HEIGHT;
            if (loc1 !== arg1) 
            {
                this._1852194636ROW_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_HEIGHT", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ActivityValueComp_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityValueComp_HorizontalLayout2_i();
            loc1.id = "valueGroup";
            this.valueGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "valueGroup", this.valueGroup);
            return loc1;
        }

        internal function _ActivityValueComp_HorizontalLayout2_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._ActivityValueComp_HorizontalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityValueComp_HorizontalLayout2", this._ActivityValueComp_HorizontalLayout2);
            return loc1;
        }

        internal function _ActivityValueComp_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityValueComp_HorizontalLayout3_i();
            loc1.id = "unitGroup";
            this.unitGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "unitGroup", this.unitGroup);
            return loc1;
        }

        internal function _ActivityValueComp_HorizontalLayout3_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._ActivityValueComp_HorizontalLayout3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityValueComp_HorizontalLayout3", this._ActivityValueComp_HorizontalLayout3);
            return loc1;
        }

        internal static const COL_UNIT_WIDTH:uint=100 * SIGMALink.scaleFactor;

        public var _ActivityValueComp_HorizontalLayout1:feathers.layout.HorizontalLayout;

        public var _ActivityValueComp_HorizontalLayout2:feathers.layout.HorizontalLayout;

        public var _ActivityValueComp_HorizontalLayout3:feathers.layout.HorizontalLayout;

        public var _ActivityValueComp_LayoutGroup2:feathers.controls.LayoutGroup;

        internal var _1856091433iconAndLabelGroup:feathers.controls.LayoutGroup;

        internal var _1831997888iconAndLabelLayout:feathers.layout.AnchorLayoutData;

        internal var _1978043854unitLayout:feathers.layout.AnchorLayoutData;

        internal var _2021110670valueGroup:feathers.controls.LayoutGroup;

        internal var _1642340357valueLayout:feathers.layout.AnchorLayoutData;

        internal var _1852194636ROW_HEIGHT:uint;

        public var clickCallback:Function;

        internal var _102102gap:Number;

        public var iconSource:String;

        public var iconText:String;

        public var iconTextTranslated:String;

        internal var _806339567padding:Number;

        public var speedBasedValue:Number;

        public var unit:String;

        public var value:Object;

        public var valueIconSource:String;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal var _494502053unitGroup:feathers.controls.LayoutGroup;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  package list
//    class ActivitiesListGroup
package frontend.screen.activities.list 
{
    public class ActivitiesListGroup extends Object
    {
        public function ActivitiesListGroup(arg1:String, arg2:String)
        {
            this.children = new Array();
            this.header = new frontend.screen.activities.list.ActivitiesListGroupHeader();
            super();
            this.header.date = arg1;
            this.header.title = arg2;
            return;
        }

        public function addItem(arg1:frontend.screen.activities.list.ActivityListItem):void
        {
            if (arg1) 
            {
                this.children.push(arg1);
                this.sumDistance = this.sumDistance + arg1.distanceValue;
                this.sumTrainingTime = this.sumTrainingTime + arg1.trainingTimeValue;
                this.footer = new frontend.screen.activities.list.ActivitiesListGroupFooter(this.children.length, this.sumDistance, this.sumTrainingTime);
            }
            return;
        }

        public function addItemAt(arg1:frontend.screen.activities.list.ActivityListItem, arg2:int):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (arg1) 
            {
                loc1 = [];
                loc3 = this.children.length;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    if (loc2 == arg2) 
                    {
                        loc1.push(arg1);
                    }
                    loc1.push(this.children[loc2]);
                    ++loc2;
                }
                if (arg2 == loc3) 
                {
                    loc1.push(arg1);
                }
                this.children = loc1;
                this.sumDistance = this.sumDistance + arg1.distanceValue;
                this.sumTrainingTime = this.sumTrainingTime + arg1.trainingTimeValue;
                this.footer = new frontend.screen.activities.list.ActivitiesListGroupFooter(loc1.length, this.sumDistance, this.sumTrainingTime);
            }
            return;
        }

        public function removeItem(arg1:int):void
        {
            var loc1:*=null;
            if (arg1 < this.children.length) 
            {
                loc1 = this.children.removeAt(arg1);
                this.sumDistance = this.sumDistance - loc1.distanceValue;
                this.sumTrainingTime = this.sumTrainingTime - loc1.trainingTimeValue;
                this.footer = new frontend.screen.activities.list.ActivitiesListGroupFooter(this.children.length, this.sumDistance, this.sumTrainingTime);
            }
            return;
        }

        public var children:Array;

        public var footer:frontend.screen.activities.list.ActivitiesListGroupFooter;

        public var header:frontend.screen.activities.list.ActivitiesListGroupHeader;

        internal var sumDistance:Number=0;

        internal var sumTrainingTime:Number=0;
    }
}


//    class ActivitiesListGroupFooter
package frontend.screen.activities.list 
{
    import frontend.*;
    import starling.textures.*;
    
    public class ActivitiesListGroupFooter extends Object
    {
        public function ActivitiesListGroupFooter(arg1:uint, arg2:Number, arg3:Number)
        {
            super();
            this.length = arg1;
            this.distance = arg2;
            this.trainingTime = arg3;
            this.statisticIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmallcount);
            this.distanceIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalldistance);
            this.timeIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalltime);
            return;
        }

        public function toString():String
        {
            return "";
        }

        public var distance:Number;

        public var distanceIcon:starling.textures.Texture;

        public var length:uint;

        public var statisticIcon:starling.textures.Texture;

        public var timeIcon:starling.textures.Texture;

        public var trainingTime:Number;
    }
}


//    class ActivitiesListGroupHeader
package frontend.screen.activities.list 
{
    public class ActivitiesListGroupHeader extends Object
    {
        public function ActivitiesListGroupHeader()
        {
            super();
            return;
        }

        public function toString():String
        {
            return "";
        }

        public var date:String;

        public var title:String;
    }
}


//    class ActivitiesSelectorItemRenderer
package frontend.screen.activities.list 
{
    import backend.utils.*;
    import core.activities.*;
    import core.general.*;
    import core.sport.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.text.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.menuList.editors.custom.*;
    import frontend.components.popup.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class ActivitiesSelectorItemRenderer extends frontend.components.list.SelectableGroupedListItemRenderer
    {
        public function ActivitiesSelectorItemRenderer()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.textAlign = "left";
                loc1.autoCorrect = true;
                loc1.softKeyboardType = flash.text.SoftKeyboardType.DEFAULT;
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                return loc1;
            }
            super();
            return;
        }

        public override function set data(arg1:Object):void
        {
            super.data = arg1;
            return;
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (activitiesEditState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        public override function set owner(arg1:feathers.controls.GroupedList):void
        {
            super.owner = arg1;
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            editGroup.visible = activitiesEditState;
            return;
        }

        internal function activity():frontend.screen.activities.list.ActivityListItem
        {
            if (data is frontend.screen.activities.list.ActivityListItem) 
            {
                return data as frontend.screen.activities.list.ActivityListItem;
            }
            return null;
        }

        
        {
            activitiesEditState = false;
            customPadding = 17 * SIGMALink.scaleFactor;
            iconGroupWidth = 65 * SIGMALink.scaleFactor;
            iconPaddingTop = 6 * SIGMALink.scaleFactor;
            unitWidth = 50 * SIGMALink.scaleFactor;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            activitiesEditState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            var loc1:*=this.activity();
            if (loc1 && !activitiesEditState) 
            {
                frontend.components.list.SelectableListItem.reset();
            }
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
            {
                loc1.addSelection();
            }
            else 
            {
                loc1.defaultSelected = false;
                loc1.removeSelection();
            }
            return;
        }

        internal function onGroupTouched(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=0;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc2:*=handler.SportHandler.getInstance().sports.length;
            var loc3:*=new feathers.data.ListCollection();
            var loc4:*=(this.activity() as frontend.screen.activities.list.ActivityListItem).activity;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (handler.SportHandler.getInstance().sports[loc1].keyName != core.sport.Sport.ACTIVITY_TRACKER) 
                {
                    loc3.push({"label":handler.SportHandler.getInstance().sports[loc1].name, "data":handler.SportHandler.getInstance().sports[loc1].sportId, "selected":handler.SportHandler.getInstance().sports[loc1].sportId == loc4.sportId});
                }
                ++loc1;
            }
            this._editor = new frontend.components.menuList.editors.custom.SportAndNameEditor();
            this._editor.dataProvider = loc3;
            this._editor.owner = new frontend.components.menuList.MenuListItem();
            this._editor.rawValue = {"name":loc4.name, "sport":loc4.sportId};
            this._editor.title = utils.LanguageManager.getString("ACTIVITYVIEW.EDIT_NAME");
            this._editor.saveCompleteCallback = this.valueChanged;
            frontend.components.popup.PopUpBase.showModalPopUp(this._editor, true, true);
            return;
        }

        internal function valueChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            debug.Debug.debug("p_returnObj: " + arg2.rawValue);
            var loc1:*=this.activity();
            if (loc1) 
            {
                if (arg2.rawValue.hasOwnProperty("name")) 
                {
                    loc1.name = arg2.rawValue.name;
                    loc1.activity.name = arg2.rawValue.name;
                }
                else 
                {
                    debug.Debug.error("Return-Wert für Name fehlt!");
                }
                if (arg2.rawValue.hasOwnProperty("sport")) 
                {
                    loc1.activity.sportId = arg2.rawValue.sport;
                    loc1.activity.sport = handler.SportHandler.getInstance().resolveSportById(arg2.rawValue.sport);
                    loc1.sport = loc1.activity.sport;
                    loc1.sportIcon = handler.SportHandler.getSportIcon(loc1.sport);
                    loc1.sportBackgroundSkin = handler.SportHandler.getSportBackgroundSkin(loc1.sport);
                }
                else 
                {
                    debug.Debug.error("Return-Wert für Sport fehlt!");
                }
                this.commitData();
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._labelNewOrUpdate = new feathers.controls.Label();
            this._labelNewOrUpdate.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLWHITELABEL;
            this._labelNewOrUpdate.layoutData = new feathers.layout.VerticalLayoutData();
            editGroup.addChild(this._labelNewOrUpdate);
            this._holderGroup = new feathers.controls.LayoutGroup();
            this._holderGroup.width = SIGMALink.appWidth;
            this._holderGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._holderGroup.layout = new feathers.layout.AnchorLayout();
            this._holderGroup.touchGroup = true;
            this._holderGroup.touchable = true;
            this._holderGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this._holderGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onGroupTouched);
            addChild(this._holderGroup);
            this._editIcon = new frontend.components.TextureImage();
            this._editIcon.textureName = frontend.Textures.linkiconsmall;
            this._editIcon.layoutData = new feathers.layout.AnchorLayoutData(1, 1);
            this._holderGroup.addChild(this._editIcon);
            this._iconGroup = new feathers.controls.LayoutGroup();
            this._iconGroup.width = iconGroupWidth;
            this._iconGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._iconGroup.layout = new feathers.layout.AnchorLayout();
            this._iconGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, 0);
            this._holderGroup.addChild(this._iconGroup);
            this._image = new frontend.components.TextureImage();
            this._image.layoutData = new feathers.layout.AnchorLayoutData(iconPaddingTop, NaN, NaN, NaN, 0, NaN);
            this._image.touchable = false;
            this._iconGroup.addChild(this._image);
            this._labelDayOfMonth = new feathers.controls.Label();
            this._labelDayOfMonth.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, customPadding);
            this._iconGroup.addChild(this._labelDayOfMonth);
            this._labelActivityName = new feathers.controls.Label();
            this._labelActivityName.width = SIGMALink.appWidth - editGroupWidth - iconGroupWidth;
            this._labelActivityName.layoutData = new feathers.layout.AnchorLayoutData(customPadding, NaN, NaN, customPadding + iconGroupWidth);
            this._labelActivityName.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
            this._holderGroup.addChild(this._labelActivityName);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDistance.layoutData = new feathers.layout.AnchorLayoutData(customPadding, unitWidth + (customPadding << 1), NaN, NaN);
            this._holderGroup.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelDistanceUnit.layoutData = new feathers.layout.AnchorLayoutData(customPadding, NaN, NaN, SIGMALink.appWidth - unitWidth - customPadding);
            this._holderGroup.addChild(this._labelDistanceUnit);
            this._labelTrainingTime = new feathers.controls.Label();
            this._labelTrainingTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelTrainingTime.layoutData = new feathers.layout.AnchorLayoutData(NaN, unitWidth + (customPadding << 1), customPadding);
            this._holderGroup.addChild(this._labelTrainingTime);
            this._labelTrainingTimeUnit = new feathers.controls.Label();
            this._labelTrainingTimeUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelTrainingTimeUnit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, customPadding, SIGMALink.appWidth - unitWidth - customPadding);
            this._holderGroup.addChild(this._labelTrainingTimeUnit);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            if (loc1.isUpdate) 
            {
                this._labelNewOrUpdate.text = utils.LanguageManager.getString("ACTIVITY_SELECTOR.IS_UPDATE");
            }
            else if (loc1.isNew) 
            {
                this._labelNewOrUpdate.text = utils.LanguageManager.getString("ACTIVITY_SELECTOR.IS_NEW");
            }
            else 
            {
                this._labelNewOrUpdate.text = " ";
            }
            this._labelDayOfMonth.text = loc1.startDate.date + "";
            this._labelDayOfMonth.styleName = loc1.sport.labelColor != 16777215 ? feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL : feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_WHITE;
            this._image.source = loc1.sportIcon;
            this._iconGroup.backgroundSkin = loc1.sportBackgroundSkin;
            if (loc1.name != "") 
            {
                this._labelActivityName.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                this._labelActivityName.text = loc1.name;
            }
            else 
            {
                this._labelActivityName.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_LIGHT;
                this._labelActivityName.text = utils.LanguageManager.getString("ACTIVITYVIEW.EDIT_NAME_PLACEHOLDER");
            }
            this._labelDistance.text = loc1.distance;
            this._labelDistance.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistance.validate();
            this._labelDistanceUnit.text = backend.utils.DataUtils.unitStringDistance;
            this._labelDistanceUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistanceUnit.validate();
            this._labelTrainingTime.text = loc1.trainingTime;
            this._labelTrainingTimeUnit.text = backend.utils.DataUtils.unitStringTimeHours;
            this._labelTrainingTime.validate();
            this._holderGroup.x = activitiesEditState ? editGroupWidth + 1 : 0;
            this._holderGroup.width = activitiesEditState ? (SIGMALink.appWidth - editGroupWidth - 1) : SIGMALink.appWidth;
            this._labelActivityName.width = SIGMALink.appWidth - editGroupWidth - iconGroupWidth - this._labelTrainingTime.width - unitWidth - 4 * customPadding;
            var loc2:*=SIGMALink.appWidth - unitWidth - customPadding;
            if (activitiesEditState) 
            {
                loc2 = loc2 - editGroupWidth;
            }
            var loc3:*=this._labelDistanceUnit.layoutData as feathers.layout.AnchorLayoutData;
            loc3.top = customPadding + (this._labelDistance.height - this._labelDistanceUnit.height >> 1);
            loc3.left = loc2;
            var loc4:*=this._labelTrainingTimeUnit.layoutData as feathers.layout.AnchorLayoutData;
            loc4.bottom = loc3.top;
            loc4.left = loc2;
            if (loc1.defaultSelected) 
            {
                loc1.addSelection();
                checkbox.isSelected = true;
            }
            else 
            {
                checkbox.isSelected = loc1.isSelected();
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        internal var _editIcon:frontend.components.TextureImage;

        internal var _editor:frontend.components.menuList.editors.custom.SportAndNameEditor;

        internal var _holderGroup:feathers.controls.LayoutGroup;

        internal var _iconGroup:feathers.controls.LayoutGroup;

        internal var _image:frontend.components.TextureImage;

        internal var _labelActivityName:feathers.controls.Label;

        internal var _labelDayOfMonth:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _labelNewOrUpdate:feathers.controls.Label;

        internal var _labelTrainingTime:feathers.controls.Label;

        internal var _labelTrainingTimeUnit:feathers.controls.Label;

        internal var stageTextEditorFunc:Function;

        internal static var activitiesEditState:Boolean=false;

        internal static var customPadding:Number;

        internal static var iconGroupWidth:Number;

        internal static var iconPaddingTop:Number;

        internal static var unitWidth:Number;

        internal var _moving:Boolean=false;
    }
}


//    class ActivityListEvent
package frontend.screen.activities.list 
{
    import core.activities.*;
    import flash.events.*;
    
    public class ActivityListEvent extends flash.events.Event
    {
        public function ActivityListEvent(arg1:String, arg2:core.activities.Activity=null, arg3:String="", arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            this.activity = arg2;
            this.GUID = arg3;
            return;
        }

        public static const DELETE:String="deleteActivityEvent";

        public static const RELOAD:String="reloadActivitiesEvent";

        public static const UPDATE:String="updateActivityInListEvent";

        public var GUID:String="";

        public var activity:core.activities.Activity;

        public var resetLastScrollPosition:Boolean=false;
    }
}


//    class ActivityListItem
package frontend.screen.activities.list 
{
    import core.activities.*;
    import core.sport.*;
    import frontend.components.list.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class ActivityListItem extends frontend.components.list.SelectableListItem
    {
        public function ActivityListItem()
        {
            this.startDate = new Date();
            super();
            return;
        }

        public var activity:core.activities.Activity;

        public var activityId:uint;

        public var defaultSelected:Boolean=false;

        public var distance:String;

        public var distanceValue:Number=0;

        public var isNew:Boolean=false;

        public var isUpdate:Boolean=false;

        public var name:String="";

        public var shareIcon:starling.textures.Texture;

        public var shared:Boolean=false;

        public var sport:core.sport.Sport;

        public var sportBackgroundSkin:starling.display.Quad;

        public var sportIcon:starling.textures.Texture;

        public var startDate:Date;

        public var trainingTime:String;

        public var trainingTimeValue:Number=0;
    }
}


//    class ActivityListItemFooterRenderer
package frontend.screen.activities.list 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import starling.display.*;
    
    public class ActivityListItemFooterRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityListItemFooterRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            super();
            touchable = false;
            height = footerHeight;
            return;
        }

        public override function set data(arg1:Object):void
        {
            super.data = arg1;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.layout = new feathers.layout.AnchorLayout();
            this._group.width = SIGMALink.appWidth;
            this._group.height = footerHeight;
            this._group.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            addChild(this._group);
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = customPadding;
            loc1.verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            this.statisticGroup = new feathers.controls.LayoutGroup();
            this.statisticGroup.height = footerHeight;
            this.statisticGroup.layout = loc1;
            this.statisticGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding, NaN, 0);
            this._group.addChild(this.statisticGroup);
            this._imgStatistic = new frontend.components.TextureImage();
            this.statisticGroup.addChild(this._imgStatistic);
            this._labelStatistic = new feathers.controls.Label();
            this._labelStatistic.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.statisticGroup.addChild(this._labelStatistic);
            this.distGroup = new feathers.controls.LayoutGroup();
            this.distGroup.height = footerHeight;
            this.distGroup.layout = loc1;
            this._group.addChild(this.distGroup);
            this._imgDistance = new frontend.components.TextureImage();
            this.distGroup.addChild(this._imgDistance);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.distGroup.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelDistanceUnit.text = backend.utils.DataUtils.unitStringDistance;
            this.distGroup.addChild(this._labelDistanceUnit);
            this.timeGroup = new feathers.controls.LayoutGroup();
            this.timeGroup.height = footerHeight;
            this.timeGroup.layout = loc1;
            this.timeGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, customPadding, NaN, NaN, NaN, 0);
            this._group.addChild(this.timeGroup);
            this._imgTime = new frontend.components.TextureImage();
            this.timeGroup.addChild(this._imgTime);
            this._labelTime = new feathers.controls.Label();
            this._labelTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.timeGroup.addChild(this._labelTime);
            this._labelTimeUnit = new feathers.controls.Label();
            this._labelTimeUnit.width = unitWidth;
            this._labelTimeUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelTimeUnit.text = backend.utils.DataUtils.unitStringTimeHours;
            this.timeGroup.addChild(this._labelTimeUnit);
            var loc2:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc2);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.list.ActivitiesListGroupFooter;
            if (!loc1) 
            {
                return;
            }
            this._labelStatistic.text = loc1.length + "";
            this._labelDistance.text = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc1.distance));
            this._labelTime.text = backend.utils.DataUtils.timeFormatter.format(loc1.trainingTime);
            this._imgStatistic.source = loc1.statisticIcon;
            this.statisticGroup.invalidate(INVALIDATION_FLAG_SIZE);
            this.statisticGroup.validate();
            this._imgDistance.source = loc1.distanceIcon;
            this.distGroup.invalidate(INVALIDATION_FLAG_SIZE);
            this.distGroup.validate();
            this._imgTime.source = loc1.timeIcon;
            this.timeGroup.invalidate(INVALIDATION_FLAG_SIZE);
            this.timeGroup.validate();
            var loc2:*=(SIGMALink.appWidth - this.statisticGroup.width - this.distGroup.width - this.timeGroup.width - 4 * customPadding) / 2;
            loc2 = loc2 + (customPadding * 2 + this.statisticGroup.width);
            this.distGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, loc2, NaN, 0);
            return;
        }

        
        {
            customPadding = 17 * SIGMALink.scaleFactor;
            footerHeight = 70 * SIGMALink.scaleFactor;
            unitWidth = 50 * SIGMALink.scaleFactor;
        }

        internal var _group:feathers.controls.LayoutGroup;

        internal var _imgDistance:frontend.components.TextureImage;

        internal var _imgStatistic:frontend.components.TextureImage;

        internal var _imgTime:frontend.components.TextureImage;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _labelStatistic:feathers.controls.Label;

        internal var _labelTime:feathers.controls.Label;

        internal var _labelTimeUnit:feathers.controls.Label;

        internal var distGroup:feathers.controls.LayoutGroup;

        internal var statisticGroup:feathers.controls.LayoutGroup;

        internal var timeGroup:feathers.controls.LayoutGroup;

        internal static var customPadding:Number;

        internal static var footerHeight:Number;

        internal static var unitWidth:Number;
    }
}


//    class ActivityListItemHeaderRenderer
package frontend.screen.activities.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    
    public class ActivityListItemHeaderRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityListItemHeaderRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            this._labelDate = new feathers.controls.Label();
            super();
            touchable = false;
            height = headerHeight;
            styleProvider = null;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.layout = new feathers.layout.AnchorLayout();
            this._group.width = SIGMALink.appWidth;
            this._group.height = headerHeight;
            this._group.backgroundSkin = new starling.display.Quad(SIGMALink.appWidth, headerHeight, core.general.Colors.LIGHTGREY);
            addChild(this._group);
            this._labelDate = new feathers.controls.Label();
            this._labelDate.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
            this._labelDate.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, NaN, PADDING, NaN, PADDING / 2);
            this._group.addChild(this._labelDate);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.list.ActivitiesListGroupHeader;
            if (!loc1) 
            {
                return;
            }
            this._labelDate.text = loc1.title;
            return;
        }

        
        {
            headerHeight = 67 * SIGMALink.scaleFactor;
        }

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _labelDate:feathers.controls.Label;

        internal static var headerHeight:Number;
    }
}


//    class ActivityListItemRenderer
package frontend.screen.activities.list 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ActivityListItemRenderer extends frontend.components.list.SelectableGroupedListItemRenderer
    {
        public function ActivityListItemRenderer()
        {
            super();
            return;
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (activitiesEditState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            activitiesEditState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
            {
                loc1.addSelection();
            }
            else 
            {
                loc1.removeSelection();
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._iconGroup = new feathers.controls.LayoutGroup();
            this._iconGroup.width = iconGroupWidth;
            this._iconGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._iconGroup.layout = new feathers.layout.AnchorLayout();
            this._iconGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, 0);
            this._group.addChild(this._iconGroup);
            this._image = new frontend.components.TextureImage();
            this._image.layoutData = new feathers.layout.AnchorLayoutData(iconPaddingTop, NaN, NaN, NaN, 0, NaN);
            this._image.touchable = false;
            this._iconGroup.addChild(this._image);
            this._labelDayOfMonth = new feathers.controls.Label();
            this._labelDayOfMonth.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, customPadding);
            this._iconGroup.addChild(this._labelDayOfMonth);
            this._labelName = new feathers.controls.Label();
            this._labelName.wordWrap = false;
            this._labelName.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this._labelName.layoutData = new feathers.layout.AnchorLayoutData(customPadding, NaN, NaN, customPadding + iconGroupWidth);
            this._group.addChild(this._labelName);
            this._shareIcon = new frontend.components.TextureImage();
            this._shareIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, customPadding, customPadding + iconGroupWidth);
            this._shareIcon.addEventListener(starling.events.Event.TRIGGERED, this.onShareIconTriggered);
            this._group.addChild(this._shareIcon);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDistance.layoutData = new feathers.layout.AnchorLayoutData(customPadding, unitWidth + (customPadding << 1), NaN, NaN);
            this._group.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelDistanceUnit.layoutData = new feathers.layout.AnchorLayoutData(customPadding, NaN, NaN, SIGMALink.appWidth - unitWidth - customPadding);
            this._group.addChild(this._labelDistanceUnit);
            this._labelTrainingTime = new feathers.controls.Label();
            this._labelTrainingTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelTrainingTime.layoutData = new feathers.layout.AnchorLayoutData(NaN, unitWidth + (customPadding << 1), customPadding);
            this._group.addChild(this._labelTrainingTime);
            this._labelTrainingTimeUnit = new feathers.controls.Label();
            this._labelTrainingTimeUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelTrainingTimeUnit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, customPadding, SIGMALink.appWidth - unitWidth - customPadding);
            this._group.addChild(this._labelTrainingTimeUnit);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        internal function onShareIconTriggered(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            arg1.stopImmediatePropagation();
            var loc1:*=this.activity();
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_SHARE_ACTIVITY, {"activityId":loc1.activityId}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            this._labelDayOfMonth.text = loc1.startDate.date + "";
            this._labelDayOfMonth.styleName = loc1.sport.labelColor != 16777215 ? feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL : feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_WHITE;
            this._image.source = loc1.sportIcon;
            this._iconGroup.backgroundSkin = loc1.sportBackgroundSkin;
            this._labelName.text = loc1.name;
            if (this._group.contains(this._shareIcon)) 
            {
                if (loc1.shareIcon) 
                {
                    this._shareIcon.includeInLayout = true;
                    this._shareIcon.source = loc1.shareIcon;
                }
                else 
                {
                    this._shareIcon.includeInLayout = false;
                }
            }
            this._labelDistance.text = loc1.distance;
            this._labelDistance.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistance.validate();
            this._labelDistanceUnit.text = backend.utils.DataUtils.unitStringDistance;
            this._labelDistanceUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistanceUnit.validate();
            this._labelTrainingTime.text = loc1.trainingTime;
            this._labelTrainingTimeUnit.text = backend.utils.DataUtils.unitStringTimeHours;
            this._group.x = activitiesEditState ? editGroupWidth + 1 : 0;
            this._group.width = activitiesEditState ? (SIGMALink.appWidth - editGroupWidth - 1) : SIGMALink.appWidth;
            var loc2:*=SIGMALink.appWidth - unitWidth - iconGroupWidth - 4 * customPadding - this._labelDistance.width;
            var loc3:*=SIGMALink.appWidth - unitWidth - customPadding;
            if (activitiesEditState) 
            {
                loc2 = loc2 - editGroupWidth;
                loc3 = loc3 - editGroupWidth;
            }
            this._labelName.width = loc2;
            var loc4:*=this._labelDistanceUnit.layoutData as feathers.layout.AnchorLayoutData;
            loc4.top = customPadding + (this._labelDistance.height - this._labelDistanceUnit.height >> 1);
            loc4.left = loc3;
            var loc5:*=this._labelTrainingTimeUnit.layoutData as feathers.layout.AnchorLayoutData;
            loc5.bottom = loc4.top;
            loc5.left = loc3;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            editGroup.visible = activitiesEditState;
            checkbox.isSelected = loc1.isSelected();
            return;
        }

        internal function activity():frontend.screen.activities.list.ActivityListItem
        {
            if (data is frontend.screen.activities.list.ActivityListItem) 
            {
                return data as frontend.screen.activities.list.ActivityListItem;
            }
            return null;
        }

        
        {
            activitiesEditState = false;
            customPadding = 17 * SIGMALink.scaleFactor;
            iconGroupWidth = 65 * SIGMALink.scaleFactor;
            iconPaddingTop = 6 * SIGMALink.scaleFactor;
            unitWidth = 50 * SIGMALink.scaleFactor;
        }

        internal var _group:feathers.controls.LayoutGroup;

        internal var _iconGroup:feathers.controls.LayoutGroup;

        internal var _image:frontend.components.TextureImage;

        internal var _labelDayOfMonth:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _labelName:feathers.controls.Label;

        internal var _labelTrainingTime:feathers.controls.Label;

        internal var _labelTrainingTimeUnit:feathers.controls.Label;

        internal var _moving:Boolean=false;

        internal var _shareIcon:frontend.components.TextureImage;

        internal static var activitiesEditState:Boolean=false;

        internal static var customPadding:Number;

        internal static var iconGroupWidth:Number;

        internal static var iconPaddingTop:Number;

        internal static var unitWidth:Number;
    }
}


//  package share
//    class ActivityShare
package frontend.screen.activities.share 
{
    import backend.oauth.*;
    import backend.sharing.*;
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import core.general.*;
    import core.sport.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.menuList.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ActivityShare extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ActivityShare()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._iconButtonCallout = new frontend.components.button.IconButtonCallout();
            this._3685147yPos = HEADER_HEIGHT;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityShare_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_share_ActivityShareWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ActivityShare[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ActivityShare_LayoutGroup1_i(), this._ActivityShare_LayoutGroup2_i(), this._ActivityShare_LayoutGroup3_i(), this._ActivityShare_Footer1_c()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ActivityShare_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_ActivityShare_Label2";
            this._ActivityShare_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityShare_Label2", this._ActivityShare_Label2);
            return loc1;
        }

        internal function _ActivityShare_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "loader";
            this.loader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "loader", this.loader);
            return loc1;
        }

        internal function _ActivityShare_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.visible = false;
            loc1.layout = this._ActivityShare_AnchorLayout2_c();
            loc1.mxmlContent = [this._ActivityShare_Button1_i()];
            loc1.id = "shareButtonGroup";
            this.shareButtonGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "shareButtonGroup", this.shareButtonGroup);
            return loc1;
        }

        internal function _ActivityShare_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityShare_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.styleName = "WHITEBUTTON";
            loc1.addEventListener("touch", this.___ActivityShare_Button1_touch);
            loc1.id = "_ActivityShare_Button1";
            this._ActivityShare_Button1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityShare_Button1", this._ActivityShare_Button1);
            return loc1;
        }

        public function ___ActivityShare_Button1_touch(arg1:starling.events.TouchEvent):void
        {
            this.shareHandler(arg1);
            return;
        }

        internal function _ActivityShare_Footer1_c():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._ActivityShare_IconButton1_i()];
            return loc1;
        }

        internal function _ActivityShare_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "settingIcon";
            this.settingIcon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "settingIcon", this.settingIcon);
            return loc1;
        }

        internal function doSharing(arg1:String=null):void
        {
            handler.SharingHandler.getInstance().addEventListener(backend.sharing.SharingEvent.MULTI_SHARING_FINISHED, this.onSharingFinished);
            handler.SharingHandler.getInstance().addEventListener(backend.sharing.SharingEvent.SHARING_COMPLETE, this.onSharingComplete);
            handler.SharingHandler.getInstance().addEventListener(backend.sharing.SharingEvent.SHARING_ERROR, this.onSharingError);
            handler.SharingHandler.getInstance().doSharing(arg1);
            return;
        }

        public function set comesFromSharingOptions(arg1:Boolean):void
        {
            this._comesFromSharingOptions = arg1;
            if (this._comesFromSharingOptions) 
            {
                handler.ViewHandler.getInstance().addBackFunction(this.backButtonFunction);
                addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            }
            return;
        }

        internal function _ActivityShare_bindingsSetup():Array
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
                var loc1:*=utils.LanguageManager.getString("ACTIVITYSHARE.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "header.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return HEADER_HEIGHT;
            }, null, "header.height")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0);
            }, null, "header.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "header.width")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, frontend.screen.activities.share.ShareButton.PADDING, frontend.screen.activities.share.ShareButton.PADDING);
            }, null, "_ActivityShare_Label1.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.PLEASE_SELECT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityShare_Label1.text")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.activities.share.ShareButton.PADDING, frontend.screen.activities.share.ShareButton.PADDING);
            }, null, "_ActivityShare_Label2.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.SHARED");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityShare_Label2.text")
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            }, null, "loader.layoutData")
            result[11] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "shareButtonGroup.backgroundSkin")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "shareButtonGroup.height")
            result[13] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(yPos);
            }, null, "shareButtonGroup.layoutData")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "shareButtonGroup.width")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.SHARE_BUTTON");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityShare_Button1.label")
            result[16] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, NaN, 0);
            }, null, "_ActivityShare_Button1.layoutData")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ActivityShare_Button1.width")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.settingsiconwhite;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "settingIcon.image")
            result[19] = new feathers.binding.Binding(this, function ():Function
            {
                return openAccountSettings;
            }, null, "settingIcon.touchHandler")
            return result;
        }

        public function get header():feathers.controls.LayoutGroup
        {
            return this._1221270899header;
        }

        public function set header(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1221270899header;
            if (loc1 !== arg1) 
            {
                this._1221270899header = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "header", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get loader():feathers.controls.LayoutGroup
        {
            return this._1097519085loader;
        }

        public function set loader(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1097519085loader;
            if (loc1 !== arg1) 
            {
                this._1097519085loader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "loader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set settingIcon(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._122546455settingIcon;
            if (loc1 !== arg1) 
            {
                this._122546455settingIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "settingIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get shareButtonGroup():feathers.controls.LayoutGroup
        {
            return this._1554344690shareButtonGroup;
        }

        public function set shareButtonGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1554344690shareButtonGroup;
            if (loc1 !== arg1) 
            {
                this._1554344690shareButtonGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "shareButtonGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get yPos():Number
        {
            return this._3685147yPos;
        }

        internal function set yPos(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3685147yPos;
            if (loc1 !== arg1) 
            {
                this._3685147yPos = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "yPos", loc1, arg1, this);
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
            ActivityShare._watcherSetupUtil = arg1;
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            handler.ViewHandler.getInstance().removeBackFunction(this.backButtonFunction);
            return;
        }

        internal function backButtonFunction():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_LIST, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        protected override function validateProperties():void
        {
            this.addLoader();
            var loc1:*=handler.ActivityHandler.getInstance().generateLoadActivityStatement(this.activityId);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadActivityComplete, this.loadActivityError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function addLoader():void
        {
            this.loader.removeChildren();
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTextureAtlas("loaderAnimation");
            if (loc1) 
            {
                this.movieClip = new starling.display.MovieClip(loc1.getTextures("frame_"), 30);
                this.loader.addChild(this.movieClip);
                this.movieClip.play();
                if (!starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.add(this.movieClip);
                }
            }
            return;
        }

        internal function loadActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activitiesError");
            return;
        }

        internal function loadActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=null;
            var loc1:*=arg1.getResult();
            if (loc1.length == 0) 
            {
                return;
            }
            this._activity = core.activities.ActivityFactory.createLogFromDB(loc1[0], false);
            if (this._activity.dataType == core.general.DataType.LOG && this._activity.entries.length == 0) 
            {
                loc2 = handler.ActivityHandler.getInstance().generateLoadActivityEntries(this._activity.activityId);
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc2, this.loadActivityEntriesComplete, this.loadActivityEntriesError, Workers.worker_DatabaseWorker);
            }
            else 
            {
                this.validateContent();
            }
            return;
        }

        internal function loadActivityEntriesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activityEntriesError");
            return;
        }

        internal function loadActivityEntriesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().loadActivityEntriesComplete(arg1.getResult(), this._activity);
            var loc1:*=handler.ActivityHandler.getInstance().generateLoadActivityMarker(this._activity.activityId);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadActivityMarkerComplete, this.loadActivityMarkerError, Workers.worker_DatabaseWorker);
            this.validateContent();
            return;
        }

        internal function loadActivityMarkerError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activityMarkerError");
            return;
        }

        internal function loadActivityMarkerComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().loadActivityMarkerComplete(arg1.getResult(), this._activity);
            return;
        }

        internal function validateContent():void
        {
            var loc4:*=null;
            this.yPos = HEADER_HEIGHT;
            var loc1:*=1 * SIGMALink.scaleFactor;
            var loc2:*=0;
            var loc3:*=0;
            this.clearAccountButtons();
            if (contains(this._iconButtonCallout)) 
            {
                removeChild(this._iconButtonCallout);
            }
            if (!backend.oauth.StravaOAuth.getInstance().loggedOut) 
            {
                ++loc2;
                if (this.isValidLogActivity()) 
                {
                    ++loc3;
                    this.st = new frontend.screen.activities.share.ShareButton();
                    this.st.textureName = frontend.Textures.shareStrava;
                    this.st.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.STRAVA.TITLE");
                    this.st.shared = this._activity.sharedToStrava;
                    this.st.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                    addChild(this.st);
                    this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
                }
            }
            if (!backend.oauth.TrainingPeaksOAuth.getInstance().loggedOut) 
            {
                ++loc2;
                if (this.isValidLogActivity()) 
                {
                    ++loc3;
                    this.tp = new frontend.screen.activities.share.ShareButton();
                    this.tp.textureName = frontend.Textures.shareTrainingPeaks;
                    this.tp.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TRAININGPEAKS.TITLE");
                    this.tp.shared = this._activity.sharedToTrainingPeaks;
                    this.tp.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                    addChild(this.tp);
                    this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
                }
            }
            if (!backend.oauth.TwoPeakOAuth.getInstance().loggedOut) 
            {
                ++loc2;
                if (this.isValidLogActivity()) 
                {
                    ++loc3;
                    this._2p = new frontend.screen.activities.share.ShareButton();
                    this._2p.textureName = frontend.Textures.shareTwoPeak;
                    this._2p.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWOPEAK.TITLE");
                    this._2p.shared = this._activity.sharedTo2Peak;
                    this._2p.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                    addChild(this._2p);
                    this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
                }
            }
            if (!backend.oauth.FacebookGoViralHandler.getInstance().loggedOut) 
            {
                ++loc2;
                ++loc3;
                this.fb = new frontend.screen.activities.share.ShareButton();
                this.fb.textureName = frontend.Textures.shareFacebook;
                this.fb.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.FACEBOOK.TITLE");
                this.fb.shared = this._activity.sharedToFacebook;
                this.fb.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                addChild(this.fb);
                this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
            }
            if (!backend.oauth.TwitterOAuth.getInstance().loggedOut) 
            {
                ++loc2;
                ++loc3;
                this.tw = new frontend.screen.activities.share.ShareButton();
                this.tw.textureName = frontend.Textures.shareTwitter;
                this.tw.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWITTER.TITLE");
                this.tw.shared = this._activity.sharedToTwitter;
                this.tw.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                addChild(this.tw);
                this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
            }
            if (loc2 == 0 || loc3 == 0) 
            {
                this.shareButtonGroup.visible = false;
                this.header.visible = false;
                loc4 = "";
                if (loc2 == 0) 
                {
                    loc4 = utils.LanguageManager.getString("APPSETTINGS.KONTEN.NO_ACCOUNTS");
                }
                if (loc2 > 0 && loc3 == 0) 
                {
                    loc4 = utils.LanguageManager.getString("APPSETTINGS.KONTEN.NO_VALID_ACCOUNTS");
                }
                loc4 = loc4 + (" " + utils.LanguageManager.getString("NO_DATA_SHARING_ACCOUNTS"));
                this._iconButtonCallout.calloutText = loc4;
                this._iconButtonCallout.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, SIGMALink.footerHeight, NaN);
                this._iconButtonCallout.anchor = this.settingIcon;
                addChild(this._iconButtonCallout);
            }
            else 
            {
                this.shareButtonGroup.visible = true;
                this.header.visible = true;
            }
            return;
        }

        internal function clearAccountButtons():void
        {
            if (this.movieClip) 
            {
                this.movieClip.stop();
                if (starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.remove(this.movieClip);
                }
                this.movieClip = null;
            }
            this.loader.removeChildren();
            if (this.st) 
            {
                removeChild(this.st);
                this.st = null;
            }
            if (this.tp) 
            {
                removeChild(this.tp);
                this.tp = null;
            }
            if (this._2p) 
            {
                removeChild(this._2p);
                this._2p = null;
            }
            if (this.fb) 
            {
                removeChild(this.fb);
                this.fb = null;
            }
            if (this.tw) 
            {
                removeChild(this.tw);
                this.tw = null;
            }
            return;
        }

        internal function isValidLogActivity():Boolean
        {
            return this._activity.entries.length > 0 && !(this._activity.sport.keyName == core.sport.Sport.ACTIVITY_TRACKER);
        }

        internal function shareHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.SharingHandler.getInstance().prepareUpload();
            this._useOwnMessage = false;
            if (this.st && this.st.selected) 
            {
                this.st.startLoading();
                handler.SharingHandler.getInstance().addStravaActivity(this._activity);
            }
            if (this.tp && this.tp.selected) 
            {
                this.tp.startLoading();
                handler.SharingHandler.getInstance().addTrainingPeaksActivity(this._activity);
            }
            if (this._2p && this._2p.selected) 
            {
                this._2p.startLoading();
                handler.SharingHandler.getInstance().addTwoPeakActivity(this._activity);
            }
            if (this.fb && this.fb.selected) 
            {
                this.fb.startLoading();
                handler.SharingHandler.getInstance().addFacebookActivity(this._activity);
                this._useOwnMessage = true;
            }
            if (this.tw && this.tw.selected) 
            {
                this.tw.startLoading();
                handler.SharingHandler.getInstance().addTwitterActivity(this._activity);
            }
            if (this._useOwnMessage) 
            {
                this.openOwnMessagePopUp();
            }
            else 
            {
                this.doSharing();
            }
            return;
        }

        internal function openOwnMessagePopUp():void
        {
            this.doSharing(handler.SharingHandler.getInstance().getSharingStandardText());
            return;
        }

        public function get settingIcon():frontend.components.button.IconButton
        {
            return this._122546455settingIcon;
        }

        internal function onSharingComplete(arg1:backend.sharing.SharingEvent):void
        {
            this._activity = arg1.activity;
            var loc1:*=arg1.currentTarget as handler.SharingHandler;
            if (this.st && loc1.currentActivitySharing.oauthInstance == backend.oauth.StravaOAuth.getInstance()) 
            {
                this.st.stopLoading();
                this.st.selected = false;
                this.st.shared = this._activity.sharedToStrava;
            }
            if (this.tp && loc1.currentActivitySharing.oauthInstance == backend.oauth.TrainingPeaksOAuth.getInstance()) 
            {
                this.tp.stopLoading();
                this.tp.selected = false;
                this.tp.shared = this._activity.sharedToTrainingPeaks;
            }
            if (this._2p && loc1.currentActivitySharing.oauthInstance == backend.oauth.TwoPeakOAuth.getInstance()) 
            {
                this._2p.stopLoading();
                this._2p.selected = false;
                this._2p.shared = this._activity.sharedTo2Peak;
            }
            if (this.fb && loc1.currentActivitySharing.oauthInstance == backend.oauth.FacebookGoViralHandler.getInstance()) 
            {
                this.fb.stopLoading();
                this.fb.selected = false;
                this.fb.shared = this._activity.sharedToFacebook;
            }
            if (this.tw && loc1.currentActivitySharing.oauthInstance == backend.oauth.TwitterOAuth.getInstance()) 
            {
                this.tw.stopLoading();
                this.tw.selected = false;
                this.tw.shared = this._activity.sharedToTwitter;
            }
            return;
        }

        internal function onSharingError(arg1:backend.sharing.SharingEvent):void
        {
            var loc1:*=arg1.eventTarget.currentTarget as backend.sharing.ActivitySharing;
            var loc2:*=loc1.oauthInstance.getErrorMessage(loc1.errorStatus);
            if (this.st && loc1.oauthInstance == backend.oauth.StravaOAuth.getInstance()) 
            {
                this.st.shared = arg1.activity.sharedToStrava;
                this.st.showError(loc2);
            }
            if (this.tp && loc1.oauthInstance == backend.oauth.TrainingPeaksOAuth.getInstance()) 
            {
                this.tp.shared = arg1.activity.sharedToTrainingPeaks;
                this.tp.showError(loc2);
            }
            if (this._2p && loc1.oauthInstance == backend.oauth.TwoPeakOAuth.getInstance()) 
            {
                this._2p.shared = arg1.activity.sharedTo2Peak;
                this._2p.showError(loc2);
            }
            if (this.fb && loc1.oauthInstance == backend.oauth.FacebookGoViralHandler.getInstance()) 
            {
                this.fb.shared = arg1.activity.sharedToFacebook;
                this.fb.showError(loc2);
            }
            if (this.tw && loc1.oauthInstance == backend.oauth.TwitterOAuth.getInstance()) 
            {
                this.tw.shared = arg1.activity.sharedToTwitter;
                this.tw.showError(loc2);
            }
            return;
        }

        internal function onSharingFinished(arg1:backend.sharing.SharingEvent):void
        {
            handler.SharingHandler.getInstance().removeEventListener(backend.sharing.SharingEvent.MULTI_SHARING_FINISHED, this.onSharingFinished);
            handler.SharingHandler.getInstance().removeEventListener(backend.sharing.SharingEvent.SHARING_COMPLETE, this.onSharingComplete);
            handler.SharingHandler.getInstance().removeEventListener(backend.sharing.SharingEvent.SHARING_ERROR, this.onSharingError);
            var loc1:*=handler.ActivityHandler.getInstance().generateUpdateSharingInformation(this._activity);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onUpdateActivityComplete, this.onUpdateActivityError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function onUpdateActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().dispatchEvent(new frontend.screen.activities.list.ActivityListEvent(frontend.screen.activities.list.ActivityListEvent.UPDATE, this._activity));
            return;
        }

        internal function onUpdateActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onUpdateActivityError");
            return;
        }

        internal function openAccountSettings(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_APPSETTINGS_KONTEN, {"gotoActivityId":this.activityId}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _ActivityShare_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.visible = false;
            loc1.layout = this._ActivityShare_AnchorLayout1_c();
            loc1.mxmlContent = [this._ActivityShare_Label1_i(), this._ActivityShare_Label2_i()];
            loc1.id = "header";
            this.header = loc1;
            feathers.binding.BindingManager.executeBindings(this, "header", this.header);
            return loc1;
        }

        internal function _ActivityShare_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityShare_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_ActivityShare_Label1";
            this._ActivityShare_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityShare_Label1", this._ActivityShare_Label1);
            return loc1;
        }

        internal static const HEADER_HEIGHT:Number=80 * SIGMALink.scaleFactor;

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        public var _ActivityShare_Button1:feathers.controls.Button;

        public var _ActivityShare_Label1:feathers.controls.Label;

        public var _ActivityShare_Label2:feathers.controls.Label;

        internal var _1221270899header:feathers.controls.LayoutGroup;

        internal var _1097519085loader:feathers.controls.LayoutGroup;

        internal var _122546455settingIcon:frontend.components.button.IconButton;

        internal var _1554344690shareButtonGroup:feathers.controls.LayoutGroup;

        public var activityId:int;

        internal var _2p:frontend.screen.activities.share.ShareButton;

        internal var _activity:core.activities.Activity;

        internal var _iconButtonCallout:frontend.components.button.IconButtonCallout;

        internal var _useOwnMessage:Boolean=false;

        internal var fb:frontend.screen.activities.share.ShareButton;

        internal var initialValidated:Boolean=false;

        internal var movieClip:starling.display.MovieClip;

        internal var st:frontend.screen.activities.share.ShareButton;

        internal var tp:frontend.screen.activities.share.ShareButton;

        internal var tw:frontend.screen.activities.share.ShareButton;

        internal var _3685147yPos:Number;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _comesFromSharingOptions:Boolean=false;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class ShareButton
package frontend.screen.activities.share 
{
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.menuList.editors.base.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class ShareButton extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ShareButton()
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
            bindings = this._ShareButton_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_share_ShareButtonWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ShareButton[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._ShareButton_AnchorLayout1_c();
            this.mxmlContent = [this._ShareButton_TextureImage1_i(), this._ShareButton_Label1_i(), this._ShareButton_OnOffToggleButton1_i(), this._ShareButton_TextureImage2_i(), this._ShareButton_LayoutGroup2_i()];
            this.addEventListener("initialize", this.___ShareButton_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get titleLabel():feathers.controls.Label
        {
            return this._1791483012titleLabel;
        }

        public function set titleLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1791483012titleLabel;
            if (loc1 !== arg1) 
            {
                this._1791483012titleLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "titleLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get loading():Boolean
        {
            return this._336650556loading;
        }

        public function set loading(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._336650556loading;
            if (loc1 !== arg1) 
            {
                this._336650556loading = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "loading", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get selected():Boolean
        {
            return this._1191572123selected;
        }

        public function set selected(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1191572123selected;
            if (loc1 !== arg1) 
            {
                this._1191572123selected = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "selected", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function onShareOptionChange(arg1:Boolean):void
        {
            this.selected = arg1;
            return;
        }

        public function get shared():Boolean
        {
            return this._903566235shared;
        }

        public function set shared(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._903566235shared;
            if (loc1 !== arg1) 
            {
                this._903566235shared = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "shared", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get textureName():String
        {
            return this._1613545030textureName;
        }

        public function set textureName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1613545030textureName;
            if (loc1 !== arg1) 
            {
                this._1613545030textureName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "textureName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get title():String
        {
            return this._110371416title;
        }

        internal function onInit():void
        {
            var loc1:*=new starling.display.Quad(1, ROW_HEIGHT, core.general.Colors.LIGHTGREY);
            loc1.x = SIGMALink.appWidth - COL_SHARED_WIDTH;
            addChild(loc1);
            return;
        }

        public function set title(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._110371416title;
            if (loc1 !== arg1) 
            {
                this._110371416title = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "title", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function startLoading():void
        {
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTextureAtlas("loaderAnimation");
            if (loc1) 
            {
                this.movieClip = new starling.display.MovieClip(loc1.getTextures("frame_"), 30);
                this.movie.addChild(this.movieClip);
                this.movieClip.play();
                if (!starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.add(this.movieClip);
                }
                this.movie.layoutData = new feathers.layout.AnchorLayoutData(NaN, (COL_SHARED_WIDTH - this.movieClip.width) / 2, NaN, NaN, NaN, 0);
                this.loading = true;
                this.shared = false;
            }
            return;
        }

        public function stopLoading():void
        {
            this.loading = false;
            this.selected = false;
            if (this.movieClip) 
            {
                this.movieClip.stop();
                if (starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.remove(this.movieClip);
                }
            }
            this.movie.removeChildren();
            return;
        }

        protected function sharedIcon_creationCompleteHandler(arg1:starling.events.Event):void
        {
            this.sharedIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, (COL_SHARED_WIDTH - this.sharedIcon.width) / 2, NaN, NaN, NaN, 0);
            return;
        }

        public function showError(arg1:String):void
        {
            this.stopLoading();
            this.titleLabel.text = arg1;
            this.titleLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this.shareOption.visible = false;
            return;
        }

        internal function _ShareButton_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ShareButton_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "icon";
            this.icon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "icon", this.icon);
            return loc1;
        }

        internal function _ShareButton_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "titleLabel";
            this.titleLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "titleLabel", this.titleLabel);
            return loc1;
        }

        internal function _ShareButton_OnOffToggleButton1_i():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            var loc1:*=new frontend.components.menuList.editors.base.OnOffToggleButton();
            loc1.id = "shareOption";
            this.shareOption = loc1;
            feathers.binding.BindingManager.executeBindings(this, "shareOption", this.shareOption);
            return loc1;
        }

        internal function _ShareButton_TextureImage2_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.addEventListener("creationComplete", this.__sharedIcon_creationComplete);
            loc1.id = "sharedIcon";
            this.sharedIcon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sharedIcon", this.sharedIcon);
            return loc1;
        }

        public function __sharedIcon_creationComplete(arg1:starling.events.Event):void
        {
            this.sharedIcon_creationCompleteHandler(arg1);
            return;
        }

        internal function _ShareButton_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "movie";
            this.movie = loc1;
            feathers.binding.BindingManager.executeBindings(this, "movie", this.movie);
            return loc1;
        }

        public function ___ShareButton_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _ShareButton_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return ROW_HEIGHT;
            }, null, "this.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
            }, null, "icon.layoutData")
            result[4] = new feathers.binding.Binding(this, null, null, "icon.textureName", "textureName");
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, COL_ICON_WIDTH, NaN, 0);
            }, null, "titleLabel.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - COL_ICON_WIDTH - PADDING;
            }, null, "titleLabel.maxWidth")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "titleLabel.styleName")
            result[8] = new feathers.binding.Binding(this, null, null, "titleLabel.text", "title");
            result[9] = new feathers.binding.Binding(this, null, null, "shareOption.checked", "selected");
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, COL_SHARED_WIDTH, NaN, NaN, NaN, 0);
            }, null, "shareOption.layoutData")
            result[11] = new feathers.binding.Binding(this, function ():Function
            {
                return onShareOptionChange;
            }, null, "shareOption.toggleChangedFunction")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.hakenicongreen;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "sharedIcon.textureName")
            result[13] = new feathers.binding.Binding(this, null, null, "sharedIcon.visible", "shared");
            result[14] = new feathers.binding.Binding(this, null, null, "movie.visible", "loading");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ShareButton._watcherSetupUtil = arg1;
            return;
        }

        public function get shareOption():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            return this._53796556shareOption;
        }

        public function get icon():frontend.components.TextureImage
        {
            return this._3226745icon;
        }

        public function set icon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3226745icon;
            if (loc1 !== arg1) 
            {
                this._3226745icon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "icon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get movie():feathers.controls.LayoutGroup
        {
            return this._104087344movie;
        }

        public function set movie(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._104087344movie;
            if (loc1 !== arg1) 
            {
                this._104087344movie = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "movie", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set shareOption(arg1:frontend.components.menuList.editors.base.OnOffToggleButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._53796556shareOption;
            if (loc1 !== arg1) 
            {
                this._53796556shareOption = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "shareOption", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get sharedIcon():frontend.components.TextureImage
        {
            return this._1784634754sharedIcon;
        }

        public function set sharedIcon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1784634754sharedIcon;
            if (loc1 !== arg1) 
            {
                this._1784634754sharedIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sharedIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static const COL_SHARED_WIDTH:Number=80 * SIGMALink.scaleFactor;

        public static const PADDING:Number=20 * SIGMALink.scaleFactor;

        public static const ROW_HEIGHT:Number=80 * SIGMALink.scaleFactor;

        internal static const COL_ICON_WIDTH:Number=100 * SIGMALink.scaleFactor;

        internal static const EDIT_GROUP_WIDTH:Number=75 * SIGMALink.scaleFactor;

        internal var _3226745icon:frontend.components.TextureImage;

        internal var _104087344movie:feathers.controls.LayoutGroup;

        internal var _53796556shareOption:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _1784634754sharedIcon:frontend.components.TextureImage;

        internal var _1791483012titleLabel:feathers.controls.Label;

        internal var _336650556loading:Boolean=false;

        internal var _903566235shared:Boolean=false;

        internal var _1613545030textureName:String;

        internal var _110371416title:String;

        internal var _moving:Boolean=false;

        internal var movieClip:starling.display.MovieClip;

        internal var _1191572123selected:Boolean=false;

        mx_internal var _bindings:Array;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  package tabs
//    package graph
//      class ActivityGraphTabView
package frontend.screen.activities.tabs.graph 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import configCache.*;
    import core.activities.*;
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.component.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class ActivityGraphTabView extends frontend.components.tabbarbase.TabLayoutScroller implements feathers.binding.IBindingClient
    {
        public function ActivityGraphTabView()
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
            bindings = this._ActivityGraphTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_graph_ActivityGraphTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.graph.ActivityGraphTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.addEventListener("addedToStage", this.___ActivityGraphTabView_TabLayoutScroller1_addedToStage);
            this.addEventListener("removedFromStage", this.___ActivityGraphTabView_TabLayoutScroller1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___ActivityGraphTabView_TabLayoutScroller1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
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

        public function ___ActivityGraphTabView_TabLayoutScroller1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _ActivityGraphTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "this.height")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.graphicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.GRAPH.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.graph.ActivityGraphTabView._watcherSetupUtil = arg1;
            return;
        }

        
        {
            gapQuadHeight = 4;
        }

        internal function drawChart(arg1:frontend.screen.activities.component.ActivityGraphComp, arg2:int=-1, arg3:Function=null):void
        {
            arg1.validate();
            var loc1:*=new starling.textures.RenderTexture(SIGMALink.appWidth, frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT);
            loc1.draw(arg1, null, 1, 3);
            var loc2:*=new starling.display.Image(loc1);
            if (arg3 != null) 
            {
                loc2.addEventListener(starling.events.TouchEvent.TOUCH, arg3);
            }
            if (arg2 != -1) 
            {
                addChildAt(loc2, arg2);
            }
            else 
            {
                addChild(loc2);
            }
            return;
        }

        public override function showContent():void
        {
            var loc2:*=null;
            if (!this._redrawFlag) 
            {
                return;
            }
            this._redrawFlag = false;
            if (this.activity.entries.length == 0) 
            {
                return;
            }
            var loc1:*=0;
            this.entries = handler.ActivityCalculator.calculateChartEntries(this.activity, 60);
            if (this.activity.entries[0].altitudeDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityGraphComp();
                loc2.yAchseLabel = backend.utils.DataUtils.altitudeLabel + " [" + backend.utils.DataUtils.unitStringAltitude + "]";
                loc2.yLabelConverter = backend.utils.DataUtils.altitudeConverter;
                loc2.yLabelFormatter = backend.utils.DataUtils.altitudeFormatter;
                loc2.yValueName = core.activities.ActivityEntryMapper.col_altitude;
                loc2.xValueName = this.getXValueName();
                loc2.graphColor = core.general.Colors.ALTITUDE;
                loc2.entries = this.entries;
                this.drawChart(loc2, -1, this.onChartTouch);
                loc1 = loc1 + (frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT + gapQuadHeight);
            }
            if (this.activity.entries[0].speedDefined) 
            {
                this.addGapQuad(loc1 - gapQuadHeight);
                this.speedIndex = numChildren;
                this.drawSleepChart();
                loc1 = loc1 + (frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT + gapQuadHeight);
            }
            if (this.activity.entries[0].heartrateDefined) 
            {
                this.addGapQuad(loc1 - gapQuadHeight);
                loc2 = new frontend.screen.activities.component.ActivityGraphComp();
                loc2.yAchseLabel = backend.utils.DataUtils.heartrateLabel + " [" + backend.utils.DataUtils.unitStringHeartrate + "]";
                loc2.yLabelFormatter = backend.utils.DataUtils.heartrateFormatter;
                loc2.yValueName = core.activities.ActivityEntryMapper.col_heartrate;
                loc2.xValueName = this.getXValueName();
                loc2.yMaxFix = 240;
                loc2.yMinFix = 0;
                loc2.yIntervalFix = 60;
                loc2.graphColor = core.general.Colors.HEATRATE;
                loc2.entries = this.entries;
                this.drawChart(loc2, -1, this.onChartTouch);
                loc1 = loc1 + (frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT + gapQuadHeight);
            }
            verticalScrollPolicy = numChildren > 3 ? feathers.controls.Scroller.SCROLL_POLICY_ON : feathers.controls.Scroller.SCROLL_POLICY_OFF;
            return;
        }

        public override function hideContent():void
        {
            this.clearCharts();
            return;
        }

        internal function addGapQuad(arg1:Number):void
        {
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, gapQuadHeight, core.general.Colors.LIGHTGREY);
            loc1.y = arg1;
            addChild(loc1);
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onSpeedFormatChanged(arg1:starling.events.Event):void
        {
            if (this.speedIndex != -1) 
            {
                removeChildAt(this.speedIndex);
            }
            this.drawSleepChart();
            return;
        }

        internal function drawSleepChart():void
        {
            this.speedChart = new frontend.screen.activities.component.ActivityGraphComp();
            var loc1:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this.activity.sport);
            if (loc1 != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
            {
                this.speedChart.speedTime = true;
                this.speedChart.yAchseLabel = backend.utils.DataUtils.speedLabel + " [" + backend.utils.DataUtils.unitStringSpeedTime + "]";
                this.speedChart.yLabelConverter = backend.utils.DataUtils.speedTimeConverter;
                this.speedChart.yLabelFormatter = backend.utils.DataUtils.timeFormatter_MM_SS;
                this.speedChart.yValueName = core.activities.ActivityEntryMapper.col_speed;
            }
            else 
            {
                this.speedChart.speedTime = false;
                this.speedChart.yAchseLabel = backend.utils.DataUtils.speedLabel + " [" + backend.utils.DataUtils.unitStringSpeed + "]";
                this.speedChart.yLabelConverter = backend.utils.DataUtils.speedConverter;
                this.speedChart.yLabelFormatter = backend.utils.DataUtils.speedFormatter;
                this.speedChart.yValueName = core.activities.ActivityEntryMapper.col_speed;
            }
            this.speedChart.xValueName = this.getXValueName();
            this.speedChart.graphColor = core.general.Colors.SPEED;
            this.speedChart.entries = this.entries;
            this.drawChart(this.speedChart, this.speedIndex, this.onSpeedChartTouch);
            return;
        }

        internal function onSpeedChartTouch(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=this.getTouchPoint(arg1);
            if (loc1.y < frontend.screen.activities.component.ActivityGraphComp.GUTTER_TOP) 
            {
                loc2 = configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this.activity.sport);
                loc2 = loc2 != utils.format.SpeedFormat.DISTANCE_PER_TIME ? utils.format.SpeedFormat.DISTANCE_PER_TIME : utils.format.SpeedFormat.TIME_PER_DISTANCE;
                configCache.ConfigCache.getInstance().setSportSpeedFormatValue(this.activity.sport, loc2);
                handler.ViewHandler.getInstance().dispatchEventWith(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED);
            }
            else 
            {
                this.onChartTouch(arg1);
            }
            return;
        }

        internal function onChartTouch(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=this.getTouchPoint(arg1);
            if (loc1.y > frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT - frontend.screen.activities.component.ActivityGraphComp.GUTTER_TOP) 
            {
                loc2 = configCache.ConfigCache.getInstance().getSportBaseValue(this.activity.sport);
                loc2 = loc2 != core.general.MeasuringUnit.DISTANCE ? core.general.MeasuringUnit.DISTANCE : core.general.MeasuringUnit.TRAININGTIME;
                configCache.ConfigCache.getInstance().setSportBaseValue(this.activity.sport, loc2);
                this.clearCharts();
                this.speedIndex = -1;
                this.showContent();
            }
            return;
        }

        internal function getTouchPoint(arg1:starling.events.TouchEvent):flash.geom.Point
        {
            var loc1:*=arg1.target as starling.display.DisplayObject;
            var loc2:*=arg1.getTouch(loc1);
            var loc3:*=new flash.geom.Point(loc2.globalX, loc2.globalY);
            return loc1.globalToLocal(loc3);
        }

        internal function getXValueName():String
        {
            return configCache.ConfigCache.getInstance().getSportBaseValue(this.activity.sport);
        }

        public override function dispose():void
        {
            this.clearCharts();
            super.dispose();
            return;
        }

        public function clearCharts():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc2:*=numChildren;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = getChildAt(loc1);
                if (loc3 is starling.display.Image) 
                {
                    (loc3 as starling.display.Image).texture.dispose();
                }
                loc3.dispose();
                ++loc1;
            }
            removeChildren();
            return;
        }

        internal var _activity:core.activities.Activity;

        internal var _redrawFlag:Boolean=true;

        internal var entries:__AS3__.vec.Vector.<Object>;

        internal var speedChart:frontend.screen.activities.component.ActivityGraphComp;

        internal var speedIndex:int=-1;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var gapQuadHeight:Number=4;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _watchers:Array;
    }
}


//    package laps
//      class ActivityLapDetailsView
package frontend.screen.activities.tabs.laps 
{
    import backend.utils.*;
    import configCache.*;
    import core.general.*;
    import core.marker.*;
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
    import frontend.components.scrollContainer.*;
    import frontend.components.tab.*;
    import frontend.screen.activities.*;
    import frontend.screen.activities.component.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class ActivityLapDetailsView extends frontend.components.scrollContainer.CustomVScrollContainer implements feathers.binding.IBindingClient
    {
        public function ActivityLapDetailsView()
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
            bindings = this._ActivityLapDetailsView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_laps_ActivityLapDetailsViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.laps.ActivityLapDetailsView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ActivityLapDetailsView_LayoutGroup1_i()];
            this.addEventListener("addedToStage", this.___ActivityLapDetailsView_CustomVScrollContainer1_addedToStage);
            this.addEventListener("removedFromStage", this.___ActivityLapDetailsView_CustomVScrollContainer1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___ActivityLapDetailsView_CustomVScrollContainer1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage();
            return;
        }

        internal function _ActivityLapDetailsView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_ActivityLapDetailsView_LayoutGroup2.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 100;
            }, null, "_ActivityLapDetailsView_LayoutGroup2.height")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ActivityLapDetailsView_LayoutGroup2.width")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth * 0.5;
            }, null, "_ActivityLapDetailsView_LayoutGroup3.width")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_VerticalLayout1.paddingLeft")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_VerticalLayout1.paddingTop")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_LAP") + " " + lapCurrent + "/" + lapAmount;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_Label1.text")
            result[9] = new feathers.binding.Binding(this, null, null, "_ActivityLapDetailsView_Label2.text", "lapTypeLabel");
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth * 0.5;
            }, null, "_ActivityLapDetailsView_LayoutGroup4.width")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_HorizontalLayout2.gap")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_HorizontalLayout2.paddingRight")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.lefticon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton1.image")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.lefticonDisabled;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton1.imageDisabled")
            result[15] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _prevButtonEnabled;
            }, null, "_ActivityLapDetailsView_IconButton1.isEnabled")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton1.paddingLeft")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton1.paddingRight")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.righticon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton2.image")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.righticonDisabled;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton2.imageDisabled")
            result[20] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _nextButtonEnabled;
            }, null, "_ActivityLapDetailsView_IconButton2.isEnabled")
            result[21] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton2.paddingLeft")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton2.paddingRight")
            return result;
        }

        public function get vContainer():feathers.controls.LayoutGroup
        {
            return this._120745813vContainer;
        }

        public function set vContainer(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._120745813vContainer;
            if (loc1 !== arg1) 
            {
                this._120745813vContainer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vContainer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get lapCurrent():uint
        {
            return this._1439809374lapCurrent;
        }

        public function set lapCurrent(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1439809374lapCurrent;
            if (loc1 !== arg1) 
            {
                this._1439809374lapCurrent = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "lapCurrent", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get lapTypeLabel():String
        {
            return this._520982655lapTypeLabel;
        }

        internal function _ActivityLapDetailsView_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_VerticalLayout1_i();
            loc1.mxmlContent = [this._ActivityLapDetailsView_Label1_i(), this._ActivityLapDetailsView_Label2_i()];
            loc1.id = "_ActivityLapDetailsView_LayoutGroup3";
            this._ActivityLapDetailsView_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_LayoutGroup3", this._ActivityLapDetailsView_LayoutGroup3);
            return loc1;
        }

        public function set lapTypeLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._520982655lapTypeLabel;
            if (loc1 !== arg1) 
            {
                this._520982655lapTypeLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "lapTypeLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set markerList(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.markerList;
            if (loc1 !== arg1) 
            {
                this._1115163640markerList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "markerList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _nextButtonEnabled():Boolean
        {
            return this._731648253_nextButtonEnabled;
        }

        internal function get _prevButtonEnabled():Boolean
        {
            return this._1506460093_prevButtonEnabled;
        }

        internal function set _prevButtonEnabled(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1506460093_prevButtonEnabled;
            if (loc1 !== arg1) 
            {
                this._1506460093_prevButtonEnabled = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_prevButtonEnabled", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get markerList():feathers.data.ListCollection
        {
            return this._markerList;
        }

        internal function set _1115163640markerList(arg1:feathers.data.ListCollection):void
        {
            this._markerList = arg1;
            this.lapAmount = this._markerList.length;
            return;
        }

        internal function get lapAmount():uint
        {
            return this._2096497197lapAmount;
        }

        internal function set lapAmount(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2096497197lapAmount;
            if (loc1 !== arg1) 
            {
                this._2096497197lapAmount = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "lapAmount", loc1, arg1, this);
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
            frontend.screen.activities.tabs.laps.ActivityLapDetailsView._watcherSetupUtil = arg1;
            return;
        }

        internal function onSwitchToPreviousLapTouch():void
        {
            if (this.lapCurrent > 1) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this).lapCurrent - 1);
                loc1.lapCurrent = loc2;
                this.onAddedToStage();
            }
            return;
        }

        internal function onSwitchToNextLapTouch():void
        {
            if (this.lapCurrent < this.lapAmount) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this).lapCurrent + 1);
                loc1.lapCurrent = loc2;
                this.onAddedToStage();
            }
            return;
        }

        internal function checkButtonStates():void
        {
            this._prevButtonEnabled = this.lapCurrent > 1;
            this._nextButtonEnabled = this.lapCurrent < this.lapAmount;
            return;
        }

        internal function onAddedToStage():void
        {
            this.checkButtonStates();
            this.addValues();
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onRemovedFromStage():void
        {
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onSpeedFormatChanged(arg1:starling.events.Event):void
        {
            this.addValues();
            return;
        }

        internal function addValues(arg1:starling.events.Event=null):void
        {
            var loc2:*=null;
            var loc1:*=this.markerList.getItemAt((this.lapCurrent - 1)) as core.marker.Marker;
            if (!loc1) 
            {
                return;
            }
            var loc4:*=loc1.type;
            switch (loc4) 
            {
                case core.general.MarkerType.LAP:
                {
                    this.lapTypeLabel = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_MANUAL_LAP");
                    break;
                }
                case core.general.MarkerType.AUTO_LAP:
                {
                    this.lapTypeLabel = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_AUTO_LAP");
                    break;
                }
                default:
                {
                    this.lapTypeLabel = "";
                }
            }
            if (this.vContainer.numChildren > 0) 
            {
                this.vContainer.removeChildren(1);
            }
            var loc3:*=100 * SIGMALink.scaleFactor;
            loc2 = new frontend.screen.activities.component.ActivityValueComp();
            loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
            loc2.ROW_HEIGHT = ROW_HEIGHT;
            loc2.iconSource = frontend.Textures.laengstezeit;
            loc2.iconText = "ACTIVIY_TAB_LAPS_DETAILS_LAPTIME";
            loc2.setValue(loc1.time, null, backend.utils.DataUtils.timeFormatter);
            loc2.unit = backend.utils.DataUtils.unitStringTimeHours;
            this.vContainer.addChild(loc2);
            loc3 = loc3 + ROW_HEIGHT;
            loc3 = loc3 + this.addHLine(loc3);
            loc2 = new frontend.screen.activities.component.ActivityValueComp();
            loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
            loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
            loc2.iconText = "ACTIVIY_TAB_LAPS_DETAILS_FROM_START";
            loc2.setValue(loc1.timeAbsolute, null, backend.utils.DataUtils.timeFormatter);
            loc2.unit = backend.utils.DataUtils.unitStringTimeHours;
            this.vContainer.addChild(loc2);
            loc3 = loc3 + SUB_ROW_HEIGHT;
            loc3 = loc3 + this.addHLine(loc3, true);
            if (loc1.distanceDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityValueComp();
                loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                loc2.ROW_HEIGHT = ROW_HEIGHT;
                loc2.iconSource = frontend.Textures.strecke;
                loc2.iconTextTranslated = backend.utils.DataUtils.distanceLabel;
                loc2.setValue(loc1.distance, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                loc2.unit = backend.utils.DataUtils.unitStringDistance;
                this.vContainer.addChild(loc2);
                loc3 = loc3 + ROW_HEIGHT;
                if (loc1.distanceAbsoluteDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_LAPS_DETAILS_FROM_START";
                    loc2.setValue(loc1.distanceAbsolute, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc2.unit = backend.utils.DataUtils.unitStringDistance;
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                loc3 = loc3 + this.addHLine(loc3, true);
            }
            if (loc1.averageSpeedDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityValueComp();
                loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                loc2.ROW_HEIGHT = ROW_HEIGHT;
                loc2.speedBasedValue = loc1.averageSpeed;
                loc2.iconSource = frontend.Textures.IconSpeed;
                loc2.iconTextTranslated = backend.utils.DataUtils.speedLabel;
                loc2.valueIconSource = frontend.Textures.averageiconmini;
                loc2.clickCallback = this.swapSpeedFormat;
                this.updateSpeedBasedObjects(loc2);
                this.vContainer.addChild(loc2);
                loc3 = loc3 + ROW_HEIGHT;
                if (loc1.minimumSpeedDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MIN";
                    loc2.speedBasedValue = loc1.minimumSpeed;
                    loc2.clickCallback = this.swapSpeedFormat;
                    this.updateSpeedBasedObjects(loc2);
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                if (loc1.maximumSpeedDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MAX";
                    loc2.speedBasedValue = loc1.maximumSpeed;
                    loc2.clickCallback = this.swapSpeedFormat;
                    this.updateSpeedBasedObjects(loc2);
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                loc3 = loc3 + this.addHLine(loc3, true);
            }
            if (loc1.averageHeartrateDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityValueComp();
                loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                loc2.ROW_HEIGHT = ROW_HEIGHT;
                loc2.iconSource = frontend.Textures.heartrateicon;
                loc2.iconTextTranslated = backend.utils.DataUtils.heartrateLabel;
                loc2.setValue(loc1.averageHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                loc2.unit = backend.utils.DataUtils.unitStringHeartrate;
                loc2.valueIconSource = frontend.Textures.averageiconmini;
                this.vContainer.addChild(loc2);
                loc3 = loc3 + ROW_HEIGHT;
                if (loc1.minimumHeartrateDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MIN";
                    loc2.setValue(loc1.minimumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc2.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                if (loc1.maximumHeartrateDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MAX";
                    loc2.setValue(loc1.maximumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc2.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                loc3 = loc3 + this.addHLine(loc3, true);
            }
            return;
        }

        internal function updateSpeedBasedObjects(arg1:frontend.screen.activities.component.ActivityValueComp):void
        {
            var loc3:*=NaN;
            var loc1:*=this.markerList.getItemAt((this.lapCurrent - 1)) as core.marker.Marker;
            var loc2:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc1.logReference.sport);
            if (loc2 != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
            {
                loc3 = utils.Calculations.calculateSpeedTime(arg1.speedBasedValue);
                if (loc3 != utils.Calculations.speedTimeMaximum()) 
                {
                    arg1.setValue(loc3 * 100, null, backend.utils.DataUtils.timeFormatter_MM_SS);
                }
                else 
                {
                    arg1.value = "--:--";
                }
                arg1.unit = backend.utils.DataUtils.unitStringSpeedTime;
            }
            else 
            {
                arg1.setValue(arg1.speedBasedValue, backend.utils.DataUtils.speedConverter, backend.utils.DataUtils.speedFormatter);
                arg1.unit = backend.utils.DataUtils.unitStringSpeed;
            }
            return;
        }

        internal function addHLine(arg1:Number, arg2:Boolean=false):Number
        {
            var loc1:*=arg2 ? 30 : 3;
            var loc2:*=new starling.display.Quad(SIGMALink.appWidth, loc1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            loc2.y = arg1;
            this.vContainer.addChild(loc2);
            return loc1;
        }

        internal function swapSpeedFormat():void
        {
            var loc1:*=this.markerList.getItemAt((this.lapCurrent - 1)) as core.marker.Marker;
            var loc2:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc1.logReference.sport);
            loc2 = loc2 != utils.format.SpeedFormat.DISTANCE_PER_TIME ? utils.format.SpeedFormat.DISTANCE_PER_TIME : utils.format.SpeedFormat.TIME_PER_DISTANCE;
            configCache.ConfigCache.getInstance().setSportSpeedFormatValue(loc1.logReference.sport, loc2);
            handler.ViewHandler.getInstance().dispatchEventWith(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED);
            return;
        }

        internal function _ActivityLapDetailsView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_AnchorLayout1_c();
            loc1.mxmlContent = [this._ActivityLapDetailsView_LayoutGroup2_i()];
            loc1.id = "vContainer";
            this.vContainer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "vContainer", this.vContainer);
            return loc1;
        }

        internal function _ActivityLapDetailsView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityLapDetailsView_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_HorizontalLayout1_c();
            loc1.mxmlContent = [this._ActivityLapDetailsView_LayoutGroup3_i(), this._ActivityLapDetailsView_LayoutGroup4_i()];
            loc1.id = "_ActivityLapDetailsView_LayoutGroup2";
            this._ActivityLapDetailsView_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_LayoutGroup2", this._ActivityLapDetailsView_LayoutGroup2);
            return loc1;
        }

        internal function _ActivityLapDetailsView_HorizontalLayout1_c():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.verticalAlign = "middle";
            return loc1;
        }

        internal function set _nextButtonEnabled(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._731648253_nextButtonEnabled;
            if (loc1 !== arg1) 
            {
                this._731648253_nextButtonEnabled = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_nextButtonEnabled", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ActivityLapDetailsView_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "left";
            loc1.verticalAlign = "middle";
            this._ActivityLapDetailsView_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_VerticalLayout1", this._ActivityLapDetailsView_VerticalLayout1);
            return loc1;
        }

        internal function _ActivityLapDetailsView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "BIGLISTLABEL";
            loc1.id = "_ActivityLapDetailsView_Label1";
            this._ActivityLapDetailsView_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_Label1", this._ActivityLapDetailsView_Label1);
            return loc1;
        }

        internal function _ActivityLapDetailsView_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "SMALLLISTLABEL";
            loc1.id = "_ActivityLapDetailsView_Label2";
            this._ActivityLapDetailsView_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_Label2", this._ActivityLapDetailsView_Label2);
            return loc1;
        }

        internal function _ActivityLapDetailsView_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_HorizontalLayout2_i();
            loc1.mxmlContent = [this._ActivityLapDetailsView_IconButton1_i(), this._ActivityLapDetailsView_IconButton2_i()];
            loc1.id = "_ActivityLapDetailsView_LayoutGroup4";
            this._ActivityLapDetailsView_LayoutGroup4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_LayoutGroup4", this._ActivityLapDetailsView_LayoutGroup4);
            return loc1;
        }

        internal function _ActivityLapDetailsView_HorizontalLayout2_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.horizontalAlign = "right";
            loc1.verticalAlign = "middle";
            this._ActivityLapDetailsView_HorizontalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_HorizontalLayout2", this._ActivityLapDetailsView_HorizontalLayout2);
            return loc1;
        }

        internal function _ActivityLapDetailsView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.addEventListener("triggered", this.___ActivityLapDetailsView_IconButton1_triggered);
            loc1.id = "_ActivityLapDetailsView_IconButton1";
            this._ActivityLapDetailsView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_IconButton1", this._ActivityLapDetailsView_IconButton1);
            return loc1;
        }

        public function ___ActivityLapDetailsView_IconButton1_triggered(arg1:starling.events.Event):void
        {
            this.onSwitchToPreviousLapTouch();
            return;
        }

        internal function _ActivityLapDetailsView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.addEventListener("triggered", this.___ActivityLapDetailsView_IconButton2_triggered);
            loc1.id = "_ActivityLapDetailsView_IconButton2";
            this._ActivityLapDetailsView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_IconButton2", this._ActivityLapDetailsView_IconButton2);
            return loc1;
        }

        public function ___ActivityLapDetailsView_IconButton2_triggered(arg1:starling.events.Event):void
        {
            this.onSwitchToNextLapTouch();
            return;
        }

        public function ___ActivityLapDetailsView_CustomVScrollContainer1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        internal static const ROW_HEIGHT:Number=80 * SIGMALink.scaleFactor;

        internal static const SUB_ROW_HEIGHT:Number=55 * SIGMALink.scaleFactor;

        public var _ActivityLapDetailsView_HorizontalLayout2:feathers.layout.HorizontalLayout;

        public var _ActivityLapDetailsView_IconButton1:frontend.components.button.IconButton;

        public var _ActivityLapDetailsView_IconButton2:frontend.components.button.IconButton;

        public var _ActivityLapDetailsView_Label1:feathers.controls.Label;

        public var _ActivityLapDetailsView_Label2:feathers.controls.Label;

        public var _ActivityLapDetailsView_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _ActivityLapDetailsView_LayoutGroup3:feathers.controls.LayoutGroup;

        public var _ActivityLapDetailsView_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _120745813vContainer:feathers.controls.LayoutGroup;

        internal var _1439809374lapCurrent:uint=0;

        internal var _520982655lapTypeLabel:String="";

        internal var _markerList:feathers.data.ListCollection;

        internal var _731648253_nextButtonEnabled:Boolean=true;

        internal var _1506460093_prevButtonEnabled:Boolean=true;

        internal var _2096497197lapAmount:uint;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        public var _ActivityLapDetailsView_LayoutGroup4:feathers.controls.LayoutGroup;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//      class ActivityLapItemListRenderer
package frontend.screen.activities.tabs.laps 
{
    import configCache.*;
    import core.general.*;
    import core.marker.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import utils.format.*;
    
    public class ActivityLapItemListRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function ActivityLapItemListRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            this._labelAvgSpeed = new feathers.controls.Label();
            this._labelDistance = new feathers.controls.Label();
            this._labelTime = new feathers.controls.Label();
            super();
            hasLabelTextRenderer = false;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.LIGHTGREY);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group.width = SIGMALink.appWidth;
            this._group.height = ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDistance.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, COL_PADDING, NaN, 0);
            this._labelDistance.width = COL_WIDTH;
            this._group.addChild(this._labelDistance);
            this._labelTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelTime.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_PADDING + COL_WIDTH + COL_PADDING, NaN, NaN, NaN, 0);
            this._labelTime.width = COL_WIDTH;
            this._group.addChild(this._labelTime);
            this._labelAvgSpeed.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelAvgSpeed.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_PADDING, NaN, NaN, NaN, 0);
            this._labelAvgSpeed.width = COL_WIDTH;
            this._group.addChild(this._labelAvgSpeed);
            addChild(this._group);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        protected override function commitData():void
        {
            var loc1:*=null;
            super.commitData();
            if (!data) 
            {
                return;
            }
            if (data is core.marker.Marker) 
            {
                loc1 = data as core.marker.Marker;
                if (loc1.distanceDefined) 
                {
                    this._labelDistance.text = loc1.distanceOutputString;
                }
                this._labelTime.text = loc1.timeOutputString;
                if (loc1.averageSpeedDefined) 
                {
                    if (configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc1.logReference.sport) != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
                    {
                        this._labelAvgSpeed.text = loc1.averageSpeedTimeOutputString;
                    }
                    else 
                    {
                        this._labelAvgSpeed.text = loc1.averageSpeedOutputString;
                    }
                }
            }
            else 
            {
                this._labelDistance.text = data + "";
                this._labelTime.text = "";
                this._labelAvgSpeed.text = "";
            }
            return;
        }

        public static const COL_PADDING:Number=20 * SIGMALink.scaleFactor;

        public static const COL_WIDTH:Number=(SIGMALink.appWidth - 4 * COL_PADDING) / 3;

        internal static const ROW_HEIGHT:Number=60 * SIGMALink.scaleFactor;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _labelAvgSpeed:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelTime:feathers.controls.Label;
    }
}


//      class ActivityLapsTabView
package frontend.screen.activities.tabs.laps 
{
    import backend.utils.*;
    import configCache.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
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
    import frontend.components.scrollContainer.*;
    import frontend.components.tab.*;
    import frontend.components.tabbar.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class ActivityLapsTabView extends frontend.components.tabbarbase.TabLayoutScroller implements feathers.binding.IBindingClient
    {
        public function ActivityLapsTabView()
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
            bindings = this._ActivityLapsTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_laps_ActivityLapsTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.laps.ActivityLapsTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.ignoreVScrollPolicySetting = true;
            this.verticalScrollPolicy = "off";
            this.layout = this._ActivityLapsTabView_AnchorLayout1_c();
            this.mxmlContent = [this._ActivityLapsTabView_TextTabBar1_i(), this._ActivityLapsTabView_LayoutGroup1_i()];
            this.addEventListener("initialize", this.___ActivityLapsTabView_TabLayoutScroller1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get tabbar():frontend.components.tabbar.TextTabBar
        {
            return this._881387426tabbar;
        }

        public function set tabbar(arg1:frontend.components.tabbar.TextTabBar):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._881387426tabbar;
            if (loc1 !== arg1) 
            {
                this._881387426tabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tabbar", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get tableHeader():feathers.controls.LayoutGroup
        {
            return this._65701893tableHeader;
        }

        public function set tableHeader(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._65701893tableHeader;
            if (loc1 !== arg1) 
            {
                this._65701893tableHeader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tableHeader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set data(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.data;
            if (loc1 !== arg1) 
            {
                this._3076010data = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "data", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get autolLapsMarkerList():feathers.data.ListCollection
        {
            return this._1866457677autolLapsMarkerList;
        }

        public function get data():Object
        {
            return this._data;
        }

        internal function set _3076010data(arg1:Object):void
        {
            this._data = arg1 as core.activities.Activity;
            return;
        }

        internal function set autolLapsMarkerList(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1866457677autolLapsMarkerList;
            if (loc1 !== arg1) 
            {
                this._1866457677autolLapsMarkerList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "autolLapsMarkerList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get manualLapsMarkerList():feathers.data.ListCollection
        {
            return this._1445284426manualLapsMarkerList;
        }

        internal function set manualLapsMarkerList(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1445284426manualLapsMarkerList;
            if (loc1 !== arg1) 
            {
                this._1445284426manualLapsMarkerList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "manualLapsMarkerList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get tabBarDataProvider():feathers.data.ListCollection
        {
            return this._273520409tabBarDataProvider;
        }

        internal function set tabBarDataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._273520409tabBarDataProvider;
            if (loc1 !== arg1) 
            {
                this._273520409tabBarDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tabBarDataProvider", loc1, arg1, this);
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
            frontend.screen.activities.tabs.laps.ActivityLapsTabView._watcherSetupUtil = arg1;
            return;
        }

        protected function init(arg1:starling.events.Event):void
        {
            this._currentSelectedTab = configCache.ConfigCache.getInstance().getValue(SELECTED_MARKER_TAB, AUTO_LAPS);
            var loc1:*=frontend.screen.activities.tabs.laps.ActivityLapItemListRenderer.COL_WIDTH;
            var loc2:*=frontend.screen.activities.tabs.laps.ActivityLapItemListRenderer.COL_PADDING;
            var loc3:*=new feathers.controls.Label();
            loc3.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DISTANCE") + " [" + backend.utils.DataUtils.unitStringDistance + "]";
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc3.wordWrap = false;
            this.tableHeader.addChild(loc3);
            loc3.validate();
            loc3.width = loc1;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, loc2, NaN, 0);
            var loc4:*=new feathers.controls.Label();
            loc4.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_TIME") + " [" + backend.utils.DataUtils.unitStringTimeHours + "]";
            loc4.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc4.wordWrap = false;
            this.tableHeader.addChild(loc4);
            loc4.validate();
            loc4.width = loc1;
            loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, loc2 + loc1 + loc2, NaN, NaN, NaN, 0);
            this.speedLabel = new feathers.controls.Label();
            this.speedLabel.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_SPEED");
            this.speedLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            this.speedLabel.wordWrap = false;
            this.tableHeader.addChild(this.speedLabel);
            this.speedLabel.width = loc1;
            this.speedLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, loc2, NaN, NaN, NaN, 0);
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onSpeedFormatChanged(arg1:starling.events.Event):void
        {
            this.showContent();
            return;
        }

        public override function showContent():void
        {
            var loc1:*=0;
            var loc2:*=null;
            this.manualLapsMarkerList = new feathers.data.ListCollection();
            this.autolLapsMarkerList = new feathers.data.ListCollection();
            if (configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this._data.sport) != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
            {
                this.speedLabel.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_SPEED") + " [" + backend.utils.DataUtils.unitStringSpeedTime + "]";
            }
            else 
            {
                this.speedLabel.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_SPEED") + " [" + backend.utils.DataUtils.unitStringSpeed + "]";
            }
            this.speedLabel.validate();
            var loc3:*=this._data.markerList.length;
            loc1 = 0;
            while (loc1 < loc3) 
            {
                loc2 = this._data.markerList[loc1];
                if (core.general.MarkerType.LAP != loc2.type) 
                {
                    if (core.general.MarkerType.AUTO_LAP == loc2.type) 
                    {
                        this.autolLapsMarkerList.addItem(loc2);
                    }
                }
                else 
                {
                    this.manualLapsMarkerList.addItem(loc2);
                }
                ++loc1;
            }
            var loc4:*=new feathers.data.ListCollection();
            if (this.autolLapsMarkerList.length > 0) 
            {
                loc4.push({"data":AUTO_LAPS, "label":utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_AUTO")});
            }
            else 
            {
                this._currentSelectedTab = MANUAL_LAPS;
                configCache.ConfigCache.getInstance().setValue(SELECTED_MARKER_TAB, MANUAL_LAPS);
            }
            loc4.push({"data":MANUAL_LAPS, "label":utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_MANUAL")});
            this.tabbar.dataProvider = loc4;
            this.tabbar.addEventListener(starling.events.Event.CHANGE, this.onTabeSelectionChange);
            this.validateDataProvider();
            return;
        }

        public override function hideContent():void
        {
            this.laplist.dataProvider = new feathers.data.ListCollection();
            return;
        }

        internal function onTabeSelectionChange(arg1:starling.events.Event):void
        {
            this._currentSelectedTab = (arg1.currentTarget as feathers.controls.TabBar).selectedItem.data;
            configCache.ConfigCache.getInstance().setValue(SELECTED_MARKER_TAB, this._currentSelectedTab);
            this.validateDataProvider();
            return;
        }

        internal function validateDataProvider():void
        {
            if (!this.autolLapsMarkerList || !this.manualLapsMarkerList) 
            {
                flash.utils.setTimeout(this.validateDataProvider, 100);
                return;
            }
            var loc1:*=this._currentSelectedTab;
            switch (loc1) 
            {
                case AUTO_LAPS:
                {
                    this.laplist.dataProvider = this.autolLapsMarkerList;
                    this.tabbar.selectedIndex = 0;
                    break;
                }
                case MANUAL_LAPS:
                {
                    this.laplist.dataProvider = this.manualLapsMarkerList;
                    this.tabbar.selectedIndex = (this.tabbar.dataProvider.length - 1);
                    break;
                }
            }
            return;
        }

        internal function onListTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.laplist.dataProvider.getItemAt(0) is core.marker.Marker && this.laplist.selectedIndex > -1) 
            {
                this.lapDetailsGroup = new frontend.screen.activities.tabs.laps.ActivityLapDetailsView();
                this.lapDetailsGroup.layoutData = new feathers.layout.AnchorLayoutData();
                this.lapDetailsGroup.lapCurrent = this.laplist.selectedIndex + 1;
                this.lapDetailsGroup.markerList = this.laplist.dataProvider;
                addChild(this.lapDetailsGroup);
                this.laplist.selectedItem = null;
                handler.ViewHandler.getInstance().addBackFunction(this.closeLapDetails);
            }
            return;
        }

        public function closeLapDetails():void
        {
            removeChild(this.lapDetailsGroup);
            this.lapDetailsGroup = null;
            return;
        }

        internal function _ActivityLapsTabView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityLapsTabView_TextTabBar1_i():frontend.components.tabbar.TextTabBar
        {
            var loc1:*=new frontend.components.tabbar.TextTabBar();
            loc1.id = "tabbar";
            this.tabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tabbar", this.tabbar);
            return loc1;
        }

        internal function _ActivityLapsTabView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapsTabView_VerticalLayout1_c();
            loc1.mxmlContent = [this._ActivityLapsTabView_LayoutGroup2_i(), this._ActivityLapsTabView_CustomVScrollContainer1_i()];
            loc1.id = "tabVGroup";
            this.tabVGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tabVGroup", this.tabVGroup);
            return loc1;
        }

        internal function _ActivityLapsTabView_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            return loc1;
        }

        internal function _ActivityLapsTabView_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapsTabView_AnchorLayout2_c();
            loc1.id = "tableHeader";
            this.tableHeader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tableHeader", this.tableHeader);
            return loc1;
        }

        internal function _ActivityLapsTabView_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityLapsTabView_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.clipContent = true;
            loc1.mxmlContent = [this._ActivityLapsTabView_List1_i()];
            loc1.id = "scrollContainer";
            this.scrollContainer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scrollContainer", this.scrollContainer);
            return loc1;
        }

        internal function _ActivityLapsTabView_List1_i():feathers.controls.List
        {
            var loc1:*=new feathers.controls.List();
            loc1.addEventListener("touch", this.__laplist_touch);
            loc1.id = "laplist";
            this.laplist = loc1;
            feathers.binding.BindingManager.executeBindings(this, "laplist", this.laplist);
            return loc1;
        }

        public function __laplist_touch(arg1:starling.events.TouchEvent):void
        {
            this.onListTouch(arg1);
            return;
        }

        public function ___ActivityLapsTabView_TabLayoutScroller1_initialize(arg1:starling.events.Event):void
        {
            this.init(arg1);
            return;
        }

        internal function _ActivityLapsTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uhr;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.LAPS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "tabbar.height")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP);
            }, null, "tabbar.layoutData")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tabbar.width")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "tabVGroup.height")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP + frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT);
            }, null, "tabVGroup.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tabVGroup.width")
            result[8] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.DARKFONT);
            }, null, "tableHeader.backgroundSkin")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return LIST_HEADER_HEIGHT;
            }, null, "tableHeader.height")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tableHeader.width")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - LIST_HEADER_HEIGHT;
            }, null, "scrollContainer.height")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scrollContainer.width")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - LIST_HEADER_HEIGHT - frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "laplist.height")
            result[14] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.tabs.laps.ActivityLapItemListRenderer;
            }, null, "laplist.itemRendererType")
            result[15] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "laplist.width")
            return result;
        }

        public function get laplist():feathers.controls.List
        {
            return this._50066247laplist;
        }

        public function set laplist(arg1:feathers.controls.List):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._50066247laplist;
            if (loc1 !== arg1) 
            {
                this._50066247laplist = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "laplist", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scrollContainer():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._2128618444scrollContainer;
        }

        public function set scrollContainer(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2128618444scrollContainer;
            if (loc1 !== arg1) 
            {
                this._2128618444scrollContainer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scrollContainer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get tabVGroup():feathers.controls.LayoutGroup
        {
            return this._1649788830tabVGroup;
        }

        public function set tabVGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1649788830tabVGroup;
            if (loc1 !== arg1) 
            {
                this._1649788830tabVGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tabVGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static const AUTO_LAPS:String="autoLaps";

        internal static const LIST_HEADER_HEIGHT:Number=53 * SIGMALink.scaleFactor;

        internal static const MANUAL_LAPS:String="manualLaps";

        internal static const PADDING_TOP:Number=0;

        internal static const SELECTED_MARKER_TAB:String="selectedMarkerTab";

        internal static const UNIT_WIDTH:Number=50 * SIGMALink.scaleFactor;

        internal var _50066247laplist:feathers.controls.List;

        internal var _2128618444scrollContainer:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _1649788830tabVGroup:feathers.controls.LayoutGroup;

        internal var _881387426tabbar:frontend.components.tabbar.TextTabBar;

        internal var _65701893tableHeader:feathers.controls.LayoutGroup;

        internal var _data:core.activities.Activity;

        internal var _currentSelectedTab:String="autoLaps";

        internal var _1866457677autolLapsMarkerList:feathers.data.ListCollection;

        internal var lapDetailsGroup:frontend.screen.activities.tabs.laps.ActivityLapDetailsView;

        internal var _1445284426manualLapsMarkerList:feathers.data.ListCollection;

        internal var speedLabel:feathers.controls.Label;

        internal var _273520409tabBarDataProvider:feathers.data.ListCollection;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    package map
//      class ActivityMapTabView
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


//    package phases
//      class ActivityPhaseFooterRenderer
package frontend.screen.activities.tabs.phases 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import starling.display.*;
    import utils.*;
    
    public class ActivityPhaseFooterRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityPhaseFooterRenderer()
        {
            super();
            height = ROW_HEIGHT;
            padding = 0;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.holderGroup = new feathers.controls.LayoutGroup();
            this.holderGroup.layout = new feathers.layout.AnchorLayout();
            this.holderGroup.height = ROW_HEIGHT;
            this.holderGroup.width = SIGMALink.appWidth;
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.title = new feathers.controls.Label();
            this.title.text = utils.LanguageManager.getString("ACTIVITY_PHASE_PLAN_TITLE");
            this.title.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH * 2 + PADDING, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.title);
            this.plan1Icon = new frontend.components.TextureImage();
            this.holderGroup.addChild(this.plan1Icon);
            this.plan1ValueLabel = new feathers.controls.Label();
            this.plan1ValueLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH + PADDING, NaN, NaN, NaN, 0);
            this.plan1ValueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.holderGroup.addChild(this.plan1ValueLabel);
            this.plan1Unit = new feathers.controls.Label();
            this.plan1Unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH, NaN, NaN, NaN, 0);
            this.plan1Unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.holderGroup.addChild(this.plan1Unit);
            this.plan2Icon = new frontend.components.TextureImage();
            this.holderGroup.addChild(this.plan2Icon);
            this.plan2ValueLabel = new feathers.controls.Label();
            this.plan2ValueLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, NaN, NaN, NaN, 0);
            this.plan2ValueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.holderGroup.addChild(this.plan2ValueLabel);
            this.plan2Unit = new feathers.controls.Label();
            this.plan2Unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH, NaN, NaN, NaN, 0);
            this.plan2Unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.holderGroup.addChild(this.plan2Unit);
            addChild(this.holderGroup);
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.phases.ActivityPhaseListGroupFooter;
            this.plan1ValueLabel.text = loc1.plan1Value;
            this.plan1Unit.text = loc1.plan1Unit;
            this.plan2ValueLabel.text = loc1.plan2Value;
            this.plan2Unit.text = loc1.plan2Unit;
            if (loc1.plan1Icon != "") 
            {
                this.plan1ValueLabel.validate();
                this.plan1Icon.textureName = loc1.plan1Icon;
                this.plan1Icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH + PADDING + this.plan1ValueLabel.width + ICON_GAP, NaN, NaN, NaN, 0);
            }
            if (loc1.plan2Icon != "") 
            {
                this.plan2ValueLabel.validate();
                this.plan2Icon.textureName = loc1.plan2Icon;
                this.plan2Icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING + this.plan2ValueLabel.width + ICON_GAP, NaN, NaN, NaN, 0);
            }
            return;
        }

        
        {
            ICON_GAP = 10 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 75 * SIGMALink.scaleFactor;
        }

        internal static const COL_WIDTH:Number=SIGMALink.appWidth / 3;

        internal static const PADDING:Number=17 * SIGMALink.scaleFactor;

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var plan1Icon:frontend.components.TextureImage;

        internal var plan1Unit:feathers.controls.Label;

        internal var plan1ValueLabel:feathers.controls.Label;

        internal var plan2Icon:frontend.components.TextureImage;

        internal var plan2Unit:feathers.controls.Label;

        internal var plan2ValueLabel:feathers.controls.Label;

        internal var title:feathers.controls.Label;

        internal static var ICON_GAP:Number;

        internal static var ROW_HEIGHT:Number;
    }
}


//      class ActivityPhaseItemRenderer
package frontend.screen.activities.tabs.phases 
{
    import backend.utils.*;
    import core.general.*;
    import core.marker.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import utils.*;
    
    public class ActivityPhaseItemRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function ActivityPhaseItemRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            super();
            hasLabelTextRenderer = false;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.WHITE);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group.width = SIGMALink.appWidth;
            this._group.height = ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._title = new feathers.controls.Label();
            this._title.layoutData = new feathers.layout.AnchorLayoutData(COL_PADDING, NaN, NaN, COL_PADDING);
            this._group.addChild(this._title);
            this._labelDuration = new feathers.controls.Label();
            this._labelDuration.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDuration.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH * 2 + COL_PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._labelDuration);
            this._inZone = new feathers.controls.Label();
            this._inZone.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._inZone.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH + COL_PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._inZone);
            var loc1:*=ROW_HEIGHT / 3;
            this._avgPrefix = utils.LanguageManager.getString("AVG");
            this._avgHRPrefix = new feathers.controls.Label();
            this._avgHRPrefix.text = this._avgPrefix;
            this._avgHRPrefix.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._group.addChild(this._avgHRPrefix);
            this._avgHRPrefix.validate();
            var loc2:*=(loc1 - this._avgHRPrefix.height) / 2;
            this._avgHRPrefix.layoutData = new feathers.layout.AnchorLayoutData(loc2, COL_HR_WIDTH);
            this._minPrefix = utils.LanguageManager.getString("MIN");
            this._minHRPrefix = new feathers.controls.Label();
            this._minHRPrefix.text = this._minPrefix;
            this._minHRPrefix.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._minHRPrefix.layoutData = new feathers.layout.AnchorLayoutData(loc1 + loc2, COL_HR_WIDTH);
            this._group.addChild(this._minHRPrefix);
            this._maxPrefix = utils.LanguageManager.getString("MAX");
            this._maxHRPrefix = new feathers.controls.Label();
            this._maxHRPrefix.text = this._maxPrefix;
            this._maxHRPrefix.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._maxHRPrefix.layoutData = new feathers.layout.AnchorLayoutData(loc1 * 2 + loc2, COL_HR_WIDTH);
            this._group.addChild(this._maxHRPrefix);
            this._avgHR = new feathers.controls.Label();
            this._avgHR.text = "0";
            this._avgHR.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._group.addChild(this._avgHR);
            this._avgHR.validate();
            loc2 = (loc1 - this._avgHR.height) / 2;
            this._avgHR.layoutData = new feathers.layout.AnchorLayoutData(loc2, COL_PADDING);
            this._minHR = new feathers.controls.Label();
            this._minHR.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._minHR.layoutData = new feathers.layout.AnchorLayoutData(loc1 + loc2, COL_PADDING);
            this._group.addChild(this._minHR);
            this._maxHR = new feathers.controls.Label();
            this._maxHR.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._maxHR.layoutData = new feathers.layout.AnchorLayoutData(loc1 * 2 + loc2, COL_PADDING);
            this._group.addChild(this._maxHR);
            var loc3:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc3);
            return;
        }

        protected override function commitData():void
        {
            var loc1:*=null;
            super.commitData();
            if (!data) 
            {
                return;
            }
            if (data is core.marker.Marker) 
            {
                loc1 = data as core.marker.Marker;
                this._group.backgroundSkin = new starling.display.Quad(1, 1, !(loc1.type == core.general.MarkerType.INTERVAL_PHASE) && !(loc1.type == core.general.MarkerType.SIMPLE_PHASE) ? core.general.Colors.WHITE : core.general.Colors.brightenColor(core.general.Colors.LIGHTGREY, 75));
                this._title.text = loc1.type == core.general.MarkerType.INTERVAL_PHASE ? utils.LanguageManager.getString("ACTIVITY_INTERVAL_PHASE_SUMMERY") : loc1.title;
                this._labelDuration.text = backend.utils.DataUtils.timeFormatterHHMMSST.format(loc1.time);
                this._inZone.text = backend.utils.DataUtils.timeFormatterHHMMSST.format(loc1.timeInTargetZone);
                if (loc1.averageHeartrateDefined) 
                {
                    this._avgHRPrefix.text = this._avgPrefix;
                    this._avgHR.text = backend.utils.DataUtils.heartrateFormatter.format(loc1.averageHeartrate);
                }
                else 
                {
                    this._avgHRPrefix.text = "";
                    this._avgHR.text = "";
                }
                if (loc1.minimumHeartrateDefined) 
                {
                    this._minHRPrefix.text = this._minPrefix;
                    this._minHR.text = backend.utils.DataUtils.heartrateFormatter.format(loc1.minimumHeartrate);
                }
                else 
                {
                    this._minHRPrefix.text = "";
                    this._minHR.text = "";
                }
                if (loc1.maximumHeartrateDefined) 
                {
                    this._maxHRPrefix.text = this._maxPrefix;
                    this._maxHR.text = backend.utils.DataUtils.heartrateFormatter.format(loc1.maximumHeartrate);
                }
                else 
                {
                    this._maxHRPrefix.text = "";
                    this._maxHR.text = "";
                }
            }
            return;
        }

        public static const COL_PADDING:Number=20 * SIGMALink.scaleFactor;

        public static const COL_WIDTH:Number=(SIGMALink.appWidth - 4 * COL_PADDING) / 3;

        internal static const COL_HR_WIDTH:Number=85 * SIGMALink.scaleFactor;

        internal static const ROW_HEIGHT:Number=150 * SIGMALink.scaleFactor;

        internal var _avgHR:feathers.controls.Label;

        internal var _avgHRPrefix:feathers.controls.Label;

        internal var _avgPrefix:String;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _inZone:feathers.controls.Label;

        internal var _labelDuration:feathers.controls.Label;

        internal var _maxHR:feathers.controls.Label;

        internal var _maxHRPrefix:feathers.controls.Label;

        internal var _maxPrefix:String;

        internal var _minHR:feathers.controls.Label;

        internal var _minHRPrefix:feathers.controls.Label;

        internal var _minPrefix:String;

        internal var _title:feathers.controls.Label;
    }
}


//      class ActivityPhaseListGroup
package frontend.screen.activities.tabs.phases 
{
    import backend.utils.*;
    import core.general.*;
    import core.marker.*;
    import debug.*;
    import frontend.*;
    
    public class ActivityPhaseListGroup extends Object
    {
        public function ActivityPhaseListGroup()
        {
            this.children = new Array();
            super();
            return;
        }

        public function addItem(arg1:core.marker.Marker):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (arg1) 
            {
                loc2 = this.children.length;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if ((this.children[loc1] as core.marker.Marker).markerId == arg1.markerId) 
                    {
                        return;
                    }
                    ++loc1;
                }
                this.children.push(arg1);
                debug.Debug.debug(arg1.type);
                if (arg1.type == core.general.MarkerType.INTERVAL_PHASE) 
                {
                    return;
                }
                this.footer = new frontend.screen.activities.tabs.phases.ActivityPhaseListGroupFooter();
                if (arg1.plannedDistanceDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseDistanceIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(arg1.plannedDistance));
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringDistance;
                }
                else if (arg1.plannedRecoveryDistanceDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseDistanceIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(arg1.plannedRecoveryDistance));
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringDistance;
                }
                else if (arg1.plannedTimeDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseTimeIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.timeFormatterHHMMSST.format(arg1.plannedTime);
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringTimeHours;
                }
                else if (arg1.plannedRecoveryTimeDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseTimeIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.timeFormatterHHMMSST.format(arg1.plannedRecoveryTime);
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringTimeHours;
                }
                else 
                {
                    this.footer.plan1Icon = "";
                    this.footer.plan1Value = "--:--";
                    this.footer.plan1Unit = "";
                }
                loc3 = "";
                if (arg1.plannedLowerLimitDefined || arg1.plannedUpperLimitDefined) 
                {
                    if (arg1.plannedLowerLimitDefined) 
                    {
                        loc3 = loc3 + arg1.plannedLowerLimit.toString();
                    }
                    if (arg1.plannedUpperLimitDefined) 
                    {
                        loc3 = loc3 + (loc3.length != 0 ? "-" + arg1.plannedUpperLimit.toString() : arg1.plannedUpperLimit.toString());
                    }
                }
                else 
                {
                    if (arg1.plannedRecoveryLowerLimitDefined) 
                    {
                        loc3 = loc3 + arg1.plannedRecoveryLowerLimit.toString();
                    }
                    if (arg1.plannedRecoveryUpperLimitDefined) 
                    {
                        loc3 = loc3 + (loc3.length != 0 ? "-" + arg1.plannedRecoveryUpperLimit.toString() : arg1.plannedRecoveryUpperLimit.toString());
                    }
                }
                if (loc3.length > 0) 
                {
                    this.footer.plan2Icon = frontend.Textures.phaseHeartrateIcon;
                    this.footer.plan2Value = loc3;
                }
            }
            return;
        }

        public var children:Array;

        public var footer:frontend.screen.activities.tabs.phases.ActivityPhaseListGroupFooter;
    }
}


//      class ActivityPhaseListGroupFooter
package frontend.screen.activities.tabs.phases 
{
    public class ActivityPhaseListGroupFooter extends Object
    {
        public function ActivityPhaseListGroupFooter()
        {
            super();
            return;
        }

        public var plan1Icon:String;

        public var plan1Unit:String;

        public var plan1Value:String;

        public var plan2Icon:String;

        public var plan2Unit:String;

        public var plan2Value:String;
    }
}


//      class ActivityPhasesTabView
package frontend.screen.activities.tabs.phases 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
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
    import frontend.components.list.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
    import mx.core.*;
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
    
    public class ActivityPhasesTabView extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityPhasesTabView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1399580807listDataProvider = new feathers.data.HierarchicalCollection();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityPhasesTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_phases_ActivityPhasesTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.phases.ActivityPhasesTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._ActivityPhasesTabView_AnchorLayout1_c();
            this.mxmlContent = [this._ActivityPhasesTabView_CustomGroupedList1_i(), this._ActivityPhasesTabView_LayoutGroup1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set phaselist(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._425294695phaselist;
            if (loc1 !== arg1) 
            {
                this._425294695phaselist = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "phaselist", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get tableHeader():feathers.controls.LayoutGroup
        {
            return this._65701893tableHeader;
        }

        public function set tableHeader(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._65701893tableHeader;
            if (loc1 !== arg1) 
            {
                this._65701893tableHeader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tableHeader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set data(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.data;
            if (loc1 !== arg1) 
            {
                this._3076010data = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "data", loc1, arg1, this);
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

        public function get data():Object
        {
            return this._data;
        }

        internal function set _3076010data(arg1:Object):void
        {
            this._data = arg1 as core.activities.Activity;
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.phases.ActivityPhasesTabView._watcherSetupUtil = arg1;
            return;
        }

        internal function itemRenderer():feathers.controls.renderers.IGroupedListItemRenderer
        {
            return new frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer();
        }

        internal function footerRendererFactory():feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
        {
            return new frontend.screen.activities.tabs.phases.ActivityPhaseFooterRenderer();
        }

        public override function showContent():void
        {
            var loc2:*=0;
            var loc4:*=null;
            this.listDataProvider = new feathers.data.HierarchicalCollection();
            var loc1:*=(this.data as core.activities.Activity).markerList;
            loc1.sort(this.sortOnTimeAbsolute);
            var loc3:*=loc1.length;
            var loc5:*=new frontend.screen.activities.tabs.phases.ActivityPhaseListGroup();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = loc1[loc2];
                if (!(loc4.type == core.general.MarkerType.LAP) && !(loc4.type == core.general.MarkerType.PAUSE) && !(loc4.type == core.general.MarkerType.AUTO_LAP)) 
                {
                    loc5 = new frontend.screen.activities.tabs.phases.ActivityPhaseListGroup();
                    this.listDataProvider.addItemAt(loc5, (this.listDataProvider.data as Array).length);
                    loc5.addItem(loc4);
                }
                ++loc2;
            }
            if (this.phaselist.dataProvider == null) 
            {
                this.phaselist.dataProvider = this.listDataProvider;
            }
            return;
        }

        internal function sortOnTimeAbsolute(arg1:core.marker.Marker, arg2:core.marker.Marker):Number
        {
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, core.marker.MarkerMapper.col_timeAbsolute, false);
        }

        public override function hideContent():void
        {
            this.listDataProvider = new feathers.data.HierarchicalCollection();
            return;
        }

        internal function _ActivityPhasesTabView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityPhasesTabView_CustomGroupedList1_i():frontend.components.list.CustomGroupedList
        {
            var loc1:*=new frontend.components.list.CustomGroupedList();
            loc1.headerRendererFactory = null;
            loc1.stickyHeader = false;
            loc1.id = "phaselist";
            this.phaselist = loc1;
            feathers.binding.BindingManager.executeBindings(this, "phaselist", this.phaselist);
            return loc1;
        }

        internal function _ActivityPhasesTabView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityPhasesTabView_AnchorLayout2_c();
            loc1.mxmlContent = [this._ActivityPhasesTabView_Label1_i(), this._ActivityPhasesTabView_Label2_i(), this._ActivityPhasesTabView_Label3_i()];
            loc1.id = "tableHeader";
            this.tableHeader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tableHeader", this.tableHeader);
            return loc1;
        }

        internal function _ActivityPhasesTabView_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityPhasesTabView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = false;
            loc1.id = "_ActivityPhasesTabView_Label1";
            this._ActivityPhasesTabView_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityPhasesTabView_Label1", this._ActivityPhasesTabView_Label1);
            return loc1;
        }

        internal function _ActivityPhasesTabView_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = false;
            loc1.id = "_ActivityPhasesTabView_Label2";
            this._ActivityPhasesTabView_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityPhasesTabView_Label2", this._ActivityPhasesTabView_Label2);
            return loc1;
        }

        internal function _ActivityPhasesTabView_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = false;
            loc1.id = "_ActivityPhasesTabView_Label3";
            this._ActivityPhasesTabView_Label3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityPhasesTabView_Label3", this._ActivityPhasesTabView_Label3);
            return loc1;
        }

        internal function _ActivityPhasesTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.phasenicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.PHASES.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[2] = new feathers.binding.Binding(this, function ():Function
            {
                return footerRendererFactory;
            }, null, "phaselist.footerRendererFactory")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - PADDING_TOP - LIST_HEADER_HEIGHT;
            }, null, "phaselist.height")
            result[4] = new feathers.binding.Binding(this, function ():Function
            {
                return itemRenderer;
            }, null, "phaselist.itemRendererFactory")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP + LIST_HEADER_HEIGHT);
            }, null, "phaselist.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "phaselist.width")
            result[7] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.DARKFONT);
            }, null, "tableHeader.backgroundSkin")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return LIST_HEADER_HEIGHT;
            }, null, "tableHeader.height")
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP);
            }, null, "tableHeader.layoutData")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tableHeader.width")
            result[11] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING, NaN, 0);
            }, null, "_ActivityPhasesTabView_Label1.layoutData")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label1.styleName")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITY_PHASE_DURATION") + " [" + backend.utils.DataUtils.unitStringTimeHours + "]";
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label1.text")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH;
            }, null, "_ActivityPhasesTabView_Label1.width")
            result[15] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING + frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH + frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING, NaN, NaN, NaN, 0);
            }, null, "_ActivityPhasesTabView_Label2.layoutData")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label2.styleName")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITY_PHASE_IN_ZONE") + " [" + backend.utils.DataUtils.unitStringTimeHours + "]";
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label2.text")
            result[18] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH;
            }, null, "_ActivityPhasesTabView_Label2.width")
            result[19] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING, NaN, NaN, NaN, 0);
            }, null, "_ActivityPhasesTabView_Label3.layoutData")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label3.styleName")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITY_PHASE_HEARTRATE") + " [" + backend.utils.DataUtils.unitStringHeartrate + "]";
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label3.text")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH;
            }, null, "_ActivityPhasesTabView_Label3.width")
            return result;
        }

        public function get phaselist():frontend.components.list.CustomGroupedList
        {
            return this._425294695phaselist;
        }

        internal static const LIST_HEADER_HEIGHT:Number=53 * SIGMALink.scaleFactor;

        internal static const PADDING_TOP:Number=0 * SIGMALink.scaleFactor;

        public var _ActivityPhasesTabView_Label1:feathers.controls.Label;

        public var _ActivityPhasesTabView_Label2:feathers.controls.Label;

        public var _ActivityPhasesTabView_Label3:feathers.controls.Label;

        internal var _425294695phaselist:frontend.components.list.CustomGroupedList;

        internal var _65701893tableHeader:feathers.controls.LayoutGroup;

        internal var _data:Object;

        internal var _1399580807listDataProvider:feathers.data.HierarchicalCollection;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    package values
//      package list
//        class ActivityValueDataProviderObject
package frontend.screen.activities.tabs.values.list 
{
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class ActivityValueDataProviderObject extends Object
    {
        public function ActivityValueDataProviderObject()
        {
            this.footer = {"label":"test"};
            super();
            return;
        }

        public function setValue(arg1:Object, arg2:utils.converter.IConverter=null, arg3:utils.interfaces.ICustomFormatterBase=null):void
        {
            if (arg2) 
            {
                if (arg3) 
                {
                    this.value = arg3.format(arg2.convert(arg1));
                }
                else 
                {
                    this.value = arg2.convert(arg1).toString();
                }
            }
            else if (arg3) 
            {
                this.value = arg3.format(arg1);
            }
            else 
            {
                this.value = arg1 + "";
            }
            return;
        }

        public var clickCallback:Function;

        public var footer:Object;

        public var header:Object;

        public var iconSource:String;

        public var iconText:String;

        public var isHline:Boolean=false;

        public var isSeperator:Boolean=false;

        public var key:String;

        public var speedBasedValue:Number;

        public var unit:String;

        public var value:String;

        public var valueIconSource:String;
    }
}


//        class ActivityValueListFooterItemRenderer
package frontend.screen.activities.tabs.values.list 
{
    import core.general.*;
    import feathers.controls.renderers.*;
    import starling.display.*;
    
    public class ActivityValueListFooterItemRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityValueListFooterItemRenderer()
        {
            super();
            height = ROW_HEIGHT;
            styleProvider = null;
            backgroundSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.LIGHTGREY);
            contentLabelFunction = this.noLabelFunction;
            return;
        }

        internal function noLabelFunction(arg1:Object):String
        {
            return "";
        }

        internal static const ROW_HEIGHT:Number=29 * SIGMALink.scaleFactor;
    }
}


//        class ActivityValueListHeaderItemRenderer
package frontend.screen.activities.tabs.values.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ActivityValueListHeaderItemRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityValueListHeaderItemRenderer()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            height = ROW_HEIGHT;
            padding = 0;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.holderGroup = new feathers.controls.LayoutGroup();
            this.holderGroup.layout = new feathers.layout.AnchorLayout();
            this.holderGroup.height = ROW_HEIGHT;
            this.holderGroup.width = SIGMALink.appWidth;
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            this.icon = new frontend.components.TextureImage();
            this.icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.icon);
            this.text = new feathers.controls.Label();
            this.text.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this.text.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding + COL_ICON_WIDTH, NaN, 0);
            this.holderGroup.addChild(this.text);
            this.value = new feathers.controls.Label();
            this.value.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.value.layoutData = new feathers.layout.AnchorLayoutData(NaN, ipadding + COL_ICON_WIDTH, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.value);
            this.unit = new feathers.controls.Label();
            this.unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, SIGMALink.appWidth - COL_ICON_WIDTH, NaN, 0);
            this.unit.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            this.holderGroup.addChild(this.unit);
            addChild(this.holderGroup);
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            if (loc1.clickCallback != null) 
            {
                loc1.clickCallback();
            }
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            this.icon.textureName = loc1.iconSource;
            this.text.text = loc1.iconText;
            this.value.text = loc1.value;
            this.unit.text = loc1.unit;
            this.value.validate();
            this.text.maxWidth = width - 2 * ipadding - 2 * COL_ICON_WIDTH - this.value.width;
            return;
        }

        
        {
            COL_ICON_WIDTH = 80 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 85 * SIGMALink.scaleFactor;
            ipadding = 17 * SIGMALink.scaleFactor;
        }

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var icon:frontend.components.TextureImage;

        internal var text:feathers.controls.Label;

        internal var unit:feathers.controls.Label;

        internal var value:feathers.controls.Label;

        internal static var COL_ICON_WIDTH:uint;

        internal static var ROW_HEIGHT:Number;

        internal static var ipadding:Number;
    }
}


//        class ActivityValueListItemRenderer
package frontend.screen.activities.tabs.values.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ActivityValueListItemRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function ActivityValueListItemRenderer()
        {
            super();
            height = ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_MIDDLE;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.holderGroup = new feathers.controls.LayoutGroup();
            this.holderGroup.layout = new feathers.layout.AnchorLayout();
            this.holderGroup.height = ROW_HEIGHT;
            this.holderGroup.width = SIGMALink.appWidth;
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            this.icon = new frontend.components.TextureImage();
            this.icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.icon);
            this.text = new feathers.controls.Label();
            this.text.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this.text.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.text);
            this.value = new feathers.controls.Label();
            this.value.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.value.layoutData = new feathers.layout.AnchorLayoutData(NaN, ipadding + COL_ICON_WIDTH, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.value);
            this.unit = new feathers.controls.Label();
            this.unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, SIGMALink.appWidth - COL_ICON_WIDTH, NaN, 0);
            this.unit.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            this.holderGroup.addChild(this.unit);
            addChild(this.holderGroup);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            if (loc1.clickCallback != null) 
            {
                loc1.clickCallback();
            }
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            this.icon.textureName = loc1.iconSource;
            this.text.text = loc1.iconText;
            this.value.text = loc1.value;
            this.unit.text = loc1.unit;
            return;
        }

        
        {
            COL_ICON_WIDTH = 80 * SIGMALink.scaleFactor;
            COL_UNIT_WIDTH = 50 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 51 * SIGMALink.scaleFactor;
            ipadding = 17 * SIGMALink.scaleFactor;
        }

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var icon:frontend.components.TextureImage;

        internal var text:feathers.controls.Label;

        internal var unit:feathers.controls.Label;

        internal var value:feathers.controls.Label;

        internal static var COL_ICON_WIDTH:uint;

        internal static var COL_UNIT_WIDTH:uint;

        internal static var ROW_HEIGHT:uint;

        internal static var ipadding:Number;
    }
}


//        class ActivityValuesGroup
package frontend.screen.activities.tabs.values.list 
{
    public class ActivityValuesGroup extends Object
    {
        public function ActivityValuesGroup()
        {
            this.children = [];
            this.footer = {"text":""};
            super();
            return;
        }

        public function addChild(arg1:frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject):void
        {
            if (arg1 is frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject) 
            {
                this.children.push(arg1);
            }
            return;
        }

        public var children:Array;

        public var footer:Object;

        public var header:Object;
    }
}


//      class ActivityValuesTabView
package frontend.screen.activities.tabs.values 
{
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.activities.*;
    import core.general.*;
    import debug.*;
    import feathers.binding.*;
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
    import frontend.components.list.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
    import frontend.screen.activities.tabs.values.list.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class ActivityValuesTabView extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityValuesTabView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.dictHCObjects = [];
            this.speedBasedObjects = [];
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityValuesTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_values_ActivityValuesTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.values.ActivityValuesTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ActivityValuesTabView_CustomGroupedList1_i()];
            this.addEventListener("addedToStage", this.___ActivityValuesTabView_TabLayoutGroup1_addedToStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get groupedList():frontend.components.list.CustomGroupedList
        {
            return this._1258726684groupedList;
        }

        public function set groupedList(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1258726684groupedList;
            if (loc1 !== arg1) 
            {
                this._1258726684groupedList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "groupedList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
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

        internal function get dataProvider():feathers.data.HierarchicalCollection
        {
            return this._339742651dataProvider;
        }

        internal function set dataProvider(arg1:feathers.data.HierarchicalCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._339742651dataProvider;
            if (loc1 !== arg1) 
            {
                this._339742651dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function loadActivityMarkerComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().loadActivityMarkerComplete(arg1.getResult(), this._activity);
            this.onActivityDataLoaded();
            return;
        }

        protected function addedToStageHandler(arg1:starling.events.Event):void
        {
            this.updateSpeedBasedObjects();
            return;
        }

        internal function loadActivityData():void
        {
            if (this._activity.dataType != core.general.DataType.LOG) 
            {
                this.onActivityDataLoaded();
            }
            else if (this._activity.entries.length != 0) 
            {
                if (this._activity.markerList.length != 0) 
                {
                    this.onActivityDataLoaded();
                }
                else 
                {
                    this.loadMarkers();
                }
            }
            else 
            {
                this.loadEntries();
            }
            return;
        }

        internal function onActivityDataLoaded():void
        {
            if (this.contentLoadedCallback != null) 
            {
                this.contentLoadedCallback();
            }
            return;
        }

        internal function loadEntries():void
        {
            var loc1:*=handler.ActivityHandler.getInstance().generateLoadActivityEntries(this._activity.activityId);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadActivityEntriesComplete, this.loadActivityEntriesError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function loadActivityEntriesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activityEntriesError");
            return;
        }

        internal function loadActivityEntriesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().loadActivityEntriesComplete(arg1.getResult(), this._activity);
            if (this._activity.markerList.length != 0) 
            {
                this.onActivityDataLoaded();
            }
            else 
            {
                this.loadMarkers();
            }
            return;
        }

        internal function loadMarkers():void
        {
            var loc1:*=handler.ActivityHandler.getInstance().generateLoadActivityMarker(this._activity.activityId);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadActivityMarkerComplete, this.loadActivityMarkerError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function loadActivityMarkerError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activityMarkerError");
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.values.ActivityValuesTabView._watcherSetupUtil = arg1;
            return;
        }

        internal function pushLine(arg1:frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject, arg2:int):void
        {
            var loc1:*=null;
            if (arg2 > (this.dictHCObjects.length - 1)) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValuesGroup();
                loc1.header = arg1;
                this.dictHCObjects.push(loc1);
            }
            else 
            {
                loc1 = this.dictHCObjects[arg2] as frontend.screen.activities.tabs.values.list.ActivityValuesGroup;
                loc1.addChild(arg1);
            }
            return;
        }

        internal function createDataProvider():void
        {
            var loc1:*=0;
            this.dataProvider = new feathers.data.HierarchicalCollection();
            var loc2:*=this.dictHCObjects.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                this.dataProvider.addItemAt(this.dictHCObjects[loc1], loc1);
                ++loc1;
            }
            return;
        }

        public override function showContent():void
        {
            this.dictHCObjects = [];
            this.speedBasedObjects = [];
            this.addToDataProviderTrainingTime(this.dictHCObjects.length);
            this.addToDataProviderDistance(this.dictHCObjects.length);
            this.addToDataProviderSpeed(this.dictHCObjects.length);
            this.addToDataProviderFuelEconomy(this.dictHCObjects.length);
            this.addToDataProviderTripsection(this.dictHCObjects.length);
            this.addToDataProviderAltitude(this.dictHCObjects.length);
            this.addToDataProviderHeartrate(this.dictHCObjects.length);
            this.addToDataProviderCalories(this.dictHCObjects.length);
            this.addToDataProviderIncline(this.dictHCObjects.length);
            this.addToDataProviderRiseRate(this.dictHCObjects.length);
            this.addToDataProviderCadence(this.dictHCObjects.length);
            this.addToDataProviderPower(this.dictHCObjects.length);
            this.addToDataProviderExpansion(this.dictHCObjects.length);
            this.addToDataProviderDistancePlusMinus(this.dictHCObjects.length);
            this.addToDataProviderBest5K(this.dictHCObjects.length);
            this.addToDataProviderTemperature(this.dictHCObjects.length);
            this.addToDataProviderNP(this.dictHCObjects.length);
            this.addToDataProviderBalance(this.dictHCObjects.length);
            this.addToDataProviderPedalingTime(this.dictHCObjects.length);
            this.createDataProvider();
            this.loadActivityData();
            return;
        }

        public override function hideContent():void
        {
            this.dictHCObjects = [];
            this.dataProvider = new feathers.data.HierarchicalCollection();
            return;
        }

        internal function addToDataProviderTrainingTime(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.trainingTimeDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TRAININGTIME;
                loc1.iconSource = frontend.Textures.laengstezeit;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TRAININGTIME");
                loc1.setValue(this.activity.trainingTime, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.exerciseTimeDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TRAININGTIME;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TRAININGTIME_BRUTTO");
                loc1.setValue(this.activity.exerciseTime, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.trainingTimeUphillDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TRAININGTIME;
                loc1.iconSource = frontend.Textures.bergauf;
                loc1.setValue(this.activity.trainingTimeUphill, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.trainingTimeDownhillDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TRAININGTIME;
                loc1.iconSource = frontend.Textures.bergab;
                loc1.setValue(this.activity.trainingTimeDownhill, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderDistance(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.distanceDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_DISTANCE;
                loc1.iconSource = frontend.Textures.strecke;
                loc1.iconText = backend.utils.DataUtils.distanceLabel;
                loc1.setValue(this.activity.distance, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringDistance;
                this.pushLine(loc1, arg1);
                if (this.activity.distanceUphillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_DISTANCE;
                    loc1.iconSource = frontend.Textures.bergauf;
                    loc1.setValue(this.activity.distanceUphill, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.distanceDownhillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_DISTANCE;
                    loc1.iconSource = frontend.Textures.bergab;
                    loc1.setValue(this.activity.distanceDownhill, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function swapSpeedFormat():void
        {
            var loc1:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this.activity.sport);
            loc1 = loc1 != utils.format.SpeedFormat.DISTANCE_PER_TIME ? utils.format.SpeedFormat.DISTANCE_PER_TIME : utils.format.SpeedFormat.TIME_PER_DISTANCE;
            configCache.ConfigCache.getInstance().setSportSpeedFormatValue(this.activity.sport, loc1);
            handler.ViewHandler.getInstance().dispatchEventWith(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED);
            this.updateSpeedBasedObjects();
            return;
        }

        internal function updateSpeedBasedObjects():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc5:*=NaN;
            var loc2:*=this.speedBasedObjects.length;
            var loc4:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this.activity.sport);
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this.speedBasedObjects[loc1];
                if (loc4 != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
                {
                    loc5 = utils.Calculations.calculateSpeedTime(loc3.speedBasedValue);
                    if (loc5 != utils.Calculations.speedTimeMaximum()) 
                    {
                        loc3.setValue(loc5 * 100, null, backend.utils.DataUtils.timeFormatter_MM_SS);
                    }
                    else 
                    {
                        loc3.value = "--:--";
                    }
                    loc3.unit = backend.utils.DataUtils.unitStringSpeedTime;
                }
                else 
                {
                    loc3.setValue(loc3.speedBasedValue, backend.utils.DataUtils.speedConverter, backend.utils.DataUtils.speedFormatter);
                    loc3.unit = backend.utils.DataUtils.unitStringSpeed;
                }
                ++loc1;
            }
            if (this.dataProvider) 
            {
                this.dataProvider.updateAll();
            }
            return;
        }

        internal function addToDataProviderSpeed(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageSpeedDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_SPEED;
                loc1.iconSource = frontend.Textures.IconSpeed;
                loc1.iconText = backend.utils.DataUtils.speedLabel;
                loc1.speedBasedValue = this.activity.averageSpeed;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                loc1.clickCallback = this.swapSpeedFormat;
                this.pushLine(loc1, arg1);
                this.speedBasedObjects.push(loc1);
                if (this.activity.averageSpeedUphillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_SPEED;
                    loc1.iconSource = frontend.Textures.averageuphillsmall;
                    loc1.speedBasedValue = this.activity.averageSpeedUphill;
                    loc1.unit = backend.utils.DataUtils.unitStringSpeed;
                    loc1.clickCallback = this.swapSpeedFormat;
                    this.pushLine(loc1, arg1);
                    this.speedBasedObjects.push(loc1);
                }
                if (this.activity.averageSpeedDownhillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_SPEED;
                    loc1.iconSource = frontend.Textures.averagedownhillsmall;
                    loc1.speedBasedValue = this.activity.averageSpeedDownhill;
                    loc1.unit = backend.utils.DataUtils.unitStringSpeed;
                    loc1.clickCallback = this.swapSpeedFormat;
                    this.pushLine(loc1, arg1);
                    this.speedBasedObjects.push(loc1);
                }
                if (this.activity.minimumSpeedDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_SPEED;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.speedBasedValue = this.activity.minimumSpeed;
                    loc1.speedBasedValue = backend.utils.DataUtils.speedConverter.convert(this.activity.minimumSpeed);
                    loc1.unit = backend.utils.DataUtils.unitStringSpeed;
                    loc1.clickCallback = this.swapSpeedFormat;
                    this.pushLine(loc1, arg1);
                    this.speedBasedObjects.push(loc1);
                }
                if (this.activity.maximumSpeedDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_SPEED;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.speedBasedValue = this.activity.maximumSpeed;
                    loc1.unit = backend.utils.DataUtils.unitStringSpeed;
                    loc1.clickCallback = this.swapSpeedFormat;
                    this.pushLine(loc1, arg1);
                    this.speedBasedObjects.push(loc1);
                }
                this.updateSpeedBasedObjects();
            }
            return;
        }

        internal function addToDataProviderFuelEconomy(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.fuelEconomyDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_FUELECONOMY;
                loc1.iconSource = frontend.Textures.fuelicon;
                loc1.iconText = backend.utils.DataUtils.fuelEconomyLabel;
                loc1.setValue(this.activity.fuelEconomy, backend.utils.DataUtils.fuelEconomyConverter, backend.utils.DataUtils.fuelEconomyFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringFuelEconomy;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderTripsection(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.tripSectionTimeDefined || this.activity.tripSectionDistanceDefined) 
            {
                if (this.activity.tripSectionTimeDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TRIPSECTION;
                    loc1.iconSource = frontend.Textures.laengstezeit;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TRIP_SECTION");
                    loc1.setValue(this.activity.tripSectionTime, null, backend.utils.DataUtils.timeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                    this.pushLine(loc1, arg1);
                }
                if (loc1) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TRIPSECTION;
                    loc1.iconSource = frontend.Textures.streckesmall;
                    loc1.setValue(this.activity.tripSectionDistance, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
                else 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TRIPSECTION;
                    loc1.iconSource = frontend.Textures.strecke;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TRIP_SECTION");
                    loc1.setValue(this.activity.tripSectionDistance, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderAltitude(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.altitudeDifferencesUphillDefined) 
            {
                if (this.activity.averageAltitudeDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconSource = frontend.Textures.hohenmeter;
                    loc1.iconText = backend.utils.DataUtils.altitudeLabel;
                    loc1.valueIconSource = frontend.Textures.averageiconmini;
                    loc1.setValue(this.activity.averageAltitude, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                    this.pushLine(loc1, arg1);
                }
                if (!loc1) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconSource = frontend.Textures.hohenmeter;
                    loc1.iconText = backend.utils.DataUtils.altitudeLabel;
                    this.pushLine(loc1, arg1);
                }
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_ALTITUDE;
                loc1.iconSource = frontend.Textures.bergauf;
                loc1.setValue(this.activity.altitudeDifferencesUphill, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                this.pushLine(loc1, arg1);
                if (this.activity.altitudeDifferencesDownhillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconSource = frontend.Textures.bergab;
                    loc1.setValue(this.activity.altitudeDifferencesDownhill, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.minimumAltitudeDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumAltitude, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumAltitudeDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumAltitude, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderHeartrate(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageHeartrateDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_HEARTRATE;
                loc1.iconSource = frontend.Textures.heartrateicon;
                loc1.iconText = backend.utils.DataUtils.heartrateLabel;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                loc1.setValue(this.activity.averageHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringHeartrate;
                this.pushLine(loc1, arg1);
                if (this.activity.averagePercentHRMaxDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_HEARTRATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_PERCENT_OF_HRMAX");
                    loc1.setValue(this.activity.averagePercentHRMax, null, backend.utils.DataUtils.heartrateFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPercent;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.minimumHeartrateDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_HEARTRATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumHeartrateDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_HEARTRATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderCalories(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.caloriesDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_KCAL;
                loc1.iconSource = frontend.Textures.kcal;
                loc1.iconText = backend.utils.DataUtils.caloriesLabel;
                loc1.setValue(this.activity.calories, null, backend.utils.DataUtils.caloriesFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringCalories;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderIncline(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageInclineUphillDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_INCLINE;
                loc1.iconSource = frontend.Textures.bergaufab;
                loc1.iconText = backend.utils.DataUtils.inclineLabel;
                this.pushLine(loc1, arg1);
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_INCLINE;
                loc1.iconSource = frontend.Textures.averageuphillsmall;
                loc1.setValue(this.activity.averageInclineUphill, null, backend.utils.DataUtils.inclineFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringIncline;
                this.pushLine(loc1, arg1);
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_INCLINE;
                loc1.iconSource = frontend.Textures.averagedownhillsmall;
                loc1.setValue(this.activity.averageInclineDownhill, null, backend.utils.DataUtils.inclineFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringIncline;
                this.pushLine(loc1, arg1);
                if (this.activity.minimumInclineDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_INCLINE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumIncline, null, backend.utils.DataUtils.inclineFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringIncline;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumInclineDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_INCLINE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumIncline, null, backend.utils.DataUtils.inclineFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringIncline;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderRiseRate(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageRiseRateDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_RISERATE;
                loc1.iconSource = frontend.Textures.bergaufab;
                loc1.iconText = backend.utils.DataUtils.riseRateLabel;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                this.pushLine(loc1, arg1);
                if (this.activity.averageRiseRateUphillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_RISERATE;
                    loc1.iconSource = frontend.Textures.averageuphillsmall;
                    loc1.setValue(this.activity.averageRiseRateUphill, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringRiseRate;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.averageRiseRateDownhillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_RISERATE;
                    loc1.iconSource = frontend.Textures.averagedownhillsmall;
                    loc1.setValue(this.activity.averageRiseRateDownhill, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringRiseRate;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.minimumRiseRateDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_RISERATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumRiseRate, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringRiseRate;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumRiseRateDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_RISERATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumRiseRate, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringRiseRate;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderCadence(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageCadenceDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_CADENCE;
                loc1.iconSource = frontend.Textures.cadenceicon;
                loc1.iconText = backend.utils.DataUtils.cadenceLabel;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                loc1.setValue(this.activity.averageCadence, null, backend.utils.DataUtils.cadenceFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringCadence;
                this.pushLine(loc1, arg1);
                if (this.activity.minimumCadenceDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_CADENCE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumCadence, null, backend.utils.DataUtils.cadenceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringCadence;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumCadenceDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_CADENCE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumCadence, null, backend.utils.DataUtils.cadenceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringCadence;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderExpansion(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageExpansionDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_EXPANSION;
                loc1.iconSource = frontend.Textures.cadenceicon;
                loc1.iconText = backend.utils.DataUtils.expansionLabel;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                loc1.setValue(this.activity.averageExpansion, null, backend.utils.DataUtils.expansionFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringExpansion;
                this.pushLine(loc1, arg1);
                if (this.activity.averageExpansionUphillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_EXPANSION;
                    loc1.iconSource = frontend.Textures.averageuphillsmall;
                    loc1.setValue(this.activity.averageExpansionUphill, null, backend.utils.DataUtils.expansionFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringExpansion;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderPower(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averagePowerDefined || this.activity.maximumPowerDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_POWER;
                loc1.iconSource = frontend.Textures.powericon;
                if (this.activity.averagePowerDefined) 
                {
                    loc1.iconText = backend.utils.DataUtils.powerLabel;
                    loc1.valueIconSource = frontend.Textures.averageiconmini;
                    loc1.setValue(this.activity.averagePower, null, backend.utils.DataUtils.powerFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPower;
                }
                this.pushLine(loc1, arg1);
                if (this.activity.averagePowerWattPerKGDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_POWER;
                    loc1.iconText = backend.utils.DataUtils.powerPerKGLabel;
                    loc1.valueIconSource = frontend.Textures.averageiconmini;
                    loc1.setValue(this.activity.averagePowerWattPerKG, backend.utils.DataUtils.powerPerKGConverter, backend.utils.DataUtils.powerPerKGFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPowerPerKg;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.workInKJDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_POWER;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_WORK_PER_KJ");
                    loc1.setValue(this.activity.workInKJ, null, backend.utils.DataUtils.powerFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringKj;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.minimumPowerDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_POWER;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumPower, backend.utils.DataUtils.powerPerKGConverter, backend.utils.DataUtils.powerPerKGFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPowerPerKg;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumPowerDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_POWER;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumPower, backend.utils.DataUtils.powerPerKGConverter, backend.utils.DataUtils.powerPerKGFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPowerPerKg;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderDistancePlusMinus(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.distancePlusDefined || this.activity.distanceMinusDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_DISTANCEPLUSMINUS;
                loc1.iconSource = frontend.Textures.strecke;
                loc1.iconText = backend.utils.DataUtils.distancePlusMinusLabel;
                this.pushLine(loc1, arg1);
                if (this.activity.distancePlusDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_DISTANCEPLUSMINUS;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE_UP");
                    loc1.setValue(this.activity.distancePlus, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.distanceMinusDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_DISTANCEPLUSMINUS;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE_DOWN");
                    loc1.setValue(this.activity.distanceMinus, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderTemperature(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageTemperatureDefined || this.activity.minimumTemperatureDefined || this.activity.maximumTemperatureDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TEMPERATURE;
                loc1.iconSource = frontend.Textures.temperatureicon;
                loc1.iconText = backend.utils.DataUtils.temperatureLabel;
                if (this.activity.averageTemperatureDefined) 
                {
                    loc1.valueIconSource = frontend.Textures.averageiconmini;
                    loc1.setValue(this.activity.averageTemperature, backend.utils.DataUtils.temperatureConverter, backend.utils.DataUtils.temperatureFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringTemperature;
                }
                this.pushLine(loc1, arg1);
                if (this.activity.minimumTemperatureDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TEMPERATURE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumTemperature, backend.utils.DataUtils.temperatureConverter, backend.utils.DataUtils.temperatureFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringTemperature;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumTemperatureDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TEMPERATURE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumTemperature, backend.utils.DataUtils.temperatureConverter, backend.utils.DataUtils.temperatureFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringTemperature;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderBest5K(arg1:int):void
        {
            var loc1:*=null;
            var loc2:*=false;
            if (this.activity.best5KTimeDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BEST_5K;
                if (!loc2) 
                {
                    loc1.iconSource = frontend.Textures.iconstarblacksmall;
                    loc2 = true;
                }
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_BEST_5K_TIME");
                loc1.setValue(this.activity.best5KTime, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.best20minPowerDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BEST_5K;
                if (!loc2) 
                {
                    loc1.iconSource = frontend.Textures.iconstarblacksmall;
                    loc2 = true;
                }
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_BEST_20MIN_POWER");
                loc1.setValue(this.activity.best20minPower, null, backend.utils.DataUtils.powerFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringPower;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderNP(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.powerNPDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_NP;
                loc1.iconSource = frontend.Textures.powericon;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_NP_SHORT");
                loc1.setValue(this.activity.powerNP, null, backend.utils.DataUtils.powerFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringPower;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.powerIFDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_NP;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_IF_SHORT");
                loc1.setValue(this.activity.powerIF, null, backend.utils.DataUtils.intensityFactorFormatter);
                loc1.unit = "";
                this.pushLine(loc1, arg1);
            }
            if (this.activity.powerTSSDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_NP;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TSS_SHORT");
                loc1.setValue(this.activity.powerTSS, null, backend.utils.DataUtils.tssFormatter);
                loc1.unit = "";
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderBalance(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageBalanceLeftDefined && this.activity.averageBalanceRightDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BALANCE;
                loc1.iconSource = frontend.Textures.cadenceicon;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_BALANCE");
                loc1.value = backend.utils.DataUtils.percentFormatter.format(this.activity.averageBalanceLeft) + " / " + backend.utils.DataUtils.percentFormatter.format(this.activity.averageBalanceRight);
                loc1.unit = backend.utils.DataUtils.unitStringPercent;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.pedalSmoothLeftDefined && this.activity.pedalSmoothRightDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BALANCE;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_PEDAL_SMOOTHNESS");
                loc1.value = this.activity.pedalSmoothLeft + " / " + this.activity.pedalSmoothRight;
                loc1.unit = "";
                this.pushLine(loc1, arg1);
            }
            if (this.activity.torqueEffectLeftDefined && this.activity.torqueEffectRightDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BALANCE;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TORQUE_EFFECT");
                loc1.value = this.activity.torqueEffectLeft + " / " + this.activity.torqueEffectRight;
                loc1.unit = "";
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderPedalingTime(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.pedalingTimeDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_PEDALING_TIME;
                loc1.iconSource = frontend.Textures.cadenceicon;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_PEDALING_TIME");
                loc1.setValue(this.activity.pedalingTime, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.pedalingIndexDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_PEDALING_TIME;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_PEDALING_INDEX");
                loc1.setValue(this.activity.pedalingIndex, null, backend.utils.DataUtils.percentFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringPercent;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function _ActivityValuesTabView_CustomGroupedList1_i():frontend.components.list.CustomGroupedList
        {
            var loc1:*=new frontend.components.list.CustomGroupedList();
            loc1.clipContent = false;
            loc1.footerField = "footer";
            loc1.headerField = "header";
            loc1.stickyHeader = true;
            loc1.useVirtualLayout = true;
            loc1.id = "groupedList";
            this.groupedList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "groupedList", this.groupedList);
            return loc1;
        }

        public function ___ActivityValuesTabView_TabLayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        internal function _ActivityValuesTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.values1icon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.VALUES.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[2] = new feathers.binding.Binding(this, function ():feathers.data.HierarchicalCollection
            {
                return dataProvider;
            }, null, "groupedList.dataProvider")
            result[3] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.tabs.values.list.ActivityValueListFooterItemRenderer;
            }, null, "groupedList.footerRendererType")
            result[4] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.tabs.values.list.ActivityValueListHeaderItemRenderer;
            }, null, "groupedList.headerRendererType")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT;
            }, null, "groupedList.height")
            result[6] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.tabs.values.list.ActivityValueListItemRenderer;
            }, null, "groupedList.itemRendererType")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "groupedList.width")
            return result;
        }

        internal static const GROUP_ALTITUDE:String="altitude";

        internal static const GROUP_BALANCE:String="balance";

        internal static const GROUP_BEST_5K:String="best5K";

        internal static const GROUP_CADENCE:String="cadence";

        internal static const GROUP_DISTANCE:String="distance";

        internal static const GROUP_DISTANCEPLUSMINUS:String="distanceplusminus";

        internal static const GROUP_EXPANSION:String="expansion";

        internal static const GROUP_FUELECONOMY:String="fueleconomy";

        internal static const GROUP_HEARTRATE:String="heartrate";

        internal static const GROUP_INCLINE:String="incline";

        internal static const GROUP_KCAL:String="kcal";

        internal static const GROUP_NP:String="np";

        internal static const GROUP_PEDALING_TIME:String="pedalingTime";

        internal static const GROUP_POWER:String="power";

        internal static const GROUP_RISERATE:String="riserate";

        internal static const GROUP_SPEED:String="speed";

        internal static const GROUP_TEMPERATURE:String="temperature";

        internal static const GROUP_TRAININGTIME:String="trainingtime";

        internal static const GROUP_TRIPSECTION:String="tripsection";

        internal var _1258726684groupedList:frontend.components.list.CustomGroupedList;

        internal var _activity:core.activities.Activity;

        public var contentLoadedCallback:Function;

        internal var _655379712contentHeight:Number;

        internal var _339742651dataProvider:feathers.data.HierarchicalCollection;

        internal var dictHCObjects:Array;

        internal var speedBasedObjects:Array;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class ActivitiesList
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


//  class ActivityEdit
package frontend.screen.activities 
{
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.*;
    import core.activities.*;
    import core.general.*;
    import core.sport.*;
    import core.user.*;
    import debug.*;
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
    import frontend.components.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.format.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class ActivityEdit extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ActivityEdit()
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
            bindings = this._ActivityEdit_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_ActivityEditWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ActivityEdit[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._ActivityEdit_CustomVScrollContainer1_i(), this._ActivityEdit_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set unitTypeEditor(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1600350699unitTypeEditor;
            if (loc1 !== arg1) 
            {
                this._1600350699unitTypeEditor = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitTypeEditor", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get userEditor():frontend.components.menuList.MenuListItem
        {
            return this._1176286488userEditor;
        }

        public function set userEditor(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1176286488userEditor;
            if (loc1 !== arg1) 
            {
                this._1176286488userEditor = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "userEditor", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get xAxis():frontend.components.menuList.MenuListItem
        {
            return this._112877625xAxis;
        }

        public function set xAxis(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._112877625xAxis;
            if (loc1 !== arg1) 
            {
                this._112877625xAxis = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "xAxis", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get activity():core.activities.Activity
        {
            return this._1655966961activity;
        }

        public function set activity(arg1:core.activities.Activity):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1655966961activity;
            if (loc1 !== arg1) 
            {
                this._1655966961activity = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "activity", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _saveBikeObj():frontend.components.menuList.MenuListDbObject
        {
            return this._42371238_saveBikeObj;
        }

        internal function set _saveBikeObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._42371238_saveBikeObj;
            if (loc1 !== arg1) 
            {
                this._42371238_saveBikeObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveBikeObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _saveDateObj():frontend.components.menuList.MenuListDbObject
        {
            return this._1511914605_saveDateObj;
        }

        internal function set _saveDateObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1511914605_saveDateObj;
            if (loc1 !== arg1) 
            {
                this._1511914605_saveDateObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveDateObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function loadUsersComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            var loc5:*=new feathers.data.ListCollection();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = new core.user.User();
                loc4.fromDB(loc1[loc2]);
                loc5.push({"label":loc4.name, "data":loc4.userId});
                ++loc2;
            }
            this.userEditor.dataProvider = loc5;
            this.userEditor.defaultValue = this.activity.userId;
            this.userEditor.onInit();
            return;
        }

        internal function get _saveDatetimeObj():frontend.components.menuList.MenuListDbObject
        {
            return this._1705910400_saveDatetimeObj;
        }

        internal function set _saveDatetimeObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1705910400_saveDatetimeObj;
            if (loc1 !== arg1) 
            {
                this._1705910400_saveDatetimeObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveDatetimeObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _saveNameObj():frontend.components.menuList.MenuListDbObject
        {
            return this._1790552176_saveNameObj;
        }

        internal function set _saveNameObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1790552176_saveNameObj;
            if (loc1 !== arg1) 
            {
                this._1790552176_saveNameObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveNameObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _saveSportObj():frontend.components.menuList.MenuListDbObject
        {
            return this._294660959_saveSportObj;
        }

        internal function set _saveSportObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._294660959_saveSportObj;
            if (loc1 !== arg1) 
            {
                this._294660959_saveSportObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveSportObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _saveUserObj():frontend.components.menuList.MenuListDbObject
        {
            return this._78532816_saveUserObj;
        }

        internal function set _saveUserObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._78532816_saveUserObj;
            if (loc1 !== arg1) 
            {
                this._78532816_saveUserObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveUserObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get isLog():Boolean
        {
            return this._100472250isLog;
        }

        internal function set isLog(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._100472250isLog;
            if (loc1 !== arg1) 
            {
                this._100472250isLog = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "isLog", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected override function validateProperties():void
        {
            var loc2:*=0;
            title = this.activity.name;
            this.validateDBObjects();
            if (this.activity.unitType) 
            {
                this.unitTypeEditor.value = this.activity.unitType.toString();
            }
            this.isLog = this.activity.dataType == core.general.DataType.LOG;
            var loc1:*=core.user.User.statementGetUsers();
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadUsersComplete, this.loadUsersError, Workers.worker_DatabaseWorker);
            var loc3:*=handler.SportHandler.getInstance().sports.length;
            var loc4:*=new feathers.data.ListCollection();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (handler.SportHandler.getInstance().sports[loc2].keyName != core.sport.Sport.ACTIVITY_TRACKER) 
                {
                    loc4.push({"label":handler.SportHandler.getInstance().sports[loc2].name, "data":handler.SportHandler.getInstance().sports[loc2].sportId, "selected":handler.SportHandler.getInstance().sports[loc2].sportId == this.activity.sportId});
                }
                ++loc2;
            }
            this.sportsItem.dataProvider = loc4;
            this.sportsItem.defaultValue = this.activity.sportId;
            this.sportsItem.onInit();
            this.validateSportsItem();
            var loc5:*=new feathers.data.ListCollection(core.general.BikeCommon.dp);
            this.bikeEditor.dataProvider = loc5;
            this.bikeEditor.defaultValue = this.activity.bike;
            this.bikeEditor.onInit();
            var loc6:*=new feathers.data.ListCollection();
            var loc7:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this.activity.sport);
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                loc6.push({"label":utils.LanguageManager.getString("UNIT_MPH"), "data":utils.format.SpeedFormat.DISTANCE_PER_TIME, "selected":loc7 == utils.format.SpeedFormat.DISTANCE_PER_TIME});
                loc6.push({"label":utils.LanguageManager.getString("UNIT_MIN_PER_MILE"), "data":utils.format.SpeedFormat.TIME_PER_DISTANCE, "selected":loc7 == utils.format.SpeedFormat.TIME_PER_DISTANCE});
            }
            else 
            {
                loc6.push({"label":utils.LanguageManager.getString("UNIT_KMH"), "data":utils.format.SpeedFormat.DISTANCE_PER_TIME, "selected":loc7 == utils.format.SpeedFormat.DISTANCE_PER_TIME});
                loc6.push({"label":utils.LanguageManager.getString("UNIT_MIN_PER_KM"), "data":utils.format.SpeedFormat.TIME_PER_DISTANCE, "selected":loc7 == utils.format.SpeedFormat.TIME_PER_DISTANCE});
            }
            this.speedFormat.dataProvider = loc6;
            this.speedFormat.defaultValue = loc7;
            this.speedFormat.onInit();
            var loc8:*=new feathers.data.ListCollection();
            var loc9:*=configCache.ConfigCache.getInstance().getSportBaseValue(this.activity.sport);
            loc8.push({"label":utils.LanguageManager.getString("ACTIVITYVIEW.EDIT_X_AXIS_DISTANCE"), "data":core.general.MeasuringUnit.DISTANCE, "selected":loc9 == core.general.MeasuringUnit.DISTANCE});
            loc8.push({"label":utils.LanguageManager.getString("ACTIVITYVIEW.EDIT_X_AXIS_TIME"), "data":core.general.MeasuringUnit.TRAININGTIME, "selected":loc9 == core.general.MeasuringUnit.TRAININGTIME});
            this.xAxis.dataProvider = loc8;
            this.xAxis.defaultValue = loc9;
            this.xAxis.onInit();
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ActivityEdit._watcherSetupUtil = arg1;
            return;
        }

        internal function loadUsersError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("loadUsersError");
            return;
        }

        internal function validateDBObjects():void
        {
            this._saveNameObj = new frontend.components.menuList.MenuListDbObject();
            this._saveNameObj.keyField = "GUID";
            this._saveNameObj.keyValue = this.activity.GUID;
            this._saveNameObj.updateField = core.activities.ActivityMapper.col_name;
            this._saveNameObj.table = "Activity";
            this._saveNameObj.updateModificationDate = true;
            this._saveNameObj.completeCallback = this.onNameChanged;
            this._saveDateObj = new frontend.components.menuList.MenuListDbObject();
            this._saveDateObj.keyField = "GUID";
            this._saveDateObj.keyValue = this.activity.GUID;
            this._saveDateObj.updateField = core.activities.ActivityMapper.col_startDate;
            this._saveDateObj.table = "Activity";
            this._saveDateObj.updateModificationDate = true;
            this._saveDateObj.completeCallback = this.onDateChanged;
            this._saveDatetimeObj = new frontend.components.menuList.MenuListDbObject();
            this._saveDatetimeObj.keyField = "GUID";
            this._saveDatetimeObj.keyValue = this.activity.GUID;
            this._saveDatetimeObj.updateField = core.activities.ActivityMapper.col_startDate;
            this._saveDatetimeObj.table = "Activity";
            this._saveDatetimeObj.updateModificationDate = true;
            this._saveDatetimeObj.completeCallback = this.onDateChanged;
            this._saveUserObj = new frontend.components.menuList.MenuListDbObject();
            this._saveUserObj.keyField = "GUID";
            this._saveUserObj.keyValue = this.activity.GUID;
            this._saveUserObj.updateField = core.activities.ActivityMapper.col_userId;
            this._saveUserObj.table = "Activity";
            this._saveUserObj.updateModificationDate = true;
            this._saveUserObj.completeCallback = this.onUserChanged;
            this._saveSportObj = new frontend.components.menuList.MenuListDbObject();
            this._saveSportObj.keyField = "GUID";
            this._saveSportObj.keyValue = this.activity.GUID;
            this._saveSportObj.updateField = core.activities.ActivityMapper.col_sportId;
            this._saveSportObj.table = "Activity";
            this._saveSportObj.updateModificationDate = true;
            this._saveSportObj.completeCallback = this.onSportChanged;
            this._saveBikeObj = new frontend.components.menuList.MenuListDbObject();
            this._saveBikeObj.keyField = "GUID";
            this._saveBikeObj.keyValue = this.activity.GUID;
            this._saveBikeObj.updateField = core.activities.ActivityMapper.col_bike;
            this._saveBikeObj.table = "Activity";
            this._saveBikeObj.updateModificationDate = true;
            this._saveBikeObj.completeCallback = this.onBikeChanged;
            return;
        }

        internal function onNameChanged(arg1:Object):void
        {
            var loc1:*;
            this.activity.name = loc1 = arg1 as String;
            title = loc1;
            this.onActivityChanged();
            return;
        }

        internal function onDateChanged(arg1:Object):void
        {
            this.activity.startDate = arg1 as Date;
            this.dateEditor.defaultValue = this.activity.startDate;
            this.dateEditor.onInit();
            this.dateTimeEditor.defaultValue = this.activity.startDate;
            this.dateTimeEditor.onInit();
            this.onActivityChanged();
            return;
        }

        internal function onUserChanged(arg1:Object):void
        {
            this.activity.userId = arg1 as uint;
            this.userEditor.defaultValue = this.activity.userId;
            this.userEditor.onInit();
            this.onActivityChanged();
            return;
        }

        internal function onSportChanged(arg1:Object):void
        {
            this.activity.sportId = arg1 as uint;
            this.activity.sport = handler.SportHandler.getInstance().resolveSportById(this.activity.sportId);
            this.sportsItem.defaultValue = this.activity.sportId;
            this.sportsItem.onInit();
            this.validateSportsItem();
            this.onActivityChanged();
            return;
        }

        internal function onBikeChanged(arg1:Object):void
        {
            this.activity.bike = arg1 as String;
            this.bikeEditor.defaultValue = this.activity.bike;
            this.bikeEditor.onInit();
            this.onActivityChanged();
            return;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.deletePopUp = new frontend.components.popup.DeletePopUp();
            this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_ACTIVITY_TITLE");
            this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_ACTIVITY_TEXT");
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
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, handler.ActivityHandler.prepareDelete(this.activity.GUID), this.onDeleteActivityComplete, this.onDeleteActivityError, Workers.worker_DatabaseWorker);
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onDeleteActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().dispatchEvent(new frontend.screen.activities.list.ActivityListEvent(frontend.screen.activities.list.ActivityListEvent.DELETE, this.activity));
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_LIST, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function onDeleteActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteActivityError");
            return;
        }

        internal function onActivityChanged():void
        {
            handler.ActivityHandler.getInstance().dispatchEvent(new frontend.screen.activities.list.ActivityListEvent(frontend.screen.activities.list.ActivityListEvent.UPDATE, this.activity));
            handler.ActivityHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
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
            loc1.requestedColumnCount = 1;
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
                if (this.sportsItem.dataProvider.getItemAt(loc3).data == this.activity.sportId) 
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

        internal function onSpeedFormatChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            configCache.ConfigCache.getInstance().setSportSpeedFormatValue(this.activity.sport, arg1.value as String);
            handler.ViewHandler.getInstance().dispatchEventWith(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED);
            return;
        }

        internal function onAxisChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            configCache.ConfigCache.getInstance().setSportBaseValue(this.activity.sport, arg1.value as String);
            return;
        }

        internal function _ActivityEdit_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.layout = this._ActivityEdit_AnchorLayout1_c();
            loc1.mxmlContent = [this._ActivityEdit_MenuList1_i()];
            loc1.id = "_ActivityEdit_CustomVScrollContainer1";
            this._ActivityEdit_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityEdit_CustomVScrollContainer1", this._ActivityEdit_CustomVScrollContainer1);
            return loc1;
        }

        internal function _ActivityEdit_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityEdit_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._ActivityEdit_MenuListItem1_i(), this._ActivityEdit_MenuListItem2_i(), this._ActivityEdit_MenuListItem3_i(), this._ActivityEdit_MenuListItem4_i(), this._ActivityEdit_MenuListItem5_i(), this._ActivityEdit_MenuListItem6_i(), this._ActivityEdit_MenuListItem7_i(), this._ActivityEdit_MenuListItem8_i(), this._ActivityEdit_MenuListItem9_i()];
            loc1.id = "activityEditors";
            this.activityEditors = loc1;
            feathers.binding.BindingManager.executeBindings(this, "activityEditors", this.activityEditors);
            return loc1;
        }

        internal function _ActivityEdit_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveToDbUseUpdate = true;
            loc1.text = "ACTIVITYVIEW.EDIT_NAME";
            loc1.title = "ACTIVITYVIEW.EDIT_NAME";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "_ActivityEdit_MenuListItem1";
            this._ActivityEdit_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityEdit_MenuListItem1", this._ActivityEdit_MenuListItem1);
            return loc1;
        }

        internal function _ActivityEdit_MenuListItem2_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=null;
            loc1 = new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveToDbUseUpdate = true;
            loc1.text = "ACTIVITYVIEW.EDIT_DATE";
            loc1.title = "ACTIVITYVIEW.EDIT_DATE";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "dateEditor";
            this.dateEditor = loc1;
            feathers.binding.BindingManager.executeBindings(this, "dateEditor", this.dateEditor);
            return loc1;
        }

        internal function _ActivityEdit_MenuListItem3_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveToDbUseUpdate = true;
            loc1.text = "ACTIVITYVIEW.EDIT_DATETIME";
            loc1.title = "ACTIVITYVIEW.EDIT_DATETIME";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "dateTimeEditor";
            this.dateTimeEditor = loc1;
            feathers.binding.BindingManager.executeBindings(this, "dateTimeEditor", this.dateTimeEditor);
            return loc1;
        }

        internal function _ActivityEdit_MenuListItem4_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveToDbUseUpdate = true;
            loc1.text = "ACTIVITYVIEW.EDIT_USER";
            loc1.title = "ACTIVITYVIEW.EDIT_USER";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "userEditor";
            this.userEditor = loc1;
            feathers.binding.BindingManager.executeBindings(this, "userEditor", this.userEditor);
            return loc1;
        }

        internal function _ActivityEdit_MenuListItem5_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveToDbUseUpdate = true;
            loc1.text = "ACTIVITYVIEW.EDIT_SPORT";
            loc1.title = "ACTIVITYVIEW.EDIT_SPORT";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "sportsItem";
            this.sportsItem = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sportsItem", this.sportsItem);
            return loc1;
        }

        internal function _ActivityEdit_MenuListItem6_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveToDbUseUpdate = true;
            loc1.text = "ACTIVITYVIEW.EDIT_BIKE";
            loc1.title = "ACTIVITYVIEW.EDIT_BIKE";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "bikeEditor";
            this.bikeEditor = loc1;
            feathers.binding.BindingManager.executeBindings(this, "bikeEditor", this.bikeEditor);
            return loc1;
        }

        internal function _ActivityEdit_MenuListItem7_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onSpeedFormatChanged;
            loc1.saveToDbUseUpdate = false;
            loc1.text = "ACTIVITYVIEW.EDIT_SPEED_FORMAT";
            loc1.title = "ACTIVITYVIEW.EDIT_SPEED_FORMAT";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "speedFormat";
            this.speedFormat = loc1;
            feathers.binding.BindingManager.executeBindings(this, "speedFormat", this.speedFormat);
            return loc1;
        }

        internal function _ActivityEdit_MenuListItem8_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onAxisChanged;
            loc1.saveToDbUseUpdate = false;
            loc1.text = "ACTIVITYVIEW.EDIT_X_AXIS";
            loc1.title = "ACTIVITYVIEW.EDIT_X_AXIS";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "xAxis";
            this.xAxis = loc1;
            feathers.binding.BindingManager.executeBindings(this, "xAxis", this.xAxis);
            return loc1;
        }

        internal function _ActivityEdit_MenuListItem9_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.defaultValue = "unbekannt";
            loc1.editable = false;
            loc1.saveToDbUseUpdate = false;
            loc1.text = "unitType (debug only)";
            loc1.title = "unitType (debug only)";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = false;
            loc1.useLocalesForTitle = false;
            loc1.id = "unitTypeEditor";
            this.unitTypeEditor = loc1;
            feathers.binding.BindingManager.executeBindings(this, "unitTypeEditor", this.unitTypeEditor);
            return loc1;
        }

        internal function _ActivityEdit_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._ActivityEdit_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ActivityEdit_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_ActivityEdit_IconButton1";
            this._ActivityEdit_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityEdit_IconButton1", this._ActivityEdit_IconButton1);
            return loc1;
        }

        internal function _ActivityEdit_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_ActivityEdit_CustomVScrollContainer1.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ActivityEdit_CustomVScrollContainer1.width")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "activityEditors.width")
            result[3] = new feathers.binding.Binding(this, function ():Object
            {
                return activity.name;
            }, null, "_ActivityEdit_MenuListItem1.defaultValue")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_ActivityEdit_MenuListItem1.minItemHeight")
            result[5] = new feathers.binding.Binding(this, function ():frontend.components.menuList.MenuListDbObject
            {
                return _saveNameObj;
            }, null, "_ActivityEdit_MenuListItem1.saveToDbUseUpdateObject")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityEdit_MenuListItem1.type")
            result[7] = new feathers.binding.Binding(this, function ():Object
            {
                return activity.startDate;
            }, null, "dateEditor.defaultValue")
            result[8] = new feathers.binding.Binding(this, function ():utils.interfaces.ICustomFormatterBase
            {
                return backend.utils.DataUtils.dateFormatter;
            }, null, "dateEditor.formatter")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "dateEditor.minItemHeight")
            result[10] = new feathers.binding.Binding(this, function ():frontend.components.menuList.MenuListDbObject
            {
                return _saveDateObj;
            }, null, "dateEditor.saveToDbUseUpdateObject")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "dateEditor.type")
            result[12] = new feathers.binding.Binding(this, function ():Object
            {
                return activity.startDate;
            }, null, "dateTimeEditor.defaultValue")
            result[13] = new feathers.binding.Binding(this, function ():utils.interfaces.ICustomFormatterBase
            {
                return backend.utils.DataUtils.dateTimeFormatter;
            }, null, "dateTimeEditor.formatter")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "dateTimeEditor.minItemHeight")
            result[15] = new feathers.binding.Binding(this, function ():frontend.components.menuList.MenuListDbObject
            {
                return _saveDatetimeObj;
            }, null, "dateTimeEditor.saveToDbUseUpdateObject")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "dateTimeEditor.type")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "userEditor.minItemHeight")
            result[18] = new feathers.binding.Binding(this, function ():frontend.components.menuList.MenuListDbObject
            {
                return _saveUserObj;
            }, null, "userEditor.saveToDbUseUpdateObject")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "userEditor.type")
            result[20] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "sportsItem.minItemHeight")
            result[21] = new feathers.binding.Binding(this, function ():frontend.components.menuList.MenuListDbObject
            {
                return _saveSportObj;
            }, null, "sportsItem.saveToDbUseUpdateObject")
            result[22] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "sportsItem.type")
            result[23] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "bikeEditor.minItemHeight")
            result[24] = new feathers.binding.Binding(this, function ():frontend.components.menuList.MenuListDbObject
            {
                return _saveBikeObj;
            }, null, "bikeEditor.saveToDbUseUpdateObject")
            result[25] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "bikeEditor.type")
            result[26] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "speedFormat.minItemHeight")
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "speedFormat.type")
            result[28] = new feathers.binding.Binding(this, function ():Boolean
            {
                return isLog;
            }, null, "xAxis.includeInLayout")
            result[29] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "xAxis.minItemHeight")
            result[30] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "xAxis.type")
            result[31] = new feathers.binding.Binding(this, function ():Boolean
            {
                return isLog;
            }, null, "xAxis.visible")
            result[32] = new feathers.binding.Binding(this, function ():Boolean
            {
                return flash.system.Capabilities.isDebugger;
            }, null, "unitTypeEditor.includeInLayout")
            result[33] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "unitTypeEditor.minItemHeight")
            result[34] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "unitTypeEditor.type")
            result[35] = new feathers.binding.Binding(this, function ():Boolean
            {
                return flash.system.Capabilities.isDebugger;
            }, null, "unitTypeEditor.visible")
            result[36] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.trashicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityEdit_IconButton1.image")
            result[37] = new feathers.binding.Binding(this, function ():Function
            {
                return touchHandler;
            }, null, "_ActivityEdit_IconButton1.touchHandler")
            return result;
        }

        public function get activityEditors():frontend.components.menuList.MenuList
        {
            return this._1362169193activityEditors;
        }

        public function set activityEditors(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1362169193activityEditors;
            if (loc1 !== arg1) 
            {
                this._1362169193activityEditors = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "activityEditors", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get bikeEditor():frontend.components.menuList.MenuListItem
        {
            return this._429065390bikeEditor;
        }

        public function set bikeEditor(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._429065390bikeEditor;
            if (loc1 !== arg1) 
            {
                this._429065390bikeEditor = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "bikeEditor", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get dateEditor():frontend.components.menuList.MenuListItem
        {
            return this._116196027dateEditor;
        }

        public function set dateEditor(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._116196027dateEditor;
            if (loc1 !== arg1) 
            {
                this._116196027dateEditor = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dateEditor", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get dateTimeEditor():frontend.components.menuList.MenuListItem
        {
            return this._1649597672dateTimeEditor;
        }

        public function set dateTimeEditor(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1649597672dateTimeEditor;
            if (loc1 !== arg1) 
            {
                this._1649597672dateTimeEditor = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dateTimeEditor", loc1, arg1, this);
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

        public function get speedFormat():frontend.components.menuList.MenuListItem
        {
            return this._1701335838speedFormat;
        }

        public function set speedFormat(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1701335838speedFormat;
            if (loc1 !== arg1) 
            {
                this._1701335838speedFormat = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "speedFormat", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get sportsItem():frontend.components.menuList.MenuListItem
        {
            return this._8445746sportsItem;
        }

        public function set sportsItem(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._8445746sportsItem;
            if (loc1 !== arg1) 
            {
                this._8445746sportsItem = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sportsItem", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unitTypeEditor():frontend.components.menuList.MenuListItem
        {
            return this._1600350699unitTypeEditor;
        }

        public var _ActivityEdit_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _ActivityEdit_IconButton1:frontend.components.button.IconButton;

        public var _ActivityEdit_MenuListItem1:frontend.components.menuList.MenuListItem;

        internal var _1362169193activityEditors:frontend.components.menuList.MenuList;

        internal var _429065390bikeEditor:frontend.components.menuList.MenuListItem;

        internal var _116196027dateEditor:frontend.components.menuList.MenuListItem;

        internal var _1649597672dateTimeEditor:frontend.components.menuList.MenuListItem;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1701335838speedFormat:frontend.components.menuList.MenuListItem;

        internal var _8445746sportsItem:frontend.components.menuList.MenuListItem;

        internal var _1600350699unitTypeEditor:frontend.components.menuList.MenuListItem;

        internal var _112877625xAxis:frontend.components.menuList.MenuListItem;

        internal var _1655966961activity:core.activities.Activity;

        internal var _42371238_saveBikeObj:frontend.components.menuList.MenuListDbObject;

        internal var _1511914605_saveDateObj:frontend.components.menuList.MenuListDbObject;

        internal var _1705910400_saveDatetimeObj:frontend.components.menuList.MenuListDbObject;

        internal var _1790552176_saveNameObj:frontend.components.menuList.MenuListDbObject;

        internal var _294660959_saveSportObj:frontend.components.menuList.MenuListDbObject;

        internal var _78532816_saveUserObj:frontend.components.menuList.MenuListDbObject;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var _100472250isLog:Boolean=true;

        internal var _1176286488userEditor:frontend.components.menuList.MenuListItem;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class ActivityView
package frontend.screen.activities 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import core.general.*;
    import core.units.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.map.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.tabs.graph.*;
    import frontend.screen.activities.tabs.laps.*;
    import frontend.screen.activities.tabs.map.*;
    import frontend.screen.activities.tabs.phases.*;
    import frontend.screen.activities.tabs.values.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class ActivityView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ActivityView()
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
            bindings = this._ActivityView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_ActivityViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.ActivityView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.savePropertiesForBackNavigation = true;
            this.mxmlContent = [this._ActivityView_LayoutGroup1_i(), this._ActivityView_TabContainer1_i(), this._ActivityView_Footer1_i()];
            this.addEventListener("addedToStage", this.___ActivityView_CustomScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___ActivityView_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___ActivityView_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _ActivityView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SPORT_ROW_HEIGHT;
            }, null, "sportRow.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "sportRow.layout")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "sportRow.width")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, SPORT_ROW_PADDING, NaN, 0);
            }, null, "sportIcon.layoutData")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, SPORT_ROW_PADDING, NaN, NaN, NaN, 0);
            }, null, "activityDate.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - SPORT_ROW_HEIGHT;
            }, null, "activitiesTabbar.height")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(SPORT_ROW_HEIGHT);
            }, null, "activitiesTabbar.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "activitiesTabbar.width")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.whiteshareicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityView_IconButton1.image")
            result[9] = new feathers.binding.Binding(this, function ():Function
            {
                return shareActivity_handler;
            }, null, "_ActivityView_IconButton1.touchHandler")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.ghostIcon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityView_IconButton2.image")
            result[11] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _ghostVisible;
            }, null, "_ActivityView_IconButton2.includeInLayout")
            result[12] = new feathers.binding.Binding(this, function ():Function
            {
                return sendGhostToDevice_handler;
            }, null, "_ActivityView_IconButton2.touchHandler")
            result[13] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _ghostVisible;
            }, null, "_ActivityView_IconButton2.touchable")
            result[14] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _ghostVisible;
            }, null, "_ActivityView_IconButton2.visible")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.infoIcon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityView_IconButton3.image")
            result[16] = new feathers.binding.Binding(this, function ():Function
            {
                return editActivity_handler;
            }, null, "_ActivityView_IconButton3.touchHandler")
            return result;
        }

        public function get activitiesTabbar():frontend.components.tab.TabContainer
        {
            return this._679224661activitiesTabbar;
        }

        public function set activitiesTabbar(arg1:frontend.components.tab.TabContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._679224661activitiesTabbar;
            if (loc1 !== arg1) 
            {
                this._679224661activitiesTabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "activitiesTabbar", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get activityDate():feathers.controls.Label
        {
            return this._1628321629activityDate;
        }

        public function set activityDate(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1628321629activityDate;
            if (loc1 !== arg1) 
            {
                this._1628321629activityDate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "activityDate", loc1, arg1, this);
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

        internal function _ActivityView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "activityDate";
            this.activityDate = loc1;
            feathers.binding.BindingManager.executeBindings(this, "activityDate", this.activityDate);
            return loc1;
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

        public function get sportIcon():frontend.components.TextureImage
        {
            return this._970785267sportIcon;
        }

        public function set sportIcon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._970785267sportIcon;
            if (loc1 !== arg1) 
            {
                this._970785267sportIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sportIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get sportRow():feathers.controls.LayoutGroup
        {
            return this._1832421946sportRow;
        }

        internal function get _ghostVisible():Boolean
        {
            return this._799692994_ghostVisible;
        }

        internal function set _ghostVisible(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._799692994_ghostVisible;
            if (loc1 !== arg1) 
            {
                this._799692994_ghostVisible = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_ghostVisible", loc1, arg1, this);
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
            frontend.screen.activities.ActivityView._watcherSetupUtil = arg1;
            return;
        }

        
        {
            initialTabIndex = -1;
        }

        public override function dispose():void
        {
            if (this.activitiesTabbar) 
            {
                this.activitiesTabbar.removeTabs();
            }
            this.sportRow.dispose();
            this.activitiesTabbar.dispose();
            this.footer.dispose();
            super.dispose();
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().openMainMenuOnSwipe(false);
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().openMainMenuOnSwipe(true);
            return;
        }

        protected override function validateProperties():void
        {
            this.activitiesTabbar.removeTabs();
            title = this.activity.name;
            this.sportRow.backgroundSkin = new starling.display.Quad(1, 1, this.activity.sport.color);
            this.sportIcon.textureName = frontend.Textures.sportTextureByKeyName(this.activity.sport.keyName);
            this.activityDate.maxWidth = SIGMALink.appWidth - 3 * SPORT_ROW_PADDING - 80 * SIGMALink.scaleFactor;
            this.activityDate.styleName = this.activity.sport.labelColor != 16777215 ? feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL : feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_WHITE;
            this.activityDate.text = backend.utils.DataUtils.dateFormatter.format(this.activity.startDate) + " - " + backend.utils.DataUtils.dateTimeFormatter.format(this.activity.startDate);
            this.activityValuesTab = new frontend.screen.activities.tabs.values.ActivityValuesTabView();
            this.activityValuesTab.activity = this.activity;
            this.activitiesTabbar.addTab(this.activityValuesTab, true);
            this.activityValuesTab.contentLoadedCallback = this.onContentLoadedCallback;
            if (this.activity.dataType == core.general.DataType.LOG) 
            {
                this.activityGraphTab = new frontend.screen.activities.tabs.graph.ActivityGraphTabView();
                this.activityGraphTab.activity = this.activity;
                this.activitiesTabbar.addTab(this.activityGraphTab);
                if (this.activity.latitudeStartDefined) 
                {
                    this.activityMapTab = new frontend.screen.activities.tabs.map.ActivityMapTabView();
                    this.activityMapTab.mapView.addEventListener(frontend.components.map.MapView.MAP_LOCK_CHANGED, this.onMapLockChanged);
                    this.activityMapTab.activity = this.activity;
                    this.activitiesTabbar.addTab(this.activityMapTab);
                }
                this.activityLapsTab = new frontend.screen.activities.tabs.laps.ActivityLapsTabView();
                this.activityLapsTab.data = this.activity;
                this.activitiesTabbar.addTab(this.activityLapsTab);
                if (core.general.UnitType.PC2814.equals(this.activity.unitType) || core.general.UnitType.SigmaMove.equals(this.activity.unitType)) 
                {
                    this.activityPhasesTab = new frontend.screen.activities.tabs.phases.ActivityPhasesTabView();
                    this.activityPhasesTab.data = this.activity;
                    this.activitiesTabbar.addTab(this.activityPhasesTab);
                }
            }
            this.activityValuesTab.showContent();
            if (!(initialTabIndex == -1) && this.activitiesTabbar.tabbar.dataProvider.length > initialTabIndex) 
            {
                this.activitiesTabbar.tabbar.selectedIndex = initialTabIndex;
            }
            this.checkGhostButtonVisibility();
            return;
        }

        internal function checkGhostButtonVisibility():void
        {
            if (this.activity.dataType != core.general.DataType.LOG) 
            {
                this._ghostVisible = false;
            }
            else 
            {
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.units.Unit.getUnitsByType(core.units.UnitFactory.ghostRaceSupported()), this.onGhostRaceTypesResult, this.onGhostRaceTypesError, Workers.worker_DatabaseWorker);
            }
            return;
        }

        internal function onGhostRaceTypesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this._ghostVisible = false;
            return;
        }

        internal function onGhostRaceTypesResult(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc4:*=null;
            var loc1:*=arg1.getResult();
            var loc2:*=0;
            var loc3:*=0;
            if (loc1) 
            {
                loc3 = loc1.length;
            }
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = core.units.UnitFactory.createUnitFromDB(loc1[loc2]);
                if (backend.utils.dataprovider.UnitsDataProvider.isCommunicationAvailable(loc4.type)) 
                {
                    this._ghostVisible = true;
                    return;
                }
                ++loc2;
            }
            this._ghostVisible = false;
            return;
        }

        internal function onContentLoadedCallback():void
        {
            if (this.activityGraphTab) 
            {
                this.activityGraphTab.showContent();
            }
            if (this.activityMapTab) 
            {
                this.activityMapTab.showContent();
                this.activityMapTab.hideContent();
            }
            if (this.activityLapsTab) 
            {
                this.activityLapsTab.showContent();
            }
            if (this.activityPhasesTab) 
            {
                this.activityPhasesTab.showContent();
            }
            return;
        }

        internal function onMapLockChanged(arg1:starling.events.Event):void
        {
            if (this.activityMapTab.mapView.mapLockActivated) 
            {
                this.activitiesTabbar.customScroller.horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_ON;
            }
            else 
            {
                this.activitiesTabbar.customScroller.horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            }
            return;
        }

        internal function onTabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.selectedTab = arg1.instance;
            if (this.selectedTab is frontend.screen.activities.tabs.map.ActivityMapTabView) 
            {
                (this.selectedTab as frontend.screen.activities.tabs.map.ActivityMapTabView).showContent();
            }
            else if (this.activityMapTab) 
            {
                this.activityMapTab.mapView.mapLockActivated = true;
                this.activityMapTab.hideContent();
            }
            return;
        }

        internal function shareActivity_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_SHARE_ACTIVITY, {"activityId":this.activity.activityId}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function editActivity_handler(arg1:starling.events.TouchEvent):void
        {
            initialTabIndex = this.activitiesTabbar.tabbar.selectedIndex;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITY_EDIT, {"activity":this.activity}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function sendGhostToDevice_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.activity.ghostName = this.activity.name;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_GHOSTRACE_TRANSFER, {"activity":this.activity, "transferModeDownload":false, "backScreenName":handler.ViewHandler.VIEW_ACTIVITY}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _ActivityView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._ActivityView_TextureImage1_i(), this._ActivityView_Label1_i()];
            loc1.id = "sportRow";
            this.sportRow = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sportRow", this.sportRow);
            return loc1;
        }

        internal function _ActivityView_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "sportIcon";
            this.sportIcon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sportIcon", this.sportIcon);
            return loc1;
        }

        public function set sportRow(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1832421946sportRow;
            if (loc1 !== arg1) 
            {
                this._1832421946sportRow = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sportRow", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ActivityView_TabContainer1_i():frontend.components.tab.TabContainer
        {
            var loc1:*=new frontend.components.tab.TabContainer();
            loc1.useIconTabs = true;
            loc1.addEventListener("tabChanged", this.__activitiesTabbar_tabChanged);
            loc1.id = "activitiesTabbar";
            this.activitiesTabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "activitiesTabbar", this.activitiesTabbar);
            return loc1;
        }

        public function __activitiesTabbar_tabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.onTabChanged(arg1);
            return;
        }

        internal function _ActivityView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._ActivityView_IconButton1_i(), this._ActivityView_IconButton2_i(), this._ActivityView_IconButton3_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ActivityView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_ActivityView_IconButton1";
            this._ActivityView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityView_IconButton1", this._ActivityView_IconButton1);
            return loc1;
        }

        internal function _ActivityView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_ActivityView_IconButton2";
            this._ActivityView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityView_IconButton2", this._ActivityView_IconButton2);
            return loc1;
        }

        internal function _ActivityView_IconButton3_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_ActivityView_IconButton3";
            this._ActivityView_IconButton3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityView_IconButton3", this._ActivityView_IconButton3);
            return loc1;
        }

        public function ___ActivityView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public static const SPORT_ROW_HEIGHT:Number=45 * SIGMALink.scaleFactor;

        internal static const SPORT_ROW_PADDING:Number=17 * SIGMALink.scaleFactor;

        public var _ActivityView_IconButton1:frontend.components.button.IconButton;

        public var _ActivityView_IconButton2:frontend.components.button.IconButton;

        public var _ActivityView_IconButton3:frontend.components.button.IconButton;

        internal var _679224661activitiesTabbar:frontend.components.tab.TabContainer;

        internal var _1628321629activityDate:feathers.controls.Label;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _970785267sportIcon:frontend.components.TextureImage;

        public var activity:core.activities.Activity;

        internal var _799692994_ghostVisible:Boolean=false;

        internal var activityGraphTab:frontend.screen.activities.tabs.graph.ActivityGraphTabView;

        internal var activityLapsTab:frontend.screen.activities.tabs.laps.ActivityLapsTabView;

        internal var activityMapTab:frontend.screen.activities.tabs.map.ActivityMapTabView;

        internal var activityPhasesTab:frontend.screen.activities.tabs.phases.ActivityPhasesTabView;

        internal var activityValuesTab:frontend.screen.activities.tabs.values.ActivityValuesTabView;

        internal var selectedTab:frontend.components.tabbarbase.ITabLayoutContainer;

        internal var _1832421946sportRow:feathers.controls.LayoutGroup;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        public static var initialTabIndex:int=-1;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindings:Array;
    }
}


