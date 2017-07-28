//package utils
//  class PartialBoundsUtils
package sk.yoz.ycanvas.map.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    
    public class PartialBoundsUtils extends Object
    {
        public function PartialBoundsUtils()
        {
            super();
            return;
        }

        public static function mergeListToRectangle(arg1:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.valueObjects.PartialBounds>):flash.geom.Rectangle
        {
            var loc7:*=0;
            var loc6:*=0;
            var loc1:*=arg1[0];
            var loc8:*;
            var loc3:*=(loc8 = loc1.rectangle).x;
            var loc2:*=loc8.y;
            var loc5:*=loc8.x + loc8.width;
            var loc4:*=loc8.y + loc8.height;
            loc7 = 1;
            loc6 = arg1.length;
            while (loc7 < loc6) 
            {
                loc1 = arg1[loc7];
                if ((loc8 = loc1.rectangle).x < loc3) 
                {
                    loc3 = loc8.x;
                }
                if (loc8.y < loc2) 
                {
                    loc2 = loc8.y;
                }
                if (loc8.x + loc8.width > loc5) 
                {
                    loc5 = loc8.x + loc8.width;
                }
                if (loc8.y + loc8.height > loc4) 
                {
                    loc4 = loc8.y + loc8.height;
                }
                ++loc7;
            }
            return new flash.geom.Rectangle(loc3, loc2, loc5 - loc3, loc4 - loc2);
        }
    }
}


//  class StrokeUtils
package sk.yoz.ycanvas.map.utils 
{
    import __AS3__.vec.*;
    import starling.rendering.*;
    
    public class StrokeUtils extends Object
    {
        public function StrokeUtils()
        {
            super();
            return;
        }

        public static function pointsToVertexData(arg1:__AS3__.vec.Vector.<Number>, arg2:Number, arg3:uint=16711680):starling.rendering.VertexData
        {
            var loc6:*=0;
            var loc11:*=0;
            var loc5:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc3:*=pointsToVertices(arg1, arg2);
            var loc1:*="position:float2, color:bytes4";
            var loc2:*=starling.rendering.VertexDataFormat.fromString(loc1);
            var loc9:*=new starling.rendering.VertexData(loc2);
            var loc4:*=loc3.length;
            var loc10:*="";
            loc6 = 0;
            loc11 = 0;
            while (loc6 < loc4) 
            {
                loc5 = loc6 + 1;
                loc7 = loc6 + 2;
                loc8 = loc6 + 3;
                loc9.setPoint(loc11, "position", loc3[loc6], loc3[loc5]);
                loc9.setColor(loc11, "color", arg3);
                loc9.setPoint(loc11 + 1, "position", loc3[loc7], loc3[loc8]);
                loc9.setColor(loc11 + 1, "color", arg3);
                loc10 = (loc10 = (loc10 = (loc10 = loc10 + (loc6 + ": " + loc3[loc6] + "\n")) + (loc5 + ": " + loc3[loc5] + "\n")) + (loc7 + ": " + loc3[loc7] + "\n")) + (loc8 + ": " + loc3[loc8] + "\n");
                loc6 = loc6 + 4;
                loc11 = loc11 + 2;
            }
            return loc9;
        }

        public static function vertexDataToIndexData(arg1:starling.rendering.VertexData):__AS3__.vec.Vector.<uint>
        {
            var loc3:*=0;
            var loc1:*=new __AS3__.vec.Vector.<uint>();
            var loc2:*=arg1.numVertices - 2;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1.push(loc3, loc3 + 1, loc3 + 2);
                ++loc3;
            }
            return loc1;
        }

        public static function indexDataVectorToIndexDataObj(arg1:__AS3__.vec.Vector.<uint>):starling.rendering.IndexData
        {
            var loc3:*=0;
            var loc1:*=new starling.rendering.IndexData();
            var loc2:*=arg1.length - 2;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1.addTriangle(arg1[loc3], arg1[loc3 + 1], arg1[loc3 + 2]);
                loc3 = loc3 + 3;
            }
            return loc1;
        }

        internal static function pointsToVertices(arg1:__AS3__.vec.Vector.<Number>, arg2:Number):__AS3__.vec.Vector.<Number>
        {
            var loc2:*=0;
            var loc13:*=false;
            var loc8:*=NaN;
            var loc1:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc20:*=NaN;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc12:*=NaN;
            var loc10:*=arg1[0];
            var loc9:*=arg1[1];
            var loc5:*=2;
            var loc3:*=3;
            var loc18:*=arg2 / 2;
            var loc4:*=new __AS3__.vec.Vector.<Number>();
            loc2 = arg1.length;
            while (loc5 < loc2) 
            {
                loc13 = false;
                loc8 = arg1[loc5];
                var loc11:*=arg1[loc3];
                loc1 = Math.atan2(loc11 - loc9, loc8 - loc10);
                loc6 = Math.sin(loc1) * loc18;
                loc7 = Math.cos(loc1) * loc18;
                loc20 = loc10 + loc6;
                var loc19:*=loc9 - loc7;
                loc14 = loc10 - loc6;
                var loc21:*=loc9 + loc7;
                if (loc20 == loc16 && loc19 == loc15 && loc14 == loc12 && loc21 == loc17) 
                {
                    loc13 = true;
                }
                loc16 = loc8 + loc6;
                loc15 = loc11 - loc7;
                loc12 = loc8 - loc6;
                loc17 = loc11 + loc7;
                if (loc13) 
                {
                    loc4.splice(loc4.length - 4, 4);
                    loc4.push(loc16, loc15, loc12, loc17);
                }
                else 
                {
                    loc4.push(loc20, loc19, loc14, loc21, loc16, loc15, loc12, loc17);
                }
                loc10 = loc8;
                loc9 = loc11;
                loc5 = loc5 + 2;
                loc3 = loc3 + 2;
            }
            return loc4;
        }
    }
}


//  class VertexDataUtils
package sk.yoz.ycanvas.map.utils 
{
    import __AS3__.vec.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import starling.rendering.*;
    
    public class VertexDataUtils extends Object
    {
        public function VertexDataUtils()
        {
            super();
            return;
        }

        public static function getPartialBoundsList(arg1:starling.rendering.VertexData, arg2:uint):__AS3__.vec.Vector.<sk.yoz.ycanvas.map.valueObjects.PartialBounds>
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc5:*=0;
            var loc1:*=new __AS3__.vec.Vector.<sk.yoz.ycanvas.map.valueObjects.PartialBounds>();
            var loc6:*=arg2 - 2;
            var loc7:*=(arg1.numVertices - 3) * 3;
            var loc4:*=arg1.numVertices;
            loc5 = 0;
            while (loc5 < loc4) 
            {
                loc3 = arg2;
                if (loc5 + loc3 > loc4) 
                {
                    loc3 = loc4 - loc5;
                }
                (loc2 = new sk.yoz.ycanvas.map.valueObjects.PartialBounds()).rectangle = arg1.getBounds("position", null, loc5, loc3);
                loc2.vertexIndexMin = loc5;
                loc2.vertexIndexMax = (loc5 + loc3 - 1);
                loc2.indiceIndexMin = loc2.vertexIndexMin < 2 ? 0 : (loc2.vertexIndexMin - 2) * 3;
                loc2.indiceIndexMax = loc2.vertexIndexMax * 3 > loc7 ? loc7 : loc2.vertexIndexMax * 3;
                loc1.push(loc2);
                loc5 = loc5 + loc6;
            }
            return loc1;
        }
    }
}


