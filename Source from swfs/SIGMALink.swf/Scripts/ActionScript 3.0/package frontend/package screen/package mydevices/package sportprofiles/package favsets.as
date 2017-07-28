//package favsets
//  package layouts
//    class FavSetLayout1
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


//    class FavSetLayout11
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


//    class FavSetLayout12
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


//    class FavSetLayout13
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


//    class FavSetLayout14
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


//    class FavSetLayout15
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


//    class FavSetLayout16
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


//    class FavSetLayout17
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


//    class FavSetLayout2
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


//    class FavSetLayout3
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


//    class FavSetLayout4
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


//    class FavSetLayout7
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


//    class FavSetLayout8
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


//    class FavSetLayout9
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


//    class FavSetLayoutsConfig
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


//  class FavSetEditor
package frontend.screen.mydevices.sportprofiles.favsets 
{
    import core.general.*;
    import core.sportprofiles.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.layouts.*;
    import starling.display.*;
    import starling.events.*;
    
    public class FavSetEditor extends feathers.controls.LayoutGroup
    {
        public function FavSetEditor()
        {
            this.favFunctionList = new core.sportprofiles.FavFunctionList();
            super();
            layout = new feathers.layout.VerticalLayout();
            (layout as feathers.layout.VerticalLayout).padding = this.padding;
            (layout as feathers.layout.VerticalLayout).gap = this.gap;
            layoutData = new feathers.layout.VerticalLayoutData(100, 100);
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        internal function set _102102gap(arg1:Number):void
        {
            this._gap = arg1;
            if (!(layout == null) && layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).gap = arg1;
            }
            return;
        }

        public function get padding():Number
        {
            return this._padding;
        }

        internal function set _806339567padding(arg1:Number):void
        {
            this._padding = arg1;
            if (!(layout == null) && layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).padding = arg1;
            }
            return;
        }

        public function initEditor():void
        {
            this._manInitialize = true;
            this.onInit();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            if (this.autoInitialize) 
            {
                this.onInit();
            }
            return;
        }

        internal function onInit():void
        {
            if (!this.autoInitialize && !this._manInitialize) 
            {
                return;
            }
            this._manInitialize = true;
            if (this.favFunctionList.templateId <= 0) 
            {
                this.favFunctionList.templateId = 1;
            }
            this.loadTemplateById(this.favFunctionList.templateId);
            return;
        }

        public function loadTemplateById(arg1:uint=1):void
        {
            if (arg1 == this.favFunctionList.templateId && this._templateInitialized) 
            {
                return;
            }
            var loc1:*=frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayoutsConfig.getTemplateById(arg1);
            var loc2:*=!(arg1 == this.favFunctionList.templateId);
            if (loc1 != null) 
            {
                this.removeChildren();
                this._favsetlayout = new loc1();
                this._favsetlayout.editable = true;
                this._favsetlayout.favFunctionList = this.favFunctionList;
                this._favsetlayout.favsetBoxTouchFunction = this.onFavsetBoxTouched;
                this._favsetlayout.gap = this.gap;
                if (loc2) 
                {
                    this._favsetlayout.setDefaultFavFunctionList(arg1);
                }
                this.addChild(this._favsetlayout);
                if (!(this.favsetBoxTouchFunction == null) && this._templateInitialized) 
                {
                    this.favsetBoxTouchFunction(this.favFunctionList);
                }
                this._templateInitialized = true;
            }
            return;
        }

        internal function onFavsetBoxTouched(arg1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox):void
        {
            if (this.favsetBoxTouchFunction != null) 
            {
                this.favsetBoxTouchFunction(arg1);
            }
            return;
        }

        public function set padding(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.padding;
            if (loc1 !== arg1) 
            {
                this._806339567padding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "padding", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set gap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.gap;
            if (loc1 !== arg1) 
            {
                this._102102gap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "gap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static const DEFAULT_GAP:Number=20;

        public static const DEFAULT_PADDING:Number=20;

        public var autoInitialize:Boolean=true;

        public var enabled:Boolean;

        public var favFunctionList:core.sportprofiles.FavFunctionList;

        public var favsetBoxTouchFunction:Function;

        internal var _gap:Number=20;

        internal var _padding:Number=20;

        internal var _favsetlayout:frontend.screen.mydevices.sportprofiles.FavsetLayoutBase;

        internal var _manInitialize:Boolean=false;

        internal var _templateInitialized:Boolean=false;
    }
}


//  class FavsetBox
package frontend.screen.mydevices.sportprofiles.favsets 
{
    import core.general.*;
    import core.sportprofiles.*;
    import debug.*;
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
    import flash.events.*;
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
    
    public class FavsetBox extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function FavsetBox()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1933458470_customLayout = new feathers.layout.VerticalLayout();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._FavsetBox_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_FavsetBoxWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._FavsetBox_TextureImage1_i(), this._FavsetBox_Label1_i()];
            this.addEventListener("initialize", this.___FavsetBox_LayoutGroup1_initialize);
            this.addEventListener("resize", this.___FavsetBox_LayoutGroup1_resize);
            this.addEventListener("touch", this.___FavsetBox_LayoutGroup1_touch);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function checkDefaultFunctions():void
        {
            if (this.position <= 0) 
            {
                return;
            }
            if (this.defaultFunction <= 0) 
            {
                return;
            }
            if (this.defaultFunctions == null) 
            {
                return;
            }
            this.defaultFunctions[this.position] = this.defaultFunction;
            return;
        }

        protected function onResize(arg1:starling.events.Event):void
        {
            this._labelMaxWidth = this.width;
            return;
        }

        protected function onFavsetBoxTouched(arg1:starling.events.TouchEvent):void
        {
            this.touchHandler(arg1);
            if (!this.editable || !handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            debug.Debug.debug("[onFavsetBoxTouched]");
            if (this.touchFunction != null) 
            {
                this.touchFunction(this);
            }
            return;
        }

        internal function _FavsetBox_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "_FavsetBox_TextureImage1";
            this._FavsetBox_TextureImage1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavsetBox_TextureImage1", this._FavsetBox_TextureImage1);
            return loc1;
        }

        public function get currentState():String
        {
            return this._currentState;
        }

        public function set currentState(arg1:String):void
        {
            if (this._currentState == arg1) 
            {
                return;
            }
            this._currentState = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        internal function _FavsetBox_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_FavsetBox_Label1";
            this._FavsetBox_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavsetBox_Label1", this._FavsetBox_Label1);
            return loc1;
        }

        public function get defaultFunction():uint
        {
            return this._defaultFunction;
        }

        public function set defaultFunction(arg1:uint):void
        {
            this._defaultFunction = arg1;
            this.checkDefaultFunctions();
            return;
        }

        public function ___FavsetBox_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInitialize(arg1);
            return;
        }

        public function get defaultFunctions():Array
        {
            return this._defaultFunctions;
        }

        public function set defaultFunctions(arg1:Array):void
        {
            this._defaultFunctions = arg1;
            this.checkDefaultFunctions();
            return;
        }

        public function ___FavsetBox_LayoutGroup1_resize(arg1:starling.events.Event):void
        {
            this.onResize(arg1);
            return;
        }

        public function get editable():Boolean
        {
            return this._editable;
        }

        internal function set _1602416228editable(arg1:Boolean):void
        {
            this._editable = arg1;
            return;
        }

        public function ___FavsetBox_LayoutGroup1_touch(arg1:starling.events.TouchEvent):void
        {
            this.onFavsetBoxTouched(arg1);
            return;
        }

        public function get favFunctionList():core.sportprofiles.FavFunctionList
        {
            return this._favFunctionList;
        }

        public function set favFunctionList(arg1:core.sportprofiles.FavFunctionList):void
        {
            if (this._favFunctionList != null) 
            {
                this._favFunctionList.removeEventListener(core.sportprofiles.FavFunctionList.EVENT_FAVFUNCTIONLIST_CHANGED, this.onFavFunctionListChanged);
            }
            this._favFunctionList = arg1;
            this._favFunctionList.addEventListener(core.sportprofiles.FavFunctionList.EVENT_FAVFUNCTIONLIST_CHANGED, this.onFavFunctionListChanged);
            this.checkLabel();
            return;
        }

        public override function set height(arg1:Number):void
        {
            if (arg1 > 0) 
            {
                super.height = arg1;
            }
            return;
        }

        internal function _FavsetBox_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return STATE_UP_BACKGROUND_SKIN;
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 100);
            }, null, "this.layoutData")
            result[3] = new feathers.binding.Binding(this, null, null, "this.touchable", "editable");
            result[4] = new feathers.binding.Binding(this, null, null, "_FavsetBox_TextureImage1.includeInLayout", "editable");
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(2, 2, NaN, NaN, NaN, NaN);
            }, null, "_FavsetBox_TextureImage1.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.linkiconsmall;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_FavsetBox_TextureImage1.textureName")
            result[7] = new feathers.binding.Binding(this, null, null, "_FavsetBox_TextureImage1.visible", "editable");
            result[8] = new feathers.binding.Binding(this, null, null, "_FavsetBox_Label1.includeInLayout", "showLabel");
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            }, null, "_FavsetBox_Label1.layoutData")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return _labelMaxWidth;
            }, null, "_FavsetBox_Label1.maxWidth")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_FavsetBox_Label1.styleName")
            result[12] = new feathers.binding.Binding(this, null, null, "_FavsetBox_Label1.text", "label");
            result[13] = new feathers.binding.Binding(this, null, null, "_FavsetBox_Label1.visible", "showLabel");
            return result;
        }

        internal function set _customLayout(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1933458470_customLayout;
            if (loc1 !== arg1) 
            {
                this._1933458470_customLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_customLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set percentageHeight(arg1:uint):void
        {
            this._percentageHeight = arg1;
            this.refreshCustomLayoutData();
            return;
        }

        public function set editable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.editable;
            if (loc1 !== arg1) 
            {
                this._1602416228editable = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editable", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set percentageWidth(arg1:uint):void
        {
            this._percentageWidth = arg1;
            this.refreshCustomLayoutData();
            return;
        }

        internal function get _labelMaxWidth():uint
        {
            return this._1677776855_labelMaxWidth;
        }

        public function get position():uint
        {
            return this._position;
        }

        public function set position(arg1:uint):void
        {
            this._position = arg1;
            this.checkLabel();
            this.checkDefaultFunctions();
            return;
        }

        internal function set _labelMaxWidth(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1677776855_labelMaxWidth;
            if (loc1 !== arg1) 
            {
                this._1677776855_labelMaxWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_labelMaxWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get label():String
        {
            return this._102727412label;
        }

        public function set label(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._102727412label;
            if (loc1 !== arg1) 
            {
                this._102727412label = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "label", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set useHorizontalLayout(arg1:Boolean):void
        {
            this._useHorizontalLayout = arg1;
            if (this._useHorizontalLayout && !(layoutData is feathers.layout.HorizontalLayoutData)) 
            {
                layoutData = new feathers.layout.HorizontalLayoutData(this._percentageWidth, this._percentageHeight);
            }
            else if (!this._useHorizontalLayout && !(layoutData is feathers.layout.VerticalLayoutData)) 
            {
                layoutData = new feathers.layout.VerticalLayoutData(this._percentageWidth, this._percentageHeight);
            }
            return;
        }

        internal function get _customLayout():feathers.layout.VerticalLayout
        {
            return this._1933458470_customLayout;
        }

        public function get showLabel():Boolean
        {
            return this._1921447433showLabel;
        }

        public function set showLabel(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1921447433showLabel;
            if (loc1 !== arg1) 
            {
                this._1921447433showLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "showLabel", loc1, arg1, this);
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
            frontend.screen.mydevices.sportprofiles.favsets.FavsetBox._watcherSetupUtil = arg1;
            return;
        }

        internal function touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this.isEnabled) 
            {
                this.touchID = -1;
                this.currentState = STATE_UP;
                return;
            }
            if (this.touchID >= 0) 
            {
                loc1 = arg1.getTouch(this, null, this.touchID);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.phase == starling.events.TouchPhase.ENDED) 
                {
                    this.currentState = STATE_UP;
                    this.touchID = -1;
                    this.backgroundSkin = this.STATE_UP_BACKGROUND_SKIN;
                }
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
            if (loc1) 
            {
                this.currentState = STATE_DOWN;
                this.touchID = loc1.id;
                this.backgroundSkin = this.STATE_DOWN_BACKGROUND_SKIN;
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.HOVER);
            if (loc1) 
            {
                this.currentState = STATE_HOVER;
                return;
            }
            this.currentState = STATE_UP;
            return;
        }

        protected function onInitialize(arg1:starling.events.Event):void
        {
            if (layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
                (layout as feathers.layout.VerticalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            }
            else if (layout is feathers.layout.HorizontalLayout) 
            {
                (layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
                (layout as feathers.layout.HorizontalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            }
            else if (!(layout is feathers.layout.AnchorLayout)) 
            {
            };
            this.refreshCustomLayoutData();
            return;
        }

        internal function refreshCustomLayoutData():void
        {
            if (this._useHorizontalLayout && (!((layoutData as feathers.layout.HorizontalLayoutData).percentHeight == this._percentageHeight) || !((layoutData as feathers.layout.HorizontalLayoutData).percentWidth == this._percentageWidth))) 
            {
                (layoutData as feathers.layout.HorizontalLayoutData).percentHeight = this._percentageHeight;
                (layoutData as feathers.layout.HorizontalLayoutData).percentWidth = this._percentageWidth;
            }
            else if (!this._useHorizontalLayout && (!((layoutData as feathers.layout.VerticalLayoutData).percentHeight == this._percentageHeight) || !((layoutData as feathers.layout.VerticalLayoutData).percentWidth == this._percentageWidth))) 
            {
                (layoutData as feathers.layout.VerticalLayoutData).percentHeight = this._percentageHeight;
                (layoutData as feathers.layout.VerticalLayoutData).percentWidth = this._percentageWidth;
            }
            return;
        }

        internal function onFavFunctionListChanged(arg1:flash.events.Event):void
        {
            this.checkLabel();
            return;
        }

        internal function checkLabel():void
        {
            if (this.position <= 0) 
            {
                return;
            }
            if (this.favFunctionList == null) 
            {
                return;
            }
            var loc1:*=this.favFunctionList.getFavFunctionlistItem((this.position - 1));
            if (loc1 == null) 
            {
                return;
            }
            if (!(this.favFunctionListItem == null) && loc1.favFuncId == this.favFunctionListItem.favFuncId) 
            {
                return;
            }
            this.favFunctionListItem = loc1;
            if (this.favFunctionListItem != null) 
            {
                this.label = utils.LanguageManager.getString("SPORTPROFILE_FUNCTION_" + this.favFunctionListItem.favFuncId);
            }
            return;
        }

        internal const STATE_DOWN_BACKGROUND_SKIN:starling.display.Quad=new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);

        internal const STATE_UP_BACKGROUND_SKIN:starling.display.Quad=new starling.display.Quad(1, 1, core.general.Colors.WHITE);

        public static const BOX_FORMAT_BIG:uint=core.sportprofiles.SportprofileFavFunctionObject.ALLOWED_BOX_FORMAT_BIG;

        public static const BOX_FORMAT_SMALL:uint=core.sportprofiles.SportprofileFavFunctionObject.ALLOWED_BOX_FORMAT_SMALL;

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_UP:String="up";

        public var _FavsetBox_Label1:feathers.controls.Label;

        public var _FavsetBox_TextureImage1:frontend.components.TextureImage;

        public var boxFormat:uint=10;

        internal var _currentState:String="up";

        internal var _defaultFunction:uint=1;

        internal var _defaultFunctions:Array;

        internal var _editable:Boolean=false;

        internal var _favFunctionList:core.sportprofiles.FavFunctionList;

        internal var _102727412label:String="";

        internal var _percentageHeight:uint=100;

        internal var _percentageWidth:uint=100;

        internal var _position:uint=0;

        internal var _1921447433showLabel:Boolean=true;

        public var touchFunction:Function;

        internal var _useHorizontalLayout:Boolean=false;

        protected var touchID:int=-1;

        internal var _1933458470_customLayout:feathers.layout.VerticalLayout;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _1677776855_labelMaxWidth:uint=400;

        mx_internal var _watchers:Array;

        mx_internal var _bindings:Array;

        internal var favFunctionListItem:core.sportprofiles.FavFunctionlistItem;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


