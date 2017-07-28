//class URLEncoding
package org.iotashan.utils 
{
    public class URLEncoding extends Object
    {
        public function URLEncoding()
        {
            super();
            return;
        }

        public static function utf8Encode(arg1:String):String
        {
            var loc1:*=0;
            var loc3:*=NaN;
            arg1 = arg1.replace(new RegExp("\\r\\n", "g"), "\n");
            arg1 = arg1.replace(new RegExp("\\r", "g"), "\n");
            var loc2:*="";
            loc1 = 0;
            while (loc1 < arg1.length) 
            {
                if ((loc3 = arg1.charCodeAt(loc1)) < 128) 
                {
                    loc2 = loc2 + String.fromCharCode(loc3);
                }
                else if (loc3 > 127 && loc3 < 2048) 
                {
                    loc2 = loc2 + String.fromCharCode(loc3 >> 6 | 192);
                    loc2 = loc2 + String.fromCharCode(loc3 & 63 | 128);
                }
                else 
                {
                    loc2 = loc2 + String.fromCharCode(loc3 >> 12 | 224);
                    loc2 = loc2 + String.fromCharCode(loc3 >> 6 & 63 | 128);
                    loc2 = loc2 + String.fromCharCode(loc3 & 63 | 128);
                }
                ++loc1;
            }
            return loc2;
        }

        public static function urlEncode(arg1:String):String
        {
            var loc2:*=0;
            var loc3:*=NaN;
            var loc1:*="";
            loc2 = 0;
            while (loc2 < arg1.length) 
            {
                if ((loc3 = arg1.charCodeAt(loc2)) >= 48 && loc3 <= 57 || loc3 >= 65 && loc3 <= 90 || loc3 >= 97 && loc3 <= 122 || loc3 == 45 || loc3 == 95 || loc3 == 46 || loc3 == 126) 
                {
                    loc1 = loc1 + String.fromCharCode(loc3);
                }
                else 
                {
                    loc1 = loc1 + ("%" + loc3.toString(16).toUpperCase());
                }
                ++loc2;
            }
            return loc1;
        }

        public static function encode(arg1:String):String
        {
            return urlEncode(utf8Encode(arg1));
        }

        public static function decode(arg1:String):*
        {
            var loc5:*=NaN;
            var loc3:*=null;
            var loc2:*=null;
            var loc1:*=arg1;
            var loc4:*=new RegExp("(%[^%]{2})");
            var loc6:*=new RegExp("\\+", "gm");
            loc1 = loc1.replace(loc6, " ");
            while (!((loc2 = loc4.exec(loc1)) == null) && loc2.length > 1 && !(loc2[1] == "")) 
            {
                loc5 = parseInt(loc2[1].substr(1), 16);
                loc3 = String.fromCharCode(loc5);
                loc1 = loc1.replace(loc2[1], loc3);
            }
            return loc1;
        }
    }
}


