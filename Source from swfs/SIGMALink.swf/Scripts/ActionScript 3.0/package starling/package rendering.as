//package rendering
//  class BatchProcessor
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.utils.*;
    
    internal class BatchProcessor extends Object
    {
        public function BatchProcessor()
        {
            super();
            this._batches = new Vector.<starling.display.MeshBatch>(0);
            this._batchPool = new BatchPool();
            this._cacheToken = new starling.rendering.BatchToken();
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._batches;
            for each (loc1 in loc3) 
            {
                loc1.dispose();
            }
            this._batches.length = 0;
            this._batchPool.purge();
            this._currentBatch = null;
            this._onBatchComplete = null;
            return;
        }

        public function addMesh(arg1:starling.display.Mesh, arg2:starling.rendering.RenderState, arg3:starling.utils.MeshSubset=null, arg4:Boolean=false):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            if (arg3 != null) 
            {
                if (arg3.numVertices < 0) 
                {
                    arg3.numVertices = arg1.numVertices - arg3.vertexID;
                }
                if (arg3.numIndices < 0) 
                {
                    arg3.numIndices = arg1.numIndices - arg3.indexID;
                }
            }
            else 
            {
                arg3 = sMeshSubset;
                var loc3:*;
                arg3.indexID = loc3 = 0;
                arg3.vertexID = loc3;
                arg3.numVertices = arg1.numVertices;
                arg3.numIndices = arg1.numIndices;
            }
            if (arg3.numVertices > 0) 
            {
                if (this._currentBatch == null || !this._currentBatch.canAddMesh(arg1, arg3.numVertices)) 
                {
                    this.finishBatch();
                    this._currentStyleType = arg1.style.type;
                    this._currentBatch = this._batchPool.get(this._currentStyleType);
                    this._currentBatch.blendMode = arg2 ? arg2.blendMode : arg1.blendMode;
                    this._cacheToken.setTo(this._batches.length);
                    this._batches[this._batches.length] = this._currentBatch;
                }
                loc1 = arg2 ? arg2._modelviewMatrix : null;
                loc2 = arg2 ? arg2._alpha : 1;
                this._currentBatch.addMesh(arg1, loc1, loc2, arg3, arg4);
                this._cacheToken.vertexID = this._cacheToken.vertexID + arg3.numVertices;
                this._cacheToken.indexID = this._cacheToken.indexID + arg3.numIndices;
            }
            return;
        }

        public function finishBatch():void
        {
            var loc1:*=this._currentBatch;
            if (loc1) 
            {
                this._currentBatch = null;
                this._currentStyleType = null;
                if (this._onBatchComplete != null) 
                {
                    this._onBatchComplete(loc1);
                }
            }
            return;
        }

        public function clear():void
        {
            var loc1:*=this._batches.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                this._batchPool.put(this._batches[loc2]);
                ++loc2;
            }
            this._batches.length = 0;
            this._currentBatch = null;
            this._currentStyleType = null;
            this._cacheToken.reset();
            return;
        }

        public function getBatchAt(arg1:int):starling.display.MeshBatch
        {
            return this._batches[arg1];
        }

        public function trim():void
        {
            this._batchPool.purge();
            return;
        }

        public function fillToken(arg1:starling.rendering.BatchToken):starling.rendering.BatchToken
        {
            arg1.batchID = this._cacheToken.batchID;
            arg1.vertexID = this._cacheToken.vertexID;
            arg1.indexID = this._cacheToken.indexID;
            return arg1;
        }

        public function get numBatches():int
        {
            return this._batches.length;
        }

        public function get onBatchComplete():Function
        {
            return this._onBatchComplete;
        }

        public function set onBatchComplete(arg1:Function):void
        {
            this._onBatchComplete = arg1;
            return;
        }

        
        {
            sMeshSubset = new starling.utils.MeshSubset();
        }

        internal var _batches:__AS3__.vec.Vector.<starling.display.MeshBatch>;

        internal var _batchPool:BatchPool;

        internal var _currentBatch:starling.display.MeshBatch;

        internal var _currentStyleType:Class;

        internal var _onBatchComplete:Function;

        internal var _cacheToken:starling.rendering.BatchToken;

        internal static var sMeshSubset:starling.utils.MeshSubset;
    }
}

import __AS3__.vec.*;
import flash.utils.*;
import starling.display.*;


class BatchPool extends Object
{
    public function BatchPool()
    {
        super();
        this._batchLists = new flash.utils.Dictionary();
        return;
    }

    public function purge():void
    {
        var loc1:*=null;
        var loc2:*=0;
        var loc3:*=0;
        var loc4:*=this._batchLists;
        for each (loc1 in loc4) 
        {
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                loc1[loc2].dispose();
                ++loc2;
            }
            loc1.length = 0;
        }
        return;
    }

    public function get(arg1:Class):starling.display.MeshBatch
    {
        var loc1:*=this._batchLists[arg1];
        if (loc1 == null) 
        {
            loc1 = new Vector.<starling.display.MeshBatch>(0);
            this._batchLists[arg1] = loc1;
        }
        if (loc1.length > 0) 
        {
            return loc1.pop();
        }
        return new starling.display.MeshBatch();
    }

    public function put(arg1:starling.display.MeshBatch):void
    {
        var loc1:*=arg1.style.type;
        var loc2:*=this._batchLists[loc1];
        if (loc2 == null) 
        {
            loc2 = new Vector.<starling.display.MeshBatch>(0);
            this._batchLists[loc1] = loc2;
        }
        arg1.clear();
        loc2[loc2.length] = arg1;
        return;
    }

    internal var _batchLists:flash.utils.Dictionary;
}

//  class BatchToken
package starling.rendering 
{
    import starling.utils.*;
    
    public class BatchToken extends Object
    {
        public function BatchToken(arg1:int=0, arg2:int=0, arg3:int=0)
        {
            super();
            this.setTo(arg1, arg2, arg3);
            return;
        }

        public function copyFrom(arg1:starling.rendering.BatchToken):void
        {
            this.batchID = arg1.batchID;
            this.vertexID = arg1.vertexID;
            this.indexID = arg1.indexID;
            return;
        }

        public function setTo(arg1:int=0, arg2:int=0, arg3:int=0):void
        {
            this.batchID = arg1;
            this.vertexID = arg2;
            this.indexID = arg3;
            return;
        }

        public function reset():void
        {
            var loc1:*;
            this.indexID = loc1 = 0;
            this.vertexID = loc1 = loc1;
            this.batchID = loc1;
            return;
        }

        public function equals(arg1:starling.rendering.BatchToken):Boolean
        {
            return this.batchID == arg1.batchID && this.vertexID == arg1.vertexID && this.indexID == arg1.indexID;
        }

        public function toString():String
        {
            return starling.utils.StringUtil.format("[BatchToken batchID={0} vertexID={1} indexID={2}]", this.batchID, this.vertexID, this.indexID);
        }

        public var batchID:int;

        public var vertexID:int;

        public var indexID:int;
    }
}


//  class Effect
package starling.rendering 
{
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.utils.*;
    
    public class Effect extends Object
    {
        public function Effect()
        {
            super();
            this._mvpMatrix3D = new flash.geom.Matrix3D();
            this._programBaseName = flash.utils.getQualifiedClassName(this);
            starling.core.Starling.current.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 20, true);
            return;
        }

        public function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        public function get mvpMatrix3D():flash.geom.Matrix3D
        {
            return this._mvpMatrix3D;
        }

        public function set mvpMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            this._mvpMatrix3D.copyFrom(arg1);
            return;
        }

        protected function get indexBuffer():flash.display3D.IndexBuffer3D
        {
            return this._indexBuffer;
        }

        protected function get indexBufferSize():int
        {
            return this._indexBufferSize;
        }

        protected function get vertexBuffer():flash.display3D.VertexBuffer3D
        {
            return this._vertexBuffer;
        }

        protected function get vertexBufferSize():int
        {
            return this._vertexBufferSize;
        }

        
        {
            sProgramNameCache = new flash.utils.Dictionary();
        }

        public function dispose():void
        {
            starling.core.Starling.current.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            this.purgeBuffers();
            return;
        }

        internal function onContextCreated(arg1:flash.events.Event):void
        {
            this.purgeBuffers();
            starling.utils.execute(this._onRestore, this);
            return;
        }

        public function purgeBuffers(arg1:Boolean=true, arg2:Boolean=true):void
        {
            if (this._vertexBuffer && arg1) 
            {
                try 
                {
                    this._vertexBuffer.dispose();
                }
                catch (e:Error)
                {
                };
                this._vertexBuffer = null;
            }
            if (this._indexBuffer && arg2) 
            {
                try 
                {
                    this._indexBuffer.dispose();
                }
                catch (e:Error)
                {
                };
                this._indexBuffer = null;
            }
            return;
        }

        public function uploadIndexData(arg1:starling.rendering.IndexData, arg2:String="staticDraw"):void
        {
            var loc1:*=arg1.numIndices;
            var loc2:*=arg1.useQuadLayout;
            var loc3:*=this._indexBufferUsesQuadLayout;
            if (this._indexBuffer) 
            {
                if (loc1 <= this._indexBufferSize) 
                {
                    if (!loc2 || !loc3) 
                    {
                        arg1.uploadToIndexBuffer(this._indexBuffer);
                        this._indexBufferUsesQuadLayout = loc2 && loc1 == this._indexBufferSize;
                    }
                }
                else 
                {
                    this.purgeBuffers(false, true);
                }
            }
            if (this._indexBuffer == null) 
            {
                this._indexBuffer = arg1.createIndexBuffer(true, arg2);
                this._indexBufferSize = loc1;
                this._indexBufferUsesQuadLayout = loc2;
            }
            return;
        }

        public function uploadVertexData(arg1:starling.rendering.VertexData, arg2:String="staticDraw"):void
        {
            if (this._vertexBuffer) 
            {
                if (arg1.size <= this._vertexBufferSize) 
                {
                    arg1.uploadToVertexBuffer(this._vertexBuffer);
                }
                else 
                {
                    this.purgeBuffers(true, false);
                }
            }
            if (this._vertexBuffer == null) 
            {
                this._vertexBuffer = arg1.createVertexBuffer(true, arg2);
                this._vertexBufferSize = arg1.size;
            }
            return;
        }

        public function render(arg1:int=0, arg2:int=-1):void
        {
            if (arg2 < 0) 
            {
                arg2 = this._indexBufferSize / 3;
            }
            if (arg2 == 0) 
            {
                return;
            }
            var loc1:*=starling.core.Starling.context;
            if (loc1 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            this.beforeDraw(loc1);
            loc1.drawTriangles(this.indexBuffer, arg1, arg2);
            this.afterDraw(loc1);
            return;
        }

        protected function beforeDraw(arg1:flash.display3D.Context3D):void
        {
            this.program.activate(arg1);
            this.vertexFormat.setVertexBufferAt(0, this.vertexBuffer, "position");
            arg1.setProgramConstantsFromMatrix(flash.display3D.Context3DProgramType.VERTEX, 0, this.mvpMatrix3D, true);
            return;
        }

        protected function afterDraw(arg1:flash.display3D.Context3D):void
        {
            arg1.setVertexBufferAt(0, null);
            return;
        }

        protected function createProgram():starling.rendering.Program
        {
            var loc1:*=["m44 op, va0, vc0", "seq v0, va0, va0"].join("\n");
            var loc2:*="mov oc, v0";
            return starling.rendering.Program.fromSource(loc1, loc2);
        }

        protected function get programVariantName():uint
        {
            return 0;
        }

        protected function get programBaseName():String
        {
            return this._programBaseName;
        }

        protected function set programBaseName(arg1:String):void
        {
            this._programBaseName = arg1;
            return;
        }

        protected function get programName():String
        {
            var loc1:*=this.programBaseName;
            var loc2:*=this.programVariantName;
            var loc3:*=sProgramNameCache[loc1];
            if (loc3 == null) 
            {
                loc3 = new flash.utils.Dictionary();
                sProgramNameCache[loc1] = loc3;
            }
            var loc4:*=loc3[loc2];
            if (loc4 == null) 
            {
                if (loc2) 
                {
                    loc4 = loc1 + "#" + loc2.toString(16);
                }
                else 
                {
                    loc4 = loc1;
                }
                loc3[loc2] = loc4;
            }
            return loc4;
        }

        protected function get program():starling.rendering.Program
        {
            var loc1:*=this.programName;
            var loc2:*=starling.core.Starling.painter;
            var loc3:*=loc2.getProgram(loc1);
            if (loc3 == null) 
            {
                loc3 = this.createProgram();
                loc2.registerProgram(loc1, loc3);
            }
            return loc3;
        }

        public function get onRestore():Function
        {
            return this._onRestore;
        }

        public function set onRestore(arg1:Function):void
        {
            this._onRestore = arg1;
            return;
        }

        public static const VERTEX_FORMAT:starling.rendering.VertexDataFormat=starling.rendering.VertexDataFormat.fromString("position:float2");

        internal var _vertexBuffer:flash.display3D.VertexBuffer3D;

        internal var _vertexBufferSize:int;

        internal var _indexBuffer:flash.display3D.IndexBuffer3D;

        internal var _indexBufferSize:int;

        internal var _indexBufferUsesQuadLayout:Boolean;

        internal var _mvpMatrix3D:flash.geom.Matrix3D;

        internal var _onRestore:Function;

        internal var _programBaseName:String;

        internal static var sProgramNameCache:flash.utils.Dictionary;
    }
}


//  class FilterEffect
package starling.rendering 
{
    import flash.display3D.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class FilterEffect extends starling.rendering.Effect
    {
        public function FilterEffect()
        {
            super();
            this._textureSmoothing = starling.textures.TextureSmoothing.BILINEAR;
            return;
        }

        protected override function get programVariantName():uint
        {
            return starling.utils.RenderUtil.getTextureVariantBits(this._texture);
        }

        protected override function createProgram():starling.rendering.Program
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._texture) 
            {
                loc1 = STD_VERTEX_SHADER;
                loc2 = tex("oc", "v0", 0, this._texture);
                return starling.rendering.Program.fromSource(loc1, loc2);
            }
            return super.createProgram();
        }

        protected override function beforeDraw(arg1:flash.display3D.Context3D):void
        {
            var loc1:*=false;
            super.beforeDraw(arg1);
            if (this._texture) 
            {
                loc1 = this._textureRepeat && this._texture.root.isPotTexture;
                starling.utils.RenderUtil.setSamplerStateAt(0, this._texture.mipMapping, this._textureSmoothing, loc1);
                arg1.setTextureAt(0, this._texture.base);
                this.vertexFormat.setVertexBufferAt(1, vertexBuffer, "texCoords");
            }
            return;
        }

        protected override function afterDraw(arg1:flash.display3D.Context3D):void
        {
            if (this._texture) 
            {
                arg1.setTextureAt(0, null);
                arg1.setVertexBufferAt(1, null);
            }
            super.afterDraw(arg1);
            return;
        }

        public override function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        public function get texture():starling.textures.Texture
        {
            return this._texture;
        }

        public function set texture(arg1:starling.textures.Texture):void
        {
            this._texture = arg1;
            return;
        }

        public function get textureSmoothing():String
        {
            return this._textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            this._textureSmoothing = arg1;
            return;
        }

        public function get textureRepeat():Boolean
        {
            return this._textureRepeat;
        }

        public function set textureRepeat(arg1:Boolean):void
        {
            this._textureRepeat = arg1;
            return;
        }

        protected static function tex(arg1:String, arg2:String, arg3:int, arg4:starling.textures.Texture, arg5:Boolean=true):String
        {
            return starling.utils.RenderUtil.createAGALTexOperation(arg1, arg2, arg3, arg4, arg5);
        }

        public static const VERTEX_FORMAT:starling.rendering.VertexDataFormat=starling.rendering.Effect.VERTEX_FORMAT.extend("texCoords:float2");

        public static const STD_VERTEX_SHADER:String="m44 op, va0, vc0 \n" + "mov v0, va1";

        internal var _texture:starling.textures.Texture;

        internal var _textureSmoothing:String;

        internal var _textureRepeat:Boolean;
    }
}


//  class IndexData
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


//  class MeshEffect
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.utils.*;
    
    public class MeshEffect extends starling.rendering.FilterEffect
    {
        public function MeshEffect()
        {
            super();
            this._alpha = 1;
            this._optimizeIfNotTinted = flash.utils.getQualifiedClassName(this) == "starling.rendering::MeshEffect";
            return;
        }

        protected override function get programVariantName():uint
        {
            var loc1:*=uint(this._optimizeIfNotTinted && !this._tinted && this._alpha == 1);
            return super.programVariantName | loc1 << 3;
        }

        protected override function createProgram():starling.rendering.Program
        {
            var loc1:*=null;
            var loc2:*=null;
            if (texture) 
            {
                if (this._optimizeIfNotTinted && !this._tinted && this._alpha == 1) 
                {
                    return super.createProgram();
                }
                loc1 = "m44 op, va0, vc0 \n" + "mov v0, va1      \n" + "mul v1, va2, vc4 \n";
                loc2 = tex("ft0", "v0", 0, texture) + "mul oc, ft0, v1  \n";
            }
            else 
            {
                loc1 = "m44 op, va0, vc0 \n" + "mul v0, va2, vc4 \n";
                loc2 = "mov oc, v0       \n";
            }
            return starling.rendering.Program.fromSource(loc1, loc2);
        }

        protected override function beforeDraw(arg1:flash.display3D.Context3D):void
        {
            super.beforeDraw(arg1);
            var loc1:*;
            sRenderAlpha[3] = loc1 = this._alpha;
            sRenderAlpha[2] = loc1 = loc1;
            sRenderAlpha[1] = loc1 = loc1;
            sRenderAlpha[0] = loc1;
            arg1.setProgramConstantsFromVector(flash.display3D.Context3DProgramType.VERTEX, 4, sRenderAlpha);
            if (this._tinted || !(this._alpha == 1) || !this._optimizeIfNotTinted || texture == null) 
            {
                this.vertexFormat.setVertexBufferAt(2, vertexBuffer, "color");
            }
            return;
        }

        protected override function afterDraw(arg1:flash.display3D.Context3D):void
        {
            arg1.setVertexBufferAt(2, null);
            super.afterDraw(arg1);
            return;
        }

        public override function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        public function get alpha():Number
        {
            return this._alpha;
        }

        public function set alpha(arg1:Number):void
        {
            this._alpha = arg1;
            return;
        }

        public function get tinted():Boolean
        {
            return this._tinted;
        }

        public function set tinted(arg1:Boolean):void
        {
            this._tinted = arg1;
            return;
        }

        
        {
            sRenderAlpha = new Vector.<Number>(4, true);
        }

        public static const VERTEX_FORMAT:starling.rendering.VertexDataFormat=starling.rendering.FilterEffect.VERTEX_FORMAT.extend("color:bytes4");

        internal var _alpha:Number;

        internal var _tinted:Boolean;

        internal var _optimizeIfNotTinted:Boolean;

        internal static var sRenderAlpha:__AS3__.vec.Vector.<Number>;
    }
}


//  class Painter
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Painter extends Object
    {
        public function Painter(arg1:flash.display.Stage3D)
        {
            super();
            this._stage3D = arg1;
            this._stage3D.addEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 40, true);
            this._context = this._stage3D.context3D;
            this._shareContext = this._context && !(this._context.driverInfo == "Disposed");
            this._backBufferWidth = this._context ? this._context.backBufferWidth : 0;
            this._backBufferHeight = this._context ? this._context.backBufferHeight : 0;
            var loc1:*;
            this._pixelSize = loc1 = 1;
            this._backBufferScaleFactor = loc1;
            this._stencilReferenceValues = new flash.utils.Dictionary(true);
            this._clipRectStack = new Vector.<flash.geom.Rectangle>(0);
            this._batchProcessorCurr = new BatchProcessor();
            this._batchProcessorCurr.onBatchComplete = this.drawBatch;
            this._batchProcessorPrev = new BatchProcessor();
            this._batchProcessorPrev.onBatchComplete = this.drawBatch;
            this._batchProcessorSpec = new BatchProcessor();
            this._batchProcessorSpec.onBatchComplete = this.drawBatch;
            this._batchProcessor = this._batchProcessorCurr;
            this._batchCacheExclusions = new Vector.<starling.display.DisplayObject>();
            this._state = new starling.rendering.RenderState();
            this._state.onDrawRequired = this.finishMeshBatch;
            this._stateStack = new Vector.<starling.rendering.RenderState>(0);
            this._stateStackPos = -1;
            this._stateStackLength = 0;
            return;
        }

        public function set drawCount(arg1:int):void
        {
            this._drawCount = arg1;
            return;
        }

        public function get stencilReferenceValue():uint
        {
            var loc1:*=this._state.renderTarget ? this._state.renderTargetBase : this;
            if (loc1 in this._stencilReferenceValues) 
            {
                return this._stencilReferenceValues[loc1];
            }
            return 0;
        }

        public function set stencilReferenceValue(arg1:uint):void
        {
            var loc1:*=this._state.renderTarget ? this._state.renderTargetBase : this;
            this._stencilReferenceValues[loc1] = arg1;
            if (this.contextValid) 
            {
                this._context.setStencilReferenceValue(arg1);
            }
            return;
        }

        public function get cacheEnabled():Boolean
        {
            return this._batchProcessor == this._batchProcessorCurr;
        }

        public function set cacheEnabled(arg1:Boolean):void
        {
            if (arg1 != this.cacheEnabled) 
            {
                this.finishMeshBatch();
                if (arg1) 
                {
                    this._batchProcessor = this._batchProcessorCurr;
                }
                else 
                {
                    this._batchProcessor = this._batchProcessorSpec;
                }
            }
            return;
        }

        public function get state():starling.rendering.RenderState
        {
            return this._state;
        }

        public function get stage3D():flash.display.Stage3D
        {
            return this._stage3D;
        }

        public function get context():flash.display3D.Context3D
        {
            return this._context;
        }

        public function set frameID(arg1:uint):void
        {
            this._frameID = arg1;
            return;
        }

        public function get frameID():uint
        {
            return this._batchProcessor != this._batchProcessorCurr ? 0 : this._frameID;
        }

        public function nextFrame():void
        {
            this._batchProcessor = this.swapBatchProcessors();
            this._batchProcessor.clear();
            this._batchProcessorSpec.clear();
            this._actualBlendMode = null;
            this._actualCulling = null;
            this._context.setDepthTest(false, flash.display3D.Context3DCompareMode.ALWAYS);
            this.stencilReferenceValue = 0;
            this._clipRectStack.length = 0;
            this._drawCount = 0;
            this._stateStackPos = -1;
            this._state.reset();
            return;
        }

        public function get pixelSize():Number
        {
            return this._pixelSize;
        }

        public function set pixelSize(arg1:Number):void
        {
            this._pixelSize = arg1;
            return;
        }

        public function get shareContext():Boolean
        {
            return this._shareContext;
        }

        public function set shareContext(arg1:Boolean):void
        {
            this._shareContext = arg1;
            return;
        }

        public function get enableErrorChecking():Boolean
        {
            return this._enableErrorChecking;
        }

        public function set enableErrorChecking(arg1:Boolean):void
        {
            this._enableErrorChecking = arg1;
            if (this._context) 
            {
                this._context.enableErrorChecking = arg1;
            }
            return;
        }

        public function get backBufferWidth():int
        {
            return this._backBufferWidth;
        }

        public function get backBufferHeight():int
        {
            return this._backBufferHeight;
        }

        public function get backBufferScaleFactor():Number
        {
            return this._backBufferScaleFactor;
        }

        public function get contextValid():Boolean
        {
            var loc1:*=null;
            if (this._context) 
            {
                loc1 = this._context.driverInfo;
                return !(loc1 == null) && !(loc1 == "") && !(loc1 == "Disposed");
            }
            return false;
        }

        public function get profile():String
        {
            if (this._context) 
            {
                return this._context.profile;
            }
            return null;
        }

        internal function get programs():flash.utils.Dictionary
        {
            var loc1:*=this.sharedData[PROGRAM_DATA_NAME] as flash.utils.Dictionary;
            if (loc1 == null) 
            {
                loc1 = new flash.utils.Dictionary();
                this.sharedData[PROGRAM_DATA_NAME] = loc1;
            }
            return loc1;
        }

        
        {
            sSharedData = new flash.utils.Dictionary();
            sMatrix = new flash.geom.Matrix();
            sPoint3D = new flash.geom.Vector3D();
            sMatrix3D = new flash.geom.Matrix3D();
            sClipRect = new flash.geom.Rectangle();
            sBufferRect = new flash.geom.Rectangle();
            sScissorRect = new flash.geom.Rectangle();
            sMeshSubset = new starling.utils.MeshSubset();
        }

        public function dispose():void
        {
            this._batchProcessorCurr.dispose();
            this._batchProcessorPrev.dispose();
            this._batchProcessorSpec.dispose();
            if (!this._shareContext) 
            {
                this._context.dispose(false);
                sSharedData = new flash.utils.Dictionary();
            }
            return;
        }

        public function requestContext3D(arg1:String, arg2:*):void
        {
            starling.utils.RenderUtil.requestContext3D(this._stage3D, arg1, arg2);
            return;
        }

        internal function onContextCreated(arg1:Object):void
        {
            this._context = this._stage3D.context3D;
            this._context.enableErrorChecking = this._enableErrorChecking;
            this._context.setDepthTest(false, flash.display3D.Context3DCompareMode.ALWAYS);
            this._actualBlendMode = null;
            this._actualCulling = null;
            return;
        }

        public function configureBackBuffer(arg1:flash.geom.Rectangle, arg2:Number, arg3:int, arg4:Boolean):void
        {
            if (!this._shareContext) 
            {
                arg4 = arg4 && starling.utils.SystemUtil.supportsDepthAndStencil;
                if (this._context.profile == "baselineConstrained") 
                {
                    this._context.configureBackBuffer(32, 32, arg3, arg4);
                }
                if (arg1.width * arg2 > this._context.maxBackBufferWidth || arg1.height * arg2 > this._context.maxBackBufferHeight) 
                {
                    arg2 = 1;
                }
                this._stage3D.x = arg1.x;
                this._stage3D.y = arg1.y;
                this._context.configureBackBuffer(arg1.width, arg1.height, arg3, arg4, !(arg2 == 1));
            }
            this._backBufferWidth = arg1.width;
            this._backBufferHeight = arg1.height;
            this._backBufferScaleFactor = arg2;
            return;
        }

        public function registerProgram(arg1:String, arg2:starling.rendering.Program):void
        {
            this.deleteProgram(arg1);
            this.programs[arg1] = arg2;
            return;
        }

        public function deleteProgram(arg1:String):void
        {
            var loc1:*=this.getProgram(arg1);
            if (loc1) 
            {
                loc1.dispose();
                delete this.programs[arg1];
            }
            return;
        }

        public function getProgram(arg1:String):starling.rendering.Program
        {
            return this.programs[arg1] as starling.rendering.Program;
        }

        public function hasProgram(arg1:String):Boolean
        {
            return arg1 in this.programs;
        }

        public function pushState(arg1:starling.rendering.BatchToken=null):void
        {
            var loc1:*;
            var loc2:*=((loc1 = this)._stateStackPos + 1);
            loc1._stateStackPos = loc2;
            if (this._stateStackLength < this._stateStackPos + 1) 
            {
                var loc3:*=((loc2 = this)._stateStackLength + 1);
                loc2._stateStackLength = loc3;
                loc1 = (loc2 = this)._stateStackLength;
                this._stateStack[loc1] = new starling.rendering.RenderState();
            }
            if (arg1) 
            {
                this._batchProcessor.fillToken(arg1);
            }
            this._stateStack[this._stateStackPos].copyFrom(this._state);
            return;
        }

        public function setStateTo(arg1:flash.geom.Matrix, arg2:Number=1, arg3:String="auto"):void
        {
            if (arg1) 
            {
                starling.utils.MatrixUtil.prependMatrix(this._state._modelviewMatrix, arg1);
            }
            if (arg2 != 1) 
            {
                this._state._alpha = this._state._alpha * arg2;
            }
            if (arg3 != starling.display.BlendMode.AUTO) 
            {
                this._state.blendMode = arg3;
            }
            return;
        }

        public function popState(arg1:starling.rendering.BatchToken=null):void
        {
            if (this._stateStackPos < 0) 
            {
                throw new flash.errors.IllegalOperationError("Cannot pop empty state stack");
            }
            this._state.copyFrom(this._stateStack[this._stateStackPos]);
            var loc1:*;
            var loc2:*=((loc1 = this)._stateStackPos - 1);
            loc1._stateStackPos = loc2;
            if (arg1) 
            {
                this._batchProcessor.fillToken(arg1);
            }
            return;
        }

        public function drawMask(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject=null):void
        {
            if (this._context == null) 
            {
                return;
            }
            this.finishMeshBatch();
            if (this.isRectangularMask(arg1, arg2, sMatrix)) 
            {
                arg1.getBounds(arg1, sClipRect);
                starling.utils.RectangleUtil.getBounds(sClipRect, sMatrix, sClipRect);
                this.pushClipRect(sClipRect);
            }
            else 
            {
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.INCREMENT_SATURATE);
                this.renderMask(arg1);
                var loc1:*;
                var loc2:*=((loc1 = this).stencilReferenceValue + 1);
                loc1.stencilReferenceValue = loc2;
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.KEEP);
            }
            this.excludeFromCache(arg2);
            return;
        }

        public function eraseMask(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject=null):void
        {
            if (this._context == null) 
            {
                return;
            }
            this.finishMeshBatch();
            if (this.isRectangularMask(arg1, arg2, sMatrix)) 
            {
                this.popClipRect();
            }
            else 
            {
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.DECREMENT_SATURATE);
                this.renderMask(arg1);
                var loc1:*;
                var loc2:*=((loc1 = this).stencilReferenceValue - 1);
                loc1.stencilReferenceValue = loc2;
                this._context.setStencilActions(flash.display3D.Context3DTriangleFace.FRONT_AND_BACK, flash.display3D.Context3DCompareMode.EQUAL, flash.display3D.Context3DStencilAction.KEEP);
            }
            return;
        }

        internal function renderMask(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this.cacheEnabled;
            this.pushState();
            this.cacheEnabled = false;
            this._state.alpha = 0;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1.stage) 
            {
                this._state.setModelviewMatricesToIdentity();
                if (arg1.is3D) 
                {
                    loc3 = arg1.getTransformationMatrix3D(null, sMatrix3D);
                }
                else 
                {
                    loc2 = arg1.getTransformationMatrix(null, sMatrix);
                }
            }
            else if (arg1.is3D) 
            {
                loc3 = arg1.transformationMatrix3D;
            }
            else 
            {
                loc2 = arg1.transformationMatrix;
            }
            if (loc3) 
            {
                this._state.transformModelviewMatrix3D(loc3);
            }
            else 
            {
                this._state.transformModelviewMatrix(loc2);
            }
            arg1.render(this);
            this.finishMeshBatch();
            this.cacheEnabled = loc1;
            this.popState();
            return;
        }

        internal function pushClipRect(arg1:flash.geom.Rectangle):void
        {
            var loc1:*=this._clipRectStack;
            var loc2:*=loc1.length;
            var loc3:*=starling.utils.Pool.getRectangle();
            if (loc2) 
            {
                starling.utils.RectangleUtil.intersect(loc1[(loc2 - 1)], arg1, loc3);
            }
            else 
            {
                loc3.copyFrom(arg1);
            }
            loc1[loc2] = loc3;
            this._state.clipRect = loc3;
            return;
        }

        internal function popClipRect():void
        {
            var loc1:*=this._clipRectStack;
            var loc2:*=loc1.length;
            if (loc2 == 0) 
            {
                throw new Error("Trying to pop from empty clip rectangle stack");
            }
            --loc2;
            starling.utils.Pool.putRectangle(loc1.pop());
            this._state.clipRect = loc2 ? loc1[(loc2 - 1)] : null;
            return;
        }

        internal function isRectangularMask(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:flash.geom.Matrix):Boolean
        {
            var loc1:*=arg1 as starling.display.Quad;
            var loc2:*=arg1.is3D || arg2 && arg2.is3D && arg1.stage == null;
            if (loc1 && !loc2 && loc1.texture == null) 
            {
                if (arg1.stage) 
                {
                    arg1.getTransformationMatrix(null, arg3);
                }
                else 
                {
                    arg3.copyFrom(arg1.transformationMatrix);
                    arg3.concat(this._state.modelviewMatrix);
                }
                return starling.utils.MathUtil.isEquivalent(arg3.a, 0) && starling.utils.MathUtil.isEquivalent(arg3.d, 0) || starling.utils.MathUtil.isEquivalent(arg3.b, 0) && starling.utils.MathUtil.isEquivalent(arg3.c, 0);
            }
            return false;
        }

        public function batchMesh(arg1:starling.display.Mesh, arg2:starling.utils.MeshSubset=null):void
        {
            this._batchProcessor.addMesh(arg1, this._state, arg2);
            return;
        }

        public function finishMeshBatch():void
        {
            this._batchProcessor.finishBatch();
            return;
        }

        public function finishFrame():void
        {
            if (this._frameID % 99 == 0) 
            {
                this._batchProcessorCurr.trim();
            }
            if (this._frameID % 150 == 0) 
            {
                this._batchProcessorSpec.trim();
            }
            this._batchProcessor.finishBatch();
            this._batchProcessor = this._batchProcessorSpec;
            this.processCacheExclusions();
            return;
        }

        internal function processCacheExclusions():void
        {
            var loc1:*=0;
            var loc2:*=this._batchCacheExclusions.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                this._batchCacheExclusions[loc1].starling_internal::excludeFromCache();
                ++loc1;
            }
            this._batchCacheExclusions.length = 0;
            return;
        }

        public function get sharedData():flash.utils.Dictionary
        {
            var loc1:*=sSharedData[this.stage3D] as flash.utils.Dictionary;
            if (loc1 == null) 
            {
                loc1 = new flash.utils.Dictionary();
                sSharedData[this.stage3D] = loc1;
            }
            return loc1;
        }

        internal function swapBatchProcessors():BatchProcessor
        {
            var loc1:*=this._batchProcessorPrev;
            this._batchProcessorPrev = this._batchProcessorCurr;
            var loc2:*;
            this._batchProcessorCurr = loc2 = loc1;
            return loc2;
        }

        public function drawFromCache(arg1:starling.rendering.BatchToken, arg2:starling.rendering.BatchToken):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=sMeshSubset;
            if (!arg1.equals(arg2)) 
            {
                this.pushState();
                loc3 = arg1.batchID;
                while (loc3 <= arg2.batchID) 
                {
                    loc1 = this._batchProcessorPrev.getBatchAt(loc3);
                    loc2.setTo();
                    if (loc3 == arg1.batchID) 
                    {
                        loc2.vertexID = arg1.vertexID;
                        loc2.indexID = arg1.indexID;
                        loc2.numVertices = loc1.numVertices - loc2.vertexID;
                        loc2.numIndices = loc1.numIndices - loc2.indexID;
                    }
                    if (loc3 == arg2.batchID) 
                    {
                        loc2.numVertices = arg2.vertexID - loc2.vertexID;
                        loc2.numIndices = arg2.indexID - loc2.indexID;
                    }
                    if (loc2.numVertices) 
                    {
                        this._state.alpha = 1;
                        this._state.blendMode = loc1.blendMode;
                        this._batchProcessor.addMesh(loc1, this._state, loc2, true);
                    }
                    ++loc3;
                }
                this.popState();
            }
            return;
        }

        public function excludeFromCache(arg1:starling.display.DisplayObject):void
        {
            if (arg1) 
            {
                this._batchCacheExclusions[this._batchCacheExclusions.length] = arg1;
            }
            return;
        }

        internal function drawBatch(arg1:starling.display.MeshBatch):void
        {
            this.pushState();
            this.state.blendMode = arg1.blendMode;
            this.state.modelviewMatrix.identity();
            this.state.alpha = 1;
            arg1.render(this);
            this.popState();
            return;
        }

        public function prepareToDraw():void
        {
            this.applyBlendMode();
            this.applyRenderTarget();
            this.applyClipRect();
            this.applyCulling();
            return;
        }

        public function clear(arg1:uint=0, arg2:Number=0):void
        {
            this.applyRenderTarget();
            this.stencilReferenceValue = 0;
            starling.utils.RenderUtil.clear(arg1, arg2);
            return;
        }

        public function present():void
        {
            this._state.renderTarget = null;
            this._actualRenderTarget = null;
            this._context.present();
            return;
        }

        internal function applyBlendMode():void
        {
            var loc1:*=this._state.blendMode;
            if (loc1 != this._actualBlendMode) 
            {
                starling.display.BlendMode.get(this._state.blendMode).activate();
                this._actualBlendMode = loc1;
            }
            return;
        }

        internal function applyCulling():void
        {
            var loc1:*=this._state.culling;
            if (loc1 != this._actualCulling) 
            {
                this._context.setCulling(loc1);
                this._actualCulling = loc1;
            }
            return;
        }

        internal function applyRenderTarget():void
        {
            var loc2:*=0;
            var loc3:*=false;
            var loc1:*=this._state.renderTargetBase;
            if (loc1 != this._actualRenderTarget) 
            {
                if (loc1) 
                {
                    loc2 = this._state.renderTargetAntiAlias;
                    loc3 = this._state.renderTargetSupportsDepthAndStencil;
                    this._context.setRenderToTexture(loc1, loc3, loc2);
                }
                else 
                {
                    this._context.setRenderToBackBuffer();
                }
                this._context.setStencilReferenceValue(this.stencilReferenceValue);
                this._actualRenderTarget = loc1;
            }
            return;
        }

        internal function applyClipRect():void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=this._state.clipRect;
            if (loc1) 
            {
                loc4 = this._state.projectionMatrix3D;
                loc5 = this._state.renderTarget;
                if (loc5) 
                {
                    loc2 = loc5.root.nativeWidth;
                    loc3 = loc5.root.nativeHeight;
                }
                else 
                {
                    loc2 = this._backBufferWidth;
                    loc3 = this._backBufferHeight;
                }
                starling.utils.MatrixUtil.transformCoords3D(loc4, loc1.x, loc1.y, 0, sPoint3D);
                sPoint3D.project();
                sClipRect.x = (sPoint3D.x * 0.5 + 0.5) * loc2;
                sClipRect.y = (0.5 - sPoint3D.y * 0.5) * loc3;
                starling.utils.MatrixUtil.transformCoords3D(loc4, loc1.right, loc1.bottom, 0, sPoint3D);
                sPoint3D.project();
                sClipRect.right = (sPoint3D.x * 0.5 + 0.5) * loc2;
                sClipRect.bottom = (0.5 - sPoint3D.y * 0.5) * loc3;
                sBufferRect.setTo(0, 0, loc2, loc3);
                starling.utils.RectangleUtil.intersect(sClipRect, sBufferRect, sScissorRect);
                if (sScissorRect.width < 1 || sScissorRect.height < 1) 
                {
                    sScissorRect.setTo(0, 0, 1, 1);
                }
                this._context.setScissorRectangle(sScissorRect);
            }
            else 
            {
                this._context.setScissorRectangle(null);
            }
            return;
        }

        public function get drawCount():int
        {
            return this._drawCount;
        }

        internal static const PROGRAM_DATA_NAME:String="starling.rendering.Painter.Programs";

        internal var _context:flash.display3D.Context3D;

        internal var _shareContext:Boolean;

        internal var _drawCount:int;

        internal var _frameID:uint;

        internal var _pixelSize:Number;

        internal var _enableErrorChecking:Boolean;

        internal var _stencilReferenceValues:flash.utils.Dictionary;

        internal var _clipRectStack:__AS3__.vec.Vector.<flash.geom.Rectangle>;

        internal var _batchCacheExclusions:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _batchProcessorCurr:BatchProcessor;

        internal var _batchProcessorPrev:BatchProcessor;

        internal var _batchProcessorSpec:BatchProcessor;

        internal var _actualRenderTarget:flash.display3D.textures.TextureBase;

        internal var _actualCulling:String;

        internal var _actualBlendMode:String;

        internal var _backBufferWidth:Number;

        internal var _backBufferHeight:Number;

        internal var _backBufferScaleFactor:Number;

        internal var _state:starling.rendering.RenderState;

        internal var _stateStack:__AS3__.vec.Vector.<starling.rendering.RenderState>;

        internal var _stateStackPos:int;

        internal var _stateStackLength:int;

        internal var _stage3D:flash.display.Stage3D;

        internal static var sSharedData:flash.utils.Dictionary;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrix3D:flash.geom.Matrix3D;

        internal static var sClipRect:flash.geom.Rectangle;

        internal static var sBufferRect:flash.geom.Rectangle;

        internal static var sScissorRect:flash.geom.Rectangle;

        internal static var sMeshSubset:starling.utils.MeshSubset;

        internal var _batchProcessor:BatchProcessor;
    }
}


//  class Program
package starling.rendering 
{
    import com.adobe.utils.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    
    public class Program extends Object
    {
        public function Program(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray)
        {
            super();
            this._vertexShader = arg1;
            this._fragmentShader = arg2;
            starling.core.Starling.current.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 30, true);
            return;
        }

        public function dispose():void
        {
            starling.core.Starling.current.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            this.disposeProgram();
            return;
        }

        public function activate(arg1:flash.display3D.Context3D=null):void
        {
            if (arg1 == null) 
            {
                arg1 = starling.core.Starling.context;
                if (arg1 == null) 
                {
                    throw new starling.errors.MissingContextError();
                }
            }
            if (this._program3D == null) 
            {
                this._program3D = arg1.createProgram();
                this._program3D.upload(this._vertexShader, this._fragmentShader);
            }
            arg1.setProgram(this._program3D);
            return;
        }

        internal function onContextCreated(arg1:flash.events.Event):void
        {
            this.disposeProgram();
            return;
        }

        internal function disposeProgram():void
        {
            if (this._program3D) 
            {
                this._program3D.dispose();
                this._program3D = null;
            }
            return;
        }

        public static function fromSource(arg1:String, arg2:String, arg3:uint=1):starling.rendering.Program
        {
            return new Program(sAssembler.assemble(flash.display3D.Context3DProgramType.VERTEX, arg1, arg3), sAssembler.assemble(flash.display3D.Context3DProgramType.FRAGMENT, arg2, arg3));
        }

        
        {
            sAssembler = new com.adobe.utils.AGALMiniAssembler();
        }

        internal var _vertexShader:flash.utils.ByteArray;

        internal var _fragmentShader:flash.utils.ByteArray;

        internal var _program3D:flash.display3D.Program3D;

        internal static var sAssembler:com.adobe.utils.AGALMiniAssembler;
    }
}


//  class RenderState
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class RenderState extends Object
    {
        public function RenderState()
        {
            super();
            this.reset();
            return;
        }

        function get renderTargetBase():flash.display3D.textures.TextureBase
        {
            return this._renderTarget ? this._renderTarget.base : null;
        }

        public function get culling():String
        {
            var loc1:*=(this._miscOptions & 3840) >> 8;
            return CULLING_VALUES[loc1];
        }

        public function set culling(arg1:String):void
        {
            var loc1:*=0;
            if (this.culling != arg1) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                loc1 = CULLING_VALUES.indexOf(arg1);
                if (loc1 == -1) 
                {
                    throw new ArgumentError("Invalid culling mode");
                }
                this._miscOptions = this._miscOptions & 4294963455 | loc1 << 8;
            }
            return;
        }

        public function get clipRect():flash.geom.Rectangle
        {
            return this._clipRect;
        }

        public function get projectionMatrix3D():flash.geom.Matrix3D
        {
            return this._projectionMatrix3D;
        }

        public function set clipRect(arg1:flash.geom.Rectangle):void
        {
            if (!starling.utils.RectangleUtil.compare(this._clipRect, arg1)) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                if (arg1) 
                {
                    if (this._clipRect == null) 
                    {
                        this._clipRect = starling.utils.Pool.getRectangle();
                    }
                    this._clipRect.copyFrom(arg1);
                }
                else if (this._clipRect) 
                {
                    starling.utils.Pool.putRectangle(this._clipRect);
                    this._clipRect = null;
                }
            }
            return;
        }

        public function get renderTargetAntiAlias():int
        {
            return this._miscOptions & 15;
        }

        public function get renderTargetSupportsDepthAndStencil():Boolean
        {
            return !((this._miscOptions & 240) == 0);
        }

        public function get is3D():Boolean
        {
            return !(this._modelviewMatrix3D == null);
        }

        function set onDrawRequired(arg1:Function):void
        {
            this._onDrawRequired = arg1;
            return;
        }

        
        {
            new Vector.<String>(4)[0] = flash.display3D.Context3DTriangleFace.NONE;
            new Vector.<String>(4)[1] = flash.display3D.Context3DTriangleFace.FRONT;
            new Vector.<String>(4)[2] = flash.display3D.Context3DTriangleFace.BACK;
            new Vector.<String>(4)[3] = flash.display3D.Context3DTriangleFace.FRONT_AND_BACK;
            sMatrix3D = new flash.geom.Matrix3D();
            sProjectionMatrix3DRev = 0;
        }

        public function copyFrom(arg1:starling.rendering.RenderState):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=false;
            if (this._onDrawRequired != null) 
            {
                loc1 = this._renderTarget ? this._renderTarget.base : null;
                loc2 = arg1._renderTarget ? arg1._renderTarget.base : null;
                loc3 = !((this._miscOptions & 3840) == (arg1._miscOptions & 3840));
                loc4 = this._clipRect || arg1._clipRect ? !starling.utils.RectangleUtil.compare(this._clipRect, arg1._clipRect) : false;
                if (!(this._blendMode == arg1._blendMode) || !(loc1 == loc2) || loc4 || loc3) 
                {
                    this._onDrawRequired();
                }
            }
            this._alpha = arg1._alpha;
            this._blendMode = arg1._blendMode;
            this._renderTarget = arg1._renderTarget;
            this._miscOptions = arg1._miscOptions;
            this._modelviewMatrix.copyFrom(arg1._modelviewMatrix);
            if (this._projectionMatrix3DRev != arg1._projectionMatrix3DRev) 
            {
                this._projectionMatrix3DRev = arg1._projectionMatrix3DRev;
                this._projectionMatrix3D.copyFrom(arg1._projectionMatrix3D);
            }
            if (this._modelviewMatrix3D || arg1._modelviewMatrix3D) 
            {
                this.modelviewMatrix3D = arg1._modelviewMatrix3D;
            }
            if (this._clipRect || arg1._clipRect) 
            {
                this.clipRect = arg1._clipRect;
            }
            return;
        }

        public function reset():void
        {
            this.alpha = 1;
            this.blendMode = starling.display.BlendMode.NORMAL;
            this.culling = flash.display3D.Context3DTriangleFace.NONE;
            this.modelviewMatrix3D = null;
            this.renderTarget = null;
            this.clipRect = null;
            this._projectionMatrix3DRev = 0;
            if (this._modelviewMatrix) 
            {
                this._modelviewMatrix.identity();
            }
            else 
            {
                this._modelviewMatrix = new flash.geom.Matrix();
            }
            if (this._projectionMatrix3D) 
            {
                this._projectionMatrix3D.identity();
            }
            else 
            {
                this._projectionMatrix3D = new flash.geom.Matrix3D();
            }
            if (this._mvpMatrix3D == null) 
            {
                this._mvpMatrix3D = new flash.geom.Matrix3D();
            }
            return;
        }

        public function transformModelviewMatrix(arg1:flash.geom.Matrix):void
        {
            starling.utils.MatrixUtil.prependMatrix(this._modelviewMatrix, arg1);
            return;
        }

        public function transformModelviewMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            if (this._modelviewMatrix3D == null) 
            {
                this._modelviewMatrix3D = starling.utils.Pool.getMatrix3D();
            }
            this._modelviewMatrix3D.prepend(starling.utils.MatrixUtil.convertTo3D(this._modelviewMatrix, sMatrix3D));
            this._modelviewMatrix3D.prepend(arg1);
            this._modelviewMatrix.identity();
            return;
        }

        public function setProjectionMatrix(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number=0, arg6:Number=0, arg7:flash.geom.Vector3D=null):void
        {
            var loc1:*;
            var loc2:*;
            this._projectionMatrix3DRev = ++sProjectionMatrix3DRev;
            starling.utils.MatrixUtil.createPerspectiveProjectionMatrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, this._projectionMatrix3D);
            return;
        }

        public function setProjectionMatrixChanged():void
        {
            var loc1:*;
            var loc2:*;
            this._projectionMatrix3DRev = ++sProjectionMatrix3DRev;
            return;
        }

        public function setModelviewMatricesToIdentity():void
        {
            this._modelviewMatrix.identity();
            if (this._modelviewMatrix3D) 
            {
                this._modelviewMatrix3D.identity();
            }
            return;
        }

        public function get modelviewMatrix():flash.geom.Matrix
        {
            return this._modelviewMatrix;
        }

        public function set modelviewMatrix(arg1:flash.geom.Matrix):void
        {
            this._modelviewMatrix.copyFrom(arg1);
            return;
        }

        public function get modelviewMatrix3D():flash.geom.Matrix3D
        {
            return this._modelviewMatrix3D;
        }

        public function set modelviewMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            if (arg1) 
            {
                if (this._modelviewMatrix3D == null) 
                {
                    this._modelviewMatrix3D = starling.utils.Pool.getMatrix3D(false);
                }
                this._modelviewMatrix3D.copyFrom(arg1);
            }
            else if (this._modelviewMatrix3D) 
            {
                starling.utils.Pool.putMatrix3D(this._modelviewMatrix3D);
                this._modelviewMatrix3D = null;
            }
            return;
        }

        function get onDrawRequired():Function
        {
            return this._onDrawRequired;
        }

        public function set projectionMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            this.setProjectionMatrixChanged();
            this._projectionMatrix3D.copyFrom(arg1);
            return;
        }

        public function get mvpMatrix3D():flash.geom.Matrix3D
        {
            this._mvpMatrix3D.copyFrom(this._projectionMatrix3D);
            if (this._modelviewMatrix3D) 
            {
                this._mvpMatrix3D.prepend(this._modelviewMatrix3D);
            }
            this._mvpMatrix3D.prepend(starling.utils.MatrixUtil.convertTo3D(this._modelviewMatrix, sMatrix3D));
            return this._mvpMatrix3D;
        }

        public function setRenderTarget(arg1:starling.textures.Texture, arg2:Boolean=true, arg3:int=0):void
        {
            var loc1:*=this._renderTarget ? this._renderTarget.base : null;
            var loc2:*=arg1 ? arg1.base : null;
            var loc3:*=starling.utils.MathUtil.min(arg3, 16) | uint(arg2) << 4;
            var loc4:*=!(loc3 == (this._miscOptions & 255));
            if (!(loc1 == loc2) || loc4) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                this._renderTarget = arg1;
                this._miscOptions = this._miscOptions & 4294967040 | loc3;
            }
            return;
        }

        public function get alpha():Number
        {
            return this._alpha;
        }

        public function set alpha(arg1:Number):void
        {
            this._alpha = arg1;
            return;
        }

        public function get blendMode():String
        {
            return this._blendMode;
        }

        public function set blendMode(arg1:String):void
        {
            if (!(arg1 == starling.display.BlendMode.AUTO) && !(this._blendMode == arg1)) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                this._blendMode = arg1;
            }
            return;
        }

        public function get renderTarget():starling.textures.Texture
        {
            return this._renderTarget;
        }

        public function set renderTarget(arg1:starling.textures.Texture):void
        {
            this.setRenderTarget(arg1);
            return;
        }

        internal static const CULLING_VALUES:__AS3__.vec.Vector.<String>=new Vector.<String>(4);

        var _alpha:Number;

        var _blendMode:String;

        var _modelviewMatrix:flash.geom.Matrix;

        internal var _miscOptions:uint;

        internal var _renderTarget:starling.textures.Texture;

        internal var _onDrawRequired:Function;

        internal var _modelviewMatrix3D:flash.geom.Matrix3D;

        internal var _projectionMatrix3D:flash.geom.Matrix3D;

        internal var _projectionMatrix3DRev:uint;

        internal var _mvpMatrix3D:flash.geom.Matrix3D;

        internal static var sMatrix3D:flash.geom.Matrix3D;

        internal static var sProjectionMatrix3DRev:uint=0;

        internal var _clipRect:flash.geom.Rectangle;
    }
}


//  class VertexData
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


//  class VertexDataAttribute
package starling.rendering 
{
    internal class VertexDataAttribute extends Object
    {
        public function VertexDataAttribute(arg1:String, arg2:String, arg3:int)
        {
            super();
            if (!(arg2 in FORMAT_SIZES)) 
            {
                throw new ArgumentError("Invalid attribute format: " + arg2 + ". " + "Use one of the following: \'float1\'-\'float4\', \'bytes4\'");
            }
            this.name = arg1;
            this.format = arg2;
            this.offset = arg3;
            this.size = FORMAT_SIZES[arg2];
            this.isColor = !(arg1.indexOf("color") == -1) || !(arg1.indexOf("Color") == -1);
            return;
        }

        internal static const FORMAT_SIZES:Object={"bytes4":4, "float1":4, "float2":8, "float3":12, "float4":16};

        public var name:String;

        public var format:String;

        public var isColor:Boolean;

        public var offset:int;

        public var size:int;
    }
}


//  class VertexDataFormat
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.utils.*;
    
    public class VertexDataFormat extends Object
    {
        public function VertexDataFormat()
        {
            super();
            this._attributes = new Vector.<VertexDataAttribute>();
            return;
        }

        public function extend(arg1:String):starling.rendering.VertexDataFormat
        {
            return fromString(this._format + ", " + arg1);
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

        public function getFormat(arg1:String):String
        {
            return this.getAttribute(arg1).format;
        }

        public function getName(arg1:int):String
        {
            return this._attributes[arg1].name;
        }

        public function hasAttribute(arg1:String):Boolean
        {
            var loc1:*=this._attributes.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this._attributes[loc2].name == arg1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        public function setVertexBufferAt(arg1:int, arg2:flash.display3D.VertexBuffer3D, arg3:String):void
        {
            var loc1:*=this.getAttribute(arg3);
            starling.core.Starling.context.setVertexBufferAt(arg1, arg2, loc1.offset / 4, loc1.format);
            return;
        }

        internal function parseFormat(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            if (!(arg1 == null) && !(arg1 == "")) 
            {
                this._attributes.length = 0;
                this._format = "";
                loc1 = arg1.split(",");
                loc2 = loc1.length;
                loc3 = 0;
                loc4 = 0;
                while (loc4 < loc2) 
                {
                    loc5 = loc1[loc4];
                    loc6 = loc5.split(":");
                    if (loc6.length != 2) 
                    {
                        throw new ArgumentError("Missing colon: " + loc5);
                    }
                    loc7 = starling.utils.StringUtil.trim(loc6[0]);
                    loc8 = starling.utils.StringUtil.trim(loc6[1]);
                    if (loc7.length == 0 || loc8.length == 0) 
                    {
                        throw new ArgumentError("Invalid format string: " + loc5);
                    }
                    loc9 = new VertexDataAttribute(loc7, loc8, loc3);
                    loc3 = loc3 + loc9.size;
                    this._format = this._format + ((loc4 != 0 ? ", " : "") + loc9.name + ":" + loc9.format);
                    this._attributes[this._attributes.length] = loc9;
                    ++loc4;
                }
                this._vertexSize = loc3;
            }
            else 
            {
                this._format = "";
            }
            return;
        }

        public function toString():String
        {
            return this._format;
        }

        function getAttribute(arg1:String):VertexDataAttribute
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=this._attributes.length;
            loc1 = 0;
            while (loc1 < loc3) 
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

        function get attributes():__AS3__.vec.Vector.<VertexDataAttribute>
        {
            return this._attributes;
        }

        public function get formatString():String
        {
            return this._format;
        }

        public function get vertexSize():int
        {
            return this._vertexSize;
        }

        public function get vertexSizeIn32Bits():int
        {
            return this._vertexSize / 4;
        }

        public function get numAttributes():int
        {
            return this._attributes.length;
        }

        public static function fromString(arg1:String):starling.rendering.VertexDataFormat
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 in sFormats) 
            {
                return sFormats[arg1];
            }
            loc1 = new VertexDataFormat();
            loc1.parseFormat(arg1);
            loc2 = loc1._format;
            if (loc2 in sFormats) 
            {
                loc1 = sFormats[loc2];
            }
            sFormats[arg1] = loc1;
            sFormats[loc2] = loc1;
            return loc1;
        }

        
        {
            sFormats = new flash.utils.Dictionary();
        }

        internal var _format:String;

        internal var _vertexSize:int;

        internal var _attributes:__AS3__.vec.Vector.<VertexDataAttribute>;

        internal static var sFormats:flash.utils.Dictionary;
    }
}


