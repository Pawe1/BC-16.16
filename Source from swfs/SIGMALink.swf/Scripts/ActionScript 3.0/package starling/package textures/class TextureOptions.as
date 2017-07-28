//class TextureOptions
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


