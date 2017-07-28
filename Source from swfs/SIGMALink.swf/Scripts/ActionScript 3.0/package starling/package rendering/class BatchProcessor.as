//class BatchProcessor
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

