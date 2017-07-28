//class TextField
package starling.text 
{
    import flash.display3D.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.utils.*;
    
    public class TextField extends starling.display.DisplayObjectContainer
    {
        public function TextField(arg1:int, arg2:int, arg3:String="", arg4:starling.text.TextFormat=null)
        {
            this._helperFormat = new starling.text.TextFormat();
            super();
            this._text = arg3 ? arg3 : "";
            this._hitArea = new flash.geom.Rectangle(0, 0, arg1, arg2);
            this._requiresRecomposition = true;
            this._compositor = sDefaultCompositor;
            this._options = new starling.text.TextOptions();
            this._format = arg4 ? arg4.clone() : new starling.text.TextFormat();
            this._format.addEventListener(starling.events.Event.CHANGE, this.setRequiresRecomposition);
            this._meshBatch = new starling.display.MeshBatch();
            this._meshBatch.touchable = false;
            this._meshBatch.pixelSnapping = true;
            addChild(this._meshBatch);
            return;
        }

        public static function get defaultCompositor():starling.text.ITextCompositor
        {
            return sDefaultCompositor;
        }

        public static function set defaultCompositor(arg1:starling.text.ITextCompositor):void
        {
            sDefaultCompositor = arg1;
            return;
        }

        public static function updateEmbeddedFonts():void
        {
            starling.utils.SystemUtil.updateEmbeddedFonts();
            return;
        }

        public static function registerCompositor(arg1:starling.text.ITextCompositor, arg2:String):void
        {
            if (arg2 == null) 
            {
                throw new ArgumentError("name must not be null");
            }
            compositors[convertToLowerCase(arg2)] = arg1;
            return;
        }

        
        {
            sMatrix = new flash.geom.Matrix();
            sDefaultCompositor = new starling.text.TrueTypeCompositor();
            sDefaultTextureFormat = flash.display3D.Context3DTextureFormat.BGRA_PACKED;
            sStringCache = new flash.utils.Dictionary();
        }

        public static function getCompositor(arg1:String):starling.text.ITextCompositor
        {
            return compositors[convertToLowerCase(arg1)];
        }

        public static function registerBitmapFont(arg1:starling.text.BitmapFont, arg2:String=null):String
        {
            if (arg2 == null) 
            {
                arg2 = arg1.name;
            }
            registerCompositor(arg1, arg2);
            return arg2;
        }

        internal function updateBorder():void
        {
            if (this._border == null) 
            {
                return;
            }
            var loc1:*=this._hitArea.width;
            var loc2:*=this._hitArea.height;
            var loc3:*=this._border.getChildAt(0) as starling.display.Quad;
            var loc4:*=this._border.getChildAt(1) as starling.display.Quad;
            var loc5:*=this._border.getChildAt(2) as starling.display.Quad;
            var loc6:*=this._border.getChildAt(3) as starling.display.Quad;
            loc3.width = loc1;
            loc3.height = 1;
            loc5.width = loc1;
            loc5.height = 1;
            loc6.width = 1;
            loc6.height = loc2;
            loc4.width = 1;
            loc4.height = loc2;
            loc4.x = (loc1 - 1);
            loc5.y = (loc2 - 1);
            var loc7:*;
            loc6.color = loc7 = this._format.color;
            loc5.color = loc7 = loc7;
            loc4.color = loc7 = loc7;
            loc3.color = loc7;
            return;
        }

        public static function unregisterBitmapFont(arg1:String, arg2:Boolean=true):void
        {
            unregisterCompositor(arg1, arg2);
            return;
        }

        public static function getBitmapFont(arg1:String):starling.text.BitmapFont
        {
            return getCompositor(arg1) as starling.text.BitmapFont;
        }

        internal static function get compositors():flash.utils.Dictionary
        {
            var loc1:*=starling.core.Starling.painter.sharedData[COMPOSITOR_DATA_NAME] as flash.utils.Dictionary;
            if (loc1 == null) 
            {
                loc1 = new flash.utils.Dictionary();
                starling.core.Starling.painter.sharedData[COMPOSITOR_DATA_NAME] = loc1;
            }
            return loc1;
        }

        public override function dispose():void
        {
            this._format.removeEventListener(starling.events.Event.CHANGE, this.setRequiresRecomposition);
            this._compositor.clearMeshBatch(this._meshBatch);
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (this._requiresRecomposition) 
            {
                this.recompose();
            }
            super.render(arg1);
            return;
        }

        internal function recompose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._requiresRecomposition) 
            {
                this._compositor.clearMeshBatch(this._meshBatch);
                loc1 = this._format.font;
                loc2 = getCompositor(loc1);
                if (loc2 == null && loc1 == starling.text.BitmapFont.MINI) 
                {
                    loc2 = new starling.text.BitmapFont();
                    registerCompositor(loc2, loc1);
                }
                this._compositor = loc2 ? loc2 : sDefaultCompositor;
                this.updateText();
                this.updateBorder();
                this._requiresRecomposition = false;
            }
            return;
        }

        internal function updateText():void
        {
            var loc1:*=this._hitArea.width;
            var loc2:*=this._hitArea.height;
            var loc3:*=this._helperFormat;
            loc3.copyFrom(this._format);
            if (this.isHorizontalAutoSize && !this._options.isHtmlText) 
            {
                loc1 = 100000;
            }
            if (this.isVerticalAutoSize) 
            {
                loc2 = 100000;
            }
            var loc4:*;
            this._meshBatch.y = loc4 = 0;
            this._meshBatch.x = loc4;
            this._options.textureScale = starling.core.Starling.contentScaleFactor;
            this._options.textureFormat = sDefaultTextureFormat;
            this._compositor.fillMeshBatch(this._meshBatch, loc1, loc2, this._text, loc3, this._options);
            if (this._style) 
            {
                this._meshBatch.style = this._style;
            }
            if (this._options.autoSize == starling.text.TextFieldAutoSize.NONE) 
            {
                this._textBounds = null;
            }
            else 
            {
                this._textBounds = this._meshBatch.getBounds(this._meshBatch, this._textBounds);
                if (this.isHorizontalAutoSize) 
                {
                    this._textBounds.x = loc4 = -this._textBounds.x;
                    this._meshBatch.x = loc4;
                    this._hitArea.width = this._textBounds.width;
                    this._textBounds.x = 0;
                }
                if (this.isVerticalAutoSize) 
                {
                    this._textBounds.y = loc4 = -this._textBounds.y;
                    this._meshBatch.y = loc4;
                    this._hitArea.height = this._textBounds.height;
                    this._textBounds.y = 0;
                }
            }
            return;
        }

        internal static function convertToLowerCase(arg1:String):String
        {
            var loc1:*=sStringCache[arg1];
            if (loc1 == null) 
            {
                loc1 = arg1.toLowerCase();
                sStringCache[arg1] = loc1;
            }
            return loc1;
        }

        protected function setRequiresRecomposition():void
        {
            this._requiresRecomposition = true;
            setRequiresRedraw();
            return;
        }

        internal function get isHorizontalAutoSize():Boolean
        {
            return this._options.autoSize == starling.text.TextFieldAutoSize.HORIZONTAL || this._options.autoSize == starling.text.TextFieldAutoSize.BOTH_DIRECTIONS;
        }

        internal function get isVerticalAutoSize():Boolean
        {
            return this._options.autoSize == starling.text.TextFieldAutoSize.VERTICAL || this._options.autoSize == starling.text.TextFieldAutoSize.BOTH_DIRECTIONS;
        }

        public function get textBounds():flash.geom.Rectangle
        {
            if (this._requiresRecomposition) 
            {
                this.recompose();
            }
            if (this._textBounds == null) 
            {
                this._textBounds = this._meshBatch.getBounds(this);
            }
            return this._textBounds.clone();
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (this._requiresRecomposition) 
            {
                this.recompose();
            }
            getTransformationMatrix(arg1, sMatrix);
            return starling.utils.RectangleUtil.getBounds(this._hitArea, sMatrix, arg2);
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            if (this._hitArea.containsPoint(arg1)) 
            {
                return this;
            }
            return null;
        }

        public override function set width(arg1:Number):void
        {
            this._hitArea.width = arg1 / (scaleX || 1);
            this.setRequiresRecomposition();
            return;
        }

        public override function set height(arg1:Number):void
        {
            this._hitArea.height = arg1 / (scaleY || 1);
            this.setRequiresRecomposition();
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            if (arg1 == null) 
            {
                arg1 = "";
            }
            if (this._text != arg1) 
            {
                this._text = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get format():starling.text.TextFormat
        {
            return this._format;
        }

        public function set format(arg1:starling.text.TextFormat):void
        {
            if (arg1 == null) 
            {
                throw new ArgumentError("format cannot be null");
            }
            this._format.copyFrom(arg1);
            return;
        }

        public function get border():Boolean
        {
            return !(this._border == null);
        }

        public function set border(arg1:Boolean):void
        {
            var loc1:*=0;
            if (arg1 && this._border == null) 
            {
                this._border = new starling.display.Sprite();
                addChild(this._border);
                loc1 = 0;
                while (loc1 < 4) 
                {
                    this._border.addChild(new starling.display.Quad(1, 1));
                    ++loc1;
                }
                this.updateBorder();
            }
            else if (!arg1 && !(this._border == null)) 
            {
                this._border.removeFromParent(true);
                this._border = null;
            }
            return;
        }

        public function get autoScale():Boolean
        {
            return this._options.autoScale;
        }

        public function set autoScale(arg1:Boolean):void
        {
            if (this._options.autoScale != arg1) 
            {
                this._options.autoScale = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get autoSize():String
        {
            return this._options.autoSize;
        }

        public function set autoSize(arg1:String):void
        {
            if (this._options.autoSize != arg1) 
            {
                this._options.autoSize = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get wordWrap():Boolean
        {
            return this._options.wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            if (arg1 != this._options.wordWrap) 
            {
                this._options.wordWrap = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get batchable():Boolean
        {
            return this._meshBatch.batchable;
        }

        public function set batchable(arg1:Boolean):void
        {
            this._meshBatch.batchable = arg1;
            return;
        }

        public function get isHtmlText():Boolean
        {
            return this._options.isHtmlText;
        }

        public function set isHtmlText(arg1:Boolean):void
        {
            if (this._options.isHtmlText != arg1) 
            {
                this._options.isHtmlText = arg1;
                this.setRequiresRecomposition();
            }
            return;
        }

        public function get pixelSnapping():Boolean
        {
            return this._meshBatch.pixelSnapping;
        }

        public function set pixelSnapping(arg1:Boolean):void
        {
            this._meshBatch.pixelSnapping = arg1;
            return;
        }

        public function get style():starling.styles.MeshStyle
        {
            return this._meshBatch.style;
        }

        public function set style(arg1:starling.styles.MeshStyle):void
        {
            var loc1:*;
            this._style = loc1 = arg1;
            this._meshBatch.style = loc1;
            this.setRequiresRecomposition();
            return;
        }

        public static function unregisterCompositor(arg1:String, arg2:Boolean=true):void
        {
            arg1 = convertToLowerCase(arg1);
            if (arg2 && !(compositors[arg1] == undefined)) 
            {
                compositors[arg1].dispose();
            }
            delete compositors[arg1];
            return;
        }

        public static function get defaultTextureFormat():String
        {
            return sDefaultTextureFormat;
        }

        public static function set defaultTextureFormat(arg1:String):void
        {
            sDefaultTextureFormat = arg1;
            return;
        }

        internal static const COMPOSITOR_DATA_NAME:String="starling.display.TextField.compositors";

        internal var _text:String;

        internal var _options:starling.text.TextOptions;

        internal var _format:starling.text.TextFormat;

        internal var _textBounds:flash.geom.Rectangle;

        internal var _hitArea:flash.geom.Rectangle;

        internal var _compositor:starling.text.ITextCompositor;

        internal var _requiresRecomposition:Boolean;

        internal var _meshBatch:starling.display.MeshBatch;

        internal var _style:starling.styles.MeshStyle;

        internal var _helperFormat:starling.text.TextFormat;

        internal var _border:starling.display.DisplayObjectContainer;

        internal static var sDefaultTextureFormat:String="bgraPacked4444";

        internal static var sStringCache:flash.utils.Dictionary;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sDefaultCompositor:starling.text.ITextCompositor;
    }
}


