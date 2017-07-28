//package layers
//  class Layer
package sk.yoz.ycanvas.map.layers 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.starling.interfaces.*;
    import starling.display.*;
    
    public class Layer extends Object implements sk.yoz.ycanvas.starling.interfaces.ILayerStarling
    {
        public function Layer(arg1:uint, arg2:sk.yoz.ycanvas.map.valueObjects.MapConfig, arg3:sk.yoz.ycanvas.interfaces.IPartitionFactory)
        {
            _center = new flash.geom.Point();
            _partitions = new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
            _content = new starling.display.Sprite();
            super();
            _level = arg1;
            this.config = arg2;
            this.partitionFactory = arg3;
            content.touchable = false;
            return;
        }

        public function get content():starling.display.DisplayObjectContainer
        {
            return _content;
        }

        public function set center(arg1:flash.geom.Point):void
        {
            var loc2:*=0;
            _center = arg1;
            var loc1:*=partitions.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                positionPartition(partitions[loc2]);
                ++loc2;
            }
            return;
        }

        public function get center():flash.geom.Point
        {
            return _center;
        }

        public function set scale(arg1:Number):void
        {
            var loc1:*;
            content.scaleY = loc1 = arg1;
            content.scaleX = loc1;
            return;
        }

        public function get level():uint
        {
            return _level;
        }

        public function get partitions():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>
        {
            return _partitions;
        }

        public function get partitionWidth():uint
        {
            return config.tileWidth;
        }

        public function get partitionHeight():uint
        {
            return config.tileHeight;
        }

        public function addPartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void
        {
            if (partitions.indexOf(arg1) != -1) 
            {
                return;
            }
            partitions.push(arg1);
            positionPartition(arg1);
            content.addChild((arg1 as sk.yoz.ycanvas.starling.interfaces.IPartitionStarling).content);
            return;
        }

        public function getPartition(arg1:int, arg2:int):sk.yoz.ycanvas.interfaces.IPartition
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=partitions.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = partitions[loc3];
                if (loc1.x == arg1 && loc1.y == arg2) 
                {
                    return loc1;
                }
                ++loc3;
            }
            return null;
        }

        public function removePartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void
        {
            var loc2:*=arg1 as sk.yoz.ycanvas.starling.interfaces.IPartitionStarling;
            if (loc2.content) 
            {
                content.removeChild(loc2.content);
            }
            var loc1:*=partitions.indexOf(arg1);
            if (loc1 != -1) 
            {
                partitions.splice(loc1, 1);
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            if (!partitions.length) 
            {
                return;
            }
            var loc4:*=partitions.concat();
            loc3 = 0;
            loc2 = loc4.length;
            while (loc3 < loc2) 
            {
                loc1 = loc4[loc3];
                removePartition(loc1);
                partitionFactory.disposePartition(loc1);
                ++loc3;
            }
            return;
        }

        internal function positionPartition(arg1:sk.yoz.ycanvas.interfaces.IPartition):void
        {
            var loc1:*=arg1 as sk.yoz.ycanvas.starling.interfaces.IPartitionStarling;
            loc1.content.x = (arg1.x - center.x) / level;
            loc1.content.y = (arg1.y - center.y) / level;
            return;
        }

        public function toString():String
        {
            return "Layer: [level:" + level + "]";
        }

        public var config:sk.yoz.ycanvas.map.valueObjects.MapConfig;

        internal var partitionFactory:sk.yoz.ycanvas.interfaces.IPartitionFactory;

        internal var _level:uint;

        internal var _center:flash.geom.Point;

        internal var _partitions:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>;

        internal var _content:starling.display.Sprite;
    }
}


//  class LayerFactory
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


