//class FilterEffect
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


