//class BitmapFont
package starling.text 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class BitmapFont extends Object implements starling.text.ITextCompositor
    {
        public function BitmapFont(arg1:starling.textures.Texture=null, arg2:XML=null)
        {
            super();
            if (arg1 == null && arg2 == null) 
            {
                arg1 = MiniBitmapFont.texture;
                arg2 = MiniBitmapFont.xml;
            }
            else if (arg1 == null || arg2 == null) 
            {
                throw new ArgumentError("Set both of the \'texture\' and \'fontXml\' arguments to valid objects or leave both of them null.");
            }
            this._name = "unknown";
            var loc1:*;
            this._baseline = loc1 = 14;
            this._size = loc1 = loc1;
            this._lineHeight = loc1;
            this._padding = loc1 = 0;
            this._offsetY = loc1 = loc1;
            this._offsetX = loc1;
            this._texture = arg1;
            this._chars = new flash.utils.Dictionary();
            this._helperImage = new starling.display.Image(arg1);
            this.parseFontXml(arg2);
            return;
        }

        public function get baseline():Number
        {
            return this._baseline;
        }

        public function set baseline(arg1:Number):void
        {
            this._baseline = arg1;
            return;
        }

        public function get offsetX():Number
        {
            return this._offsetX;
        }

        public function set offsetX(arg1:Number):void
        {
            this._offsetX = arg1;
            return;
        }

        public function get size():Number
        {
            return this._size;
        }

        public function get offsetY():Number
        {
            return this._offsetY;
        }

        public function set offsetY(arg1:Number):void
        {
            this._offsetY = arg1;
            return;
        }

        public function get padding():Number
        {
            return this._padding;
        }

        public function set padding(arg1:Number):void
        {
            this._padding = arg1;
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._texture;
        }

        public function dispose():void
        {
            if (this._texture) 
            {
                this._texture.dispose();
            }
            return;
        }

        internal function parseFontXml(arg1:XML):void
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=0;
            var loc15:*=0;
            var loc16:*=NaN;
            var loc1:*=this._texture.scale;
            var loc2:*=this._texture.frame;
            var loc3:*=loc2 ? loc2.x : 0;
            var loc4:*=loc2 ? loc2.y : 0;
            this._name = starling.utils.StringUtil.clean(arg1.info.@face);
            this._size = parseFloat(arg1.info.@size) / loc1;
            this._lineHeight = parseFloat(arg1.common.@lineHeight) / loc1;
            this._baseline = parseFloat(arg1.common.@base) / loc1;
            if (arg1.info.@smooth.toString() == "0") 
            {
                this.smoothing = starling.textures.TextureSmoothing.NONE;
            }
            if (this._size <= 0) 
            {
                trace("[Starling] Warning: invalid font size in \'" + this._name + "\' font.");
                this._size = this._size != 0 ? this._size * -1 : 16;
            }
            var loc17:*=0;
            var loc18:*=arg1.chars.char;
            for each (loc5 in loc18) 
            {
                loc7 = parseInt(loc5.@id);
                loc8 = parseFloat(loc5.@xoffset) / loc1;
                loc9 = parseFloat(loc5.@yoffset) / loc1;
                loc10 = parseFloat(loc5.@xadvance) / loc1;
                loc11 = new flash.geom.Rectangle();
                loc11.x = parseFloat(loc5.@x) / loc1 + loc3;
                loc11.y = parseFloat(loc5.@y) / loc1 + loc4;
                loc11.width = parseFloat(loc5.@width) / loc1;
                loc11.height = parseFloat(loc5.@height) / loc1;
                loc12 = starling.textures.Texture.fromTexture(this._texture, loc11);
                loc13 = new starling.text.BitmapChar(loc7, loc12, loc8, loc9, loc10);
                this.addChar(loc7, loc13);
            }
            loc17 = 0;
            loc18 = arg1.kernings.kerning;
            for each (loc6 in loc18) 
            {
                loc14 = parseInt(loc6.@first);
                loc15 = parseInt(loc6.@second);
                loc16 = parseFloat(loc6.@amount) / loc1;
                if (!(loc15 in this._chars)) 
                {
                    continue;
                }
                this.getChar(loc15).addKerning(loc14, loc16);
            }
            return;
        }

        public function getChar(arg1:int):starling.text.BitmapChar
        {
            return this._chars[arg1];
        }

        public function addChar(arg1:int, arg2:starling.text.BitmapChar):void
        {
            this._chars[arg1] = arg2;
            return;
        }

        public function getCharIDs(arg1:__AS3__.vec.Vector.<int>=null):__AS3__.vec.Vector.<int>
        {
            var loc1:*=undefined;
            if (arg1 == null) 
            {
                arg1 = new Vector.<int>(0);
            }
            var loc2:*=0;
            var loc3:*=this._chars;
            for (loc1 in loc3) 
            {
                arg1[arg1.length] = int(loc1);
            }
            return arg1;
        }

        public function hasChars(arg1:String):Boolean
        {
            var loc1:*=0;
            if (arg1 == null) 
            {
                return true;
            }
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = arg1.charCodeAt(loc3);
                if (!(loc1 == CHAR_SPACE) && !(loc1 == CHAR_TAB) && !(loc1 == CHAR_NEWLINE) && !(loc1 == CHAR_CARRIAGE_RETURN) && this.getChar(loc1) == null) 
                {
                    return false;
                }
                ++loc3;
            }
            return true;
        }

        public function createSprite(arg1:Number, arg2:Number, arg3:String, arg4:starling.text.TextFormat, arg5:starling.text.TextOptions=null):starling.display.Sprite
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=this.arrangeChars(arg1, arg2, arg3, arg4, arg5);
            var loc2:*=loc1.length;
            var loc3:*=this.smoothing;
            var loc4:*=new starling.display.Sprite();
            var loc5:*=0;
            while (loc5 < loc2) 
            {
                loc6 = loc1[loc5];
                loc7 = loc6.char.createImage();
                loc7.x = loc6.x;
                loc7.y = loc6.y;
                loc7.scale = loc6.scale;
                loc7.color = arg4.color;
                loc7.textureSmoothing = loc3;
                loc4.addChild(loc7);
                ++loc5;
            }
            CharLocation.rechargePool();
            return loc4;
        }

        public function fillMeshBatch(arg1:starling.display.MeshBatch, arg2:Number, arg3:Number, arg4:String, arg5:starling.text.TextFormat, arg6:starling.text.TextOptions=null):void
        {
            var loc4:*=null;
            var loc1:*=this.arrangeChars(arg2, arg3, arg4, arg5, arg6);
            var loc2:*=loc1.length;
            this._helperImage.color = arg5.color;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                this._helperImage.texture = loc4.char.texture;
                this._helperImage.readjustSize();
                this._helperImage.x = loc4.x;
                this._helperImage.y = loc4.y;
                this._helperImage.scale = loc4.scale;
                arg1.addMesh(this._helperImage);
                ++loc3;
            }
            CharLocation.rechargePool();
            return;
        }

        public function clearMeshBatch(arg1:starling.display.MeshBatch):void
        {
            arg1.clear();
            return;
        }

        internal function arrangeChars(arg1:Number, arg2:Number, arg3:String, arg4:starling.text.TextFormat, arg5:starling.text.TextOptions):__AS3__.vec.Vector.<CharLocation>
        {
            var loc9:*=null;
            var loc10:*=0;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=0;
            var loc15:*=0;
            var loc21:*=0;
            var loc22:*=0;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=null;
            var loc26:*=false;
            var loc27:*=0;
            var loc28:*=null;
            var loc29:*=0;
            var loc30:*=null;
            var loc31:*=0;
            var loc32:*=null;
            var loc33:*=NaN;
            var loc34:*=0;
            if (arg3 == null || arg3.length == 0) 
            {
                return CharLocation.vectorFromPool();
            }
            if (arg5 == null) 
            {
                arg5 = sDefaultOptions;
            }
            var loc1:*=arg4.kerning;
            var loc2:*=arg4.leading;
            var loc3:*=arg4.horizontalAlign;
            var loc4:*=arg4.verticalAlign;
            var loc5:*=arg4.size;
            var loc6:*=arg5.autoScale;
            var loc7:*=arg5.wordWrap;
            var loc8:*=false;
            if (loc5 < 0) 
            {
                loc5 = loc5 * (-this._size);
            }
            while (!loc8) 
            {
                sLines.length = 0;
                loc13 = loc5 / this._size;
                loc11 = (arg1 - 2 * this._padding) / loc13;
                loc12 = (arg2 - 2 * this._padding) / loc13;
                if (this._lineHeight <= loc12) 
                {
                    loc21 = -1;
                    loc22 = -1;
                    loc23 = 0;
                    loc24 = 0;
                    loc25 = CharLocation.vectorFromPool();
                    loc10 = arg3.length;
                    loc14 = 0;
                    while (loc14 < loc10) 
                    {
                        loc26 = false;
                        loc27 = arg3.charCodeAt(loc14);
                        loc28 = this.getChar(loc27);
                        if (loc27 == CHAR_NEWLINE || loc27 == CHAR_CARRIAGE_RETURN) 
                        {
                            loc26 = true;
                        }
                        else if (loc28 != null) 
                        {
                            if (loc27 == CHAR_SPACE || loc27 == CHAR_TAB) 
                            {
                                loc21 = loc14;
                            }
                            if (loc1) 
                            {
                                loc23 = loc23 + loc28.getKerning(loc22);
                            }
                            loc9 = CharLocation.instanceFromPool(loc28);
                            loc9.x = loc23 + loc28.xOffset;
                            loc9.y = loc24 + loc28.yOffset;
                            loc25[loc25.length] = loc9;
                            loc23 = loc23 + loc28.xAdvance;
                            loc22 = loc27;
                            if (loc9.x + loc28.width > loc11) 
                            {
                                if (loc7) 
                                {
                                    if (!(loc6 && loc21 == -1)) 
                                    {
                                    };
                                    loc29 = loc21 != -1 ? loc14 - loc21 : 1;
                                    loc15 = 0;
                                    while (loc15 < loc29) 
                                    {
                                        loc25.pop();
                                        ++loc15;
                                    }
                                    if (loc25.length != 0) 
                                    {
                                    };
                                    loc14 = loc14 - loc29;
                                }
                                else 
                                {
                                    if (!loc6) 
                                    {
                                    };
                                    loc25.pop();
                                    while (loc14 < (loc10 - 1) && !(arg3.charCodeAt(loc14) == CHAR_NEWLINE)) 
                                    {
                                        ++loc14;
                                    }
                                }
                                loc26 = true;
                            }
                        }
                        else 
                        {
                            trace("[Starling] Font: " + this.name + " missing character: " + arg3.charAt(loc14) + " id: " + loc27);
                        }
                        if (loc14 != (loc10 - 1)) 
                        {
                            if (loc26) 
                            {
                                sLines[sLines.length] = loc25;
                                if (loc21 == loc14) 
                                {
                                    loc25.pop();
                                }
                                if (loc24 + loc2 + 2 * this._lineHeight <= loc12) 
                                {
                                    loc25 = CharLocation.vectorFromPool();
                                    loc23 = 0;
                                    loc24 = loc24 + (this._lineHeight + loc2);
                                    loc21 = -1;
                                    loc22 = -1;
                                }
                            }
                        }
                        else 
                        {
                            sLines[sLines.length] = loc25;
                            loc8 = true;
                        }
                        ++loc14;
                    }
                }
                if (loc6 && !loc8 && loc5 > 3) 
                {
                    --loc5;
                    continue;
                }
                loc8 = true;
            }
            var loc16:*=CharLocation.vectorFromPool();
            var loc17:*=sLines.length;
            var loc18:*=loc24 + this._lineHeight;
            var loc19:*=0;
            if (loc4 != starling.utils.Align.BOTTOM) 
            {
                if (loc4 == starling.utils.Align.CENTER) 
                {
                    loc19 = (loc12 - loc18) / 2;
                }
            }
            else 
            {
                loc19 = loc12 - loc18;
            }
            var loc20:*=0;
            while (loc20 < loc17) 
            {
                loc30 = sLines[loc20];
                loc10 = loc30.length;
                if (loc10 != 0) 
                {
                    loc31 = 0;
                    loc32 = loc30[(loc30.length - 1)];
                    loc33 = loc32.x - loc32.char.xOffset + loc32.char.xAdvance;
                    if (loc3 != starling.utils.Align.RIGHT) 
                    {
                        if (loc3 == starling.utils.Align.CENTER) 
                        {
                            loc31 = (loc11 - loc33) / 2;
                        }
                    }
                    else 
                    {
                        loc31 = loc11 - loc33;
                    }
                    loc34 = 0;
                    while (loc34 < loc10) 
                    {
                        loc9 = loc30[loc34];
                        loc9.x = loc13 * (loc9.x + loc31 + this._offsetX) + this._padding;
                        loc9.y = loc13 * (loc9.y + loc19 + this._offsetY) + this._padding;
                        loc9.scale = loc13;
                        if (loc9.char.width > 0 && loc9.char.height > 0) 
                        {
                            loc16[loc16.length] = loc9;
                        }
                        ++loc34;
                    }
                }
                ++loc20;
            }
            return loc16;
        }

        public function get name():String
        {
            return this._name;
        }

        
        {
            sLines = [];
            sDefaultOptions = new starling.text.TextOptions();
        }

        public function get lineHeight():Number
        {
            return this._lineHeight;
        }

        public function set lineHeight(arg1:Number):void
        {
            this._lineHeight = arg1;
            return;
        }

        public function get smoothing():String
        {
            return this._helperImage.textureSmoothing;
        }

        public function set smoothing(arg1:String):void
        {
            this._helperImage.textureSmoothing = arg1;
            return;
        }

        public static const NATIVE_SIZE:int=-1;

        public static const MINI:String="mini";

        internal static const CHAR_SPACE:int=32;

        internal static const CHAR_NEWLINE:int=10;

        internal static const CHAR_CARRIAGE_RETURN:int=13;

        internal static const CHAR_TAB:int=9;

        internal var _texture:starling.textures.Texture;

        internal var _chars:flash.utils.Dictionary;

        internal var _name:String;

        internal var _size:Number;

        internal var _baseline:Number;

        internal var _offsetX:Number;

        internal var _offsetY:Number;

        internal var _padding:Number;

        internal var _helperImage:starling.display.Image;

        internal var _lineHeight:Number;

        internal static var sLines:Array;

        internal static var sDefaultOptions:starling.text.TextOptions;
    }
}

import __AS3__.vec.*;


class CharLocation extends Object
{
    public function CharLocation(arg1:starling.text.BitmapChar)
    {
        super();
        this.reset(arg1);
        return;
    }

    internal function reset(arg1:starling.text.BitmapChar):CharLocation
    {
        this.char = arg1;
        return this;
    }

    public static function instanceFromPool(arg1:starling.text.BitmapChar):CharLocation
    {
        var loc1:*=sInstancePool.length > 0 ? sInstancePool.pop() : new CharLocation(arg1);
        loc1.reset(arg1);
        sInstanceLoan[sInstanceLoan.length] = loc1;
        return loc1;
    }

    public static function vectorFromPool():__AS3__.vec.Vector.<CharLocation>
    {
        var loc1:*=sVectorPool.length > 0 ? sVectorPool.pop() : new Vector.<CharLocation>(0);
        loc1.length = 0;
        sVectorLoan[sVectorLoan.length] = loc1;
        return loc1;
    }

    public static function rechargePool():void
    {
        var loc1:*=null;
        var loc2:*=null;
        while (sInstanceLoan.length > 0) 
        {
            loc1 = sInstanceLoan.pop();
            loc1.char = null;
            sInstancePool[sInstancePool.length] = loc1;
        }
        while (sVectorLoan.length > 0) 
        {
            loc2 = sVectorLoan.pop();
            loc2.length = 0;
            sVectorPool[sVectorPool.length] = loc2;
        }
        return;
    }

    
    {
        sInstancePool = new Vector.<>(0);
        sVectorPool = [];
        sInstanceLoan = new Vector.<>(0);
        sVectorLoan = [];
    }

    public var char:starling.text.BitmapChar;

    public var scale:Number;

    public var x:Number;

    public var y:Number;

    internal static var sInstancePool:__AS3__.vec.Vector.<CharLocation>;

    internal static var sVectorPool:Array;

    internal static var sInstanceLoan:__AS3__.vec.Vector.<CharLocation>;

    internal static var sVectorLoan:Array;
}

