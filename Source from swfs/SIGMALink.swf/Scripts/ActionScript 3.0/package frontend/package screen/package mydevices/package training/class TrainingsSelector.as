//class TrainingsSelector
package frontend.screen.mydevices.training 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.training.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
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
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.popup.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.list.*;
    import handler.*;
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
    
    use namespace mx_internal;
    
    public class TrainingsSelector extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function TrainingsSelector()
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
            bindings = this._TrainingsSelector_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_training_TrainingsSelectorWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TrainingsSelector[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._TrainingsSelector_LayoutGroup1_i(), this._TrainingsSelector_Footer1_i()];
            this.addEventListener("addedToStage", this.___TrainingsSelector_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___TrainingsSelector_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___TrainingsSelector_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
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

        public function get download():Boolean
        {
            return this._1427818632download;
        }

        public function set download(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1427818632download;
            if (loc1 !== arg1) 
            {
                this._1427818632download = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "download", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _trainingsDataProvider():feathers.data.ListCollection
        {
            return this._1101150773_trainingsDataProvider;
        }

        protected function set _trainingsDataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1101150773_trainingsDataProvider;
            if (loc1 !== arg1) 
            {
                this._1101150773_trainingsDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_trainingsDataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _customList():frontend.components.list.CustomList
        {
            return this._493623986_customList;
        }

        public function __row1_resize(arg1:starling.events.Event):void
        {
            this.onResizeRow(arg1);
            return;
        }

        internal function set _customList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._493623986_customList;
            if (loc1 !== arg1) 
            {
                this._493623986_customList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_customList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unit():core.units.Unit
        {
            return this._unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            this._unit = arg1;
            return;
        }

        internal function get _listTitle():String
        {
            return this._1571499739_listTitle;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            TrainingsSelector._watcherSetupUtil = arg1;
            return;
        }

        internal static function get ROW_PADDING():Number
        {
            return TrainingsSelector._25669012ROW_PADDING;
        }

        internal static function set ROW_PADDING(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=TrainingsSelector._25669012ROW_PADDING;
            if (loc1 !== arg1) 
            {
                TrainingsSelector._25669012ROW_PADDING = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_PADDING", loc1, arg1, TrainingsSelector);
                loc3 = TrainingsSelector.staticEventDispatcher;
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

        
        {
            _25669012ROW_PADDING = 15 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this._customList = new frontend.components.list.CustomList();
            this._customList.height = frontend.components.menuList.MenuList.ROW_HEIGHT * 3;
            this._customList.width = SIGMALink.appWidth;
            this._customList.allowMultipleSelection = false;
            this._customList.autoHideBackground = false;
            this._customList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._listStateHandler = new frontend.components.list.ListStateHandler(this._customList);
            return;
        }

        protected function onResizeRow(arg1:starling.events.Event):void
        {
            this.listLoader.height = SIGMALink.containerHeight - this.row1.height;
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            var loc1:*=0;
            var loc3:*=null;
            this.trainings = (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.ITrainingsList).trainingsOnDeviceList;
            this._trainingsDataProvider = new feathers.data.ListCollection();
            var loc2:*=this.trainings.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = new frontend.screen.mydevices.list.MyDeviceTrainingsListItem();
                loc3.training = this.trainings[loc1];
                this._trainingsDataProvider.push(loc3);
                ++loc1;
            }
            if (this.download) 
            {
                this._listTitle = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_TRAININGS_SELECT_TRAINING_DOWNLOAD");
                this._customList.itemRendererFactory = this.trainingsMultiSelectItemRenderer;
            }
            this._customList.dataProvider = this._trainingsDataProvider;
            this.listLoader.checkDataProvider();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            if (this._progressPopUp) 
            {
                this._progressPopUp.removeEventListener(frontend.components.popup.ProgressPopUp.PROGRESS_COMPLETE, this.onProgressComplete);
            }
            return;
        }

        internal function trainingsMultiSelectItemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.list.MyDeviceTrainingsRenderer();
            loc1.isEditState(true);
            loc1.allowMultiSelection = true;
            return loc1;
        }

        internal function nextStepSave(arg1:starling.events.TouchEvent):void
        {
            this._progressPopUp = new frontend.components.popup.ProgressPopUp();
            this._progressPopUp.title = utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRAININGS_TITLE");
            this._progressPopUp.text = utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRAININGS_TEXT");
            this._progressPopUp.imageTexture = frontend.Textures.linkIconWhite;
            this._progressPopUp.addEventListener(frontend.components.popup.ProgressPopUp.PROGRESS_COMPLETE, this.onProgressComplete);
            frontend.components.popup.PopUpBase.showModalPopUp(this._progressPopUp);
            flash.utils.setTimeout(this.saveNow, 500);
            return;
        }

        internal function saveNow():void
        {
            var loc1:*=0;
            var loc2:*=this._trainingsDataProvider.length;
            if (this.download) 
            {
                this.trainings = new Vector.<core.training.Training>();
                while (loc1 < loc2) 
                {
                    if ((this._trainingsDataProvider.getItemAt(loc1) as frontend.screen.mydevices.list.MyDeviceTrainingsListItem).isSelected()) 
                    {
                        this.trainings.push((this._trainingsDataProvider.getItemAt(loc1) as frontend.screen.mydevices.list.MyDeviceTrainingsListItem).training);
                        (this._trainingsDataProvider.getItemAt(loc1) as frontend.screen.mydevices.list.MyDeviceTrainingsListItem).removeSelection();
                    }
                    ++loc1;
                }
                this._trainingsToSave = this.trainings.length;
                this.saveNextTrainingsProgram();
            }
            return;
        }

        internal function onTrainingDownloadCanceled(arg1:frontend.components.popup.CustomFullscreenContentPopUp):void
        {
            this.goBackSwitch();
            return;
        }

        internal function saveNextTrainingsProgram():void
        {
            var loc1:*=null;
            if (this.trainings.length > 0) 
            {
                loc1 = this.trainings.shift();
                loc1.unit = this.unit;
                loc1.unitGUID = this.unit.GUID;
                loc1.isDeleted = false;
                loc1.modificationDate = new Date().time;
                handler.AppDeviceHandler.getInstance().saveTraining(new backend.utils.dbUtils.DBUtilObject(loc1, this.onInsertDataComplete, this.onInsertDataError, null, true));
            }
            else 
            {
                this._progressPopUp.setProgressPercentage(100);
            }
            return;
        }

        internal function onProgressComplete(arg1:starling.events.Event=null):void
        {
            this._progressPopUp.removeEventListener(frontend.components.popup.ProgressPopUp.PROGRESS_COMPLETE, this.onProgressComplete);
            frontend.components.popup.PopUpBase.removePopUps(this._progressPopUp);
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            this.goBackSwitch();
            return;
        }

        protected function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=100 / this._trainingsToSave * (this._trainingsToSave - this.trainings.length);
            this._progressPopUp.setProgressPercentage(loc1);
            this.saveNextTrainingsProgram();
            return;
        }

        protected function onInsertDataError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertDataError: " + arg1.toString());
            return;
        }

        protected function goBackSwitch():void
        {
            this._listStateHandler.setNormalState();
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function _TrainingsSelector_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._TrainingsSelector_VerticalLayout1_c();
            loc1.mxmlContent = [this._TrainingsSelector_LayoutGroup2_i(), this._TrainingsSelector_ListLoader1_i()];
            loc1.id = "_TrainingsSelector_LayoutGroup1";
            this._TrainingsSelector_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TrainingsSelector_LayoutGroup1", this._TrainingsSelector_LayoutGroup1);
            return loc1;
        }

        internal function _TrainingsSelector_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            loc1.useVirtualLayout = true;
            return loc1;
        }

        internal function _TrainingsSelector_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._TrainingsSelector_Label1_i()];
            loc1.addEventListener("resize", this.__row1_resize);
            loc1.id = "row1";
            this.row1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "row1", this.row1);
            return loc1;
        }

        internal function _TrainingsSelector_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_TrainingsSelector_Label1";
            this._TrainingsSelector_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TrainingsSelector_Label1", this._TrainingsSelector_Label1);
            return loc1;
        }

        internal function set _listTitle(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1571499739_listTitle;
            if (loc1 !== arg1) 
            {
                this._1571499739_listTitle = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_listTitle", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _TrainingsSelector_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        internal function _TrainingsSelector_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._TrainingsSelector_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _TrainingsSelector_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.touchHandler = this.nextStepSave;
            loc1.id = "nextButton";
            this.nextButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "nextButton", this.nextButton);
            return loc1;
        }

        public function ___TrainingsSelector_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___TrainingsSelector_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___TrainingsSelector_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _TrainingsSelector_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.DEVICE_TRAININGS_DOWNLOAD");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_TrainingsSelector_LayoutGroup1.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_TrainingsSelector_LayoutGroup1.height")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_TrainingsSelector_LayoutGroup1.width")
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
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ROW_PADDING, NaN, 0);
            }, null, "_TrainingsSelector_Label1.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TrainingsSelector_Label1.styleName")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_listTitle;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TrainingsSelector_Label1.text")
            result[11] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _customList;
            }, null, "listLoader.list")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=download ? frontend.Textures.saveiconwhite : frontend.Textures.arrowRight;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "nextButton.image")
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

        public var _TrainingsSelector_Label1:feathers.controls.Label;

        public var _TrainingsSelector_LayoutGroup1:feathers.controls.LayoutGroup;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        internal var _1749722107nextButton:frontend.components.button.IconButton;

        internal var _3506583row1:feathers.controls.LayoutGroup;

        internal var _1427818632download:Boolean=true;

        internal var _unit:core.units.Unit;

        protected var _1101150773_trainingsDataProvider:feathers.data.ListCollection;

        internal var _493623986_customList:frontend.components.list.CustomList;

        internal var _listStateHandler:frontend.components.list.ListStateHandler;

        internal var _1571499739_listTitle:String="";

        internal var _progressPopUp:frontend.components.popup.ProgressPopUp;

        internal var _trainingsToSave:uint;

        internal static var _25669012ROW_PADDING:Number;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        mx_internal var _bindingsByDestination:Object;

        public var trainings:__AS3__.vec.Vector.<core.training.Training>;
    }
}


