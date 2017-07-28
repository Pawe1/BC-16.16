//class MenuList
package frontend.components.menuList 
{
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
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class MenuList extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function MenuList()
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
            bindings = this._MenuList_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_menuList_MenuListWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.components.menuList.MenuList[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._MenuList_VerticalLayout1_c();
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get selectMode():Boolean
        {
            return this._selectMode;
        }

        public function set selectMode(arg1:Boolean):void
        {
            var loc1:*=0;
            this._selectMode = arg1;
            if (this.items && this.items.length > 0) 
            {
                loc1 = 0;
                loc1 = 0;
                while (loc1 < this.items.length) 
                {
                    if (this.items[loc1] is frontend.components.menuList.MenuListItem) 
                    {
                        (this.items[loc1] as frontend.components.menuList.MenuListItem).selectMode = this._selectMode;
                    }
                    ++loc1;
                }
            }
            return;
        }

        internal function _MenuList_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            loc1.useVirtualLayout = true;
            return loc1;
        }

        internal function _MenuList_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.components.menuList.MenuList._watcherSetupUtil = arg1;
            return;
        }

        public static function get HEADLINE_HEIGHT():Number
        {
            return frontend.components.menuList.MenuList._359756302HEADLINE_HEIGHT;
        }

        public static function set HEADLINE_HEIGHT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.menuList.MenuList._359756302HEADLINE_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.menuList.MenuList._359756302HEADLINE_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "HEADLINE_HEIGHT", loc1, arg1, frontend.components.menuList.MenuList);
                loc3 = frontend.components.menuList.MenuList.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get ROW_HEIGHT():Number
        {
            return frontend.components.menuList.MenuList._1852194636ROW_HEIGHT;
        }

        public static function set ROW_HEIGHT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.menuList.MenuList._1852194636ROW_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.menuList.MenuList._1852194636ROW_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_HEIGHT", loc1, arg1, frontend.components.menuList.MenuList);
                loc3 = frontend.components.menuList.MenuList.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get ROW_HEIGHT_SMALL():Number
        {
            return frontend.components.menuList.MenuList._1918462412ROW_HEIGHT_SMALL;
        }

        public static function set ROW_HEIGHT_SMALL(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.menuList.MenuList._1918462412ROW_HEIGHT_SMALL;
            if (loc1 !== arg1) 
            {
                frontend.components.menuList.MenuList._1918462412ROW_HEIGHT_SMALL = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_HEIGHT_SMALL", loc1, arg1, frontend.components.menuList.MenuList);
                loc3 = frontend.components.menuList.MenuList.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get SMALLER_ROW_HEIGHT():Number
        {
            return frontend.components.menuList.MenuList._1860509847SMALLER_ROW_HEIGHT;
        }

        public static function set SMALLER_ROW_HEIGHT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.menuList.MenuList._1860509847SMALLER_ROW_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.menuList.MenuList._1860509847SMALLER_ROW_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "SMALLER_ROW_HEIGHT", loc1, arg1, frontend.components.menuList.MenuList);
                loc3 = frontend.components.menuList.MenuList.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _359756302HEADLINE_HEIGHT = 64 * SIGMALink.scaleFactor;
            _1852194636ROW_HEIGHT = 128 * SIGMALink.scaleFactor;
            _1918462412ROW_HEIGHT_SMALL = 64 * SIGMALink.scaleFactor;
            _1860509847SMALLER_ROW_HEIGHT = 100 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal var _selectMode:Boolean=false;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _359756302HEADLINE_HEIGHT:Number;

        internal static var _1852194636ROW_HEIGHT:Number;

        internal static var _1918462412ROW_HEIGHT_SMALL:Number;

        internal static var _1860509847SMALLER_ROW_HEIGHT:Number;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


