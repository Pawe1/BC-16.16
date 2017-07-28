//class MeshSubset
package starling.utils 
{
    public class MeshSubset extends Object
    {
        public function MeshSubset(arg1:int=0, arg2:int=-1, arg3:int=0, arg4:int=-1)
        {
            super();
            this.setTo(arg1, arg2, arg3, arg4);
            return;
        }

        public function setTo(arg1:int=0, arg2:int=-1, arg3:int=0, arg4:int=-1):void
        {
            this.vertexID = arg1;
            this.numVertices = arg2;
            this.indexID = arg3;
            this.numIndices = arg4;
            return;
        }

        public var vertexID:int;

        public var numVertices:int;

        public var indexID:int;

        public var numIndices:int;
    }
}


