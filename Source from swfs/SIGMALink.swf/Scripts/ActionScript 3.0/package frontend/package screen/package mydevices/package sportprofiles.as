//package sportprofiles
//  package favsets
//    package layouts
//      class FavSetLayout1
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


//      class FavSetLayout11
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


//      class FavSetLayout12
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


//      class FavSetLayout13
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


//      class FavSetLayout14
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


//      class FavSetLayout15
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


//      class FavSetLayout16
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


//      class FavSetLayout17
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


//      class FavSetLayout2
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


//      class FavSetLayout3
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


//      class FavSetLayout4
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


//      class FavSetLayout7
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


//      class FavSetLayout8
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


//      class FavSetLayout9
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


//      class FavSetLayoutsConfig
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


//    class FavSetEditor
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


//    class FavsetBox
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


//  package list
//    class SportprofileCategoryListItem
package frontend.screen.mydevices.sportprofiles.list 
{
    import core.sportprofiles.*;
    import frontend.components.list.*;
    
    public class SportprofileCategoryListItem extends frontend.components.list.SelectableListItem
    {
        public function SportprofileCategoryListItem()
        {
            super();
            return;
        }

        public var category:core.sportprofiles.SportprofileFavFunctionsCategory;
    }
}


//    class SportprofileFunctionListItem
package frontend.screen.mydevices.sportprofiles.list 
{
    import core.sportprofiles.*;
    import frontend.components.list.*;
    
    public class SportprofileFunctionListItem extends frontend.components.list.SelectableListItem
    {
        public function SportprofileFunctionListItem()
        {
            super();
            return;
        }

        public var favFunction:core.sportprofiles.SportprofileFavFunctionObject;
    }
}


//    class SportprofilesFavsetItemCategoryItemRenderer
package frontend.screen.mydevices.sportprofiles.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    
    public class SportprofilesFavsetItemCategoryItemRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function SportprofilesFavsetItemCategoryItemRenderer()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            padding = 20 * SIGMALink.scaleFactor;
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._selectImage = new frontend.components.TextureImage();
            this._selectImage.textureName = frontend.Textures.pfeilmitbg;
            this._selectImage.touchable = false;
            this._selectImage.layoutData = new feathers.layout.AnchorLayoutData(NaN, padding, NaN, NaN, NaN, 0);
            this._group.addChild(this._selectImage);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, padding, NaN, 0);
            this._group.addChild(this._name);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            this._name.text = this.categoryListItem().category.label;
            this._name.width = width - this._selectImage.width - 3 * padding;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        internal function categoryListItem():frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem
        {
            if (data is frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem) 
            {
                return data as frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem;
            }
            return new frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem();
        }

        internal var _bottomLine:starling.display.Quad;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _name:feathers.controls.Label;

        internal var _selectImage:frontend.components.TextureImage;
    }
}


//    class SportprofilesFavsetItemFunctionItemRenderer
package frontend.screen.mydevices.sportprofiles.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    
    public class SportprofilesFavsetItemFunctionItemRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function SportprofilesFavsetItemFunctionItemRenderer()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            padding = 20 * SIGMALink.scaleFactor;
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._selectImage = new frontend.components.TextureImage();
            this._selectImage.textureName = frontend.Textures.pfeilmitbg;
            this._selectImage.touchable = false;
            this._selectImage.layoutData = new feathers.layout.AnchorLayoutData(NaN, padding, NaN, NaN, NaN, 0);
            this._group.addChild(this._selectImage);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, padding, NaN, 0);
            this._group.addChild(this._name);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            this._name.text = this.functionListItem().favFunction.functionLabel;
            this._name.width = width - this._selectImage.width - 3 * padding;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        internal function functionListItem():frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem
        {
            if (data is frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem) 
            {
                return data as frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem;
            }
            return new frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem();
        }

        internal var _bottomLine:starling.display.Quad;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _name:feathers.controls.Label;

        internal var _selectImage:frontend.components.TextureImage;
    }
}


//  class DeviceSportprofileChangeCategoryView
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.renderers.*;
    import feathers.data.*;
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
    import frontend.screen.mydevices.sportprofiles.list.*;
    import handler.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class DeviceSportprofileChangeCategoryView extends frontend.screen.mydevices.sportprofiles.DeviceSportprofileChangeFuncBaseView
    {
        public function DeviceSportprofileChangeCategoryView()
        {
            super();
            return;
        }

        internal function onCategorySelected(arg1:frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_FUNCTION, {"sportprofile":sportprofile, "favsetNr":favsetNr, "favsetBox":favsetBox, "category":arg1.category.categoryId}, handler.ViewHandler.slideToLeftTransition(), true);
            return;
        }

        protected override function createItemRendererFactory():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.list.SportprofilesFavsetItemCategoryItemRenderer();
            return loc1;
        }

        protected override function createDataProvider():feathers.data.ListCollection
        {
            var loc2:*=0;
            var loc5:*=null;
            var loc1:*=core.sportprofiles.SportprofileFavFunctions.getInstance().getCategories();
            var loc3:*=loc1.length;
            var loc4:*=new feathers.data.ListCollection();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc5 = new frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem();
                loc5.category = loc1[loc2];
                loc4.push(loc5);
                ++loc2;
            }
            return loc4;
        }

        protected override function goBack():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET, {"sportprofile":sportprofile, "favsetNr":favsetNr}, handler.ViewHandler.slideToRightTransition(), true);
            return;
        }

        protected override function onListTouchedOk(arg1:starling.events.TouchEvent):void
        {
            if (_customList.selectedItem != null) 
            {
                this.onCategorySelected(_customList.selectedItem as frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem);
            }
            return;
        }
    }
}


//  class DeviceSportprofileChangeFuncBaseView
package frontend.screen.mydevices.sportprofiles 
{
    import core.general.*;
    import core.sportprofiles.*;
    import debug.*;
    import feathers.controls.renderers.*;
    import feathers.data.*;
    import feathers.events.*;
    import frontend.components.list.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class DeviceSportprofileChangeFuncBaseView extends frontend.screen.component.CustomScreen
    {
        public function DeviceSportprofileChangeFuncBaseView()
        {
            this.listLoader = new frontend.components.list.ListLoader();
            super();
            return;
        }

        protected override function validateProperties():void
        {
            super.validateProperties();
            core.sportprofiles.SportprofileFavFunctions.currentSportprofile = this.sportprofile;
            return;
        }

        protected function createItemRendererFactory():feathers.controls.renderers.IListItemRenderer
        {
            debug.Debug.error("please override");
            return null;
        }

        protected function createDataProvider():feathers.data.ListCollection
        {
            debug.Debug.error("please override");
            return new feathers.data.ListCollection();
        }

        protected function goBack():void
        {
            debug.Debug.error("please override");
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            allowCaching = false;
            hasBackwardNavigation = true;
            saveAsOldScreen = false;
            handler.ViewHandler.getInstance().addBackFunction(this.goBack);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        protected override function addContent():void
        {
            super.addContent();
            this.listLoader = new frontend.components.list.ListLoader();
            this.listLoader.startLoading();
            this.listLoader.height = SIGMALink.containerHeight;
            this.listLoader.width = SIGMALink.appWidth;
            addChild(this.listLoader);
            addChild(new frontend.screen.component.Footer());
            this._customList = new frontend.components.list.CustomList();
            this._customList.addEventListener(starling.events.TouchEvent.TOUCH, this.onListTouch);
            this._customList.height = SIGMALink.containerHeight;
            this._customList.width = SIGMALink.appWidth;
            this._customList.allowMultipleSelection = false;
            this._customList.autoHideBackground = false;
            this._customList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._customList.itemRendererFactory = this.createItemRendererFactory;
            this._customList.dataProvider = this.createDataProvider();
            this.listLoader.list = this._customList;
            this.listLoader.checkDataProvider();
            return;
        }

        internal function onListTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.onListTouchedOk(arg1);
            return;
        }

        protected function onListTouchedOk(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.error("please override");
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().removeBackFunction(this.goBack);
            return;
        }

        protected function get _customList():frontend.components.list.CustomList
        {
            return this._493623986_customList;
        }

        protected function set _customList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._493623986_customList;
            if (loc1 !== arg1) 
            {
                this._493623986_customList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_customList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var category:uint=0;

        public var favsetBox:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var favsetNr:uint;

        public var sportprofile:core.sportprofiles.Sportprofile;

        public var viewFilter:uint=1;

        protected var _493623986_customList:frontend.components.list.CustomList;

        protected var listLoader:frontend.components.list.ListLoader;
    }
}


//  class DeviceSportprofileChangeFunctionView
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.settings.interfaces.*;
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.renderers.*;
    import feathers.data.*;
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
    import frontend.screen.mydevices.sportprofiles.list.*;
    import handler.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class DeviceSportprofileChangeFunctionView extends frontend.screen.mydevices.sportprofiles.DeviceSportprofileChangeFuncBaseView
    {
        public function DeviceSportprofileChangeFunctionView()
        {
            super();
            return;
        }

        internal function onFunctionSelected(arg1:frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem):void
        {
            var loc1:*=(sportprofile as core.settings.interfaces.IFavSets).getFavSetObject(favsetNr);
            loc1.changeFavFunction(new core.sportprofiles.FavFunctionlistItem(arg1.favFunction.functionId, favsetBox.position));
            sportprofile.changeFavFunctionList(favsetNr, loc1);
            sportprofile.modificationDate = new Date().time;
            handler.AppDeviceHandler.getInstance().saveSportprofile(new backend.utils.dbUtils.DBUtilObject(sportprofile, this.onInsertDataComplete, this.onInsertDataComplete, null));
            return;
        }

        protected function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET, {"sportprofile":sportprofile, "favsetNr":favsetNr}, handler.ViewHandler.slideToRightTransition(), true);
            return;
        }

        protected override function createItemRendererFactory():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.list.SportprofilesFavsetItemFunctionItemRenderer();
            return loc1;
        }

        protected override function createDataProvider():feathers.data.ListCollection
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc5:*=null;
            if (category > 0) 
            {
                loc1 = core.sportprofiles.SportprofileFavFunctions.getInstance().getCategoryFunctions(category).filter(this.filterFunctions);
            }
            else 
            {
                loc1 = core.sportprofiles.SportprofileFavFunctions.getInstance().functions.filter(this.filterFunctions);
            }
            var loc3:*=loc1.length;
            var loc4:*=new feathers.data.ListCollection();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc5 = new frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem();
                loc5.favFunction = loc1[loc2];
                loc4.push(loc5);
                ++loc2;
            }
            return loc4;
        }

        protected override function goBack():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_CATEGORY, {"sportprofile":sportprofile, "favsetNr":favsetNr, "favsetBox":favsetBox}, handler.ViewHandler.slideToRightTransition(), true);
            return;
        }

        protected override function onListTouchedOk(arg1:starling.events.TouchEvent):void
        {
            this.onFunctionSelected(_customList.selectedItem as frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem);
            return;
        }

        internal function filterFunctions(arg1:core.sportprofiles.SportprofileFavFunctionObject, arg2:int, arg3:__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>):Boolean
        {
            if (arg1.allowedBoxFormats.indexOf(core.sportprofiles.SportprofileFavFunctionObject.ALLOWED_BOX_FORMAT_ALL) == -1 && favsetBox.boxFormat > 0 && arg1.allowedBoxFormats.indexOf(favsetBox.boxFormat) == -1) 
            {
                return false;
            }
            if (arg1.allowedViews.indexOf(viewFilter) == -1) 
            {
                return false;
            }
            return true;
        }
    }
}


//  class DeviceSportprofileChangeTemplateView
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.sportprofiles.*;
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
    import frontend.screen.component.*;
    import frontend.screen.mydevices.sportprofiles.favsets.layouts.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class DeviceSportprofileChangeTemplateView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSportprofileChangeTemplateView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._favSetTemplatesDataProvider = new Vector.<frontend.screen.mydevices.sportprofiles.FavsetLayoutBase>();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._DeviceSportprofileChangeTemplateView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_DeviceSportprofileChangeTemplateViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSportprofileChangeTemplateView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.savePropertiesForBackNavigation = false;
            this.mxmlContent = [this._DeviceSportprofileChangeTemplateView_ScrollContainer1_i(), this._DeviceSportprofileChangeTemplateView_Footer1_i()];
            this.addEventListener("addedToStage", this.___DeviceSportprofileChangeTemplateView_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___DeviceSportprofileChangeTemplateView_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___DeviceSportprofileChangeTemplateView_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _DeviceSportprofileChangeTemplateView_TiledRowsLayout1_i():feathers.layout.TiledRowsLayout
        {
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.distributeHeights = true;
            loc1.distributeWidths = true;
            loc1.useSquareTiles = false;
            this._DeviceSportprofileChangeTemplateView_TiledRowsLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileChangeTemplateView_TiledRowsLayout1", this._DeviceSportprofileChangeTemplateView_TiledRowsLayout1);
            return loc1;
        }

        public function __templateContainer_addedToStage(arg1:starling.events.Event):void
        {
            this.templateContainer_addedToStageHandler(arg1);
            return;
        }

        public function ___DeviceSportprofileChangeTemplateView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddetToStage(arg1);
            return;
        }

        public function ___DeviceSportprofileChangeTemplateView_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___DeviceSportprofileChangeTemplateView_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        public function get colsMaxCount():uint
        {
            return this._colsMaxCount;
        }

        public function set colsMaxCount(arg1:uint):void
        {
            this._colsMaxCount = arg1;
            this.refresehTemplatePreviewSize();
            return;
        }

        internal function _DeviceSportprofileChangeTemplateView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "templateContainer.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "templateContainer.height")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_POLICY_OFF;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "templateContainer.horizontalScrollPolicy")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "templateContainer.pageWidth")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_BAR_DISPLAY_MODE_NONE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "templateContainer.scrollBarDisplayMode")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_POLICY_ON;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "templateContainer.verticalScrollPolicy")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "templateContainer.width")
            result[7] = new feathers.binding.Binding(this, null, null, "_DeviceSportprofileChangeTemplateView_TiledRowsLayout1.gap", "gap");
            result[8] = new feathers.binding.Binding(this, null, null, "_DeviceSportprofileChangeTemplateView_TiledRowsLayout1.padding", "gap");
            result[9] = new feathers.binding.Binding(this, function ():int
            {
                return _cols;
            }, null, "_DeviceSportprofileChangeTemplateView_TiledRowsLayout1.requestedColumnCount")
            return result;
        }

        public function get colsMinWidth():uint
        {
            return this._colsMinWidth;
        }

        public function set colsMinWidth(arg1:uint):void
        {
            this._colsMinWidth = arg1;
            this.refresehTemplatePreviewSize();
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

        public function get gap():Number
        {
            return this._gap;
        }

        internal function set _102102gap(arg1:Number):void
        {
            this._gap = arg1;
            this.refresehTemplatePreviewSize();
            return;
        }

        public function get templateContainer():feathers.controls.ScrollContainer
        {
            return this._1612581159templateContainer;
        }

        public function set templateContainer(arg1:feathers.controls.ScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1612581159templateContainer;
            if (loc1 !== arg1) 
            {
                this._1612581159templateContainer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "templateContainer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function set templatePreviewWidth(arg1:Number):void
        {
            this._templatePreviewWidth = arg1;
            this._templatePreviewHeight = this._templatePreviewWidth / 3 * 4;
            return;
        }

        internal function get _cols():uint
        {
            return this._90793938_cols;
        }

        internal function set _cols(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._90793938_cols;
            if (loc1 !== arg1) 
            {
                this._90793938_cols = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_cols", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function templateContainer_addedToStageHandler(arg1:starling.events.Event):void
        {
            if (!this._favSetTemplatesLoaded) 
            {
                flash.utils.setTimeout(this.templateContainer_addedToStageHandler, 100, arg1);
                return;
            }
            this.templateContainer.removeChildren();
            var loc1:*=0;
            while (loc1 < this._favSetTemplatesDataProvider.length) 
            {
                this.templateContainer.addChild(this._favSetTemplatesDataProvider[loc1]);
                this._favSetTemplatesDataProvider[loc1].validate();
                ++loc1;
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSportprofileChangeTemplateView._watcherSetupUtil = arg1;
            return;
        }

        internal function refresehTemplatePreviewSize():void
        {
            var loc1:*=this._cols;
            var loc2:*=(SIGMALink.appWidth - this.gap * (loc1 + 1)) / loc1;
            if (!this.autoCalculateCols) 
            {
                this.templatePreviewWidth = loc2;
                return;
            }
            while (loc2 > this.colsMinWidth && loc1 < this.colsMaxCount) 
            {
                ++loc1;
                loc2 = (SIGMALink.appWidth - this.gap * (loc1 + 1)) / loc1;
            }
            this._cols = loc1;
            this.templatePreviewWidth = loc2;
            if (this.templateContainer != null) 
            {
                this.templateContainer.validate();
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            var loc2:*=null;
            this.refresehTemplatePreviewSize();
            var loc1:*=0;
            while (loc1 < frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayoutsConfig.templates.length) 
            {
                loc2 = new frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayoutsConfig.templates[loc1]();
                loc2.id = "template_" + loc2.templateId;
                loc2.editable = false;
                loc2.showLabel = false;
                loc2.height = this._templatePreviewHeight;
                loc2.width = this._templatePreviewWidth;
                loc2.gap = 4;
                loc2.padding = 4;
                loc2.touchable = true;
                loc2.touchFunction = this.onTemplateSelected;
                loc2.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.GREY);
                loc2.selected = this.sportprofile.getFavSetObject(this.favsetNr).templateId == loc2.templateId;
                this._favSetTemplatesDataProvider.push(loc2);
                ++loc1;
            }
            this._favSetTemplatesLoaded = true;
            return;
        }

        internal function onTemplateSelected(arg1:frontend.screen.mydevices.sportprofiles.FavsetLayoutBase):void
        {
            var loc1:*=new core.sportprofiles.FavFunctionList();
            loc1.fromJson(arg1.favFunctionList.toJson());
            loc1.active = this.defaultActive;
            this.sportprofile.changeFavFunctionList(this.favsetNr, loc1);
            arg1.editable = false;
            this.sportprofile.modificationDate = new Date().time;
            handler.AppDeviceHandler.getInstance().saveSportprofile(new backend.utils.dbUtils.DBUtilObject(this.sportprofile, this.onInsertDataComplete, this.onInsertDataComplete, null));
            return;
        }

        protected function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.goBack();
            return;
        }

        internal function goBack():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET, {"sportprofile":this.sportprofile, "favsetNr":this.favsetNr}, handler.ViewHandler.slideToRightTransition(), true);
            return;
        }

        internal function _DeviceSportprofileChangeTemplateView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        protected override function validateProperties():void
        {
            super.validateProperties();
            core.sportprofiles.SportprofileFavFunctions.currentSportprofile = this.sportprofile;
            var loc1:*=0;
            while (loc1 < this._favSetTemplatesDataProvider.length) 
            {
                this._favSetTemplatesDataProvider[loc1].selected = this.sportprofile.getFavSetObject(this.favsetNr).templateId == this._favSetTemplatesDataProvider[loc1].templateId;
                ++loc1;
            }
            return;
        }

        protected function onAddetToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addBackFunction(this.goBack);
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().removeBackFunction(this.goBack);
            return;
        }

        internal function _DeviceSportprofileChangeTemplateView_ScrollContainer1_i():feathers.controls.ScrollContainer
        {
            var loc1:*=new feathers.controls.ScrollContainer();
            loc1.autoHideBackground = true;
            loc1.clipContent = true;
            loc1.hasElasticEdges = false;
            loc1.layout = this._DeviceSportprofileChangeTemplateView_TiledRowsLayout1_i();
            loc1.addEventListener("addedToStage", this.__templateContainer_addedToStage);
            loc1.id = "templateContainer";
            this.templateContainer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "templateContainer", this.templateContainer);
            return loc1;
        }

        internal static const DEFAULT_COLS_MAX_COUNT:uint=4;

        internal static const DEFAULT_COLS_MIN_WIDTH:uint=120;

        internal static const DEFAULT_GAP:Number=20;

        public var _DeviceSportprofileChangeTemplateView_TiledRowsLayout1:feathers.layout.TiledRowsLayout;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1612581159templateContainer:feathers.controls.ScrollContainer;

        public var autoCalculateCols:Boolean=true;

        internal var _colsMaxCount:uint=4;

        internal var _colsMinWidth:uint=120;

        public var defaultActive:Boolean=false;

        public var favsetNr:uint;

        internal var _gap:Number=20;

        public var sportprofile:core.sportprofiles.Sportprofile;

        internal var _templatePreviewWidth:Number=0;

        internal var _90793938_cols:uint=2;

        internal var _favSetTemplatesDataProvider:__AS3__.vec.Vector.<frontend.screen.mydevices.sportprofiles.FavsetLayoutBase>;

        internal var _templatePreviewHeight:Number=0;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _watchers:Array;

        mx_internal var _bindings:Array;

        internal var _favSetTemplatesLoaded:Boolean=false;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class DeviceSportprofileFavSetView
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import core.sportprofiles.*;
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
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
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
    
    public class DeviceSportprofileFavSetView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSportprofileFavSetView()
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
            bindings = this._DeviceSportprofileFavSetView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_DeviceSportprofileFavSetViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSportprofileFavSetView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.savePropertiesForBackNavigation = false;
            this.mxmlContent = [this._DeviceSportprofileFavSetView_LayoutGroup1_i(), this._DeviceSportprofileFavSetView_Footer1_i()];
            this.addEventListener("initialize", this.___DeviceSportprofileFavSetView_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get activeCheckbox():frontend.components.menuList.MenuListItem
        {
            return this._665806615activeCheckbox;
        }

        public function set activeCheckbox(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._665806615activeCheckbox;
            if (loc1 !== arg1) 
            {
                this._665806615activeCheckbox = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "activeCheckbox", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get favSetEditorScroller():frontend.components.scrollContainer.CustomHScrollContainer
        {
            return this._972775406favSetEditorScroller;
        }

        public function set favSetEditorScroller(arg1:frontend.components.scrollContainer.CustomHScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._972775406favSetEditorScroller;
            if (loc1 !== arg1) 
            {
                this._972775406favSetEditorScroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "favSetEditorScroller", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
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

        public function get pageIndicator():frontend.components.CustomPageIndicator
        {
            return this._643699648pageIndicator;
        }

        public function set pageIndicator(arg1:frontend.components.CustomPageIndicator):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._643699648pageIndicator;
            if (loc1 !== arg1) 
            {
                this._643699648pageIndicator = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "pageIndicator", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _DeviceSportprofileFavSetView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._DeviceSportprofileFavSetView_VerticalLayout1_i();
            loc1.mxmlContent = [this._DeviceSportprofileFavSetView_MenuListItem1_i(), this._DeviceSportprofileFavSetView_CustomHScrollContainer1_i(), this._DeviceSportprofileFavSetView_CustomPageIndicator1_i()];
            loc1.id = "_DeviceSportprofileFavSetView_LayoutGroup1";
            this._DeviceSportprofileFavSetView_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileFavSetView_LayoutGroup1", this._DeviceSportprofileFavSetView_LayoutGroup1);
            return loc1;
        }

        public function get active():Boolean
        {
            return this._active;
        }

        internal function set _1422950650active(arg1:Boolean):void
        {
            this._active = this.favsetNr > 1 ? arg1 : true;
            return;
        }

        public function set active(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.active;
            if (loc1 !== arg1) 
            {
                this._1422950650active = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "active", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get changeFunction():Function
        {
            return this._1095383976changeFunction;
        }

        public function get favsetNr():uint
        {
            return this._favsetNr;
        }

        internal function set _1054106507favsetNr(arg1:uint):void
        {
            if (this._favsetNr == arg1) 
            {
                return;
            }
            this._favsetNr = arg1;
            this._pageLabel = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SPORT_PROFILES_AKTIV").replace("###NR###", arg1.toString());
            if (this.favSetEditorScroller && this.favSetEditorScroller.numChildren >= arg1) 
            {
                this.active = (this.favSetEditorScroller.getChildAt((arg1 - 1)) as frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor).favFunctionList.active;
            }
            return;
        }

        public function set favsetNr(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.favsetNr;
            if (loc1 !== arg1) 
            {
                this._1054106507favsetNr = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "favsetNr", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _favSetMaxCount():uint
        {
            return this._857027729_favSetMaxCount;
        }

        internal function set _favSetMaxCount(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._857027729_favSetMaxCount;
            if (loc1 !== arg1) 
            {
                this._857027729_favSetMaxCount = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_favSetMaxCount", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _pageLabel():String
        {
            return this._623155162_pageLabel;
        }

        internal function set _pageLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._623155162_pageLabel;
            if (loc1 !== arg1) 
            {
                this._623155162_pageLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_pageLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get verticalSeperatorLineVisible():Boolean
        {
            return this._56421971verticalSeperatorLineVisible;
        }

        internal function set verticalSeperatorLineVisible(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._56421971verticalSeperatorLineVisible;
            if (loc1 !== arg1) 
            {
                this._56421971verticalSeperatorLineVisible = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "verticalSeperatorLineVisible", loc1, arg1, this);
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
            DeviceSportprofileFavSetView._watcherSetupUtil = arg1;
            return;
        }

        internal function getFavFunctionList():core.sportprofiles.FavFunctionList
        {
            if (this.favSetEditorScroller && this.favSetEditorScroller.numChildren >= this.favsetNr) 
            {
                return (this.favSetEditorScroller.getChildAt((this.favsetNr - 1)) as frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor).favFunctionList;
            }
            return null;
        }

        protected override function validateProperties():void
        {
            super.validateProperties();
            title = this.sportprofile.profileName;
            core.sportprofiles.SportprofileFavFunctions.currentSportprofile = this.sportprofile;
            return;
        }

        internal function onFavChanged(arg1:core.sportprofiles.FavFunctionList):void
        {
            this.sportprofile.changeFavFunctionList(this.favsetNr, arg1);
            this.sportprofile.modificationDate = new Date().time;
            handler.AppDeviceHandler.getInstance().saveSportprofile(new backend.utils.dbUtils.DBUtilObject(this.sportprofile, this.onInsertDataComplete, this.onInsertDataComplete, null));
            return;
        }

        protected function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            return;
        }

        internal function onChangeTemplateClick(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_TEMPLATE, {"sportprofile":this.sportprofile, "favsetNr":this.favsetNr, "defaultActive":this.active}, handler.ViewHandler.slideToLeftTransition(), true);
            return;
        }

        protected function onInit(arg1:starling.events.Event=null):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            if (this.sportprofile is core.settings.interfaces.IFavSets) 
            {
                this._favSetMaxCount = (this.sportprofile as core.settings.interfaces.IFavSets).favSetMaxCount;
                loc1 = 1;
                this._favSetEditorsDataProvider = new Vector.<frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor>();
                while (loc1 <= this._favSetMaxCount) 
                {
                    loc3 = new core.sportprofiles.FavFunctionList();
                    loc3 = (this.sportprofile as core.settings.interfaces.IFavSets).getFavSetObject(loc1);
                    loc2 = new frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor();
                    loc2.layoutData = new feathers.layout.HorizontalLayoutData(NaN, 100);
                    loc2.id = "favSetEditor" + loc1;
                    loc2.autoInitialize = false;
                    loc2.favsetBoxTouchFunction = this.onFavsetBoxTouched;
                    loc2.enabled = loc3.active;
                    loc2.favFunctionList = loc3;
                    loc2.initEditor();
                    this._favSetEditorsDataProvider.push(loc2);
                    ++loc1;
                }
                this.favSetEditorsLoaded = true;
            }
            return;
        }

        internal function onFavsetBoxTouched(arg1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_CATEGORY, {"sportprofile":this.sportprofile, "favsetBox":arg1, "favsetNr":this.favsetNr}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected function onActiveCheckboxChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.active = arg2.rawValue as Boolean;
            var loc1:*=this.getFavFunctionList();
            loc1.active = this.active;
            this.onFavChanged(loc1);
            return;
        }

        internal function onUploadButtonClick(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES_TRANSFER, {"unit":this.sportprofile.unit, "sportprofile":this.sportprofile, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected function favSetEditorScroller_addedToStageHandler(arg1:starling.events.Event):void
        {
            if (!this.favSetEditorsLoaded) 
            {
                flash.utils.setTimeout(this.favSetEditorScroller_addedToStageHandler, 100, arg1);
                return;
            }
            this.favSetEditorScroller.removeChildren();
            this._scrollPosition = (this.favsetNr - 1);
            var loc1:*=0;
            while (loc1 < this._favSetEditorsDataProvider.length) 
            {
                this._favSetEditorsDataProvider[loc1].width = this.favSetEditorScroller.pageWidth;
                this.favSetEditorScroller.addChild(this._favSetEditorsDataProvider[loc1]);
                this._favSetEditorsDataProvider[loc1].validate();
                if (loc1 == this._scrollPosition) 
                {
                    this.active = (this._favSetEditorsDataProvider[loc1] as frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor).favFunctionList.active;
                }
                ++loc1;
            }
            this.scrollTo(this._scrollPosition);
            return;
        }

        protected function onScrollComplete(arg1:starling.events.Event):void
        {
            this.favsetNr = this.favSetEditorScroller.horizontalPageIndex + 1;
            return;
        }

        protected function onScroll(arg1:starling.events.Event):void
        {
            if (this.pageIndicator.selectedIndex != this.favSetEditorScroller.horizontalPageIndex) 
            {
                if (this.favSetEditorScroller.horizontalPageIndex <= this._scrollIndex && this.favSetEditorScroller.horizontalScrollPosition > this._scrollPosition) 
                {
                    return;
                }
                this.pageIndicator.selectedIndex = this.favSetEditorScroller.horizontalPageIndex;
            }
            this._scrollPosition = this.favSetEditorScroller.horizontalScrollPosition;
            return;
        }

        protected function onPageIndicatorChanged(arg1:starling.events.Event):void
        {
            this._scrollIndex = this.pageIndicator.selectedIndex;
            this.favsetNr = this.pageIndicator.selectedIndex + 1;
            if (!this.favSetEditorScroller.isScrolling) 
            {
                this.scrollTo(this.pageIndicator.selectedIndex);
            }
            return;
        }

        internal function scrollTo(arg1:uint):void
        {
            if (this.favSetEditorScroller == null) 
            {
                return;
            }
            this.favSetEditorScroller.scrollToPageIndex(arg1, 0, 0);
            return;
        }

        public function set changeFunction(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1095383976changeFunction;
            if (loc1 !== arg1) 
            {
                this._1095383976changeFunction = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "changeFunction", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _DeviceSportprofileFavSetView_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 2;
            loc1.paddingBottom = 25;
            this._DeviceSportprofileFavSetView_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileFavSetView_VerticalLayout1", this._DeviceSportprofileFavSetView_VerticalLayout1);
            return loc1;
        }

        internal function _DeviceSportprofileFavSetView_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.saveCompleteCallback = this.onActiveCheckboxChanged;
            loc1.useLocalesForText = false;
            loc1.id = "activeCheckbox";
            this.activeCheckbox = loc1;
            feathers.binding.BindingManager.executeBindings(this, "activeCheckbox", this.activeCheckbox);
            return loc1;
        }

        internal function _DeviceSportprofileFavSetView_CustomHScrollContainer1_i():frontend.components.scrollContainer.CustomHScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomHScrollContainer();
            loc1.autoHideBackground = true;
            loc1.clipContent = true;
            loc1.hasElasticEdges = true;
            loc1.snapToPages = true;
            loc1.addEventListener("addedToStage", this.__favSetEditorScroller_addedToStage);
            loc1.addEventListener("scroll", this.__favSetEditorScroller_scroll);
            loc1.addEventListener("scrollComplete", this.__favSetEditorScroller_scrollComplete);
            loc1.id = "favSetEditorScroller";
            this.favSetEditorScroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "favSetEditorScroller", this.favSetEditorScroller);
            return loc1;
        }

        public function __favSetEditorScroller_addedToStage(arg1:starling.events.Event):void
        {
            this.favSetEditorScroller_addedToStageHandler(arg1);
            return;
        }

        public function __favSetEditorScroller_scroll(arg1:starling.events.Event):void
        {
            this.onScroll(arg1);
            return;
        }

        public function __favSetEditorScroller_scrollComplete(arg1:starling.events.Event):void
        {
            this.onScrollComplete(arg1);
            return;
        }

        internal function _DeviceSportprofileFavSetView_CustomPageIndicator1_i():frontend.components.CustomPageIndicator
        {
            var loc1:*=new frontend.components.CustomPageIndicator();
            loc1.gap = 25;
            loc1.addEventListener("change", this.__pageIndicator_change);
            loc1.id = "pageIndicator";
            this.pageIndicator = loc1;
            feathers.binding.BindingManager.executeBindings(this, "pageIndicator", this.pageIndicator);
            return loc1;
        }

        public function __pageIndicator_change(arg1:starling.events.Event):void
        {
            this.onPageIndicatorChanged(arg1);
            return;
        }

        internal function _DeviceSportprofileFavSetView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._DeviceSportprofileFavSetView_IconButton1_i(), this._DeviceSportprofileFavSetView_IconButton2_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _DeviceSportprofileFavSetView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSportprofileFavSetView_IconButton1";
            this._DeviceSportprofileFavSetView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileFavSetView_IconButton1", this._DeviceSportprofileFavSetView_IconButton1);
            return loc1;
        }

        internal function _DeviceSportprofileFavSetView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSportprofileFavSetView_IconButton2";
            this._DeviceSportprofileFavSetView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileFavSetView_IconButton2", this._DeviceSportprofileFavSetView_IconButton2);
            return loc1;
        }

        public function ___DeviceSportprofileFavSetView_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _DeviceSportprofileFavSetView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_DeviceSportprofileFavSetView_LayoutGroup1.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_DeviceSportprofileFavSetView_LayoutGroup1.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_DeviceSportprofileFavSetView_LayoutGroup1.width")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.CENTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileFavSetView_VerticalLayout1.horizontalAlign")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileFavSetView_VerticalLayout1.verticalAlign")
            result[5] = new feathers.binding.Binding(this, null, null, "activeCheckbox.checked", "active");
            result[6] = new feathers.binding.Binding(this, function ():Boolean
            {
                return favsetNr > 1;
            }, null, "activeCheckbox.editable")
            result[7] = new feathers.binding.Binding(this, function ():Boolean
            {
                return favsetNr > 1;
            }, null, "activeCheckbox.isEnabled")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_pageLabel;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "activeCheckbox.text")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "activeCheckbox.type")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_POLICY_ON;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "favSetEditorScroller.horizontalScrollPolicy")
            result[11] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.HorizontalLayout();
            }, null, "favSetEditorScroller.layout")
            result[12] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 100);
            }, null, "favSetEditorScroller.layoutData")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "favSetEditorScroller.pageWidth")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_BAR_DISPLAY_MODE_NONE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "favSetEditorScroller.scrollBarDisplayMode")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_POLICY_OFF;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "favSetEditorScroller.verticalScrollPolicy")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.Direction.HORIZONTAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "pageIndicator.direction")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.CENTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "pageIndicator.horizontalAlign")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.PageIndicatorInteractionMode.PRECISE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "pageIndicator.interactionMode")
            result[19] = new feathers.binding.Binding(this, function ():int
            {
                return _favSetMaxCount;
            }, null, "pageIndicator.pageCount")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "pageIndicator.verticalAlign")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.sportprofileTemplate;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileFavSetView_IconButton1.image")
            result[22] = new feathers.binding.Binding(this, function ():Function
            {
                return onChangeTemplateClick;
            }, null, "_DeviceSportprofileFavSetView_IconButton1.touchHandler")
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uploadicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileFavSetView_IconButton2.image")
            result[24] = new feathers.binding.Binding(this, function ():Function
            {
                return onUploadButtonClick;
            }, null, "_DeviceSportprofileFavSetView_IconButton2.touchHandler")
            return result;
        }

        public var _DeviceSportprofileFavSetView_IconButton1:frontend.components.button.IconButton;

        public var _DeviceSportprofileFavSetView_IconButton2:frontend.components.button.IconButton;

        public var _DeviceSportprofileFavSetView_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _DeviceSportprofileFavSetView_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _665806615activeCheckbox:frontend.components.menuList.MenuListItem;

        internal var _972775406favSetEditorScroller:frontend.components.scrollContainer.CustomHScrollContainer;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _643699648pageIndicator:frontend.components.CustomPageIndicator;

        internal var _1095383976changeFunction:Function;

        internal var _favsetNr:uint;

        public var sportprofile:core.sportprofiles.Sportprofile;

        internal var _favSetEditorsDataProvider:__AS3__.vec.Vector.<frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor>;

        internal var _857027729_favSetMaxCount:uint=0;

        internal var _623155162_pageLabel:String="";

        internal var _scrollIndex:uint=0;

        internal var _scrollPosition:Number=0;

        internal var favSetEditorsLoaded:Boolean=false;

        internal var _56421971verticalSeperatorLineVisible:Boolean;

        mx_internal var _watchers:Array;

        internal var _active:Boolean=true;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class DeviceSportprofileSettingsView
package frontend.screen.mydevices.sportprofiles 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import core.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import core.sportprofiles.*;
    import debug.*;
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.component.*;
    import utils.*;
    import utils.converter.*;
    import utils.format.*;
    
    public class DeviceSportprofileSettingsView extends frontend.screen.mydevices.sportprofiles.SportprofilesScreen
    {
        public function DeviceSportprofileSettingsView()
        {
            super();
            this.mxmlContent = [this._DeviceSportprofileSettingsView_Footer1_i()];
            return;
        }

        protected override function validateProperties():void
        {
            var distanceConverterAutoLap:utils.converter.DistanceConverter;
            var autoLapSpinner:frontend.components.menuList.MenuListItem;
            var basedOnDistanceItem:frontend.components.menuList.MenuListItem;
            var basedOnTimeItem:frontend.components.menuList.MenuListItem;
            var basedOnCaloriesItem:frontend.components.menuList.MenuListItem;
            var autoLapAllowed:Array;

            var loc1:*;
            autoLapSpinner = null;
            basedOnDistanceItem = null;
            basedOnTimeItem = null;
            basedOnCaloriesItem = null;
            autoLapAllowed = null;
            dataProvider.removeAll();
            distanceConverterAutoLap = new utils.converter.DistanceConverter(utils.format.DistanceFormat.MILLIMETER, core.MeasurementConfig.distanceFormat);
            title = sportprofile.profileName;
            if (sportprofile is core.settings.interfaces.IAutoPause) 
            {
                addListItem("DEVICE_SPORTPROFILES.AUTO_PAUSE", core.sportprofiles.SportprofileMapper.col_autoPause, (sportprofile as core.settings.interfaces.IAutoPause).autoPause, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (sportprofile is core.settings.interfaces.IAutoLap) 
            {
                autoLapAllowed = new Array();
                autoLapAllowed.push(core.general.AutoLap.OFF);
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnDistance) 
                {
                    autoLapAllowed.push(core.general.AutoLap.DISTANCE);
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnTime) 
                {
                    autoLapAllowed.push(core.general.AutoLap.TIME);
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnCalories) 
                {
                    autoLapAllowed.push(core.general.AutoLap.CALORIES);
                }
                autoLapSpinner = addListItem("SETTINGS_AUTOLAP_ACTIVE", core.sportprofiles.SportprofileMapper.col_autoLap, (sportprofile as core.settings.interfaces.IAutoLap).autoLap, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.AutoLapDataProvider.filter(autoLapAllowed));
                autoLapSpinner.saveCompleteCallback = function (arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
                {
                    debug.Debug.debug(arg2.value + " (" + arg2.rawValue + ") selected");
                    if (sportprofile is core.settings.interfaces.IAutoLapBasedOnDistance) 
                    {
                        basedOnDistanceItem.editable = arg2.rawValue == core.general.AutoLap.DISTANCE;
                    }
                    if (sportprofile is core.settings.interfaces.IAutoLapBasedOnTime) 
                    {
                        basedOnTimeItem.editable = arg2.rawValue == core.general.AutoLap.TIME;
                    }
                    if (sportprofile is core.settings.interfaces.IAutoLapBasedOnCalories) 
                    {
                        basedOnCaloriesItem.editable = arg2.rawValue == core.general.AutoLap.CALORIES;
                    }
                    apply(arg1, arg2);
                    return;
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnDistance) 
                {
                    basedOnDistanceItem = addListItemNumberInput("SETTINGS_AUTOLAP_BASEDON_DISTANCE", core.sportprofiles.SportprofileMapper.col_autoLapDistance, (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance, (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistanceMin, (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistanceMax, backend.utils.DataUtils.distanceFormatter, distanceConverterAutoLap, backend.utils.DataUtils.unitStringDistance);
                    basedOnDistanceItem.editable = (sportprofile as core.settings.interfaces.IAutoLap).autoLap == core.general.AutoLap.DISTANCE;
                    basedOnDistanceItem.minimum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistanceMin;
                    basedOnDistanceItem.maximum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistanceMax;
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnTime) 
                {
                    basedOnTimeItem = addListItem("SETTINGS_AUTOLAP_BASEDON_TIME", core.sportprofiles.SportprofileMapper.col_autoLapTime, (sportprofile as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME, null, backend.utils.DataUtils.autoLapTimeFormatter, false, utils.LanguageManager.getString("UNIT_HOUR"));
                    basedOnTimeItem.editable = (sportprofile as core.settings.interfaces.IAutoLap).autoLap == core.general.AutoLap.TIME;
                    basedOnTimeItem.minimum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTimeMin;
                    basedOnTimeItem.maximum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTimeMax;
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnCalories) 
                {
                    basedOnCaloriesItem = addListItem("SETTINGS_AUTOLAP_BASEDON_CALORIES", core.sportprofiles.SportprofileMapper.col_autoLapCalories, (sportprofile as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER, null, backend.utils.DataUtils.caloriesFormatter, false, backend.utils.DataUtils.unitStringCalories);
                    basedOnCaloriesItem.editable = (sportprofile as core.settings.interfaces.IAutoLap).autoLap == core.general.AutoLap.CALORIES;
                    basedOnCaloriesItem.minimum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCaloriesMin;
                    basedOnCaloriesItem.maximum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCaloriesMax;
                }
            }
            return;
        }

        internal function _DeviceSportprofileSettingsView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", footer);
            return loc1;
        }
    }
}


//  class DeviceSportprofileView
package frontend.screen.mydevices.sportprofiles 
{
    import core.settings.interfaces.*;
    import core.sport.*;
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.data.*;
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
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.popup.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class DeviceSportprofileView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSportprofileView()
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
            bindings = this._DeviceSportprofileView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_DeviceSportprofileViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSportprofileView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._DeviceSportprofileView_CustomVScrollContainer1_i(), this._DeviceSportprofileView_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get menuList():frontend.components.menuList.MenuList
        {
            return this._604015971menuList;
        }

        public function set menuList(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._604015971menuList;
            if (loc1 !== arg1) 
            {
                this._604015971menuList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "menuList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scroller():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._402164678scroller;
        }

        public function set scroller(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._402164678scroller;
            if (loc1 !== arg1) 
            {
                this._402164678scroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scroller", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _saveNameObj():frontend.components.menuList.MenuListDbObject
        {
            return this._1790552176_saveNameObj;
        }

        internal function set _saveNameObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1790552176_saveNameObj;
            if (loc1 !== arg1) 
            {
                this._1790552176_saveNameObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveNameObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _saveSportObj():frontend.components.menuList.MenuListDbObject
        {
            return this._294660959_saveSportObj;
        }

        internal function set _saveSportObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._294660959_saveSportObj;
            if (loc1 !== arg1) 
            {
                this._294660959_saveSportObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveSportObj", loc1, arg1, this);
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
            DeviceSportprofileView._watcherSetupUtil = arg1;
            return;
        }

        internal function onNameChanged(arg1:Object):void
        {
            var loc1:*;
            this.sportprofile.profileName = loc1 = arg1 as String;
            title = loc1;
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        internal function onSportChanged(arg1:Object):void
        {
            this.sportprofile.sportId = arg1 as uint;
            this.validateSportsItem();
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        protected override function validateProperties():void
        {
            var loc3:*=0;
            var loc7:*=null;
            this.menuList.removeChildren();
            title = this.sportprofile.profileName;
            var loc1:*=new frontend.components.menuList.MenuListHeadline();
            loc1.useLocalesForText = false;
            loc1.text = this.sportprofile.unit.externalName;
            this.menuList.addChild(loc1);
            this._saveNameObj = new frontend.components.menuList.MenuListDbObject();
            this._saveNameObj.keyField = "GUID";
            this._saveNameObj.keyValue = this.sportprofile.GUID;
            this._saveNameObj.updateField = core.sportprofiles.SportprofileMapper.col_profileName;
            this._saveNameObj.table = core.sportprofiles.SportprofileMapper.TABLE_NAME;
            this._saveNameObj.updateModificationDate = true;
            this._saveNameObj.completeCallback = this.onNameChanged;
            var loc2:*=new frontend.components.menuList.MenuListItem();
            loc2.defaultValue = this.sportprofile.profileName;
            loc2.editable = true;
            loc2.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc2.saveToDbUseUpdate = true;
            loc2.saveToDbUseUpdateObject = this._saveNameObj;
            loc2.text = "DEVICE_SPORTPROFILE.NAME";
            loc2.title = "DEVICE_SPORTPROFILE.NAME";
            loc2.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
            loc2.useConfigCache = false;
            loc2.useLocalesForText = true;
            loc2.useLocalesForTitle = true;
            this.menuList.addChild(loc2);
            var loc4:*=handler.SportHandler.getInstance().sports.length;
            var loc5:*=new feathers.data.ListCollection();
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (handler.SportHandler.getInstance().sports[loc3].keyName != core.sport.Sport.ACTIVITY_TRACKER) 
                {
                    loc5.push({"label":handler.SportHandler.getInstance().sports[loc3].name, "data":handler.SportHandler.getInstance().sports[loc3].sportId, "selected":handler.SportHandler.getInstance().sports[loc3].sportId == this.sportprofile.sportId});
                }
                ++loc3;
            }
            this._saveSportObj = new frontend.components.menuList.MenuListDbObject();
            this._saveSportObj.keyField = "GUID";
            this._saveSportObj.keyValue = this.sportprofile.GUID;
            this._saveSportObj.updateField = core.sportprofiles.SportprofileMapper.col_sportId;
            this._saveSportObj.table = core.sportprofiles.SportprofileMapper.TABLE_NAME;
            this._saveSportObj.updateModificationDate = true;
            this._saveSportObj.completeCallback = this.onSportChanged;
            this.sportsItem = new frontend.components.menuList.MenuListItem();
            this.sportsItem.dataProvider = loc5;
            this.sportsItem.defaultValue = this.sportprofile.sportId;
            this.sportsItem.editable = true;
            this.sportsItem.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            this.sportsItem.saveToDbUseUpdate = true;
            this.sportsItem.saveToDbUseUpdateObject = this._saveSportObj;
            this.sportsItem.text = "ACTIVITYVIEW.EDIT_SPORT";
            this.sportsItem.title = "ACTIVITYVIEW.EDIT_SPORT";
            this.sportsItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT;
            this.sportsItem.useConfigCache = false;
            this.sportsItem.useLocalesForText = true;
            this.sportsItem.useLocalesForTitle = true;
            this.validateSportsItem();
            this.menuList.addChild(this.sportsItem);
            var loc6:*=new frontend.components.menuList.MenuListItem();
            loc6.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
            loc6.destination = handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_SETTINGS;
            loc6.destinationObject = {"sportprofile":this.sportprofile};
            loc6.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc6.text = "DEVICE_SPORTPROFILE.SETTINGS";
            this.menuList.addChild(loc6);
            if (this.sportprofile is core.settings.interfaces.IFavSets) 
            {
                loc4 = (this.sportprofile as core.settings.interfaces.IFavSets).favSetMaxCount;
                loc3 = 1;
                while (loc3 <= loc4) 
                {
                    loc7 = new frontend.components.menuList.MenuListItem();
                    loc7.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                    loc7.destination = handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET;
                    loc7.destinationObject = {"sportprofile":this.sportprofile, "favsetNr":loc3};
                    loc7.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                    loc7.useLocalesForText = false;
                    loc7.text = utils.LanguageManager.getString("DEVICE_SPORTPROFILE.FAVSET") + " " + loc3;
                    this.menuList.addChild(loc7);
                    ++loc3;
                }
            }
            return;
        }

        internal function validateSportsItem():void
        {
            var loc3:*=0;
            var loc6:*=null;
            this.sportsItem.customLayoutContent.removeChildren();
            this.sportsItem.customLayoutContent.visible = true;
            this.sportsItem.customLayoutContent.includeInLayout = true;
            this.sportsItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.requestedColumnCount = 1;
            loc1.useSquareTiles = false;
            loc1.horizontalGap = this.sportsItem.padding;
            loc1.verticalGap = this.sportsItem.padding;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.paddingRight = this.sportsItem.padding;
            var loc2:*=new frontend.components.SportIcon();
            loc2.sportId = 1;
            loc2.validate();
            loc1.typicalItem = loc2;
            loc1.typicalItemHeight = loc2.height;
            loc1.typicalItemWidth = loc2.width;
            this.sportsItem.customLayoutContent.width = loc1.requestedColumnCount * loc1.typicalItemWidth + (loc1.requestedColumnCount + 1) * this.sportsItem.padding;
            var loc4:*=this.sportsItem.dataProvider.length;
            var loc5:*=[];
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if (this.sportsItem.dataProvider.getItemAt(loc3).data == this.sportprofile.sportId) 
                {
                    loc6 = new frontend.components.SportIcon();
                    loc6.sportId = this.sportsItem.dataProvider.getItemAt(loc3).data;
                    this.sportsItem.customLayoutContent.addChild(loc6);
                }
                ++loc3;
            }
            loc1.requestedRowCount = Math.max(1, Math.ceil(this.sportsItem.customLayoutContent.numChildren / loc1.requestedColumnCount));
            this.sportsItem.customLayoutContent.layout = loc1;
            this.sportsItem.height = loc1.requestedRowCount * this.sportsItem.minItemHeight;
            this.sportsItem.customLayoutContent.height = this.sportsItem.height;
            return;
        }

        internal function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES_TRANSFER, {"unit":this.sportprofile.unit, "sportprofile":this.sportprofile, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _DeviceSportprofileView_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._DeviceSportprofileView_MenuList1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _DeviceSportprofileView_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "menuList";
            this.menuList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "menuList", this.menuList);
            return loc1;
        }

        internal function _DeviceSportprofileView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._DeviceSportprofileView_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _DeviceSportprofileView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSportprofileView_IconButton1";
            this._DeviceSportprofileView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileView_IconButton1", this._DeviceSportprofileView_IconButton1);
            return loc1;
        }

        internal function _DeviceSportprofileView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "menuList.width")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uploadicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileView_IconButton1.image")
            result[4] = new feathers.binding.Binding(this, function ():Function
            {
                return toDevice_handler;
            }, null, "_DeviceSportprofileView_IconButton1.touchHandler")
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

        internal static const padding:Number=20 * SIGMALink.scaleFactor;

        public var _DeviceSportprofileView_IconButton1:frontend.components.button.IconButton;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _604015971menuList:frontend.components.menuList.MenuList;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        public var sportprofile:core.sportprofiles.Sportprofile;

        internal var _1790552176_saveNameObj:frontend.components.menuList.MenuListDbObject;

        internal var _294660959_saveSportObj:frontend.components.menuList.MenuListDbObject;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var sportsItem:frontend.components.menuList.MenuListItem;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class FavsetLayoutBase
package frontend.screen.mydevices.sportprofiles 
{
    import core.general.*;
    import core.sportprofiles.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class FavsetLayoutBase extends feathers.controls.LayoutGroup
    {
        public function FavsetLayoutBase()
        {
            this._1670629978defaultFunctions = [];
            this._80214450hLayout = new feathers.layout.HorizontalLayout();
            this._379635904vLayout = new feathers.layout.VerticalLayout();
            super();
            this.hLayout.padding = 0;
            this.hLayout.gap = this.gap;
            this.hLayout.verticalAlign = feathers.layout.VerticalAlign.TOP;
            this.hLayout.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this.vLayout.padding = 0;
            this.vLayout.gap = this.gap;
            this.vLayout.verticalAlign = feathers.layout.VerticalAlign.TOP;
            this.vLayout.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            layoutData = new feathers.layout.VerticalLayoutData(100, 100);
            layout = new feathers.layout.VerticalLayout();
            (layout as feathers.layout.VerticalLayout).padding = 0;
            (layout as feathers.layout.VerticalLayout).gap = this.gap;
            (layout as feathers.layout.VerticalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            (layout as feathers.layout.VerticalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            return;
        }

        public function get padding():Number
        {
            return this._padding;
        }

        public function set padding(arg1:Number):void
        {
            this._padding = arg1;
            if (layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).padding = this.padding;
            }
            if (layout is feathers.layout.HorizontalLayout) 
            {
                (layout as feathers.layout.HorizontalLayout).padding = this.padding;
            }
            return;
        }

        public function set touchFunction(arg1:Function):void
        {
            this._touchFunction = arg1;
            if (this.touchFunction == null) 
            {
                this.removeEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            }
            else 
            {
                this.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            }
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        protected function set defaultFunctions(arg1:Array):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1670629978defaultFunctions;
            if (loc1 !== arg1) 
            {
                this._1670629978defaultFunctions = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "defaultFunctions", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        internal function set _102102gap(arg1:Number):void
        {
            this._gap = arg1;
            if (this.hLayout != null) 
            {
                this.hLayout.gap = this.gap;
            }
            if (this.vLayout != null) 
            {
                this.vLayout.gap = this.gap;
            }
            if (layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).gap = this.gap;
            }
            if (layout is feathers.layout.HorizontalLayout) 
            {
                (layout as feathers.layout.HorizontalLayout).gap = this.gap;
            }
            return;
        }

        internal function set _1191572123selected(arg1:Boolean):void
        {
            this._selected = arg1;
            backgroundSkin = new starling.display.Quad(1, 1, this.selected ? core.general.Colors.RED : core.general.Colors.GREY);
            return;
        }

        protected function onFavsetBoxTouched(arg1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox):void
        {
            if (this.favsetBoxTouchFunction != null) 
            {
                this.favsetBoxTouchFunction(arg1);
            }
            return;
        }

        public function get touchFunction():Function
        {
            return this._touchFunction;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.touchFunction != null) 
            {
                this.favFunctionList = new core.sportprofiles.FavFunctionList();
                this.setDefaultFavFunctionList(this.templateId);
                this.touchFunction(this);
            }
            return;
        }

        public function setDefaultFavFunctionList(arg1:uint):void
        {
            var loc1:*=undefined;
            if (this.defaultFunctions == null || this.defaultFunctions.length <= 0 || this.favFunctionList == null) 
            {
                return;
            }
            this.favFunctionList.templateId = this.templateId;
            this.favFunctionList.resetFavFunctions();
            var loc2:*=0;
            var loc3:*=this.defaultFunctions;
            for (loc1 in loc3) 
            {
                if (!(loc1 > 0)) 
                {
                    continue;
                }
                this.favFunctionList.changeFavFunction(new core.sportprofiles.FavFunctionlistItem(this.defaultFunctions[loc1] as uint, loc1));
            }
            debug.Debug.debug("Neue FavFunctionList (Default-Werte): " + this.favFunctionList.toJson());
            return;
        }

        public function get editable():Boolean
        {
            return this._1602416228editable;
        }

        public function set editable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1602416228editable;
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

        public function get favFunctionList():core.sportprofiles.FavFunctionList
        {
            return this._1342962513favFunctionList;
        }

        public function set favFunctionList(arg1:core.sportprofiles.FavFunctionList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1342962513favFunctionList;
            if (loc1 !== arg1) 
            {
                this._1342962513favFunctionList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "favFunctionList", loc1, arg1, this);
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

        public function set selected(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.selected;
            if (loc1 !== arg1) 
            {
                this._1191572123selected = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "selected", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
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

        protected function get defaultFunctions():Array
        {
            return this._1670629978defaultFunctions;
        }

        protected function get hLayout():feathers.layout.HorizontalLayout
        {
            return this._80214450hLayout;
        }

        protected function set hLayout(arg1:feathers.layout.HorizontalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._80214450hLayout;
            if (loc1 !== arg1) 
            {
                this._80214450hLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get vLayout():feathers.layout.VerticalLayout
        {
            return this._379635904vLayout;
        }

        protected function set vLayout(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._379635904vLayout;
            if (loc1 !== arg1) 
            {
                this._379635904vLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static const FAVSET_DEFAULT_GAP:Number=2;

        internal var _1342962513favFunctionList:core.sportprofiles.FavFunctionList;

        public var favsetBoxTouchFunction:Function;

        public var label:String;

        public var numberOfFunctions:uint=0;

        internal var _padding:Number=0;

        internal var _selected:Boolean=false;

        public var templateId:uint;

        internal var _touchFunction:Function;

        internal var _gap:Number=2;

        internal var _1921447433showLabel:Boolean=true;

        protected var _80214450hLayout:feathers.layout.HorizontalLayout;

        protected var _379635904vLayout:feathers.layout.VerticalLayout;

        public var dataProvider:Array;

        internal var _1602416228editable:Boolean=false;

        protected var _1670629978defaultFunctions:Array;
    }
}


//  class SportprofilesScreen
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import core.sportprofiles.*;
    import feathers.data.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.mydevices.list.*;
    import handler.*;
    import service.cloud.*;
    import starling.events.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class SportprofilesScreen extends frontend.screen.mydevices.list.MenuItemListScreen
    {
        public function SportprofilesScreen()
        {
            super();
            allowCaching = false;
            savePropertiesForBackNavigation = true;
            return;
        }

        protected override function addListItem(arg1:String, arg2:String, arg3:Object, arg4:String, arg5:feathers.data.ListCollection=null, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItem(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            loc1.saveCompleteCallback = this.onSportprofileChanged;
            return loc1;
        }

        protected override function addFavListItem(arg1:String, arg2:String, arg3:Object, arg4:feathers.data.ListCollection):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addFavListItem(arg1, arg2, arg3, arg4);
            loc1.saveCompleteCallback = this.onFavSettingsChanged;
            return loc1;
        }

        protected override function addListItemNumberInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:utils.converter.IConverter=null, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemNumberInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            loc1.saveCompleteCallback = this.onSportprofileChanged;
            return loc1;
        }

        protected override function addListItemDateInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemDateInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            loc1.saveCompleteCallback = this.onSportprofileChanged;
            return loc1;
        }

        protected override function addListItemZoneInput(arg1:String, arg2:String, arg3:String, arg4:Object, arg5:Number, arg6:Number, arg7:Number, arg8:utils.interfaces.ICustomFormatterBase, arg9:utils.converter.IConverter, arg10:Boolean, arg11:int, arg12:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemZoneInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
            if (loc1.editable) 
            {
                loc1.saveCompleteCallback = this.onSportprofileChanged;
            }
            return loc1;
        }

        protected override function getDBObject(arg1:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=super.getDBObject(arg1);
            loc1.keyField = core.sportprofiles.SportprofileMapper.col_GUID;
            loc1.keyValue = this.sportprofile.GUID;
            loc1.table = core.sportprofiles.SportprofileMapper.TABLE_NAME;
            loc1.classAttributeName = arg1;
            return loc1;
        }

        protected override function getMultiDBObject(arg1:String, arg2:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=super.getMultiDBObject(arg1, arg2);
            loc1.keyField = core.sportprofiles.SportprofileMapper.col_GUID;
            loc1.keyValue = this.sportprofile.GUID;
            loc1.table = core.sportprofiles.SportprofileMapper.TABLE_NAME;
            return loc1;
        }

        protected function onSportprofileChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.apply(arg1, arg2);
            return;
        }

        public function apply(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            if (arg1.saveToDbUseUpdateObject.classAttributeName.length > 0) 
            {
                this.sportprofile[arg1.saveToDbUseUpdateObject.classAttributeName] = arg2.rawValue;
            }
            else 
            {
                this.sportprofile[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
            }
            var loc1:*=dataProvider.getItemIndex(arg1);
            dataProvider.updateItemAt(loc1);
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        protected function onFavSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            return;
        }

        protected override function createFooterButtons():void
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.image = frontend.Textures.uploadicon;
            loc1.touchHandler = this.toDevice_handler;
            var loc2:*=new Vector.<frontend.components.button.IconButton>();
            loc2.push(loc1);
            footer.setButtonGroup(loc2);
            return;
        }

        internal function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES_TRANSFER, {"unit":this.sportprofile.unit, "sportprofile":this.sportprofile, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        public var sportprofile:core.sportprofiles.Sportprofile;
    }
}


//  class SportprofilesSelector
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.sportprofiles.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.core.*;
    import feathers.data.*;
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
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.list.*;
    import handler.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class SportprofilesSelector extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function SportprofilesSelector()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.toggleGroup = new feathers.core.ToggleGroup();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._SportprofilesSelector_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_SportprofilesSelectorWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return SportprofilesSelector[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._SportprofilesSelector_LayoutGroup1_i(), this._SportprofilesSelector_Footer1_i()];
            this.addEventListener("addedToStage", this.___SportprofilesSelector_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___SportprofilesSelector_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get row1():feathers.controls.LayoutGroup
        {
            return this._3506583row1;
        }

        public function set row1(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3506583row1;
            if (loc1 !== arg1) 
            {
                this._3506583row1 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "row1", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get download():Boolean
        {
            return this._1427818632download;
        }

        public function set download(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1427818632download;
            if (loc1 !== arg1) 
            {
                this._1427818632download = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "download", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _sportprofilesDataProvider():feathers.data.ListCollection
        {
            return this._852377274_sportprofilesDataProvider;
        }

        protected function set _sportprofilesDataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._852377274_sportprofilesDataProvider;
            if (loc1 !== arg1) 
            {
                this._852377274_sportprofilesDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_sportprofilesDataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _customList():frontend.components.list.CustomList
        {
            return this._493623986_customList;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this._customList = new frontend.components.list.CustomList();
            this._customList.height = frontend.components.menuList.MenuList.ROW_HEIGHT * 3;
            this._customList.width = SIGMALink.appWidth;
            this._customList.allowMultipleSelection = false;
            this._customList.autoHideBackground = false;
            this._customList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._listStateHandler = new frontend.components.list.ListStateHandler(this._customList);
            return;
        }

        internal function set _customList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._493623986_customList;
            if (loc1 !== arg1) 
            {
                this._493623986_customList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_customList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _listTitle():String
        {
            return this._1571499739_listTitle;
        }

        internal function set _listTitle(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1571499739_listTitle;
            if (loc1 !== arg1) 
            {
                this._1571499739_listTitle = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_listTitle", loc1, arg1, this);
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
            SportprofilesSelector._watcherSetupUtil = arg1;
            return;
        }

        internal static function get ROW_PADDING():Number
        {
            return SportprofilesSelector._25669012ROW_PADDING;
        }

        internal static function set ROW_PADDING(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=SportprofilesSelector._25669012ROW_PADDING;
            if (loc1 !== arg1) 
            {
                SportprofilesSelector._25669012ROW_PADDING = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_PADDING", loc1, arg1, SportprofilesSelector);
                loc3 = SportprofilesSelector.staticEventDispatcher;
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
            _25669012ROW_PADDING = 15 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        protected function onResizeRow(arg1:starling.events.Event):void
        {
            this.listLoader.height = SIGMALink.containerHeight - this.row1.height;
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            var loc1:*=0;
            var loc3:*=null;
            this.sportprofiles = (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.ISportProfiles).loadedSportProfiles;
            var loc2:*=this.sportprofiles.length;
            this._sportprofilesDataProvider = new feathers.data.ListCollection();
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = new frontend.screen.mydevices.list.MyDeviceSportprofilesListItem();
                loc3.sportprofile = this.sportprofiles[loc1];
                this._sportprofilesDataProvider.push(loc3);
                ++loc1;
            }
            if (this.download) 
            {
                this._listTitle = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SPORT_PROFILES_SELECT_PROFILE_DOWNLOAD");
                this._customList.itemRendererFactory = this.sportprofileMultiSelectItemRenderer;
            }
            else 
            {
                this._listTitle = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SPORT_PROFILES_SELECT_PROFILE");
                this._customList.itemRendererFactory = this.sportprofileSingleSelectItemRenderer;
            }
            this._customList.dataProvider = this._sportprofilesDataProvider;
            this.listLoader.checkDataProvider();
            return;
        }

        internal function sportprofileMultiSelectItemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.list.MyDeviceSportprofilesRenderer();
            loc1.isEditState(true);
            loc1.allowMultiSelection = true;
            return loc1;
        }

        internal function sportprofileSingleSelectItemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.list.MyDeviceSportprofilesRenderer();
            loc1.isEditState(true);
            loc1.allowMultiSelection = false;
            loc1.toggleGroup = this.toggleGroup;
            return loc1;
        }

        internal function nextStepSave(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            if (this.download) 
            {
                loc2 = this._sportprofilesDataProvider.length;
                this.sportprofiles = new Vector.<core.sportprofiles.Sportprofile>();
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if ((this._sportprofilesDataProvider.getItemAt(loc1) as frontend.screen.mydevices.list.MyDeviceSportprofilesListItem).isSelected()) 
                    {
                        this.sportprofiles.push((this._sportprofilesDataProvider.getItemAt(loc1) as frontend.screen.mydevices.list.MyDeviceSportprofilesListItem).sportprofile);
                        (this._sportprofilesDataProvider.getItemAt(loc1) as frontend.screen.mydevices.list.MyDeviceSportprofilesListItem).removeSelection();
                    }
                    ++loc1;
                }
                this.saveNextSportprofile();
            }
            else 
            {
                loc2 = this._sportprofilesDataProvider.length;
                loc3 = 0;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if (frontend.components.list.SelectableListItem.isGUIDSelected((this._sportprofilesDataProvider.getItemAt(loc1) as frontend.screen.mydevices.list.MyDeviceSportprofilesListItem).sportprofile.GUID)) 
                    {
                        loc3 = loc1;
                        break;
                    }
                    ++loc1;
                }
                (this.unit as core.units.interfaces.ISportProfiles).currentSportProfileIndex = loc3;
                (this.unit as core.units.interfaces.ISportProfiles).loadedSportProfiles[loc3] = this.sportprofileToUpload;
                this._listStateHandler.setNormalState();
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES_TRANSFER, {"unit":this.unit, "sportprofile":this.sportprofileToUpload, "transferModeDownload":false, "sportprofilesPreloadedFromDevice":false}, handler.ViewHandler.slideToLeftTransition());
            }
            return;
        }

        internal function saveNextSportprofile():void
        {
            var loc1:*=null;
            if (this.sportprofiles.length > 0) 
            {
                loc1 = this.sportprofiles.shift();
                loc1.unit = this.unit;
                loc1.unitGUID = this.unit.GUID;
                handler.AppDeviceHandler.getInstance().saveSportprofile(new backend.utils.dbUtils.DBUtilObject(loc1, this.onInsertDataComplete, this.onInsertDataError, null));
            }
            else 
            {
                handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
                this.goBackSwitch();
            }
            return;
        }

        protected function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            if (this.sportprofiles.length > 0) 
            {
                this.saveNextSportprofile();
            }
            else 
            {
                handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
                this.goBackSwitch();
            }
            return;
        }

        protected function onInsertDataError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertDataError: " + arg1.toString());
            return;
        }

        protected function goBackSwitch():void
        {
            this._listStateHandler.setNormalState();
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function _SportprofilesSelector_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._SportprofilesSelector_VerticalLayout1_c();
            loc1.mxmlContent = [this._SportprofilesSelector_LayoutGroup2_i(), this._SportprofilesSelector_ListLoader1_i()];
            loc1.id = "_SportprofilesSelector_LayoutGroup1";
            this._SportprofilesSelector_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_SportprofilesSelector_LayoutGroup1", this._SportprofilesSelector_LayoutGroup1);
            return loc1;
        }

        internal function _SportprofilesSelector_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            loc1.useVirtualLayout = true;
            return loc1;
        }

        internal function _SportprofilesSelector_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._SportprofilesSelector_Label1_i()];
            loc1.addEventListener("resize", this.__row1_resize);
            loc1.id = "row1";
            this.row1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "row1", this.row1);
            return loc1;
        }

        internal function _SportprofilesSelector_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_SportprofilesSelector_Label1";
            this._SportprofilesSelector_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_SportprofilesSelector_Label1", this._SportprofilesSelector_Label1);
            return loc1;
        }

        public function __row1_resize(arg1:starling.events.Event):void
        {
            this.onResizeRow(arg1);
            return;
        }

        internal function _SportprofilesSelector_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        internal function _SportprofilesSelector_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._SportprofilesSelector_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _SportprofilesSelector_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.touchHandler = this.nextStepSave;
            loc1.id = "nextButton";
            this.nextButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "nextButton", this.nextButton);
            return loc1;
        }

        public function ___SportprofilesSelector_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___SportprofilesSelector_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _SportprofilesSelector_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_SPORTPROFILES_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_SportprofilesSelector_LayoutGroup1.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_SportprofilesSelector_LayoutGroup1.height")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_SportprofilesSelector_LayoutGroup1.width")
            result[4] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "row1.backgroundSkin")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            }, null, "row1.height")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "row1.layout")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "row1.width")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ROW_PADDING, NaN, 0);
            }, null, "_SportprofilesSelector_Label1.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_SportprofilesSelector_Label1.styleName")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_listTitle;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_SportprofilesSelector_Label1.text")
            result[11] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _customList;
            }, null, "listLoader.list")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=download ? frontend.Textures.saveiconwhite : frontend.Textures.arrowRight;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "nextButton.image")
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

        public function get listLoader():frontend.components.list.ListLoader
        {
            return this._159473233listLoader;
        }

        public function set listLoader(arg1:frontend.components.list.ListLoader):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._159473233listLoader;
            if (loc1 !== arg1) 
            {
                this._159473233listLoader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listLoader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get nextButton():frontend.components.button.IconButton
        {
            return this._1749722107nextButton;
        }

        public function set nextButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1749722107nextButton;
            if (loc1 !== arg1) 
            {
                this._1749722107nextButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "nextButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var _SportprofilesSelector_Label1:feathers.controls.Label;

        public var _SportprofilesSelector_LayoutGroup1:feathers.controls.LayoutGroup;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        internal var _1749722107nextButton:frontend.components.button.IconButton;

        internal var _3506583row1:feathers.controls.LayoutGroup;

        internal var _1427818632download:Boolean=true;

        public var sportprofiles:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        public var unit:core.units.Unit;

        protected var _852377274_sportprofilesDataProvider:feathers.data.ListCollection;

        internal var _493623986_customList:frontend.components.list.CustomList;

        internal var _listStateHandler:frontend.components.list.ListStateHandler;

        internal var _1571499739_listTitle:String="";

        internal var toggleGroup:feathers.core.ToggleGroup;

        public var sportprofileToUpload:core.sportprofiles.Sportprofile;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _25669012ROW_PADDING:Number;
    }
}


