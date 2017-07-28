//class Debug
package de.pagecon.ane.nfc.debug 
{
    import flash.globalization.*;
    
    public class Debug extends Object
    {
        public function Debug()
        {
            super();
            return;
        }

        public static function addlog(... rest):void
        {
            var loc7:*=0;
            if (!DEBUG_MODE) 
            {
                return;
            }
            var loc1:*="";
            var loc12:*="";
            var loc3:*="";
            var loc6:*="";
            var loc2:*="";
            var loc4:*="";
            var loc5:*;
            var loc10:*;
            var loc11:*;
            if ((loc11 = (loc10 = (loc5 = new Error()).getStackTrace()).split("\n")).hasOwnProperty(2)) 
            {
                loc6 = (loc12 = loc11[2].slice(4, loc11[2].length)).split("/")[0] + " ::: ";
                loc4 = loc12.split("()")[0] + "() -> ";
                if (loc11.hasOwnProperty(3)) 
                {
                    loc1 = loc11[3].slice(4, loc11[3].length);
                    loc3 = loc1.split("/")[0] + " ::: ";
                    loc2 = loc1.split("()")[0] + "() -> ";
                }
            }
            var loc9:*=new flash.globalization.DateTimeFormatter("i-default", "short", "none");
            var loc8:*="HH:mm:ss";
            loc9.setDateTimePattern(loc8);
            loc7 = 0;
            while (loc7 < rest.length) 
            {
                trace("[" + loc9.format(new Date()) + "] [NFCANE] ::: " + loc2 + loc4 + rest[loc7].toString());
                ++loc7;
            }
            return;
        }

        public static var DEBUG_MODE:Boolean=true;
    }
}


