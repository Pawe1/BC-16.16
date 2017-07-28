//package textures
//  class AtfData
package starling.textures 
{
    import flash.display3D.*;
    import flash.utils.*;
    
    public class AtfData extends Object
    {
        public function AtfData(arg1:flash.utils.ByteArray)
        {
            var loc2:*=false;
            var loc3:*=0;
            super();
            if (!isAtfData(arg1)) 
            {
                throw new ArgumentError("Invalid ATF data");
            }
            if (arg1[6] != 255) 
            {
                arg1.position = 6;
            }
            else 
            {
                arg1.position = 12;
            }
            var loc1:*=arg1.readUnsignedByte();
            var loc4:*=loc1 & 127;
            switch (loc4) 
            {
                case 0:
                case 1:
                {
                    this._format = flash.display3D.Context3DTextureFormat.BGRA;
                    break;
                }
                case 12:
                case 2:
                case 3:
                {
                    this._format = flash.display3D.Context3DTextureFormat.COMPRESSED;
                    break;
                }
                case 13:
                case 4:
                case 5:
                {
                    this._format = "compressedAlpha";
                    break;
                }
                default:
                {
                    throw new Error("Invalid ATF format");
                }
            }
            this._width = Math.pow(2, arg1.readUnsignedByte());
            this._height = Math.pow(2, arg1.readUnsignedByte());
            this._numTextures = arg1.readUnsignedByte();
            this._isCubeMap = !((loc1 & 128) == 0);
            this._data = arg1;
            if (!(arg1[5] == 0) && arg1[6] == 255) 
            {
                loc2 = (arg1[5] & 1) == 1;
                loc3 = arg1[5] >> 1 & 127;
                this._numTextures = loc2 ? 1 : loc3;
            }
            return;
        }

        public function get format():String
        {
            return this._format;
        }

        public function get width():int
        {
            return this._width;
        }

        public function get height():int
        {
            return this._height;
        }

        public function get numTextures():int
        {
            return this._numTextures;
        }

        public function get isCubeMap():Boolean
        {
            return this._isCubeMap;
        }

        public function get data():flash.utils.ByteArray
        {
            return this._data;
        }

        public static function isAtfData(arg1:flash.utils.ByteArray):Boolean
        {
            var loc1:*=null;
            if (arg1.length < 3) 
            {
                return false;
            }
            loc1 = String.fromCharCode(arg1[0], arg1[1], arg1[2]);
            return loc1 == "ATF";
        }

        internal var _format:String;

        internal var _width:int;

        internal var _height:int;

        internal var _numTextures:int;

        internal var _isCubeMap:Boolean;

        internal var _data:flash.utils.ByteArray;
    }
}


//  class ConcretePotTexture
package starling.textures 
{
    import flash.display.*;
    import flash.display3D.textures.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.utils.*;
    
    internal class ConcretePotTexture extends starling.textures.ConcreteTexture
    {
        public function ConcretePotTexture(arg1:flash.display3D.textures.Texture, arg2:String, arg3:int, arg4:int, arg5:Boolean, arg6:Boolean, arg7:Boolean=false, arg8:Number=1)
        {
            super(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            if (arg3 != starling.utils.MathUtil.getNextPowerOfTwo(arg3)) 
            {
                throw new ArgumentError("width must be a power of two");
            }
            if (arg4 != starling.utils.MathUtil.getNextPowerOfTwo(arg4)) 
            {
                throw new ArgumentError("height must be a power of two");
            }
            return;
        }

        public override function dispose():void
        {
            base.removeEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            super.dispose();
            return;
        }

        protected override function createBase():flash.display3D.textures.TextureBase
        {
            return starling.core.Starling.context.createTexture(nativeWidth, nativeHeight, format, optimizedForRenderTexture);
        }

        public override function uploadBitmapData(arg1:flash.display.BitmapData):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            this.potBase.uploadFromBitmapData(arg1);
            var loc1:*=null;
            if (!(arg1.width == nativeWidth) || !(arg1.height == nativeHeight)) 
            {
                loc1 = new flash.display.BitmapData(nativeWidth, nativeHeight, true, 0);
                loc1.copyPixels(arg1, arg1.rect, sOrigin);
                arg1 = loc1;
            }
            if (mipMapping && arg1.width > 1 && arg1.height > 1) 
            {
                loc2 = arg1.width >> 1;
                loc3 = arg1.height >> 1;
                loc4 = 1;
                loc5 = new flash.display.BitmapData(loc2, loc3, true, 0);
                loc6 = sRectangle;
                loc7 = sMatrix;
                loc7.setTo(0.5, 0, 0, 0.5, 0, 0);
                while (loc2 >= 1 || loc3 >= 1) 
                {
                    loc6.setTo(0, 0, loc2, loc3);
                    loc5.fillRect(loc6, 0);
                    loc5.draw(arg1, loc7, null, null, null, true);
                    this.potBase.uploadFromBitmapData(loc5, loc4++);
                    loc7.scale(0.5, 0.5);
                    loc2 = loc2 >> 1;
                    loc3 = loc3 >> 1;
                }
                loc5.dispose();
            }
            if (loc1) 
            {
                loc1.dispose();
            }
            setDataUploaded();
            return;
        }

        public override function get isPotTexture():Boolean
        {
            return true;
        }

        public override function uploadAtfData(arg1:flash.utils.ByteArray, arg2:int=0, arg3:*=null):void
        {
            var loc1:*=arg3 is Function || arg3 === true;
            if (arg3 is Function) 
            {
                this._textureReadyCallback = arg3 as Function;
                base.addEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            }
            this.potBase.uploadCompressedTextureFromByteArray(arg1, arg2, loc1);
            setDataUploaded();
            return;
        }

        internal function onTextureReady(arg1:flash.events.Event):void
        {
            base.removeEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            starling.utils.execute(this._textureReadyCallback, this);
            this._textureReadyCallback = null;
            return;
        }

        internal function get potBase():flash.display3D.textures.Texture
        {
            return base as flash.display3D.textures.Texture;
        }

        
        {
            sMatrix = new flash.geom.Matrix();
            sRectangle = new flash.geom.Rectangle();
            sOrigin = new flash.geom.Point();
        }

        internal var _textureReadyCallback:Function;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sRectangle:flash.geom.Rectangle;

        internal static var sOrigin:flash.geom.Point;
    }
}


//  class ConcreteRectangleTexture
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


//  class ConcreteTexture
package starling.textures 
{
    import flash.display.*;
    import flash.display3D.textures.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class ConcreteTexture extends starling.textures.Texture
    {
        public function ConcreteTexture(arg1:flash.display3D.textures.TextureBase, arg2:String, arg3:int, arg4:int, arg5:Boolean, arg6:Boolean, arg7:Boolean=false, arg8:Number=1)
        {
            super();
            if (flash.system.Capabilities.isDebugger && flash.utils.getQualifiedClassName(this) == "starling.textures::ConcreteTexture") 
            {
                throw new starling.errors.AbstractClassError();
            }
            this._scale = arg8 <= 0 ? 1 : arg8;
            this._base = arg1;
            this._format = arg2;
            this._width = arg3;
            this._height = arg4;
            this._mipMapping = arg5;
            this._premultipliedAlpha = arg6;
            this._optimizedForRenderTexture = arg7;
            this._onRestore = null;
            this._dataUploaded = false;
            return;
        }

        public override function get base():flash.display3D.textures.TextureBase
        {
            return this._base;
        }

        public override function get root():starling.textures.ConcreteTexture
        {
            return this;
        }

        public override function get format():String
        {
            return this._format;
        }

        public override function get width():Number
        {
            return this._width / this._scale;
        }

        public override function get height():Number
        {
            return this._height / this._scale;
        }

        public override function get nativeWidth():Number
        {
            return this._width;
        }

        public override function get nativeHeight():Number
        {
            return this._height;
        }

        public override function get scale():Number
        {
            return this._scale;
        }

        public override function get mipMapping():Boolean
        {
            return this._mipMapping;
        }

        public override function get premultipliedAlpha():Boolean
        {
            return this._premultipliedAlpha;
        }

        public override function dispose():void
        {
            if (this._base) 
            {
                this._base.dispose();
            }
            this.onRestore = null;
            super.dispose();
            return;
        }

        public function uploadBitmap(arg1:flash.display.Bitmap):void
        {
            this.uploadBitmapData(arg1.bitmapData);
            return;
        }

        public function uploadBitmapData(arg1:flash.display.BitmapData):void
        {
            throw new starling.errors.NotSupportedError();
        }

        public function uploadAtfData(arg1:flash.utils.ByteArray, arg2:int=0, arg3:*=null):void
        {
            throw new starling.errors.NotSupportedError();
        }

        public function attachNetStream(arg1:flash.net.NetStream, arg2:Function=null):void
        {
            this.attachVideo("NetStream", arg1, arg2);
            return;
        }

        public function attachCamera(arg1:flash.media.Camera, arg2:Function=null):void
        {
            this.attachVideo("Camera", arg1, arg2);
            return;
        }

        function attachVideo(arg1:String, arg2:Object, arg3:Function=null):void
        {
            throw new starling.errors.NotSupportedError();
        }

        internal function onContextCreated():void
        {
            this._dataUploaded = false;
            this._base = this.createBase();
            starling.utils.execute(this._onRestore, this);
            if (!this._dataUploaded) 
            {
                this.clear();
            }
            return;
        }

        protected function createBase():flash.display3D.textures.TextureBase
        {
            throw new starling.errors.AbstractMethodError();
        }

        starling_internal function recreateBase():void
        {
            this._base = this.createBase();
            return;
        }

        public function clear(arg1:uint=0, arg2:Number=0):void
        {
            if (this._premultipliedAlpha && arg2 < 1) 
            {
                arg1 = starling.utils.Color.rgb(starling.utils.Color.getRed(arg1) * arg2, starling.utils.Color.getGreen(arg1) * arg2, starling.utils.Color.getBlue(arg1) * arg2);
            }
            var loc1:*=starling.core.Starling.painter;
            loc1.pushState();
            loc1.state.renderTarget = this;
            try 
            {
                loc1.clear(arg1, arg2);
            }
            catch (e:Error)
            {
            };
            loc1.popState();
            this.setDataUploaded();
            return;
        }

        protected function setDataUploaded():void
        {
            this._dataUploaded = true;
            return;
        }

        public function get optimizedForRenderTexture():Boolean
        {
            return this._optimizedForRenderTexture;
        }

        public function get isPotTexture():Boolean
        {
            return false;
        }

        public function get onRestore():Function
        {
            return this._onRestore;
        }

        public function set onRestore(arg1:Function):void
        {
            starling.core.Starling.current.removeEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            if (arg1 == null) 
            {
                this._onRestore = null;
            }
            else 
            {
                this._onRestore = arg1;
                starling.core.Starling.current.addEventListener(starling.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            }
            return;
        }

        internal var _base:flash.display3D.textures.TextureBase;

        internal var _format:String;

        internal var _width:int;

        internal var _height:int;

        internal var _mipMapping:Boolean;

        internal var _premultipliedAlpha:Boolean;

        internal var _optimizedForRenderTexture:Boolean;

        internal var _scale:Number;

        internal var _onRestore:Function;

        internal var _dataUploaded:Boolean;
    }
}


//  class ConcreteVideoTexture
package starling.textures 
{
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.events.*;
    import starling.core.*;
    import starling.utils.*;
    
    internal class ConcreteVideoTexture extends starling.textures.ConcreteTexture
    {
        public function ConcreteVideoTexture(arg1:flash.display3D.textures.VideoTexture, arg2:Number=1)
        {
            super(arg1, flash.display3D.Context3DTextureFormat.BGRA, arg1.videoWidth, arg1.videoHeight, false, false, false, arg2);
            return;
        }

        public override function dispose():void
        {
            base.removeEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            super.dispose();
            return;
        }

        protected override function createBase():flash.display3D.textures.TextureBase
        {
            return starling.core.Starling.context.createVideoTexture();
        }

        override function attachVideo(arg1:String, arg2:Object, arg3:Function=null):void
        {
            this._textureReadyCallback = arg3;
            var loc1:*;
            (loc1 = base)["attach" + arg1](arg2);
            base.addEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            setDataUploaded();
            return;
        }

        internal function onTextureReady(arg1:flash.events.Event):void
        {
            base.removeEventListener(flash.events.Event.TEXTURE_READY, this.onTextureReady);
            starling.utils.execute(this._textureReadyCallback, this);
            this._textureReadyCallback = null;
            return;
        }

        public override function get nativeWidth():Number
        {
            return this.videoBase.videoWidth;
        }

        public override function get nativeHeight():Number
        {
            return this.videoBase.videoHeight;
        }

        public override function get width():Number
        {
            return this.nativeWidth / scale;
        }

        public override function get height():Number
        {
            return this.nativeHeight / scale;
        }

        internal function get videoBase():flash.display3D.textures.VideoTexture
        {
            return base as flash.display3D.textures.VideoTexture;
        }

        internal var _textureReadyCallback:Function;
    }
}


//  class RenderTexture
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


//  class SubTexture
package starling.textures 
{
    import flash.display3D.textures.*;
    import flash.geom.*;
    import starling.core.*;
    
    use namespace starling_internal;
    
    public class SubTexture extends starling.textures.Texture
    {
        public function SubTexture(arg1:starling.textures.Texture, arg2:flash.geom.Rectangle=null, arg3:Boolean=false, arg4:flash.geom.Rectangle=null, arg5:Boolean=false, arg6:Number=1)
        {
            super();
            var loc1:*;
            starling_internal::setTo(arg1, arg2, arg3, arg4, arg5, arg6);
            return;
        }

        starling_internal function setTo(arg1:starling.textures.Texture, arg2:flash.geom.Rectangle=null, arg3:Boolean=false, arg4:flash.geom.Rectangle=null, arg5:Boolean=false, arg6:Number=1):void
        {
            if (this._region == null) 
            {
                this._region = new flash.geom.Rectangle();
            }
            if (arg2) 
            {
                this._region.copyFrom(arg2);
            }
            else 
            {
                this._region.setTo(0, 0, arg1.width, arg1.height);
            }
            if (arg4) 
            {
                if (this._frame) 
                {
                    this._frame.copyFrom(arg4);
                }
                else 
                {
                    this._frame = arg4.clone();
                }
            }
            else 
            {
                this._frame = null;
            }
            this._parent = arg1;
            this._ownsParent = arg3;
            this._rotated = arg5;
            this._width = (arg5 ? this._region.height : this._region.width) / arg6;
            this._height = (arg5 ? this._region.width : this._region.height) / arg6;
            this._scale = this._parent.scale * arg6;
            if (this._frame && (this._frame.x > 0 || this._frame.y > 0 || this._frame.right < this._width || this._frame.bottom < this._height)) 
            {
                trace("[Starling] Warning: frames inside the texture\'s region are unsupported.");
            }
            this.updateMatrices();
            return;
        }

        internal function updateMatrices():void
        {
            if (this._transformationMatrix) 
            {
                this._transformationMatrix.identity();
            }
            else 
            {
                this._transformationMatrix = new flash.geom.Matrix();
            }
            if (this._transformationMatrixToRoot) 
            {
                this._transformationMatrixToRoot.identity();
            }
            else 
            {
                this._transformationMatrixToRoot = new flash.geom.Matrix();
            }
            if (this._rotated) 
            {
                this._transformationMatrix.translate(0, -1);
                this._transformationMatrix.rotate(Math.PI / 2);
            }
            this._transformationMatrix.scale(this._region.width / this._parent.width, this._region.height / this._parent.height);
            this._transformationMatrix.translate(this._region.x / this._parent.width, this._region.y / this._parent.height);
            var loc1:*=this;
            while (loc1) 
            {
                this._transformationMatrixToRoot.concat(loc1._transformationMatrix);
                loc1 = loc1.parent as starling.textures.SubTexture;
            }
            return;
        }

        public override function dispose():void
        {
            if (this._ownsParent) 
            {
                this._parent.dispose();
            }
            super.dispose();
            return;
        }

        public function get parent():starling.textures.Texture
        {
            return this._parent;
        }

        public function get ownsParent():Boolean
        {
            return this._ownsParent;
        }

        public function get rotated():Boolean
        {
            return this._rotated;
        }

        public function get region():flash.geom.Rectangle
        {
            return this._region;
        }

        public override function get transformationMatrix():flash.geom.Matrix
        {
            return this._transformationMatrix;
        }

        public override function get transformationMatrixToRoot():flash.geom.Matrix
        {
            return this._transformationMatrixToRoot;
        }

        public override function get base():flash.display3D.textures.TextureBase
        {
            return this._parent.base;
        }

        public override function get root():starling.textures.ConcreteTexture
        {
            return this._parent.root;
        }

        public override function get format():String
        {
            return this._parent.format;
        }

        public override function get width():Number
        {
            return this._width;
        }

        public override function get height():Number
        {
            return this._height;
        }

        public override function get nativeWidth():Number
        {
            return this._width * this._scale;
        }

        public override function get nativeHeight():Number
        {
            return this._height * this._scale;
        }

        public override function get mipMapping():Boolean
        {
            return this._parent.mipMapping;
        }

        public override function get premultipliedAlpha():Boolean
        {
            return this._parent.premultipliedAlpha;
        }

        public override function get scale():Number
        {
            return this._scale;
        }

        public override function get frame():flash.geom.Rectangle
        {
            return this._frame;
        }

        internal var _parent:starling.textures.Texture;

        internal var _ownsParent:Boolean;

        internal var _region:flash.geom.Rectangle;

        internal var _frame:flash.geom.Rectangle;

        internal var _rotated:Boolean;

        internal var _width:Number;

        internal var _height:Number;

        internal var _scale:Number;

        internal var _transformationMatrix:flash.geom.Matrix;

        internal var _transformationMatrixToRoot:flash.geom.Matrix;
    }
}


//  class Texture
package starling.textures 
{
    import flash.display.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class Texture extends Object
    {
        public function Texture()
        {
            super();
            if (flash.system.Capabilities.isDebugger && flash.utils.getQualifiedClassName(this) == "starling.textures::Texture") 
            {
                throw new starling.errors.AbstractClassError();
            }
            return;
        }

        public function dispose():void
        {
            return;
        }

        public function setupVertexPositions(arg1:starling.rendering.VertexData, arg2:int=0, arg3:String="position", arg4:flash.geom.Rectangle=null):void
        {
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc1:*=this.frame;
            var loc2:*=this.width;
            var loc3:*=this.height;
            if (loc1) 
            {
                sRectangle.setTo(-loc1.x, -loc1.y, loc2, loc3);
            }
            else 
            {
                sRectangle.setTo(0, 0, loc2, loc3);
            }
            arg1.setPoint(arg2, arg3, sRectangle.left, sRectangle.top);
            arg1.setPoint(arg2 + 1, arg3, sRectangle.right, sRectangle.top);
            arg1.setPoint(arg2 + 2, arg3, sRectangle.left, sRectangle.bottom);
            arg1.setPoint(arg2 + 3, arg3, sRectangle.right, sRectangle.bottom);
            if (arg4) 
            {
                loc4 = arg4.width / this.frameWidth;
                loc5 = arg4.height / this.frameHeight;
                if (!(loc4 == 1) || !(loc5 == 1) || !(arg4.x == 0) || !(arg4.y == 0)) 
                {
                    sMatrix.identity();
                    sMatrix.scale(loc4, loc5);
                    sMatrix.translate(arg4.x, arg4.y);
                    arg1.transformPoints(arg3, sMatrix, arg2, 4);
                }
            }
            return;
        }

        public function setupTextureCoordinates(arg1:starling.rendering.VertexData, arg2:int=0, arg3:String="texCoords"):void
        {
            this.setTexCoords(arg1, arg2, arg3, 0, 0);
            this.setTexCoords(arg1, arg2 + 1, arg3, 1, 0);
            this.setTexCoords(arg1, arg2 + 2, arg3, 0, 1);
            this.setTexCoords(arg1, arg2 + 3, arg3, 1, 1);
            return;
        }

        public function localToGlobal(arg1:Number, arg2:Number, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Point();
            }
            if (this != this.root) 
            {
                starling.utils.MatrixUtil.transformCoords(this.transformationMatrixToRoot, arg1, arg2, arg3);
            }
            else 
            {
                arg3.setTo(arg1, arg2);
            }
            return arg3;
        }

        public function globalToLocal(arg1:Number, arg2:Number, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Point();
            }
            if (this != this.root) 
            {
                sMatrix.identity();
                sMatrix.copyFrom(this.transformationMatrixToRoot);
                sMatrix.invert();
                starling.utils.MatrixUtil.transformCoords(sMatrix, arg1, arg2, arg3);
            }
            else 
            {
                arg3.setTo(arg1, arg2);
            }
            return arg3;
        }

        public function setTexCoords(arg1:starling.rendering.VertexData, arg2:int, arg3:String, arg4:Number, arg5:Number):void
        {
            this.localToGlobal(arg4, arg5, sPoint);
            arg1.setPoint(arg2, arg3, sPoint.x, sPoint.y);
            return;
        }

        public function getTexCoords(arg1:starling.rendering.VertexData, arg2:int, arg3:String="texCoords", arg4:flash.geom.Point=null):flash.geom.Point
        {
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Point();
            }
            arg1.getPoint(arg2, arg3, arg4);
            return this.globalToLocal(arg4.x, arg4.y, arg4);
        }

        public function get frame():flash.geom.Rectangle
        {
            return null;
        }

        public function get frameWidth():Number
        {
            return this.frame ? this.frame.width : this.width;
        }

        public function get frameHeight():Number
        {
            return this.frame ? this.frame.height : this.height;
        }

        public function get width():Number
        {
            return 0;
        }

        public function get height():Number
        {
            return 0;
        }

        public function get nativeWidth():Number
        {
            return 0;
        }

        public function get nativeHeight():Number
        {
            return 0;
        }

        public function get scale():Number
        {
            return 1;
        }

        public function get base():flash.display3D.textures.TextureBase
        {
            return null;
        }

        public function get root():starling.textures.ConcreteTexture
        {
            return null;
        }

        public function get format():String
        {
            return flash.display3D.Context3DTextureFormat.BGRA;
        }

        public function get mipMapping():Boolean
        {
            return false;
        }

        public function get premultipliedAlpha():Boolean
        {
            return false;
        }

        public function get transformationMatrix():flash.geom.Matrix
        {
            return null;
        }

        public function get transformationMatrixToRoot():flash.geom.Matrix
        {
            return null;
        }

        public static function fromData(arg1:Object, arg2:starling.textures.TextureOptions=null):starling.textures.Texture
        {
            if (arg1 is flash.display.Bitmap) 
            {
                arg1 = (arg1 as flash.display.Bitmap).bitmapData;
            }
            if (arg2 == null) 
            {
                arg2 = sDefaultOptions;
            }
            if (arg1 is Class) 
            {
                return fromEmbeddedAsset(arg1 as Class, arg2.mipMapping, arg2.optimizeForRenderToTexture, arg2.scale, arg2.format, arg2.forcePotTexture);
            }
            if (arg1 is flash.display.BitmapData) 
            {
                return fromBitmapData(arg1 as flash.display.BitmapData, arg2.mipMapping, arg2.optimizeForRenderToTexture, arg2.scale, arg2.format, arg2.forcePotTexture);
            }
            if (arg1 is flash.utils.ByteArray) 
            {
                return fromAtfData(arg1 as flash.utils.ByteArray, arg2.scale, arg2.mipMapping, arg2.onReady);
            }
            throw new ArgumentError("Unsupported \'data\' type: " + flash.utils.getQualifiedClassName(arg1));
        }

        public static function fromTextureBase(arg1:flash.display3D.textures.TextureBase, arg2:int, arg3:int, arg4:starling.textures.TextureOptions=null):starling.textures.ConcreteTexture
        {
            if (arg4 == null) 
            {
                arg4 = sDefaultOptions;
            }
            if (arg1 is flash.display3D.textures.Texture) 
            {
                return new ConcretePotTexture(arg1 as flash.display3D.textures.Texture, arg4.format, arg2, arg3, arg4.mipMapping, arg4.premultipliedAlpha, arg4.optimizeForRenderToTexture, arg4.scale);
            }
            if (arg1 is flash.display3D.textures.RectangleTexture) 
            {
                return new ConcreteRectangleTexture(arg1 as flash.display3D.textures.RectangleTexture, arg4.format, arg2, arg3, arg4.premultipliedAlpha, arg4.optimizeForRenderToTexture, arg4.scale);
            }
            if (arg1 is flash.display3D.textures.VideoTexture) 
            {
                return new ConcreteVideoTexture(arg1 as flash.display3D.textures.VideoTexture, arg4.scale);
            }
            throw new ArgumentError("Unsupported \'base\' type: " + flash.utils.getQualifiedClassName(arg1));
        }

        public static function fromEmbeddedAsset(arg1:Class, arg2:Boolean=false, arg3:Boolean=false, arg4:Number=1, arg5:String="bgra", arg6:Boolean=false):starling.textures.Texture
        {
            var assetClass:Class;
            var mipMapping:Boolean=false;
            var optimizeForRenderToTexture:Boolean=false;
            var scale:Number=1;
            var format:String="bgra";
            var forcePotTexture:Boolean=false;
            var texture:starling.textures.Texture;
            var asset:Object;

            var loc1:*;
            texture = null;
            assetClass = arg1;
            mipMapping = arg2;
            optimizeForRenderToTexture = arg3;
            scale = arg4;
            format = arg5;
            forcePotTexture = arg6;
            asset = new assetClass();
            if (asset is flash.display.Bitmap) 
            {
                texture = starling.textures.Texture.fromBitmap(asset as flash.display.Bitmap, mipMapping, optimizeForRenderToTexture, scale, format, forcePotTexture);
                texture.root.onRestore = function ():void
                {
                    texture.root.uploadBitmap(new assetClass());
                    return;
                }
            }
            else if (asset is flash.utils.ByteArray) 
            {
                texture = starling.textures.Texture.fromAtfData(asset as flash.utils.ByteArray, scale, mipMapping, null);
                texture.root.onRestore = function ():void
                {
                    texture.root.uploadAtfData(new assetClass());
                    return;
                }
            }
            else 
            {
                throw new ArgumentError("Invalid asset type: " + flash.utils.getQualifiedClassName(asset));
            }
            asset = null;
            return texture;
        }

        public static function fromBitmap(arg1:flash.display.Bitmap, arg2:Boolean=false, arg3:Boolean=false, arg4:Number=1, arg5:String="bgra", arg6:Boolean=false):starling.textures.Texture
        {
            return fromBitmapData(arg1.bitmapData, arg2, arg3, arg4, arg5, arg6);
        }

        public static function fromBitmapData(arg1:flash.display.BitmapData, arg2:Boolean=false, arg3:Boolean=false, arg4:Number=1, arg5:String="bgra", arg6:Boolean=false):starling.textures.Texture
        {
            var data:flash.display.BitmapData;
            var generateMipMaps:Boolean=false;
            var optimizeForRenderToTexture:Boolean=false;
            var scale:Number=1;
            var format:String="bgra";
            var forcePotTexture:Boolean=false;
            var texture:starling.textures.Texture;

            var loc1:*;
            texture = null;
            data = arg1;
            generateMipMaps = arg2;
            optimizeForRenderToTexture = arg3;
            scale = arg4;
            format = arg5;
            forcePotTexture = arg6;
            texture = starling.textures.Texture.empty(data.width / scale, data.height / scale, true, generateMipMaps, optimizeForRenderToTexture, scale, format, forcePotTexture);
            texture.root.uploadBitmapData(data);
            texture.root.onRestore = function ():void
            {
                texture.root.uploadBitmapData(data);
                return;
            }
            return texture;
        }

        public static function fromAtfData(arg1:flash.utils.ByteArray, arg2:Number=1, arg3:Boolean=true, arg4:Function=null, arg5:Boolean=false):starling.textures.Texture
        {
            var data:flash.utils.ByteArray;
            var scale:Number=1;
            var useMipMaps:Boolean=true;
            var async:Function=null;
            var premultipliedAlpha:Boolean=false;
            var context:flash.display3D.Context3D;
            var atfData:starling.textures.AtfData;
            var nativeTexture:flash.display3D.textures.Texture;
            var concreteTexture:starling.textures.ConcreteTexture;

            var loc1:*;
            concreteTexture = null;
            data = arg1;
            scale = arg2;
            useMipMaps = arg3;
            async = arg4;
            premultipliedAlpha = arg5;
            context = starling.core.Starling.context;
            if (context == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            atfData = new starling.textures.AtfData(data);
            nativeTexture = context.createTexture(atfData.width, atfData.height, atfData.format, false);
            concreteTexture = new ConcretePotTexture(nativeTexture, atfData.format, atfData.width, atfData.height, useMipMaps && atfData.numTextures > 1, premultipliedAlpha, false, scale);
            concreteTexture.uploadAtfData(data, 0, async);
            concreteTexture.onRestore = function ():void
            {
                concreteTexture.uploadAtfData(data, 0);
                return;
            }
            return concreteTexture;
        }

        public static function fromNetStream(arg1:flash.net.NetStream, arg2:Number=1, arg3:Function=null):starling.textures.Texture
        {
            var stream:flash.net.NetStream;
            var scale:Number=1;
            var onComplete:Function=null;

            var loc1:*;
            stream = arg1;
            scale = arg2;
            onComplete = arg3;
            if (stream.client == stream && !("onMetaData" in stream)) 
            {
                stream.client = {"onMetaData":function (arg1:Object):void
                {
                    return;
                }}
            }
            return fromVideoAttachment("NetStream", stream, scale, onComplete);
        }

        public static function fromCamera(arg1:flash.media.Camera, arg2:Number=1, arg3:Function=null):starling.textures.Texture
        {
            return fromVideoAttachment("Camera", arg1, arg2, arg3);
        }

        internal static function fromVideoAttachment(arg1:String, arg2:Object, arg3:Number, arg4:Function):starling.textures.Texture
        {
            var type:String;
            var attachment:Object;
            var scale:Number;
            var onComplete:Function;
            var context:flash.display3D.Context3D;
            var base:flash.display3D.textures.VideoTexture;
            var texture:starling.textures.ConcreteTexture;

            var loc1:*;
            texture = null;
            type = arg1;
            attachment = arg2;
            scale = arg3;
            onComplete = arg4;
            if (!starling.utils.SystemUtil.supportsVideoTexture) 
            {
                throw new starling.errors.NotSupportedError("Video Textures are not supported on this platform");
            }
            context = starling.core.Starling.context;
            if (context == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            base = context.createVideoTexture();
            texture = new ConcreteVideoTexture(base, scale);
            texture.attachVideo(type, attachment, onComplete);
            texture.onRestore = function ():void
            {
                texture.root.attachVideo(type, attachment);
                return;
            }
            return texture;
        }

        public static function fromColor(arg1:Number, arg2:Number, arg3:uint=16777215, arg4:Number=1, arg5:Boolean=false, arg6:Number=-1, arg7:String="bgra", arg8:Boolean=false):starling.textures.Texture
        {
            var width:Number;
            var height:Number;
            var color:uint=16777215;
            var alpha:Number=1;
            var optimizeForRenderToTexture:Boolean=false;
            var scale:Number=-1;
            var format:String="bgra";
            var forcePotTexture:Boolean=false;
            var texture:starling.textures.Texture;

            var loc1:*;
            texture = null;
            width = arg1;
            height = arg2;
            color = arg3;
            alpha = arg4;
            optimizeForRenderToTexture = arg5;
            scale = arg6;
            format = arg7;
            forcePotTexture = arg8;
            texture = starling.textures.Texture.empty(width, height, true, false, optimizeForRenderToTexture, scale, format, forcePotTexture);
            texture.root.clear(color, alpha);
            texture.root.onRestore = function ():void
            {
                texture.root.clear(color, alpha);
                return;
            }
            return texture;
        }

        public static function empty(arg1:Number, arg2:Number, arg3:Boolean=true, arg4:Boolean=false, arg5:Boolean=false, arg6:Number=-1, arg7:String="bgra", arg8:Boolean=false):starling.textures.Texture
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            if (arg6 <= 0) 
            {
                arg6 = starling.core.Starling.contentScaleFactor;
            }
            var loc5:*=starling.core.Starling.context;
            if (loc5 == null) 
            {
                throw new starling.errors.MissingContextError();
            }
            var loc6:*=arg1 * arg6;
            var loc7:*=arg2 * arg6;
            var loc8:*=!arg8 && !arg4 && !(starling.core.Starling.current.profile == "baselineConstrained") && arg7.indexOf("compressed") == -1;
            if (loc8) 
            {
                loc1 = Math.ceil(loc6 - 1e-009);
                loc2 = Math.ceil(loc7 - 1e-009);
                loc3 = loc5.createRectangleTexture(loc1, loc2, arg7, arg5);
                loc4 = new ConcreteRectangleTexture(loc3 as flash.display3D.textures.RectangleTexture, arg7, loc1, loc2, arg3, arg5, arg6);
            }
            else 
            {
                loc1 = starling.utils.MathUtil.getNextPowerOfTwo(loc6);
                loc2 = starling.utils.MathUtil.getNextPowerOfTwo(loc7);
                loc3 = loc5.createTexture(loc1, loc2, arg7, arg5);
                loc4 = new ConcretePotTexture(loc3 as flash.display3D.textures.Texture, arg7, loc1, loc2, arg4, arg3, arg5, arg6);
            }
            loc4.onRestore = loc4.clear;
            if (loc1 - loc6 < 0.001 && loc2 - loc7 < 0.001) 
            {
                return loc4;
            }
            return new starling.textures.SubTexture(loc4, new flash.geom.Rectangle(0, 0, arg1, arg2), true);
        }

        public static function fromTexture(arg1:starling.textures.Texture, arg2:flash.geom.Rectangle=null, arg3:flash.geom.Rectangle=null, arg4:Boolean=false, arg5:Number=1):starling.textures.Texture
        {
            return new starling.textures.SubTexture(arg1, arg2, false, arg3, arg4, arg5);
        }

        public static function get maxSize():int
        {
            var loc1:*=starling.core.Starling.current;
            var loc2:*=loc1 ? loc1.profile : "baseline";
            if (loc2 == "baseline" || loc2 == "baselineConstrained") 
            {
                return 2048;
            }
            return 4096;
        }

        
        {
            sDefaultOptions = new starling.textures.TextureOptions();
            sRectangle = new flash.geom.Rectangle();
            sMatrix = new flash.geom.Matrix();
            sPoint = new flash.geom.Point();
        }

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sPoint:flash.geom.Point;

        internal static var sDefaultOptions:starling.textures.TextureOptions;

        internal static var sRectangle:flash.geom.Rectangle;
    }
}


//  class TextureAtlas
package starling.textures 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.utils.*;
    
    public class TextureAtlas extends Object
    {
        public function TextureAtlas(arg1:starling.textures.Texture, arg2:XML=null)
        {
            super();
            this._subTextures = new flash.utils.Dictionary();
            this._atlasTexture = arg1;
            if (arg2) 
            {
                this.parseAtlasXml(arg2);
            }
            return;
        }

        public function dispose():void
        {
            this._atlasTexture.dispose();
            return;
        }

        protected function parseAtlasXml(arg1:XML):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=false;
            var loc1:*=this._atlasTexture.scale;
            var loc2:*=new flash.geom.Rectangle();
            var loc3:*=new flash.geom.Rectangle();
            var loc15:*=0;
            var loc16:*=arg1.SubTexture;
            for each (loc4 in loc16) 
            {
                loc5 = starling.utils.StringUtil.clean(loc4.@name);
                loc6 = parseFloat(loc4.@x) / loc1;
                loc7 = parseFloat(loc4.@y) / loc1;
                loc8 = parseFloat(loc4.@width) / loc1;
                loc9 = parseFloat(loc4.@height) / loc1;
                loc10 = parseFloat(loc4.@frameX) / loc1;
                loc11 = parseFloat(loc4.@frameY) / loc1;
                loc12 = parseFloat(loc4.@frameWidth) / loc1;
                loc13 = parseFloat(loc4.@frameHeight) / loc1;
                loc14 = parseBool(loc4.@rotated);
                loc2.setTo(loc6, loc7, loc8, loc9);
                loc3.setTo(loc10, loc11, loc12, loc13);
                if (loc12 > 0 && loc13 > 0) 
                {
                    this.addRegion(loc5, loc2, loc3, loc14);
                    continue;
                }
                this.addRegion(loc5, loc2, null, loc14);
            }
            return;
        }

        public function getTexture(arg1:String):starling.textures.Texture
        {
            return this._subTextures[arg1];
        }

        public function getTextures(arg1:String="", arg2:__AS3__.vec.Vector.<starling.textures.Texture>=null):__AS3__.vec.Vector.<starling.textures.Texture>
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                arg2 = new Vector.<starling.textures.Texture>(0);
            }
            var loc2:*=0;
            var loc3:*=this.getNames(arg1, sNames);
            for each (loc1 in loc3) 
            {
                arg2[arg2.length] = this.getTexture(loc1);
            }
            sNames.length = 0;
            return arg2;
        }

        public function getNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                arg2 = new Vector.<String>(0);
            }
            if (this._subTextureNames == null) 
            {
                this._subTextureNames = new Vector.<String>(0);
                var loc2:*=0;
                var loc3:*=this._subTextures;
                for (loc1 in loc3) 
                {
                    this._subTextureNames[this._subTextureNames.length] = loc1;
                }
                this._subTextureNames.sort(Array.CASEINSENSITIVE);
            }
            loc2 = 0;
            loc3 = this._subTextureNames;
            for each (loc1 in loc3) 
            {
                if (loc1.indexOf(arg1) != 0) 
                {
                    continue;
                }
                arg2[arg2.length] = loc1;
            }
            return arg2;
        }

        public function getRegion(arg1:String):flash.geom.Rectangle
        {
            var loc1:*=this._subTextures[arg1];
            return loc1 ? loc1.region : null;
        }

        public function getFrame(arg1:String):flash.geom.Rectangle
        {
            var loc1:*=this._subTextures[arg1];
            return loc1 ? loc1.frame : null;
        }

        public function getRotation(arg1:String):Boolean
        {
            var loc1:*=this._subTextures[arg1];
            return loc1 ? loc1.rotated : false;
        }

        public function addRegion(arg1:String, arg2:flash.geom.Rectangle, arg3:flash.geom.Rectangle=null, arg4:Boolean=false):void
        {
            this._subTextures[arg1] = new starling.textures.SubTexture(this._atlasTexture, arg2, false, arg3, arg4);
            this._subTextureNames = null;
            return;
        }

        public function removeRegion(arg1:String):void
        {
            var loc1:*=this._subTextures[arg1];
            if (loc1) 
            {
                loc1.dispose();
            }
            delete this._subTextures[arg1];
            this._subTextureNames = null;
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._atlasTexture;
        }

        internal static function parseBool(arg1:String):Boolean
        {
            return arg1.toLowerCase() == "true";
        }

        
        {
            sNames = new Vector.<String>(0);
        }

        internal var _atlasTexture:starling.textures.Texture;

        internal var _subTextures:flash.utils.Dictionary;

        internal var _subTextureNames:__AS3__.vec.Vector.<String>;

        internal static var sNames:__AS3__.vec.Vector.<String>;
    }
}


//  class TextureOptions
package starling.textures 
{
    import starling.core.*;
    
    public class TextureOptions extends Object
    {
        public function TextureOptions(arg1:Number=1, arg2:Boolean=false, arg3:String="bgra", arg4:Boolean=true, arg5:Boolean=false)
        {
            super();
            this._scale = arg1;
            this._format = arg3;
            this._mipMapping = arg2;
            this._forcePotTexture = arg5;
            this._premultipliedAlpha = arg4;
            return;
        }

        public function clone():starling.textures.TextureOptions
        {
            var loc1:*=new starling.textures.TextureOptions(this._scale, this._mipMapping, this._format);
            loc1._optimizeForRenderToTexture = this._optimizeForRenderToTexture;
            loc1._premultipliedAlpha = this._premultipliedAlpha;
            loc1._forcePotTexture = this._forcePotTexture;
            loc1._onReady = this._onReady;
            return loc1;
        }

        public function get scale():Number
        {
            return this._scale;
        }

        public function set scale(arg1:Number):void
        {
            this._scale = arg1 > 0 ? arg1 : starling.core.Starling.contentScaleFactor;
            return;
        }

        public function get format():String
        {
            return this._format;
        }

        public function set format(arg1:String):void
        {
            this._format = arg1;
            return;
        }

        public function get mipMapping():Boolean
        {
            return this._mipMapping;
        }

        public function set mipMapping(arg1:Boolean):void
        {
            this._mipMapping = arg1;
            return;
        }

        public function get optimizeForRenderToTexture():Boolean
        {
            return this._optimizeForRenderToTexture;
        }

        public function set optimizeForRenderToTexture(arg1:Boolean):void
        {
            this._optimizeForRenderToTexture = arg1;
            return;
        }

        public function get forcePotTexture():Boolean
        {
            return this._forcePotTexture;
        }

        public function set forcePotTexture(arg1:Boolean):void
        {
            this._forcePotTexture = arg1;
            return;
        }

        public function get onReady():Function
        {
            return this._onReady;
        }

        public function set onReady(arg1:Function):void
        {
            this._onReady = arg1;
            return;
        }

        public function get premultipliedAlpha():Boolean
        {
            return this._premultipliedAlpha;
        }

        public function set premultipliedAlpha(arg1:Boolean):void
        {
            this._premultipliedAlpha = arg1;
            return;
        }

        internal var _scale:Number;

        internal var _format:String;

        internal var _mipMapping:Boolean;

        internal var _optimizeForRenderToTexture:Boolean=false;

        internal var _premultipliedAlpha:Boolean;

        internal var _forcePotTexture:Boolean;

        internal var _onReady:Function=null;
    }
}


//  class TextureSmoothing
package starling.textures 
{
    import starling.errors.*;
    
    public class TextureSmoothing extends Object
    {
        public function TextureSmoothing()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function isValid(arg1:String):Boolean
        {
            return arg1 == NONE || arg1 == BILINEAR || arg1 == TRILINEAR;
        }

        public static const NONE:String="none";

        public static const BILINEAR:String="bilinear";

        public static const TRILINEAR:String="trilinear";
    }
}


