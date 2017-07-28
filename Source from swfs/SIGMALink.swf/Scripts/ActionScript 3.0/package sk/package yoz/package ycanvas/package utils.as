//package utils
//  class DisplayObjectUtils
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


//  class ILayerUtils
package sk.yoz.ycanvas.utils 
{
    import __AS3__.vec.*;
    import sk.yoz.ycanvas.*;
    
    public class ILayerUtils extends Object
    {
        public function ILayerUtils()
        {
            super();
            return;
        }

        public static function disposeDeep(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:uint=1):void
        {
            var loc3:*=0;
            var loc1:*=arg1.layers.concat();
            var loc2:*=Math.max(loc1.length - arg2, 0);
            loc3 = 0;
            while (loc3 < loc2) 
            {
                arg1.disposeLayer(loc1[loc3]);
                ++loc3;
            }
            return;
        }

        public static function disposeEmpty(arg1:sk.yoz.ycanvas.AbstractYCanvas):void
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=arg1.layers.concat();
            loc3 = 0;
            loc2 = loc1.length;
            while (loc3 < loc2) 
            {
                if (!loc1[loc3].partitions.length) 
                {
                    arg1.disposeLayer(loc1[loc3]);
                }
                ++loc3;
            }
            return;
        }
    }
}


//  class IPartitionUtils
package sk.yoz.ycanvas.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.valueObjects.*;
    
    public class IPartitionUtils extends Object
    {
        public function IPartitionUtils()
        {
            super();
            return;
        }

        public static function getOverlaping(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            return getOverlapingByMode(arg1, arg2, arg3, 0);
        }

        public static function getLower(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            return getOverlapingByMode(arg1, arg2, arg3, 1);
        }

        public static function getUpper(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            return getOverlapingByMode(arg1, arg2, arg3, 2);
        }

        internal static function getOverlapingByMode(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition, arg4:uint):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            var loc8:*=0;
            var loc5:*=null;
            var loc1:*=null;
            var loc12:*=undefined;
            var loc6:*=null;
            var loc3:*=0;
            var loc2:*=0;
            var loc4:*=0;
            var loc10:*=arg1.layers;
            var loc11:*=arg4 == 1;
            var loc9:*=arg4 == 2;
            var loc7:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>();
            loc3 = 0;
            loc2 = loc10.length;
            while (loc3 < loc2) 
            {
                if (!((loc1 = loc10[loc3]) == arg2 || loc11 && loc1.level > arg2.level || loc9 && loc1.level < arg2.level)) 
                {
                    loc8 = (loc12 = loc1.partitions.concat()).length;
                    (loc6 = new sk.yoz.ycanvas.valueObjects.LayerPartitions()).layer = loc1;
                    loc6.partitions = new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
                    loc7.push(loc6);
                    loc4 = 0;
                    while (loc4 < loc8) 
                    {
                        loc5 = loc12[loc4];
                        if (isOverlaping(arg2, arg3, loc1, loc5)) 
                        {
                            loc6.partitions.push(loc5);
                        }
                        ++loc4;
                    }
                }
                ++loc3;
            }
            return loc7;
        }

        public static function disposeInvisible(arg1:sk.yoz.ycanvas.AbstractYCanvas):void
        {
            var loc1:*=undefined;
            var loc5:*=null;
            var loc4:*=0;
            var loc3:*=0;
            var loc2:*=arg1.layers;
            loc4 = 0;
            loc3 = loc2.length;
            while (loc4 < loc3) 
            {
                loc5 = loc2[loc4];
                loc1 = getInvisible(arg1, loc5);
                dispose(arg1, loc5, loc1);
                ++loc4;
            }
            return;
        }

        public static function dispose(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>):void
        {
            var loc2:*=0;
            var loc1:*=arg3.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                arg1.disposePartition(arg2, arg3[loc2]);
                ++loc2;
            }
            return;
        }

        public static function diposeLayerPartitionsList(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>):void
        {
            var loc2:*=0;
            var loc1:*=arg2.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                dispose(arg1, arg2[loc2].layer, arg2[loc2].partitions);
                ++loc2;
            }
            return;
        }

        public static function getAt(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:flash.geom.Point):__AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>
        {
            var loc1:*=null;
            var loc8:*=null;
            var loc9:*=0;
            var loc6:*=null;
            var loc4:*=0;
            var loc3:*=0;
            var loc5:*=0;
            var loc2:*=arg1.layers;
            var loc7:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.valueObjects.LayerPartitions>();
            loc4 = 0;
            loc3 = loc2.length;
            while (loc4 < loc3) 
            {
                loc9 = (loc8 = loc2[loc4]).partitions.length;
                (loc6 = new sk.yoz.ycanvas.valueObjects.LayerPartitions()).layer = loc2[loc4];
                loc6.partitions = new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
                loc7.push(loc6);
                loc5 = 0;
                while (loc5 < loc9) 
                {
                    loc1 = loc8.partitions[loc5];
                    if (isOverlapingPoint(arg2, loc8, loc1)) 
                    {
                        loc6.partitions.push(loc1);
                    }
                    ++loc5;
                }
                ++loc4;
            }
            return loc7;
        }

        internal static function isOverlaping(arg1:sk.yoz.ycanvas.interfaces.ILayer, arg2:sk.yoz.ycanvas.interfaces.IPartition, arg3:sk.yoz.ycanvas.interfaces.ILayer, arg4:sk.yoz.ycanvas.interfaces.IPartition):Boolean
        {
            var loc3:*=arg1;
            var loc2:*=arg2;
            var loc1:*=arg3;
            var loc4:*=arg4;
            if (arg1.level > arg3.level) 
            {
                loc3 = arg3;
                loc2 = arg4;
                loc1 = arg1;
                loc4 = arg2;
            }
            return loc2.x >= loc4.x && loc2.x < loc4.x + loc4.expectedWidth * loc1.level && loc2.y >= loc4.y && loc2.y < loc4.y + loc4.expectedHeight * loc1.level;
        }

        internal static function isOverlapingPoint(arg1:flash.geom.Point, arg2:sk.yoz.ycanvas.interfaces.ILayer, arg3:sk.yoz.ycanvas.interfaces.IPartition):Boolean
        {
            return arg1.x >= arg3.x && arg1.x < arg3.x + arg3.expectedWidth * arg2.level && arg1.y >= arg3.y && arg1.y < arg3.y + arg3.expectedHeight * arg2.level;
        }

        internal static function getInvisible(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:sk.yoz.ycanvas.interfaces.ILayer):__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>
        {
            var loc3:*=null;
            var loc7:*=0;
            var loc4:*=arg2.partitionWidth * arg2.level;
            var loc5:*=arg2.partitionHeight * arg2.level;
            var loc1:*=arg2.partitions.concat();
            var loc2:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.IPartition>();
            var loc6:*=loc1.length;
            loc7 = 0;
            while (loc7 < loc6) 
            {
                loc3 = loc1[loc7];
                if (!arg1.isCollision(arg1.marginPoints, loc3.x, loc3.y, loc4, loc5)) 
                {
                    loc2.push(loc3);
                }
                ++loc7;
            }
            return loc2;
        }

        internal static const OVERLAP_ALL:uint=0;

        internal static const OVERLAP_LOWER:uint=1;

        internal static const OVERLAP_UPPER:uint=2;
    }
}


//  class TransformationUtils
package sk.yoz.ycanvas.utils 
{
    import flash.geom.*;
    import sk.yoz.math.*;
    import sk.yoz.ycanvas.*;
    
    public class TransformationUtils extends Object
    {
        public function TransformationUtils()
        {
            super();
            return;
        }

        public static function moveTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:flash.geom.Point):void
        {
            arg1.center = arg2;
            return;
        }

        public static function scaleTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:Number, arg3:flash.geom.Point=null):void
        {
            if (!arg3) 
            {
                arg3 = arg1.center;
            }
            var loc1:*=1 - arg1.scale / arg2;
            arg1.center = new flash.geom.Point(arg1.center.x + (arg3.x - arg1.center.x) * loc1, arg1.center.y + (arg3.y - arg1.center.y) * loc1);
            arg1.scale = arg2;
            return;
        }

        public static function rotateTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:Number, arg3:flash.geom.Point=null):void
        {
            if (!arg3) 
            {
                arg3 = arg1.center;
            }
            var loc1:*=arg1.rotation - arg2;
            arg1.center = sk.yoz.math.GeometryMath.rotatePointByRadians(arg1.center, arg3, loc1);
            arg1.rotation = arg2;
            return;
        }

        public static function moveRotateTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:flash.geom.Point, arg3:Number):void
        {
            arg1.center = arg2;
            arg1.rotation = arg3;
            return;
        }

        public static function rotateScaleTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:Number, arg3:Number, arg4:flash.geom.Point=null):void
        {
            if (!arg4) 
            {
                arg4 = arg1.center;
            }
            var loc3:*=arg1.rotation - arg2;
            var loc2:*=sk.yoz.math.GeometryMath.rotatePointByRadians(arg1.center, arg4, loc3);
            var loc1:*=1 - arg1.scale / arg3;
            loc2.x = loc2.x + (arg4.x - loc2.x) * loc1;
            loc2.y = loc2.y + (arg4.y - loc2.y) * loc1;
            arg1.center = loc2;
            arg1.rotation = arg2;
            arg1.scale = arg3;
            return;
        }
    }
}


