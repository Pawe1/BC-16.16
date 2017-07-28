//class InitialStartComplete
package frontend.screen.initialAppStart 
{
    import core.general.*;
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
    
    public class InitialStartComplete extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialStartComplete()
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
            bindings = this._InitialStartComplete_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialStartCompleteWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialStartComplete[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._InitialStartComplete_LayoutGroup2_i()];
            this.addEventListener("initialize", this.___InitialStartComplete_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this.vl = new feathers.layout.VerticalLayout();
            this.vl.gap = frontend.screen.initialAppStart.InitialAppStart.PADDING;
            return;
        }

        internal function _InitialStartComplete_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialStartComplete_Label1_i(), this._InitialStartComplete_LayoutGroup3_i()];
            loc1.id = "_InitialStartComplete_LayoutGroup2";
            this._InitialStartComplete_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_LayoutGroup2", this._InitialStartComplete_LayoutGroup2);
            return loc1;
        }

        internal function _InitialStartComplete_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialStartComplete_Label1";
            this._InitialStartComplete_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_Label1", this._InitialStartComplete_Label1);
            return loc1;
        }

        internal function _InitialStartComplete_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialStartComplete_Label2_i(), this._InitialStartComplete_Label3_i()];
            loc1.id = "_InitialStartComplete_LayoutGroup3";
            this._InitialStartComplete_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_LayoutGroup3", this._InitialStartComplete_LayoutGroup3);
            return loc1;
        }

        internal function _InitialStartComplete_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialStartComplete_Label2";
            this._InitialStartComplete_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_Label2", this._InitialStartComplete_Label2);
            return loc1;
        }

        internal function _InitialStartComplete_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialStartComplete_Label3";
            this._InitialStartComplete_Label3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialStartComplete_Label3", this._InitialStartComplete_Label3);
            return loc1;
        }

        public function ___InitialStartComplete_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _InitialStartComplete_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return vl;
            }, null, "this.layout")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_InitialStartComplete_LayoutGroup2.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_InitialStartComplete_LayoutGroup2.layout")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialStartComplete_LayoutGroup2.width")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(2 * frontend.screen.initialAppStart.InitialAppStart.PADDING, NaN, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialStartComplete_Label1.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUVALUE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialStartComplete_Label1.styleName")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_HEADLINE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialStartComplete_Label1.text")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialStartComplete_Label1.width")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return vl;
            }, null, "_InitialStartComplete_LayoutGroup3.layout")
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(100 * SIGMALink.scaleFactor, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialStartComplete_LayoutGroup3.layoutData")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialStartComplete_LayoutGroup3.width")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_TEXT_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialStartComplete_Label2.text")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialStartComplete_Label2.width")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_TEXT_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialStartComplete_Label3.text")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialStartComplete_Label3.width")
            return result;
        }

        internal function get vl():feathers.layout.VerticalLayout
        {
            return this._3766vl;
        }

        internal function set vl(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3766vl;
            if (loc1 !== arg1) 
            {
                this._3766vl = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vl", loc1, arg1, this);
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
            frontend.screen.initialAppStart.InitialStartComplete._watcherSetupUtil = arg1;
            return;
        }

        public var _InitialStartComplete_Label1:feathers.controls.Label;

        public var _InitialStartComplete_Label2:feathers.controls.Label;

        public var _InitialStartComplete_Label3:feathers.controls.Label;

        public var _InitialStartComplete_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _InitialStartComplete_LayoutGroup3:feathers.controls.LayoutGroup;

        internal var _3766vl:feathers.layout.VerticalLayout;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


