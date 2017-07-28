//class GVFacebookDispatcher
package com.milkmangames.nativeextensions 
{
    import com.milkmangames.nativeextensions.events.*;
    
    public class GVFacebookDispatcher extends com.milkmangames.nativeextensions.GVDispatcher
    {
        public function GVFacebookDispatcher()
        {
            super();
            return;
        }

        public function addRequestListener(arg1:Function):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_RESPONSE, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_FAILED, arg1);
            return this;
        }

        public function addDialogListener(arg1:Function):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_CANCELED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_FAILED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_FINISHED, arg1);
            return this;
        }

        public function addAdIdListener(arg1:Function):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_AD_ID_RESPONSE, arg1);
            return this;
        }
    }
}


