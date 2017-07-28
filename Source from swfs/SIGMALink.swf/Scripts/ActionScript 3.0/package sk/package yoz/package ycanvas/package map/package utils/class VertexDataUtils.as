//class VertexDataUtils
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


