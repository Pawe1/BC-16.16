//class ShortcutNoDevice
package frontend.screen.dashboard 
{
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.*;
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
    
    public class ShortcutNoDevice extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ShortcutNoDevice()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._581074019_paddingBottom = 2 * SIGMALink.scaleFactor;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ShortcutNoDevice_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_dashboard_ShortcutNoDeviceWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.dashboard.ShortcutNoDevice[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ShortcutNoDevice_LayoutGroup2_i(), this._ShortcutNoDevice_TextureImage1_i()];
            this.addEventListener("initialize", this.___ShortcutNoDevice_LayoutGroup1_initialize);
            this.addEventListener("touch", this.___ShortcutNoDevice_LayoutGroup1_touch);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get title():feathers.controls.Label
        {
            return this._110371416title;
        }

        public function set title(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._110371416title;
            if (loc1 !== arg1) 
            {
                this._110371416title = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "title", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _leftGroupWidth():Number
        {
            return this._115690509_leftGroupWidth;
        }

        internal function set _leftGroupWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._115690509_leftGroupWidth;
            if (loc1 !== arg1) 
            {
                this._115690509_leftGroupWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_leftGroupWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _paddingBottom():Number
        {
            return this._581074019_paddingBottom;
        }

        internal function set _paddingBottom(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._581074019_paddingBottom;
            if (loc1 !== arg1) 
            {
                this._581074019_paddingBottom = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_paddingBottom", loc1, arg1, this);
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
            frontend.screen.dashboard.ShortcutNoDevice._watcherSetupUtil = arg1;
            return;
        }

        protected override function validateChildren():void
        {
            super.validateChildren();
            this._leftGroupWidth = this.textGroup.width;
            return;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ADD_DEVICE_POSSIBLE_DEVICES, null, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            (layout as feathers.layout.HorizontalLayout).gap = frontend.screen.dashboard.Dashboard.padding / 2;
            (layout as feathers.layout.HorizontalLayout).padding = frontend.screen.dashboard.Dashboard.padding;
            (layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            return;
        }

        internal function _ShortcutNoDevice_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ShortcutNoDevice_VerticalLayout1_i();
            loc1.mxmlContent = [this._ShortcutNoDevice_Label1_i(), this._ShortcutNoDevice_Label2_i()];
            loc1.id = "textGroup";
            this.textGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "textGroup", this.textGroup);
            return loc1;
        }

        internal function _ShortcutNoDevice_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._ShortcutNoDevice_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ShortcutNoDevice_VerticalLayout1", this._ShortcutNoDevice_VerticalLayout1);
            return loc1;
        }

        internal function _ShortcutNoDevice_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "DASHBOARD_OPTION_TITLE";
            loc1.id = "title";
            this.title = loc1;
            feathers.binding.BindingManager.executeBindings(this, "title", this.title);
            return loc1;
        }

        internal function _ShortcutNoDevice_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "DASHBOARD_OPTION_TEXT";
            loc1.wordWrap = true;
            loc1.id = "text";
            this.text = loc1;
            feathers.binding.BindingManager.executeBindings(this, "text", this.text);
            return loc1;
        }

        internal function _ShortcutNoDevice_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.touchable = false;
            loc1.id = "_ShortcutNoDevice_TextureImage1";
            this._ShortcutNoDevice_TextureImage1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ShortcutNoDevice_TextureImage1", this._ShortcutNoDevice_TextureImage1);
            return loc1;
        }

        public function ___ShortcutNoDevice_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___ShortcutNoDevice_LayoutGroup1_touch(arg1:starling.events.TouchEvent):void
        {
            this.touchHandler(arg1);
            return;
        }

        internal function _ShortcutNoDevice_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.HorizontalLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "this.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.HorizontalLayoutData(100);
            }, null, "textGroup.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.dashboard.Dashboard.padding / 2;
            }, null, "_ShortcutNoDevice_VerticalLayout1.gap")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.NO_DEVICE_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "title.text")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return _leftGroupWidth;
            }, null, "title.width")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.NO_DEVICE_TEXT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "text.text")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return _leftGroupWidth;
            }, null, "text.width")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardbigadddevice;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ShortcutNoDevice_TextureImage1.textureName")
            return result;
        }

        public function get text():feathers.controls.Label
        {
            return this._3556653text;
        }

        public function set text(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3556653text;
            if (loc1 !== arg1) 
            {
                this._3556653text = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "text", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get textGroup():feathers.controls.LayoutGroup
        {
            return this._1059785390textGroup;
        }

        public function set textGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1059785390textGroup;
            if (loc1 !== arg1) 
            {
                this._1059785390textGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "textGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var _ShortcutNoDevice_TextureImage1:frontend.components.TextureImage;

        public var _ShortcutNoDevice_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _3556653text:feathers.controls.Label;

        internal var _1059785390textGroup:feathers.controls.LayoutGroup;

        internal var _110371416title:feathers.controls.Label;

        internal var _115690509_leftGroupWidth:Number=1;

        internal var _581074019_paddingBottom:Number;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


