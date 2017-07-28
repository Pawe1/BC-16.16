//class ASKarten
package frontend.screen.appsettings.karten 
{
    import configCache.*;
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
    import frontend.components.*;
    import frontend.components.map.*;
    import frontend.components.menuList.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import helper.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASKarten extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASKarten()
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
            bindings = this._ASKarten_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_karten_ASKartenWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASKarten[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASKarten_CustomVScrollContainer1_i(), this._ASKarten_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ASKarten_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("touch", this.___ASKarten_Button1_touch);
            loc1.id = "_ASKarten_Button1";
            this._ASKarten_Button1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_Button1", this._ASKarten_Button1);
            return loc1;
        }

        public function ___ASKarten_Button1_touch(arg1:starling.events.TouchEvent):void
        {
            this.saveButtonTouchHandler(arg1);
            return;
        }

        internal function _ASKarten_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ASKarten_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KARTEN.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_ASKarten_CustomVScrollContainer1.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKarten_CustomVScrollContainer1.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKarten_MenuList1.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheAttributeNames.ENABLE_MAP_CACHING;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_MenuListItem1.configCacheAttribute")
            result[5] = new feathers.binding.Binding(this, function ():Object
            {
                return true;
            }, null, "_ASKarten_MenuListItem1.defaultValue")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_MenuListItem1.type")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_MenuListItem2.type")
            result[8] = new feathers.binding.Binding(this, function ():Object
            {
                return _dirSizeLabel;
            }, null, "_ASKarten_MenuListItem2.value")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return GAP;
            }, null, "_ASKarten_VerticalLayout1.gap")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return GAP;
            }, null, "_ASKarten_VerticalLayout1.padding")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * GAP;
            }, null, "_ASKarten_LangLabel1.width")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.CENTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_Button1.horizontalAlign")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ASKARTEN.CLEARCHACHE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_Button1.label")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_Button1.verticalAlign")
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

        internal function get _dirSizeLabel():String
        {
            return this._226534587_dirSizeLabel;
        }

        internal function set _dirSizeLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._226534587_dirSizeLabel;
            if (loc1 !== arg1) 
            {
                this._226534587_dirSizeLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_dirSizeLabel", loc1, arg1, this);
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
            ASKarten._watcherSetupUtil = arg1;
            return;
        }

        protected override function validateProperties():void
        {
            var loc1:*=helper.File_helper.directorySize(frontend.components.map.MapLayerOptions.BASE_CACHE_DIRECTORY) / 1000000;
            this.updateDirSize(loc1);
            return;
        }

        internal function updateDirSize(arg1:Number):void
        {
            this._dirSizeLabel = (Math.round(arg1 * 100) / 100).toString() + " MB";
            return;
        }

        protected function saveButtonTouchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            helper.File_helper.deleteDirectory(frontend.components.map.MapLayerOptions.BASE_CACHE_DIRECTORY);
            this.updateDirSize(0);
            return;
        }

        internal function _ASKarten_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._ASKarten_MenuList1_i(), this._ASKarten_LayoutGroup1_c()];
            loc1.id = "_ASKarten_CustomVScrollContainer1";
            this._ASKarten_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_CustomVScrollContainer1", this._ASKarten_CustomVScrollContainer1);
            return loc1;
        }

        internal function _ASKarten_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._ASKarten_MenuListItem1_i(), this._ASKarten_MenuListItem2_i()];
            loc1.id = "_ASKarten_MenuList1";
            this._ASKarten_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_MenuList1", this._ASKarten_MenuList1);
            return loc1;
        }

        internal function _ASKarten_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=null;
            loc1 = new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.text = "ASKARTEN.ENABLECHACHING";
            loc1.useConfigCache = true;
            loc1.id = "_ASKarten_MenuListItem1";
            this._ASKarten_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_MenuListItem1", this._ASKarten_MenuListItem1);
            return loc1;
        }

        internal function _ASKarten_MenuListItem2_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = false;
            loc1.text = "ASKARTEN.ACTUAL_CACHE_SIZE";
            loc1.id = "_ASKarten_MenuListItem2";
            this._ASKarten_MenuListItem2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_MenuListItem2", this._ASKarten_MenuListItem2);
            return loc1;
        }

        internal function _ASKarten_LayoutGroup1_c():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ASKarten_VerticalLayout1_i();
            loc1.mxmlContent = [this._ASKarten_LangLabel1_i(), this._ASKarten_Button1_i()];
            return loc1;
        }

        internal function _ASKarten_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "center";
            loc1.verticalAlign = "middle";
            this._ASKarten_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_VerticalLayout1", this._ASKarten_VerticalLayout1);
            return loc1;
        }

        internal function _ASKarten_LangLabel1_i():frontend.components.LangLabel
        {
            var loc1:*=new frontend.components.LangLabel();
            loc1.height = 200;
            loc1.text = "ASKARTEN.DESCRIPTIONTEXT";
            loc1.wordWrap = true;
            loc1.id = "_ASKarten_LangLabel1";
            this._ASKarten_LangLabel1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_LangLabel1", this._ASKarten_LangLabel1);
            return loc1;
        }

        internal static const GAP:Number=20 * SIGMALink.scaleFactor;

        public var _ASKarten_Button1:feathers.controls.Button;

        public var _ASKarten_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _ASKarten_LangLabel1:frontend.components.LangLabel;

        public var _ASKarten_MenuList1:frontend.components.menuList.MenuList;

        public var _ASKarten_MenuListItem1:frontend.components.menuList.MenuListItem;

        public var _ASKarten_MenuListItem2:frontend.components.menuList.MenuListItem;

        public var _ASKarten_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _226534587_dirSizeLabel:String="";

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


