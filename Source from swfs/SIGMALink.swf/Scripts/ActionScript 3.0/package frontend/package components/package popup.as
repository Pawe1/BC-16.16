//package popup
//  package oauth
//    class CustomOAuth
package frontend.components.popup.oauth 
{
    import debug.*;
    import feathers.core.*;
    import feathers.events.*;
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;
    import frontend.components.popup.*;
    import service.oauth.*;
    import starling.events.*;
    
    public class CustomOAuth extends service.oauth.CommonOAuth
    {
        public function CustomOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            this.pleaseWaitAdded = false;
            this.waitForCall = false;
            if (this.webView) 
            {
                lastLocation = "";
                if (feathers.core.PopUpManager.isPopUp(this.oauthPopUP)) 
                {
                    frontend.components.popup.PopUpBase.removePopUps(this.oauthPopUP, false);
                }
                this.webView.removeEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.onWebViewLocationChange);
                this.webView.removeEventListener(starling.events.Event.COMPLETE, this.onWebViewComplete);
                this.webView = null;
            }
            this.oauthPopUP = null;
            return;
        }

        public override function logout():void
        {
            debug("logout");
            this.webView = new frontend.components.popup.oauth.CustomWebView();
            this.webView.addEventListener(starling.events.Event.COMPLETE, this.handleLogout);
            this.webView.addEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.handleLogout);
            this.webView.addEventListener(feathers.events.FeathersEventType.ERROR, this.handleLogoutError);
            this.webView.loadURL(LOGOUT_URL);
            return;
        }

        public override function showWebViewer(arg1:Boolean):void
        {
            debug("show web viewer");
            if (this.webView) 
            {
                if (!this.oauthPopUP) 
                {
                    this.oauthPopUP = new frontend.components.popup.OAuthPopUp();
                }
                this.oauthPopUP.title = popupTitle;
                this.oauthPopUP.oauth = this;
                this.webView.validate();
                this.getStageWebView().addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.onNativeStageSoftKeyboardActivate);
                this.getStageWebView().addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.onNativeStageSoftKeyboardDeactivate);
                if (!feathers.core.PopUpManager.isPopUp(this.oauthPopUP) && showWebViewOnCheckLogin) 
                {
                    this.waitForCall = true;
                    frontend.components.popup.PopUpBase.showModalPopUp(this.oauthPopUP, showWebViewOnCheckLogin, false);
                }
            }
            return;
        }

        protected override function doOAuthCall(arg1:flash.media.StageWebView):void
        {
            if (this.waitForCall) 
            {
                this.waitForCall = false;
                this.oauthPopUP.addPleaseWait();
                this.pleaseWaitAdded = true;
                this.webView.visible = false;
                this.oauthPopUP.setWebView(this.webView);
                this.reloadTimeout = flash.utils.setTimeout(this.doOAuthCall, 1000, arg1);
                return;
            }
            if (showWebViewOnCheckLogin && this.pleaseWaitAdded) 
            {
                this.webView.visible = true;
                super.doOAuthCall(arg1);
                this.oauthPopUP.removePleaseWait();
            }
            else if (!showWebViewOnCheckLogin) 
            {
                super.doOAuthCall(arg1);
            }
            return;
        }

        internal function onNativeStageSoftKeyboardActivate(arg1:flash.events.SoftKeyboardEvent):void
        {
            debug.Debug.debug("onNativeStageSoftKeyboardActivate");
            return;
        }

        internal function onNativeStageSoftKeyboardDeactivate(arg1:flash.events.SoftKeyboardEvent):void
        {
            debug.Debug.debug("onNativeStageSoftKeyboardDeactivate");
            return;
        }

        protected override function getStageWebView():flash.media.StageWebView
        {
            var loc1:*=this.webView.getStageWebView() as flash.media.StageWebView;
            return loc1;
        }

        protected override function initWebView():void
        {
            this.webView = new frontend.components.popup.oauth.CustomWebView();
            this.webView.addEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.onWebViewLocationChange);
            this.webView.addEventListener(flash.events.Event.COMPLETE, this.onWebViewComplete);
            return;
        }

        protected function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            lastLocation = (arg1.target as frontend.components.popup.oauth.CustomWebView).location;
            debug("onWebViewLocationChange");
            return;
        }

        protected function onWebViewComplete(arg1:starling.events.Event):void
        {
            return;
        }

        internal function handleLogout(arg1:starling.events.Event):void
        {
            if (this.webView && (arg1.target as frontend.components.popup.oauth.CustomWebView).location == LOGOUT_COMPLETE_URL) 
            {
                debug("handleLogout > ok");
                this.webView.removeEventListener(starling.events.Event.COMPLETE, this.handleLogout);
                this.webView.removeEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.handleLogout);
                this.webView.removeEventListener(feathers.events.FeathersEventType.ERROR, this.handleLogoutError);
                this.webView.dispose();
                this.webView = null;
                doLogout();
            }
            else 
            {
                debug("handleLogout > failed");
            }
            return;
        }

        internal function handleLogoutError(arg1:starling.events.Event):void
        {
            debug("handleLogout > error: errorId = " + arg1.toString());
            if (this.webView) 
            {
                this.webView.removeEventListener(starling.events.Event.COMPLETE, this.handleLogout);
                this.webView.removeEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.handleLogout);
                this.webView.removeEventListener(feathers.events.FeathersEventType.ERROR, this.handleLogoutError);
                this.webView.dispose();
                this.webView = null;
            }
            doLogout();
            return;
        }

        protected var oauthPopUP:frontend.components.popup.OAuthPopUp;

        protected var pleaseWaitAdded:Boolean=false;

        protected var reloadTimeout:uint=0;

        protected var waitForCall:Boolean=false;

        protected var webView:frontend.components.popup.oauth.CustomWebView;
    }
}


//    class CustomWebView
package frontend.components.popup.oauth 
{
    import feathers.controls.*;
    import flash.geom.*;
    import flash.media.*;
    
    public class CustomWebView extends feathers.controls.WebView
    {
        public function CustomWebView()
        {
            super();
            createStageWebView();
            return;
        }

        public function getStageWebView():Object
        {
            return stageWebView;
        }

        public function setViewPort(arg1:feathers.controls.LayoutGroup):void
        {
            setSize(arg1.width, arg1.height);
            (this.getStageWebView() as flash.media.StageWebView).viewPort = new flash.geom.Rectangle(arg1.x, arg1.y, arg1.width, arg1.height);
            return;
        }
    }
}


//  class CustomFullscreenContentPopUp
package frontend.components.popup 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.ui.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.screen.component.*;
    import handler.*;
    import helper.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CustomFullscreenContentPopUp extends frontend.components.popup.PopUpBase
    {
        public function CustomFullscreenContentPopUp(arg1:feathers.controls.LayoutGroup, arg2:Boolean=true, arg3:Function=null, arg4:Function=null)
        {
            super();
            this.popupIgnoresBackButton = true;
            _backgroundSkinColor = core.general.Colors.RED;
            height = SIGMALink.appHeight;
            width = SIGMALink.appWidth;
            this._contentGroup = arg1;
            this._showOkButton = arg2;
            this.okCallback = arg3;
            this.cancelCallback = arg4;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc2:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc2 = new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = this.headline;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.addChild(loc3);
            var loc4:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc4.y = (HEADER_HEIGHT - 1);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function androidBackButtonHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!helper.Capabilities_helper.isAndroid()) 
            {
                return;
            }
            if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                if (this.cancelCallback != null) 
                {
                    this.cancelCallback(this);
                }
            }
            return;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=new Vector.<frontend.components.button.IconButton>();
            if (!helper.Capabilities_helper.isAndroid()) 
            {
                loc4 = new frontend.components.button.IconButton();
                loc4.touchHandler = this.cancelButton_handler;
                loc4.image = frontend.Textures.backbutton;
                loc1.push(loc4);
            }
            if (this._showOkButton) 
            {
                loc5 = new frontend.components.button.IconButton();
                loc5.touchHandler = this.okButton_handler;
                loc5.image = this.okButtonTexture;
                loc1.push(loc5);
            }
            var loc2:*=new frontend.screen.component.Footer();
            loc2.showBackButton = false;
            loc2.forceRightButton = true;
            loc2.setButtonGroup(loc1);
            var loc3:*=new feathers.controls.LayoutGroup();
            loc3.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc3.layout = new feathers.layout.AnchorLayout();
            loc3.addChild(loc2);
            return loc3;
        }

        protected override function addContent():void
        {
            super.addContent();
            if (!this._contentGroup) 
            {
                return;
            }
            this._contentGroup.maxWidth = SIGMALink.appWidth - (_layoutGap << 1);
            this._contentGroup.layoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0, NaN, 0);
            contentHolder.height = height;
            contentHolder.addChild(this._contentGroup);
            return;
        }

        public override function validate():void
        {
            super.validate();
            return;
        }

        internal function okButton_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.okCallback != null) 
            {
                this.okCallback(this);
            }
            return;
        }

        internal function cancelButton_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.cancelCallback != null) 
            {
                this.cancelCallback(this);
            }
            return;
        }

        public function get headline():String
        {
            return this._1115058732headline;
        }

        public function set headline(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1115058732headline;
            if (loc1 !== arg1) 
            {
                this._1115058732headline = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headline", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get okButtonTexture():String
        {
            return this._2082819827okButtonTexture;
        }

        public function set okButtonTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2082819827okButtonTexture;
            if (loc1 !== arg1) 
            {
                this._2082819827okButtonTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "okButtonTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var cancelCallback:Function;

        internal var _1115058732headline:String="INFO";

        internal var _2082819827okButtonTexture:String="arrowRight";

        public var okCallback:Function;

        internal var _contentGroup:feathers.controls.LayoutGroup;

        internal var _showOkButton:Boolean=true;
    }
}


//  class DeletePopUp
package frontend.components.popup 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class DeletePopUp extends frontend.components.popup.PopUpBase
    {
        public function DeletePopUp()
        {
            this.closeBtnLabel = utils.LanguageManager.getString("CANCEL_BUTTON");
            this.deleteBtnLabel = utils.LanguageManager.getString("DELETE_BUTTON");
            this.description = new feathers.controls.Label();
            super();
            _backgroundSkinColor = core.general.Colors.RED;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight * 0.33;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc4:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc2 = new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = title;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.addChild(loc3);
            loc4 = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc4.y = (HEADER_HEIGHT - 1);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = FOOTER_HEIGHT;
            loc2.width = SIGMALink.appWidth;
            loc2.layoutData = footerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Button();
            loc3.label = this.deleteBtnLabel;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
            loc3.addEventListener(starling.events.Event.TRIGGERED, this.deleteButton_triggeredHandler);
            loc2.addChild(loc3);
            var loc4:*=new feathers.controls.Button();
            loc4.label = this.closeBtnLabel;
            loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, _layoutGap, NaN, NaN, NaN, 0);
            loc4.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function addContent():void
        {
            super.addContent();
            this.description.maxWidth = SIGMALink.appWidth - (_layoutGap << 1);
            this.description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
            this.description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this.description.wordWrap = true;
            contentHolder.addChild(this.description);
            return;
        }

        public override function validate():void
        {
            super.validate();
            this.validatePopUpContent();
            return;
        }

        protected function validatePopUpContent():void
        {
            this.description.text = this.text;
            return;
        }

        internal function deleteButton_triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.deleteCallback != null) 
            {
                this.deleteCallback();
            }
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            if (this.cancelCallback != null) 
            {
                this.cancelCallback();
            }
            return;
        }

        public var cancelCallback:Function;

        public var deleteCallback:Function;

        public var text:String;

        protected var closeBtnLabel:String;

        protected var deleteBtnLabel:String;

        protected var description:feathers.controls.Label;
    }
}


//  class FirmwarePopUp
package frontend.components.popup 
{
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import frontend.*;
    import starling.display.*;
    import starling.events.*;
    
    public class FirmwarePopUp extends frontend.components.popup.PopUpBase
    {
        public function FirmwarePopUp()
        {
            super();
            _backgroundSkinColor = core.general.Colors.RED;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = 215 * SIGMALink.scaleFactor;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc2:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc2 = new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = 3;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc3.y = 2;
            loc2.addChild(loc3);
            return loc1;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc4:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.layout.VerticalLayout();
            loc2.gap = BUTTON_PADDING;
            loc2.padding = BUTTON_PADDING;
            var loc3:*=SIGMALink.appWidth - 2 * BUTTON_PADDING;
            loc4 = new feathers.controls.LayoutGroup();
            loc4.layout = loc2;
            loc4.width = SIGMALink.appWidth;
            loc4.layoutData = footerLayoutData;
            loc1.addChild(loc4);
            var loc5:*=new feathers.controls.Button();
            loc5.width = loc3;
            loc5.label = frontend.Locales.getString("DEVICEVIEW.GENERAL_FIRMWARE_WHATS_NEW");
            loc5.addEventListener(starling.events.Event.TRIGGERED, this.whatsNewButton_triggeredHandler);
            loc4.addChild(loc5);
            var loc6:*=new feathers.controls.Button();
            loc6.width = loc3;
            loc6.label = frontend.Locales.getString("DEVICEVIEW.GENERAL_FIRMWARE_UPDATE");
            loc6.addEventListener(starling.events.Event.TRIGGERED, this.updateButton_triggeredHandler);
            loc4.addChild(loc6);
            var loc7:*=new feathers.controls.Button();
            loc7.width = loc3;
            loc7.label = frontend.Locales.getString("DEVICEVIEW.GENERAL_FIRMWARE_CANCEL");
            loc7.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc4.addChild(loc7);
            return loc1;
        }

        protected function whatsNewButton_triggeredHandler(arg1:starling.events.Event):void
        {
            debug.Debug.debug("whats new?");
            return;
        }

        protected function updateButton_triggeredHandler(arg1:starling.events.Event):void
        {
            debug.Debug.debug("Update!");
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            frontend.components.popup.PopUpBase.closePopUp();
            return;
        }

        internal static const BUTTON_PADDING:uint=10;

        public var cancelCallback:Function;
    }
}


//  class InfoPopUp
package frontend.components.popup 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class InfoPopUp extends frontend.components.popup.PopUpBase
    {
        public function InfoPopUp(arg1:Boolean=true, arg2:Boolean=true, arg3:Function=null, arg4:Function=null)
        {
            this._1642565809_cancelBtnLabel = utils.LanguageManager.getString("CANCEL_BUTTON");
            this._description = new feathers.controls.Label();
            this._1513957997_okBtnLabel = utils.LanguageManager.getString("OK_BUTTON");
            super();
            this.popupIgnoresBackButton = true;
            _backgroundSkinColor = core.general.Colors.RED;
            this._showOkButton = arg1;
            this._showCancelButton = arg2;
            this.okCallback = arg3;
            this.cancelCallback = arg4;
            return;
        }

        public function setOkButtonLabel(arg1:String, arg2:Boolean=true):void
        {
            if (arg2) 
            {
                this._okBtnLabel = utils.LanguageManager.getString(arg1);
            }
            else 
            {
                this._okBtnLabel = arg1;
            }
            return;
        }

        public function setCancelButtonLabel(arg1:String, arg2:Boolean=true):void
        {
            if (arg2) 
            {
                this._cancelBtnLabel = utils.LanguageManager.getString(arg1);
            }
            else 
            {
                this._cancelBtnLabel = arg1;
            }
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight * 0.45;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = this.headline;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.addChild(loc3);
            var loc4:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc4.y = (HEADER_HEIGHT - 1);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = FOOTER_HEIGHT;
            loc2.width = SIGMALink.appWidth;
            loc2.layoutData = footerLayoutData;
            loc1.addChild(loc2);
            if (this._showOkButton) 
            {
                loc3 = new feathers.controls.Button();
                loc3.label = this._okBtnLabel;
                loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
                loc3.addEventListener(starling.events.Event.TRIGGERED, this.okButton_triggeredHandler);
                loc2.addChild(loc3);
            }
            if (this._showCancelButton) 
            {
                loc4 = new feathers.controls.Button();
                loc4.label = this._cancelBtnLabel;
                loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, _layoutGap, NaN, NaN, NaN, 0);
                loc4.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
                loc2.addChild(loc4);
            }
            return loc1;
        }

        protected override function addContent():void
        {
            super.addContent();
            this._description.maxWidth = SIGMALink.appWidth - (_layoutGap << 1);
            this._description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
            this._description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._description.wordWrap = true;
            contentHolder.addChild(this._description);
            return;
        }

        public override function validate():void
        {
            super.validate();
            this.validatePopUpContent();
            return;
        }

        protected function validatePopUpContent():void
        {
            this._description.text = this.text;
            return;
        }

        internal function okButton_triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.okCallback != null) 
            {
                this.okCallback(this);
            }
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            if (this.cancelCallback != null) 
            {
                this.cancelCallback(this);
            }
            return;
        }

        public function get headline():String
        {
            return this._1115058732headline;
        }

        public function set headline(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1115058732headline;
            if (loc1 !== arg1) 
            {
                this._1115058732headline = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headline", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _cancelBtnLabel():String
        {
            return this._1642565809_cancelBtnLabel;
        }

        internal function set _cancelBtnLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1642565809_cancelBtnLabel;
            if (loc1 !== arg1) 
            {
                this._1642565809_cancelBtnLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_cancelBtnLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _okBtnLabel():String
        {
            return this._1513957997_okBtnLabel;
        }

        internal function set _okBtnLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1513957997_okBtnLabel;
            if (loc1 !== arg1) 
            {
                this._1513957997_okBtnLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_okBtnLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var cancelCallback:Function;

        public var data:Object;

        internal var _1115058732headline:String="INFO";

        public var okCallback:Function;

        public var text:String;

        internal var _1642565809_cancelBtnLabel:String;

        internal var _description:feathers.controls.Label;

        internal var _1513957997_okBtnLabel:String;

        internal var _showCancelButton:Boolean=true;

        internal var _showOkButton:Boolean=true;
    }
}


//  class OAuthPopUp
package frontend.components.popup 
{
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.components.popup.oauth.*;
    import starling.events.*;
    import utils.*;
    
    public class OAuthPopUp extends frontend.components.popup.PopUpBase
    {
        public function OAuthPopUp()
        {
            super();
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            this.cancel(arg1);
            return;
        }

        internal function cancel(arg1:starling.events.Event):void
        {
            if (this.cancelFunc != null) 
            {
                this.cancelFunc();
            }
            this.oauth.destructor();
            return;
        }

        public function setWebView(arg1:feathers.controls.WebView, arg2:Boolean=true):void
        {
            if (contentHolder) 
            {
                contentHolder.addChild(arg1);
                if (arg1 is frontend.components.popup.oauth.CustomWebView) 
                {
                    (arg1 as frontend.components.popup.oauth.CustomWebView).setViewPort(contentHolder);
                }
            }
            return;
        }

        public function addPleaseWait():void
        {
            this._pleaseWaitLabel = new feathers.controls.Label();
            this._pleaseWaitLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._pleaseWaitLabel.text = utils.LanguageManager.getString("OAUTH_PLEASE_WAIT");
            contentHolder.addChild(this._pleaseWaitLabel);
            return;
        }

        public function removePleaseWait():void
        {
            if (contentHolder.contains(this._pleaseWaitLabel)) 
            {
                contentHolder.removeChild(this._pleaseWaitLabel);
                this._pleaseWaitLabel = null;
            }
            return;
        }

        public var oauth:frontend.components.popup.oauth.CustomOAuth;

        internal var _pleaseWaitLabel:feathers.controls.Label;

        internal var _reload:Boolean=true;

        internal var cancelFunc:Function;
    }
}


//  class PopUpBase
package frontend.components.popup 
{
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import frontend.*;
    import frontend.components.button.*;
    import handler.*;
    import helper.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    import utils.*;
    
    public class PopUpBase extends feathers.controls.Panel
    {
        public function PopUpBase()
        {
            super();
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        protected function set _layoutGap(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1431588301_layoutGap;
            if (loc1 !== arg1) 
            {
                this._1431588301_layoutGap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_layoutGap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function closePopUp():void
        {
            var loc1:*=undefined;
            var loc2:*=0;
            var loc3:*=currentPopUps;
            for (loc1 in loc3) 
            {
                removePopUps(loc1, loc1 is frontend.components.popup.PopUpBase);
            }
            checkPopUpMode();
            return;
        }

        public static function showModalPopUp(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Boolean=true, arg4:Boolean=true, arg5:Boolean=false):void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            handler.ViewHandler.getInstance().popUpMode = true;
            currentPopUps[arg1] = frontend.components.popup.PopUpBase;
            closeOnTouchOutside = arg5;
            var loc1:*=CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP;
            if (arg1 is frontend.components.popup.PopUpBase) 
            {
                loc1 = (arg1 as frontend.components.popup.PopUpBase).closeTweenDirection;
            }
            feathers.core.PopUpManager.addPopUp(arg1, arg2, !arg3, createCustomOverlayFactory);
            if (arg3) 
            {
                loc2 = 0;
                loc3 = 0;
                var loc4:*=loc1;
                switch (loc4) 
                {
                    case CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP:
                    {
                        arg1.y = SIGMALink.appHeight;
                        loc2 = SIGMALink.appHeight - arg1.height;
                        if (!arg4) 
                        {
                            loc2 = loc2 - SIGMALink.footerHeight;
                        }
                        starling.core.Starling.juggler.tween(arg1, TWEEN_DURATION, {"y":loc2});
                        break;
                    }
                    case CUSTOM_TWEEN_DIRECTION_RIGHT_TO_LEFT:
                    {
                        arg1.y = 0;
                        arg1.x = SIGMALink.appWidth;
                        starling.core.Starling.juggler.tween(arg1, TWEEN_DURATION, {"y":loc2, "x":loc3});
                        break;
                    }
                    case CUSTOM_TWEEN_DIRECTION_LEFT_TO_RIGHT:
                    {
                        arg1.y = 0;
                        arg1.x = SIGMALink.appWidth * -1;
                        starling.core.Starling.juggler.tween(arg1, TWEEN_DURATION, {"y":loc2, "x":loc3});
                        break;
                    }
                }
            }
            return;
        }

        internal static function removePopUp(arg1:starling.display.DisplayObject, arg2:Function=null):void
        {
            var p_popup:starling.display.DisplayObject;
            var p_callback:Function=null;

            var loc1:*;
            p_popup = arg1;
            p_callback = arg2;
            try 
            {
                feathers.core.PopUpManager.removePopUp(p_popup);
            }
            catch (e:Error)
            {
                debug.Debug.error("Versuch PopUp zu schließen fehlgeschlagen. PopUp existiert nicht mehr.");
            }
            finally
            {
                if (p_callback != null) 
                {
                    p_callback();
                }
            }
            return;
        }

        public function get popupIgnoresBackButton():Boolean
        {
            return this._popupIgnoresBackButton;
        }

        public function set popupIgnoresBackButton(arg1:Boolean):void
        {
            this._popupIgnoresBackButton = arg1;
            if (stage != null) 
            {
                if (this._popupIgnoresBackButton) 
                {
                    stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
                }
                else 
                {
                    stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
                }
            }
            return;
        }

        protected function customDraw():void
        {
            if (this._validate) 
            {
                if (header && !(header.height == HEADER_HEIGHT)) 
                {
                    header.height = HEADER_HEIGHT;
                    header.validate();
                }
                if (footer && !(footer.height == FOOTER_HEIGHT)) 
                {
                    footer.height = FOOTER_HEIGHT;
                    footer.validate();
                }
                backgroundSkin = new starling.display.Quad(1, 1, this._backgroundSkinColor);
                outerPadding = 0;
                padding = 0;
                this._validate = false;
            }
            return;
        }

        public static function removePopUps(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Function=null):void
        {
            var p_popup:starling.display.DisplayObject;
            var p_tween:Boolean=true;
            var p_callback:Function=null;
            var yTo:Number;
            var xTo:Number;
            var tweenDirection:String;

            var loc1:*;
            yTo = NaN;
            xTo = NaN;
            tweenDirection = null;
            p_popup = arg1;
            p_tween = arg2;
            p_callback = arg3;
            if (feathers.core.PopUpManager.isPopUp(p_popup)) 
            {
                if (p_tween) 
                {
                    yTo = 0;
                    xTo = 0;
                    tweenDirection = CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP;
                    if (p_popup is frontend.components.popup.PopUpBase) 
                    {
                        tweenDirection = (p_popup as frontend.components.popup.PopUpBase).closeTweenDirection;
                    }
                    var loc2:*=tweenDirection;
                    switch (loc2) 
                    {
                        case CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP:
                        {
                            yTo = SIGMALink.appHeight;
                            xTo = p_popup.x;
                            break;
                        }
                        case CUSTOM_TWEEN_DIRECTION_RIGHT_TO_LEFT:
                        {
                            xTo = SIGMALink.appWidth * -1;
                            break;
                        }
                        case CUSTOM_TWEEN_DIRECTION_LEFT_TO_RIGHT:
                        {
                            xTo = SIGMALink.appWidth;
                            break;
                        }
                    }
                    starling.core.Starling.juggler.tween(p_popup, TWEEN_DURATION, {"y":yTo, "x":xTo, "onComplete":function ():void
                    {
                        removePopUp(p_popup, p_callback);
                        return;
                    }})
                }
                else 
                {
                    removePopUp(p_popup, p_callback);
                }
            }
            if (currentPopUps[p_popup] != null) 
            {
                delete currentPopUps[p_popup];
            }
            checkPopUpMode();
            return;
        }

        internal static function checkPopUpMode():void
        {
            var loc2:*=undefined;
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=currentPopUps;
            for (loc2 in loc4) 
            {
                ++loc1;
            }
            handler.ViewHandler.getInstance().popUpMode = loc1 > 0;
            return;
        }

        internal static function onTouchOutside(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (closeOnTouchOutside) 
            {
                closePopUp();
            }
            closeOnTouchOutside = false;
            return;
        }

        internal static function createCustomOverlayFactory():starling.display.DisplayObject
        {
            var quad:starling.display.Quad;

            var loc1:*;
            quad = null;
            quad = new starling.display.Quad(1, 1, starling.utils.Color.BLACK);
            quad.alpha = 0;
            quad.addEventListener(starling.events.Event.ADDED_TO_STAGE, function ():void
            {
                starling.core.Starling.juggler.tween(quad, TWEEN_DURATION, {"alpha":MODAL_ALPHA});
                quad.addEventListener(starling.events.TouchEvent.TOUCH, onTouchOutside);
                return;
            })
            quad.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, function ():void
            {
                quad.alpha = 0;
                quad.removeEventListener(starling.events.TouchEvent.TOUCH, onTouchOutside);
                return;
            })
            return quad;
        }

        public static function get FOOTER_HEIGHT():int
        {
            return frontend.components.popup.PopUpBase._253748299FOOTER_HEIGHT;
        }

        public static function get HEADER_HEIGHT():int
        {
            return frontend.components.popup.PopUpBase._907846425HEADER_HEIGHT;
        }

        public static function set HEADER_HEIGHT(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.popup.PopUpBase._907846425HEADER_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.popup.PopUpBase._907846425HEADER_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "HEADER_HEIGHT", loc1, arg1, frontend.components.popup.PopUpBase);
                loc3 = frontend.components.popup.PopUpBase.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get OUTER_PADDING():int
        {
            return frontend.components.popup.PopUpBase._529003507OUTER_PADDING;
        }

        public static function set OUTER_PADDING(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.popup.PopUpBase._529003507OUTER_PADDING;
            if (loc1 !== arg1) 
            {
                frontend.components.popup.PopUpBase._529003507OUTER_PADDING = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "OUTER_PADDING", loc1, arg1, frontend.components.popup.PopUpBase);
                loc3 = frontend.components.popup.PopUpBase.staticEventDispatcher;
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
            closeOnTouchOutside = false;
            currentPopUps = new flash.utils.Dictionary();
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public function close():void
        {
            closePopUp();
            return;
        }

        public function show(arg1:Boolean=true, arg2:Boolean=true, arg3:Boolean=true, arg4:Boolean=false):void
        {
            frontend.components.popup.PopUpBase.showModalPopUp(this, arg1, arg2, arg3, arg4);
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            debug.Debug.debug("[POPUP] onAddedToStage");
            removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            if (helper.Capabilities_helper.isAndroid() && this.popupIgnoresBackButton) 
            {
                stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            handler.ViewHandler.getInstance().handleAndroidBackButton = !this.popupIgnoresBackButton;
            this.initLayout();
            this.addContent();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            debug.Debug.debug("[POPUP] onRemovedFromStage");
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (helper.Capabilities_helper.isAndroid()) 
            {
                stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            handler.ViewHandler.getInstance().handleAndroidBackButton = true;
            if (this.closeCallback != null) 
            {
                this.closeCallback(this);
            }
            return;
        }

        protected function androidBackButtonHandler(arg1:starling.events.KeyboardEvent):void
        {
            debug.Debug.debug("[POPUP] androidBackButtonHandler");
            if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
            }
            return;
        }

        protected function createPopUpHeader():feathers.core.IFeathersControl
        {
            debug.Debug.debug("[POPUP] createPopUpHeader");
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = this.headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = title;
            loc3.layoutData = this.titleLayoutData;
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_POPUP_TITLE;
            loc2.addChild(loc3);
            var loc4:*=new frontend.components.button.IconButton();
            loc4.image = frontend.Textures.closeiconred;
            loc4.layoutData = this.closeIconLayoutData;
            loc4.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc2.addChild(loc4);
            return loc1;
        }

        protected function createPopUpFooter():feathers.core.IFeathersControl
        {
            debug.Debug.debug("createPopUpFooter");
            var loc1:*=new feathers.controls.LayoutGroup();
            if (!this.showCloseButton) 
            {
                return loc1;
            }
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = FOOTER_HEIGHT;
            loc2.layoutData = this.footerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Button();
            loc3.label = utils.LanguageManager.getString("CLOSE_BUTTON");
            loc3.layoutData = this.closeButtonLayoutData;
            loc3.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc2.addChild(loc3);
            return loc1;
        }

        protected function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            return;
        }

        protected function initLayout():void
        {
            FOOTER_HEIGHT = this.showCloseButton ? 90 * SIGMALink.scaleFactor : 0;
            HEADER_HEIGHT = 100 * SIGMALink.scaleFactor;
            this._layoutGap = 20 * SIGMALink.scaleFactor;
            OUTER_PADDING = 8 * SIGMALink.scaleFactor;
            this._doublePadding = OUTER_PADDING << 1;
            this.validatePopUpSize();
            this.headerLayoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            this.titleLayoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, this._layoutGap, NaN, 0);
            this.closeIconLayoutData = new feathers.layout.AnchorLayoutData(NaN, this._layoutGap, NaN, NaN, NaN, 0);
            this.footerLayoutData = new feathers.layout.AnchorLayoutData(0, NaN, 0, NaN, 0, 0);
            this.closeButtonLayoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, this._layoutGap);
            footerFactory = this.createPopUpFooter;
            headerFactory = this.createPopUpHeader;
            layout = new feathers.layout.AnchorLayout();
            this.contentLayoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            return;
        }

        protected function validatePopUpSize():void
        {
            width = SIGMALink.appWidth - this._doublePadding;
            height = SIGMALink.appHeight - this._doublePadding;
            return;
        }

        protected function addContent():void
        {
            this.contentHolder = new feathers.controls.LayoutGroup();
            this.contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.contentHolder.layout = new feathers.layout.AnchorLayout();
            this.contentHolder.layoutData = this.contentLayoutData;
            this.contentHolder.width = width;
            this.contentHolder.height = height - HEADER_HEIGHT - FOOTER_HEIGHT;
            this.myViewPort = new flash.geom.Rectangle(0, 0, this.contentHolder.width, this.contentHolder.height);
            addChild(this.contentHolder);
            return;
        }

        protected override function draw():void
        {
            this.customDraw();
            super.draw();
            return;
        }

        public static function set FOOTER_HEIGHT(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.popup.PopUpBase._253748299FOOTER_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.popup.PopUpBase._253748299FOOTER_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "FOOTER_HEIGHT", loc1, arg1, frontend.components.popup.PopUpBase);
                loc3 = frontend.components.popup.PopUpBase.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _doublePadding():int
        {
            return this._1627099903_doublePadding;
        }

        protected function set _doublePadding(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1627099903_doublePadding;
            if (loc1 !== arg1) 
            {
                this._1627099903_doublePadding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_doublePadding", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _layoutGap():int
        {
            return this._1431588301_layoutGap;
        }

        internal static const MODAL_ALPHA:Number=0.8;

        internal static const TWEEN_DURATION:Number=0.3;

        public static const CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP:String="tweenBottomToTop";

        public static const CUSTOM_TWEEN_DIRECTION_LEFT_TO_RIGHT:String="tweenLeftToRight";

        public static const CUSTOM_TWEEN_DIRECTION_RIGHT_TO_LEFT:String="tweenRightToLeft";

        public var closeCallback:Function;

        public var closeTweenDirection:String="tweenBottomToTop";

        public var contentHolder:feathers.controls.LayoutGroup;

        internal var _popupIgnoresBackButton:Boolean=true;

        protected var _backgroundSkinColor:uint=15658734;

        protected var _1627099903_doublePadding:int;

        protected var _1431588301_layoutGap:int;

        protected var _validate:Boolean=true;

        protected var closeButtonLayoutData:feathers.layout.AnchorLayoutData;

        protected var closeIconLayoutData:feathers.layout.AnchorLayoutData;

        protected var contentLayoutData:feathers.layout.AnchorLayoutData;

        protected var footerLayoutData:feathers.layout.AnchorLayoutData;

        protected var headerLayoutData:feathers.layout.AnchorLayoutData;

        protected var myViewPort:flash.geom.Rectangle;

        protected var titleLayoutData:feathers.layout.AnchorLayoutData;

        internal static var _907846425HEADER_HEIGHT:int;

        internal static var _529003507OUTER_PADDING:int;

        public static var closeOnTouchOutside:Boolean=false;

        public var showCloseButton:Boolean=false;

        internal static var currentPopUps:flash.utils.Dictionary;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        internal static var _253748299FOOTER_HEIGHT:int;
    }
}


//  class ProgressPopUp
package frontend.components.popup 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.utils.*;
    import frontend.components.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ProgressPopUp extends frontend.components.popup.PopUpBase
    {
        public function ProgressPopUp()
        {
            this.description = new feathers.controls.Label();
            this.headline = new feathers.controls.Label();
            this._2932247_gap = 20 * SIGMALink.scaleFactor;
            this._image = new frontend.components.TextureImage();
            this._percentageLabel = new feathers.controls.Label();
            this._progressBarHeight = 66 * SIGMALink.scaleFactor;
            this._progressBorderWidth = 9 * SIGMALink.scaleFactor;
            super();
            this.popupIgnoresBackButton = true;
            _backgroundSkinColor = core.general.Colors.RED;
            this._progressBar = new feathers.controls.ProgressBar();
            this._progressBar.styleProvider = null;
            this._progressBar.backgroundSkin = new starling.display.Quad(1, this._progressBarHeight - 4 * this._progressBorderWidth, core.general.Colors.RED);
            this._progressBar.fillSkin = new starling.display.Quad(1, this._progressBarHeight - 4 * this._progressBorderWidth, core.general.Colors.WHITE);
            return;
        }

        public function get imageTexture():String
        {
            return this._imageTexture;
        }

        internal function set _819554496imageTexture(arg1:String):void
        {
            this._imageTexture = arg1;
            if (this._image != null) 
            {
                this._image.includeInLayout = !(this._imageTexture == null);
            }
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight * 0.33;
            return;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            return new feathers.controls.LayoutGroup();
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            return new feathers.controls.LayoutGroup();
        }

        protected override function addContent():void
        {
            super.addContent();
            contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = this._gap;
            var loc2:*=new feathers.layout.HorizontalLayout();
            loc2.gap = this._gap;
            loc2.padding = this._gap;
            var loc3:*=new feathers.controls.LayoutGroup();
            loc3.layout = loc2;
            loc3.width = width;
            var loc4:*=new feathers.controls.LayoutGroup();
            loc4.layout = loc1;
            if (this._imageTexture == null) 
            {
                this._image.includeInLayout = false;
            }
            else 
            {
                this._image.textureName = this._imageTexture;
                this._image.includeInLayout = true;
            }
            contentHolder.addChild(loc3);
            loc3.addChild(this._image);
            loc3.addChild(loc4);
            this._image.validate();
            loc4.width = width - this._image.width - this._gap * 3;
            this.headline = new feathers.controls.Label();
            this.headline.text = title;
            this.description.maxWidth = loc4.width;
            this.headline.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_RED_POPUP_TITLE;
            loc4.addChild(this.headline);
            this.description.maxWidth = loc4.width;
            this.description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            this.description.wordWrap = true;
            loc4.addChild(this.description);
            var loc5:*=new feathers.controls.LayoutGroup();
            loc5.width = loc4.width;
            loc5.height = this._progressBarHeight;
            loc5.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc5.layout = new feathers.layout.AnchorLayout();
            var loc6:*=new feathers.controls.LayoutGroup();
            loc6.width = loc5.width - 2 * this._progressBorderWidth;
            loc6.height = loc5.height - 2 * this._progressBorderWidth;
            loc6.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc6.layout = new feathers.layout.AnchorLayout();
            loc6.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc5.addChild(loc6);
            this._progressBar.minimum = 0;
            this._progressBar.maximum = 100;
            this._progressBar.value = 0;
            this._progressBar.width = loc6.width - 2 * this._progressBorderWidth;
            this._progressBar.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc6.addChild(this._progressBar);
            loc4.addChild(loc5);
            this._percentageLabel.text = "";
            this._percentageLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc4.addChild(this._percentageLabel);
            return;
        }

        public function setProgressPercentage(arg1:uint):void
        {
            var loc1:*=NaN;
            if (this._progressBar == null) 
            {
                return;
            }
            if (arg1 > 100) 
            {
                arg1 = 100;
            }
            if (arg1 != 100) 
            {
                loc1 = arg1;
            }
            else 
            {
                loc1 = this._progressBar.value + arg1 / this._prgressAnimateToCompleteDuration;
            }
            if (loc1 > 100) 
            {
                loc1 = 100;
            }
            this._progressBar.value = loc1;
            this._progressBar.fillSkin.width = this._progressBar.width * this._progressBar.value / 100;
            this._percentageLabel.text = this._progressBar.value + "%";
            if (arg1 == 100) 
            {
                if (this._progressBar.value < 100) 
                {
                    flash.utils.setTimeout(this.setProgressPercentage, this._prgressAnimateToCompleteDuration, arg1);
                }
                else 
                {
                    flash.utils.setTimeout(this.onProgressComplete, this._prgressAnimateToCompleteDuration);
                }
            }
            return;
        }

        internal function onProgressComplete():void
        {
            dispatchEventWith(PROGRESS_COMPLETE);
            return;
        }

        public override function validate():void
        {
            super.validate();
            this.validatePopUpContent();
            return;
        }

        public function validatePopUpContent():void
        {
            this.headline.text = title;
            this.description.text = this.text;
            return;
        }

        public function set imageTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.imageTexture;
            if (loc1 !== arg1) 
            {
                this._819554496imageTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "imageTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _gap():Number
        {
            return this._2932247_gap;
        }

        internal function set _gap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2932247_gap;
            if (loc1 !== arg1) 
            {
                this._2932247_gap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_gap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static const PROGRESS_COMPLETE:String="progressCompleteEvent";

        internal var _imageTexture:String;

        public var text:String;

        protected var description:feathers.controls.Label;

        protected var headline:feathers.controls.Label;

        internal var _2932247_gap:Number;

        internal var _image:frontend.components.TextureImage;

        internal var _percentageLabel:feathers.controls.Label;

        internal var _prgressAnimateToCompleteDuration:uint=10;

        internal var _progressBar:feathers.controls.ProgressBar;

        internal var _progressBarHeight:Number;

        internal var _progressBorderWidth:Number;
    }
}


//  class SortPopUp
package frontend.components.popup 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.list.*;
    import starling.display.*;
    import utils.*;
    
    public class SortPopUp extends frontend.components.popup.PopUpBase
    {
        public function SortPopUp(arg1:__AS3__.vec.Vector.<frontend.components.list.ListSortItem>, arg2:String, arg3:Boolean=false)
        {
            this.sortItems = arg1;
            this.currentSortField = arg2;
            this.currentSortAscending = arg3;
            super();
            title = utils.LanguageManager.getString("SORT_POPUP.TITLE");
            _backgroundSkinColor = core.general.Colors.WHITE;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 0;
            HEADER_HEIGHT = 65 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth * 0.6;
            height = SIGMALink.appHeight * 0.33;
            minWidth = 240;
            minHeight = 240;
            x = (SIGMALink.appWidth - width) / 2;
            return;
        }

        protected override function initLayout():void
        {
            super.initLayout();
            footerFactory = null;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.height = HEADER_HEIGHT;
            loc1.layoutData = headerLayoutData;
            var loc2:*=new feathers.controls.Label();
            loc2.text = title;
            loc2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc1.addChild(loc2);
            return loc1;
        }

        protected override function addContent():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc4:*=null;
            super.addContent();
            loc1 = new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            contentHolder.layout = loc1;
            var loc3:*=this.sortItems.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = this.sortItems[loc2];
                loc4.ascending = loc4.sortField != this.currentSortField ? false : this.currentSortAscending;
                loc4.selected = loc4.sortField == this.currentSortField;
                loc4.sortFunction = this.applySort;
                contentHolder.addChild(loc4);
                ++loc2;
            }
            this.validatePopUpHeight();
            return;
        }

        protected function validatePopUpHeight():void
        {
            if (contentHolder.numChildren == 0) 
            {
                return;
            }
            var loc1:*=contentHolder.layout as feathers.layout.VerticalLayout;
            var loc2:*=contentHolder.getChildAt(0) as frontend.components.list.ListSortItem;
            height = HEADER_HEIGHT + contentHolder.numChildren * loc2.height + loc1.gap * (contentHolder.numChildren - 1);
            return;
        }

        internal function applySort(arg1:frontend.components.list.ListSortItem):void
        {
            var loc1:*=0;
            var loc2:*=this.sortItems.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (this.sortItems[loc1] != arg1) 
                {
                    this.sortItems[loc1].selected = false;
                }
                ++loc1;
            }
            if (this.sortCallback != null) 
            {
                this.sortCallback(arg1);
            }
            return;
        }

        public var sortCallback:Function;

        protected var sortItems:__AS3__.vec.Vector.<frontend.components.list.ListSortItem>;

        internal var currentSortAscending:Boolean=false;

        internal var currentSortField:String;
    }
}


