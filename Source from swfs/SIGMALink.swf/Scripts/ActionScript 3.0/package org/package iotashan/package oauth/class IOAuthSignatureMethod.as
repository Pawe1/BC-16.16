//class IOAuthSignatureMethod
package org.iotashan.oauth 
{
    public dynamic interface IOAuthSignatureMethod
    {
        function get name():String;

        function signRequest(arg1:org.iotashan.oauth.OAuthRequest):String;
    }
}


