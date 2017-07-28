//class BatchToken
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


