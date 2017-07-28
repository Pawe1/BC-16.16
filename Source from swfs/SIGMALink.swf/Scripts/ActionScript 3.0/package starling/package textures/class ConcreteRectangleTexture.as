//class ConcreteRectangleTexture
package starling.textures 
{
    import flash.display.*;
    import flash.display3D.textures.*;
    import starling.core.*;
    
    internal class ConcreteRectangleTexture extends starling.textures.ConcreteTexture
    {
        public function ConcreteRectangleTexture(arg1:flash.display3D.textures.RectangleTexture, arg2:String, arg3:int, arg4:int, arg5:Boolean, arg6:Boolean=false, arg7:Number=1)
        {
            super(arg1, arg2, arg3, arg4, false, arg5, arg6, arg7);
            return;
        }

        public override function uploadBitmapData(arg1:flash.display.BitmapData):void
        {
            this.rectangleBase.uploadFromBitmapData(arg1);
            setDataUploaded();
            return;
        }

        protected override function createBase():flash.display3D.textures.TextureBase
        {
            return starling.core.Starling.context.createRectangleTexture(nativeWidth, nativeHeight, format, optimizedForRenderTexture);
        }

        internal function get rectangleBase():flash.display3D.textures.RectangleTexture
        {
            return base as flash.display3D.textures.RectangleTexture;
        }
    }
}


