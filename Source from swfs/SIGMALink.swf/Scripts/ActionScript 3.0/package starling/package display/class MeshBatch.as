//class MeshBatch
package starling.display 
{
    import flash.geom.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.utils.*;
    
    public class MeshBatch extends starling.display.Mesh
    {
        public function MeshBatch()
        {
            var loc1:*=new starling.rendering.VertexData();
            var loc2:*=new starling.rendering.IndexData();
            super(loc1, loc2);
            return;
        }

        public override function dispose():void
        {
            if (this._effect) 
            {
                this._effect.dispose();
            }
            super.dispose();
            return;
        }

        public override function setVertexDataChanged():void
        {
            this._vertexSyncRequired = true;
            super.setVertexDataChanged();
            return;
        }

        public override function setIndexDataChanged():void
        {
            this._indexSyncRequired = true;
            super.setIndexDataChanged();
            return;
        }

        internal function setVertexAndIndexDataChanged():void
        {
            var loc1:*;
            this._indexSyncRequired = loc1 = true;
            this._vertexSyncRequired = loc1;
            return;
        }

        internal function syncVertexBuffer():void
        {
            this._effect.uploadVertexData(_vertexData);
            this._vertexSyncRequired = false;
            return;
        }

        internal function syncIndexBuffer():void
        {
            this._effect.uploadIndexData(_indexData);
            this._indexSyncRequired = false;
            return;
        }

        public function clear():void
        {
            if (_parent) 
            {
                setRequiresRedraw();
            }
            _vertexData.numVertices = 0;
            _indexData.numIndices = 0;
            this._vertexSyncRequired = true;
            this._indexSyncRequired = true;
            return;
        }

        public function addMesh(arg1:starling.display.Mesh, arg2:flash.geom.Matrix=null, arg3:Number=1, arg4:starling.utils.MeshSubset=null, arg5:Boolean=false):void
        {
            if (arg5) 
            {
                arg2 = null;
            }
            else if (arg2 == null) 
            {
                arg2 = arg1.transformationMatrix;
            }
            if (arg4 == null) 
            {
                arg4 = sFullMeshSubset;
            }
            var loc1:*=_vertexData.numVertices;
            var loc2:*=_indexData.numIndices;
            var loc3:*=arg1._style;
            if (loc1 == 0) 
            {
                this.setupFor(arg1);
            }
            loc3.batchVertexData(_style, loc1, arg2, arg4.vertexID, arg4.numVertices);
            loc3.batchIndexData(_style, loc2, loc1 - arg4.vertexID, arg4.indexID, arg4.numIndices);
            if (arg3 != 1) 
            {
                _vertexData.scaleAlphas("color", arg3, loc1, arg4.numVertices);
            }
            if (_parent) 
            {
                setRequiresRedraw();
            }
            var loc4:*;
            this._vertexSyncRequired = loc4 = true;
            this._indexSyncRequired = loc4;
            return;
        }

        public function addMeshAt(arg1:starling.display.Mesh, arg2:int, arg3:int):void
        {
            var loc1:*=arg1.numIndices;
            var loc2:*=arg1.numVertices;
            var loc3:*=arg1.transformationMatrix;
            var loc4:*=arg1._style;
            if (_vertexData.numVertices == 0) 
            {
                this.setupFor(arg1);
            }
            loc4.batchVertexData(_style, arg3, loc3, 0, loc2);
            loc4.batchIndexData(_style, arg2, arg3, 0, loc1);
            if (alpha != 1) 
            {
                _vertexData.scaleAlphas("color", alpha, arg3, loc2);
            }
            if (_parent) 
            {
                setRequiresRedraw();
            }
            var loc5:*;
            this._vertexSyncRequired = loc5 = true;
            this._indexSyncRequired = loc5;
            return;
        }

        internal function setupFor(arg1:starling.display.Mesh):void
        {
            var loc1:*=arg1._style;
            var loc2:*=loc1.type;
            if (_style.type != loc2) 
            {
                this.setStyle(new loc2() as starling.styles.MeshStyle, false);
            }
            _style.copyFrom(loc1);
            return;
        }

        public function canAddMesh(arg1:starling.display.Mesh, arg2:int=-1):Boolean
        {
            var loc1:*=_vertexData.numVertices;
            if (loc1 == 0) 
            {
                return true;
            }
            if (arg2 < 0) 
            {
                arg2 = arg1.numVertices;
            }
            if (arg2 == 0) 
            {
                return true;
            }
            if (arg2 + loc1 > MAX_NUM_VERTICES) 
            {
                return false;
            }
            return _style.canBatchWith(arg1._style);
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (_vertexData.numVertices == 0) 
            {
                return;
            }
            if (_pixelSnapping) 
            {
                starling.utils.MatrixUtil.snapToPixels(arg1.state.modelviewMatrix, arg1.pixelSize);
            }
            if (this._batchable) 
            {
                arg1.batchMesh(this);
            }
            else 
            {
                arg1.finishMeshBatch();
                arg1.drawCount = arg1.drawCount + 1;
                arg1.prepareToDraw();
                arg1.excludeFromCache(this);
                if (this._vertexSyncRequired) 
                {
                    this.syncVertexBuffer();
                }
                if (this._indexSyncRequired) 
                {
                    this.syncIndexBuffer();
                }
                _style.updateEffect(this._effect, arg1.state);
                this._effect.render(0, _indexData.numTriangles);
            }
            return;
        }

        public override function setStyle(arg1:starling.styles.MeshStyle=null, arg2:Boolean=true):void
        {
            super.setStyle(arg1, arg2);
            if (this._effect) 
            {
                this._effect.dispose();
            }
            this._effect = style.createEffect();
            this._effect.onRestore = this.setVertexAndIndexDataChanged;
            return;
        }

        public function set numVertices(arg1:int):void
        {
            if (_vertexData.numVertices != arg1) 
            {
                _vertexData.numVertices = arg1;
                this._vertexSyncRequired = true;
                setRequiresRedraw();
            }
            return;
        }

        public function set numIndices(arg1:int):void
        {
            if (_indexData.numIndices != arg1) 
            {
                _indexData.numIndices = arg1;
                this._indexSyncRequired = true;
                setRequiresRedraw();
            }
            return;
        }

        public function get batchable():Boolean
        {
            return this._batchable;
        }

        public function set batchable(arg1:Boolean):void
        {
            if (this._batchable != arg1) 
            {
                this._batchable = arg1;
                setRequiresRedraw();
            }
            return;
        }

        
        {
            sFullMeshSubset = new starling.utils.MeshSubset();
        }

        public static const MAX_NUM_VERTICES:int=65535;

        internal var _effect:starling.rendering.MeshEffect;

        internal var _batchable:Boolean;

        internal var _vertexSyncRequired:Boolean;

        internal var _indexSyncRequired:Boolean;

        internal static var sFullMeshSubset:starling.utils.MeshSubset;
    }
}


