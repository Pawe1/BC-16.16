//class ActivityEdit
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


