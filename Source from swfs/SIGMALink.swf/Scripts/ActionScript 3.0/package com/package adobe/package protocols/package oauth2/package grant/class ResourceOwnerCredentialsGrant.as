//class ResourceOwnerCredentialsGrant
package com.adobe.protocols.oauth2.grant 
{
    public class ResourceOwnerCredentialsGrant extends Object implements com.adobe.protocols.oauth2.grant.IGrantType
    {
        public function ResourceOwnerCredentialsGrant(arg1:String, arg2:String, arg3:String, arg4:String, arg5:String=null)
        {
            super();
            _clientId = arg1;
            _clientSecret = arg2;
            _username = arg3;
            _password = arg4;
            _scope = arg5;
            return;
        }

        public function get clientId():String
        {
            return _clientId;
        }

        public function get clientSecret():String
        {
            return _clientSecret;
        }

        public function get username():String
        {
            return _username;
        }

        public function get password():String
        {
            return _password;
        }

        public function get scope():String
        {
            return _scope;
        }

        internal var _clientId:String;

        internal var _clientSecret:String;

        internal var _username:String;

        internal var _password:String;

        internal var _scope:String;
    }
}


