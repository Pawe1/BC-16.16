//class JSON
package com.adobe.serialization.json 
{
    public class JSON extends Object
    {
        public function JSON()
        {
            super();
            return;
        }

        public static function decode(arg1:String, arg2:Boolean=true):*
        {
            return new com.adobe.serialization.json.JSONDecoder(arg1, arg2).getValue();
        }

        public static function encode(arg1:Object):String
        {
            return new com.adobe.serialization.json.JSONEncoder(arg1).getString();
        }
    }
}


