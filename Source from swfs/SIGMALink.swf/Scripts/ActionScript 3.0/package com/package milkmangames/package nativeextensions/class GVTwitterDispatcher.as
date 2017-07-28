//class GVTwitterDispatcher
package com.milkmangames.nativeextensions 
{
    import com.milkmangames.nativeextensions.events.*;
    
    public class GVTwitterDispatcher extends com.milkmangames.nativeextensions.GVDispatcher
    {
        public function GVTwitterDispatcher()
        {
            super();
            return;
        }

        public function addDialogListener(arg1:Function):com.milkmangames.nativeextensions.GVTwitterDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVTwitterEvent.TW_DIALOG_CANCELED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVTwitterEvent.TW_DIALOG_FAILED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVTwitterEvent.TW_DIALOG_FINISHED, arg1);
            return this;
        }
    }
}


