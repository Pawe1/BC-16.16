//class AddDevicePossibleDevices
package frontend.screen.mydevices 
{
    import core.units.*;
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
    
    public class AddDevicePossibleDevices extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function AddDevicePossibleDevices()
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
            bindings = this._AddDevicePossibleDevices_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_AddDevicePossibleDevicesWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return AddDevicePossibleDevices[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._AddDevicePossibleDevices_PossibleDevicesList1_c(), this._AddDevicePossibleDevices_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function listCallback(arg1:core.units.Unit):void
        {
            if (arg1 != null) 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ADD_DEVICE, {"unit":arg1}, handler.ViewHandler.slideToLeftTransition(), true);
            }
            return;
        }

        internal function _AddDevicePossibleDevices_PossibleDevicesList1_c():frontend.screen.mydevices.components.PossibleDevicesList
        {
            var loc1:*=new frontend.screen.mydevices.components.PossibleDevicesList();
            loc1.callBack = this.listCallback;
            return loc1;
        }

        internal function _AddDevicePossibleDevices_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.showBackButton = true;
            loc1.id = "footerEdit";
            this.footerEdit = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footerEdit", this.footerEdit);
            return loc1;
        }

        internal function _AddDevicePossibleDevices_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICES.ADD_DEVICE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
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
            AddDevicePossibleDevices._watcherSetupUtil = arg1;
            return;
        }

        internal var _1420120645footerEdit:frontend.screen.component.Footer;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


