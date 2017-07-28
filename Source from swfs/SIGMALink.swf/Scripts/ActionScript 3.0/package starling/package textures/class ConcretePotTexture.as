//class ConcretePotTexture
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


