//class DeviceTrainingDetail
package frontend.screen.mydevices.training 
{
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.training.*;
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
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.popup.*;
    import frontend.screen.component.*;
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
    
    public class DeviceTrainingDetail extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceTrainingDetail()
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
            bindings = this._DeviceTrainingDetail_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_training_DeviceTrainingDetailWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceTrainingDetail[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._DeviceTrainingDetail_LayoutGroup1_i(), this._DeviceTrainingDetail_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get phaseList():frontend.components.list.CustomList
        {
            return this._426248007phaseList;
        }

        public function set phaseList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._426248007phaseList;
            if (loc1 !== arg1) 
            {
                this._426248007phaseList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "phaseList", loc1, arg1, this);
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

        internal function get _dataProvider():feathers.data.ListCollection
        {
            return this._1763739238_dataProvider;
        }

        protected override function validateProperties():void
        {
            if (this.training == null) 
            {
                this.training = new core.training.Training();
            }
            if (this.training.unit != null) 
            {
                this._unitName = this.training.unit.externalName;
            }
            title = this.training.name;
            var loc1:*=handler.AppDeviceHandler.getInstance().generateLoadTrainingPhase(this.training.trainingId);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.onLoadTrainingPhaseComplete, this.onLoadTrainingError);
            return;
        }

        internal function set _dataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1763739238_dataProvider;
            if (loc1 !== arg1) 
            {
                this._1763739238_dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_dataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _unitName():String
        {
            return this._202336370_unitName;
        }

        internal function set _unitName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._202336370_unitName;
            if (loc1 !== arg1) 
            {
                this._202336370_unitName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_unitName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        
        {
            _1222191211PADDING_LEFT = 15 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceTrainingDetail._watcherSetupUtil = arg1;
            return;
        }

        internal static function get PADDING_LEFT():Number
        {
            return DeviceTrainingDetail._1222191211PADDING_LEFT;
        }

        internal static function set PADDING_LEFT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=DeviceTrainingDetail._1222191211PADDING_LEFT;
            if (loc1 !== arg1) 
            {
                DeviceTrainingDetail._1222191211PADDING_LEFT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "PADDING_LEFT", loc1, arg1, DeviceTrainingDetail);
                loc3 = DeviceTrainingDetail.staticEventDispatcher;
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

        internal function onLoadTrainingError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            return;
        }

        internal function onLoadTrainingPhaseComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.AppDeviceHandler.getInstance().loadTrainingPhaseComplete(arg1.getResult(), this.training);
            var loc1:*=0;
            var loc2:*=this.training.phasesList.length;
            this._dataProvider = new feathers.data.ListCollection();
            while (loc1 < loc2) 
            {
                this._dataProvider.push(this.training.phasesList[loc1]);
                ++loc1;
            }
            return;
        }

        internal function onListTouch(arg1:starling.events.Event):void
        {
            return;
        }

        internal function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_TRAININGS_TRANSFER, {"unit":this.training.unit, "training":this.training, "transferModeDownload":false, "backScreenName":handler.ViewHandler.VIEW_DEVICE_SETTING}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected function delete_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.deletePopUp = new frontend.components.popup.DeletePopUp();
            this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRAINING_TITLE");
            this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRAINING_TEXT");
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
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.training.TrainingMapper.prepareDelete(this.training.GUID), this.onDeleteComplete, this.onDeleteError, Workers.worker_DatabaseWorker);
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_TRAINING_PROGRAM, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function onDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteSettingsError");
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_TRAINING_PROGRAM, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function _DeviceTrainingDetail_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._DeviceTrainingDetail_VerticalLayout1_c();
            loc1.mxmlContent = [this._DeviceTrainingDetail_LayoutGroup2_i(), this._DeviceTrainingDetail_LayoutGroup3_i(), this._DeviceTrainingDetail_CustomList1_i()];
            loc1.id = "tabVGroup";
            this.tabVGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tabVGroup", this.tabVGroup);
            return loc1;
        }

        internal function _DeviceTrainingDetail_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            return loc1;
        }

        internal function _DeviceTrainingDetail_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._DeviceTrainingDetail_Label1_i()];
            loc1.id = "headline";
            this.headline = loc1;
            feathers.binding.BindingManager.executeBindings(this, "headline", this.headline);
            return loc1;
        }

        internal function _DeviceTrainingDetail_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_DeviceTrainingDetail_Label1";
            this._DeviceTrainingDetail_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceTrainingDetail_Label1", this._DeviceTrainingDetail_Label1);
            return loc1;
        }

        internal function _DeviceTrainingDetail_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._DeviceTrainingDetail_AnchorLayout1_c();
            loc1.mxmlContent = [this._DeviceTrainingDetail_Label2_i(), this._DeviceTrainingDetail_Label3_i(), this._DeviceTrainingDetail_Label4_i()];
            loc1.id = "tableHeader";
            this.tableHeader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tableHeader", this.tableHeader);
            return loc1;
        }

        internal function _DeviceTrainingDetail_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _DeviceTrainingDetail_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_DeviceTrainingDetail_Label2";
            this._DeviceTrainingDetail_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceTrainingDetail_Label2", this._DeviceTrainingDetail_Label2);
            return loc1;
        }

        internal function _DeviceTrainingDetail_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_DeviceTrainingDetail_Label3";
            this._DeviceTrainingDetail_Label3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceTrainingDetail_Label3", this._DeviceTrainingDetail_Label3);
            return loc1;
        }

        internal function _DeviceTrainingDetail_Label4_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_DeviceTrainingDetail_Label4";
            this._DeviceTrainingDetail_Label4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceTrainingDetail_Label4", this._DeviceTrainingDetail_Label4);
            return loc1;
        }

        internal function _DeviceTrainingDetail_CustomList1_i():frontend.components.list.CustomList
        {
            var loc1:*=new frontend.components.list.CustomList();
            loc1.clipContent = true;
            loc1.addEventListener("triggered", this.__phaseList_triggered);
            loc1.id = "phaseList";
            this.phaseList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "phaseList", this.phaseList);
            return loc1;
        }

        public function __phaseList_triggered(arg1:starling.events.Event):void
        {
            this.onListTouch(arg1);
            return;
        }

        internal function _DeviceTrainingDetail_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._DeviceTrainingDetail_IconButton1_i(), this._DeviceTrainingDetail_IconButton2_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _DeviceTrainingDetail_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceTrainingDetail_IconButton1";
            this._DeviceTrainingDetail_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceTrainingDetail_IconButton1", this._DeviceTrainingDetail_IconButton1);
            return loc1;
        }

        internal function _DeviceTrainingDetail_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceTrainingDetail_IconButton2";
            this._DeviceTrainingDetail_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceTrainingDetail_IconButton2", this._DeviceTrainingDetail_IconButton2);
            return loc1;
        }

        internal function _DeviceTrainingDetail_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData();
            }, null, "tabVGroup.layoutData")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tabVGroup.width")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "headline.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return LIST_HEADER_HEIGHT;
            }, null, "headline.height")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "headline.layout")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "headline.width")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING_LEFT, 0, 0);
            }, null, "_DeviceTrainingDetail_Label1.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_Label1.styleName")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_unitName;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_Label1.text")
            result[9] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.DARKFONT);
            }, null, "tableHeader.backgroundSkin")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return LIST_HEADER_HEIGHT;
            }, null, "tableHeader.height")
            result[11] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData();
            }, null, "tableHeader.layoutData")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tableHeader.width")
            result[13] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.PADDING, NaN, 0);
            }, null, "_DeviceTrainingDetail_Label2.layoutData")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_Label2.styleName")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.TRAINING_PROGRAM_PHASE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_Label2.text")
            result[16] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.COL_WIDTH + frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.PADDING, NaN, NaN, NaN, 0);
            }, null, "_DeviceTrainingDetail_Label3.layoutData")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_Label3.styleName")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.TRAINING_PROGRAM_DURATION");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_Label3.text")
            result[19] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.PADDING, NaN, NaN, NaN, 0);
            }, null, "_DeviceTrainingDetail_Label4.layoutData")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_Label4.styleName")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.TRAINING_PROGRAM_HEARTRATE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_Label4.text")
            result[22] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "phaseList.backgroundSkin")
            result[23] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return _dataProvider;
            }, null, "phaseList.dataProvider")
            result[24] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - 2 * LIST_HEADER_HEIGHT;
            }, null, "phaseList.height")
            result[25] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.mydevices.training.TrainingPhaseItemListRenderer;
            }, null, "phaseList.itemRendererType")
            result[26] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "phaseList.width")
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uploadicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_IconButton1.image")
            result[28] = new feathers.binding.Binding(this, function ():Function
            {
                return toDevice_handler;
            }, null, "_DeviceTrainingDetail_IconButton1.touchHandler")
            result[29] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.trashicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceTrainingDetail_IconButton2.image")
            result[30] = new feathers.binding.Binding(this, function ():Function
            {
                return delete_handler;
            }, null, "_DeviceTrainingDetail_IconButton2.touchHandler")
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

        public function get headline():feathers.controls.LayoutGroup
        {
            return this._1115058732headline;
        }

        public function set headline(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1115058732headline;
            if (loc1 !== arg1) 
            {
                this._1115058732headline = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headline", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static const PADDING_TOP:Number=0;

        internal static const LIST_HEADER_HEIGHT:Number=53 * SIGMALink.scaleFactor;

        public var _DeviceTrainingDetail_IconButton1:frontend.components.button.IconButton;

        public var _DeviceTrainingDetail_IconButton2:frontend.components.button.IconButton;

        public var _DeviceTrainingDetail_Label1:feathers.controls.Label;

        public var _DeviceTrainingDetail_Label2:feathers.controls.Label;

        public var _DeviceTrainingDetail_Label3:feathers.controls.Label;

        public var _DeviceTrainingDetail_Label4:feathers.controls.Label;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _426248007phaseList:frontend.components.list.CustomList;

        internal var _1649788830tabVGroup:feathers.controls.LayoutGroup;

        internal var _65701893tableHeader:feathers.controls.LayoutGroup;

        public var training:core.training.Training;

        internal var _1763739238_dataProvider:feathers.data.ListCollection;

        internal var _202336370_unitName:String="";

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var _1115058732headline:feathers.controls.LayoutGroup;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        internal static var _1222191211PADDING_LEFT:Number;
    }
}


