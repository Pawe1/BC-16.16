//class DatabaseUpdateView
package frontend.screen.databaseUpdate 
{
    import backend.database.*;
    import core.*;
    import core.general.*;
    import database.*;
    import database.update.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.themes.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.events.*;
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
    
    use namespace mx_internal;
    
    public class DatabaseUpdateView extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function DatabaseUpdateView()
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
            bindings = this._DatabaseUpdateView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_databaseUpdate_DatabaseUpdateViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.databaseUpdate.DatabaseUpdateView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DatabaseUpdateView_LayoutGroup2_i(), this._DatabaseUpdateView_LayoutGroup3_i()];
            this.addEventListener("initialize", this.___DatabaseUpdateView_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _DatabaseUpdateView_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "center";
            this._DatabaseUpdateView_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DatabaseUpdateView_VerticalLayout1", this._DatabaseUpdateView_VerticalLayout1);
            return loc1;
        }

        internal function _DatabaseUpdateView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_DatabaseUpdateView_Label1";
            this._DatabaseUpdateView_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DatabaseUpdateView_Label1", this._DatabaseUpdateView_Label1);
            return loc1;
        }

        internal function _DatabaseUpdateView_ProgressBar1_i():feathers.controls.ProgressBar
        {
            var loc1:*=new feathers.controls.ProgressBar();
            loc1.maximum = 100;
            loc1.minimum = 0;
            loc1.value = 0;
            loc1.id = "progress";
            this.progress = loc1;
            feathers.binding.BindingManager.executeBindings(this, "progress", this.progress);
            return loc1;
        }

        public function ___DatabaseUpdateView_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _DatabaseUpdateView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new frontend.screen.databaseUpdate.DatabaseUpdateBackgroundSkin();
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight;
            }, null, "this.height")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            }, null, "bgGroup.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            }, null, "_DatabaseUpdateView_LayoutGroup3.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return _barHeight;
            }, null, "_DatabaseUpdateView_VerticalLayout1.gap")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DatabaseUpdateView_Label1.styleName")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_progressLabel;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DatabaseUpdateView_Label1.text")
            result[9] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return _progressBGSkin;
            }, null, "progress.backgroundSkin")
            result[10] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return _progressFillSkin;
            }, null, "progress.fillSkin")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return _barHeight;
            }, null, "progress.height")
            result[12] = new feathers.binding.Binding(this, function ():feathers.skins.IStyleProvider
            {
                return null;
            }, null, "progress.styleProvider")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 4 * _barHeight;
            }, null, "progress.width")
            return result;
        }

        public function get bgGroup():feathers.controls.LayoutGroup
        {
            return this._201073350bgGroup;
        }

        internal function setProgressBarValue(arg1:Number):void
        {
            this.progress.maximum = 100 * this._requiredUpdateCount;
            this.progress.value = arg1 + this._currentUpdateCount * 100;
            return;
        }

        public function set bgGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._201073350bgGroup;
            if (loc1 !== arg1) 
            {
                this._201073350bgGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "bgGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get progress():feathers.controls.ProgressBar
        {
            return this._1001078227progress;
        }

        public function set progress(arg1:feathers.controls.ProgressBar):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1001078227progress;
            if (loc1 !== arg1) 
            {
                this._1001078227progress = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "progress", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _progressBGSkin():starling.display.Quad
        {
            return this._942681618_progressBGSkin;
        }

        internal function set _progressBGSkin(arg1:starling.display.Quad):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._942681618_progressBGSkin;
            if (loc1 !== arg1) 
            {
                this._942681618_progressBGSkin = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_progressBGSkin", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _progressFillSkin():starling.display.Quad
        {
            return this._471277236_progressFillSkin;
        }

        internal function set _progressFillSkin(arg1:starling.display.Quad):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._471277236_progressFillSkin;
            if (loc1 !== arg1) 
            {
                this._471277236_progressFillSkin = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_progressFillSkin", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function set _progressLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._20385080_progressLabel;
            if (loc1 !== arg1) 
            {
                this._20385080_progressLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_progressLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _stageHeight():Number
        {
            return this._940972026_stageHeight;
        }

        internal function set _stageHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._940972026_stageHeight;
            if (loc1 !== arg1) 
            {
                this._940972026_stageHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_stageHeight", loc1, arg1, this);
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
            frontend.screen.databaseUpdate.DatabaseUpdateView._watcherSetupUtil = arg1;
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this._progressLabel = utils.LanguageManager.getString("DATABASE_UPDATE_IN_PROGRESS");
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight;
            this._progressFillSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this._progressBGSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            this._progressBGSkin.alpha = 0;
            this.checkDatabaseVersion();
            return;
        }

        internal function checkDatabaseVersion():void
        {
            addEventListener(STATUS_LOADED, this.onStatusLoaded);
            this.db = backend.database.DatabaseDefinition.getInstance().getHighestOldDatabase();
            debug.Debug.debug("check db version: " + this.db.versionNumber);
            this.checkDatabaseUpdateStatus(this.db);
            return;
        }

        internal function checkDatabaseUpdateStatus(arg1:database.Database):void
        {
            new database.DatabaseTransaction(this.executeStatusSelectStatement, [arg1], flash.data.SQLMode.READ).commit();
            return;
        }

        public function executeStatusSelectStatement(arg1:database.Database):void
        {
            var p_database:database.Database;
            var stmt:database.DCSQLStatement;

            var loc1:*;
            stmt = null;
            p_database = arg1;
            stmt = new database.DCSQLStatement();
            stmt.addEventListener(flash.events.SQLEvent.RESULT, this.selectStatusComplete);
            stmt.addEventListener(flash.events.SQLErrorEvent.ERROR, this.selectStatusError);
            stmt.text = "select * from Status";
            stmt.data = p_database;
            try 
            {
                stmt.execute();
            }
            catch (error:flash.errors.SQLError)
            {
                stmt.dispatchEvent(new flash.events.SQLErrorEvent(flash.events.SQLErrorEvent.ERROR, false, false, new flash.errors.SQLError(error.operation, error.details + " in " + stmt.text, error.message, error.errorID, error.detailID, error.detailArguments)));
            }
            return;
        }

        internal function selectStatusComplete(arg1:flash.events.SQLEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.selectStatusComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.selectStatusError);
            var loc2:*=loc1.getResult();
            this.status = new core.Status();
            if (loc2.data && loc2.data.length == 1) 
            {
                this.status.fromDB(loc2.data[0]);
            }
            (loc1.data as database.Database).checkStatusFlag = false;
            (loc1.data as database.Database).updateComplete = this.status.dbUpdateNumber == database.CommonDatabaseDefinition.CURRENT_DB_VERSION;
            handler.AppDBHandler.getInstance().commit();
            dispatchEventWith(STATUS_LOADED);
            return;
        }

        internal function selectStatusError(arg1:flash.events.SQLErrorEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.selectStatusComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.selectStatusError);
            (loc1.data as database.Database).checkStatusFlag = false;
            handler.AppDBHandler.getInstance().commit();
            this.checkDatabaseVersion();
            return;
        }

        internal function onStatusLoaded(arg1:starling.events.Event):void
        {
            if (!this._requiredUpdates) 
            {
                this._requiredUpdates = database.CommonDatabaseDefinition.getRequiredUpdates(this.db.versionNumber);
                this._requiredUpdateCount = (this._requiredUpdates.length - 1);
                this._currentUpdateCount = 0;
                debug.Debug.debug("required db updates: " + this._requiredUpdates.toString());
            }
            this._currentUpdateCount = this._requiredUpdates.indexOf(this.status.dbUpdateNumber);
            if (this._currentUpdateCount == -1) 
            {
                this._currentUpdateCount = 0;
            }
            if (this._currentUpdateCount != this._requiredUpdateCount) 
            {
                this.oldDatabase = backend.database.DatabaseDefinition.getInstance().getUpdateTargetDatabase(this._requiredUpdates[this._currentUpdateCount]);
                this.targetDatabase = backend.database.DatabaseDefinition.getInstance().getUpdateTargetDatabase(this._requiredUpdates[this._currentUpdateCount + 1]);
                this.startUpdate();
            }
            else 
            {
                debug.Debug.debug("update complete (" + this._currentUpdateCount + "/" + this._requiredUpdateCount + ")");
                dispatchEventWith(UPDATE_COMPLETE);
            }
            return;
        }

        internal function startUpdate():void
        {
            backend.database.DatabaseUpdate.getInstance().addEventListener(database.update.CommonDatabaseUpdate.DATABASE_OKAY, this.onUpdateProgress);
            backend.database.DatabaseUpdate.getInstance().addEventListener(database.update.CommonDatabaseUpdate.DATABASE_ERROR, this.onUpdateProgress);
            backend.database.DatabaseUpdate.getInstance().addEventListener(database.update.CommonDatabaseUpdate.PROGRESS, this.onSQLUpdateProgress);
            flash.utils.setTimeout(backend.database.DatabaseUpdate.getInstance().runUpdate, 500, this.oldDatabase, this.targetDatabase);
            return;
        }

        internal function onSQLUpdateProgress(arg1:database.update.SQLUpdateEvent):void
        {
            var loc1:*=100 * arg1.value / arg1.maximum;
            this.setProgressBarValue(loc1);
            return;
        }

        internal function get _progressLabel():String
        {
            return this._20385080_progressLabel;
        }

        internal function onUpdateProgress(arg1:flash.events.Event):void
        {
            if (this.targetDatabase.versionNumber <= database.CommonDatabaseDefinition.getInstance().currentDatabase.versionNumber) 
            {
                var loc1:*=arg1.type;
                switch (loc1) 
                {
                    case database.update.CommonDatabaseUpdate.DATABASE_OKAY:
                    {
                        if (this.oldDatabase.directory == this.targetDatabase.directory && !(this.oldDatabase.file.nativePath == this.targetDatabase.file.nativePath)) 
                        {
                            this.oldDatabase.deleteDatabase();
                        }
                        this.checkDatabaseVersion();
                        break;
                    }
                    case database.update.CommonDatabaseUpdate.DATABASE_ERROR:
                    {
                        this.targetDatabase.deleteDatabase();
                        if (this.oldDatabase.createBackupBeforeUpdate) 
                        {
                            this.oldDatabase.restoreFromBackup();
                        }
                        debug.Debug.error("DB-Update error");
                        break;
                    }
                }
            }
            return;
        }

        internal function _DatabaseUpdateView_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "bgGroup";
            this.bgGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "bgGroup", this.bgGroup);
            return loc1;
        }

        internal function _DatabaseUpdateView_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._DatabaseUpdateView_VerticalLayout1_i();
            loc1.mxmlContent = [this._DatabaseUpdateView_Label1_i(), this._DatabaseUpdateView_ProgressBar1_i()];
            loc1.id = "_DatabaseUpdateView_LayoutGroup3";
            this._DatabaseUpdateView_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DatabaseUpdateView_LayoutGroup3", this._DatabaseUpdateView_LayoutGroup3);
            return loc1;
        }

        internal const _barHeight:int=20 * SIGMALink.scaleFactor;

        public static const UPDATE_COMPLETE:String="updateCompleteEvent";

        internal static const STATUS_LOADED:String="statusLoaded";

        public var _DatabaseUpdateView_Label1:feathers.controls.Label;

        public var _DatabaseUpdateView_LayoutGroup3:feathers.controls.LayoutGroup;

        public var _DatabaseUpdateView_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _201073350bgGroup:feathers.controls.LayoutGroup;

        internal var _1001078227progress:feathers.controls.ProgressBar;

        internal var _firstCheck:Boolean=true;

        internal var _942681618_progressBGSkin:starling.display.Quad;

        internal var _471277236_progressFillSkin:starling.display.Quad;

        internal var _20385080_progressLabel:String;

        internal var _requiredUpdateCount:int=0;

        internal var _requiredUpdates:Array;

        internal var _940972026_stageHeight:Number=0;

        internal var db:database.Database;

        internal var oldDatabase:database.Database;

        internal var status:core.Status;

        internal var targetDatabase:database.Database;

        internal var _currentUpdateCount:int=0;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


