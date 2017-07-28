//package oauth
//  class CustomOAuth
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


//  class CustomWebView
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


