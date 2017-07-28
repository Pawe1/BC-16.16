//class GVShareDispatcher
package com.milkmangames.nativeextensions 
{
    import com.milkmangames.nativeextensions.events.*;
    
    public class GVShareDispatcher extends com.milkmangames.nativeextensions.GVDispatcher
    {
        public function GVShareDispatcher()
        {
            super();
            return;
        }

        public function addDialogListener(arg1:Function):com.milkmangames.nativeextensions.GVShareDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVShareEvent.GENERIC_MESSAGE_SHARED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_CANCELED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_FINISHED, arg1);
            return this;
        }
    }
}


