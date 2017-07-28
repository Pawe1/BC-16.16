//class FavSetLayout14
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


