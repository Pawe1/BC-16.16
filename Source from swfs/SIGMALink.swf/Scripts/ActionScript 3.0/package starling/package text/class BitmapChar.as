//class BitmapChar
package starling.text 
{
    import flash.utils.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class BitmapChar extends Object
    {
        public function BitmapChar(arg1:int, arg2:starling.textures.Texture, arg3:Number, arg4:Number, arg5:Number)
        {
            super();
            this._charID = arg1;
            this._texture = arg2;
            this._xOffset = arg3;
            this._yOffset = arg4;
            this._xAdvance = arg5;
            this._kernings = null;
            return;
        }

        public function addKerning(arg1:int, arg2:Number):void
        {
            if (this._kernings == null) 
            {
                this._kernings = new flash.utils.Dictionary();
            }
            this._kernings[arg1] = arg2;
            return;
        }

        public function getKerning(arg1:int):Number
        {
            if (this._kernings == null || this._kernings[arg1] == undefined) 
            {
                return 0;
            }
            return this._kernings[arg1];
        }

        public function createImage():starling.display.Image
        {
            return new starling.display.Image(this._texture);
        }

        public function get charID():int
        {
            return this._charID;
        }

        public function get xOffset():Number
        {
            return this._xOffset;
        }

        public function get yOffset():Number
        {
            return this._yOffset;
        }

        public function get xAdvance():Number
        {
            return this._xAdvance;
        }

        public function get texture():starling.textures.Texture
        {
            return this._texture;
        }

        public function get width():Number
        {
            return this._texture.width;
        }

        public function get height():Number
        {
            return this._texture.height;
        }

        internal var _texture:starling.textures.Texture;

        internal var _charID:int;

        internal var _xOffset:Number;

        internal var _yOffset:Number;

        internal var _xAdvance:Number;

        internal var _kernings:flash.utils.Dictionary;
    }
}


