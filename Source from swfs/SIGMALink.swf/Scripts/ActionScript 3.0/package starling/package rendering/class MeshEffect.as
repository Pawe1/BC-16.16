//class MeshEffect
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


