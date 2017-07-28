//package training
//  class DeviceTrainingDetail
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


//  class TrainingPhaseItemListRenderer
package frontend.screen.mydevices.training 
{
    import backend.utils.*;
    import core.general.*;
    import core.training.*;
    import core.training.type.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.formatter.*;
    import starling.display.*;
    import utils.format.*;
    
    public class TrainingPhaseItemListRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function TrainingPhaseItemListRenderer()
        {
            super();
            hasLabelTextRenderer = false;
            styleProvider = null;
            height = ROW_HEIGHT;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        internal function getSimpleLabelText(arg1:feathers.controls.Label, arg2:feathers.controls.Label, arg3:int, arg4:int, arg5:core.training.type.PhaseTarget, arg6:core.training.type.PhaseControl):void
        {
            var loc1:*=arg6;
            switch (loc1) 
            {
                case core.training.type.PhaseControl.PULSE:
                {
                    arg1.text = arg4.toString();
                    break;
                }
                case core.training.type.PhaseControl.TIME:
                {
                    arg1.text = arg3.toString() + "-" + arg4.toString();
                    break;
                }
            }
            loc1 = arg5;
            switch (loc1) 
            {
                case core.training.type.PhaseTarget.HEARTFREQUENCY:
                {
                    arg2.text = backend.utils.DataUtils.unitStringHeartrate;
                    arg2.paddingRight = 0;
                    break;
                }
                case core.training.type.PhaseTarget.PERCENT_MAX_HEARTFREQUENCY:
                {
                    arg2.text = "%";
                    arg2.paddingRight = 17 * SIGMALink.scaleFactor;
                    break;
                }
            }
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            if (!(data is core.training.TrainingPhase)) 
            {
                return;
            }
            var loc1:*=data as core.training.TrainingPhase;
            var loc2:*;
            this._intervallCountLabel.includeInLayout = loc2 = false;
            this._intervallCountLabel.visible = loc2;
            this._durationLabel1.includeInLayout = loc2 = false;
            this._durationLabel1.visible = loc2;
            this._minuteUnitLabel1.includeInLayout = loc2 = false;
            this._minuteUnitLabel1.visible = loc2;
            this._durationLabel2.includeInLayout = loc2 = false;
            this._durationLabel2.visible = loc2;
            this._minuteUnitLabel2.includeInLayout = loc2 = false;
            this._minuteUnitLabel2.visible = loc2;
            this._subGroupVRightH1.includeInLayout = loc2 = true;
            this._subGroupVRightH1.visible = loc2;
            this._subGroupVRightH2.includeInLayout = loc2 = false;
            this._subGroupVRightH2.visible = loc2;
            this._loadRecoveryImage1.includeInLayout = loc2 = false;
            this._loadRecoveryImage1.visible = loc2;
            this._bpmLabel1.includeInLayout = loc2 = false;
            this._bpmLabel1.visible = loc2;
            this._loadRecoveryImage2.includeInLayout = loc2 = false;
            this._loadRecoveryImage2.visible = loc2;
            this._bpmLabel2.includeInLayout = loc2 = false;
            this._bpmLabel2.visible = loc2;
            this._durationLabel1.text = "";
            this._durationLabel2.text = "";
            this._bpmLabel1.text = "";
            this._bpmLabel2.text = "";
            loc2 = loc1.type;
            switch (loc2) 
            {
                case core.training.type.PhaseCategory.INTERVAL:
                {
                    this._phaseImage.textureName = frontend.Textures.reloadicon;
                    this._intervallCountLabel.visible = true;
                    this._intervallCountLabel.includeInLayout = true;
                    this._intervallCountLabel.text = loc1.iterations.toString();
                    if (loc1.loadPhaseControl == core.training.type.PhaseControl.TIME) 
                    {
                        this._durationLabel1.includeInLayout = loc2 = true;
                        this._durationLabel1.visible = loc2;
                        this._durationLabel1.text = this._timeFormatter.format(loc1.loadDuration);
                        this._minuteUnitLabel1.includeInLayout = loc2 = true;
                        this._minuteUnitLabel1.visible = loc2;
                    }
                    if (loc1.recoveryPhaseControl == core.training.type.PhaseControl.TIME) 
                    {
                        this._durationLabel2.includeInLayout = loc2 = true;
                        this._durationLabel2.visible = loc2;
                        this._durationLabel2.text = this._timeFormatter.format(loc1.recoveryDuration);
                        this._minuteUnitLabel2.includeInLayout = loc2 = true;
                        this._minuteUnitLabel2.visible = loc2;
                    }
                    this._subGroupVRightH2.includeInLayout = loc2 = true;
                    this._subGroupVRightH2.visible = loc2;
                    this._loadRecoveryImage1.includeInLayout = loc2 = loc1.loadPhaseControl == core.training.type.PhaseControl.PULSE;
                    this._loadRecoveryImage1.visible = loc2;
                    this._loadRecoveryImage2.includeInLayout = loc2 = loc1.recoveryPhaseControl == core.training.type.PhaseControl.PULSE;
                    this._loadRecoveryImage2.visible = loc2;
                    this._loadRecoveryImage1.textureName = frontend.Textures.iconup;
                    this._loadRecoveryImage2.textureName = frontend.Textures.icondown;
                    this._bpmLabel1.includeInLayout = loc2 = true;
                    this._bpmLabel1.visible = loc2;
                    this._bpmLabel2.includeInLayout = loc2 = true;
                    this._bpmLabel2.visible = loc2;
                    this.getSimpleLabelText(this._bpmLabel1, this._bpmUnitLabel1, loc1.loadTargetMin, loc1.loadTargetMax, loc1.loadTargetType, loc1.loadPhaseControl);
                    this.getSimpleLabelText(this._bpmLabel2, this._bpmUnitLabel2, loc1.recoveryTargetMin, loc1.recoveryTargetMax, loc1.recoveryTargetType, loc1.recoveryPhaseControl);
                    break;
                }
                case core.training.type.PhaseCategory.SIMPLE:
                {
                    this._phaseImage.textureName = frontend.Textures.pfeilrechts;
                    this._intervallCountLabel.text = "";
                    if (loc1.loadPhaseControl == core.training.type.PhaseControl.TIME) 
                    {
                        this._durationLabel1.includeInLayout = loc2 = true;
                        this._durationLabel1.visible = loc2;
                        this._durationLabel1.text = this._timeFormatter.format(loc1.loadDuration);
                        this._minuteUnitLabel1.includeInLayout = loc2 = true;
                        this._minuteUnitLabel1.visible = loc2;
                    }
                    this._loadRecoveryImage1.includeInLayout = loc2 = loc1.loadPhaseControl == core.training.type.PhaseControl.PULSE;
                    this._loadRecoveryImage1.visible = loc2;
                    this._loadRecoveryImage1.textureName = loc1.loadRecovery != core.training.type.PhaseLoadRecovery.LOAD ? frontend.Textures.icondown : frontend.Textures.iconup;
                    this._bpmLabel1.includeInLayout = loc2 = true;
                    this._bpmLabel1.visible = loc2;
                    this.getSimpleLabelText(this._bpmLabel1, this._bpmUnitLabel1, loc1.loadTargetMin, loc1.loadTargetMax, loc1.loadTargetType, loc1.loadPhaseControl);
                    break;
                }
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._timeFormatter = new frontend.formatter.TimeFormatter();
            this._timeFormatter.inputType = utils.format.TimeFormatterConstants.INPUT_HUNDREDTHSSECONDS;
            this._timeFormatter.formatString = "MM:SS";
            this._vLayout = new feathers.layout.VerticalLayout();
            this._vLayout.gap = 5;
            this._vLayout.verticalAlign = VERTICAL_ALIGN_MIDDLE;
            this._vLayout.horizontalAlign = HORIZONTAL_ALIGN_RIGHT;
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 2;
            this._hLayout.horizontalAlign = HORIZONTAL_ALIGN_CENTER;
            this._hLayout.verticalAlign = VERTICAL_ALIGN_MIDDLE;
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._subGroupLeft = new feathers.controls.LayoutGroup();
            this._subGroupLeft.height = ROW_HEIGHT;
            this._subGroupLeft.layout = new feathers.layout.AnchorLayout();
            this._subGroupLeft.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.PADDING, NaN, 0);
            this._group.addChild(this._subGroupLeft);
            this._phaseImage = new frontend.components.TextureImage();
            this._phaseImage.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._subGroupLeft.addChild(this._phaseImage);
            this._intervallCountLabel = new feathers.controls.Label();
            this._intervallCountLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._intervallCountLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER_SMALL;
            this._subGroupLeft.addChild(this._intervallCountLabel);
            this._subGroupMid = new feathers.controls.LayoutGroup();
            this._subGroupMid.height = ROW_HEIGHT;
            this._subGroupMid.layout = new feathers.layout.AnchorLayout();
            this._subGroupMid.layoutData = new feathers.layout.AnchorLayoutData(NaN, frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.COL_WIDTH + frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._subGroupMid);
            this._subGroupVMid = new feathers.controls.LayoutGroup();
            this._subGroupVMid.layout = this._vLayout;
            this._subGroupVMid.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, NaN, 0);
            this._subGroupMid.addChild(this._subGroupVMid);
            this._subGroupVMidH1 = new feathers.controls.LayoutGroup();
            this._subGroupVMidH1.layout = this._hLayout;
            this._subGroupVMid.addChild(this._subGroupVMidH1);
            this._durationLabel1 = new feathers.controls.Label();
            this._durationLabel1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._subGroupVMidH1.addChild(this._durationLabel1);
            this._minuteUnitLabel1 = new feathers.controls.Label();
            this._minuteUnitLabel1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._minuteUnitLabel1.text = frontend.Locales.getString("UNIT_MINUTES");
            this._subGroupVMidH1.addChild(this._minuteUnitLabel1);
            this._subGroupVMidH2 = new feathers.controls.LayoutGroup();
            this._subGroupVMidH2.layout = this._hLayout;
            this._subGroupVMid.addChild(this._subGroupVMidH2);
            this._durationLabel2 = new feathers.controls.Label();
            this._durationLabel2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._subGroupVMidH2.addChild(this._durationLabel2);
            this._minuteUnitLabel2 = new feathers.controls.Label();
            this._minuteUnitLabel2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._minuteUnitLabel2.text = frontend.Locales.getString("UNIT_MINUTES");
            this._subGroupVMidH2.addChild(this._minuteUnitLabel2);
            this._subGroupRight = new feathers.controls.LayoutGroup();
            this._subGroupRight.height = ROW_HEIGHT;
            this._subGroupRight.layout = new feathers.layout.AnchorLayout();
            this._subGroupRight.layoutData = new feathers.layout.AnchorLayoutData(NaN, frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._subGroupRight);
            this._subGroupVRight = new feathers.controls.LayoutGroup();
            this._subGroupVRight.layout = this._vLayout;
            this._subGroupVRight.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, NaN, 0);
            this._subGroupRight.addChild(this._subGroupVRight);
            this._subGroupVRightH1 = new feathers.controls.LayoutGroup();
            this._subGroupVRightH1.layout = this._hLayout;
            this._subGroupVRight.addChild(this._subGroupVRightH1);
            this._loadRecoveryImage1 = new frontend.components.TextureImage();
            this._loadRecoveryImage1.scale = 0.3;
            this._subGroupVRightH1.addChild(this._loadRecoveryImage1);
            this._bpmLabel1 = new feathers.controls.Label();
            this._bpmLabel1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._subGroupVRightH1.addChild(this._bpmLabel1);
            this._bpmUnitLabel1 = new feathers.controls.Label();
            this._bpmUnitLabel1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._subGroupVRightH1.addChild(this._bpmUnitLabel1);
            this._subGroupVRightH2 = new feathers.controls.LayoutGroup();
            this._subGroupVRightH2.layout = this._hLayout;
            this._subGroupVRight.addChild(this._subGroupVRightH2);
            this._loadRecoveryImage2 = new frontend.components.TextureImage();
            this._loadRecoveryImage2.scale = 0.3;
            this._subGroupVRightH2.addChild(this._loadRecoveryImage2);
            this._bpmLabel2 = new feathers.controls.Label();
            this._bpmLabel2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._subGroupVRightH2.addChild(this._bpmLabel2);
            this._bpmUnitLabel2 = new feathers.controls.Label();
            this._bpmUnitLabel2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._subGroupVRightH2.addChild(this._bpmUnitLabel2);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
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

        public static const COL_WIDTH:Number=SIGMALink.appWidth / 3;

        public static const PADDING:Number=17 * SIGMALink.scaleFactor;

        internal static const ROW_HEIGHT:Number=100 * SIGMALink.scaleFactor;

        internal var _bpmLabel1:feathers.controls.Label;

        internal var _bpmLabel2:feathers.controls.Label;

        internal var _bpmUnitLabel1:feathers.controls.Label;

        internal var _bpmUnitLabel2:feathers.controls.Label;

        internal var _durationLabel1:feathers.controls.Label;

        internal var _durationLabel2:feathers.controls.Label;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _hLayout:feathers.layout.HorizontalLayout;

        internal var _intervallCountLabel:feathers.controls.Label;

        internal var _loadRecoveryImage1:frontend.components.TextureImage;

        internal var _loadRecoveryImage2:frontend.components.TextureImage;

        internal var _subGroupVMidH1:feathers.controls.LayoutGroup;

        internal var _subGroupVMidH2:feathers.controls.LayoutGroup;

        internal var _subGroupVRight:feathers.controls.LayoutGroup;

        internal var _subGroupVRightH1:feathers.controls.LayoutGroup;

        internal var _subGroupVRightH2:feathers.controls.LayoutGroup;

        internal var _timeFormatter:frontend.formatter.TimeFormatter;

        internal var _vLayout:feathers.layout.VerticalLayout;

        internal var _subGroupLeft:feathers.controls.LayoutGroup;

        internal var _phaseImage:frontend.components.TextureImage;

        internal var _minuteUnitLabel2:feathers.controls.Label;

        internal var _minuteUnitLabel1:feathers.controls.Label;

        internal var _subGroupRight:feathers.controls.LayoutGroup;

        internal var _subGroupVMid:feathers.controls.LayoutGroup;

        internal var _subGroupMid:feathers.controls.LayoutGroup;
    }
}


//  class TrainingsSelector
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


