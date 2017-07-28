//class LayerFactory
package sk.yoz.ycanvas.map.layers 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    
    public class LayerFactory extends Object implements sk.yoz.ycanvas.interfaces.ILayerFactory
    {
        public function LayerFactory(arg1:sk.yoz.ycanvas.map.valueObjects.MapConfig, arg2:sk.yoz.ycanvas.interfaces.IPartitionFactory)
        {
            var loc1:*=0;
            layers = new __AS3__.vec.Vector.<sk.yoz.ycanvas.map.layers.Layer>();
            super();
            loc1 = 1;
            while (loc1 <= 32768) 
            {
                layers.push(new sk.yoz.ycanvas.map.layers.Layer(loc1, arg1, arg2));
                loc1 = loc1 * 2;
            }
            return;
        }

        public function create(arg1:Number, arg2:flash.geom.Point):sk.yoz.ycanvas.interfaces.ILayer
        {
            return getLayerByScale(arg1);
        }

        public function disposeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            sk.yoz.ycanvas.map.layers.Layer(arg1).dispose();
            return;
        }

        internal function getLayerByScale(arg1:Number):sk.yoz.ycanvas.map.layers.Layer
        {
            return layers[getLayerIndex(arg1)];
        }

        protected function getLayerIndex(arg1:Number):uint
        {
            var loc2:*=0;
            var loc3:*=1 / arg1 * CUSTOM_TILE_SCALE;
            var loc1:*=layers.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (loc3 < 1 << loc2) 
                {
                    break;
                }
                ++loc2;
            }
            return Math.min((loc1 - 1), loc2);
        }

        internal var layers:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.layers.Layer>;

        public static var CUSTOM_SCALE_STEPS:Number=1.5;

        public static var CUSTOM_TILE_SCALE:Number=1;
    }
}


