//class MainApplicationDrawer
package frontend.components 
{
    import core.general.*;
    import core.sleepScreen.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.core.*;
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
    import frontend.screen.component.*;
    import frontend.screen.mydevices.sleepScreen.*;
    import handler.*;
    import helper.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class MainApplicationDrawer extends feathers.controls.Drawers implements feathers.binding.IBindingClient
    {
        public function MainApplicationDrawer()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._handleAndroidBackButton = helper.Capabilities_helper.isAndroid();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._MainApplicationDrawer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_MainApplicationDrawerWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.components.MainApplicationDrawer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.leftDrawerToggleEventType = "toggleLeftMenu";
            this.content = this._MainApplicationDrawer_LayoutGroup1_i();
            this.addEventListener("close", this.___MainApplicationDrawer_Drawers1_close);
            this.addEventListener("creationComplete", this.___MainApplicationDrawer_Drawers1_creationComplete);
            this.addEventListener("open", this.___MainApplicationDrawer_Drawers1_open);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set header(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1221270899header;
            if (loc1 !== arg1) 
            {
                this._1221270899header = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "header", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get icon():frontend.components.button.IconButton
        {
            return this._3226745icon;
        }

        public function set icon(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3226745icon;
            if (loc1 !== arg1) 
            {
                this._3226745icon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "icon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get layoutGroup():feathers.controls.LayoutGroup
        {
            return this._1989375349layoutGroup;
        }

        public function set layoutGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1989375349layoutGroup;
            if (loc1 !== arg1) 
            {
                this._1989375349layoutGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "layoutGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get navigator():frontend.screen.component.CustomScreenNavigator
        {
            return this._752822871navigator;
        }

        internal function _MainApplicationDrawer_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.addEventListener("touch", this.__icon_touch);
            loc1.id = "icon";
            this.icon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "icon", this.icon);
            return loc1;
        }

        public function set navigator(arg1:frontend.screen.component.CustomScreenNavigator):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._752822871navigator;
            if (loc1 !== arg1) 
            {
                this._752822871navigator = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "navigator", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set handleAndroidBackButton(arg1:Boolean):void
        {
            this._handleAndroidBackButton = arg1 && helper.Capabilities_helper.isAndroid();
            debug.Debug.debug("_handleAndroidBackButton: " + this._handleAndroidBackButton.toString());
            if (this._handleAndroidBackButton) 
            {
                stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            else 
            {
                stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            return;
        }

        public function get titleLabel():feathers.controls.Label
        {
            return this._1791483012titleLabel;
        }

        internal function get online():Boolean
        {
            return this._1012222381online;
        }

        internal function set online(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1012222381online;
            if (loc1 !== arg1) 
            {
                this._1012222381online = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "online", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get wlanOnline():Boolean
        {
            return this._1085177163wlanOnline;
        }

        internal function set wlanOnline(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1085177163wlanOnline;
            if (loc1 !== arg1) 
            {
                this._1085177163wlanOnline = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "wlanOnline", loc1, arg1, this);
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
            frontend.components.MainApplicationDrawer._watcherSetupUtil = arg1;
            return;
        }

        internal function androidBackButtonHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                handler.ViewHandler.getInstance().goBack();
            }
            return;
        }

        public function initMainApplicationDrawer():void
        {
            debug.Debug.info("initMainApplicationDrawer");
            this.initialized = true;
            return;
        }

        internal function onCreationComplete():void
        {
            if (!this.initialized) 
            {
                debug.Debug.info("App not initialized - try again later");
                flash.utils.setTimeout(this.onCreationComplete, 300);
                return;
            }
            debug.Debug.info("onCreationComplete()");
            SIGMALink.appWidth = width;
            SIGMALink.appHeight = height;
            SIGMALink.headerTop = SIGMALink.iOSHeaderCorrectur * SIGMALink.scaleFactor;
            SIGMALink.headerHeight = 85 * SIGMALink.scaleFactor + SIGMALink.headerTop;
            SIGMALink.footerHeight = 75 * SIGMALink.scaleFactor;
            SIGMALink.containerHeight = SIGMALink.appHeight - SIGMALink.headerHeight - SIGMALink.footerHeight;
            handler.ViewHandler.getInstance().drawer = this;
            handler.ViewHandler.getInstance().navigator = this.navigator;
            handler.ViewHandler.getInstance().mainLayoutGroup = this.layoutGroup;
            handler.ViewHandler.getInstance().init();
            this.titleLabel.maxWidth = SIGMALink.appWidth - 4 * padding - this.icon.width - 60 * SIGMALink.scaleFactor;
            this.handleAndroidBackButton = true;
            core.sleepScreen.SleepScreenSign.initSigns(frontend.screen.mydevices.sleepScreen.SleepScreenRenderer.SCREEN_WIDTH, frontend.screen.mydevices.sleepScreen.SleepScreenRenderer.SCREEN_HEIGHT);
            return;
        }

        protected function toggleLeftMenu(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.toggleNavi();
            return;
        }

        public function toggleNavi():void
        {
            this.layoutGroup.dispatchEventWith("toggleLeftMenu");
            return;
        }

        protected function onMenuOpen(arg1:starling.events.Event):void
        {
            this.open = true;
            handler.ViewHandler.getInstance().dispatchEvent(new starling.events.Event(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, false, this.open));
            return;
        }

        protected function onMenuClose(arg1:starling.events.Event):void
        {
            this.open = false;
            handler.ViewHandler.getInstance().dispatchEvent(new starling.events.Event(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, false, this.open));
            return;
        }

        internal function _MainApplicationDrawer_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._MainApplicationDrawer_AnchorLayout1_c();
            loc1.mxmlContent = [this._MainApplicationDrawer_CustomScreenNavigator1_i(), this._MainApplicationDrawer_LayoutGroup2_i()];
            loc1.id = "layoutGroup";
            this.layoutGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "layoutGroup", this.layoutGroup);
            return loc1;
        }

        internal function _MainApplicationDrawer_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _MainApplicationDrawer_CustomScreenNavigator1_i():frontend.screen.component.CustomScreenNavigator
        {
            var loc1:*=new frontend.screen.component.CustomScreenNavigator();
            loc1.id = "navigator";
            this.navigator = loc1;
            feathers.binding.BindingManager.executeBindings(this, "navigator", this.navigator);
            return loc1;
        }

        internal function _MainApplicationDrawer_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._MainApplicationDrawer_LayoutGroup3_i()];
            loc1.id = "_MainApplicationDrawer_LayoutGroup2";
            this._MainApplicationDrawer_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MainApplicationDrawer_LayoutGroup2", this._MainApplicationDrawer_LayoutGroup2);
            return loc1;
        }

        internal function _MainApplicationDrawer_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._MainApplicationDrawer_IconButton1_i(), this._MainApplicationDrawer_IconButton2_i(), this._MainApplicationDrawer_Label1_i()];
            loc1.id = "header";
            this.header = loc1;
            feathers.binding.BindingManager.executeBindings(this, "header", this.header);
            return loc1;
        }

        public function set titleLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1791483012titleLabel;
            if (loc1 !== arg1) 
            {
                this._1791483012titleLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "titleLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function __icon_touch(arg1:starling.events.TouchEvent):void
        {
            this.toggleLeftMenu(arg1);
            return;
        }

        internal function _MainApplicationDrawer_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_MainApplicationDrawer_IconButton2";
            this._MainApplicationDrawer_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MainApplicationDrawer_IconButton2", this._MainApplicationDrawer_IconButton2);
            return loc1;
        }

        internal function _MainApplicationDrawer_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "titleLabel";
            this.titleLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "titleLabel", this.titleLabel);
            return loc1;
        }

        public function ___MainApplicationDrawer_Drawers1_close(arg1:starling.events.Event):void
        {
            this.onMenuClose(arg1);
            return;
        }

        public function ___MainApplicationDrawer_Drawers1_creationComplete(arg1:starling.events.Event):void
        {
            this.onCreationComplete();
            return;
        }

        public function ___MainApplicationDrawer_Drawers1_open(arg1:starling.events.Event):void
        {
            this.onMenuOpen(arg1);
            return;
        }

        internal function _MainApplicationDrawer_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.core.IFeathersControl
            {
                return handler.ViewHandler.getInstance().navi;
            }, null, "this.leftDrawer")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "layoutGroup.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight;
            }, null, "layoutGroup.height")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight - SIGMALink.headerHeight;
            }, null, "navigator.height")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(SIGMALink.headerHeight, 0, 0, 0);
            }, null, "navigator.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "navigator.width")
            result[7] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.RED);
            }, null, "_MainApplicationDrawer_LayoutGroup2.backgroundSkin")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.headerHeight;
            }, null, "_MainApplicationDrawer_LayoutGroup2.height")
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_MainApplicationDrawer_LayoutGroup2.layout")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_MainApplicationDrawer_LayoutGroup2.width")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.headerHeight - SIGMALink.headerTop;
            }, null, "header.height")
            result[12] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "header.layout")
            result[13] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(SIGMALink.headerTop, 0, NaN, 0);
            }, null, "header.layoutData")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "header.width")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.menubutton;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "icon.image")
            result[16] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, padding - frontend.components.button.IconButton.outerPadding, NaN, 0);
            }, null, "icon.layoutData")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.sigmaminiiconwhite;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MainApplicationDrawer_IconButton2.image")
            result[18] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0, NaN, NaN, NaN, 0, NaN);
            }, null, "_MainApplicationDrawer_IconButton2.layoutData")
            result[19] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, padding / 2, NaN, 0, NaN);
            }, null, "titleLabel.layoutData")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "titleLabel.styleName")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.getInstance().currentTitle;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "titleLabel.text")
            return result;
        }

        public function get header():feathers.controls.LayoutGroup
        {
            return this._1221270899header;
        }

        internal static const padding:Number=20 * SIGMALink.scaleFactor;

        public var _MainApplicationDrawer_IconButton2:frontend.components.button.IconButton;

        public var _MainApplicationDrawer_LayoutGroup2:feathers.controls.LayoutGroup;

        internal var _1221270899header:feathers.controls.LayoutGroup;

        internal var _3226745icon:frontend.components.button.IconButton;

        internal var _1989375349layoutGroup:feathers.controls.LayoutGroup;

        internal var _752822871navigator:frontend.screen.component.CustomScreenNavigator;

        internal var _handleAndroidBackButton:Boolean;

        public var open:Boolean=false;

        internal var initialized:Boolean=false;

        internal var _1012222381online:Boolean;

        internal var touchBeginX:uint=0;

        internal var touchBeginY:uint=0;

        internal var _1085177163wlanOnline:Boolean;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal var _1791483012titleLabel:feathers.controls.Label;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


