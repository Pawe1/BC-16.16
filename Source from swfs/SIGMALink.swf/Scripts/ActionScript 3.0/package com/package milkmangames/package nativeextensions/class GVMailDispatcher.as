//class GVMailDispatcher
package com.milkmangames.nativeextensions 
{
    import com.milkmangames.nativeextensions.events.*;
    
    public class GVMailDispatcher extends com.milkmangames.nativeextensions.GVDispatcher
    {
        public function GVMailDispatcher()
        {
            super();
            return;
        }

        public function addDialogListener(arg1:Function):com.milkmangames.nativeextensions.GVMailDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_CANCELED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_FAILED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_SAVED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_SENT, arg1);
            return this;
        }
    }
}


