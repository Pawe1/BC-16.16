//class IndexData
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.utils.*;
    
    public class IndexData extends Object
    {
        public function IndexData(arg1:int=48)
        {
            super();
            this._numIndices = 0;
            this._initialCapacity = arg1;
            this._useQuadLayout = true;
            return;
        }

        public function set useQuadLayout(arg1:Boolean):void
        {
            if (arg1 != this._useQuadLayout) 
            {
                if (arg1) 
                {
                    this.ensureQuadDataCapacity(this._numIndices);
                    this._rawData.length = 0;
                    this._useQuadLayout = true;
                }
                else 
                {
                    this.switchToGenericData();
                }
            }
            return;
        }

        public function get rawData():flash.utils.ByteArray
        {
            if (this._useQuadLayout) 
            {
                return sQuadData;
            }
            return this._rawData;
        }

        internal static function getBasicQuadIndexAt(arg1:int):int
        {
            var loc3:*=0;
            var loc1:*=arg1 / 6;
            var loc2:*=arg1 - loc1 * 6;
            if (loc2 != 0) 
            {
                if (loc2 == 1 || loc2 == 3) 
                {
                    loc3 = 1;
                }
                else if (loc2 == 2 || loc2 == 5) 
                {
                    loc3 = 2;
                }
                else 
                {
                    loc3 = 3;
                }
            }
            else 
            {
                loc3 = 0;
            }
            return loc1 * 4 + loc3;
        }

        
        {
            sQuadData = new flash.utils.ByteArray();
            sQuadDataNumIndices = 0;
            sVector = new Vector.<uint>(0);
            sTrimData = new flash.utils.ByteArray();
        }

        public function clear():void
        {
            if (this._rawData) 
            {
                this._rawData.clear();
            }
            this._numIndices = 0;
            this._useQuadLayout = true;
            return;
        }

        public function clone():starling.rendering.IndexData
        {
            var loc1:*=new starling.rendering.IndexData(this._numIndices);
            if (!this._useQuadLayout) 
            {
                loc1.switchToGenericData();
                loc1._rawData.writeBytes(this._rawData);
            }
            loc1._numIndices = this._numIndices;
            return loc1;
        }

        public function copyTo(arg1:starling.rendering.IndexData, arg2:int=0, arg3:int=0, arg4:int=0, arg5:int=-1):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc4:*=false;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=0;
            if (arg5 < 0 || arg4 + arg5 > this._numIndices) 
            {
                arg5 = this._numIndices - arg4;
            }
            var loc3:*=arg2 + arg5;
            if (arg1._numIndices < loc3) 
            {
                arg1._numIndices = loc3;
                if (sQuadDataNumIndices < loc3) 
                {
                    this.ensureQuadDataCapacity(loc3);
                }
            }
            if (this._useQuadLayout) 
            {
                if (arg1._useQuadLayout) 
                {
                    loc4 = true;
                    loc5 = arg2 - arg4;
                    loc6 = loc5 / 6;
                    loc7 = arg3 / 4;
                    if (loc6 == loc7 && (arg3 & 3) == 0 && loc6 * 6 == loc5) 
                    {
                        loc4 = true;
                    }
                    else if (arg5 > 2) 
                    {
                        loc4 = false;
                    }
                    else 
                    {
                        loc8 = 0;
                        while (loc8 < arg5) 
                        {
                            loc4 = loc4 && getBasicQuadIndexAt(arg4 + loc8) + arg3 == getBasicQuadIndexAt(arg2 + loc8);
                            ++loc8;
                        }
                    }
                    if (loc4) 
                    {
                        return;
                    }
                    arg1.switchToGenericData();
                }
                loc1 = sQuadData;
                loc2 = arg1._rawData;
                if ((arg3 & 3) == 0) 
                {
                    arg4 = arg4 + 6 * arg3 / 4;
                    arg3 = 0;
                    this.ensureQuadDataCapacity(arg4 + arg5);
                }
            }
            else 
            {
                if (arg1._useQuadLayout) 
                {
                    arg1.switchToGenericData();
                }
                loc1 = this._rawData;
                loc2 = arg1._rawData;
            }
            loc2.position = arg2 * INDEX_SIZE;
            if (arg3 != 0) 
            {
                loc1.position = arg4 * INDEX_SIZE;
                while (arg5 > 1) 
                {
                    loc9 = loc1.readUnsignedInt();
                    loc10 = ((loc9 & 4294901760) >> 16) + arg3;
                    loc11 = (loc9 & 65535) + arg3;
                    loc2.writeUnsignedInt(loc10 << 16 | loc11);
                    arg5 = arg5 - 2;
                }
                if (arg5) 
                {
                    loc2.writeShort(loc1.readUnsignedShort() + arg3);
                }
            }
            else 
            {
                loc2.writeBytes(loc1, arg4 * INDEX_SIZE, arg5 * INDEX_SIZE);
            }
            return;
        }

        public function setIndex(arg1:int, arg2:uint):void
        {
            if (this._numIndices < arg1 + 1) 
            {
                this.numIndices = arg1 + 1;
            }
            if (this._useQuadLayout) 
            {
                if (getBasicQuadIndexAt(arg1) == arg2) 
                {
                    return;
                }
                this.switchToGenericData();
            }
            this._rawData.position = arg1 * INDEX_SIZE;
            this._rawData.writeShort(arg2);
            return;
        }

        public function getIndex(arg1:int):int
        {
            if (this._useQuadLayout) 
            {
                if (arg1 < this._numIndices) 
                {
                    return getBasicQuadIndexAt(arg1);
                }
                throw new flash.errors.EOFError();
            }
            this._rawData.position = arg1 * INDEX_SIZE;
            return this._rawData.readUnsignedShort();
        }

        public function offsetIndices(arg1:int, arg2:int=0, arg3:int=-1):void
        {
            if (arg3 < 0 || arg2 + arg3 > this._numIndices) 
            {
                arg3 = this._numIndices - arg2;
            }
            var loc1:*=arg2 + arg3;
            var loc2:*=arg2;
            while (loc2 < loc1) 
            {
                this.setIndex(loc2, this.getIndex(loc2) + arg1);
                ++loc2;
            }
            return;
        }

        public function addTriangle(arg1:uint, arg2:uint, arg3:uint):void
        {
            var loc1:*=false;
            var loc2:*=false;
            if (this._useQuadLayout) 
            {
                if (arg1 == getBasicQuadIndexAt(this._numIndices)) 
                {
                    loc1 = !((this._numIndices & 1) == 0);
                    loc2 = !loc1;
                    if (loc2 && arg2 == arg1 + 1 && arg3 == arg2 + 1 || loc1 && arg3 == arg1 + 1 && arg2 == arg3 + 1) 
                    {
                        this._numIndices = this._numIndices + 3;
                        this.ensureQuadDataCapacity(this._numIndices);
                        return;
                    }
                }
                this.switchToGenericData();
            }
            this._rawData.position = this._numIndices * INDEX_SIZE;
            this._rawData.writeShort(arg1);
            this._rawData.writeShort(arg2);
            this._rawData.writeShort(arg3);
            this._numIndices = this._numIndices + 3;
            return;
        }

        public function addQuad(arg1:uint, arg2:uint, arg3:uint, arg4:uint):void
        {
            if (this._useQuadLayout) 
            {
                if (arg1 == getBasicQuadIndexAt(this._numIndices) && arg2 == arg1 + 1 && arg3 == arg2 + 1 && arg4 == arg3 + 1) 
                {
                    this._numIndices = this._numIndices + 6;
                    this.ensureQuadDataCapacity(this._numIndices);
                    return;
                }
                this.switchToGenericData();
            }
            this._rawData.position = this._numIndices * INDEX_SIZE;
            this._rawData.writeShort(arg1);
            this._rawData.writeShort(arg2);
            this._rawData.writeShort(arg3);
            this._rawData.writeShort(arg2);
            this._rawData.writeShort(arg4);
            this._rawData.writeShort(arg3);
            this._numIndices = this._numIndices + 6;
            return;
        }

        public function toVector(arg1:__AS3__.vec.Vector.<uint>=null):__AS3__.vec.Vector.<uint>
        {
            if (arg1 != null) 
            {
                arg1.length = this._numIndices;
            }
            else 
            {
                arg1 = new Vector.<uint>(this._numIndices);
            }
            var loc1:*=this._useQuadLayout ? sQuadData : this._rawData;
            loc1.position = 0;
            var loc2:*=0;
            while (loc2 < this._numIndices) 
            {
                arg1[loc2] = loc1.readUnsignedShort();
                ++loc2;
            }
            return arg1;
        }

        public function toString():String
        {
            var loc1:*=starling.utils.StringUtil.format("[IndexData numIndices={0} indices=\"{1}\"]", this._numIndices, this.toVector(sVector).join());
            sVector.length = 0;
            return loc1;
        }

        internal function switchToGenericData():void
        {
            if (this._useQuadLayout) 
            {
                this._useQuadLayout = false;
                if (this._rawData == null) 
                {
                    this._rawData = new flash.utils.ByteArray();
                    this._rawData.endian = flash.utils.Endian.LITTLE_ENDIAN;
                    this._rawData.length = this._initialCapacity * INDEX_SIZE;
                    this._rawData.length = this._numIndices * INDEX_SIZE;
                }
                if (this._numIndices) 
                {
                    this._rawData.writeBytes(sQuadData, 0, this._numIndices * INDEX_SIZE);
                }
            }
            return;
        }

        internal function ensureQuadDataCapacity(arg1:int):void
        {
            var loc1:*=0;
            if (sQuadDataNumIndices >= arg1) 
            {
                return;
            }
            var loc2:*=sQuadDataNumIndices / 6;
            var loc3:*=Math.ceil(arg1 / 6);
            sQuadData.endian = flash.utils.Endian.LITTLE_ENDIAN;
            sQuadData.position = sQuadData.length;
            sQuadDataNumIndices = loc3 * 6;
            loc1 = loc2;
            while (loc1 < loc3) 
            {
                sQuadData.writeShort(4 * loc1);
                sQuadData.writeShort(4 * loc1 + 1);
                sQuadData.writeShort(4 * loc1 + 2);
                sQuadData.writeShort(4 * loc1 + 1);
                sQuadData.writeShort(4 * loc1 + 3);
                sQuadData.writeShort(4 * loc1 + 2);
                ++loc1;
            }
            return;
        }

        public function createIndexBuffer(arg1:Boolean=false, arg2:String="staticDraw"):flash.display3D.IndexBuffer3D
        {
            var loc1:*=starling.core.Starling.context;
            if (loc1 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            if (this._numIndices == 0) 
            {
                return null;
            }
            var loc2:*=loc1.createIndexBuffer(this._numIndices, arg2);
            if (arg1) 
            {
                this.uploadToIndexBuffer(loc2);
            }
            return loc2;
        }

        public function uploadToIndexBuffer(arg1:flash.display3D.IndexBuffer3D, arg2:int=0, arg3:int=-1):void
        {
            if (arg3 < 0 || arg2 + arg3 > this._numIndices) 
            {
                arg3 = this._numIndices - arg2;
            }
            if (arg3 > 0) 
            {
                arg1.uploadFromByteArray(this.rawData, 0, arg2, arg3);
            }
            return;
        }

        public function trim():void
        {
            if (this._useQuadLayout) 
            {
                return;
            }
            sTrimData.length = this._rawData.length;
            sTrimData.position = 0;
            sTrimData.writeBytes(this._rawData);
            this._rawData.clear();
            this._rawData.length = sTrimData.length;
            this._rawData.writeBytes(sTrimData);
            sTrimData.clear();
            return;
        }

        public function get numIndices():int
        {
            return this._numIndices;
        }

        public function set numIndices(arg1:int):void
        {
            if (arg1 != this._numIndices) 
            {
                if (this._useQuadLayout) 
                {
                    this.ensureQuadDataCapacity(arg1);
                }
                else 
                {
                    this._rawData.length = arg1 * INDEX_SIZE;
                }
                if (arg1 == 0) 
                {
                    this._useQuadLayout = true;
                }
                this._numIndices = arg1;
            }
            return;
        }

        public function get numTriangles():int
        {
            return this._numIndices / 3;
        }

        public function set numTriangles(arg1:int):void
        {
            this.numIndices = arg1 * 3;
            return;
        }

        public function get numQuads():int
        {
            return this._numIndices / 6;
        }

        public function set numQuads(arg1:int):void
        {
            this.numIndices = arg1 * 6;
            return;
        }

        public function get indexSizeInBytes():int
        {
            return INDEX_SIZE;
        }

        public function get useQuadLayout():Boolean
        {
            return this._useQuadLayout;
        }

        internal static const INDEX_SIZE:int=2;

        internal var _rawData:flash.utils.ByteArray;

        internal var _numIndices:int;

        internal var _initialCapacity:int;

        internal var _useQuadLayout:Boolean;

        internal static var sQuadDataNumIndices:uint=0;

        internal static var sVector:__AS3__.vec.Vector.<uint>;

        internal static var sTrimData:flash.utils.ByteArray;

        internal static var sQuadData:flash.utils.ByteArray;
    }
}


