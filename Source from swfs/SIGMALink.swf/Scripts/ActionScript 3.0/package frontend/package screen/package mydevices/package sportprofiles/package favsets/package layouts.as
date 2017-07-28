//package layouts
//  class FavSetLayout1
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout1 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout1()
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
            bindings = this._FavSetLayout1_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout1WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout1[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 1;
            this.mxmlContent = [this._FavSetLayout1_FavsetBox1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout1_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.position = 1;
            loc1.id = "_FavSetLayout1_FavsetBox1";
            this._FavSetLayout1_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout1_FavsetBox1", this._FavSetLayout1_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout1_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout1_FavsetBox1.boxFormat")
            result[2] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TRACK_VIEW;
            }, null, "_FavSetLayout1_FavsetBox1.defaultFunction")
            result[3] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout1_FavsetBox1.defaultFunctions")
            result[4] = new feathers.binding.Binding(this, null, null, "_FavSetLayout1_FavsetBox1.editable", "editable");
            result[5] = new feathers.binding.Binding(this, null, null, "_FavSetLayout1_FavsetBox1.favFunctionList", "favFunctionList");
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout1_FavsetBox1.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout1._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=1;

        public var _FavSetLayout1_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout11
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout11 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout11()
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
            bindings = this._FavSetLayout11_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout11WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout11[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 4;
            this.mxmlContent = [this._FavSetLayout11_FavsetBox1_i(), this._FavSetLayout11_LayoutGroup1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout11_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 33;
            loc1.position = 1;
            loc1.id = "_FavSetLayout11_FavsetBox1";
            this._FavSetLayout11_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout11_FavsetBox1", this._FavSetLayout11_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout11_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout11_LayoutGroup2_i(), this._FavSetLayout11_FavsetBox4_i()];
            loc1.id = "_FavSetLayout11_LayoutGroup1";
            this._FavSetLayout11_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout11_LayoutGroup1", this._FavSetLayout11_LayoutGroup1);
            return loc1;
        }

        internal function _FavSetLayout11_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout11_FavsetBox2_i(), this._FavSetLayout11_FavsetBox3_i()];
            loc1.id = "_FavSetLayout11_LayoutGroup2";
            this._FavSetLayout11_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout11_LayoutGroup2", this._FavSetLayout11_LayoutGroup2);
            return loc1;
        }

        internal function _FavSetLayout11_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 50;
            loc1.position = 2;
            loc1.id = "_FavSetLayout11_FavsetBox2";
            this._FavSetLayout11_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout11_FavsetBox2", this._FavSetLayout11_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout11_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 50;
            loc1.position = 3;
            loc1.id = "_FavSetLayout11_FavsetBox3";
            this._FavSetLayout11_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout11_FavsetBox3", this._FavSetLayout11_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout11_FavsetBox4_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 100;
            loc1.position = 4;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout11_FavsetBox4";
            this._FavSetLayout11_FavsetBox4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout11_FavsetBox4", this._FavSetLayout11_FavsetBox4);
            return loc1;
        }

        internal function _FavSetLayout11_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout11_FavsetBox1.boxFormat")
            result[2] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_CURRENT_SPEED;
            }, null, "_FavSetLayout11_FavsetBox1.defaultFunction")
            result[3] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout11_FavsetBox1.defaultFunctions")
            result[4] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox1.editable", "editable");
            result[5] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox1.favFunctionList", "favFunctionList");
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox1.showLabel", "showLabel");
            result[7] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout11_LayoutGroup1.layout")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 67);
            }, null, "_FavSetLayout11_LayoutGroup1.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return vLayout;
            }, null, "_FavSetLayout11_LayoutGroup2.layout")
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.HorizontalLayoutData(100, 100);
            }, null, "_FavSetLayout11_LayoutGroup2.layoutData")
            result[11] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout11_FavsetBox2.boxFormat")
            result[12] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_TRIP_DISTANCE;
            }, null, "_FavSetLayout11_FavsetBox2.defaultFunction")
            result[13] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout11_FavsetBox2.defaultFunctions")
            result[14] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox2.editable", "editable");
            result[15] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox2.favFunctionList", "favFunctionList");
            result[16] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox2.showLabel", "showLabel");
            result[17] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout11_FavsetBox3.boxFormat")
            result[18] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_CLOCK;
            }, null, "_FavSetLayout11_FavsetBox3.defaultFunction")
            result[19] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout11_FavsetBox3.defaultFunctions")
            result[20] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox3.editable", "editable");
            result[21] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox3.favFunctionList", "favFunctionList");
            result[22] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox3.showLabel", "showLabel");
            result[23] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout11_FavsetBox4.boxFormat")
            result[24] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TRACK_VIEW;
            }, null, "_FavSetLayout11_FavsetBox4.defaultFunction")
            result[25] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout11_FavsetBox4.defaultFunctions")
            result[26] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox4.editable", "editable");
            result[27] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox4.favFunctionList", "favFunctionList");
            result[28] = new feathers.binding.Binding(this, null, null, "_FavSetLayout11_FavsetBox4.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout11._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=11;

        public var _FavSetLayout11_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout11_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout11_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout11_FavsetBox4:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout11_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _FavSetLayout11_LayoutGroup2:feathers.controls.LayoutGroup;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout12
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout12 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout12()
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
            bindings = this._FavSetLayout12_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout12WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout12[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 4;
            this.mxmlContent = [this._FavSetLayout12_LayoutGroup1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout12_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout12_LayoutGroup2_i(), this._FavSetLayout12_FavsetBox4_i()];
            loc1.id = "_FavSetLayout12_LayoutGroup1";
            this._FavSetLayout12_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout12_LayoutGroup1", this._FavSetLayout12_LayoutGroup1);
            return loc1;
        }

        internal function _FavSetLayout12_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout12_FavsetBox1_i(), this._FavSetLayout12_FavsetBox2_i(), this._FavSetLayout12_FavsetBox3_i()];
            loc1.id = "_FavSetLayout12_LayoutGroup2";
            this._FavSetLayout12_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout12_LayoutGroup2", this._FavSetLayout12_LayoutGroup2);
            return loc1;
        }

        internal function _FavSetLayout12_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 34;
            loc1.position = 1;
            loc1.id = "_FavSetLayout12_FavsetBox1";
            this._FavSetLayout12_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout12_FavsetBox1", this._FavSetLayout12_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout12_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 33;
            loc1.position = 2;
            loc1.id = "_FavSetLayout12_FavsetBox2";
            this._FavSetLayout12_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout12_FavsetBox2", this._FavSetLayout12_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout12_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 33;
            loc1.position = 3;
            loc1.id = "_FavSetLayout12_FavsetBox3";
            this._FavSetLayout12_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout12_FavsetBox3", this._FavSetLayout12_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout12_FavsetBox4_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 4;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout12_FavsetBox4";
            this._FavSetLayout12_FavsetBox4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout12_FavsetBox4", this._FavSetLayout12_FavsetBox4);
            return loc1;
        }

        internal function _FavSetLayout12_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout12_LayoutGroup1.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 100);
            }, null, "_FavSetLayout12_LayoutGroup1.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return vLayout;
            }, null, "_FavSetLayout12_LayoutGroup2.layout")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.HorizontalLayoutData(50, 100);
            }, null, "_FavSetLayout12_LayoutGroup2.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout12_FavsetBox1.boxFormat")
            result[6] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_CURRENT_SPEED;
            }, null, "_FavSetLayout12_FavsetBox1.defaultFunction")
            result[7] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout12_FavsetBox1.defaultFunctions")
            result[8] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox1.editable", "editable");
            result[9] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox1.favFunctionList", "favFunctionList");
            result[10] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox1.showLabel", "showLabel");
            result[11] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout12_FavsetBox2.boxFormat")
            result[12] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_TRIP_DISTANCE;
            }, null, "_FavSetLayout12_FavsetBox2.defaultFunction")
            result[13] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout12_FavsetBox2.defaultFunctions")
            result[14] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox2.editable", "editable");
            result[15] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox2.favFunctionList", "favFunctionList");
            result[16] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox2.showLabel", "showLabel");
            result[17] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout12_FavsetBox3.boxFormat")
            result[18] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_CLOCK;
            }, null, "_FavSetLayout12_FavsetBox3.defaultFunction")
            result[19] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout12_FavsetBox3.defaultFunctions")
            result[20] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox3.editable", "editable");
            result[21] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox3.favFunctionList", "favFunctionList");
            result[22] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox3.showLabel", "showLabel");
            result[23] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout12_FavsetBox4.boxFormat")
            result[24] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TRACK_VIEW;
            }, null, "_FavSetLayout12_FavsetBox4.defaultFunction")
            result[25] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout12_FavsetBox4.defaultFunctions")
            result[26] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox4.editable", "editable");
            result[27] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox4.favFunctionList", "favFunctionList");
            result[28] = new feathers.binding.Binding(this, null, null, "_FavSetLayout12_FavsetBox4.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout12._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=12;

        public var _FavSetLayout12_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout12_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout12_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout12_FavsetBox4:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout12_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _FavSetLayout12_LayoutGroup2:feathers.controls.LayoutGroup;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout13
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout13 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout13()
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
            bindings = this._FavSetLayout13_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout13WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout13[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 5;
            this.mxmlContent = [this._FavSetLayout13_FavsetBox1_i(), this._FavSetLayout13_LayoutGroup1_i(), this._FavSetLayout13_LayoutGroup2_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout13_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 34;
            loc1.position = 1;
            loc1.id = "_FavSetLayout13_FavsetBox1";
            this._FavSetLayout13_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout13_FavsetBox1", this._FavSetLayout13_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout13_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout13_FavsetBox2_i(), this._FavSetLayout13_FavsetBox3_i()];
            loc1.id = "_FavSetLayout13_LayoutGroup1";
            this._FavSetLayout13_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout13_LayoutGroup1", this._FavSetLayout13_LayoutGroup1);
            return loc1;
        }

        internal function _FavSetLayout13_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 2;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout13_FavsetBox2";
            this._FavSetLayout13_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout13_FavsetBox2", this._FavSetLayout13_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout13_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 3;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout13_FavsetBox3";
            this._FavSetLayout13_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout13_FavsetBox3", this._FavSetLayout13_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout13_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout13_FavsetBox4_i(), this._FavSetLayout13_FavsetBox5_i()];
            loc1.id = "_FavSetLayout13_LayoutGroup2";
            this._FavSetLayout13_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout13_LayoutGroup2", this._FavSetLayout13_LayoutGroup2);
            return loc1;
        }

        internal function _FavSetLayout13_FavsetBox4_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 4;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout13_FavsetBox4";
            this._FavSetLayout13_FavsetBox4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout13_FavsetBox4", this._FavSetLayout13_FavsetBox4);
            return loc1;
        }

        internal function _FavSetLayout13_FavsetBox5_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 5;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout13_FavsetBox5";
            this._FavSetLayout13_FavsetBox5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout13_FavsetBox5", this._FavSetLayout13_FavsetBox5);
            return loc1;
        }

        internal function _FavSetLayout13_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout13_FavsetBox1.boxFormat")
            result[2] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_CURRENT_SPEED;
            }, null, "_FavSetLayout13_FavsetBox1.defaultFunction")
            result[3] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout13_FavsetBox1.defaultFunctions")
            result[4] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox1.editable", "editable");
            result[5] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox1.favFunctionList", "favFunctionList");
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox1.showLabel", "showLabel");
            result[7] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout13_LayoutGroup1.layout")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout13_LayoutGroup1.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout13_FavsetBox2.boxFormat")
            result[10] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_CLOCK;
            }, null, "_FavSetLayout13_FavsetBox2.defaultFunction")
            result[11] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout13_FavsetBox2.defaultFunctions")
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox2.editable", "editable");
            result[13] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox2.favFunctionList", "favFunctionList");
            result[14] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox2.showLabel", "showLabel");
            result[15] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout13_FavsetBox3.boxFormat")
            result[16] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_TRIP_DISTANCE;
            }, null, "_FavSetLayout13_FavsetBox3.defaultFunction")
            result[17] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout13_FavsetBox3.defaultFunctions")
            result[18] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox3.editable", "editable");
            result[19] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox3.favFunctionList", "favFunctionList");
            result[20] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox3.showLabel", "showLabel");
            result[21] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout13_LayoutGroup2.layout")
            result[22] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout13_LayoutGroup2.layoutData")
            result[23] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout13_FavsetBox4.boxFormat")
            result[24] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_ALTITUDE_ASCENT;
            }, null, "_FavSetLayout13_FavsetBox4.defaultFunction")
            result[25] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout13_FavsetBox4.defaultFunctions")
            result[26] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox4.editable", "editable");
            result[27] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox4.favFunctionList", "favFunctionList");
            result[28] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox4.showLabel", "showLabel");
            result[29] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout13_FavsetBox5.boxFormat")
            result[30] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_EXCERCISE_TIME;
            }, null, "_FavSetLayout13_FavsetBox5.defaultFunction")
            result[31] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout13_FavsetBox5.defaultFunctions")
            result[32] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox5.editable", "editable");
            result[33] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox5.favFunctionList", "favFunctionList");
            result[34] = new feathers.binding.Binding(this, null, null, "_FavSetLayout13_FavsetBox5.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout13._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=13;

        public var _FavSetLayout13_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout13_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout13_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout13_FavsetBox4:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout13_FavsetBox5:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout13_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _FavSetLayout13_LayoutGroup2:feathers.controls.LayoutGroup;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout14
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout14 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout14()
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
            bindings = this._FavSetLayout14_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout14WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout14[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 5;
            this.mxmlContent = [this._FavSetLayout14_LayoutGroup1_i(), this._FavSetLayout14_FavsetBox3_i(), this._FavSetLayout14_LayoutGroup2_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout14_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout14_FavsetBox1_i(), this._FavSetLayout14_FavsetBox2_i()];
            loc1.id = "_FavSetLayout14_LayoutGroup1";
            this._FavSetLayout14_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout14_LayoutGroup1", this._FavSetLayout14_LayoutGroup1);
            return loc1;
        }

        internal function _FavSetLayout14_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 1;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout14_FavsetBox1";
            this._FavSetLayout14_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout14_FavsetBox1", this._FavSetLayout14_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout14_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 2;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout14_FavsetBox2";
            this._FavSetLayout14_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout14_FavsetBox2", this._FavSetLayout14_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout14_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 34;
            loc1.position = 3;
            loc1.id = "_FavSetLayout14_FavsetBox3";
            this._FavSetLayout14_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout14_FavsetBox3", this._FavSetLayout14_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout14_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout14_FavsetBox4_i(), this._FavSetLayout14_FavsetBox5_i()];
            loc1.id = "_FavSetLayout14_LayoutGroup2";
            this._FavSetLayout14_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout14_LayoutGroup2", this._FavSetLayout14_LayoutGroup2);
            return loc1;
        }

        internal function _FavSetLayout14_FavsetBox4_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 4;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout14_FavsetBox4";
            this._FavSetLayout14_FavsetBox4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout14_FavsetBox4", this._FavSetLayout14_FavsetBox4);
            return loc1;
        }

        internal function _FavSetLayout14_FavsetBox5_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 5;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout14_FavsetBox5";
            this._FavSetLayout14_FavsetBox5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout14_FavsetBox5", this._FavSetLayout14_FavsetBox5);
            return loc1;
        }

        internal function _FavSetLayout14_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout14_LayoutGroup1.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout14_LayoutGroup1.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout14_FavsetBox1.boxFormat")
            result[4] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_CLOCK;
            }, null, "_FavSetLayout14_FavsetBox1.defaultFunction")
            result[5] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout14_FavsetBox1.defaultFunctions")
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox1.editable", "editable");
            result[7] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox1.favFunctionList", "favFunctionList");
            result[8] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox1.showLabel", "showLabel");
            result[9] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout14_FavsetBox2.boxFormat")
            result[10] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_TRIP_DISTANCE;
            }, null, "_FavSetLayout14_FavsetBox2.defaultFunction")
            result[11] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout14_FavsetBox2.defaultFunctions")
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox2.editable", "editable");
            result[13] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox2.favFunctionList", "favFunctionList");
            result[14] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox2.showLabel", "showLabel");
            result[15] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout14_FavsetBox3.boxFormat")
            result[16] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_CURRENT_SPEED;
            }, null, "_FavSetLayout14_FavsetBox3.defaultFunction")
            result[17] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout14_FavsetBox3.defaultFunctions")
            result[18] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox3.editable", "editable");
            result[19] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox3.favFunctionList", "favFunctionList");
            result[20] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox3.showLabel", "showLabel");
            result[21] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout14_LayoutGroup2.layout")
            result[22] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout14_LayoutGroup2.layoutData")
            result[23] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout14_FavsetBox4.boxFormat")
            result[24] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_ALTITUDE_ASCENT;
            }, null, "_FavSetLayout14_FavsetBox4.defaultFunction")
            result[25] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout14_FavsetBox4.defaultFunctions")
            result[26] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox4.editable", "editable");
            result[27] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox4.favFunctionList", "favFunctionList");
            result[28] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox4.showLabel", "showLabel");
            result[29] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout14_FavsetBox5.boxFormat")
            result[30] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_EXCERCISE_TIME;
            }, null, "_FavSetLayout14_FavsetBox5.defaultFunction")
            result[31] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout14_FavsetBox5.defaultFunctions")
            result[32] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox5.editable", "editable");
            result[33] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox5.favFunctionList", "favFunctionList");
            result[34] = new feathers.binding.Binding(this, null, null, "_FavSetLayout14_FavsetBox5.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout14._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=14;

        public var _FavSetLayout14_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout14_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout14_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout14_FavsetBox4:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout14_FavsetBox5:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout14_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _FavSetLayout14_LayoutGroup2:feathers.controls.LayoutGroup;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout15
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout15 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout15()
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
            bindings = this._FavSetLayout15_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout15WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout15[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 5;
            this.mxmlContent = [this._FavSetLayout15_LayoutGroup1_i(), this._FavSetLayout15_LayoutGroup2_i(), this._FavSetLayout15_FavsetBox5_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout15_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout15_FavsetBox1_i(), this._FavSetLayout15_FavsetBox2_i()];
            loc1.id = "_FavSetLayout15_LayoutGroup1";
            this._FavSetLayout15_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout15_LayoutGroup1", this._FavSetLayout15_LayoutGroup1);
            return loc1;
        }

        internal function _FavSetLayout15_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 1;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout15_FavsetBox1";
            this._FavSetLayout15_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout15_FavsetBox1", this._FavSetLayout15_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout15_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 2;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout15_FavsetBox2";
            this._FavSetLayout15_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout15_FavsetBox2", this._FavSetLayout15_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout15_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout15_FavsetBox3_i(), this._FavSetLayout15_FavsetBox4_i()];
            loc1.id = "_FavSetLayout15_LayoutGroup2";
            this._FavSetLayout15_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout15_LayoutGroup2", this._FavSetLayout15_LayoutGroup2);
            return loc1;
        }

        internal function _FavSetLayout15_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 3;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout15_FavsetBox3";
            this._FavSetLayout15_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout15_FavsetBox3", this._FavSetLayout15_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout15_FavsetBox4_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 4;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout15_FavsetBox4";
            this._FavSetLayout15_FavsetBox4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout15_FavsetBox4", this._FavSetLayout15_FavsetBox4);
            return loc1;
        }

        internal function _FavSetLayout15_FavsetBox5_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 34;
            loc1.position = 5;
            loc1.id = "_FavSetLayout15_FavsetBox5";
            this._FavSetLayout15_FavsetBox5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout15_FavsetBox5", this._FavSetLayout15_FavsetBox5);
            return loc1;
        }

        internal function _FavSetLayout15_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout15_LayoutGroup1.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout15_LayoutGroup1.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout15_FavsetBox1.boxFormat")
            result[4] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_CLOCK;
            }, null, "_FavSetLayout15_FavsetBox1.defaultFunction")
            result[5] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout15_FavsetBox1.defaultFunctions")
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox1.editable", "editable");
            result[7] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox1.favFunctionList", "favFunctionList");
            result[8] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox1.showLabel", "showLabel");
            result[9] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout15_FavsetBox2.boxFormat")
            result[10] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_TRIP_DISTANCE;
            }, null, "_FavSetLayout15_FavsetBox2.defaultFunction")
            result[11] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout15_FavsetBox2.defaultFunctions")
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox2.editable", "editable");
            result[13] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox2.favFunctionList", "favFunctionList");
            result[14] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox2.showLabel", "showLabel");
            result[15] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout15_LayoutGroup2.layout")
            result[16] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout15_LayoutGroup2.layoutData")
            result[17] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout15_FavsetBox3.boxFormat")
            result[18] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_CURRENT_SPEED;
            }, null, "_FavSetLayout15_FavsetBox3.defaultFunction")
            result[19] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout15_FavsetBox3.defaultFunctions")
            result[20] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox3.editable", "editable");
            result[21] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox3.favFunctionList", "favFunctionList");
            result[22] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox3.showLabel", "showLabel");
            result[23] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout15_FavsetBox4.boxFormat")
            result[24] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_ALTITUDE_ASCENT;
            }, null, "_FavSetLayout15_FavsetBox4.defaultFunction")
            result[25] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout15_FavsetBox4.defaultFunctions")
            result[26] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox4.editable", "editable");
            result[27] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox4.favFunctionList", "favFunctionList");
            result[28] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox4.showLabel", "showLabel");
            result[29] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout15_FavsetBox5.boxFormat")
            result[30] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_EXCERCISE_TIME;
            }, null, "_FavSetLayout15_FavsetBox5.defaultFunction")
            result[31] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout15_FavsetBox5.defaultFunctions")
            result[32] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox5.editable", "editable");
            result[33] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox5.favFunctionList", "favFunctionList");
            result[34] = new feathers.binding.Binding(this, null, null, "_FavSetLayout15_FavsetBox5.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout15._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=15;

        public var _FavSetLayout15_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout15_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout15_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout15_FavsetBox4:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout15_FavsetBox5:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout15_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _FavSetLayout15_LayoutGroup2:feathers.controls.LayoutGroup;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout16
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout16 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout16()
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
            bindings = this._FavSetLayout16_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout16WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout16[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 5;
            this.mxmlContent = [this._FavSetLayout16_LayoutGroup1_i(), this._FavSetLayout16_LayoutGroup2_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout16_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout16_FavsetBox1_i(), this._FavSetLayout16_FavsetBox2_i()];
            loc1.id = "_FavSetLayout16_LayoutGroup1";
            this._FavSetLayout16_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout16_LayoutGroup1", this._FavSetLayout16_LayoutGroup1);
            return loc1;
        }

        internal function _FavSetLayout16_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 1;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout16_FavsetBox1";
            this._FavSetLayout16_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout16_FavsetBox1", this._FavSetLayout16_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout16_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 2;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout16_FavsetBox2";
            this._FavSetLayout16_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout16_FavsetBox2", this._FavSetLayout16_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout16_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout16_LayoutGroup3_i(), this._FavSetLayout16_FavsetBox5_i()];
            loc1.id = "_FavSetLayout16_LayoutGroup2";
            this._FavSetLayout16_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout16_LayoutGroup2", this._FavSetLayout16_LayoutGroup2);
            return loc1;
        }

        internal function _FavSetLayout16_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout16_FavsetBox3_i(), this._FavSetLayout16_FavsetBox4_i()];
            loc1.id = "_FavSetLayout16_LayoutGroup3";
            this._FavSetLayout16_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout16_LayoutGroup3", this._FavSetLayout16_LayoutGroup3);
            return loc1;
        }

        internal function _FavSetLayout16_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 50;
            loc1.position = 3;
            loc1.id = "_FavSetLayout16_FavsetBox3";
            this._FavSetLayout16_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout16_FavsetBox3", this._FavSetLayout16_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout16_FavsetBox4_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 50;
            loc1.position = 4;
            loc1.id = "_FavSetLayout16_FavsetBox4";
            this._FavSetLayout16_FavsetBox4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout16_FavsetBox4", this._FavSetLayout16_FavsetBox4);
            return loc1;
        }

        internal function _FavSetLayout16_FavsetBox5_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 5;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout16_FavsetBox5";
            this._FavSetLayout16_FavsetBox5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout16_FavsetBox5", this._FavSetLayout16_FavsetBox5);
            return loc1;
        }

        internal function _FavSetLayout16_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout16_LayoutGroup1.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout16_LayoutGroup1.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout16_FavsetBox1.boxFormat")
            result[4] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_CLOCK;
            }, null, "_FavSetLayout16_FavsetBox1.defaultFunction")
            result[5] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout16_FavsetBox1.defaultFunctions")
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox1.editable", "editable");
            result[7] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox1.favFunctionList", "favFunctionList");
            result[8] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox1.showLabel", "showLabel");
            result[9] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout16_FavsetBox2.boxFormat")
            result[10] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_TRIP_DISTANCE;
            }, null, "_FavSetLayout16_FavsetBox2.defaultFunction")
            result[11] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout16_FavsetBox2.defaultFunctions")
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox2.editable", "editable");
            result[13] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox2.favFunctionList", "favFunctionList");
            result[14] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox2.showLabel", "showLabel");
            result[15] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout16_LayoutGroup2.layout")
            result[16] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 67);
            }, null, "_FavSetLayout16_LayoutGroup2.layoutData")
            result[17] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return vLayout;
            }, null, "_FavSetLayout16_LayoutGroup3.layout")
            result[18] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.HorizontalLayoutData(50, 100);
            }, null, "_FavSetLayout16_LayoutGroup3.layoutData")
            result[19] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout16_FavsetBox3.boxFormat")
            result[20] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_CURRENT_SPEED;
            }, null, "_FavSetLayout16_FavsetBox3.defaultFunction")
            result[21] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout16_FavsetBox3.defaultFunctions")
            result[22] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox3.editable", "editable");
            result[23] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox3.favFunctionList", "favFunctionList");
            result[24] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox3.showLabel", "showLabel");
            result[25] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout16_FavsetBox4.boxFormat")
            result[26] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_ALTITUDE_ASCENT;
            }, null, "_FavSetLayout16_FavsetBox4.defaultFunction")
            result[27] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout16_FavsetBox4.defaultFunctions")
            result[28] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox4.editable", "editable");
            result[29] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox4.favFunctionList", "favFunctionList");
            result[30] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox4.showLabel", "showLabel");
            result[31] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout16_FavsetBox5.boxFormat")
            result[32] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_EXCERCISE_TIME;
            }, null, "_FavSetLayout16_FavsetBox5.defaultFunction")
            result[33] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout16_FavsetBox5.defaultFunctions")
            result[34] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox5.editable", "editable");
            result[35] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox5.favFunctionList", "favFunctionList");
            result[36] = new feathers.binding.Binding(this, null, null, "_FavSetLayout16_FavsetBox5.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout16._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=16;

        public var _FavSetLayout16_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout16_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout16_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout16_FavsetBox4:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout16_FavsetBox5:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout16_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _FavSetLayout16_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _FavSetLayout16_LayoutGroup3:feathers.controls.LayoutGroup;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout17
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout17 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout17()
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
            bindings = this._FavSetLayout17_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout17WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout17[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 6;
            this.mxmlContent = [this._FavSetLayout17_LayoutGroup1_i(), this._FavSetLayout17_LayoutGroup2_i(), this._FavSetLayout17_LayoutGroup3_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout17_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout17_FavsetBox1_i(), this._FavSetLayout17_FavsetBox2_i()];
            loc1.id = "_FavSetLayout17_LayoutGroup1";
            this._FavSetLayout17_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout17_LayoutGroup1", this._FavSetLayout17_LayoutGroup1);
            return loc1;
        }

        internal function _FavSetLayout17_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 1;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout17_FavsetBox1";
            this._FavSetLayout17_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout17_FavsetBox1", this._FavSetLayout17_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout17_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 2;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout17_FavsetBox2";
            this._FavSetLayout17_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout17_FavsetBox2", this._FavSetLayout17_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout17_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout17_FavsetBox3_i(), this._FavSetLayout17_FavsetBox4_i()];
            loc1.id = "_FavSetLayout17_LayoutGroup2";
            this._FavSetLayout17_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout17_LayoutGroup2", this._FavSetLayout17_LayoutGroup2);
            return loc1;
        }

        internal function _FavSetLayout17_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 3;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout17_FavsetBox3";
            this._FavSetLayout17_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout17_FavsetBox3", this._FavSetLayout17_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout17_FavsetBox4_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 4;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout17_FavsetBox4";
            this._FavSetLayout17_FavsetBox4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout17_FavsetBox4", this._FavSetLayout17_FavsetBox4);
            return loc1;
        }

        internal function _FavSetLayout17_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout17_FavsetBox5_i(), this._FavSetLayout17_FavsetBox6_i()];
            loc1.id = "_FavSetLayout17_LayoutGroup3";
            this._FavSetLayout17_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout17_LayoutGroup3", this._FavSetLayout17_LayoutGroup3);
            return loc1;
        }

        internal function _FavSetLayout17_FavsetBox5_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 5;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout17_FavsetBox5";
            this._FavSetLayout17_FavsetBox5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout17_FavsetBox5", this._FavSetLayout17_FavsetBox5);
            return loc1;
        }

        internal function _FavSetLayout17_FavsetBox6_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 6;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout17_FavsetBox6";
            this._FavSetLayout17_FavsetBox6 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout17_FavsetBox6", this._FavSetLayout17_FavsetBox6);
            return loc1;
        }

        internal function _FavSetLayout17_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout17_LayoutGroup1.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout17_LayoutGroup1.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout17_FavsetBox1.boxFormat")
            result[4] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_CLOCK;
            }, null, "_FavSetLayout17_FavsetBox1.defaultFunction")
            result[5] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout17_FavsetBox1.defaultFunctions")
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox1.editable", "editable");
            result[7] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox1.favFunctionList", "favFunctionList");
            result[8] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox1.showLabel", "showLabel");
            result[9] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout17_FavsetBox2.boxFormat")
            result[10] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_TRIP_DISTANCE;
            }, null, "_FavSetLayout17_FavsetBox2.defaultFunction")
            result[11] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout17_FavsetBox2.defaultFunctions")
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox2.editable", "editable");
            result[13] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox2.favFunctionList", "favFunctionList");
            result[14] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox2.showLabel", "showLabel");
            result[15] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout17_LayoutGroup2.layout")
            result[16] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout17_LayoutGroup2.layoutData")
            result[17] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout17_FavsetBox3.boxFormat")
            result[18] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_CURRENT_SPEED;
            }, null, "_FavSetLayout17_FavsetBox3.defaultFunction")
            result[19] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout17_FavsetBox3.defaultFunctions")
            result[20] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox3.editable", "editable");
            result[21] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox3.favFunctionList", "favFunctionList");
            result[22] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox3.showLabel", "showLabel");
            result[23] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout17_FavsetBox4.boxFormat")
            result[24] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_ALTITUDE_ASCENT;
            }, null, "_FavSetLayout17_FavsetBox4.defaultFunction")
            result[25] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout17_FavsetBox4.defaultFunctions")
            result[26] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox4.editable", "editable");
            result[27] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox4.favFunctionList", "favFunctionList");
            result[28] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox4.showLabel", "showLabel");
            result[29] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout17_LayoutGroup3.layout")
            result[30] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 34);
            }, null, "_FavSetLayout17_LayoutGroup3.layoutData")
            result[31] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout17_FavsetBox5.boxFormat")
            result[32] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_EXCERCISE_TIME;
            }, null, "_FavSetLayout17_FavsetBox5.defaultFunction")
            result[33] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout17_FavsetBox5.defaultFunctions")
            result[34] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox5.editable", "editable");
            result[35] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox5.favFunctionList", "favFunctionList");
            result[36] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox5.showLabel", "showLabel");
            result[37] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout17_FavsetBox6.boxFormat")
            result[38] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_CALORIES_CALORIES;
            }, null, "_FavSetLayout17_FavsetBox6.defaultFunction")
            result[39] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout17_FavsetBox6.defaultFunctions")
            result[40] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox6.editable", "editable");
            result[41] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox6.favFunctionList", "favFunctionList");
            result[42] = new feathers.binding.Binding(this, null, null, "_FavSetLayout17_FavsetBox6.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout17._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=17;

        public var _FavSetLayout17_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout17_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout17_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout17_FavsetBox4:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout17_FavsetBox5:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout17_FavsetBox6:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout17_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _FavSetLayout17_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _FavSetLayout17_LayoutGroup3:feathers.controls.LayoutGroup;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout2
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout2 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout2()
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
            bindings = this._FavSetLayout2_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout2WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout2[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 2;
            this.mxmlContent = [this._FavSetLayout2_FavsetBox1_i(), this._FavSetLayout2_FavsetBox2_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout2_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 25;
            loc1.position = 1;
            loc1.id = "_FavSetLayout2_FavsetBox1";
            this._FavSetLayout2_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout2_FavsetBox1", this._FavSetLayout2_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout2_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 75;
            loc1.position = 2;
            loc1.id = "_FavSetLayout2_FavsetBox2";
            this._FavSetLayout2_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout2_FavsetBox2", this._FavSetLayout2_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout2_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout2_FavsetBox1.boxFormat")
            result[2] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TRACK_VIEW;
            }, null, "_FavSetLayout2_FavsetBox1.defaultFunction")
            result[3] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout2_FavsetBox1.defaultFunctions")
            result[4] = new feathers.binding.Binding(this, null, null, "_FavSetLayout2_FavsetBox1.editable", "editable");
            result[5] = new feathers.binding.Binding(this, null, null, "_FavSetLayout2_FavsetBox1.favFunctionList", "favFunctionList");
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout2_FavsetBox1.showLabel", "showLabel");
            result[7] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout2_FavsetBox2.boxFormat")
            result[8] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TIME_OF_ARRIVAL;
            }, null, "_FavSetLayout2_FavsetBox2.defaultFunction")
            result[9] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout2_FavsetBox2.defaultFunctions")
            result[10] = new feathers.binding.Binding(this, null, null, "_FavSetLayout2_FavsetBox2.editable", "editable");
            result[11] = new feathers.binding.Binding(this, null, null, "_FavSetLayout2_FavsetBox2.favFunctionList", "favFunctionList");
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout2_FavsetBox2.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout2._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=2;

        public var _FavSetLayout2_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout2_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout3
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout3 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout3()
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
            bindings = this._FavSetLayout3_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout3WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout3[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 2;
            this.mxmlContent = [this._FavSetLayout3_FavsetBox1_i(), this._FavSetLayout3_FavsetBox2_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout3_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 75;
            loc1.position = 1;
            loc1.id = "_FavSetLayout3_FavsetBox1";
            this._FavSetLayout3_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout3_FavsetBox1", this._FavSetLayout3_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout3_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 25;
            loc1.position = 2;
            loc1.id = "_FavSetLayout3_FavsetBox2";
            this._FavSetLayout3_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout3_FavsetBox2", this._FavSetLayout3_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout3_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout3_FavsetBox1.boxFormat")
            result[2] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TRACK_VIEW;
            }, null, "_FavSetLayout3_FavsetBox1.defaultFunction")
            result[3] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout3_FavsetBox1.defaultFunctions")
            result[4] = new feathers.binding.Binding(this, null, null, "_FavSetLayout3_FavsetBox1.editable", "editable");
            result[5] = new feathers.binding.Binding(this, null, null, "_FavSetLayout3_FavsetBox1.favFunctionList", "favFunctionList");
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout3_FavsetBox1.showLabel", "showLabel");
            result[7] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout3_FavsetBox2.boxFormat")
            result[8] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TIME_OF_ARRIVAL;
            }, null, "_FavSetLayout3_FavsetBox2.defaultFunction")
            result[9] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout3_FavsetBox2.defaultFunctions")
            result[10] = new feathers.binding.Binding(this, null, null, "_FavSetLayout3_FavsetBox2.editable", "editable");
            result[11] = new feathers.binding.Binding(this, null, null, "_FavSetLayout3_FavsetBox2.favFunctionList", "favFunctionList");
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout3_FavsetBox2.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout3._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=3;

        public var _FavSetLayout3_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout3_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout4
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout4 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout4()
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
            bindings = this._FavSetLayout4_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout4WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout4[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 2;
            this.mxmlContent = [this._FavSetLayout4_FavsetBox1_i(), this._FavSetLayout4_FavsetBox2_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout4_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 50;
            loc1.position = 1;
            loc1.id = "_FavSetLayout4_FavsetBox1";
            this._FavSetLayout4_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout4_FavsetBox1", this._FavSetLayout4_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout4_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 50;
            loc1.position = 2;
            loc1.id = "_FavSetLayout4_FavsetBox2";
            this._FavSetLayout4_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout4_FavsetBox2", this._FavSetLayout4_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout4_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout4_FavsetBox1.boxFormat")
            result[2] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_CURRENT_SPEED;
            }, null, "_FavSetLayout4_FavsetBox1.defaultFunction")
            result[3] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout4_FavsetBox1.defaultFunctions")
            result[4] = new feathers.binding.Binding(this, null, null, "_FavSetLayout4_FavsetBox1.editable", "editable");
            result[5] = new feathers.binding.Binding(this, null, null, "_FavSetLayout4_FavsetBox1.favFunctionList", "favFunctionList");
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout4_FavsetBox1.showLabel", "showLabel");
            result[7] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout4_FavsetBox2.boxFormat")
            result[8] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_TRIP_DISTANCE;
            }, null, "_FavSetLayout4_FavsetBox2.defaultFunction")
            result[9] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout4_FavsetBox2.defaultFunctions")
            result[10] = new feathers.binding.Binding(this, null, null, "_FavSetLayout4_FavsetBox2.editable", "editable");
            result[11] = new feathers.binding.Binding(this, null, null, "_FavSetLayout4_FavsetBox2.favFunctionList", "favFunctionList");
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout4_FavsetBox2.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout4._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=4;

        public var _FavSetLayout4_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout4_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout7
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout7 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout7()
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
            bindings = this._FavSetLayout7_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout7WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout7[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 3;
            this.mxmlContent = [this._FavSetLayout7_FavsetBox1_i(), this._FavSetLayout7_FavsetBox2_i(), this._FavSetLayout7_FavsetBox3_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout7_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 33;
            loc1.position = 1;
            loc1.id = "_FavSetLayout7_FavsetBox1";
            this._FavSetLayout7_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout7_FavsetBox1", this._FavSetLayout7_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout7_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 33;
            loc1.position = 2;
            loc1.id = "_FavSetLayout7_FavsetBox2";
            this._FavSetLayout7_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout7_FavsetBox2", this._FavSetLayout7_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout7_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 34;
            loc1.position = 3;
            loc1.id = "_FavSetLayout7_FavsetBox3";
            this._FavSetLayout7_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout7_FavsetBox3", this._FavSetLayout7_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout7_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout7_FavsetBox1.boxFormat")
            result[2] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_CURRENT_SPEED;
            }, null, "_FavSetLayout7_FavsetBox1.defaultFunction")
            result[3] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout7_FavsetBox1.defaultFunctions")
            result[4] = new feathers.binding.Binding(this, null, null, "_FavSetLayout7_FavsetBox1.editable", "editable");
            result[5] = new feathers.binding.Binding(this, null, null, "_FavSetLayout7_FavsetBox1.favFunctionList", "favFunctionList");
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout7_FavsetBox1.showLabel", "showLabel");
            result[7] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout7_FavsetBox2.boxFormat")
            result[8] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_BICYCLE_TRIP_DISTANCE;
            }, null, "_FavSetLayout7_FavsetBox2.defaultFunction")
            result[9] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout7_FavsetBox2.defaultFunctions")
            result[10] = new feathers.binding.Binding(this, null, null, "_FavSetLayout7_FavsetBox2.editable", "editable");
            result[11] = new feathers.binding.Binding(this, null, null, "_FavSetLayout7_FavsetBox2.favFunctionList", "favFunctionList");
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout7_FavsetBox2.showLabel", "showLabel");
            result[13] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout7_FavsetBox3.boxFormat")
            result[14] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_TIME_EXCERCISE_TIME;
            }, null, "_FavSetLayout7_FavsetBox3.defaultFunction")
            result[15] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout7_FavsetBox3.defaultFunctions")
            result[16] = new feathers.binding.Binding(this, null, null, "_FavSetLayout7_FavsetBox3.editable", "editable");
            result[17] = new feathers.binding.Binding(this, null, null, "_FavSetLayout7_FavsetBox3.favFunctionList", "favFunctionList");
            result[18] = new feathers.binding.Binding(this, null, null, "_FavSetLayout7_FavsetBox3.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout7._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=7;

        public var _FavSetLayout7_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout7_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout7_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout8
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout8 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout8()
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
            bindings = this._FavSetLayout8_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout8WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout8[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 3;
            this.mxmlContent = [this._FavSetLayout8_FavsetBox1_i(), this._FavSetLayout8_LayoutGroup1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout8_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageHeight = 75;
            loc1.position = 1;
            loc1.id = "_FavSetLayout8_FavsetBox1";
            this._FavSetLayout8_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout8_FavsetBox1", this._FavSetLayout8_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout8_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout8_FavsetBox2_i(), this._FavSetLayout8_FavsetBox3_i()];
            loc1.id = "_FavSetLayout8_LayoutGroup1";
            this._FavSetLayout8_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout8_LayoutGroup1", this._FavSetLayout8_LayoutGroup1);
            return loc1;
        }

        internal function _FavSetLayout8_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 2;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout8_FavsetBox2";
            this._FavSetLayout8_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout8_FavsetBox2", this._FavSetLayout8_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout8_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.percentageWidth = 50;
            loc1.position = 3;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout8_FavsetBox3";
            this._FavSetLayout8_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout8_FavsetBox3", this._FavSetLayout8_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout8_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout8_FavsetBox1.boxFormat")
            result[2] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_ALTITUDE_PROFILE;
            }, null, "_FavSetLayout8_FavsetBox1.defaultFunction")
            result[3] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout8_FavsetBox1.defaultFunctions")
            result[4] = new feathers.binding.Binding(this, null, null, "_FavSetLayout8_FavsetBox1.editable", "editable");
            result[5] = new feathers.binding.Binding(this, null, null, "_FavSetLayout8_FavsetBox1.favFunctionList", "favFunctionList");
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout8_FavsetBox1.showLabel", "showLabel");
            result[7] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout8_LayoutGroup1.layout")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 25);
            }, null, "_FavSetLayout8_LayoutGroup1.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout8_FavsetBox2.boxFormat")
            result[10] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_ALTITUDE_ASCENT;
            }, null, "_FavSetLayout8_FavsetBox2.defaultFunction")
            result[11] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout8_FavsetBox2.defaultFunctions")
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout8_FavsetBox2.editable", "editable");
            result[13] = new feathers.binding.Binding(this, null, null, "_FavSetLayout8_FavsetBox2.favFunctionList", "favFunctionList");
            result[14] = new feathers.binding.Binding(this, null, null, "_FavSetLayout8_FavsetBox2.showLabel", "showLabel");
            result[15] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout8_FavsetBox3.boxFormat")
            result[16] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_ALTITUDE_CURRENT_ALTITUDE;
            }, null, "_FavSetLayout8_FavsetBox3.defaultFunction")
            result[17] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout8_FavsetBox3.defaultFunctions")
            result[18] = new feathers.binding.Binding(this, null, null, "_FavSetLayout8_FavsetBox3.editable", "editable");
            result[19] = new feathers.binding.Binding(this, null, null, "_FavSetLayout8_FavsetBox3.favFunctionList", "favFunctionList");
            result[20] = new feathers.binding.Binding(this, null, null, "_FavSetLayout8_FavsetBox3.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout8._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=8;

        public var _FavSetLayout8_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout8_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout8_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout8_LayoutGroup1:feathers.controls.LayoutGroup;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayout9
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class FavSetLayout9 extends frontend.screen.mydevices.sportprofiles.FavsetLayoutBase implements feathers.binding.IBindingClient
    {
        public function FavSetLayout9()
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
            bindings = this._FavSetLayout9_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_layouts_FavSetLayout9WatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return FavSetLayout9[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.numberOfFunctions = 3;
            this.mxmlContent = [this._FavSetLayout9_LayoutGroup1_i(), this._FavSetLayout9_FavsetBox3_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _FavSetLayout9_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._FavSetLayout9_FavsetBox1_i(), this._FavSetLayout9_FavsetBox2_i()];
            loc1.id = "_FavSetLayout9_LayoutGroup1";
            this._FavSetLayout9_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout9_LayoutGroup1", this._FavSetLayout9_LayoutGroup1);
            return loc1;
        }

        internal function _FavSetLayout9_FavsetBox1_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.position = 1;
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout9_FavsetBox1";
            this._FavSetLayout9_FavsetBox1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout9_FavsetBox1", this._FavSetLayout9_FavsetBox1);
            return loc1;
        }

        internal function _FavSetLayout9_FavsetBox2_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.position = 2;
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.useHorizontalLayout = true;
            loc1.id = "_FavSetLayout9_FavsetBox2";
            this._FavSetLayout9_FavsetBox2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout9_FavsetBox2", this._FavSetLayout9_FavsetBox2);
            return loc1;
        }

        internal function _FavSetLayout9_FavsetBox3_i():frontend.screen.mydevices.sportprofiles.favsets.FavsetBox
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.favsets.FavsetBox();
            loc1.percentageHeight = 67;
            loc1.position = 3;
            loc1.touchFunction = onFavsetBoxTouched;
            loc1.id = "_FavSetLayout9_FavsetBox3";
            this._FavSetLayout9_FavsetBox3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavSetLayout9_FavsetBox3", this._FavSetLayout9_FavsetBox3);
            return loc1;
        }

        internal function _FavSetLayout9_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():uint
            {
                return TEMPLATE_ID;
            }, null, "this.templateId")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return hLayout;
            }, null, "_FavSetLayout9_LayoutGroup1.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 33);
            }, null, "_FavSetLayout9_LayoutGroup1.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout9_FavsetBox1.boxFormat")
            result[4] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TIME_OF_ARRIVAL;
            }, null, "_FavSetLayout9_FavsetBox1.defaultFunction")
            result[5] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout9_FavsetBox1.defaultFunctions")
            result[6] = new feathers.binding.Binding(this, null, null, "_FavSetLayout9_FavsetBox1.editable", "editable");
            result[7] = new feathers.binding.Binding(this, null, null, "_FavSetLayout9_FavsetBox1.favFunctionList", "favFunctionList");
            result[8] = new feathers.binding.Binding(this, null, null, "_FavSetLayout9_FavsetBox1.showLabel", "showLabel");
            result[9] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_SMALL;
            }, null, "_FavSetLayout9_FavsetBox2.boxFormat")
            result[10] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TIME_TO_DESTINATION;
            }, null, "_FavSetLayout9_FavsetBox2.defaultFunction")
            result[11] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout9_FavsetBox2.defaultFunctions")
            result[12] = new feathers.binding.Binding(this, null, null, "_FavSetLayout9_FavsetBox2.editable", "editable");
            result[13] = new feathers.binding.Binding(this, null, null, "_FavSetLayout9_FavsetBox2.favFunctionList", "favFunctionList");
            result[14] = new feathers.binding.Binding(this, null, null, "_FavSetLayout9_FavsetBox2.showLabel", "showLabel");
            result[15] = new feathers.binding.Binding(this, function ():uint
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox.BOX_FORMAT_BIG;
            }, null, "_FavSetLayout9_FavsetBox3.boxFormat")
            result[16] = new feathers.binding.Binding(this, function ():uint
            {
                return core.sportprofiles.SportprofileFavFunctions.FUNC_NAVIGATION_TRACK_VIEW;
            }, null, "_FavSetLayout9_FavsetBox3.defaultFunction")
            result[17] = new feathers.binding.Binding(this, function ():Array
            {
                var loc1:*=defaultFunctions;
                return loc1 == null || loc1 is Array || loc1 is flash.utils.Proxy ? loc1 : [loc1];
            }, null, "_FavSetLayout9_FavsetBox3.defaultFunctions")
            result[18] = new feathers.binding.Binding(this, null, null, "_FavSetLayout9_FavsetBox3.editable", "editable");
            result[19] = new feathers.binding.Binding(this, null, null, "_FavSetLayout9_FavsetBox3.favFunctionList", "favFunctionList");
            result[20] = new feathers.binding.Binding(this, null, null, "_FavSetLayout9_FavsetBox3.showLabel", "showLabel");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            FavSetLayout9._watcherSetupUtil = arg1;
            return;
        }

        public static const TEMPLATE_ID:uint=9;

        public var _FavSetLayout9_FavsetBox1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout9_FavsetBox2:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout9_FavsetBox3:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var _FavSetLayout9_LayoutGroup1:feathers.controls.LayoutGroup;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavSetLayoutsConfig
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    public class FavSetLayoutsConfig extends Object
    {
        public function FavSetLayoutsConfig()
        {
            super();
            return;
        }

        public static function getTemplateById(arg1:uint):Class
        {
            var loc1:*=0;
            while (loc1 < templates.length) 
            {
                if (templates[loc1][ATTR_NAME_TEMPLATE_ID] == arg1) 
                {
                    return templates[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static function getIndexByClass(arg1:Class):int
        {
            var loc1:*=0;
            while (loc1 < templates.length) 
            {
                if (templates[loc1] == arg1) 
                {
                    return loc1;
                }
                ++loc1;
            }
            return -1;
        }

        public static function getTemplateIdByIndex(arg1:uint):int
        {
            if (templates.hasOwnProperty(arg1)) 
            {
                return templates[arg1][ATTR_NAME_TEMPLATE_ID];
            }
            return 0;
        }

        public static function templateIdExists(arg1:uint):Boolean
        {
            return templates.hasOwnProperty(arg1);
        }

        public static const ATTR_NAME_TEMPLATE_ID:String="TEMPLATE_ID";

        public static const templates:Array=[frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout1, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout2, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout3, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout4, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout7, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout8, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout9, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout11, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout12, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout13, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout14, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout15, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout16, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout17];
    }
}


