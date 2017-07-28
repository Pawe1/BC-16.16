//class Debug
package de.pagecon.ane.notificationlistenerservice.debug 
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
            var loc8:*=0;
            if (!DEBUG_MODE) 
            {
                return;
            }
            var loc2:*="";
            var loc3:*="";
            var loc5:*="";
            var loc1:*="";
            var loc7:*="";
            var loc4:*="";
            var loc11:*;
            var loc12:*;
            var loc6:*;
            if ((loc6 = (loc12 = (loc11 = new Error()).getStackTrace()).split("\n")).hasOwnProperty(2)) 
            {
                loc1 = (loc3 = loc6[2].slice(4, loc6[2].length)).split("/")[0] + " ::: ";
                loc4 = loc3.split("()")[0] + "() -> ";
                if (loc6.hasOwnProperty(3)) 
                {
                    loc2 = loc6[3].slice(4, loc6[3].length);
                    loc5 = loc2.split("/")[0] + " ::: ";
                    loc7 = loc2.split("()")[0] + "() -> ";
                }
            }
            var loc9:*=new flash.globalization.DateTimeFormatter("i-default", "short", "none");
            var loc10:*="HH:mm:ss";
            loc9.setDateTimePattern(loc10);
            loc8 = 0;
            while (loc8 < rest.length) 
            {
                trace("[" + loc9.format(new Date()) + "] [NOTIFICATION LISTENER SERVICE ANE] ::: " + loc7 + loc4 + rest[loc8].toString());
                ++loc8;
            }
            return;
        }

        public static var DEBUG_MODE:Boolean=true;
    }
}


