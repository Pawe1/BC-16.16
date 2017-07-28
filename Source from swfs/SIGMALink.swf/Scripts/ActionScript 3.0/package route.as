//package route
//  package json
//    package geometry
//      class GjGeometry
package route.json.geometry 
{
    import flash.errors.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class GjGeometry extends flash.events.EventDispatcher
    {
        public function GjGeometry()
        {
            super();
            return;
        }

        public function get toJSON():String
        {
            throw new flash.errors.IllegalOperationError("Please override this method");
            return null;
        }

        public static function fromObject(arg1:Object):route.json.geometry.GjGeometry
        {
            var loc2:*=null;
            var loc1:*=null;
            if (!arg1.hasOwnProperty("type")) 
            {
                return null;
            }
            if (flash.utils.getQualifiedClassName(arg1.type) != flash.utils.getQualifiedClassName(String)) 
            {
                return null;
            }
            try 
            {
                loc2 = flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(GjGeometry).replace("Geometry", arg1.type as String)) as Class;
                if (flash.utils.getQualifiedSuperclassName(loc2) != flash.utils.getQualifiedClassName(GjGeometry)) 
                {
                    var loc4:*;
                    return loc4 = null;
                }
                loc1 = loc2.fromObject(arg1);
            }
            catch (error:Error)
            {
                var loc5:*=null;
                return loc5;
            }
            return loc1;
        }

        public static const EVENT_COORDINATES_CHANGED:String="CoordinatesChangedEvent";
    }
}


//      class GjPoint
package route.json.geometry 
{
    import route.json.*;
    
    public class GjPoint extends route.json.geometry.GjGeometry
    {
        public function GjPoint(arg1:Number=NaN, arg2:Number=NaN, arg3:Number=NaN)
        {
            coordinates = new route.json.GjPosition();
            super();
            coordinates.longitude = arg1;
            coordinates.latitude = arg2;
            coordinates.altitude = arg3;
            return;
        }

        public function get altitude():Number
        {
            return coordinates.altitude;
        }

        public function set altitude(arg1:Number):void
        {
            coordinates.altitude = arg1;
            return;
        }

        public function get latitude():Number
        {
            return coordinates.latitude;
        }

        public function set latitude(arg1:Number):void
        {
            coordinates.latitude = arg1;
            return;
        }

        public function get longitude():Number
        {
            return coordinates.longitude;
        }

        public function set longitude(arg1:Number):void
        {
            coordinates.longitude = arg1;
            return;
        }

        public override function get toJSON():String
        {
            var loc1:*="{";
            loc1 = loc1 + "\"type\":\"Point\",";
            loc1 = loc1 + ("\"coordinates\":" + coordinates.toJSON);
            loc1 = loc1 + "}";
            return loc1;
        }

        public function asGjPoint():route.json.geometry.GjPoint
        {
            return new route.json.geometry.GjPoint(this.coordinates.longitude, this.coordinates.latitude, this.coordinates.altitude);
        }

        public static function fromObject(arg1:Object):route.json.geometry.GjPoint
        {
            if (!arg1.hasOwnProperty("type")) 
            {
                return null;
            }
            if (arg1.type != "Point") 
            {
                return null;
            }
            if (!arg1.hasOwnProperty("coordinates")) 
            {
                return null;
            }
            var loc1:*=new GjPoint();
            loc1.coordinates = route.json.GjPosition.fromJSON(arg1.coordinates);
            if (!loc1.coordinates) 
            {
                return null;
            }
            return loc1;
        }

        public static const type:String="Point";

        public var coordinates:route.json.GjPosition;
    }
}


//    class GjPosition
package route.json 
{
    import flash.utils.*;
    
    public dynamic class GjPosition extends Array
    {
        public function GjPosition(... rest)
        {
            super(rest);
            return;
        }

        public function get altitude():Number
        {
            if (this[5] is Number) 
            {
                return this[5];
            }
            return NaN;
        }

        public function set altitude(arg1:Number):void
        {
            this[5] = arg1;
            return;
        }

        public function get direction():Number
        {
            if (this[2] is Number) 
            {
                return this[2];
            }
            return NaN;
        }

        public function set direction(arg1:Number):void
        {
            this[2] = arg1;
            return;
        }

        public function get distance():Number
        {
            if (this[4] is Number) 
            {
                return this[4];
            }
            return NaN;
        }

        public function set distance(arg1:Number):void
        {
            this[4] = arg1;
            return;
        }

        public function get latitude():Number
        {
            if (this[1] is Number) 
            {
                return this[1];
            }
            return NaN;
        }

        public function set latitude(arg1:Number):void
        {
            this[1] = arg1;
            return;
        }

        public function get longitude():Number
        {
            if (this[0] is Number) 
            {
                return this[0];
            }
            return NaN;
        }

        public function set longitude(arg1:Number):void
        {
            this[0] = arg1;
            return;
        }

        public function get street():String
        {
            if (this[3] is String) 
            {
                return this[3];
            }
            return "";
        }

        public function set street(arg1:String):void
        {
            this[3] = arg1;
            return;
        }

        public function get toJSON():String
        {
            return "[" + longitude + "," + latitude + "]";
        }

        public static function fromJSON(arg1:Object):route.json.GjPosition
        {
            if (!(flash.utils.getQualifiedClassName(arg1) == flash.utils.getQualifiedClassName(Array)) || (arg1 as Array).length < 2) 
            {
                return null;
            }
            var loc1:*=new GjPosition(6);
            if ((arg1 as Array).length != 3) 
            {
                if ((arg1 as Array).length != 6) 
                {
                    if ((arg1 as Array).length == 5) 
                    {
                        loc1.longitude = (arg1 as Array)[0];
                        loc1.latitude = (arg1 as Array)[1];
                        loc1.direction = (arg1 as Array)[2];
                        loc1.street = (arg1 as Array)[3];
                        loc1.distance = (arg1 as Array)[4];
                        loc1.altitude = 0;
                    }
                }
                else 
                {
                    loc1.longitude = (arg1 as Array)[0];
                    loc1.latitude = (arg1 as Array)[1];
                    loc1.direction = (arg1 as Array)[2];
                    loc1.street = (arg1 as Array)[3];
                    loc1.distance = (arg1 as Array)[4];
                    loc1.altitude = (arg1 as Array)[5];
                }
            }
            else 
            {
                loc1.longitude = (arg1 as Array)[0];
                loc1.latitude = (arg1 as Array)[1];
                loc1.altitude = (arg1 as Array)[2];
            }
            return loc1;
        }
    }
}


