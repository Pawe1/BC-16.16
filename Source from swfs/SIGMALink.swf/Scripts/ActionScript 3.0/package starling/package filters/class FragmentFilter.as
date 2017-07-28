//class FragmentFilter
package starling.filters 
{
    import flash.display3D.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class FragmentFilter extends starling.events.EventDispatcher
    {
        public function FragmentFilter()
        {
            super();
            this._resolution = 1;
            this._textureFormat = flash.display3D.Context3DTextureFormat.BGRA;
            this._textureSmoothing = starling.textures.TextureSmoothing.BILINEAR;
            starling.core.Starling.current.stage3D.addEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 0, true);
            return;
        }

        protected function onTargetAssigned(arg1:starling.display.DisplayObject):void
        {
            return;
        }

        public function get padding():starling.utils.Padding
        {
            if (this._padding == null) 
            {
                this._padding = new starling.utils.Padding();
                this._padding.addEventListener(starling.events.Event.CHANGE, this.setRequiresRedraw);
            }
            return this._padding;
        }

        public function set padding(arg1:starling.utils.Padding):void
        {
            this.padding.copyFrom(arg1);
            return;
        }

        public function get isCached():Boolean
        {
            return this._cached;
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

        public function get resolution():Number
        {
            return this._resolution;
        }

        public function set resolution(arg1:Number):void
        {
            if (arg1 != this._resolution) 
            {
                if (arg1 > 0) 
                {
                    this._resolution = arg1;
                }
                else 
                {
                    throw new ArgumentError("resolution must be > 0");
                }
                this.setRequiresRedraw();
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
                if (this._quad) 
                {
                    this._quad.textureSmoothing = arg1;
                }
                this.setRequiresRedraw();
            }
            return;
        }

        public function set textureFormat(arg1:String):void
        {
            if (arg1 != this._textureFormat) 
            {
                this._textureFormat = arg1;
                if (this._helper) 
                {
                    this._helper.textureFormat = arg1;
                }
                this.setRequiresRedraw();
            }
            return;
        }

        public function get alwaysDrawToBackBuffer():Boolean
        {
            return this._alwaysDrawToBackBuffer;
        }

        public function set alwaysDrawToBackBuffer(arg1:Boolean):void
        {
            this._alwaysDrawToBackBuffer = arg1;
            return;
        }

        starling_internal function setTarget(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
            if (arg1 != this._target) 
            {
                loc1 = this._target;
                this._target = arg1;
                if (arg1 == null) 
                {
                    if (this._helper) 
                    {
                        this._helper.purge();
                    }
                    if (this._effect) 
                    {
                        this._effect.purgeBuffers();
                    }
                    if (this._quad) 
                    {
                        this._quad.disposeTexture();
                    }
                }
                if (loc1) 
                {
                    loc1.filter = null;
                    loc1.removeEventListener(starling.events.Event.ENTER_FRAME, this.onEnterFrame);
                }
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

        public function dispose():void
        {
            starling.core.Starling.current.stage3D.removeEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            if (this._helper) 
            {
                this._helper.dispose();
            }
            if (this._effect) 
            {
                this._effect.dispose();
            }
            if (this._quad) 
            {
                this._quad.dispose();
            }
            this._effect = null;
            this._quad = null;
            return;
        }

        internal function onContextCreated(arg1:Object):void
        {
            this.setRequiresRedraw();
            return;
        }

        public function render(arg1:starling.rendering.Painter):void
        {
            if (this._target == null) 
            {
                throw new flash.errors.IllegalOperationError("Cannot render filter without target");
            }
            if (this._target.is3D) 
            {
                var loc1:*;
                this._cacheRequested = loc1 = false;
                this._cached = loc1;
            }
            if (!this._cached || this._cacheRequested) 
            {
                this.renderPasses(arg1, this._cacheRequested);
                this._cacheRequested = false;
            }
            else if (this._quad.visible) 
            {
                this._quad.render(arg1);
            }
            return;
        }

        internal function renderPasses(arg1:starling.rendering.Painter, arg2:Boolean):void
        {
            var loc7:*=null;
            var loc10:*=null;
            if (this._helper == null) 
            {
                this._helper = new FilterHelper(this._textureFormat);
            }
            if (this._quad != null) 
            {
                this._helper.putTexture(this._quad.texture);
                this._quad.texture = null;
            }
            else 
            {
                this._quad = new FilterQuad(this._textureSmoothing);
            }
            var loc1:*=starling.utils.Pool.getRectangle();
            var loc2:*=false;
            var loc3:*=this._resolution;
            var loc4:*=this._target.stage || this._target.parent;
            var loc5:*=loc4 is starling.display.Stage;
            var loc6:*=starling.core.Starling.current.stage;
            if (!arg2 && (this._alwaysDrawToBackBuffer || this._target.requiresRedraw)) 
            {
                loc2 = arg1.state.alpha == 1;
                arg1.excludeFromCache(this._target);
            }
            if (this._target != starling.core.Starling.current.root) 
            {
                this._target.getBounds(loc4, loc1);
                if (!arg2 && loc5) 
                {
                    loc7 = loc6.getStageBounds(null, starling.utils.Pool.getRectangle());
                    starling.utils.RectangleUtil.intersect(loc1, loc7, loc1);
                    starling.utils.Pool.putRectangle(loc7);
                }
            }
            else 
            {
                loc6.getStageBounds(this._target, loc1);
            }
            this._quad.visible = !loc1.isEmpty();
            if (!this._quad.visible) 
            {
                starling.utils.Pool.putRectangle(loc1);
                return;
            }
            if (this._padding) 
            {
                starling.utils.RectangleUtil.extend(loc1, this._padding.left, this._padding.right, this._padding.top, this._padding.bottom);
            }
            loc1.setTo(Math.floor(loc1.x), Math.floor(loc1.y), Math.ceil(loc1.width), Math.ceil(loc1.height));
            this._helper.textureScale = starling.core.Starling.contentScaleFactor * this._resolution;
            this._helper.projectionMatrix3D = arg1.state.projectionMatrix3D;
            this._helper.renderTarget = arg1.state.renderTarget;
            this._helper.targetBounds = loc1;
            this._helper.target = this._target;
            this._helper.start(this.numPasses, loc2);
            this._quad.setBounds(loc1);
            this._resolution = 1;
            var loc8:*=arg1.cacheEnabled;
            var loc9:*=this._helper.getTexture();
            arg1.cacheEnabled = false;
            arg1.pushState();
            arg1.state.alpha = 1;
            arg1.state.renderTarget = loc9;
            arg1.state.setProjectionMatrix(loc1.x, loc1.y, loc9.root.width, loc9.root.height, loc6.stageWidth, loc6.stageHeight, loc6.cameraPosition);
            this._target.render(arg1);
            arg1.finishMeshBatch();
            arg1.state.setModelviewMatricesToIdentity();
            arg1.state.clipRect = null;
            loc10 = this.process(arg1, this._helper, loc9);
            arg1.popState();
            arg1.cacheEnabled = loc8;
            if (loc10) 
            {
                arg1.pushState();
                if (this._target.is3D) 
                {
                    arg1.state.setModelviewMatricesToIdentity();
                }
                else 
                {
                    this._quad.moveVertices(loc4, this._target);
                }
                this._quad.texture = loc10;
                this._quad.render(arg1);
                arg1.finishMeshBatch();
                arg1.popState();
            }
            this._helper.target = null;
            this._helper.putTexture(loc9);
            this._resolution = loc3;
            starling.utils.Pool.putRectangle(loc1);
            return;
        }

        public function process(arg1:starling.rendering.Painter, arg2:starling.filters.IFilterHelper, arg3:starling.textures.Texture=null, arg4:starling.textures.Texture=null, arg5:starling.textures.Texture=null, arg6:starling.textures.Texture=null):starling.textures.Texture
        {
            var loc3:*=null;
            var loc5:*=null;
            var loc1:*=this.effect;
            var loc2:*=arg2.getTexture(this._resolution);
            var loc4:*=null;
            if (loc2) 
            {
                loc5 = loc2;
                loc3 = starling.utils.MatrixUtil.createPerspectiveProjectionMatrix(0, 0, loc2.root.width / this._resolution, loc2.root.height / this._resolution, 0, 0, null, sMatrix3D);
            }
            else 
            {
                loc4 = arg2.targetBounds;
                loc5 = (arg2 as FilterHelper).renderTarget;
                loc3 = (arg2 as FilterHelper).projectionMatrix3D;
                loc1.textureSmoothing = this._textureSmoothing;
            }
            arg1.state.renderTarget = loc5;
            arg1.prepareToDraw();
            arg1.drawCount = arg1.drawCount + 1;
            arg3.setupVertexPositions(this.vertexData, 0, "position", loc4);
            arg3.setupTextureCoordinates(this.vertexData);
            loc1.texture = arg3;
            loc1.mvpMatrix3D = loc3;
            loc1.uploadVertexData(this.vertexData);
            loc1.uploadIndexData(this.indexData);
            loc1.render(0, this.indexData.numTriangles);
            return loc2;
        }

        protected function createEffect():starling.rendering.FilterEffect
        {
            return new starling.rendering.FilterEffect();
        }

        public function cache():void
        {
            var loc1:*;
            this._cacheRequested = loc1 = true;
            this._cached = loc1;
            this.setRequiresRedraw();
            return;
        }

        public function clearCache():void
        {
            var loc1:*;
            this._cacheRequested = loc1 = false;
            this._cached = loc1;
            this.setRequiresRedraw();
            return;
        }

        public function get textureFormat():String
        {
            return this._textureFormat;
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

        protected function get effect():starling.rendering.FilterEffect
        {
            if (this._effect == null) 
            {
                this._effect = this.createEffect();
            }
            return this._effect;
        }

        protected function get vertexData():starling.rendering.VertexData
        {
            if (this._vertexData == null) 
            {
                this._vertexData = new starling.rendering.VertexData(this.effect.vertexFormat, 4);
            }
            return this._vertexData;
        }

        protected function get indexData():starling.rendering.IndexData
        {
            if (this._indexData == null) 
            {
                this._indexData = new starling.rendering.IndexData(6);
                this._indexData.addQuad(0, 1, 2, 3);
            }
            return this._indexData;
        }

        protected function setRequiresRedraw():void
        {
            dispatchEventWith(starling.events.Event.CHANGE);
            if (this._target) 
            {
                this._target.setRequiresRedraw();
            }
            if (this._cached) 
            {
                this._cacheRequested = true;
            }
            return;
        }

        public function get numPasses():int
        {
            return 1;
        }

        internal var _quad:FilterQuad;

        internal var _target:starling.display.DisplayObject;

        internal var _effect:starling.rendering.FilterEffect;

        internal var _vertexData:starling.rendering.VertexData;

        internal var _padding:starling.utils.Padding;

        internal var _helper:FilterHelper;

        internal var _resolution:Number;

        internal var _textureFormat:String;

        internal var _textureSmoothing:String;

        internal var _alwaysDrawToBackBuffer:Boolean;

        internal var _cacheRequested:Boolean;

        internal var _cached:Boolean;

        internal var _indexData:starling.rendering.IndexData;

        internal static var sMatrix3D:flash.geom.Matrix3D;
    }
}

import flash.geom.*;
import starling.display.*;
import starling.rendering.*;
import starling.textures.*;


class FilterQuad extends starling.display.Mesh
{
    public function FilterQuad(arg1:String)
    {
        var loc1:*=new starling.rendering.VertexData(null, 4);
        loc1.numVertices = 4;
        var loc2:*=new starling.rendering.IndexData(6);
        loc2.addQuad(0, 1, 2, 3);
        super(loc1, loc2);
        textureSmoothing = arg1;
        pixelSnapping = false;
        return;
    }

    public override function dispose():void
    {
        this.disposeTexture();
        super.dispose();
        return;
    }

    public function disposeTexture():void
    {
        if (texture) 
        {
            texture.dispose();
            this.texture = null;
        }
        return;
    }

    public function moveVertices(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
    {
        if (arg2.is3D) 
        {
            throw new Error("cannot move vertices into 3D space");
        }
        if (arg1 != arg2) 
        {
            arg2.getTransformationMatrix(arg1, sMatrix).invert();
            vertexData.transformPoints("position", sMatrix);
        }
        return;
    }

    public function setBounds(arg1:flash.geom.Rectangle):void
    {
        var loc1:*=this.vertexData;
        var loc2:*="position";
        loc1.setPoint(0, loc2, arg1.x, arg1.y);
        loc1.setPoint(1, loc2, arg1.right, arg1.y);
        loc1.setPoint(2, loc2, arg1.x, arg1.bottom);
        loc1.setPoint(3, loc2, arg1.right, arg1.bottom);
        return;
    }

    public override function set texture(arg1:starling.textures.Texture):void
    {
        super.texture = arg1;
        if (arg1) 
        {
            arg1.setupTextureCoordinates(vertexData);
        }
        return;
    }

    
    {
        sMatrix = new flash.geom.Matrix();
    }

    internal static var sMatrix:flash.geom.Matrix;
}

