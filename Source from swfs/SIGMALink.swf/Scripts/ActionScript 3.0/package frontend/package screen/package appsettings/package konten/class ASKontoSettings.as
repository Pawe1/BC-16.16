//class ASKontoSettings
package frontend.screen.appsettings.konten 
{
    import debug.*;
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
    import frontend.components.button.*;
    import frontend.components.popup.oauth.*;
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
    
    public class ASKontoSettings extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASKontoSettings()
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
            bindings = this._ASKontoSettings_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_ASKontoSettingsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASKontoSettings[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASKontoSettings_CustomVScrollContainer1_i(), this._ASKontoSettings_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ASKontoSettings_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_ASKontoSettings_CustomVScrollContainer1.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKontoSettings_CustomVScrollContainer1.width")
            result[2] = new feathers.binding.Binding(this, null, null, "_ASKontoSettings_ASKontenSetting1.oauthInstance", "oauthInstance");
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKontoSettings_ASKontenSetting1.width")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKontoSettings_LayoutGroup1.width")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return GAP;
            }, null, "_ASKontoSettings_VerticalLayout1.gap")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return GAP;
            }, null, "_ASKontoSettings_VerticalLayout1.padding")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.CENTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKontoSettings_Button1.horizontalAlign")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.LOGOUT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKontoSettings_Button1.label")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKontoSettings_Button1.verticalAlign")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.arrowRight;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "nextButton.image")
            result[11] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showNextButton;
            }, null, "nextButton.includeInLayout")
            result[12] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showNextButton;
            }, null, "nextButton.visible")
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

        public function get oauthInstance():frontend.components.popup.oauth.CustomOAuth
        {
            return this._1940553804oauthInstance;
        }

        public function set oauthInstance(arg1:frontend.components.popup.oauth.CustomOAuth):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1940553804oauthInstance;
            if (loc1 !== arg1) 
            {
                this._1940553804oauthInstance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "oauthInstance", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _showNextButton():Boolean
        {
            return this._1327868161_showNextButton;
        }

        public function set gotoActivityId(arg1:uint):void
        {
            this._gotoActivityId = arg1;
            this._showNextButton = this._gotoActivityId > 0;
            return;
        }

        internal function set _showNextButton(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1327868161_showNextButton;
            if (loc1 !== arg1) 
            {
                this._1327868161_showNextButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_showNextButton", loc1, arg1, this);
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
            ASKontoSettings._watcherSetupUtil = arg1;
            return;
        }

        internal function logoutTouchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.logout();
            return;
        }

        protected function logout():void
        {
            debug.Debug.warning("please override");
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function gotoActivity(arg1:starling.events.TouchEvent):void
        {
            if (this._gotoActivityId == 0) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_SHARE_ACTIVITY, {"activityId":this._gotoActivityId, "comesFromSharingOptions":true}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _ASKontoSettings_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._ASKontoSettings_ASKontenSetting1_i(), this._ASKontoSettings_LayoutGroup1_i()];
            loc1.id = "_ASKontoSettings_CustomVScrollContainer1";
            this._ASKontoSettings_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_CustomVScrollContainer1", this._ASKontoSettings_CustomVScrollContainer1);
            return loc1;
        }

        internal function _ASKontoSettings_ASKontenSetting1_i():frontend.screen.appsettings.konten.ASKontenSetting
        {
            var loc1:*=new frontend.screen.appsettings.konten.ASKontenSetting();
            loc1.id = "_ASKontoSettings_ASKontenSetting1";
            this._ASKontoSettings_ASKontenSetting1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_ASKontenSetting1", this._ASKontoSettings_ASKontenSetting1);
            return loc1;
        }

        internal function _ASKontoSettings_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ASKontoSettings_VerticalLayout1_i();
            loc1.mxmlContent = [this._ASKontoSettings_Button1_i()];
            loc1.id = "_ASKontoSettings_LayoutGroup1";
            this._ASKontoSettings_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_LayoutGroup1", this._ASKontoSettings_LayoutGroup1);
            return loc1;
        }

        internal function _ASKontoSettings_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "center";
            loc1.verticalAlign = "middle";
            this._ASKontoSettings_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_VerticalLayout1", this._ASKontoSettings_VerticalLayout1);
            return loc1;
        }

        internal function _ASKontoSettings_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("touch", this.___ASKontoSettings_Button1_touch);
            loc1.id = "_ASKontoSettings_Button1";
            this._ASKontoSettings_Button1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_Button1", this._ASKontoSettings_Button1);
            return loc1;
        }

        public function ___ASKontoSettings_Button1_touch(arg1:starling.events.TouchEvent):void
        {
            this.logoutTouchHandler(arg1);
            return;
        }

        internal function _ASKontoSettings_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._ASKontoSettings_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ASKontoSettings_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.touchHandler = this.gotoActivity;
            loc1.id = "nextButton";
            this.nextButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "nextButton", this.nextButton);
            return loc1;
        }

        internal static const GAP:Number=20 * SIGMALink.scaleFactor;

        public var _ASKontoSettings_ASKontenSetting1:frontend.screen.appsettings.konten.ASKontenSetting;

        public var _ASKontoSettings_Button1:feathers.controls.Button;

        public var _ASKontoSettings_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _ASKontoSettings_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _ASKontoSettings_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1749722107nextButton:frontend.components.button.IconButton;

        internal var _gotoActivityId:uint=0;

        internal var _1940553804oauthInstance:frontend.components.popup.oauth.CustomOAuth;

        internal var _1327868161_showNextButton:Boolean=false;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


