//class ConcreteVideoTexture
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


