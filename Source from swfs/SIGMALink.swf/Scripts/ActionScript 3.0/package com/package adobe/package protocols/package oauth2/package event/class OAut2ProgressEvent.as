//class OAut2ProgressEvent
package com.adobe.protocols.oauth2.event 
{
    import flash.events.*;
    
    public class OAut2ProgressEvent extends flash.events.Event
    {
        public function OAut2ProgressEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public static const PROGRESS:String="progressEvent";

        public var authorizationCode:String;

        public var accessToken:String;
    }
}


