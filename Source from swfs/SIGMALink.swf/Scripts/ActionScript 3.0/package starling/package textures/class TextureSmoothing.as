//class TextureSmoothing
package starling.textures 
{
    import starling.errors.*;
    
    public class TextureSmoothing extends Object
    {
        public function TextureSmoothing()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function isValid(arg1:String):Boolean
        {
            return arg1 == NONE || arg1 == BILINEAR || arg1 == TRILINEAR;
        }

        public static const NONE:String="none";

        public static const BILINEAR:String="bilinear";

        public static const TRILINEAR:String="trilinear";
    }
}


