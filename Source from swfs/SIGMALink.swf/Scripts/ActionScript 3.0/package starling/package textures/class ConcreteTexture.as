//class ConcreteTexture
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


