//package tests
//  class TestsView
package frontend.screen.tests 
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
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class TestsView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function TestsView()
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
            bindings = this._TestsView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tests_TestsViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TestsView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.title = "TESTS";
            this.mxmlContent = [this._TestsView_CustomVScrollContainer1_i(), this._TestsView_Footer1_i()];
            this.addEventListener("addedToStage", this.___TestsView_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___TestsView_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___TestsView_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _TestsView_IconButton4_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.includeInLayout = false;
            loc1.visible = false;
            loc1.id = "_TestsView_IconButton4";
            this._TestsView_IconButton4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TestsView_IconButton4", this._TestsView_IconButton4);
            return loc1;
        }

        internal function _TestsView_IconButton5_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_TestsView_IconButton5";
            this._TestsView_IconButton5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TestsView_IconButton5", this._TestsView_IconButton5);
            return loc1;
        }

        public function ___TestsView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.customscreen1_addedToStageHandler(arg1);
            return;
        }

        public function ___TestsView_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.customscreen1_initializeHandler(arg1);
            return;
        }

        public function ___TestsView_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.customscreen1_removedFromStageHandler(arg1);
            return;
        }

        internal function _TestsView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_TestsView_CustomVScrollContainer1.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_TestsView_CustomVScrollContainer1.width")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_TestsView_MenuList1.width")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TestsView_MenuListItem1.type")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.whiteshareicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TestsView_IconButton1.image")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.whiteshareicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TestsView_IconButton2.image")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.whiteshareicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TestsView_IconButton3.image")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.ghostIcon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TestsView_IconButton4.image")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.infoIcon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TestsView_IconButton5.image")
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
            TestsView._watcherSetupUtil = arg1;
            return;
        }

        protected function customscreen1_addedToStageHandler(arg1:starling.events.Event):void
        {
            return;
        }

        protected function customscreen1_initializeHandler(arg1:starling.events.Event):void
        {
            return;
        }

        protected function customscreen1_removedFromStageHandler(arg1:starling.events.Event):void
        {
            return;
        }

        internal function _TestsView_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._TestsView_MenuList1_i()];
            loc1.id = "_TestsView_CustomVScrollContainer1";
            this._TestsView_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TestsView_CustomVScrollContainer1", this._TestsView_CustomVScrollContainer1);
            return loc1;
        }

        internal function _TestsView_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._TestsView_MenuListItem1_i()];
            loc1.id = "_TestsView_MenuList1";
            this._TestsView_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TestsView_MenuList1", this._TestsView_MenuList1);
            return loc1;
        }

        internal function _TestsView_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = false;
            loc1.text = "ACTIVITYVIEW.EDIT_SPEED_FORMAT";
            loc1.title = "ACTIVITYVIEW.EDIT_SPEED_FORMAT";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = false;
            loc1.useLocalesForTitle = false;
            loc1.id = "_TestsView_MenuListItem1";
            this._TestsView_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TestsView_MenuListItem1", this._TestsView_MenuListItem1);
            return loc1;
        }

        internal function _TestsView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._TestsView_IconButton1_i(), this._TestsView_IconButton2_i(), this._TestsView_IconButton3_i(), this._TestsView_IconButton4_i(), this._TestsView_IconButton5_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _TestsView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_TestsView_IconButton1";
            this._TestsView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TestsView_IconButton1", this._TestsView_IconButton1);
            return loc1;
        }

        internal function _TestsView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_TestsView_IconButton2";
            this._TestsView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TestsView_IconButton2", this._TestsView_IconButton2);
            return loc1;
        }

        internal function _TestsView_IconButton3_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_TestsView_IconButton3";
            this._TestsView_IconButton3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TestsView_IconButton3", this._TestsView_IconButton3);
            return loc1;
        }

        public var _TestsView_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _TestsView_IconButton1:frontend.components.button.IconButton;

        public var _TestsView_IconButton2:frontend.components.button.IconButton;

        public var _TestsView_IconButton3:frontend.components.button.IconButton;

        public var _TestsView_IconButton4:frontend.components.button.IconButton;

        public var _TestsView_IconButton5:frontend.components.button.IconButton;

        public var _TestsView_MenuList1:frontend.components.menuList.MenuList;

        public var _TestsView_MenuListItem1:frontend.components.menuList.MenuListItem;

        internal var _1268861541footer:frontend.screen.component.Footer;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


