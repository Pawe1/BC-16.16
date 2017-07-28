//class GetAccessTokenEvent
package com.adobe.protocols.oauth2.event 
{
    import flash.events.*;
    
    public class GetAccessTokenEvent extends flash.events.Event implements com.adobe.protocols.oauth2.event.IOAuth2Event
    {
        public function GetAccessTokenEvent(arg1:Boolean=false, arg2:Boolean=false)
        {
            super("getAccessToken", arg1, arg2);
            return;
        }

        public function parseAccessTokenResponse(arg1:Object):void
        {
            _accessToken = arg1.access_token;
            _tokenType = arg1.token_type;
            _expiresIn = arg1.expires_in;
            _refreshToken = arg1.refresh_token;
            _scope = arg1.scope;
            _state = arg1.state;
            _response = arg1;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.adobe.protocols.oauth2.event.GetAccessTokenEvent();
        }

        public function get errorCode():String
        {
            return _errorCode;
        }

        public function set errorCode(arg1:String):void
        {
            _errorCode = arg1;
            return;
        }

        public function get errorMessage():String
        {
            return _errorMessage;
        }

        public function set errorMessage(arg1:String):void
        {
            _errorMessage = arg1;
            return;
        }

        public function get accessToken():String
        {
            return _accessToken;
        }

        public function get tokenType():String
        {
            return _tokenType;
        }

        public function get expiresIn():int
        {
            return _expiresIn;
        }

        public function get refreshToken():String
        {
            return _refreshToken;
        }

        public function get scope():String
        {
            return _scope;
        }

        public function get state():String
        {
            return _state;
        }

        public function get response():Object
        {
            return _response;
        }

        public static const TYPE:String="getAccessToken";

        internal var _errorCode:String;

        internal var _errorMessage:String;

        internal var _accessToken:String;

        internal var _tokenType:String;

        internal var _expiresIn:int;

        internal var _refreshToken:String;

        internal var _scope:String;

        internal var _state:String;

        internal var _response:Object;
    }
}


