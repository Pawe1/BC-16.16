//class InitialAppSettings
package frontend.screen.initialAppStart 
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
    import frontend.components.menuList.*;
    import frontend.screen.appsettings.allgemein.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class InitialAppSettings extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialAppSettings()
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
            bindings = this._InitialAppSettings_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialAppSettingsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.initialAppStart.InitialAppSettings[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._InitialAppSettings_MenuListItem1_i(), this._InitialAppSettings_GeneralAppSettings1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public override function set height(arg1:Number):void
        {
            super.height = arg1;
            this._scrollerHeight = height - frontend.screen.initialAppStart.InitialAppStart.FOOTER_HEIGHT - frontend.screen.initialAppStart.InitialAppStart.PADDING - 6 * SIGMALink.scaleFactor;
            return;
        }

        internal function _InitialAppSettings_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "INITIAL_APP_SETTINGS_TITLE";
            loc1.touchable = false;
            loc1.id = "_InitialAppSettings_MenuListItem1";
            this._InitialAppSettings_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialAppSettings_MenuListItem1", this._InitialAppSettings_MenuListItem1);
            return loc1;
        }

        internal function _InitialAppSettings_GeneralAppSettings1_i():frontend.screen.appsettings.allgemein.GeneralAppSettings
        {
            var loc1:*=new frontend.screen.appsettings.allgemein.GeneralAppSettings();
            loc1.clipContent = true;
            loc1.id = "_InitialAppSettings_GeneralAppSettings1";
            this._InitialAppSettings_GeneralAppSettings1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_InitialAppSettings_GeneralAppSettings1", this._InitialAppSettings_GeneralAppSettings1);
            return loc1;
        }

        internal function _InitialAppSettings_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.settingsiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_InitialAppSettings_MenuListItem1.iconTexture")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_InitialAppSettings_MenuListItem1.minItemHeight")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return _scrollerHeight;
            }, null, "_InitialAppSettings_GeneralAppSettings1.height")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT + frontend.screen.initialAppStart.InitialAppStart.PADDING);
            }, null, "_InitialAppSettings_GeneralAppSettings1.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_InitialAppSettings_GeneralAppSettings1.width")
            return result;
        }

        internal function get _scrollerHeight():Number
        {
            return this._1361851360_scrollerHeight;
        }

        internal function set _scrollerHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1361851360_scrollerHeight;
            if (loc1 !== arg1) 
            {
                this._1361851360_scrollerHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_scrollerHeight", loc1, arg1, this);
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
            frontend.screen.initialAppStart.InitialAppSettings._watcherSetupUtil = arg1;
            return;
        }

        public var _InitialAppSettings_GeneralAppSettings1:frontend.screen.appsettings.allgemein.GeneralAppSettings;

        public var _InitialAppSettings_MenuListItem1:frontend.components.menuList.MenuListItem;

        internal var _1361851360_scrollerHeight:Number=0;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


