//class Texture
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


