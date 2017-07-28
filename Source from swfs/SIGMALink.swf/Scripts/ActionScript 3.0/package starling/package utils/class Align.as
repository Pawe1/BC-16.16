//class Align
package starling.utils 
{
    import starling.errors.*;
    
    public final class Align extends Object
    {
        public function Align()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function isValid(arg1:String):Boolean
        {
            return arg1 == LEFT || arg1 == RIGHT || arg1 == CENTER || arg1 == TOP || arg1 == BOTTOM;
        }

        public static function isValidHorizontal(arg1:String):Boolean
        {
            return arg1 == LEFT || arg1 == CENTER || arg1 == RIGHT;
        }

        public static function isValidVertical(arg1:String):Boolean
        {
            return arg1 == TOP || arg1 == CENTER || arg1 == BOTTOM;
        }

        public static const LEFT:String="left";

        public static const RIGHT:String="right";

        public static const TOP:String="top";

        public static const BOTTOM:String="bottom";

        public static const CENTER:String="center";
    }
}


