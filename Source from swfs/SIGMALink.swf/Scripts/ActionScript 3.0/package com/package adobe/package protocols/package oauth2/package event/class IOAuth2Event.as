//class IOAuth2Event
package com.adobe.protocols.oauth2.event 
{
    public dynamic interface IOAuth2Event
    {
        function get errorCode():String;

        function set errorCode(arg1:String):void;

        function get errorMessage():String;

        function set errorMessage(arg1:String):void;
    }
}


