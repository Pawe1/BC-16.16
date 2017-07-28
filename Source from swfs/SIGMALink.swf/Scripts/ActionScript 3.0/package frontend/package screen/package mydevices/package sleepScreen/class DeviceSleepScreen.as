//class DeviceSleepScreen
package frontend.screen.mydevices.sleepScreen 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.sleepScreen.*;
    import core.units.*;
    import core.units.interfaces.*;
    import feathers.binding.*;
    import feathers.controls.renderers.*;
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
    import frontend.components.list.*;
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
    import utils.*;
    
    use namespace mx_internal;
    
    public class DeviceSleepScreen extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSleepScreen()
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
            bindings = this._DeviceSleepScreen_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sleepScreen_DeviceSleepScreenWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSleepScreen[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._DeviceSleepScreen_CustomList1_i(), this._DeviceSleepScreen_Footer1_i()];
            this.addEventListener("initialize", this.___DeviceSleepScreen_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onInit():void
        {
            var loc1:*=new Vector.<frontend.screen.mydevices.sleepScreen.SleepScreenItem>();
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.bikeAndHills()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.bikeAndHeartrate()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.bikeAndCup()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.street()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.flagHi()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.flagFinish()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.sigma()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.sigmaS()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.iLoveSigma()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.iLoveSigma2()));
            loc1.push(new frontend.screen.mydevices.sleepScreen.SleepScreenItem(core.sleepScreen.SleepScreenSign.sigmaAndHills()));
            this.dataProvider = new feathers.data.ListCollection(loc1);
            return;
        }

        internal function itemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.sleepScreen.SleepScreenRenderer();
            loc1.uploadCallback = this.uploadToDevice;
            return loc1;
        }

        internal function uploadToDevice(arg1:frontend.screen.mydevices.sleepScreen.SleepScreenItem):void
        {
            (this.unit as core.units.interfaces.ISleepScreen).sleepScreen = arg1;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SLEEP_SCREEN_TRANSFER, {"unit":this.unit}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            return;
        }

        internal function _DeviceSleepScreen_CustomList1_i():frontend.components.list.CustomList
        {
            var loc1:*=new frontend.components.list.CustomList();
            loc1.allowMultipleSelection = false;
            loc1.id = "sleepScreenList";
            this.sleepScreenList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sleepScreenList", this.sleepScreenList);
            return loc1;
        }

        internal function _DeviceSleepScreen_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___DeviceSleepScreen_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _DeviceSleepScreen_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SLEEP_SCREEN");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "sleepScreenList.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return dataProvider;
            }, null, "sleepScreenList.dataProvider")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "sleepScreenList.height")
            result[4] = new feathers.binding.Binding(this, function ():Function
            {
                return itemRenderer;
            }, null, "sleepScreenList.itemRendererFactory")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "sleepScreenList.width")
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

        public function get sleepScreenList():frontend.components.list.CustomList
        {
            return this._1273330017sleepScreenList;
        }

        public function set sleepScreenList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1273330017sleepScreenList;
            if (loc1 !== arg1) 
            {
                this._1273330017sleepScreenList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sleepScreenList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get dataProvider():feathers.data.ListCollection
        {
            return this._339742651dataProvider;
        }

        internal function set dataProvider(arg1:feathers.data.ListCollection):void
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

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSleepScreen._watcherSetupUtil = arg1;
            return;
        }

        internal static const padding:Number=20 * SIGMALink.scaleFactor;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1273330017sleepScreenList:frontend.components.list.CustomList;

        public var unit:core.units.Unit;

        internal var _339742651dataProvider:feathers.data.ListCollection;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


