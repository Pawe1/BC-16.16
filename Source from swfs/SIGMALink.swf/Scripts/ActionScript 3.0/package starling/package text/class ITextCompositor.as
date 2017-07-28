//class ITextCompositor
package starling.text 
{
    import starling.display.*;
    
    public interface ITextCompositor
    {
        function fillMeshBatch(arg1:starling.display.MeshBatch, arg2:Number, arg3:Number, arg4:String, arg5:starling.text.TextFormat, arg6:starling.text.TextOptions=null):void;

        function clearMeshBatch(arg1:starling.display.MeshBatch):void;

        function dispose():void;
    }
}


