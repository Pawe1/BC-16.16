//class TextOptions
package starling.text 
{
    import flash.display3D.*;
    import starling.core.*;
    
    public class TextOptions extends Object
    {
        public function TextOptions(arg1:Boolean=true, arg2:Boolean=false)
        {
            super();
            this._wordWrap = arg1;
            this._autoScale = arg2;
            this._autoSize = starling.text.TextFieldAutoSize.NONE;
            this._textureScale = starling.core.Starling.contentScaleFactor;
            this._textureFormat = flash.display3D.Context3DTextureFormat.BGR_PACKED;
            this._isHtmlText = false;
            return;
        }

        public function copyFrom(arg1:starling.text.TextOptions):void
        {
            this._wordWrap = arg1._wordWrap;
            this._autoScale = arg1._autoScale;
            this._autoSize = arg1._autoSize;
            this._isHtmlText = arg1._isHtmlText;
            this._textureScale = arg1._textureScale;
            this._textureFormat = arg1._textureFormat;
            return;
        }

        public function clone():starling.text.TextOptions
        {
            var loc1:*=new starling.text.TextOptions();
            loc1.copyFrom(this);
            return loc1;
        }

        public function get wordWrap():Boolean
        {
            return this._wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            this._wordWrap = arg1;
            return;
        }

        public function get autoSize():String
        {
            return this._autoSize;
        }

        public function set autoSize(arg1:String):void
        {
            this._autoSize = arg1;
            return;
        }

        public function get autoScale():Boolean
        {
            return this._autoScale;
        }

        public function set autoScale(arg1:Boolean):void
        {
            this._autoScale = arg1;
            return;
        }

        public function get isHtmlText():Boolean
        {
            return this._isHtmlText;
        }

        public function set isHtmlText(arg1:Boolean):void
        {
            this._isHtmlText = arg1;
            return;
        }

        public function get textureScale():Number
        {
            return this._textureScale;
        }

        public function set textureScale(arg1:Number):void
        {
            this._textureScale = arg1;
            return;
        }

        public function get textureFormat():String
        {
            return this._textureFormat;
        }

        public function set textureFormat(arg1:String):void
        {
            this._textureFormat = arg1;
            return;
        }

        internal var _wordWrap:Boolean;

        internal var _autoScale:Boolean;

        internal var _autoSize:String;

        internal var _isHtmlText:Boolean;

        internal var _textureScale:Number;

        internal var _textureFormat:String;
    }
}


