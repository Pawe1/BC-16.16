//class MyDevices
package frontend.screen.mydevices 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
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
    import frontend.components.popup.*;
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
    import frontend.screen.mydevices.list.*;
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
    
    use namespace mx_internal;
    
    public class MyDevices extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function MyDevices()
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
            bindings = this._MyDevices_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_MyDevicesWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyDevices[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._MyDevices_DeviceList1_i(), this._MyDevices_Footer1_i(), this._MyDevices_Footer2_i()];
            this.addEventListener("initialize", this.___MyDevices_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onDeviceClicked(arg1:frontend.screen.mydevices.list.MyDevicesListItem):void
        {
            var loc1:*=null;
            if (arg1) 
            {
                loc1 = arg1.unit;
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_VIEW, {"unit":loc1}, handler.ViewHandler.slideToLeftTransition());
            }
            return;
        }

        internal function addDevice_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ADD_DEVICE_POSSIBLE_DEVICES, null, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function editDevice_handler(arg1:starling.events.TouchEvent):void
        {
            this.deviceList.listLoader.swapState();
            return;
        }

        internal function deleteDevice_handler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=0;
            var loc3:*=null;
            this._selectedDevice = new Vector.<frontend.screen.mydevices.list.MyDevicesListItem>();
            var loc2:*=this.deviceList.dataProvider.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this.deviceList.dataProvider.data[loc1] as frontend.screen.mydevices.list.MyDevicesListItem;
                if (loc3 && loc3.isSelected()) 
                {
                    this._selectedDevice.push(loc3);
                }
                ++loc1;
            }
            if (this._selectedDevice.length > 0) 
            {
                if (!this.deletePopUp) 
                {
                    this.deletePopUp = new frontend.components.popup.DeletePopUp();
                    this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_DEVICES_TITLE");
                    this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_DEVICES_TEXT");
                    this.deletePopUp.cancelCallback = this.onPopUpClose;
                    this.deletePopUp.deleteCallback = this.onPopUpDelete;
                }
                frontend.components.popup.PopUpBase.showModalPopUp(this.deletePopUp, true, true);
            }
            return;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function _MyDevices_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._MyDevices_IconButton1_i(), this._MyDevices_IconButton2_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function onPopUpDelete():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc2:*=this._selectedDevice.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this._selectedDevice[loc1] as frontend.screen.mydevices.list.MyDevicesListItem;
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.units.Unit.prepareDelete(loc3.unit.GUID), this.onDeleteUnitComplete, this.onDeleteUnitError, Workers.worker_DatabaseWorker, loc3);
                ++loc1;
            }
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            this.deviceList.listLoader.swapState();
            return;
        }

        internal function onDeleteUnitComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.info("Unit wurde gelöscht.");
            var loc1:*=(arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.mydevices.list.MyDevicesListItem;
            this.deviceList.dataProvider.removeItem(loc1);
            loc1.removeSelection();
            handler.AppDeviceHandler.getInstance().dispatchEvent(new frontend.screen.component.devices.DeviceListEvent(frontend.screen.component.devices.DeviceListEvent.RELOAD));
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        public function get clearHistory():Boolean
        {
            return this._clearHistory;
        }

        public function set clearHistory(arg1:Boolean):void
        {
            this._clearHistory = arg1;
            if (this.clearHistory) 
            {
                handler.ViewHandler.getInstance().clearHistory();
            }
            return;
        }

        internal function onDeleteUnitError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Unit konnte nicht gelöscht werden.");
            var loc1:*=(arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.mydevices.list.MyDevicesListItem;
            loc1.removeSelection();
            return;
        }

        internal function _MyDevices_DeviceList1_i():frontend.screen.component.devices.DeviceList
        {
            var loc1:*=new frontend.screen.component.devices.DeviceList();
            loc1.triggeredHandler = this.onDeviceClicked;
            loc1.id = "deviceList";
            this.deviceList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "deviceList", this.deviceList);
            return loc1;
        }

        internal function onInit():void
        {
            this.deviceList.completeCallback = this.onDevicesLoadedComplete;
            handler.AppDeviceHandler.getInstance().addEventListener(frontend.screen.component.devices.DeviceListEvent.RELOAD, this.deviceList.loadUnits);
            handler.AppDeviceHandler.getInstance().addEventListener(frontend.screen.component.devices.DeviceListEvent.UPDATE, this.deviceList.updateUnit);
            handler.AppDeviceHandler.getInstance().addEventListener(frontend.screen.component.devices.DeviceListEvent.DELETE, this.deviceList.deleteUnit);
            return;
        }

        internal function onDevicesLoadedComplete():void
        {
            this.editButton.isEnabled = this.deviceList.dataProvider.length > 0;
            if (this.addButton) 
            {
                this.deviceList.listLoader.noDataText = utils.LanguageManager.getString("NO_DATA_DEVICES");
                this.deviceList.listLoader.noDataIconButtonAnchor = this.addButton;
            }
            return;
        }

        internal function _MyDevices_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "addButton";
            this.addButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "addButton", this.addButton);
            return loc1;
        }

        internal function _MyDevices_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "editButton";
            this.editButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "editButton", this.editButton);
            return loc1;
        }

        internal function _MyDevices_Footer2_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.showBackButton = false;
            loc1.mxmlContent = [this._MyDevices_IconButton3_i(), this._MyDevices_IconButton4_i()];
            loc1.id = "footerEdit";
            this.footerEdit = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footerEdit", this.footerEdit);
            return loc1;
        }

        internal function _MyDevices_IconButton3_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_MyDevices_IconButton3";
            this._MyDevices_IconButton3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MyDevices_IconButton3", this._MyDevices_IconButton3);
            return loc1;
        }

        internal function _MyDevices_IconButton4_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_MyDevices_IconButton4";
            this._MyDevices_IconButton4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MyDevices_IconButton4", this._MyDevices_IconButton4);
            return loc1;
        }

        public function ___MyDevices_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _MyDevices_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICES.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !deviceList.listLoader.listStateHandler.editState;
            }, null, "footer.includeInLayout")
            result[2] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !deviceList.listLoader.listStateHandler.editState;
            }, null, "footer.visible")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.addiconwhite;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "addButton.image")
            result[4] = new feathers.binding.Binding(this, function ():Function
            {
                return addDevice_handler;
            }, null, "addButton.touchHandler")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.editbutton;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "editButton.image")
            result[6] = new feathers.binding.Binding(this, function ():Function
            {
                return editDevice_handler;
            }, null, "editButton.touchHandler")
            result[7] = new feathers.binding.Binding(this, function ():Boolean
            {
                return deviceList.listLoader.listStateHandler.editState;
            }, null, "footerEdit.includeInLayout")
            result[8] = new feathers.binding.Binding(this, function ():Boolean
            {
                return deviceList.listLoader.listStateHandler.editState;
            }, null, "footerEdit.visible")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.trashicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDevices_IconButton3.image")
            result[10] = new feathers.binding.Binding(this, function ():Function
            {
                return deleteDevice_handler;
            }, null, "_MyDevices_IconButton3.touchHandler")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.closeicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MyDevices_IconButton4.image")
            result[12] = new feathers.binding.Binding(this, function ():Function
            {
                return editDevice_handler;
            }, null, "_MyDevices_IconButton4.touchHandler")
            return result;
        }

        public function set editButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1454002652editButton;
            if (loc1 !== arg1) 
            {
                this._1454002652editButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get addButton():frontend.components.button.IconButton
        {
            return this._484847821addButton;
        }

        public function set addButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._484847821addButton;
            if (loc1 !== arg1) 
            {
                this._484847821addButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "addButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get deviceList():frontend.screen.component.devices.DeviceList
        {
            return this._780937236deviceList;
        }

        public function set deviceList(arg1:frontend.screen.component.devices.DeviceList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._780937236deviceList;
            if (loc1 !== arg1) 
            {
                this._780937236deviceList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "deviceList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get editButton():frontend.components.button.IconButton
        {
            return this._1454002652editButton;
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

        public function get footerEdit():frontend.screen.component.Footer
        {
            return this._1420120645footerEdit;
        }

        public function set footerEdit(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1420120645footerEdit;
            if (loc1 !== arg1) 
            {
                this._1420120645footerEdit = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footerEdit", loc1, arg1, this);
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
            MyDevices._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal var _selectedDevice:__AS3__.vec.Vector.<frontend.screen.mydevices.list.MyDevicesListItem>;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var _1268861541footer:frontend.screen.component.Footer;

        public var _MyDevices_IconButton3:frontend.components.button.IconButton;

        public var _MyDevices_IconButton4:frontend.components.button.IconButton;

        internal var _484847821addButton:frontend.components.button.IconButton;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _780937236deviceList:frontend.screen.component.devices.DeviceList;

        internal var _1454002652editButton:frontend.components.button.IconButton;

        internal var _1420120645footerEdit:frontend.screen.component.Footer;

        internal var _clearHistory:Boolean=false;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


