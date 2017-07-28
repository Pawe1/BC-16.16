//class AppSettings
package frontend.screen.appsettings 
{
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
    import frontend.components.menuList.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
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
    
    public class AppSettings extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function AppSettings()
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
            bindings = this._AppSettings_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_AppSettingsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return AppSettings[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._AppSettings_CustomVScrollContainer1_i(), this._AppSettings_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _AppSettings_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._AppSettings_MenuList1_i()];
            loc1.id = "_AppSettings_CustomVScrollContainer1";
            this._AppSettings_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_CustomVScrollContainer1", this._AppSettings_CustomVScrollContainer1);
            return loc1;
        }

        internal function _AppSettings_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._AppSettings_MenuListItem1_i(), this._AppSettings_MenuListItem2_i(), this._AppSettings_MenuListItem3_i(), this._AppSettings_MenuListItem4_i(), this._AppSettings_MenuListItem5_i(), this._AppSettings_MenuListItem6_i()];
            loc1.id = "_AppSettings_MenuList1";
            this._AppSettings_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuList1", this._AppSettings_MenuList1);
            return loc1;
        }

        internal function _AppSettings_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.ALLGEMEIN";
            loc1.id = "_AppSettings_MenuListItem1";
            this._AppSettings_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem1", this._AppSettings_MenuListItem1);
            return loc1;
        }

        internal function _AppSettings_MenuListItem2_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.BENUTZER";
            loc1.id = "_AppSettings_MenuListItem2";
            this._AppSettings_MenuListItem2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem2", this._AppSettings_MenuListItem2);
            return loc1;
        }

        internal function _AppSettings_MenuListItem3_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.CLOUD";
            loc1.id = "_AppSettings_MenuListItem3";
            this._AppSettings_MenuListItem3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem3", this._AppSettings_MenuListItem3);
            return loc1;
        }

        internal function _AppSettings_MenuListItem4_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN";
            loc1.id = "_AppSettings_MenuListItem4";
            this._AppSettings_MenuListItem4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem4", this._AppSettings_MenuListItem4);
            return loc1;
        }

        internal function _AppSettings_MenuListItem5_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.MOBILESNETZ";
            loc1.id = "_AppSettings_MenuListItem5";
            this._AppSettings_MenuListItem5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem5", this._AppSettings_MenuListItem5);
            return loc1;
        }

        internal function _AppSettings_MenuListItem6_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KARTEN";
            loc1.id = "_AppSettings_MenuListItem6";
            this._AppSettings_MenuListItem6 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem6", this._AppSettings_MenuListItem6);
            return loc1;
        }

        internal function _AppSettings_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _AppSettings_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_AppSettings_CustomVScrollContainer1.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_AppSettings_CustomVScrollContainer1.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_AppSettings_MenuList1.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_ALLGEMEIN;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem1.destination")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.settingsiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem1.iconTexture")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem1.minItemHeight")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem1.type")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_BENUTZER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem2.destination")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.profileiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem2.iconTexture")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem2.minItemHeight")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem2.type")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_CLOUD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem3.destination")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.cloudiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem3.iconTexture")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem3.minItemHeight")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem3.type")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTEN;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem4.destination")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.shareiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem4.iconTexture")
            result[18] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem4.minItemHeight")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem4.type")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_MOBILESNETZ;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem5.destination")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.networkiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem5.iconTexture")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem5.minItemHeight")
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem5.type")
            result[24] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KARTEN;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem6.destination")
            result[25] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.mapsred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem6.iconTexture")
            result[26] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem6.minItemHeight")
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem6.type")
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

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            AppSettings._watcherSetupUtil = arg1;
            return;
        }

        public var _AppSettings_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _AppSettings_MenuList1:frontend.components.menuList.MenuList;

        public var _AppSettings_MenuListItem1:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem2:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem3:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem4:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem5:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem6:frontend.components.menuList.MenuListItem;

        internal var _1268861541footer:frontend.screen.component.Footer;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


