//class GjPoint
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


