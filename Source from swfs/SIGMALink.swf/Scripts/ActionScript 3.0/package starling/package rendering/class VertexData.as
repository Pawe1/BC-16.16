//class VertexData
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.styles.*;
    import starling.utils.*;
    
    public class VertexData extends Object
    {
        public function VertexData(arg1:*=null, arg2:int=32)
        {
            super();
            if (arg1 != null) 
            {
                if (arg1 is starling.rendering.VertexDataFormat) 
                {
                    this._format = arg1;
                }
                else if (arg1 is String) 
                {
                    this._format = starling.rendering.VertexDataFormat.fromString(arg1 as String);
                }
                else 
                {
                    throw new ArgumentError("\'format\' must be String or VertexDataFormat");
                }
            }
            else 
            {
                this._format = starling.styles.MeshStyle.VERTEX_FORMAT;
            }
            this._attributes = this._format.attributes;
            this._numAttributes = this._attributes.length;
            this._posOffset = this._format.hasAttribute("position") ? this._format.getOffset("position") : 0;
            this._colOffset = this._format.hasAttribute("color") ? this._format.getOffset("color") : 0;
            this._vertexSize = this._format.vertexSize;
            this._numVertices = 0;
            this._premultipliedAlpha = true;
            this._rawData = new flash.utils.ByteArray();
            var loc1:*;
            sBytes.endian = loc1 = flash.utils.Endian.LITTLE_ENDIAN;
            this._rawData.endian = loc1;
            this._rawData.length = arg2 * this._vertexSize;
            this._rawData.length = 0;
            return;
        }

        public function set tinted(arg1:Boolean):void
        {
            this._tinted = arg1;
            return;
        }

        public function get formatString():String
        {
            return this._format.formatString;
        }

        public function get vertexSize():int
        {
            return this._vertexSize;
        }

        public function get vertexSizeIn32Bits():int
        {
            return this._vertexSize / 4;
        }

        public function get size():int
        {
            return this._numVertices * this._vertexSize;
        }

        public function get sizeIn32Bits():int
        {
            return this._numVertices * this._vertexSize / 4;
        }

        internal static function switchEndian(arg1:uint):uint
        {
            return (arg1 & 255) << 24 | (arg1 >> 8 & 255) << 16 | (arg1 >> 16 & 255) << 8 | arg1 >> 24 & 255;
        }

        public function trim():void
        {
            var loc1:*=this._numVertices * this._vertexSize;
            sBytes.length = loc1;
            sBytes.position = 0;
            sBytes.writeBytes(this._rawData, 0, loc1);
            this._rawData.clear();
            this._rawData.length = loc1;
            this._rawData.writeBytes(sBytes);
            sBytes.clear();
            return;
        }

        internal static function premultiplyAlpha(arg1:uint):uint
        {
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1 & 255;
            if (loc1 == 255) 
            {
                return arg1;
            }
            loc2 = loc1 / 255;
            loc3 = (arg1 >> 24 & 255) * loc2;
            loc4 = (arg1 >> 16 & 255) * loc2;
            loc5 = (arg1 >> 8 & 255) * loc2;
            return (loc3 & 255) << 24 | (loc4 & 255) << 16 | (loc5 & 255) << 8 | loc1;
        }

        internal static function unmultiplyAlpha(arg1:uint):uint
        {
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1 & 255;
            if (loc1 == 255 || loc1 == 0) 
            {
                return arg1;
            }
            loc2 = loc1 / 255;
            loc3 = (arg1 >> 24 & 255) / loc2;
            loc4 = (arg1 >> 16 & 255) / loc2;
            loc5 = (arg1 >> 8 & 255) / loc2;
            return (loc3 & 255) << 24 | (loc4 & 255) << 16 | (loc5 & 255) << 8 | loc1;
        }

        public function clear():void
        {
            this._rawData.clear();
            this._numVertices = 0;
            this._tinted = false;
            return;
        }

        public function clone():starling.rendering.VertexData
        {
            var loc1:*=new starling.rendering.VertexData(this._format, this._numVertices);
            loc1._rawData.writeBytes(this._rawData);
            loc1._numVertices = this._numVertices;
            loc1._premultipliedAlpha = this._premultipliedAlpha;
            loc1._tinted = this._tinted;
            return loc1;
        }

        public function copyTo(arg1:starling.rendering.VertexData, arg2:int=0, arg3:flash.geom.Matrix=null, arg4:int=0, arg5:int=-1):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            if (arg5 < 0 || arg4 + arg5 > this._numVertices) 
            {
                arg5 = this._numVertices - arg4;
            }
            if (this._format !== arg1._format) 
            {
                if (arg1._numVertices < arg2 + arg5) 
                {
                    arg1.numVertices = arg2 + arg5;
                }
                loc6 = 0;
                while (loc6 < this._numAttributes) 
                {
                    loc7 = this._attributes[loc6];
                    loc8 = arg1.getAttribute(loc7.name);
                    if (loc8) 
                    {
                        if (loc7.offset != this._posOffset) 
                        {
                            this.copyAttributeTo_internal(arg1, arg2, null, loc7, loc8, arg4, arg5);
                        }
                        else 
                        {
                            this.copyAttributeTo_internal(arg1, arg2, arg3, loc7, loc8, arg4, arg5);
                        }
                    }
                    ++loc6;
                }
            }
            else 
            {
                if (arg1._numVertices < arg2 + arg5) 
                {
                    arg1._numVertices = arg2 + arg5;
                }
                arg1._tinted = arg1._tinted || this._tinted;
                loc1 = arg1._rawData;
                loc1.position = arg2 * this._vertexSize;
                loc1.writeBytes(this._rawData, arg4 * this._vertexSize, arg5 * this._vertexSize);
                if (arg3) 
                {
                    loc4 = arg2 * this._vertexSize + this._posOffset;
                    loc5 = loc4 + arg5 * this._vertexSize;
                    while (loc4 < loc5) 
                    {
                        loc1.position = loc4;
                        loc2 = loc1.readFloat();
                        loc3 = loc1.readFloat();
                        loc1.position = loc4;
                        loc1.writeFloat(arg3.a * loc2 + arg3.c * loc3 + arg3.tx);
                        loc1.writeFloat(arg3.d * loc3 + arg3.b * loc2 + arg3.ty);
                        loc4 = loc4 + this._vertexSize;
                    }
                }
            }
            return;
        }

        public function copyAttributeTo(arg1:starling.rendering.VertexData, arg2:int, arg3:String, arg4:flash.geom.Matrix=null, arg5:int=0, arg6:int=-1):void
        {
            var loc1:*=this.getAttribute(arg3);
            var loc2:*=arg1.getAttribute(arg3);
            if (loc1 == null) 
            {
                throw new ArgumentError("Attribute \'" + arg3 + "\' not found in source data");
            }
            if (loc2 == null) 
            {
                throw new ArgumentError("Attribute \'" + arg3 + "\' not found in target data");
            }
            if (loc1.isColor) 
            {
                arg1._tinted = arg1._tinted || this._tinted;
            }
            this.copyAttributeTo_internal(arg1, arg2, arg4, loc1, loc2, arg5, arg6);
            return;
        }

        internal function copyAttributeTo_internal(arg1:starling.rendering.VertexData, arg2:int, arg3:flash.geom.Matrix, arg4:VertexDataAttribute, arg5:VertexDataAttribute, arg6:int, arg7:int):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (arg4.format != arg5.format) 
            {
                throw new flash.errors.IllegalOperationError("Attribute formats differ between source and target");
            }
            if (arg7 < 0 || arg6 + arg7 > this._numVertices) 
            {
                arg7 = this._numVertices - arg6;
            }
            if (arg1._numVertices < arg2 + arg7) 
            {
                arg1._numVertices = arg2 + arg7;
            }
            var loc5:*=this._rawData;
            var loc6:*=arg1._rawData;
            var loc7:*=this._vertexSize - arg4.size;
            var loc8:*=arg1._vertexSize - arg5.size;
            var loc9:*=arg4.size / 4;
            loc5.position = arg6 * this._vertexSize + arg4.offset;
            loc6.position = arg2 * arg1._vertexSize + arg5.offset;
            if (arg3) 
            {
                loc1 = 0;
                while (loc1 < arg7) 
                {
                    loc3 = loc5.readFloat();
                    loc4 = loc5.readFloat();
                    loc6.writeFloat(arg3.a * loc3 + arg3.c * loc4 + arg3.tx);
                    loc6.writeFloat(arg3.d * loc4 + arg3.b * loc3 + arg3.ty);
                    loc5.position = loc5.position + loc7;
                    loc6.position = loc6.position + loc8;
                    ++loc1;
                }
            }
            else 
            {
                loc1 = 0;
                while (loc1 < arg7) 
                {
                    loc2 = 0;
                    while (loc2 < loc9) 
                    {
                        loc6.writeUnsignedInt(loc5.readUnsignedInt());
                        ++loc2;
                    }
                    loc5.position = loc5.position + loc7;
                    loc6.position = loc6.position + loc8;
                    ++loc1;
                }
            }
            return;
        }

        
        {
            sHelperPoint = new flash.geom.Point();
            sHelperPoint3D = new flash.geom.Vector3D();
            sBytes = new flash.utils.ByteArray();
        }

        public function toString():String
        {
            return starling.utils.StringUtil.format("[VertexData format=\"{0}\" numVertices={1}]", this._format.formatString, this._numVertices);
        }

        public function getUnsignedInt(arg1:int, arg2:String):uint
        {
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            return this._rawData.readUnsignedInt();
        }

        public function setUnsignedInt(arg1:int, arg2:String, arg3:uint):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            this._rawData.writeUnsignedInt(arg3);
            return;
        }

        public function getFloat(arg1:int, arg2:String):Number
        {
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            return this._rawData.readFloat();
        }

        public function setFloat(arg1:int, arg2:String, arg3:Number):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            this._rawData.writeFloat(arg3);
            return;
        }

        public function getPoint(arg1:int, arg2:String, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Point();
            }
            var loc1:*=arg2 != "position" ? this.getAttribute(arg2).offset : this._posOffset;
            this._rawData.position = arg1 * this._vertexSize + loc1;
            arg3.x = this._rawData.readFloat();
            arg3.y = this._rawData.readFloat();
            return arg3;
        }

        public function setPoint(arg1:int, arg2:String, arg3:Number, arg4:Number):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            var loc1:*=arg2 != "position" ? this.getAttribute(arg2).offset : this._posOffset;
            this._rawData.position = arg1 * this._vertexSize + loc1;
            this._rawData.writeFloat(arg3);
            this._rawData.writeFloat(arg4);
            return;
        }

        public function getPoint3D(arg1:int, arg2:String, arg3:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Vector3D();
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            arg3.x = this._rawData.readFloat();
            arg3.y = this._rawData.readFloat();
            arg3.z = this._rawData.readFloat();
            return arg3;
        }

        public function setPoint3D(arg1:int, arg2:String, arg3:Number, arg4:Number, arg5:Number):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            this._rawData.writeFloat(arg3);
            this._rawData.writeFloat(arg4);
            this._rawData.writeFloat(arg5);
            return;
        }

        public function getPoint4D(arg1:int, arg2:String, arg3:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Vector3D();
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            arg3.x = this._rawData.readFloat();
            arg3.y = this._rawData.readFloat();
            arg3.z = this._rawData.readFloat();
            arg3.w = this._rawData.readFloat();
            return arg3;
        }

        public function setPoint4D(arg1:int, arg2:String, arg3:Number, arg4:Number, arg5:Number, arg6:Number=1):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            this._rawData.position = arg1 * this._vertexSize + this.getAttribute(arg2).offset;
            this._rawData.writeFloat(arg3);
            this._rawData.writeFloat(arg4);
            this._rawData.writeFloat(arg5);
            this._rawData.writeFloat(arg6);
            return;
        }

        public function getColor(arg1:int, arg2:String="color"):uint
        {
            var loc1:*=arg2 != "color" ? this.getAttribute(arg2).offset : this._colOffset;
            this._rawData.position = arg1 * this._vertexSize + loc1;
            var loc2:*=switchEndian(this._rawData.readUnsignedInt());
            if (this._premultipliedAlpha) 
            {
                loc2 = unmultiplyAlpha(loc2);
            }
            return loc2 >> 8 & 16777215;
        }

        public function setColor(arg1:int, arg2:String, arg3:uint):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            var loc1:*=this.getAlpha(arg1, arg2);
            this.colorize(arg2, arg3, loc1, arg1, 1);
            return;
        }

        public function getAlpha(arg1:int, arg2:String="color"):Number
        {
            var loc1:*=arg2 != "color" ? this.getAttribute(arg2).offset : this._colOffset;
            this._rawData.position = arg1 * this._vertexSize + loc1;
            var loc2:*=switchEndian(this._rawData.readUnsignedInt());
            return (loc2 & 255) / 255;
        }

        public function setAlpha(arg1:int, arg2:String, arg3:Number):void
        {
            if (this._numVertices < arg1 + 1) 
            {
                this.numVertices = arg1 + 1;
            }
            var loc1:*=this.getColor(arg1, arg2);
            this.colorize(arg2, loc1, arg3, arg1, 1);
            return;
        }

        public function getBounds(arg1:String="position", arg2:flash.geom.Matrix=null, arg3:int=0, arg4:int=-1, arg5:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=0;
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Rectangle();
            }
            if (arg4 < 0 || arg3 + arg4 > this._numVertices) 
            {
                arg4 = this._numVertices - arg3;
            }
            if (arg4 != 0) 
            {
                loc1 = Number.MAX_VALUE;
                loc2 = -Number.MAX_VALUE;
                loc3 = Number.MAX_VALUE;
                loc4 = -Number.MAX_VALUE;
                loc5 = arg1 != "position" ? this.getAttribute(arg1).offset : this._posOffset;
                loc6 = arg3 * this._vertexSize + loc5;
                if (arg2 != null) 
                {
                    loc9 = 0;
                    while (loc9 < arg4) 
                    {
                        this._rawData.position = loc6;
                        loc7 = this._rawData.readFloat();
                        loc8 = this._rawData.readFloat();
                        loc6 = loc6 + this._vertexSize;
                        starling.utils.MatrixUtil.transformCoords(arg2, loc7, loc8, sHelperPoint);
                        if (loc1 > sHelperPoint.x) 
                        {
                            loc1 = sHelperPoint.x;
                        }
                        if (loc2 < sHelperPoint.x) 
                        {
                            loc2 = sHelperPoint.x;
                        }
                        if (loc3 > sHelperPoint.y) 
                        {
                            loc3 = sHelperPoint.y;
                        }
                        if (loc4 < sHelperPoint.y) 
                        {
                            loc4 = sHelperPoint.y;
                        }
                        ++loc9;
                    }
                }
                else 
                {
                    loc9 = 0;
                    while (loc9 < arg4) 
                    {
                        this._rawData.position = loc6;
                        loc7 = this._rawData.readFloat();
                        loc8 = this._rawData.readFloat();
                        loc6 = loc6 + this._vertexSize;
                        if (loc1 > loc7) 
                        {
                            loc1 = loc7;
                        }
                        if (loc2 < loc7) 
                        {
                            loc2 = loc7;
                        }
                        if (loc3 > loc8) 
                        {
                            loc3 = loc8;
                        }
                        if (loc4 < loc8) 
                        {
                            loc4 = loc8;
                        }
                        ++loc9;
                    }
                }
                arg5.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            }
            else if (arg2 != null) 
            {
                starling.utils.MatrixUtil.transformCoords(arg2, 0, 0, sHelperPoint);
                arg5.setTo(sHelperPoint.x, sHelperPoint.y, 0, 0);
            }
            else 
            {
                arg5.setEmpty();
            }
            return arg5;
        }

        public function getBoundsProjected(arg1:String, arg2:flash.geom.Matrix3D, arg3:flash.geom.Vector3D, arg4:int=0, arg5:int=-1, arg6:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=0;
            if (arg6 == null) 
            {
                arg6 = new flash.geom.Rectangle();
            }
            if (arg3 == null) 
            {
                throw new ArgumentError("camPos must not be null");
            }
            if (arg5 < 0 || arg4 + arg5 > this._numVertices) 
            {
                arg5 = this._numVertices - arg4;
            }
            if (arg5 != 0) 
            {
                loc1 = Number.MAX_VALUE;
                loc2 = -Number.MAX_VALUE;
                loc3 = Number.MAX_VALUE;
                loc4 = -Number.MAX_VALUE;
                loc5 = arg1 != "position" ? this.getAttribute(arg1).offset : this._posOffset;
                loc6 = arg4 * this._vertexSize + loc5;
                loc9 = 0;
                while (loc9 < arg5) 
                {
                    this._rawData.position = loc6;
                    loc7 = this._rawData.readFloat();
                    loc8 = this._rawData.readFloat();
                    loc6 = loc6 + this._vertexSize;
                    if (arg2) 
                    {
                        starling.utils.MatrixUtil.transformCoords3D(arg2, loc7, loc8, 0, sHelperPoint3D);
                    }
                    else 
                    {
                        sHelperPoint3D.setTo(loc7, loc8, 0);
                    }
                    starling.utils.MathUtil.intersectLineWithXYPlane(arg3, sHelperPoint3D, sHelperPoint);
                    if (loc1 > sHelperPoint.x) 
                    {
                        loc1 = sHelperPoint.x;
                    }
                    if (loc2 < sHelperPoint.x) 
                    {
                        loc2 = sHelperPoint.x;
                    }
                    if (loc3 > sHelperPoint.y) 
                    {
                        loc3 = sHelperPoint.y;
                    }
                    if (loc4 < sHelperPoint.y) 
                    {
                        loc4 = sHelperPoint.y;
                    }
                    ++loc9;
                }
                arg6.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            }
            else 
            {
                if (arg2) 
                {
                    starling.utils.MatrixUtil.transformCoords3D(arg2, 0, 0, 0, sHelperPoint3D);
                }
                else 
                {
                    sHelperPoint3D.setTo(0, 0, 0);
                }
                starling.utils.MathUtil.intersectLineWithXYPlane(arg3, sHelperPoint3D, sHelperPoint);
                arg6.setTo(sHelperPoint.x, sHelperPoint.y, 0, 0);
            }
            return arg6;
        }

        public function get premultipliedAlpha():Boolean
        {
            return this._premultipliedAlpha;
        }

        public function set premultipliedAlpha(arg1:Boolean):void
        {
            this.setPremultipliedAlpha(arg1, false);
            return;
        }

        public function setPremultipliedAlpha(arg1:Boolean, arg2:Boolean):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            if (arg2 && !(arg1 == this._premultipliedAlpha)) 
            {
                loc1 = 0;
                while (loc1 < this._numAttributes) 
                {
                    loc2 = this._attributes[loc1];
                    if (loc2.isColor) 
                    {
                        loc3 = loc2.offset;
                        loc6 = 0;
                        while (loc6 < this._numVertices) 
                        {
                            this._rawData.position = loc3;
                            loc4 = switchEndian(this._rawData.readUnsignedInt());
                            loc5 = arg1 ? premultiplyAlpha(loc4) : unmultiplyAlpha(loc4);
                            this._rawData.position = loc3;
                            this._rawData.writeUnsignedInt(switchEndian(loc5));
                            loc3 = loc3 + this._vertexSize;
                            ++loc6;
                        }
                    }
                    ++loc1;
                }
            }
            this._premultipliedAlpha = arg1;
            return;
        }

        public function updateTinted(arg1:String="color"):Boolean
        {
            var loc1:*=arg1 != "color" ? this.getAttribute(arg1).offset : this._colOffset;
            this._tinted = false;
            var loc2:*=0;
            while (loc2 < this._numVertices) 
            {
                this._rawData.position = loc1;
                if (this._rawData.readUnsignedInt() != 4294967295) 
                {
                    this._tinted = true;
                    break;
                }
                loc1 = loc1 + this._vertexSize;
                ++loc2;
            }
            return this._tinted;
        }

        public function transformPoints(arg1:String, arg2:flash.geom.Matrix, arg3:int=0, arg4:int=-1):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg4 < 0 || arg3 + arg4 > this._numVertices) 
            {
                arg4 = this._numVertices - arg3;
            }
            var loc3:*=arg1 != "position" ? this.getAttribute(arg1).offset : this._posOffset;
            var loc4:*=arg3 * this._vertexSize + loc3;
            var loc5:*=loc4 + arg4 * this._vertexSize;
            while (loc4 < loc5) 
            {
                this._rawData.position = loc4;
                loc1 = this._rawData.readFloat();
                loc2 = this._rawData.readFloat();
                this._rawData.position = loc4;
                this._rawData.writeFloat(arg2.a * loc1 + arg2.c * loc2 + arg2.tx);
                this._rawData.writeFloat(arg2.d * loc2 + arg2.b * loc1 + arg2.ty);
                loc4 = loc4 + this._vertexSize;
            }
            return;
        }

        public function translatePoints(arg1:String, arg2:Number, arg3:Number, arg4:int=0, arg5:int=-1):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg5 < 0 || arg4 + arg5 > this._numVertices) 
            {
                arg5 = this._numVertices - arg4;
            }
            var loc3:*=arg1 != "position" ? this.getAttribute(arg1).offset : this._posOffset;
            var loc4:*=arg4 * this._vertexSize + loc3;
            var loc5:*=loc4 + arg5 * this._vertexSize;
            while (loc4 < loc5) 
            {
                this._rawData.position = loc4;
                loc1 = this._rawData.readFloat();
                loc2 = this._rawData.readFloat();
                this._rawData.position = loc4;
                this._rawData.writeFloat(loc1 + arg2);
                this._rawData.writeFloat(loc2 + arg3);
                loc4 = loc4 + this._vertexSize;
            }
            return;
        }

        public function scaleAlphas(arg1:String, arg2:Number, arg3:int=0, arg4:int=-1):void
        {
            var loc1:*=0;
            var loc4:*=0;
            var loc5:*=NaN;
            var loc6:*=0;
            if (arg2 == 1) 
            {
                return;
            }
            if (arg4 < 0 || arg3 + arg4 > this._numVertices) 
            {
                arg4 = this._numVertices - arg3;
            }
            this._tinted = true;
            var loc2:*=arg1 != "color" ? this.getAttribute(arg1).offset : this._colOffset;
            var loc3:*=arg3 * this._vertexSize + loc2;
            loc1 = 0;
            while (loc1 < arg4) 
            {
                loc4 = loc3 + 3;
                loc5 = this._rawData[loc4] / 255 * arg2;
                if (loc5 > 1) 
                {
                    loc5 = 1;
                }
                else if (loc5 < 0) 
                {
                    loc5 = 0;
                }
                if (loc5 == 1 || !this._premultipliedAlpha) 
                {
                    this._rawData[loc4] = int(loc5 * 255);
                }
                else 
                {
                    this._rawData.position = loc3;
                    loc6 = unmultiplyAlpha(switchEndian(this._rawData.readUnsignedInt()));
                    loc6 = loc6 & 4294967040 | int(loc5 * 255) & 255;
                    loc6 = premultiplyAlpha(loc6);
                    this._rawData.position = loc3;
                    this._rawData.writeUnsignedInt(switchEndian(loc6));
                }
                loc3 = loc3 + this._vertexSize;
                ++loc1;
            }
            return;
        }

        public function colorize(arg1:String="color", arg2:uint=16777215, arg3:Number=1, arg4:int=0, arg5:int=-1):void
        {
            if (arg5 < 0 || arg4 + arg5 > this._numVertices) 
            {
                arg5 = this._numVertices - arg4;
            }
            var loc1:*=arg1 != "color" ? this.getAttribute(arg1).offset : this._colOffset;
            var loc2:*=arg4 * this._vertexSize + loc1;
            var loc3:*=loc2 + arg5 * this._vertexSize;
            if (arg3 > 1) 
            {
                arg3 = 1;
            }
            else if (arg3 < 0) 
            {
                arg3 = 0;
            }
            var loc4:*=arg2 << 8 & 4294967040 | int(arg3 * 255) & 255;
            if (loc4 == 4294967295 && arg5 == this._numVertices) 
            {
                this._tinted = false;
            }
            else if (loc4 != 4294967295) 
            {
                this._tinted = true;
            }
            if (this._premultipliedAlpha && !(arg3 == 1)) 
            {
                loc4 = premultiplyAlpha(loc4);
            }
            this._rawData.position = arg4 * this._vertexSize + loc1;
            this._rawData.writeUnsignedInt(switchEndian(loc4));
            while (loc2 < loc3) 
            {
                this._rawData.position = loc2;
                this._rawData.writeUnsignedInt(switchEndian(loc4));
                loc2 = loc2 + this._vertexSize;
            }
            return;
        }

        public function getFormat(arg1:String):String
        {
            return this.getAttribute(arg1).format;
        }

        public function getSize(arg1:String):int
        {
            return this.getAttribute(arg1).size;
        }

        public function getSizeIn32Bits(arg1:String):int
        {
            return this.getAttribute(arg1).size / 4;
        }

        public function getOffset(arg1:String):int
        {
            return this.getAttribute(arg1).offset;
        }

        public function getOffsetIn32Bits(arg1:String):int
        {
            return this.getAttribute(arg1).offset / 4;
        }

        public function hasAttribute(arg1:String):Boolean
        {
            return !(this.getAttribute(arg1) == null);
        }

        public function createVertexBuffer(arg1:Boolean=false, arg2:String="staticDraw"):flash.display3D.VertexBuffer3D
        {
            var loc1:*=starling.core.Starling.context;
            if (loc1 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            if (this._numVertices == 0) 
            {
                return null;
            }
            var loc2:*=loc1.createVertexBuffer(this._numVertices, this._vertexSize / 4, arg2);
            if (arg1) 
            {
                this.uploadToVertexBuffer(loc2);
            }
            return loc2;
        }

        public function uploadToVertexBuffer(arg1:flash.display3D.VertexBuffer3D, arg2:int=0, arg3:int=-1):void
        {
            if (arg3 < 0 || arg2 + arg3 > this._numVertices) 
            {
                arg3 = this._numVertices - arg2;
            }
            if (arg3 > 0) 
            {
                arg1.uploadFromByteArray(this._rawData, 0, arg2, arg3);
            }
            return;
        }

        internal final function getAttribute(arg1:String):VertexDataAttribute
        {
            var loc1:*=0;
            var loc2:*=null;
            loc1 = 0;
            while (loc1 < this._numAttributes) 
            {
                loc2 = this._attributes[loc1];
                if (loc2.name == arg1) 
                {
                    return loc2;
                }
                ++loc1;
            }
            return null;
        }

        public function get numVertices():int
        {
            return this._numVertices;
        }

        public function set numVertices(arg1:int):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            if (arg1 > this._numVertices) 
            {
                loc1 = this._numVertices * this.vertexSize;
                loc2 = arg1 * this._vertexSize;
                if (this._rawData.length > loc1) 
                {
                    this._rawData.position = loc1;
                    while (this._rawData.bytesAvailable) 
                    {
                        this._rawData.writeUnsignedInt(0);
                    }
                }
                if (this._rawData.length < loc2) 
                {
                    this._rawData.length = loc2;
                }
                loc3 = 0;
                while (loc3 < this._numAttributes) 
                {
                    loc4 = this._attributes[loc3];
                    if (loc4.isColor) 
                    {
                        loc5 = this._numVertices * this._vertexSize + loc4.offset;
                        loc6 = this._numVertices;
                        while (loc6 < arg1) 
                        {
                            this._rawData.position = loc5;
                            this._rawData.writeUnsignedInt(4294967295);
                            loc5 = loc5 + this._vertexSize;
                            ++loc6;
                        }
                    }
                    ++loc3;
                }
            }
            if (arg1 == 0) 
            {
                this._tinted = false;
            }
            this._numVertices = arg1;
            return;
        }

        public function get rawData():flash.utils.ByteArray
        {
            return this._rawData;
        }

        public function get format():starling.rendering.VertexDataFormat
        {
            return this._format;
        }

        public function set format(arg1:starling.rendering.VertexDataFormat):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc7:*=null;
            var loc8:*=null;
            if (this._format === arg1) 
            {
                return;
            }
            var loc4:*=this._format.vertexSize;
            var loc5:*=arg1.vertexSize;
            var loc6:*=arg1.numAttributes;
            sBytes.length = arg1.vertexSize * this._numVertices;
            loc1 = 0;
            while (loc1 < loc6) 
            {
                loc7 = arg1.attributes[loc1];
                loc8 = this.getAttribute(loc7.name);
                if (loc8) 
                {
                    loc3 = loc7.offset;
                    loc2 = 0;
                    while (loc2 < this._numVertices) 
                    {
                        sBytes.position = loc3;
                        sBytes.writeBytes(this._rawData, loc4 * loc2 + loc8.offset, loc8.size);
                        loc3 = loc3 + loc5;
                        ++loc2;
                    }
                }
                else if (loc7.isColor) 
                {
                    loc3 = loc7.offset;
                    loc2 = 0;
                    while (loc2 < this._numVertices) 
                    {
                        sBytes.position = loc3;
                        sBytes.writeUnsignedInt(4294967295);
                        loc3 = loc3 + loc5;
                        ++loc2;
                    }
                }
                ++loc1;
            }
            this._rawData.clear();
            this._rawData.length = sBytes.length;
            this._rawData.writeBytes(sBytes);
            sBytes.clear();
            this._format = arg1;
            this._attributes = this._format.attributes;
            this._numAttributes = this._attributes.length;
            this._vertexSize = this._format.vertexSize;
            this._posOffset = this._format.hasAttribute("position") ? this._format.getOffset("position") : 0;
            this._colOffset = this._format.hasAttribute("color") ? this._format.getOffset("color") : 0;
            return;
        }

        public function get tinted():Boolean
        {
            return this._tinted;
        }

        internal var _rawData:flash.utils.ByteArray;

        internal var _numVertices:int;

        internal var _format:starling.rendering.VertexDataFormat;

        internal var _attributes:__AS3__.vec.Vector.<VertexDataAttribute>;

        internal var _numAttributes:int;

        internal var _premultipliedAlpha:Boolean;

        internal var _tinted:Boolean;

        internal var _colOffset:int;

        internal var _vertexSize:int;

        internal var _posOffset:int;

        internal static var sHelperPoint3D:flash.geom.Vector3D;

        internal static var sBytes:flash.utils.ByteArray;

        internal static var sHelperPoint:flash.geom.Point;
    }
}


