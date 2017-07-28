//package geom
//  class Polygon
package starling.geom 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class Polygon extends Object
    {
        public function Polygon(arg1:Array=null)
        {
            super();
            this._coords = new Vector.<Number>(0);
            this.addVertices.apply(this, arg1);
            return;
        }

        public function clone():starling.geom.Polygon
        {
            var loc1:*=new starling.geom.Polygon();
            var loc2:*=this._coords.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1._coords[loc3] = this._coords[loc3];
                ++loc3;
            }
            return loc1;
        }

        public function reverse():void
        {
            var loc3:*=NaN;
            var loc1:*=this._coords.length;
            var loc2:*=loc1 / 2;
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                loc3 = this._coords[loc4];
                this._coords[loc4] = this._coords[loc1 - loc4 - 2];
                this._coords[loc1 - loc4 - 2] = loc3;
                loc3 = this._coords[loc4 + 1];
                this._coords[loc4 + 1] = this._coords[(loc1 - loc4 - 1)];
                this._coords[(loc1 - loc4 - 1)] = loc3;
                loc4 = loc4 + 2;
            }
            return;
        }

        public function addVertices(... rest):void
        {
            var loc1:*=0;
            var loc2:*=rest.length;
            var loc3:*=this._coords.length;
            if (loc2 > 0) 
            {
                if (rest[0] is flash.geom.Point) 
                {
                    loc1 = 0;
                    while (loc1 < loc2) 
                    {
                        this._coords[loc3 + loc1 * 2] = (rest[loc1] as flash.geom.Point).x;
                        this._coords[loc3 + loc1 * 2 + 1] = (rest[loc1] as flash.geom.Point).y;
                        ++loc1;
                    }
                }
                else if (rest[0] is Number) 
                {
                    loc1 = 0;
                    while (loc1 < loc2) 
                    {
                        this._coords[loc3 + loc1] = rest[loc1];
                        ++loc1;
                    }
                }
                else 
                {
                    throw new ArgumentError("Invalid type: " + flash.utils.getQualifiedClassName(rest[0]));
                }
            }
            return;
        }

        public function setVertex(arg1:int, arg2:Number, arg3:Number):void
        {
            if (arg1 >= 0 && arg1 <= this.numVertices) 
            {
                this._coords[arg1 * 2] = arg2;
                this._coords[arg1 * 2 + 1] = arg3;
            }
            else 
            {
                throw new RangeError("Invalid index: " + arg1);
            }
            return;
        }

        public function getVertex(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (arg1 >= 0 && arg1 < this.numVertices) 
            {
                arg2 = arg2 || new flash.geom.Point();
                arg2.setTo(this._coords[arg1 * 2], this._coords[arg1 * 2 + 1]);
                return arg2;
            }
            throw new RangeError("Invalid index: " + arg1);
        }

        public function contains(arg1:Number, arg2:Number):Boolean
        {
            var loc1:*=0;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc2:*=(this.numVertices - 1);
            var loc3:*=0;
            loc1 = 0;
            while (loc1 < this.numVertices) 
            {
                loc4 = this._coords[loc1 * 2];
                loc5 = this._coords[loc1 * 2 + 1];
                loc6 = this._coords[loc2 * 2];
                loc7 = this._coords[loc2 * 2 + 1];
                if ((loc5 < arg2 && loc7 >= arg2 || loc7 < arg2 && loc5 >= arg2) && (loc4 <= arg1 || loc6 <= arg1)) 
                {
                    loc3 = loc3 ^ uint(loc4 + (arg2 - loc5) / (loc7 - loc5) * (loc6 - loc4) < arg1);
                }
                loc2 = loc1;
                ++loc1;
            }
            return !(loc3 == 0);
        }

        public function containsPoint(arg1:flash.geom.Point):Boolean
        {
            return this.contains(arg1.x, arg1.y);
        }

        public function triangulate(arg1:starling.rendering.IndexData=null, arg2:int=0):starling.rendering.IndexData
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc10:*=0;
            var loc11:*=false;
            var loc12:*=0;
            var loc13:*=0;
            var loc14:*=0;
            var loc1:*=this.numVertices;
            var loc2:*=this.numTriangles;
            if (arg1 == null) 
            {
                arg1 = new starling.rendering.IndexData(loc2 * 3);
            }
            if (loc2 == 0) 
            {
                return arg1;
            }
            sRestIndices.length = loc1;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                sRestIndices[loc3] = loc3;
                ++loc3;
            }
            loc4 = 0;
            loc5 = loc1;
            var loc6:*=starling.utils.Pool.getPoint();
            var loc7:*=starling.utils.Pool.getPoint();
            var loc8:*=starling.utils.Pool.getPoint();
            var loc9:*=starling.utils.Pool.getPoint();
            while (loc5 > 3) 
            {
                loc11 = false;
                loc12 = sRestIndices[loc4 % loc5];
                loc13 = sRestIndices[(loc4 + 1) % loc5];
                loc14 = sRestIndices[(loc4 + 2) % loc5];
                loc6.setTo(this._coords[2 * loc12], this._coords[2 * loc12 + 1]);
                loc7.setTo(this._coords[2 * loc13], this._coords[2 * loc13 + 1]);
                loc8.setTo(this._coords[2 * loc14], this._coords[2 * loc14 + 1]);
                if (isConvexTriangle(loc6.x, loc6.y, loc7.x, loc7.y, loc8.x, loc8.y)) 
                {
                    loc11 = true;
                    loc3 = 3;
                    while (loc3 < loc5) 
                    {
                        loc10 = sRestIndices[(loc4 + loc3) % loc5];
                        loc9.setTo(this._coords[2 * loc10], this._coords[2 * loc10 + 1]);
                        if (starling.utils.MathUtil.isPointInTriangle(loc9, loc6, loc7, loc8)) 
                        {
                            loc11 = false;
                        }
                        ++loc3;
                    }
                }
                if (loc11) 
                {
                    arg1.addTriangle(loc12 + arg2, loc13 + arg2, loc14 + arg2);
                    sRestIndices.removeAt((loc4 + 1) % loc5);
                    --loc5;
                    loc4 = 0;
                    continue;
                }
                ++loc4;
                if (loc4 != loc5) 
                {
                    continue;
                }
                break;
            }
            starling.utils.Pool.putPoint(loc6);
            starling.utils.Pool.putPoint(loc7);
            starling.utils.Pool.putPoint(loc8);
            starling.utils.Pool.putPoint(loc9);
            arg1.addTriangle(sRestIndices[0] + arg2, sRestIndices[1] + arg2, sRestIndices[2] + arg2);
            return arg1;
        }

        public function copyToVertexData(arg1:starling.rendering.VertexData=null, arg2:int=0, arg3:String="position"):void
        {
            var loc1:*=this.numVertices;
            var loc2:*=arg2 + loc1;
            if (arg1.numVertices < loc2) 
            {
                arg1.numVertices = loc2;
            }
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                arg1.setPoint(arg2 + loc3, arg3, this._coords[loc3 * 2], this._coords[loc3 * 2 + 1]);
                ++loc3;
            }
            return;
        }

        public function toString():String
        {
            var loc1:*="[Polygon";
            var loc2:*=this.numVertices;
            if (loc2 > 0) 
            {
                loc1 = loc1 + "\n";
            }
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = loc1 + ("  [Vertex " + loc3 + ": " + "x=" + this._coords[loc3 * 2].toFixed(1) + ", " + "y=" + this._coords[loc3 * 2 + 1].toFixed(1) + "]" + (loc3 != (loc2 - 1) ? ",\n" : "\n"));
                ++loc3;
            }
            return loc1 + "]";
        }

        public function get isSimple():Boolean
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=0;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc1:*=this._coords.length;
            if (loc1 <= 6) 
            {
                return true;
            }
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._coords[loc2];
                loc4 = this._coords[loc2 + 1];
                loc5 = this._coords[(loc2 + 2) % loc1];
                loc6 = this._coords[(loc2 + 3) % loc1];
                loc7 = loc2 + loc1 - 2;
                loc8 = loc2 + 4;
                while (loc8 < loc7) 
                {
                    loc9 = this._coords[loc8 % loc1];
                    loc10 = this._coords[(loc8 + 1) % loc1];
                    loc11 = this._coords[(loc8 + 2) % loc1];
                    loc12 = this._coords[(loc8 + 3) % loc1];
                    if (areVectorsIntersecting(loc3, loc4, loc5, loc6, loc9, loc10, loc11, loc12)) 
                    {
                        return false;
                    }
                    loc8 = loc8 + 2;
                }
                loc2 = loc2 + 2;
            }
            return true;
        }

        public function get isConvex():Boolean
        {
            var loc2:*=0;
            var loc1:*=this._coords.length;
            if (loc1 < 6) 
            {
                return true;
            }
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (!isConvexTriangle(this._coords[loc2], this._coords[loc2 + 1], this._coords[(loc2 + 2) % loc1], this._coords[(loc2 + 3) % loc1], this._coords[(loc2 + 4) % loc1], this._coords[(loc2 + 5) % loc1])) 
                {
                    return false;
                }
                loc2 = loc2 + 2;
            }
            return true;
        }

        public function get area():Number
        {
            var loc3:*=0;
            var loc1:*=0;
            var loc2:*=this._coords.length;
            if (loc2 >= 6) 
            {
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc1 = loc1 + this._coords[loc3] * this._coords[(loc3 + 3) % loc2];
                    loc1 = loc1 - this._coords[loc3 + 1] * this._coords[(loc3 + 2) % loc2];
                    loc3 = loc3 + 2;
                }
            }
            return loc1 / 2;
        }

        public function get numVertices():int
        {
            return this._coords.length / 2;
        }

        public function set numVertices(arg1:int):void
        {
            var loc2:*=0;
            var loc1:*=this.numVertices;
            this._coords.length = arg1 * 2;
            if (loc1 < arg1) 
            {
                loc2 = loc1;
                while (loc2 < arg1) 
                {
                    var loc3:*;
                    this._coords[loc2 * 2 + 1] = loc3 = 0;
                    this._coords[loc2 * 2] = loc3;
                    ++loc2;
                }
            }
            return;
        }

        public function get numTriangles():int
        {
            var loc1:*=this.numVertices;
            return loc1 >= 3 ? loc1 - 2 : 0;
        }

        public static function createEllipse(arg1:Number, arg2:Number, arg3:Number, arg4:Number):starling.geom.Polygon
        {
            return new Ellipse(arg1, arg2, arg3, arg4);
        }

        public static function createCircle(arg1:Number, arg2:Number, arg3:Number):starling.geom.Polygon
        {
            return new Ellipse(arg1, arg2, arg3, arg3);
        }

        public static function createRectangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number):starling.geom.Polygon
        {
            return new Rectangle(arg1, arg2, arg3, arg4);
        }

        internal static function isConvexTriangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number):Boolean
        {
            return (arg2 - arg4) * (arg5 - arg3) + (arg3 - arg1) * (arg6 - arg4) >= 0;
        }

        internal static function areVectorsIntersecting(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number):Boolean
        {
            if (arg1 == arg3 && arg2 == arg4 || arg5 == arg7 && arg6 == arg8) 
            {
                return false;
            }
            var loc1:*=arg3 - arg1;
            var loc2:*=arg4 - arg2;
            var loc3:*=arg7 - arg5;
            var loc4:*=arg8 - arg6;
            var loc5:*=loc4 * loc1 - loc3 * loc2;
            if (loc5 == 0) 
            {
                return false;
            }
            var loc6:*=(loc2 * (arg5 - arg1) - loc1 * (arg6 - arg2)) / loc5;
            if (loc6 < 0 || loc6 > 1) 
            {
                return false;
            }
            var loc7:*=loc2 ? (arg6 - arg2 + loc6 * loc4) / loc2 : (arg5 - arg1 + loc6 * loc3) / loc1;
            return loc7 >= 0 && loc7 <= 1;
        }

        
        {
            sRestIndices = new Vector.<uint>(0);
        }

        internal var _coords:__AS3__.vec.Vector.<Number>;

        internal static var sRestIndices:__AS3__.vec.Vector.<uint>;
    }
}

import flash.errors.*;
import flash.utils.*;
import starling.rendering.*;


class ImmutablePolygon extends starling.geom.Polygon
{
    public function ImmutablePolygon(arg1:Array)
    {
        super(arg1);
        this._frozen = true;
        return;
    }

    public override function addVertices(... rest):void
    {
        if (this._frozen) 
        {
            throw this.getImmutableError();
        }
        super.addVertices.apply(this, rest);
        return;
    }

    public override function setVertex(arg1:int, arg2:Number, arg3:Number):void
    {
        if (this._frozen) 
        {
            throw this.getImmutableError();
        }
        super.setVertex(arg1, arg2, arg3);
        return;
    }

    public override function reverse():void
    {
        if (this._frozen) 
        {
            throw this.getImmutableError();
        }
        super.reverse();
        return;
    }

    public override function set numVertices(arg1:int):void
    {
        if (this._frozen) 
        {
            throw this.getImmutableError();
        }
        super.reverse();
        return;
    }

    internal function getImmutableError():Error
    {
        var loc1:*=flash.utils.getQualifiedClassName(this).split("::").pop();
        var loc2:*=loc1 + " cannot be modified. Call \'clone\' to create a mutable copy.";
        return new flash.errors.IllegalOperationError(loc2);
    }

    internal var _frozen:Boolean;
}

class Ellipse extends ImmutablePolygon
{
    public function Ellipse(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int=-1)
    {
        this._x = arg1;
        this._y = arg2;
        this._radiusX = arg3;
        this._radiusY = arg4;
        super(this.getVertices(arg5));
        return;
    }

    internal function getVertices(arg1:int):Array
    {
        if (arg1 < 0) 
        {
            arg1 = Math.PI * (this._radiusX + this._radiusY) / 4;
        }
        if (arg1 < 6) 
        {
            arg1 = 6;
        }
        var loc1:*=[];
        var loc2:*=2 * Math.PI / arg1;
        var loc3:*=0;
        var loc4:*=0;
        while (loc4 < arg1) 
        {
            loc1[loc4 * 2] = Math.cos(loc3) * this._radiusX + this._x;
            loc1[loc4 * 2 + 1] = Math.sin(loc3) * this._radiusY + this._y;
            loc3 = loc3 + loc2;
            ++loc4;
        }
        return loc1;
    }

    public override function triangulate(arg1:starling.rendering.IndexData=null, arg2:int=0):starling.rendering.IndexData
    {
        if (arg1 == null) 
        {
            arg1 = new starling.rendering.IndexData((numVertices - 2) * 3);
        }
        var loc1:*=1;
        var loc2:*=(numVertices - 1);
        var loc3:*=loc1;
        while (loc3 < loc2) 
        {
            arg1.addTriangle(arg2, arg2 + loc3, arg2 + loc3 + 1);
            ++loc3;
        }
        return arg1;
    }

    public override function contains(arg1:Number, arg2:Number):Boolean
    {
        var loc1:*=arg1 - this._x;
        var loc2:*=arg2 - this._y;
        var loc3:*=loc1 / this._radiusX;
        var loc4:*=loc2 / this._radiusY;
        return loc3 * loc3 + loc4 * loc4 <= 1;
    }

    public override function get area():Number
    {
        return Math.PI * this._radiusX * this._radiusY;
    }

    public override function get isSimple():Boolean
    {
        return true;
    }

    public override function get isConvex():Boolean
    {
        return true;
    }

    internal var _x:Number;

    internal var _y:Number;

    internal var _radiusX:Number;

    internal var _radiusY:Number;
}

class Rectangle extends ImmutablePolygon
{
    public function Rectangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number)
    {
        this._x = arg1;
        this._y = arg2;
        this._width = arg3;
        this._height = arg4;
        super([arg1, arg2, arg1 + arg3, arg2, arg1 + arg3, arg2 + arg4, arg1, arg2 + arg4]);
        return;
    }

    public override function triangulate(arg1:starling.rendering.IndexData=null, arg2:int=0):starling.rendering.IndexData
    {
        if (arg1 == null) 
        {
            arg1 = new starling.rendering.IndexData(6);
        }
        arg1.addTriangle(arg2, arg2 + 1, arg2 + 3);
        arg1.addTriangle(arg2 + 1, arg2 + 2, arg2 + 3);
        return arg1;
    }

    public override function contains(arg1:Number, arg2:Number):Boolean
    {
        return arg1 >= this._x && arg1 <= this._x + this._width && arg2 >= this._y && arg2 <= this._y + this._height;
    }

    public override function get area():Number
    {
        return this._width * this._height;
    }

    public override function get isSimple():Boolean
    {
        return true;
    }

    public override function get isConvex():Boolean
    {
        return true;
    }

    internal var _x:Number;

    internal var _y:Number;

    internal var _width:Number;

    internal var _height:Number;
}

