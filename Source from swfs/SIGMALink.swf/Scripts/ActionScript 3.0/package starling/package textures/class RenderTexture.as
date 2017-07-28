//class RenderTexture
package starling.textures 
{
    import flash.display3D.textures.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.filters.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class RenderTexture extends starling.textures.SubTexture
    {
        public function RenderTexture(arg1:int, arg2:int, arg3:Boolean=true, arg4:Number=-1, arg5:String="bgra")
        {
            this._isPersistent = arg3;
            this._activeTexture = starling.textures.Texture.empty(arg1, arg2, true, false, true, arg4, arg5);
            this._activeTexture.root.onRestore = this._activeTexture.root.clear;
            super(this._activeTexture, new flash.geom.Rectangle(0, 0, arg1, arg2), true, null, false);
            if (arg3 && useDoubleBuffering) 
            {
                this._bufferTexture = starling.textures.Texture.empty(arg1, arg2, true, false, true, arg4, arg5);
                this._bufferTexture.root.onRestore = this._bufferTexture.root.clear;
                this._helperImage = new starling.display.Image(this._bufferTexture);
                this._helperImage.textureSmoothing = starling.textures.TextureSmoothing.NONE;
            }
            return;
        }

        public override function dispose():void
        {
            this._activeTexture.dispose();
            if (this.isDoubleBuffered) 
            {
                this._bufferTexture.dispose();
                this._helperImage.dispose();
            }
            super.dispose();
            return;
        }

        public function draw(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix=null, arg3:Number=1, arg4:int=0):void
        {
            if (arg1 == null) 
            {
                return;
            }
            if (this._drawing) 
            {
                this.render(arg1, arg2, arg3);
            }
            else 
            {
                this.renderBundled(this.render, arg1, arg2, arg3, arg4);
            }
            return;
        }

        public function drawBundled(arg1:Function, arg2:int=0):void
        {
            this.renderBundled(arg1, null, null, 1, arg2);
            return;
        }

        internal function render(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix=null, arg3:Number=1):void
        {
            var loc1:*=starling.core.Starling.painter;
            var loc2:*=loc1.state;
            var loc3:*=loc1.cacheEnabled;
            var loc4:*=arg1.filter;
            var loc5:*=arg1.mask;
            loc1.cacheEnabled = false;
            loc1.pushState();
            loc2.alpha = arg1.alpha * arg3;
            loc2.setModelviewMatricesToIdentity();
            loc2.blendMode = arg1.blendMode != starling.display.BlendMode.AUTO ? arg1.blendMode : starling.display.BlendMode.NORMAL;
            if (arg2) 
            {
                loc2.transformModelviewMatrix(arg2);
            }
            else 
            {
                loc2.transformModelviewMatrix(arg1.transformationMatrix);
            }
            if (loc5) 
            {
                loc1.drawMask(loc5);
            }
            if (loc4) 
            {
                loc4.render(loc1);
            }
            else 
            {
                arg1.render(loc1);
            }
            if (loc5) 
            {
                loc1.eraseMask(loc5);
            }
            loc1.popState();
            loc1.cacheEnabled = loc3;
            return;
        }

        internal function renderBundled(arg1:Function, arg2:starling.display.DisplayObject=null, arg3:flash.geom.Matrix=null, arg4:Number=1, arg5:int=0):void
        {
            var renderBlock:Function;
            var object:starling.display.DisplayObject=null;
            var matrix:flash.geom.Matrix=null;
            var alpha:Number=1;
            var antiAliasing:int=0;
            var painter:starling.rendering.Painter;
            var state:starling.rendering.RenderState;
            var rootTexture:starling.textures.Texture;
            var tmpTexture:starling.textures.Texture;

            var loc1:*;
            tmpTexture = null;
            renderBlock = arg1;
            object = arg2;
            matrix = arg3;
            alpha = arg4;
            antiAliasing = arg5;
            painter = starling.core.Starling.painter;
            state = painter.state;
            if (!starling.core.Starling.current.contextValid) 
            {
                return;
            }
            if (this.isDoubleBuffered) 
            {
                tmpTexture = this._activeTexture;
                this._activeTexture = this._bufferTexture;
                this._bufferTexture = tmpTexture;
                this._helperImage.texture = this._bufferTexture;
            }
            painter.pushState();
            rootTexture = this._activeTexture.root;
            state.setProjectionMatrix(0, 0, rootTexture.width, rootTexture.height, width, height);
            sClipRect.setTo(0, 0, this._activeTexture.width, this._activeTexture.height);
            state.clipRect = sClipRect;
            state.setRenderTarget(this._activeTexture, true, antiAliasing);
            painter.prepareToDraw();
            if (this.isDoubleBuffered || !this.isPersistent || !this._bufferReady) 
            {
                painter.clear();
            }
            if (this.isDoubleBuffered && this._bufferReady) 
            {
                this._helperImage.render(painter);
            }
            else 
            {
                this._bufferReady = true;
            }
            try 
            {
                this._drawing = true;
                starling.utils.execute(renderBlock, object, matrix, alpha);
            }
            finally
            {
                this._drawing = false;
                painter.popState();
            }
            return;
        }

        public function clear(arg1:uint=0, arg2:Number=0):void
        {
            this._activeTexture.root.clear(arg1, arg2);
            this._bufferReady = true;
            return;
        }

        internal function get isDoubleBuffered():Boolean
        {
            return !(this._bufferTexture == null);
        }

        public function get isPersistent():Boolean
        {
            return this._isPersistent;
        }

        public override function get base():flash.display3D.textures.TextureBase
        {
            return this._activeTexture.base;
        }

        public override function get root():starling.textures.ConcreteTexture
        {
            return this._activeTexture.root;
        }

        public static function get useDoubleBuffering():Boolean
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            if (starling.core.Starling.current) 
            {
                loc1 = starling.core.Starling.painter;
                loc2 = loc1.sharedData;
                if (USE_DOUBLE_BUFFERING_DATA_NAME in loc2) 
                {
                    return loc2[USE_DOUBLE_BUFFERING_DATA_NAME];
                }
                loc3 = loc1.profile ? loc1.profile : "baseline";
                loc4 = loc3 == "baseline" || loc3 == "baselineConstrained";
                loc2[USE_DOUBLE_BUFFERING_DATA_NAME] = loc4;
                return loc4;
            }
            return false;
        }

        public static function set useDoubleBuffering(arg1:Boolean):void
        {
            if (starling.core.Starling.current == null) 
            {
                throw new flash.errors.IllegalOperationError("Starling not yet initialized");
            }
            starling.core.Starling.painter.sharedData[USE_DOUBLE_BUFFERING_DATA_NAME] = arg1;
            return;
        }

        
        {
            sClipRect = new flash.geom.Rectangle();
        }

        internal static const USE_DOUBLE_BUFFERING_DATA_NAME:String="starling.textures.RenderTexture.useDoubleBuffering";

        internal var _activeTexture:starling.textures.Texture;

        internal var _bufferTexture:starling.textures.Texture;

        internal var _helperImage:starling.display.Image;

        internal var _drawing:Boolean;

        internal var _bufferReady:Boolean;

        internal var _isPersistent:Boolean;

        internal static var sClipRect:flash.geom.Rectangle;
    }
}


