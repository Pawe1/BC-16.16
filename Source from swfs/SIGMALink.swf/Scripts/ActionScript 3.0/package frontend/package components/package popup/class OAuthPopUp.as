//class OAuthPopUp
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


