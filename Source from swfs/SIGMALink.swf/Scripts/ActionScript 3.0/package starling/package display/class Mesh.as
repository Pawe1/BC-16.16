//class Mesh
package starling.display 
{
    import flash.geom.*;
    import starling.core.*;
    import starling.geom.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Mesh extends starling.display.DisplayObject
    {
        public function Mesh(arg1:starling.rendering.VertexData, arg2:starling.rendering.IndexData, arg3:starling.styles.MeshStyle=null)
        {
            super();
            if (arg1 == null) 
            {
                throw new ArgumentError("VertexData must not be null");
            }
            if (arg2 == null) 
            {
                throw new ArgumentError("IndexData must not be null");
            }
            this._vertexData = arg1;
            this._indexData = arg2;
            this.setStyle(arg3, false);
            return;
        }

        public static function get defaultStyleFactory():Function
        {
            return sDefaultStyleFactory;
        }

        public static function set defaultStyleFactory(arg1:Function):void
        {
            sDefaultStyleFactory = arg1;
            return;
        }

        public static function fromPolygon(arg1:starling.geom.Polygon, arg2:starling.styles.MeshStyle=null):starling.display.Mesh
        {
            var loc1:*=new starling.rendering.VertexData(null, arg1.numVertices);
            var loc2:*=new starling.rendering.IndexData(arg1.numTriangles);
            arg1.copyToVertexData(loc1);
            arg1.triangulate(loc2);
            return new Mesh(loc1, loc2, arg2);
        }

        
        {
            sDefaultStyle = starling.styles.MeshStyle;
            sDefaultStyleFactory = null;
        }

        public override function dispose():void
        {
            this._vertexData.clear();
            this._indexData.clear();
            super.dispose();
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            return starling.utils.MeshUtil.containsPoint(this._vertexData, this._indexData, arg1) ? this : null;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            return starling.utils.MeshUtil.calculateBounds(this._vertexData, this, arg1, arg2);
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (this._pixelSnapping) 
            {
                starling.utils.MatrixUtil.snapToPixels(arg1.state.modelviewMatrix, arg1.pixelSize);
            }
            arg1.batchMesh(this);
            return;
        }

        public function setStyle(arg1:starling.styles.MeshStyle=null, arg2:Boolean=true):void
        {
            if (arg1 != null) 
            {
                if (arg1 == this._style) 
                {
                    return;
                }
                if (arg1.target) 
                {
                    arg1.target.setStyle();
                }
            }
            else 
            {
                arg1 = this.createDefaultMeshStyle();
            }
            if (this._style) 
            {
                if (arg2) 
                {
                    arg1.copyFrom(this._style);
                }
                this._style.starling_internal::setTarget(null);
            }
            this._style = arg1;
            this._style.starling_internal::setTarget(this, this._vertexData, this._indexData);
            return;
        }

        internal function createDefaultMeshStyle():starling.styles.MeshStyle
        {
            var loc1:*=null;
            if (sDefaultStyleFactory != null) 
            {
                if (sDefaultStyleFactory.length != 0) 
                {
                    loc1 = sDefaultStyleFactory(this);
                }
                else 
                {
                    loc1 = sDefaultStyleFactory();
                }
            }
            if (loc1 == null) 
            {
                loc1 = new sDefaultStyle() as starling.styles.MeshStyle;
            }
            return loc1;
        }

        public function setVertexDataChanged():void
        {
            setRequiresRedraw();
            return;
        }

        public function setIndexDataChanged():void
        {
            setRequiresRedraw();
            return;
        }

        public function getVertexPosition(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            return this._style.getVertexPosition(arg1, arg2);
        }

        public function setVertexPosition(arg1:int, arg2:Number, arg3:Number):void
        {
            this._style.setVertexPosition(arg1, arg2, arg3);
            return;
        }

        public function getVertexAlpha(arg1:int):Number
        {
            return this._style.getVertexAlpha(arg1);
        }

        public function setVertexAlpha(arg1:int, arg2:Number):void
        {
            this._style.setVertexAlpha(arg1, arg2);
            return;
        }

        public function getVertexColor(arg1:int):uint
        {
            return this._style.getVertexColor(arg1);
        }

        public function setVertexColor(arg1:int, arg2:uint):void
        {
            this._style.setVertexColor(arg1, arg2);
            return;
        }

        public function getTexCoords(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            return this._style.getTexCoords(arg1, arg2);
        }

        public function setTexCoords(arg1:int, arg2:Number, arg3:Number):void
        {
            this._style.setTexCoords(arg1, arg2, arg3);
            return;
        }

        protected function get vertexData():starling.rendering.VertexData
        {
            return this._vertexData;
        }

        protected function get indexData():starling.rendering.IndexData
        {
            return this._indexData;
        }

        public function get style():starling.styles.MeshStyle
        {
            return this._style;
        }

        public function set style(arg1:starling.styles.MeshStyle):void
        {
            this.setStyle(arg1);
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._style.texture;
        }

        public function set texture(arg1:starling.textures.Texture):void
        {
            this._style.texture = arg1;
            return;
        }

        public function get color():uint
        {
            return this._style.color;
        }

        public function set color(arg1:uint):void
        {
            this._style.color = arg1;
            return;
        }

        public function get textureSmoothing():String
        {
            return this._style.textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            this._style.textureSmoothing = arg1;
            return;
        }

        public function get textureRepeat():Boolean
        {
            return this._style.textureRepeat;
        }

        public function set textureRepeat(arg1:Boolean):void
        {
            this._style.textureRepeat = arg1;
            return;
        }

        public function get pixelSnapping():Boolean
        {
            return this._pixelSnapping;
        }

        public function set pixelSnapping(arg1:Boolean):void
        {
            this._pixelSnapping = arg1;
            return;
        }

        public function get numVertices():int
        {
            return this._vertexData.numVertices;
        }

        public function get numIndices():int
        {
            return this._indexData.numIndices;
        }

        public function get numTriangles():int
        {
            return this._indexData.numTriangles;
        }

        public function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return this._style.vertexFormat;
        }

        public static function get defaultStyle():Class
        {
            return sDefaultStyle;
        }

        public static function set defaultStyle(arg1:Class):void
        {
            sDefaultStyle = arg1;
            return;
        }

        var _style:starling.styles.MeshStyle;

        var _vertexData:starling.rendering.VertexData;

        var _indexData:starling.rendering.IndexData;

        var _pixelSnapping:Boolean;

        internal static var sDefaultStyle:Class;

        internal static var sDefaultStyleFactory:Function=null;
    }
}


