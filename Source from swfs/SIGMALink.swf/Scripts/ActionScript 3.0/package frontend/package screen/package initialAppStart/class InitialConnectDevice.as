//class InitialConnectDevice
package frontend.screen.initialAppStart 
{
    import core.general.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.components.*;
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
    
    public class InitialConnectDevice extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialConnectDevice()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._483870027_compHeight = height;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._InitialConnectDevice_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialConnectDeviceWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialConnectDevice[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._InitialConnectDevice_VerticalLayout1_c();
            this.mxmlContent = [this._InitialConnectDevice_LayoutGroup2_i(), this._InitialConnectDevice_PossibleDevicesList1_i(), this._InitialConnectDevice_AddNewDeviceComponent1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
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

        public function get possibleDevicesList():frontend.screen.mydevices.components.PossibleDevicesList
        {
            return this._916539158possibleDevicesList;
        }

        public function set possibleDevicesList(arg1:frontend.screen.mydevices.components.PossibleDevicesList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._916539158possibleDevicesList;
            if (loc1 !== arg1) 
            {
                this._916539158possibleDevicesList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "possibleDevicesList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _compHeight():Number
        {
            return this._483870027_compHeight;
        }

        internal function set _compHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._483870027_compHeight;
            if (loc1 !== arg1) 
            {
                this._483870027_compHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_compHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public override function set height(arg1:Number):void
        {
            debug.Debug.debug("[InitialConnectdevice.height] " + arg1);
            debug.Debug.debug("[headline.height] " + this.headline.height);
            super.height = arg1;
            this._compHeight = (arg1 - this.headline.height - 1);
            debug.Debug.debug("[_compHeight] " + this._compHeight);
            return;
        }

        internal function get _selectUnitState():Boolean
        {
            return this._2011851154_selectUnitState;
        }

        internal function set _selectUnitState(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2011851154_selectUnitState;
            if (loc1 !== arg1) 
            {
                this._2011851154_selectUnitState = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_selectUnitState", loc1, arg1, this);
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
            frontend.screen.initialAppStart.InitialConnectDevice._watcherSetupUtil = arg1;
            return;
        }

        protected function onHeadlineResize(arg1:starling.events.Event):void
        {
            this._compHeight = (height - this.headline.height - 1);
            return;
        }

        internal function onDeviceExistCallback():void
        {
            if (this.deviceExistsCallback != null) 
            {
                this.deviceExistsCallback();
            }
            return;
        }

        internal function onUnitSelectedCallback(arg1:core.units.Unit):void
        {
            if (arg1 != null) 
            {
                this._selectUnitState = false;
            }
            this.addDeviceComponent.unit = arg1;
            this.possibleDevicesList.validate();
            this.addDeviceComponent.validate();
            if (this.unitSelectedCallback != null) 
            {
                this.unitSelectedCallback(arg1);
            }
            return;
        }

        internal function onDeviceAddetCallback():void
        {
            if (this.deviceAddetCallback != null) 
            {
                this.deviceAddetCallback();
            }
            return;
        }

        public function showDeviceList():void
        {
            this._selectUnitState = true;
            this.possibleDevicesList.validate();
            this.addDeviceComponent.validate();
            return;
        }

        internal function _InitialConnectDevice_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            return loc1;
        }

        internal function _InitialConnectDevice_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialConnectDevice_Label1_i()];
            loc1.addEventListener("resize", this.__headline_resize);
            loc1.id = "headline";
            this.headline = loc1;
            feathers.binding.BindingManager.executeBindings(this, "headline", this.headline);
            return loc1;
        }

        internal function _InitialConnectDevice_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialConnectDevice_Label1";
            this._InitialConnectDevice_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialConnectDevice_Label1", this._InitialConnectDevice_Label1);
            return loc1;
        }

        public function __headline_resize(arg1:starling.events.Event):void
        {
            this.onHeadlineResize(arg1);
            return;
        }

        internal function _InitialConnectDevice_PossibleDevicesList1_i():frontend.screen.mydevices.components.PossibleDevicesList
        {
            var loc1:*=new frontend.screen.mydevices.components.PossibleDevicesList();
            loc1.callBack = this.onUnitSelectedCallback;
            loc1.id = "possibleDevicesList";
            this.possibleDevicesList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "possibleDevicesList", this.possibleDevicesList);
            return loc1;
        }

        internal function _InitialConnectDevice_AddNewDeviceComponent1_i():frontend.screen.mydevices.components.AddNewDeviceComponent
        {
            var loc1:*=new frontend.screen.mydevices.components.AddNewDeviceComponent();
            loc1.deviceAddetCallback = this.onDeviceAddetCallback;
            loc1.deviceExistsCallback = this.onDeviceExistCallback;
            loc1.useSmallLayout = true;
            loc1.id = "addDeviceComponent";
            this.addDeviceComponent = loc1;
            feathers.binding.BindingManager.executeBindings(this, "addDeviceComponent", this.addDeviceComponent);
            return loc1;
        }

        internal function _InitialConnectDevice_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "headline.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "headline.layout")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "headline.width")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(2 * frontend.screen.initialAppStart.InitialAppStart.PADDING, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialConnectDevice_Label1.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUVALUE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialConnectDevice_Label1.styleName")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_DEVICE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialConnectDevice_Label1.text")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialConnectDevice_Label1.width")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return _compHeight;
            }, null, "possibleDevicesList.height")
            result[9] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _selectUnitState;
            }, null, "possibleDevicesList.includeInLayout")
            result[10] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _selectUnitState;
            }, null, "possibleDevicesList.visible")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return _compHeight;
            }, null, "addDeviceComponent.height")
            result[12] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !_selectUnitState;
            }, null, "addDeviceComponent.includeInLayout")
            result[13] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !_selectUnitState;
            }, null, "addDeviceComponent.visible")
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

        public var _InitialConnectDevice_Label1:feathers.controls.Label;

        internal var _1192405094addDeviceComponent:frontend.screen.mydevices.components.AddNewDeviceComponent;

        internal var _1115058732headline:feathers.controls.LayoutGroup;

        internal var _916539158possibleDevicesList:frontend.screen.mydevices.components.PossibleDevicesList;

        public var deviceAddetCallback:Function;

        public var deviceExistsCallback:Function;

        public var unitSelectedCallback:Function;

        internal var _483870027_compHeight:Number;

        internal var _2011851154_selectUnitState:Boolean=false;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


