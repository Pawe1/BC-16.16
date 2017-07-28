//class MyDeviceRepair
package frontend.screen.mydevices 
{
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
    import frontend.screen.component.*;
    import frontend.screen.mydevices.components.*;
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
    
    public class MyDeviceRepair extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function MyDeviceRepair()
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
            bindings = this._MyDeviceRepair_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_MyDeviceRepairWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyDeviceRepair[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._MyDeviceRepair_AddNewDeviceComponent1_i(), this._MyDeviceRepair_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onDeviceExistCallback():void
        {
            debug.Debug.error("Device already exists");
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function onDeviceAddetCallback():void
        {
            debug.Debug.debug("Device addet");
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ADD_DEVICE_SET_NAME, {"unit":this.unit}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _MyDeviceRepair_AddNewDeviceComponent1_i():frontend.screen.mydevices.components.AddNewDeviceComponent
        {
            var loc1:*=new frontend.screen.mydevices.components.AddNewDeviceComponent();
            loc1.deviceAddetCallback = this.onDeviceAddetCallback;
            loc1.deviceExistsCallback = this.onDeviceExistCallback;
            loc1.repairUnit = true;
            loc1.id = "addDeviceComponent";
            this.addDeviceComponent = loc1;
            feathers.binding.BindingManager.executeBindings(this, "addDeviceComponent", this.addDeviceComponent);
            return loc1;
        }

        internal function _MyDeviceRepair_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.showBackButton = true;
            loc1.id = "footerEdit";
            this.footerEdit = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footerEdit", this.footerEdit);
            return loc1;
        }

        internal function _MyDeviceRepair_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICES.ADD_DEVICE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, null, null, "addDeviceComponent.unit", "unit");
            return result;
        }

        public function get addDeviceComponent():frontend.screen.mydevices.components.AddNewDeviceComponent
        {
            return this._1192405094addDeviceComponent;
        }

        public function set addDeviceComponent(arg1:frontend.screen.mydevices.components.AddNewDeviceComponent):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1192405094addDeviceComponent;
            if (loc1 !== arg1) 
            {
                this._1192405094addDeviceComponent = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "addDeviceComponent", loc1, arg1, this);
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

        public function get unit():core.units.Unit
        {
            return this._3594628unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3594628unit;
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

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            MyDeviceRepair._watcherSetupUtil = arg1;
            return;
        }

        internal var _1192405094addDeviceComponent:frontend.screen.mydevices.components.AddNewDeviceComponent;

        internal var _1420120645footerEdit:frontend.screen.component.Footer;

        internal var _3594628unit:core.units.Unit;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


