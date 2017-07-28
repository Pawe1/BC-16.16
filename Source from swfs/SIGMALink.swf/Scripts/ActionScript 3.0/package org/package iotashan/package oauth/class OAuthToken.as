//class OAuthToken
package org.iotashan.oauth 
{
    public class OAuthToken extends Object
    {
        public function OAuthToken(arg1:String="", arg2:String="")
        {
            super();
            _key = arg1;
            _secret = arg2;
            return;
        }

        public function get key():String
        {
            return _key;
        }

        public function set key(arg1:String):void
        {
            if (arg1 != _key) 
            {
                _key = arg1;
            }
            return;
        }

        public function get secret():String
        {
            return _secret;
        }

        public function set secret(arg1:String):void
        {
            if (arg1 != _secret) 
            {
                _secret = arg1;
            }
            return;
        }

        public function get isEmpty():Boolean
        {
            if (key.length == 0 && secret.length == 0) 
            {
                return true;
            }
            return false;
        }

        internal var _key:String;

        internal var _secret:String;
    }
}


