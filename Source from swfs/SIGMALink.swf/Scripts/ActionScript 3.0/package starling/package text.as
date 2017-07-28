//package text
//  class BitmapChar
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


//  class BitmapFont
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

//  class ITextCompositor
package starling.text 
{
    import starling.display.*;
    
    public interface ITextCompositor
    {
        function fillMeshBatch(arg1:starling.display.MeshBatch, arg2:Number, arg3:Number, arg4:String, arg5:starling.text.TextFormat, arg6:starling.text.TextOptions=null):void;

        function clearMeshBatch(arg1:starling.display.MeshBatch):void;

        function dispose():void;
    }
}


//  class MiniBitmapFont
package starling.text 
{
    import flash.display.*;
    import flash.display3D.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.textures.*;
    
    internal class MiniBitmapFont extends Object
    {
        public function MiniBitmapFont()
        {
            super();
            return;
        }

        public static function get texture():starling.textures.Texture
        {
            var bitmapData:flash.display.BitmapData;
            var format:String;
            var texture:starling.textures.Texture;

            var loc1:*;
            bitmapData = null;
            texture = null;
            bitmapData = getBitmapData();
            format = flash.display3D.Context3DTextureFormat.BGRA_PACKED;
            texture = starling.textures.Texture.fromBitmapData(bitmapData, false, false, 1, format);
            bitmapData.dispose();
            bitmapData = null;
            texture.root.onRestore = function ():void
            {
                bitmapData = getBitmapData();
                texture.root.uploadBitmapData(bitmapData);
                bitmapData.dispose();
                bitmapData = null;
                return;
            }
            return texture;
        }

        internal static function getBitmapData():flash.display.BitmapData
        {
            var loc1:*=new flash.display.BitmapData(BITMAP_WIDTH, BITMAP_HEIGHT);
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=BITMAP_DATA.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc2.writeUnsignedInt(BITMAP_DATA[loc4]);
                ++loc4;
            }
            loc2.uncompress();
            loc1.setPixels(new flash.geom.Rectangle(0, 0, BITMAP_WIDTH, BITMAP_HEIGHT), loc2);
            loc2.clear();
            return loc1;
        }

        public static function get xml():XML
        {
            return XML_DATA;
        }

        internal static const BITMAP_WIDTH:int=128;

        internal static const BITMAP_HEIGHT:int=64;

        internal static const BITMAP_DATA:Array=[2027613533, 3413039936, 202148514, 2266925598, 4206886452, 4286853117, 2034947, 3202703399, 352977282, 2957757964, 3113652880, 2158068882, 1468709156, 2268063717, 2779310143, 2101025806, 3416509055, 4215794539, 3602168838, 1038056207, 1932393374, 3182285627, 3086802234, 1741291262, 2017257123, 3395280843, 984074419, 3049693147, 3986077023, 1055013549, 1806563255, 1754714962, 1577746187, 1124058786, 3888759258, 2482229043, 2916583666, 3743065328, 866060213, 1695195001, 2401582068, 3113347901, 2616521596, 1053798161, 2093370968, 4229025683, 560451479, 854767518, 2610241322, 4279041348, 4181572480, 4031244973, 587139110, 1081376765, 962217926, 783603325, 3605526425, 4102001916, 289204733, 2635140255, 3453981695, 3487854373, 2132197241, 3164775074, 4257640328, 770238970, 144664537, 707141570, 2934433071, 871272893, 512964596, 808491899, 481894297, 3095982481, 3598364156, 1710636358, 2904016319, 1751040139, 596966466, 1363963692, 465815609, 315567311, 4290666159, 4086022551, 179721458, 2221734970, 3942224988, 1519355876, 3292323782, 3933427230, 3314199893, 3736227348, 3846038425, 603088884, 2677349227, 3207069327, 3555275967, 3063054283, 3064577213, 3412044179, 693642210, 4280513949, 762928717, 1802215333, 3774849674, 4221155330, 970959395, 557220237, 2107226136, 3509822982, 3403284788, 4265820019, 898597576, 991077243, 2091615904, 3334716888, 633599866, 4218780109, 2216000376, 834870947, 2118009742, 1362731961, 236280636, 1274945142, 1458729366, 797960805, 3289369720, 2103717340, 3946406003, 2676522889, 1624104606, 1156993903, 3186170404, 2254499071, 1204911924, 1314218830, 3307086392, 2824275959, 3839865679, 2073394964, 1873329433, 1754205930, 1528429545, 1631106062, 2263272465, 4220497047, 3522893765, 3641376303, 707451487, 3452496787, 1390653868, 2620555793, 1027328684, 3419683476, 3662193703, 765701986, 3808279132, 786403271, 3824435837, 713234896, 4261856399, 3471930731, 3993492879, 1447960461, 1398434593, 1914230187, 2398643285, 4156374464, 3859339207, 3220700061, 3373248762, 3186030434, 1315917060, 2809852481, 4008553903, 4105611953, 1599499652, 3513857591, 877854499, 4198259455, 3648560077, 2838035419, 3255594190, 2465578457, 4263505201, 534904657, 2889261598, 1358214576, 1069250354, 3870010557, 2628896583, 3448610878, 442343309, 1024736866, 4015119133, 3250867279, 1513359261, 2442089596, 1944476762, 735490552, 426990058, 4234106111, 1204305707, 3330995265, 2398649368, 4221048123, 1724669255, 3801115709, 3489328790, 3896402933, 3696936939, 2836983295, 3656750393, 3349724512, 3810416287, 3654997608, 4284455103, 2294939563, 4207697932, 642748805, 2476981639, 2319419898, 572956615, 3833238940, 964924880, 2081600351, 3572458416, 2056247513, 1951368808, 2133449703, 2783728628, 512866577, 913279200, 1678129016, 3488578991, 3373952929, 2562996951, 3666058925, 1664169178, 1943591935, 750675303, 154399903, 2571590890, 852654952, 4117307766, 1971649621, 4180195820, 1222535348, 4283953215, 2880662236, 2717410980, 1175907705, 1157322027, 505963121, 2631540616, 3661227656, 3591803353, 2624126821, 1948662907, 3596065103, 1147387734, 256773959, 1173572460, 2361957471, 4210876076, 3080180620, 3464801210, 3821654259, 1465302035, 2851185457, 3143266144, 3793180414, 3368833103, 4274670712, 3473819108, 3487569332, 773123355, 1618635668, 2570176190, 2075248691, 1740805534, 288646743, 1837597401, 603556968, 3182536872, 673184603, 3088757053, 2897054404, 3192651316, 2885335802, 1057233368, 1118437241, 4182126463, 3110464775, 3313191614, 2360987274, 735505357, 2992631425, 2360928811, 4187834527, 279183208, 1586420003, 1174008423, 4062987589, 1162167621, 1162167621, 1162167621, 1162167621, 1174119799, 787274608];

        internal static const XML_DATA:XML=new XML("<font>\n          <info face=\"mini\" size=\"8\" bold=\"0\" italic=\"0\" smooth=\"0\"/>\n          <common lineHeight=\"8\" base=\"7\" scaleW=\"128\" scaleH=\"64\" pages=\"1\" packed=\"0\"/>\n          <chars count=\"191\">\n            <char id=\"195\" x=\"1\" y=\"1\" width=\"5\" height=\"9\" xoffset=\"0\" yoffset=\"-2\" xadvance=\"6\"/>\n            <char id=\"209\" x=\"7\" y=\"1\" width=\"5\" height=\"9\" xoffset=\"0\" yoffset=\"-2\" xadvance=\"6\"/>\n            <char id=\"213\" x=\"13\" y=\"1\" width=\"5\" height=\"9\" xoffset=\"0\" yoffset=\"-2\" xadvance=\"6\"/>\n            <char id=\"253\" x=\"19\" y=\"1\" width=\"4\" height=\"9\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"255\" x=\"24\" y=\"1\" width=\"4\" height=\"9\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"192\" x=\"29\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"193\" x=\"35\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"194\" x=\"41\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"197\" x=\"47\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"200\" x=\"53\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"201\" x=\"59\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"202\" x=\"65\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"210\" x=\"71\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"211\" x=\"77\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"212\" x=\"83\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"217\" x=\"89\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"218\" x=\"95\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"219\" x=\"101\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"221\" x=\"107\" y=\"1\" width=\"5\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"6\"/>\n            <char id=\"206\" x=\"113\" y=\"1\" width=\"3\" height=\"8\" xoffset=\"-1\" yoffset=\"-1\" xadvance=\"2\"/>\n            <char id=\"204\" x=\"117\" y=\"1\" width=\"2\" height=\"8\" xoffset=\"-1\" yoffset=\"-1\" xadvance=\"2\"/>\n            <char id=\"205\" x=\"120\" y=\"1\" width=\"2\" height=\"8\" xoffset=\"0\" yoffset=\"-1\" xadvance=\"2\"/>\n            <char id=\"36\" x=\"1\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"6\"/>\n            <char id=\"196\" x=\"7\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"6\"/>\n            <char id=\"199\" x=\"13\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"203\" x=\"19\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"6\"/>\n            <char id=\"214\" x=\"25\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"6\"/>\n            <char id=\"220\" x=\"31\" y=\"11\" width=\"5\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"6\"/>\n            <char id=\"224\" x=\"37\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"225\" x=\"42\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"226\" x=\"47\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"227\" x=\"52\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"232\" x=\"57\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"233\" x=\"62\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"234\" x=\"67\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"235\" x=\"72\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"241\" x=\"77\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"242\" x=\"82\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"243\" x=\"87\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"244\" x=\"92\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"245\" x=\"97\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"249\" x=\"102\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"250\" x=\"107\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"251\" x=\"112\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"0\" xadvance=\"5\"/>\n            <char id=\"254\" x=\"117\" y=\"11\" width=\"4\" height=\"7\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"123\" x=\"122\" y=\"11\" width=\"3\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"4\"/>\n            <char id=\"125\" x=\"1\" y=\"19\" width=\"3\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"4\"/>\n            <char id=\"167\" x=\"5\" y=\"19\" width=\"3\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"4\"/>\n            <char id=\"207\" x=\"9\" y=\"19\" width=\"3\" height=\"7\" xoffset=\"-1\" yoffset=\"0\" xadvance=\"2\"/>\n            <char id=\"106\" x=\"13\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"40\" x=\"16\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"3\"/>\n            <char id=\"41\" x=\"19\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"3\"/>\n            <char id=\"91\" x=\"22\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"3\"/>\n            <char id=\"93\" x=\"25\" y=\"19\" width=\"2\" height=\"7\" xoffset=\"0\" yoffset=\"1\" xadvance=\"3\"/>\n            <char id=\"124\" x=\"28\" y=\"19\" width=\"1\" height=\"7\" xoffset=\"1\" yoffset=\"1\" xadvance=\"4\"/>\n            <char id=\"81\" x=\"30\" y=\"19\" width=\"5\" height=\"6\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"163\" x=\"36\" y=\"19\" width=\"5\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"6\"/>\n            <char id=\"177\" x=\"42\" y=\"19\" width=\"5\" height=\"6\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"181\" x=\"48\" y=\"19\" width=\"5\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"6\"/>\n            <char id=\"103\" x=\"54\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"112\" x=\"59\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"113\" x=\"64\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"121\" x=\"69\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"162\" x=\"74\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"228\" x=\"79\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"229\" x=\"84\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"231\" x=\"89\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"240\" x=\"94\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"246\" x=\"99\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"252\" x=\"104\" y=\"19\" width=\"4\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"5\"/>\n            <char id=\"238\" x=\"109\" y=\"19\" width=\"3\" height=\"6\" xoffset=\"-1\" yoffset=\"1\" xadvance=\"2\"/>\n            <char id=\"59\" x=\"113\" y=\"19\" width=\"2\" height=\"6\" xoffset=\"0\" yoffset=\"3\" xadvance=\"4\"/>\n            <char id=\"236\" x=\"116\" y=\"19\" width=\"2\" height=\"6\" xoffset=\"-1\" yoffset=\"1\" xadvance=\"2\"/>\n            <char id=\"237\" x=\"119\" y=\"19\" width=\"2\" height=\"6\" xoffset=\"0\" yoffset=\"1\" xadvance=\"2\"/>\n            <char id=\"198\" x=\"1\" y=\"27\" width=\"9\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"10\"/>\n            <char id=\"190\" x=\"11\" y=\"27\" width=\"8\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"9\"/>\n            <char id=\"87\" x=\"20\" y=\"27\" width=\"7\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"8\"/>\n            <char id=\"188\" x=\"28\" y=\"27\" width=\"7\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"8\"/>\n            <char id=\"189\" x=\"36\" y=\"27\" width=\"7\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"8\"/>\n            <char id=\"38\" x=\"44\" y=\"27\" width=\"6\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"7\"/>\n            <char id=\"164\" x=\"51\" y=\"27\" width=\"6\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"7\"/>\n            <char id=\"208\" x=\"58\" y=\"27\" width=\"6\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"7\"/>\n            <char id=\"8364\" x=\"65\" y=\"27\" width=\"6\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"7\"/>\n            <char id=\"65\" x=\"72\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"66\" x=\"78\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"67\" x=\"84\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"68\" x=\"90\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"69\" x=\"96\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"70\" x=\"102\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"71\" x=\"108\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"72\" x=\"114\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"75\" x=\"120\" y=\"27\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"77\" x=\"1\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"78\" x=\"7\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"79\" x=\"13\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"80\" x=\"19\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"82\" x=\"25\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"83\" x=\"31\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"84\" x=\"37\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"85\" x=\"43\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"86\" x=\"49\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"88\" x=\"55\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"89\" x=\"61\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"90\" x=\"67\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"50\" x=\"73\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"51\" x=\"79\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"52\" x=\"85\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"53\" x=\"91\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"54\" x=\"97\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"56\" x=\"103\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"57\" x=\"109\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"48\" x=\"115\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"47\" x=\"121\" y=\"33\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"64\" x=\"1\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"92\" x=\"7\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"37\" x=\"13\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"43\" x=\"19\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"35\" x=\"25\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"42\" x=\"31\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"165\" x=\"37\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"169\" x=\"43\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"174\" x=\"49\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"182\" x=\"55\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"216\" x=\"61\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"247\" x=\"67\" y=\"39\" width=\"5\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"6\"/>\n            <char id=\"74\" x=\"73\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"76\" x=\"78\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"98\" x=\"83\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"100\" x=\"88\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"104\" x=\"93\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"107\" x=\"98\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"55\" x=\"103\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"63\" x=\"108\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"191\" x=\"113\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"222\" x=\"118\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"223\" x=\"123\" y=\"39\" width=\"4\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"116\" x=\"1\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"60\" x=\"5\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"62\" x=\"9\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"170\" x=\"13\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"186\" x=\"17\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"239\" x=\"21\" y=\"45\" width=\"3\" height=\"5\" xoffset=\"-1\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"102\" x=\"25\" y=\"45\" width=\"2\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"49\" x=\"28\" y=\"45\" width=\"2\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"73\" x=\"31\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"105\" x=\"33\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"108\" x=\"35\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"33\" x=\"37\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"1\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"161\" x=\"39\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"166\" x=\"41\" y=\"45\" width=\"1\" height=\"5\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"109\" x=\"43\" y=\"45\" width=\"7\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"8\"/>\n            <char id=\"119\" x=\"51\" y=\"45\" width=\"7\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"8\"/>\n            <char id=\"230\" x=\"59\" y=\"45\" width=\"7\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"8\"/>\n            <char id=\"97\" x=\"67\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"99\" x=\"72\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"101\" x=\"77\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"110\" x=\"82\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"111\" x=\"87\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"115\" x=\"92\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"117\" x=\"97\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"118\" x=\"102\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"120\" x=\"107\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"122\" x=\"112\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"215\" x=\"117\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"248\" x=\"122\" y=\"45\" width=\"4\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"114\" x=\"1\" y=\"51\" width=\"3\" height=\"4\" xoffset=\"0\" yoffset=\"3\" xadvance=\"4\"/>\n            <char id=\"178\" x=\"5\" y=\"51\" width=\"3\" height=\"4\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"179\" x=\"9\" y=\"51\" width=\"3\" height=\"4\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"185\" x=\"13\" y=\"51\" width=\"1\" height=\"4\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"61\" x=\"15\" y=\"51\" width=\"5\" height=\"3\" xoffset=\"0\" yoffset=\"3\" xadvance=\"6\"/>\n            <char id=\"171\" x=\"21\" y=\"51\" width=\"5\" height=\"3\" xoffset=\"0\" yoffset=\"3\" xadvance=\"6\"/>\n            <char id=\"172\" x=\"27\" y=\"51\" width=\"5\" height=\"3\" xoffset=\"0\" yoffset=\"4\" xadvance=\"6\"/>\n            <char id=\"187\" x=\"33\" y=\"51\" width=\"5\" height=\"3\" xoffset=\"0\" yoffset=\"3\" xadvance=\"6\"/>\n            <char id=\"176\" x=\"39\" y=\"51\" width=\"3\" height=\"3\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"44\" x=\"43\" y=\"51\" width=\"2\" height=\"3\" xoffset=\"0\" yoffset=\"6\" xadvance=\"3\"/>\n            <char id=\"58\" x=\"46\" y=\"51\" width=\"1\" height=\"3\" xoffset=\"1\" yoffset=\"3\" xadvance=\"4\"/>\n            <char id=\"94\" x=\"48\" y=\"51\" width=\"4\" height=\"2\" xoffset=\"-1\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"126\" x=\"53\" y=\"51\" width=\"4\" height=\"2\" xoffset=\"0\" yoffset=\"3\" xadvance=\"5\"/>\n            <char id=\"34\" x=\"58\" y=\"51\" width=\"3\" height=\"2\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"96\" x=\"62\" y=\"51\" width=\"2\" height=\"2\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"180\" x=\"65\" y=\"51\" width=\"2\" height=\"2\" xoffset=\"0\" yoffset=\"2\" xadvance=\"3\"/>\n            <char id=\"184\" x=\"68\" y=\"51\" width=\"2\" height=\"2\" xoffset=\"0\" yoffset=\"7\" xadvance=\"3\"/>\n            <char id=\"39\" x=\"71\" y=\"51\" width=\"1\" height=\"2\" xoffset=\"0\" yoffset=\"2\" xadvance=\"2\"/>\n            <char id=\"95\" x=\"73\" y=\"51\" width=\"5\" height=\"1\" xoffset=\"0\" yoffset=\"7\" xadvance=\"6\"/>\n            <char id=\"45\" x=\"79\" y=\"51\" width=\"4\" height=\"1\" xoffset=\"0\" yoffset=\"4\" xadvance=\"5\"/>\n            <char id=\"173\" x=\"84\" y=\"51\" width=\"4\" height=\"1\" xoffset=\"0\" yoffset=\"4\" xadvance=\"5\"/>\n            <char id=\"168\" x=\"89\" y=\"51\" width=\"3\" height=\"1\" xoffset=\"1\" yoffset=\"2\" xadvance=\"5\"/>\n            <char id=\"175\" x=\"93\" y=\"51\" width=\"3\" height=\"1\" xoffset=\"0\" yoffset=\"2\" xadvance=\"4\"/>\n            <char id=\"46\" x=\"97\" y=\"51\" width=\"1\" height=\"1\" xoffset=\"0\" yoffset=\"6\" xadvance=\"2\"/>\n            <char id=\"183\" x=\"99\" y=\"51\" width=\"1\" height=\"1\" xoffset=\"0\" yoffset=\"4\" xadvance=\"2\"/>\n            <char id=\"32\" x=\"6\" y=\"56\" width=\"0\" height=\"0\" xoffset=\"0\" yoffset=\"127\" xadvance=\"3\"/>\n          </chars>\n        </font>");
    }
}


//  class TextField
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


//  class TextFieldAutoSize
package starling.text 
{
    import starling.errors.*;
    
    public class TextFieldAutoSize extends Object
    {
        public function TextFieldAutoSize()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static const NONE:String="none";

        public static const HORIZONTAL:String="horizontal";

        public static const VERTICAL:String="vertical";

        public static const BOTH_DIRECTIONS:String="bothDirections";
    }
}


//  class TextFormat
package starling.text 
{
    import flash.text.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class TextFormat extends starling.events.EventDispatcher
    {
        public function TextFormat(arg1:String="Verdana", arg2:Number=12, arg3:uint=0, arg4:String="center", arg5:String="center")
        {
            super();
            this._font = arg1;
            this._size = arg2;
            this._color = arg3;
            this._horizontalAlign = arg4;
            this._verticalAlign = arg5;
            this._kerning = true;
            this._leading = 0;
            return;
        }

        public function get underline():Boolean
        {
            return this._underline;
        }

        public function set underline(arg1:Boolean):void
        {
            if (arg1 != this._underline) 
            {
                this._underline = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            if (!starling.utils.Align.isValidHorizontal(arg1)) 
            {
                throw new ArgumentError("Invalid horizontal alignment");
            }
            if (arg1 != this._horizontalAlign) 
            {
                this._horizontalAlign = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get verticalAlign():String
        {
            return this._verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            if (!starling.utils.Align.isValidVertical(arg1)) 
            {
                throw new ArgumentError("Invalid vertical alignment");
            }
            if (arg1 != this._verticalAlign) 
            {
                this._verticalAlign = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get kerning():Boolean
        {
            return this._kerning;
        }

        public function set kerning(arg1:Boolean):void
        {
            if (arg1 != this._kerning) 
            {
                this._kerning = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get leading():Number
        {
            return this._leading;
        }

        public function set leading(arg1:Number):void
        {
            if (arg1 != this._leading) 
            {
                this._leading = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function copyFrom(arg1:starling.text.TextFormat):void
        {
            this._font = arg1._font;
            this._size = arg1._size;
            this._color = arg1._color;
            this._bold = arg1._bold;
            this._italic = arg1._italic;
            this._underline = arg1._underline;
            this._horizontalAlign = arg1._horizontalAlign;
            this._verticalAlign = arg1._verticalAlign;
            this._kerning = arg1._kerning;
            this._leading = arg1._leading;
            dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function clone():starling.text.TextFormat
        {
            var loc1:*=new starling.text.TextFormat();
            loc1.copyFrom(this);
            return loc1;
        }

        public function setTo(arg1:String="Verdana", arg2:Number=12, arg3:uint=0, arg4:String="center", arg5:String="center"):void
        {
            this._font = arg1;
            this._size = arg2;
            this._color = arg3;
            this._horizontalAlign = arg4;
            this._verticalAlign = arg5;
            dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function toNativeFormat(arg1:flash.text.TextFormat=null):flash.text.TextFormat
        {
            if (arg1 == null) 
            {
                arg1 = new flash.text.TextFormat();
            }
            arg1.font = this._font;
            arg1.size = this._size;
            arg1.color = this._color;
            arg1.bold = this._bold;
            arg1.italic = this._italic;
            arg1.underline = this._underline;
            arg1.align = this._horizontalAlign;
            arg1.kerning = this._kerning;
            arg1.leading = this._leading;
            return arg1;
        }

        public function get font():String
        {
            return this._font;
        }

        public function set font(arg1:String):void
        {
            if (arg1 != this._font) 
            {
                this._font = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get size():Number
        {
            return this._size;
        }

        public function set size(arg1:Number):void
        {
            if (arg1 != this._size) 
            {
                this._size = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get color():uint
        {
            return this._color;
        }

        public function set color(arg1:uint):void
        {
            if (arg1 != this._color) 
            {
                this._color = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get bold():Boolean
        {
            return this._bold;
        }

        public function set bold(arg1:Boolean):void
        {
            if (arg1 != this._bold) 
            {
                this._bold = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get italic():Boolean
        {
            return this._italic;
        }

        public function set italic(arg1:Boolean):void
        {
            if (arg1 != this._italic) 
            {
                this._italic = arg1;
                dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        internal var _font:String;

        internal var _size:Number;

        internal var _color:uint;

        internal var _bold:Boolean;

        internal var _italic:Boolean;

        internal var _underline:Boolean;

        internal var _horizontalAlign:String;

        internal var _verticalAlign:String;

        internal var _kerning:Boolean;

        internal var _leading:Number;
    }
}


//  class TextOptions
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


//  class TrueTypeCompositor
package starling.text 
{
    import flash.geom.*;
    import flash.text.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class TrueTypeCompositor extends Object implements starling.text.ITextCompositor
    {
        public function TrueTypeCompositor()
        {
            super();
            return;
        }

        public function dispose():void
        {
            return;
        }

        public function fillMeshBatch(arg1:starling.display.MeshBatch, arg2:Number, arg3:Number, arg4:String, arg5:starling.text.TextFormat, arg6:starling.text.TextOptions=null):void
        {
            var meshBatch:starling.display.MeshBatch;
            var width:Number;
            var height:Number;
            var text:String;
            var format:starling.text.TextFormat;
            var options:starling.text.TextOptions=null;
            var texture:starling.textures.Texture;
            var textureFormat:String;
            var bitmapData:BitmapDataEx;

            var loc1:*;
            texture = null;
            bitmapData = null;
            meshBatch = arg1;
            width = arg2;
            height = arg3;
            text = arg4;
            format = arg5;
            options = arg6;
            if (text == null || text == "") 
            {
                return;
            }
            textureFormat = options.textureFormat;
            bitmapData = this.renderText(width, height, text, format, options);
            texture = starling.textures.Texture.fromBitmapData(bitmapData, false, false, bitmapData.scale, textureFormat);
            texture.root.onRestore = function ():void
            {
                bitmapData = renderText(width, height, text, format, options);
                texture.root.uploadBitmapData(bitmapData);
                bitmapData.dispose();
                bitmapData = null;
                return;
            }
            bitmapData.dispose();
            bitmapData = null;
            sHelperQuad.texture = texture;
            sHelperQuad.readjustSize();
            if (format.horizontalAlign != starling.utils.Align.LEFT) 
            {
                if (format.horizontalAlign != starling.utils.Align.CENTER) 
                {
                    sHelperQuad.x = width - texture.width;
                }
                else 
                {
                    sHelperQuad.x = int((width - texture.width) / 2);
                }
            }
            else 
            {
                sHelperQuad.x = 0;
            }
            if (format.verticalAlign != starling.utils.Align.TOP) 
            {
                if (format.verticalAlign != starling.utils.Align.CENTER) 
                {
                    sHelperQuad.y = height - texture.height;
                }
                else 
                {
                    sHelperQuad.y = int((height - texture.height) / 2);
                }
            }
            else 
            {
                sHelperQuad.y = 0;
            }
            meshBatch.addMesh(sHelperQuad);
            sHelperQuad.texture = null;
            return;
        }

        public function clearMeshBatch(arg1:starling.display.MeshBatch):void
        {
            arg1.clear();
            if (arg1.texture) 
            {
                arg1.texture.dispose();
            }
            return;
        }

        internal function renderText(arg1:Number, arg2:Number, arg3:String, arg4:starling.text.TextFormat, arg5:starling.text.TextOptions):BitmapDataEx
        {
            var loc11:*=null;
            var loc1:*=arg1 * arg5.textureScale;
            var loc2:*=arg2 * arg5.textureScale;
            var loc3:*=arg4.horizontalAlign;
            arg4.toNativeFormat(sNativeFormat);
            sNativeFormat.size = Number(sNativeFormat.size) * arg5.textureScale;
            sNativeTextField.embedFonts = starling.utils.SystemUtil.isEmbeddedFont(arg4.font, arg4.bold, arg4.italic);
            sNativeTextField.defaultTextFormat = sNativeFormat;
            sNativeTextField.width = loc1;
            sNativeTextField.height = loc2;
            sNativeTextField.antiAliasType = flash.text.AntiAliasType.ADVANCED;
            sNativeTextField.selectable = false;
            sNativeTextField.multiline = true;
            sNativeTextField.wordWrap = arg5.wordWrap;
            if (arg5.isHtmlText) 
            {
                sNativeTextField.htmlText = arg3;
            }
            else 
            {
                sNativeTextField.text = arg3;
            }
            if (arg5.autoScale) 
            {
                this.autoScaleNativeTextField(sNativeTextField, arg3, arg5.isHtmlText);
            }
            var loc4:*=sNativeTextField.textWidth;
            var loc5:*=sNativeTextField.textHeight;
            var loc6:*=Math.ceil(loc4) + 4;
            var loc7:*=Math.ceil(loc5) + 4;
            var loc8:*=starling.textures.Texture.maxSize;
            var loc9:*=1;
            var loc10:*=0;
            if (arg5.isHtmlText) 
            {
                var loc12:*;
                loc6 = loc12 = loc1;
                loc4 = loc12;
            }
            if (loc6 < loc9) 
            {
                loc6 = 1;
            }
            if (loc7 < loc9) 
            {
                loc7 = 1;
            }
            if (loc7 > loc8 || loc6 > loc8) 
            {
                arg5.textureScale = arg5.textureScale * loc8 / Math.max(loc6, loc7);
                return this.renderText(arg1, arg2, arg3, arg4, arg5);
            }
            if (!arg5.isHtmlText) 
            {
                if (loc3 != starling.utils.Align.RIGHT) 
                {
                    if (loc3 == starling.utils.Align.CENTER) 
                    {
                        loc10 = (loc1 - loc4 - 4) / 2;
                    }
                }
                else 
                {
                    loc10 = loc1 - loc4 - 4;
                }
            }
            loc11 = new BitmapDataEx(loc6, loc7);
            sHelperMatrix.setTo(1, 0, 0, 1, -loc10, 0);
            loc11.draw(sNativeTextField, sHelperMatrix);
            loc11.scale = arg5.textureScale;
            sNativeTextField.text = "";
            return loc11;
        }

        internal function autoScaleNativeTextField(arg1:flash.text.TextField, arg2:String, arg3:Boolean):void
        {
            var loc1:*=arg1.defaultTextFormat;
            var loc2:*=arg1.width - 4;
            var loc3:*=arg1.height - 4;
            var loc4:*=Number(loc1.size);
            while (arg1.textWidth > loc2 || arg1.textHeight > loc3) 
            {
                if (loc4 <= 4) 
                {
                    break;
                }
                loc1.size = loc4--;
                arg1.defaultTextFormat = loc1;
                if (arg3) 
                {
                    arg1.htmlText = arg2;
                    continue;
                }
                arg1.text = arg2;
            }
            return;
        }

        
        {
            sHelperMatrix = new flash.geom.Matrix();
            sHelperQuad = new starling.display.Quad(100, 100);
            sNativeTextField = new flash.text.TextField();
            sNativeFormat = new flash.text.TextFormat();
        }

        internal static var sHelperMatrix:flash.geom.Matrix;

        internal static var sHelperQuad:starling.display.Quad;

        internal static var sNativeTextField:flash.text.TextField;

        internal static var sNativeFormat:flash.text.TextFormat;
    }
}

import flash.display.*;


class BitmapDataEx extends flash.display.BitmapData
{
    public function BitmapDataEx(arg1:int, arg2:int, arg3:Boolean=true, arg4:uint=0)
    {
        super(arg1, arg2, arg3, arg4);
        return;
    }

    public function get scale():Number
    {
        return this._scale;
    }

    public function set scale(arg1:Number):void
    {
        this._scale = arg1;
        return;
    }

    internal var _scale:Number=1;
}

