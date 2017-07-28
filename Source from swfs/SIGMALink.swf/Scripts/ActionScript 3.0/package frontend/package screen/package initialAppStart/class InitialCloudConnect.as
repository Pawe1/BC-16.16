//class InitialCloudConnect
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
    import frontend.*;
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
    
    public class InitialCloudConnect extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialCloudConnect()
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
            bindings = this._InitialCloudConnect_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialCloudConnectWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialCloudConnect[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._InitialCloudConnect_LayoutGroup2_i()];
            this.addEventListener("initialize", this.___InitialCloudConnect_LayoutGroup1_initialize);
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
            this.hl = new feathers.layout.HorizontalLayout();
            this.hl.gap = frontend.screen.initialAppStart.InitialAppStart.PADDING;
            this.hl.verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            this.vl = new feathers.layout.VerticalLayout();
            this.vl.gap = frontend.screen.initialAppStart.InitialAppStart.PADDING;
            return;
        }

        protected function onLinkTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*="https://www.youtube.com/watch?v=" + utils.LanguageManager.getString("YOUTUBE_SIGMA_CLOUD");
            flash.net.navigateToURL(new flash.net.URLRequest("https://www.youtube.com/watch?v=" + utils.LanguageManager.getString("YOUTUBE_SIGMA_CLOUD")), "_blank");
            return;
        }

        internal function _InitialCloudConnect_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialCloudConnect_ImageLoader1_i(), this._InitialCloudConnect_LayoutGroup3_i()];
            loc1.id = "_InitialCloudConnect_LayoutGroup2";
            this._InitialCloudConnect_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_LayoutGroup2", this._InitialCloudConnect_LayoutGroup2);
            return loc1;
        }

        internal function _InitialCloudConnect_ImageLoader1_i():feathers.controls.ImageLoader
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.id = "_InitialCloudConnect_ImageLoader1";
            this._InitialCloudConnect_ImageLoader1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_ImageLoader1", this._InitialCloudConnect_ImageLoader1);
            return loc1;
        }

        internal function _InitialCloudConnect_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._InitialCloudConnect_Label1_i(), this._InitialCloudConnect_LayoutGroup4_i()];
            loc1.id = "_InitialCloudConnect_LayoutGroup3";
            this._InitialCloudConnect_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_LayoutGroup3", this._InitialCloudConnect_LayoutGroup3);
            return loc1;
        }

        internal function _InitialCloudConnect_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialCloudConnect_Label1";
            this._InitialCloudConnect_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_Label1", this._InitialCloudConnect_Label1);
            return loc1;
        }

        internal function _InitialCloudConnect_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.touchGroup = true;
            loc1.mxmlContent = [this._InitialCloudConnect_ImageLoader2_i(), this._InitialCloudConnect_Label2_i()];
            loc1.addEventListener("touch", this.___InitialCloudConnect_LayoutGroup4_touch);
            loc1.id = "_InitialCloudConnect_LayoutGroup4";
            this._InitialCloudConnect_LayoutGroup4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_LayoutGroup4", this._InitialCloudConnect_LayoutGroup4);
            return loc1;
        }

        internal function _InitialCloudConnect_ImageLoader2_i():feathers.controls.ImageLoader
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.id = "_InitialCloudConnect_ImageLoader2";
            this._InitialCloudConnect_ImageLoader2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_ImageLoader2", this._InitialCloudConnect_ImageLoader2);
            return loc1;
        }

        internal function _InitialCloudConnect_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_InitialCloudConnect_Label2";
            this._InitialCloudConnect_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialCloudConnect_Label2", this._InitialCloudConnect_Label2);
            return loc1;
        }

        public function ___InitialCloudConnect_LayoutGroup4_touch(arg1:starling.events.TouchEvent):void
        {
            this.onLinkTouch(arg1);
            return;
        }

        public function ___InitialCloudConnect_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _InitialCloudConnect_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_InitialCloudConnect_LayoutGroup2.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_InitialCloudConnect_LayoutGroup2.layout")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialCloudConnect_LayoutGroup2.width")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(2 * frontend.screen.initialAppStart.InitialAppStart.PADDING, NaN, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialCloudConnect_ImageLoader1.layoutData")
            result[4] = new feathers.binding.Binding(this, function ():Object
            {
                return frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.sigmacloudlogo);
            }, null, "_InitialCloudConnect_ImageLoader1.source")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return vl;
            }, null, "_InitialCloudConnect_LayoutGroup3.layout")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(100 * SIGMALink.scaleFactor, NaN, frontend.screen.initialAppStart.InitialAppStart.PADDING, frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialCloudConnect_LayoutGroup3.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialCloudConnect_LayoutGroup3.width")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("INITIAL_APP_START_CLOUD_CONNECT_DESC");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialCloudConnect_Label1.text")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialCloudConnect_Label1.width")
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hl;
            }, null, "_InitialCloudConnect_LayoutGroup4.layout")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialCloudConnect_LayoutGroup4.width")
            result[12] = new feathers.binding.Binding(this, function ():Object
            {
                return frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.videoicon);
            }, null, "_InitialCloudConnect_ImageLoader2.source")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.initialAppStart.InitialAppStart.PADDING;
            }, null, "_InitialCloudConnect_Label2.paddingRight")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialCloudConnect_Label2.styleName")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("VIDEO_LINK_TEXT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialCloudConnect_Label2.text")
            return result;
        }

        internal function get hl():feathers.layout.HorizontalLayout
        {
            return this._3332hl;
        }

        internal function set hl(arg1:feathers.layout.HorizontalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3332hl;
            if (loc1 !== arg1) 
            {
                this._3332hl = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hl", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
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
            frontend.screen.initialAppStart.InitialCloudConnect._watcherSetupUtil = arg1;
            return;
        }

        public var _InitialCloudConnect_ImageLoader1:feathers.controls.ImageLoader;

        public var _InitialCloudConnect_ImageLoader2:feathers.controls.ImageLoader;

        public var _InitialCloudConnect_Label1:feathers.controls.Label;

        public var _InitialCloudConnect_Label2:feathers.controls.Label;

        public var _InitialCloudConnect_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _InitialCloudConnect_LayoutGroup3:feathers.controls.LayoutGroup;

        public var _InitialCloudConnect_LayoutGroup4:feathers.controls.LayoutGroup;

        internal var _3332hl:feathers.layout.HorizontalLayout;

        internal var _3766vl:feathers.layout.VerticalLayout;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


