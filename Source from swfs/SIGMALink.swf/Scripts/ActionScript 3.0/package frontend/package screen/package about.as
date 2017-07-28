//package about
//  class About
package frontend.screen.about 
{
    import core.general.*;
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
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
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
    
    public class About extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function About()
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
            bindings = this._About_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_about_AboutWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return About[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._About_CustomVScrollContainer1_i(), this._About_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _About_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_VerticalLayout4_i();
            loc1.mxmlContent = [this._About_LayoutGroup6_i(), this._About_LayoutGroup7_i()];
            loc1.id = "_About_LayoutGroup5";
            this._About_LayoutGroup5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup5", this._About_LayoutGroup5);
            return loc1;
        }

        internal function _About_VerticalLayout4_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._About_VerticalLayout4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_VerticalLayout4", this._About_VerticalLayout4);
            return loc1;
        }

        internal function _About_LayoutGroup6_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._About_Label5_i(), this._About_Label6_i()];
            loc1.id = "_About_LayoutGroup6";
            this._About_LayoutGroup6 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup6", this._About_LayoutGroup6);
            return loc1;
        }

        internal function _About_Label5_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label5";
            this._About_Label5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label5", this._About_Label5);
            return loc1;
        }

        internal function _About_Label6_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label6";
            this._About_Label6 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label6", this._About_Label6);
            return loc1;
        }

        internal function _About_LayoutGroup7_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._About_Label7_i(), this._About_Label8_i()];
            loc1.id = "_About_LayoutGroup7";
            this._About_LayoutGroup7 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup7", this._About_LayoutGroup7);
            return loc1;
        }

        internal function _About_Label7_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label7";
            this._About_Label7 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label7", this._About_Label7);
            return loc1;
        }

        internal function _About_Label8_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label8";
            this._About_Label8 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label8", this._About_Label8);
            return loc1;
        }

        internal function _About_LayoutGroup8_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_VerticalLayout5_i();
            loc1.mxmlContent = [this._About_LayoutGroup9_i(), this._About_LayoutGroup10_i()];
            loc1.id = "_About_LayoutGroup8";
            this._About_LayoutGroup8 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup8", this._About_LayoutGroup8);
            return loc1;
        }

        internal function _About_VerticalLayout5_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._About_VerticalLayout5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_VerticalLayout5", this._About_VerticalLayout5);
            return loc1;
        }

        internal function _About_LayoutGroup9_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._About_Label9_i(), this._About_Label10_i()];
            loc1.id = "_About_LayoutGroup9";
            this._About_LayoutGroup9 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup9", this._About_LayoutGroup9);
            return loc1;
        }

        internal function _About_Label9_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label9";
            this._About_Label9 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label9", this._About_Label9);
            return loc1;
        }

        internal function _About_Label10_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label10";
            this._About_Label10 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label10", this._About_Label10);
            return loc1;
        }

        internal function _About_LayoutGroup10_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.touchGroup = true;
            loc1.mxmlContent = [this._About_Label11_i(), this._About_Label12_i()];
            loc1.addEventListener("touch", this.___About_LayoutGroup10_touch);
            loc1.id = "_About_LayoutGroup10";
            this._About_LayoutGroup10 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup10", this._About_LayoutGroup10);
            return loc1;
        }

        internal function _About_Label12_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label12";
            this._About_Label12 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label12", this._About_Label12);
            return loc1;
        }

        public function ___About_LayoutGroup10_touch(arg1:starling.events.TouchEvent):void
        {
            this.onLinkClick(arg1);
            return;
        }

        internal function _About_LayoutGroup11_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_HorizontalLayout2_i();
            loc1.mxmlContent = [this._About_Label13_i()];
            loc1.id = "_About_LayoutGroup11";
            this._About_LayoutGroup11 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup11", this._About_LayoutGroup11);
            return loc1;
        }

        internal function _About_HorizontalLayout2_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._About_HorizontalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_HorizontalLayout2", this._About_HorizontalLayout2);
            return loc1;
        }

        internal function _About_Label13_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label13";
            this._About_Label13 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label13", this._About_Label13);
            return loc1;
        }

        internal function _About_LayoutGroup12_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_HorizontalLayout3_i();
            loc1.mxmlContent = [this._About_Button1_i()];
            loc1.id = "_About_LayoutGroup12";
            this._About_LayoutGroup12 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup12", this._About_LayoutGroup12);
            return loc1;
        }

        internal function _About_Label11_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label11";
            this._About_Label11 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label11", this._About_Label11);
            return loc1;
        }

        internal function _About_HorizontalLayout3_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._About_HorizontalLayout3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_HorizontalLayout3", this._About_HorizontalLayout3);
            return loc1;
        }

        internal function _About_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("touch", this.___About_Button1_touch);
            loc1.id = "_About_Button1";
            this._About_Button1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Button1", this._About_Button1);
            return loc1;
        }

        public function ___About_Button1_touch(arg1:starling.events.TouchEvent):void
        {
            this.onFeedbackClick(arg1);
            return;
        }

        internal function _About_LayoutGroup13_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_AnchorLayout2_c();
            loc1.mxmlContent = [this._About_Label14_i()];
            loc1.id = "_About_LayoutGroup13";
            this._About_LayoutGroup13 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup13", this._About_LayoutGroup13);
            return loc1;
        }

        internal function _About_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _About_Label14_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label14";
            this._About_Label14 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label14", this._About_Label14);
            return loc1;
        }

        internal function _About_LayoutGroup14_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_VerticalLayout6_i();
            loc1.mxmlContent = [this._About_Label15_i(), this._About_Label16_i(), this._About_Label17_i(), this._About_Label18_i(), this._About_Label19_i(), this._About_Label20_i(), this._About_Label21_i(), this._About_Label22_i(), this._About_Label23_i(), this._About_Label24_i(), this._About_Label25_i(), this._About_Label26_i(), this._About_Label27_i(), this._About_Label28_i(), this._About_Label29_i(), this._About_Label30_i(), this._About_Label31_i(), this._About_Label32_i(), this._About_Label33_i(), this._About_Label34_i(), this._About_Label35_i(), this._About_Label36_i(), this._About_Label37_i(), this._About_Label38_i(), this._About_Label39_i(), this._About_Label40_i(), this._About_Label41_i(), this._About_Label42_i()];
            loc1.id = "_About_LayoutGroup14";
            this._About_LayoutGroup14 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup14", this._About_LayoutGroup14);
            return loc1;
        }

        internal function _About_VerticalLayout6_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._About_VerticalLayout6 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_VerticalLayout6", this._About_VerticalLayout6);
            return loc1;
        }

        internal function _About_Label15_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label15";
            this._About_Label15 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label15", this._About_Label15);
            return loc1;
        }

        internal function _About_Label16_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label16";
            this._About_Label16 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label16", this._About_Label16);
            return loc1;
        }

        internal function _About_Label17_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label17";
            this._About_Label17 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label17", this._About_Label17);
            return loc1;
        }

        internal function _About_Label18_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label18";
            this._About_Label18 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label18", this._About_Label18);
            return loc1;
        }

        internal function _About_Label19_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label19";
            this._About_Label19 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label19", this._About_Label19);
            return loc1;
        }

        internal function _About_Label20_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label20";
            this._About_Label20 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label20", this._About_Label20);
            return loc1;
        }

        internal function _About_Label21_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.addEventListener("touch", this.___About_Label21_touch);
            loc1.id = "_About_Label21";
            this._About_Label21 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label21", this._About_Label21);
            return loc1;
        }

        public function ___About_Label21_touch(arg1:starling.events.TouchEvent):void
        {
            this.onAGBClick(arg1, "ABOUT_TOU_1_7");
            return;
        }

        internal function _About_Label22_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label22";
            this._About_Label22 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label22", this._About_Label22);
            return loc1;
        }

        internal function _About_Label23_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label23";
            this._About_Label23 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label23", this._About_Label23);
            return loc1;
        }

        internal function _About_Label24_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label24";
            this._About_Label24 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label24", this._About_Label24);
            return loc1;
        }

        internal function _About_Label25_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label25";
            this._About_Label25 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label25", this._About_Label25);
            return loc1;
        }

        internal function _About_Label26_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label26";
            this._About_Label26 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label26", this._About_Label26);
            return loc1;
        }

        internal function _About_Label27_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label27";
            this._About_Label27 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label27", this._About_Label27);
            return loc1;
        }

        internal function _About_Label28_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.addEventListener("touch", this.___About_Label28_touch);
            loc1.id = "_About_Label28";
            this._About_Label28 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label28", this._About_Label28);
            return loc1;
        }

        public function ___About_Label28_touch(arg1:starling.events.TouchEvent):void
        {
            this.onAGBClick(arg1, "ABOUT_TOU_3_3");
            return;
        }

        internal function _About_Label29_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label29";
            this._About_Label29 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label29", this._About_Label29);
            return loc1;
        }

        internal function _About_Label30_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label30";
            this._About_Label30 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label30", this._About_Label30);
            return loc1;
        }

        internal function _About_Label31_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label31";
            this._About_Label31 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label31", this._About_Label31);
            return loc1;
        }

        internal function _About_Label32_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label32";
            this._About_Label32 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label32", this._About_Label32);
            return loc1;
        }

        internal function _About_Label33_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label33";
            this._About_Label33 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label33", this._About_Label33);
            return loc1;
        }

        internal function _About_Label34_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label34";
            this._About_Label34 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label34", this._About_Label34);
            return loc1;
        }

        internal function _About_Label35_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label35";
            this._About_Label35 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label35", this._About_Label35);
            return loc1;
        }

        internal function _About_Label36_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label36";
            this._About_Label36 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label36", this._About_Label36);
            return loc1;
        }

        internal function _About_Label37_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label37";
            this._About_Label37 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label37", this._About_Label37);
            return loc1;
        }

        internal function _About_Label38_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label38";
            this._About_Label38 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label38", this._About_Label38);
            return loc1;
        }

        internal function _About_Label39_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label39";
            this._About_Label39 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label39", this._About_Label39);
            return loc1;
        }

        internal function _About_Label41_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label41";
            this._About_Label41 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label41", this._About_Label41);
            return loc1;
        }

        internal function _About_Label42_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label42";
            this._About_Label42 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label42", this._About_Label42);
            return loc1;
        }

        internal function _About_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _About_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_About_CustomVScrollContainer1.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_About_CustomVScrollContainer1.height")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_CustomVScrollContainer1.width")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout1.gap")
            result[5] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_About_LayoutGroup1.backgroundSkin")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return HEADER_HEIGHT;
            }, null, "_About_LayoutGroup1.height")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_LayoutGroup1.width")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, PADDING / 2);
            }, null, "_About_Label1.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label1.styleName")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label1.text")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_LayoutGroup2.width")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_HorizontalLayout1.gap")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_HorizontalLayout1.paddingLeft")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.appIcon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "appIcon.textureName")
            result[15] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout2.gap")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label2.styleName")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.APPNAME");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label2.text")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label3.styleName")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.APPVERSION") + " " + handler.ApplicationHandler.versionLabel + "\n" + utils.LanguageManager.getString("ABOUT.BUILD") + " " + handler.ApplicationHandler.versionNumber;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label3.text")
            result[20] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_LayoutGroup4.width")
            result[21] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout3.gap")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout3.padding")
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label4.styleName")
            result[24] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.ADRESS1") + "\n" + utils.LanguageManager.getString("ABOUT.ADRESS2") + "\n" + utils.LanguageManager.getString("ABOUT.ADRESS3");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label4.text")
            result[25] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_LayoutGroup5.width")
            result[26] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout4.gap")
            result[27] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout4.paddingLeft")
            result[28] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout4.paddingRight")
            result[29] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.HorizontalLayout();
            }, null, "_About_LayoutGroup6.layout")
            result[30] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label5.styleName")
            result[31] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.CONTACT1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label5.text")
            result[32] = new feathers.binding.Binding(this, function ():Number
            {
                return iconWidth;
            }, null, "_About_Label5.width")
            result[33] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label6.styleName")
            result[34] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.CONTACT2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label6.text")
            result[35] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.HorizontalLayout();
            }, null, "_About_LayoutGroup7.layout")
            result[36] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label7.styleName")
            result[37] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.CONTACT3");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label7.text")
            result[38] = new feathers.binding.Binding(this, function ():Number
            {
                return iconWidth;
            }, null, "_About_Label7.width")
            result[39] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label8.styleName")
            result[40] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.CONTACT4");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label8.text")
            result[41] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_LayoutGroup8.width")
            result[42] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout5.gap")
            result[43] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout5.padding")
            result[44] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.HorizontalLayout();
            }, null, "_About_LayoutGroup9.layout")
            result[45] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_LayoutGroup9.width")
            result[46] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label9.styleName")
            result[47] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.CONTACT5");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label9.text")
            result[48] = new feathers.binding.Binding(this, function ():Number
            {
                return iconWidth;
            }, null, "_About_Label9.width")
            result[49] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label10.styleName")
            result[50] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.CONTACT6");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label10.text")
            result[51] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.HorizontalLayout();
            }, null, "_About_LayoutGroup10.layout")
            result[52] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_LayoutGroup10.width")
            result[53] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label11.styleName")
            result[54] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.CONTACT7");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label11.text")
            result[55] = new feathers.binding.Binding(this, function ():Number
            {
                return iconWidth;
            }, null, "_About_Label11.width")
            result[56] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label12.styleName")
            result[57] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.CONTACT8");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label12.text")
            result[58] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_LayoutGroup11.width")
            result[59] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_HorizontalLayout2.gap")
            result[60] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_HorizontalLayout2.padding")
            result[61] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label13.styleName")
            result[62] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.FEEDBACK1") + "\n" + utils.LanguageManager.getString("ABOUT.FEEDBACK2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label13.text")
            result[63] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * PADDING;
            }, null, "_About_Label13.width")
            result[64] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_LayoutGroup12.width")
            result[65] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_HorizontalLayout3.paddingLeft")
            result[66] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_HorizontalLayout3.paddingRight")
            result[67] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT.FEEDBACK_BUTTON");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Button1.label")
            result[68] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * PADDING;
            }, null, "_About_Button1.width")
            result[69] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_About_LayoutGroup13.backgroundSkin")
            result[70] = new feathers.binding.Binding(this, function ():Number
            {
                return HEADER_HEIGHT;
            }, null, "_About_LayoutGroup13.height")
            result[71] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_LayoutGroup13.width")
            result[72] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, PADDING / 2);
            }, null, "_About_Label14.layoutData")
            result[73] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label14.styleName")
            result[74] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TERMS_OF_USE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label14.text")
            result[75] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_About_LayoutGroup14.width")
            result[76] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout6.gap")
            result[77] = new feathers.binding.Binding(this, function ():Number
            {
                return PADDING;
            }, null, "_About_VerticalLayout6.padding")
            result[78] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label15.maxWidth")
            result[79] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label15.styleName")
            result[80] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_1_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label15.text")
            result[81] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label16.maxWidth")
            result[82] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label16.styleName")
            result[83] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_1_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label16.text")
            result[84] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label17.maxWidth")
            result[85] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label17.styleName")
            result[86] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_1_3");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label17.text")
            result[87] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label18.maxWidth")
            result[88] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label18.styleName")
            result[89] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_1_4");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label18.text")
            result[90] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label19.maxWidth")
            result[91] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label19.styleName")
            result[92] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_1_5");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label19.text")
            result[93] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label20.maxWidth")
            result[94] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label20.styleName")
            result[95] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_1_6");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label20.text")
            result[96] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label21.maxWidth")
            result[97] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label21.styleName")
            result[98] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_1_7");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label21.text")
            result[99] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label22.maxWidth")
            result[100] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label22.styleName")
            result[101] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_2_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label22.text")
            result[102] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label23.maxWidth")
            result[103] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label23.styleName")
            result[104] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_2_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label23.text")
            result[105] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label24.maxWidth")
            result[106] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label24.styleName")
            result[107] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_2_3");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label24.text")
            result[108] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label25.maxWidth")
            result[109] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label25.styleName")
            result[110] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_2_4");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label25.text")
            result[111] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label26.maxWidth")
            result[112] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label26.styleName")
            result[113] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_3_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label26.text")
            result[114] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label27.maxWidth")
            result[115] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label27.styleName")
            result[116] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_3_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label27.text")
            result[117] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label28.maxWidth")
            result[118] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label28.styleName")
            result[119] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_3_3");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label28.text")
            result[120] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label29.maxWidth")
            result[121] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label29.styleName")
            result[122] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_4_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label29.text")
            result[123] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label30.maxWidth")
            result[124] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label30.styleName")
            result[125] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_4_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label30.text")
            result[126] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label31.maxWidth")
            result[127] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label31.styleName")
            result[128] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_5_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label31.text")
            result[129] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label32.maxWidth")
            result[130] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label32.styleName")
            result[131] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_5_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label32.text")
            result[132] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label33.maxWidth")
            result[133] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label33.styleName")
            result[134] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_6_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label33.text")
            result[135] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label34.maxWidth")
            result[136] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label34.styleName")
            result[137] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_6_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label34.text")
            result[138] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label35.maxWidth")
            result[139] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label35.styleName")
            result[140] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_7_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label35.text")
            result[141] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label36.maxWidth")
            result[142] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label36.styleName")
            result[143] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_7_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label36.text")
            result[144] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label37.maxWidth")
            result[145] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label37.styleName")
            result[146] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_8_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label37.text")
            result[147] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label38.maxWidth")
            result[148] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label38.styleName")
            result[149] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_8_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label38.text")
            result[150] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label39.maxWidth")
            result[151] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label39.styleName")
            result[152] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_8_3");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label39.text")
            result[153] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label40.maxWidth")
            result[154] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label40.styleName")
            result[155] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_8_4");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label40.text")
            result[156] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label41.maxWidth")
            result[157] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_BOLD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label41.styleName")
            result[158] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_9_1");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label41.text")
            result[159] = new feathers.binding.Binding(this, function ():Number
            {
                return maxLabelWidth;
            }, null, "_About_Label42.maxWidth")
            result[160] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label42.styleName")
            result[161] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ABOUT_TOU_9_2");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_About_Label42.text")
            return result;
        }

        public function get appIcon():frontend.components.TextureImage
        {
            return this._794283462appIcon;
        }

        public function set appIcon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._794283462appIcon;
            if (loc1 !== arg1) 
            {
                this._794283462appIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "appIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _About_LayoutGroup3_c():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_VerticalLayout2_i();
            loc1.mxmlContent = [this._About_Label2_i(), this._About_Label3_i()];
            return loc1;
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

        internal function get iconWidth():Number
        {
            return this._1398151987iconWidth;
        }

        internal function set iconWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1398151987iconWidth;
            if (loc1 !== arg1) 
            {
                this._1398151987iconWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get maxLabelWidth():Number
        {
            return this._1465387958maxLabelWidth;
        }

        internal function set maxLabelWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1465387958maxLabelWidth;
            if (loc1 !== arg1) 
            {
                this._1465387958maxLabelWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "maxLabelWidth", loc1, arg1, this);
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
            About._watcherSetupUtil = arg1;
            return;
        }

        internal function onIconComplete():void
        {
            this.iconWidth = this.appIcon.width;
            this.maxLabelWidth = SIGMALink.appWidth - 2 * PADDING;
            return;
        }

        internal function onLinkClick(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            flash.net.navigateToURL(new flash.net.URLRequest(utils.LanguageManager.getString("ABOUT.CONTACT8")));
            return;
        }

        internal function onFeedbackClick(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*="mailto:" + utils.LanguageManager.getString("ABOUT.CONTACT6") + "?subject=" + utils.LanguageManager.getString("ABOUT.FEEDBACK_SUBJECT");
            flash.net.navigateToURL(new flash.net.URLRequest(loc1));
            return;
        }

        internal function onAGBClick(arg1:starling.events.TouchEvent, arg2:String):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=utils.LanguageManager.getString(arg2);
            flash.net.navigateToURL(new flash.net.URLRequest(loc1));
            return;
        }

        internal function _About_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.layout = this._About_VerticalLayout1_i();
            loc1.mxmlContent = [this._About_LayoutGroup1_i(), this._About_LayoutGroup2_i(), this._About_LayoutGroup4_i(), this._About_LayoutGroup5_i(), this._About_LayoutGroup8_i(), this._About_LayoutGroup11_i(), this._About_LayoutGroup12_i(), this._About_LayoutGroup13_i(), this._About_LayoutGroup14_i()];
            loc1.id = "_About_CustomVScrollContainer1";
            this._About_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_CustomVScrollContainer1", this._About_CustomVScrollContainer1);
            return loc1;
        }

        internal function _About_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._About_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_VerticalLayout1", this._About_VerticalLayout1);
            return loc1;
        }

        internal function _About_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_AnchorLayout1_c();
            loc1.mxmlContent = [this._About_Label1_i()];
            loc1.id = "_About_LayoutGroup1";
            this._About_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup1", this._About_LayoutGroup1);
            return loc1;
        }

        internal function _About_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _About_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label1";
            this._About_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label1", this._About_Label1);
            return loc1;
        }

        internal function _About_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_HorizontalLayout1_i();
            loc1.mxmlContent = [this._About_TextureImage1_i(), this._About_LayoutGroup3_c()];
            loc1.id = "_About_LayoutGroup2";
            this._About_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup2", this._About_LayoutGroup2);
            return loc1;
        }

        internal function _About_HorizontalLayout1_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._About_HorizontalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_HorizontalLayout1", this._About_HorizontalLayout1);
            return loc1;
        }

        internal function _About_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.addEventListener("creationComplete", this.__appIcon_creationComplete);
            loc1.id = "appIcon";
            this.appIcon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "appIcon", this.appIcon);
            return loc1;
        }

        public function __appIcon_creationComplete(arg1:starling.events.Event):void
        {
            this.onIconComplete();
            return;
        }

        internal function _About_Label40_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_About_Label40";
            this._About_Label40 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label40", this._About_Label40);
            return loc1;
        }

        internal function _About_VerticalLayout2_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._About_VerticalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_VerticalLayout2", this._About_VerticalLayout2);
            return loc1;
        }

        internal function _About_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label2";
            this._About_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label2", this._About_Label2);
            return loc1;
        }

        internal function _About_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label3";
            this._About_Label3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label3", this._About_Label3);
            return loc1;
        }

        internal function _About_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._About_VerticalLayout3_i();
            loc1.mxmlContent = [this._About_Label4_i()];
            loc1.id = "_About_LayoutGroup4";
            this._About_LayoutGroup4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_LayoutGroup4", this._About_LayoutGroup4);
            return loc1;
        }

        internal function _About_VerticalLayout3_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._About_VerticalLayout3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_VerticalLayout3", this._About_VerticalLayout3);
            return loc1;
        }

        internal function _About_Label4_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_About_Label4";
            this._About_Label4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_About_Label4", this._About_Label4);
            return loc1;
        }

        internal static const HEADER_HEIGHT:Number=67 * SIGMALink.scaleFactor;

        internal static const ICON_GAP:Number=80 * SIGMALink.scaleFactor;

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        public var _About_HorizontalLayout2:feathers.layout.HorizontalLayout;

        public var _About_HorizontalLayout3:feathers.layout.HorizontalLayout;

        public var _About_Label1:feathers.controls.Label;

        public var _About_Label10:feathers.controls.Label;

        public var _About_Label11:feathers.controls.Label;

        public var _About_Label12:feathers.controls.Label;

        public var _About_Label13:feathers.controls.Label;

        public var _About_Label14:feathers.controls.Label;

        public var _About_Label15:feathers.controls.Label;

        public var _About_Label16:feathers.controls.Label;

        public var _About_Label17:feathers.controls.Label;

        public var _About_Label18:feathers.controls.Label;

        public var _About_Label19:feathers.controls.Label;

        public var _About_Label2:feathers.controls.Label;

        public var _About_Label20:feathers.controls.Label;

        public var _About_Label21:feathers.controls.Label;

        public var _About_Label22:feathers.controls.Label;

        public var _About_Label24:feathers.controls.Label;

        public var _About_Label25:feathers.controls.Label;

        public var _About_Label26:feathers.controls.Label;

        public var _About_Label27:feathers.controls.Label;

        public var _About_Label28:feathers.controls.Label;

        public var _About_Label29:feathers.controls.Label;

        public var _About_Label3:feathers.controls.Label;

        public var _About_Label30:feathers.controls.Label;

        public var _About_Label31:feathers.controls.Label;

        public var _About_Label32:feathers.controls.Label;

        public var _About_Label33:feathers.controls.Label;

        public var _About_Label34:feathers.controls.Label;

        public var _About_Label35:feathers.controls.Label;

        public var _About_Label36:feathers.controls.Label;

        public var _About_Label37:feathers.controls.Label;

        public var _About_Label38:feathers.controls.Label;

        public var _About_Label39:feathers.controls.Label;

        public var _About_Label4:feathers.controls.Label;

        public var _About_Label40:feathers.controls.Label;

        public var _About_Label41:feathers.controls.Label;

        public var _About_Label42:feathers.controls.Label;

        public var _About_Label5:feathers.controls.Label;

        public var _About_Label6:feathers.controls.Label;

        public var _About_Label7:feathers.controls.Label;

        public var _About_Label8:feathers.controls.Label;

        public var _About_Label9:feathers.controls.Label;

        public var _About_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup10:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup11:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup12:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup13:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup14:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup4:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup5:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup6:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup7:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup8:feathers.controls.LayoutGroup;

        public var _About_LayoutGroup9:feathers.controls.LayoutGroup;

        public var _About_VerticalLayout1:feathers.layout.VerticalLayout;

        public var _About_VerticalLayout2:feathers.layout.VerticalLayout;

        public var _About_VerticalLayout4:feathers.layout.VerticalLayout;

        public var _About_VerticalLayout5:feathers.layout.VerticalLayout;

        public var _About_VerticalLayout6:feathers.layout.VerticalLayout;

        internal var _794283462appIcon:frontend.components.TextureImage;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1398151987iconWidth:Number;

        internal var _1465387958maxLabelWidth:Number=0;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        public var _About_VerticalLayout3:feathers.layout.VerticalLayout;

        public var _About_Label23:feathers.controls.Label;

        public var _About_Button1:feathers.controls.Button;

        public var _About_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _About_HorizontalLayout1:feathers.layout.HorizontalLayout;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


