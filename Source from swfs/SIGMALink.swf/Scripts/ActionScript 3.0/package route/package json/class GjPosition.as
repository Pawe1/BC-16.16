//class GjPosition
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


