//class MeshStyle
package starling.styles 
{
    import flash.display3D.textures.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.textures.*;
    
    use namespace starling_internal;
    
    public class MeshStyle extends starling.events.EventDispatcher
    {
        public function MeshStyle()
        {
            super();
            this._textureSmoothing = starling.textures.TextureSmoothing.BILINEAR;
            this._type = Object(this).constructor as Class;
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._texture;
        }

        public function set texture(arg1:starling.textures.Texture):void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (arg1 != this._texture) 
            {
                if (arg1) 
                {
                    loc2 = this._vertexData ? this._vertexData.numVertices : 0;
                    loc1 = 0;
                    while (loc1 < loc2) 
                    {
                        this.getTexCoords(loc1, sPoint);
                        arg1.setTexCoords(this._vertexData, loc1, "texCoords", sPoint.x, sPoint.y);
                        ++loc1;
                    }
                    this.setVertexDataChanged();
                }
                else 
                {
                    this.setRequiresRedraw();
                }
                this._texture = arg1;
                this._textureBase = arg1 ? arg1.base : null;
            }
            return;
        }

        public function get textureSmoothing():String
        {
            return this._textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            if (arg1 != this._textureSmoothing) 
            {
                this._textureSmoothing = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get textureRepeat():Boolean
        {
            return this._textureRepeat;
        }

        public function updateEffect(arg1:starling.rendering.MeshEffect, arg2:starling.rendering.RenderState):void
        {
            arg1.texture = this._texture;
            arg1.textureRepeat = this._textureRepeat;
            arg1.textureSmoothing = this._textureSmoothing;
            arg1.mvpMatrix3D = arg2.mvpMatrix3D;
            arg1.alpha = arg2.alpha;
            arg1.tinted = this._vertexData.tinted;
            return;
        }

        public function set textureRepeat(arg1:Boolean):void
        {
            this._textureRepeat = arg1;
            return;
        }

        public function get target():starling.display.Mesh
        {
            return this._target;
        }

        public function copyFrom(arg1:starling.styles.MeshStyle):void
        {
            this._texture = arg1._texture;
            this._textureBase = arg1._textureBase;
            this._textureRepeat = arg1._textureRepeat;
            this._textureSmoothing = arg1._textureSmoothing;
            return;
        }

        public function clone():starling.styles.MeshStyle
        {
            var loc1:*=new this._type();
            loc1.copyFrom(this);
            return loc1;
        }

        public function createEffect():starling.rendering.MeshEffect
        {
            return new starling.rendering.MeshEffect();
        }

        
        {
            sPoint = new flash.geom.Point();
        }

        public function canBatchWith(arg1:starling.styles.MeshStyle):Boolean
        {
            var loc1:*=null;
            if (this._type == arg1._type) 
            {
                loc1 = arg1._texture;
                if (this._texture == null && loc1 == null) 
                {
                    return true;
                }
                if (this._texture && loc1) 
                {
                    return this._textureBase == arg1._textureBase && this._textureSmoothing == arg1._textureSmoothing && this._textureRepeat == arg1._textureRepeat;
                }
                return false;
            }
            return false;
        }

        public function batchVertexData(arg1:starling.styles.MeshStyle, arg2:int=0, arg3:flash.geom.Matrix=null, arg4:int=0, arg5:int=-1):void
        {
            this._vertexData.copyTo(arg1._vertexData, arg2, arg3, arg4, arg5);
            return;
        }

        public function batchIndexData(arg1:starling.styles.MeshStyle, arg2:int=0, arg3:int=0, arg4:int=0, arg5:int=-1):void
        {
            this._indexData.copyTo(arg1._indexData, arg2, arg3, arg4, arg5);
            return;
        }

        protected function setRequiresRedraw():void
        {
            if (this._target) 
            {
                this._target.setRequiresRedraw();
            }
            return;
        }

        protected function setVertexDataChanged():void
        {
            if (this._target) 
            {
                this._target.setVertexDataChanged();
            }
            return;
        }

        protected function setIndexDataChanged():void
        {
            if (this._target) 
            {
                this._target.setIndexDataChanged();
            }
            return;
        }

        protected function onTargetAssigned(arg1:starling.display.Mesh):void
        {
            return;
        }

        public override function addEventListener(arg1:String, arg2:Function):void
        {
            if (arg1 == starling.events.Event.ENTER_FRAME && this._target) 
            {
                this._target.addEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
            }
            super.addEventListener(arg1, arg2);
            return;
        }

        public override function removeEventListener(arg1:String, arg2:Function):void
        {
            if (arg1 == starling.events.Event.ENTER_FRAME && this._target) 
            {
                this._target.removeEventListener(arg1, this.onEnterFrame);
            }
            super.removeEventListener(arg1, arg2);
            return;
        }

        internal function onEnterFrame(arg1:starling.events.Event):void
        {
            dispatchEvent(arg1);
            return;
        }

        starling_internal function setTarget(arg1:starling.display.Mesh=null, arg2:starling.rendering.VertexData=null, arg3:starling.rendering.IndexData=null):void
        {
            if (this._target != arg1) 
            {
                if (this._target) 
                {
                    this._target.removeEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
                }
                if (arg2) 
                {
                    arg2.format = this.vertexFormat;
                }
                this._target = arg1;
                this._vertexData = arg2;
                this._indexData = arg3;
                if (arg1) 
                {
                    if (hasEventListener(starling.events.Event.ENTER_FRAME)) 
                    {
                        arg1.addEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
                    }
                    this.onTargetAssigned(arg1);
                }
            }
            return;
        }

        public function getVertexPosition(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            return this._vertexData.getPoint(arg1, "position", arg2);
        }

        public function setVertexPosition(arg1:int, arg2:Number, arg3:Number):void
        {
            this._vertexData.setPoint(arg1, "position", arg2, arg3);
            this.setVertexDataChanged();
            return;
        }

        public function getVertexAlpha(arg1:int):Number
        {
            return this._vertexData.getAlpha(arg1);
        }

        public function setVertexAlpha(arg1:int, arg2:Number):void
        {
            this._vertexData.setAlpha(arg1, "color", arg2);
            this.setVertexDataChanged();
            return;
        }

        public function getVertexColor(arg1:int):uint
        {
            return this._vertexData.getColor(arg1);
        }

        public function setVertexColor(arg1:int, arg2:uint):void
        {
            this._vertexData.setColor(arg1, "color", arg2);
            this.setVertexDataChanged();
            return;
        }

        public function getTexCoords(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (this._texture) 
            {
                return this._texture.getTexCoords(this._vertexData, arg1, "texCoords", arg2);
            }
            return this._vertexData.getPoint(arg1, "texCoords", arg2);
        }

        public function setTexCoords(arg1:int, arg2:Number, arg3:Number):void
        {
            if (this._texture) 
            {
                this._texture.setTexCoords(this._vertexData, arg1, "texCoords", arg2, arg3);
            }
            else 
            {
                this._vertexData.setPoint(arg1, "texCoords", arg2, arg3);
            }
            this.setVertexDataChanged();
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

        public function get type():Class
        {
            return this._type;
        }

        public function get color():uint
        {
            if (this._vertexData.numVertices > 0) 
            {
                return this._vertexData.getColor(0);
            }
            return 0;
        }

        public function set color(arg1:uint):void
        {
            var loc1:*=0;
            var loc2:*=this._vertexData.numVertices;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                this._vertexData.setColor(loc1, "color", arg1);
                ++loc1;
            }
            if (arg1 == 16777215 && this._vertexData.tinted) 
            {
                this._vertexData.updateTinted();
            }
            this.setVertexDataChanged();
            return;
        }

        public function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        public static const VERTEX_FORMAT:starling.rendering.VertexDataFormat=starling.rendering.MeshEffect.VERTEX_FORMAT;

        internal var _type:Class;

        internal var _target:starling.display.Mesh;

        internal var _texture:starling.textures.Texture;

        internal var _textureBase:flash.display3D.textures.TextureBase;

        internal var _textureSmoothing:String;

        internal var _vertexData:starling.rendering.VertexData;

        internal var _indexData:starling.rendering.IndexData;

        internal var _textureRepeat:Boolean;

        internal static var sPoint:flash.geom.Point;
    }
}


