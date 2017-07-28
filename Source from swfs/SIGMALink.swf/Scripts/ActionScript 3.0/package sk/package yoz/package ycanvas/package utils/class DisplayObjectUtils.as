//class DisplayObjectUtils
package sk.yoz.ycanvas.utils 
{
    import flash.display.*;
    import flash.geom.*;
    
    public class DisplayObjectUtils extends Object
    {
        public function DisplayObjectUtils()
        {
            super();
            return;
        }

        public static function getConcatenatedMatrix(arg1:flash.display.DisplayObject):flash.geom.Matrix
        {
            var loc1:*=new flash.geom.Matrix();
            var loc2:*=arg1;
            while (loc2) 
            {
                loc1.concat(loc2.transform.matrix);
                loc2 = loc2.parent;
            }
            return loc1;
        }
    }
}


