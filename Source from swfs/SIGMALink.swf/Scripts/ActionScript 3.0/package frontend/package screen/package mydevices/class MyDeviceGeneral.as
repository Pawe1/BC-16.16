//class MyDeviceGeneral
package frontend.screen.mydevices 
{
    import backend.utils.dbUtils.*;
    import core.firmware.*;
    import core.general.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
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
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
    import handler.*;
    import mx.core.*;
    import service.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class MyDeviceGeneral extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function MyDeviceGeneral()
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
            bindings = this._MyDeviceGeneral_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_MyDeviceGeneralWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyDeviceGeneral[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.savePropertiesForBackNavigation = true;
            this.mxmlContent = [this._MyDeviceGeneral_CustomVScrollContainer1_i(), this._MyDeviceGeneral_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set deviceNameEditor(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1776728782deviceNameEditor;
            if (loc1 !== arg1) 
            {
                this._1776728782deviceNameEditor = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "deviceNameEditor", loc1, arg1, this);
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

        public function get menuListComp():frontend.components.menuList.MenuList
        {
            return this._331022156menuListComp;
        }

        public function set menuListComp(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._331022156menuListComp;
            if (loc1 !== arg1) 
            {
                this._331022156menuListComp = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "menuListComp", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scroller():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._402164678scroller;
        }

        public function set scroller(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._402164678scroller;
            if (loc1 !== arg1) 
            {
                this._402164678scroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scroller", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _MyDeviceGeneral_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._MyDeviceGeneral_MenuListItem1_i(), this._MyDeviceGeneral_MenuListItem2_i(), this._MyDeviceGeneral_MenuListItem3_i(), this._MyDeviceGeneral_MenuListItem4_i(), this._MyDeviceGeneral_MenuListItem5_i()];
            loc1.addEventListener("creationComplete", this.__menuListComp_creationComplete);
            loc1.id = "menuListComp";
            this.menuListComp = loc1;
            feathers.binding.BindingManager.executeBindings(this, "menuListComp", this.menuListComp);
            return loc1;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.unit;
            if (loc1 !== arg1) 
            {
                this._3594628unit = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unit", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function set _firmwareButtonLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._276119400_firmwareButtonLabel;
            if (loc1 !== arg1) 
            {
                this._276119400_firmwareButtonLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_firmwareButtonLabel", loc1, arg1, this);
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

        internal function set _3594628unit(arg1:core.units.Unit):void
        {
            this._unit = arg1;
            return;
        }

        internal function get _saveDeviceNameObj():frontend.components.menuList.MenuListDbObject
        {
            return this._2114919878_saveDeviceNameObj;
        }

        internal function set _saveDeviceNameObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2114919878_saveDeviceNameObj;
            if (loc1 !== arg1) 
            {
                this._2114919878_saveDeviceNameObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveDeviceNameObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _unitTypeStr():String
        {
            return this._243673932_unitTypeStr;
        }

        internal function set _unitTypeStr(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._243673932_unitTypeStr;
            if (loc1 !== arg1) 
            {
                this._243673932_unitTypeStr = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_unitTypeStr", loc1, arg1, this);
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
            MyDeviceGeneral._watcherSetupUtil = arg1;
            return;
        }

        internal function validateDBObjects():void
        {
            this._saveDeviceNameObj = new frontend.components.menuList.MenuListDbObject();
            this._saveDeviceNameObj.keyField = core.units.Unit.col_GUID;
            this._saveDeviceNameObj.keyValue = this.unit.GUID;
            this._saveDeviceNameObj.updateField = core.units.Unit.col_externalName;
            this._saveDeviceNameObj.table = core.units.Unit.table_name;
            this._saveDeviceNameObj.updateModificationDate = true;
            return;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.deletePopUp = new frontend.components.popup.DeletePopUp();
            this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_DEVICE_TITLE");
            this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_DEVICE_TEXT");
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
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.units.Unit.prepareDelete(this.unit.GUID), this.onDeleteUnitComplete, this.onDeleteUnitError, Workers.worker_DatabaseWorker);
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onDeleteUnitComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=new frontend.screen.component.devices.DeviceListEvent(frontend.screen.component.devices.DeviceListEvent.DELETE, this.unit);
            handler.AppDeviceHandler.getInstance().dispatchEvent(loc1);
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_MYDEVICES, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function onDeleteUnitError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Unit konnte nicht gelöscht werden.");
            return;
        }

        protected function onListComplete(arg1:starling.events.Event):void
        {
            var loc1:*=20 * SIGMALink.scaleFactor;
            var loc2:*=120 * SIGMALink.scaleFactor;
            this.menuListComp.height = Math.max(SIGMALink.containerHeight, this.menuListComp.height + loc2);
            return;
        }

        protected function onUnitChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.unit[this._saveDeviceNameObj.updateField] = arg2.rawValue;
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            handler.AppDeviceHandler.getInstance().dispatchEvent(new frontend.screen.component.devices.DeviceListEvent(frontend.screen.component.devices.DeviceListEvent.UPDATE, this.unit));
            return;
        }

        internal function checkOrUpdateFirmware():void
        {
            var loc1:*=null;
            return;
        }

        internal function onFwUpdateChecked():void
        {
            if (this._fwUpdate.updateAvailable) 
            {
                this._firmwareButtonLabel = "DEVICEVIEW.GENERAL_FIRMWARE_UPDATE";
            }
            else 
            {
                this._firmwareButtonLabel = "DEVICEVIEW.GENERAL_FIRMWARE_CHECK";
            }
            return;
        }

        internal function onFwUpdateCheckError():void
        {
            debug.Debug.error("FIRMWARE UPDATE CHECK FAILED!");
            return;
        }

        protected override function validateProperties():void
        {
            this._unitTypeStr = core.general.UnitType.formatUnit(this.unit.type);
            this.validateDBObjects();
            if (this._fwUpdate != null) 
            {
                this.onFwUpdateChecked();
            }
            else 
            {
                this._fwUpdate = new core.firmware.FirmwareUpdate(this.unit, handler.ApplicationHandler.SW_VERSION_FOR_FW_REQUEST, handler.ApplicationHandler.isBeta);
                var loc1:*=service.DeviceCommunicationHandler.getInstance().connectionMode;
                switch (loc1) 
                {
                    case service.DeviceCommunicationHandler.CONNECTION_MODE_BLE:
                    case service.DeviceCommunicationHandler.CONNECTION_MODE_USB:
                    {
                        this._fwUpdate.checkUpdate(this.onFwUpdateChecked, this.onFwUpdateCheckError);
                        break;
                    }
                    case service.DeviceCommunicationHandler.CONNECTION_MODE_NFC:
                    case service.DeviceCommunicationHandler.CONNECTION_MODE_NONE:
                    {
                        this._fwUpdate.updateAvailable = false;
                        this.onFwUpdateChecked();
                        break;
                    }
                }
            }
            return;
        }

        internal function _MyDeviceGeneral_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.layout = this._MyDeviceGeneral_AnchorLayout1_c();
            loc1.mxmlContent = [this._MyDeviceGeneral_MenuList1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _MyDeviceGeneral_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function get _firmwareButtonLabel():String
        {
            return this._276119400_firmwareButtonLabel;
        }

        internal function _MyDeviceGeneral_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveToDbUseUpdate = true;
            loc1.text = "DEVICEVIEW.GENERAL_NAME";
            loc1.title = "DEVICEVIEW.GENERAL_NAME";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "deviceNameEditor";
            this.deviceNameEditor = loc1;
            feathers.binding.BindingManager.executeBindings(this, "deviceNameEditor", this.deviceNameEditor);
            return loc1;
        }

        internal function _MyDeviceGeneral_MenuListItem2_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = false;
            loc1.text = "DEVICEVIEW.GENERAL_TYPE";
            loc1.useConfigCache = false;
            loc1.id = "_MyDeviceGeneral_MenuListItem2";
            this._MyDeviceGeneral_MenuListItem2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MyDeviceGeneral_MenuListItem2", this._MyDeviceGeneral_MenuListItem2);
            return loc1;
        }

        internal function _MyDeviceGeneral_MenuListItem3_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = false;
            loc1.text = "DEVICEVIEW.GENERAL_SERIALNUMBER";
            loc1.useConfigCache = false;
            loc1.id = "_MyDeviceGeneral_MenuListItem3";
            this._MyDeviceGeneral_MenuListItem3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MyDeviceGeneral_MenuListItem3", this._MyDeviceGeneral_MenuListItem3);
            return loc1;
        }

        internal function _MyDeviceGeneral_MenuListItem4_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = false;
            loc1.functionButtonCallback = this.checkOrUpdateFirmware;
            loc1.text = "DEVICEVIEW.GENERAL_FIRMWARE";
            loc1.useConfigCache = false;
            loc1.id = "_MyDeviceGeneral_MenuListItem4";
            this._MyDeviceGeneral_MenuListItem4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MyDeviceGeneral_MenuListItem4", this._MyDeviceGeneral_MenuListItem4);
            return loc1;
        }

        internal function _MyDeviceGeneral_MenuListItem5_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "DEVICEVIEW.DEVICE_REPAIR";
            loc1.id = "_MyDeviceGeneral_MenuListItem5";
            this._MyDeviceGeneral_MenuListItem5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MyDeviceGeneral_MenuListItem5", this._MyDeviceGeneral_MenuListItem5);
            return loc1;
        }

        public function __menuListComp_creationComplete(arg1:starling.events.Event):void
        {
            this.onListComplete(arg1);
            return;
        }

        internal function _MyDeviceGeneral_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._MyDeviceGeneral_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _MyDeviceGeneral_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_MyDeviceGeneral_IconButton1";
            this._MyDeviceGeneral_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MyDeviceGeneral_IconButton1", this._MyDeviceGeneral_IconButton1);
            return loc1;
        }

        internal function _MyDeviceGeneral_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.GENERAL");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0);
            }, null, "menuListComp.layoutData")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "menuListComp.width")
            result[5] = new feathers.binding.Binding(this, function ():Object
            {
                return unit.externalName;
            }, null, "deviceNameEditor.defaultValue")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "deviceNameEditor.minItemHeight")
            result[7] = new feathers.binding.Binding(this, function ():Function
            {
                return onUnitChanged;
            }, null, "deviceNameEditor.saveCompleteCallback")
            result[8] = new feathers.binding.Binding(this, function ():frontend.components.menuList.MenuListDbObject
            {
                return _saveDeviceNameObj;
            }, null, "deviceNameEditor.saveToDbUseUpdateObject")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "deviceNameEditor.type")
            result[10] = new feathers.binding.Binding(this, function ():Object
            {
                return unit.externalName;
            }, null, "deviceNameEditor.value")
            result[11] = new feathers.binding.Binding(this, function ():Object
            {
                return _unitTypeStr;
            }, null, "_MyDeviceGeneral_MenuListItem2.defaultValue")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_MyDeviceGeneral_MenuListItem2.minItemHeight")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDeviceGeneral_MenuListItem2.type")
            result[14] = new feathers.binding.Binding(this, function ():Object
            {
                return _unitTypeStr;
            }, null, "_MyDeviceGeneral_MenuListItem2.value")
            result[15] = new feathers.binding.Binding(this, function ():Object
            {
                return unit.serialNumber;
            }, null, "_MyDeviceGeneral_MenuListItem3.defaultValue")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_MyDeviceGeneral_MenuListItem3.minItemHeight")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDeviceGeneral_MenuListItem3.type")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_firmwareButtonLabel;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDeviceGeneral_MenuListItem4.functionButtonLabel")
            result[19] = new feathers.binding.Binding(this, function ():Boolean
            {
                return false;
            }, null, "_MyDeviceGeneral_MenuListItem4.functionButtonVisible")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=unit.softwareRevision;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDeviceGeneral_MenuListItem4.leftSubLabelText")
            result[21] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_MyDeviceGeneral_MenuListItem4.minItemHeight")
            result[22] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_BUTTON;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDeviceGeneral_MenuListItem4.type")
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_DEVICE_REPAIR;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDeviceGeneral_MenuListItem5.destination")
            result[24] = new feathers.binding.Binding(this, function ():Object
            {
                return {"unit":unit};
            }, null, "_MyDeviceGeneral_MenuListItem5.destinationObject")
            result[25] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_MyDeviceGeneral_MenuListItem5.minItemHeight")
            result[26] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDeviceGeneral_MenuListItem5.type")
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.trashicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDeviceGeneral_IconButton1.image")
            result[28] = new feathers.binding.Binding(this, function ():Function
            {
                return touchHandler;
            }, null, "_MyDeviceGeneral_IconButton1.touchHandler")
            return result;
        }

        public function get deviceNameEditor():frontend.components.menuList.MenuListItem
        {
            return this._1776728782deviceNameEditor;
        }

        internal static const padding:Number=20 * SIGMALink.scaleFactor;

        public var _MyDeviceGeneral_IconButton1:frontend.components.button.IconButton;

        public var _MyDeviceGeneral_MenuListItem2:frontend.components.menuList.MenuListItem;

        public var _MyDeviceGeneral_MenuListItem3:frontend.components.menuList.MenuListItem;

        public var _MyDeviceGeneral_MenuListItem4:frontend.components.menuList.MenuListItem;

        public var _MyDeviceGeneral_MenuListItem5:frontend.components.menuList.MenuListItem;

        internal var _1776728782deviceNameEditor:frontend.components.menuList.MenuListItem;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _unit:core.units.Unit;

        internal var _276119400_firmwareButtonLabel:String="DEVICEVIEW.GENERAL_FIRMWARE_CHECK";

        internal var _fwUpdate:core.firmware.FirmwareUpdate;

        internal var _2114919878_saveDeviceNameObj:frontend.components.menuList.MenuListDbObject;

        internal var _243673932_unitTypeStr:String;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal var _331022156menuListComp:frontend.components.menuList.MenuList;

        mx_internal var _watchers:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


