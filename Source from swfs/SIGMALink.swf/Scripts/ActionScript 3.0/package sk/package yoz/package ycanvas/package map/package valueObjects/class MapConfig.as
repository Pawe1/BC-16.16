//class MapConfig
package sk.yoz.ycanvas.map.valueObjects 
{
    import __AS3__.vec.*;
    
    public class MapConfig extends Object
    {
        public function MapConfig()
        {
            super();
            return;
        }

        public var urlTemplates:__AS3__.vec.Vector.<String>;

        public var tileWidth:uint;

        public var tileHeight:uint;

        public var forTouch:Boolean=true;
    }
}


