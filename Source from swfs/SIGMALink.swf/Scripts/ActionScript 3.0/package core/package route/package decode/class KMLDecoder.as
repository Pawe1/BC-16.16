//class KMLDecoder
package core.route.decode 
{
    import __AS3__.vec.*;
    import core.route.*;
    import flash.events.*;
    
    public class KMLDecoder extends flash.events.EventDispatcher
    {
        public function KMLDecoder()
        {
            super();
            return;
        }

        public static function decodeRoute(arg1:XML):core.route.Route
        {
            var loc9:*=null;
            var loc11:*=null;
            var loc6:*=null;
            var loc12:*=null;
            var loc3:*=null;
            var loc8:*=null;
            var loc4:*=null;
            var loc5:*=0;
            arg1.normalize();
            var loc13:*;
            if (loc13 = arg1.namespaceDeclarations()) 
            {
                var loc15:*=0;
                var loc14:*=loc13;
                for each (var loc1:* in loc14) 
                {
                    if (!(loc1.prefix == "")) 
                    {
                        continue;
                    }
                    loc9 = loc1;
                }
            }
            var loc7:*;
            (loc7 = new core.route.Route()).name = arg1.loc9::Document.loc9::name;
            loc7.description = arg1.loc9::Document.loc9::description;
            loc7.creationTimestamp = new Date();
            loc7.routePoints = new __AS3__.vec.Vector.<core.route.RoutePoint>();
            var loc2:*=loc9;
            var loc17:*=0;
            var loc16:*=loc2;
            for each (var loc10:* in loc16) 
            {
                loc10.normalize();
                loc11 = loc10.loc9::coordinates;
                loc6 = new RegExp("\r\n|\r|\n", "ig");
                loc12 = (loc11 = (loc11 = loc11.replace(loc6, "#")).replace(new RegExp("\\s", "g"), "")).split("#");
                loc5 = 0;
                while (loc5 < loc12.length) 
                {
                    if ((loc3 = loc12[loc5].split(",")).length == 3) 
                    {
                        (loc8 = new core.route.RoutePoint()).routeId = loc7.routeId;
                        loc8.longitude = loc3[0];
                        loc8.latitude = loc3[1];
                        loc8.altitude = loc3[2] * 1000;
                        loc8.routingType = "imported";
                        loc8.userPoint = false;
                        loc7.routePoints.push(loc8);
                    }
                    ++loc5;
                }
            }
            core.route.Route.setImportedRouteStartPoints(loc7);
            return loc7;
        }
    }
}


