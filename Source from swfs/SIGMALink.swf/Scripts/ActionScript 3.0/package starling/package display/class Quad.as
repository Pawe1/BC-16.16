//class Quad
package starling.display 
{
    import flash.geom.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class Quad extends starling.display.Mesh
    {
        public function Quad(arg1:Number, arg2:Number, arg3:uint=16777215)
        {
            this._bounds = new flash.geom.Rectangle(0, 0, arg1, arg2);
            var loc1:*=new starling.rendering.VertexData(starling.styles.MeshStyle.VERTEX_FORMAT, 4);
            var loc2:*=new starling.rendering.IndexData(6);
            super(loc1, loc2);
            if (arg1 == 0 || arg2 == 0) 
            {
                throw new ArgumentError("Invalid size: width and height must not be zero");
            }
            this.setupVertices();
            this.color = arg3;
            return;
        }

        protected function setupVertices():void
        {
            var loc1:*="position";
            var loc2:*="texCoords";
            var loc3:*=style.texture;
            var loc4:*=this.vertexData;
            var loc5:*=this.indexData;
            loc5.numIndices = 0;
            loc5.addQuad(0, 1, 2, 3);
            if (loc4.numVertices != 4) 
            {
                loc4.numVertices = 4;
                loc4.trim();
            }
            if (loc3) 
            {
                loc3.setupVertexPositions(loc4, 0, "position", this._bounds);
                loc3.setupTextureCoordinates(loc4, 0, loc2);
            }
            else 
            {
                loc4.setPoint(0, loc1, this._bounds.left, this._bounds.top);
                loc4.setPoint(1, loc1, this._bounds.right, this._bounds.top);
                loc4.setPoint(2, loc1, this._bounds.left, this._bounds.bottom);
                loc4.setPoint(3, loc1, this._bounds.right, this._bounds.bottom);
                loc4.setPoint(0, loc2, 0, 0);
                loc4.setPoint(1, loc2, 1, 0);
                loc4.setPoint(2, loc2, 0, 1);
                loc4.setPoint(3, loc2, 1, 1);
            }
            setRequiresRedraw();
            return;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            if (arg1 != this) 
            {
                if (arg1 == parent && !isRotated) 
                {
                    loc1 = this.scaleX;
                    loc2 = this.scaleY;
                    arg2.setTo(x - pivotX * loc1, y - pivotY * loc2, this._bounds.width * loc1, this._bounds.height * loc2);
                    if (loc1 < 0) 
                    {
                        arg2.width = arg2.width * -1;
                        arg2.x = arg2.x - arg2.width;
                    }
                    if (loc2 < 0) 
                    {
                        arg2.height = arg2.height * -1;
                        arg2.y = arg2.y - arg2.height;
                    }
                }
                else if (is3D && stage) 
                {
                    stage.getCameraPosition(arg1, sPoint3D);
                    getTransformationMatrix3D(arg1, sMatrix3D);
                    starling.utils.RectangleUtil.getBoundsProjected(this._bounds, sMatrix3D, sPoint3D, arg2);
                }
                else 
                {
                    getTransformationMatrix(arg1, sMatrix);
                    starling.utils.RectangleUtil.getBounds(this._bounds, sMatrix, arg2);
                }
            }
            else 
            {
                arg2.copyFrom(this._bounds);
            }
            return arg2;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            if (this._bounds.containsPoint(arg1)) 
            {
                return this;
            }
            return null;
        }

        public function readjustSize(arg1:Number=-1, arg2:Number=-1):void
        {
            if (arg1 <= 0) 
            {
                arg1 = texture ? texture.frameWidth : this._bounds.width;
            }
            if (arg2 <= 0) 
            {
                arg2 = texture ? texture.frameHeight : this._bounds.height;
            }
            if (!(arg1 == this._bounds.width) || !(arg2 == this._bounds.height)) 
            {
                this._bounds.setTo(0, 0, arg1, arg2);
                this.setupVertices();
            }
            return;
        }

        public override function set texture(arg1:starling.textures.Texture):void
        {
            if (arg1 != texture) 
            {
                super.texture = arg1;
                this.setupVertices();
            }
            return;
        }

        public static function fromTexture(arg1:starling.textures.Texture):starling.display.Quad
        {
            var loc1:*=new Quad(100, 100);
            loc1.texture = arg1;
            loc1.readjustSize();
            return loc1;
        }

        
        {
            sPoint3D = new flash.geom.Vector3D();
            sMatrix = new flash.geom.Matrix();
            sMatrix3D = new flash.geom.Matrix3D();
        }

        internal var _bounds:flash.geom.Rectangle;

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sMatrix3D:flash.geom.Matrix3D;
    }
}


