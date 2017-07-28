//class Image
package starling.display 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.rendering.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class Image extends starling.display.Quad
    {
        public function Image(arg1:starling.textures.Texture)
        {
            super(100, 100);
            this.texture = arg1;
            readjustSize();
            return;
        }

        public function get scale9Grid():flash.geom.Rectangle
        {
            return this._scale9Grid;
        }

        public function set scale9Grid(arg1:flash.geom.Rectangle):void
        {
            if (arg1) 
            {
                if (this._scale9Grid != null) 
                {
                    this._scale9Grid.copyFrom(arg1);
                }
                else 
                {
                    this._scale9Grid = arg1.clone();
                }
                readjustSize();
                this._tileGrid = null;
            }
            else 
            {
                this._scale9Grid = null;
            }
            this.setupVertices();
            return;
        }

        public function get tileGrid():flash.geom.Rectangle
        {
            return this._tileGrid;
        }

        public function set tileGrid(arg1:flash.geom.Rectangle):void
        {
            if (arg1) 
            {
                if (this._tileGrid != null) 
                {
                    this._tileGrid.copyFrom(arg1);
                }
                else 
                {
                    this._tileGrid = arg1.clone();
                }
                this._scale9Grid = null;
            }
            else 
            {
                this._tileGrid = null;
            }
            this.setupVertices();
            return;
        }

        protected override function setupVertices():void
        {
            if (texture && this._scale9Grid) 
            {
                this.setupScale9Grid();
            }
            else if (texture && this._tileGrid) 
            {
                this.setupTileGrid();
            }
            else 
            {
                super.setupVertices();
            }
            return;
        }

        public override function set scaleX(arg1:Number):void
        {
            super.scaleX = arg1;
            if (texture && (this._scale9Grid || this._tileGrid)) 
            {
                this.setupVertices();
            }
            return;
        }

        public override function set scaleY(arg1:Number):void
        {
            super.scaleY = arg1;
            if (texture && (this._scale9Grid || this._tileGrid)) 
            {
                this.setupVertices();
            }
            return;
        }

        public override function set texture(arg1:starling.textures.Texture):void
        {
            if (arg1 != texture) 
            {
                super.texture = arg1;
                if (this._scale9Grid && arg1) 
                {
                    readjustSize();
                }
            }
            return;
        }

        internal function setupScale9Grid():void
        {
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=NaN;
            var loc18:*=0;
            var loc19:*=NaN;
            var loc1:*=this.texture;
            var loc2:*=loc1.frame;
            var loc3:*=scaleX > 0 ? scaleX : -scaleX;
            var loc4:*=scaleY > 0 ? scaleY : -scaleY;
            if (starling.utils.MathUtil.isEquivalent(this._scale9Grid.width, loc1.frameWidth)) 
            {
                loc4 = loc4 / loc3;
            }
            else if (starling.utils.MathUtil.isEquivalent(this._scale9Grid.height, loc1.frameHeight)) 
            {
                loc3 = loc3 / loc4;
            }
            var loc5:*=1 / loc3;
            var loc6:*=1 / loc4;
            var loc7:*=this.vertexData;
            var loc8:*=this.indexData;
            var loc9:*=loc7.numVertices;
            var loc13:*=starling.utils.Pool.getRectangle();
            var loc14:*=starling.utils.Pool.getRectangle();
            var loc15:*=starling.utils.Pool.getRectangle();
            var loc16:*=starling.utils.Pool.getRectangle();
            loc13.copyFrom(this._scale9Grid);
            loc14.setTo(0, 0, loc1.frameWidth, loc1.frameHeight);
            if (loc2) 
            {
                loc15.setTo(-loc2.x, -loc2.y, loc1.width, loc1.height);
            }
            else 
            {
                loc15.copyFrom(loc14);
            }
            starling.utils.RectangleUtil.intersect(loc13, loc15, loc16);
            var loc20:*;
            sBasCols[2] = loc20 = 0;
            sBasCols[0] = loc20;
            sBasRows[2] = loc20 = 0;
            sBasRows[0] = loc20;
            sBasCols[1] = loc16.width;
            sBasRows[1] = loc16.height;
            if (loc15.x < loc13.x) 
            {
                sBasCols[0] = loc13.x - loc15.x;
            }
            if (loc15.y < loc13.y) 
            {
                sBasRows[0] = loc13.y - loc15.y;
            }
            if (loc15.right > loc13.right) 
            {
                sBasCols[2] = loc15.right - loc13.right;
            }
            if (loc15.bottom > loc13.bottom) 
            {
                sBasRows[2] = loc15.bottom - loc13.bottom;
            }
            if (loc15.x < loc13.x) 
            {
                sPadding.left = loc15.x * loc5;
            }
            else 
            {
                sPadding.left = loc13.x * loc5 + loc15.x - loc13.x;
            }
            if (loc15.right > loc13.right) 
            {
                sPadding.right = (loc14.width - loc15.right) * loc5;
            }
            else 
            {
                sPadding.right = (loc14.width - loc13.right) * loc5 + loc13.right - loc15.right;
            }
            if (loc15.y < loc13.y) 
            {
                sPadding.top = loc15.y * loc6;
            }
            else 
            {
                sPadding.top = loc13.y * loc6 + loc15.y - loc13.y;
            }
            if (loc15.bottom > loc13.bottom) 
            {
                sPadding.bottom = (loc14.height - loc15.bottom) * loc6;
            }
            else 
            {
                sPadding.bottom = (loc14.height - loc13.bottom) * loc6 + loc13.bottom - loc15.bottom;
            }
            sPosCols[0] = sBasCols[0] * loc5;
            sPosCols[2] = sBasCols[2] * loc5;
            sPosCols[1] = loc14.width - sPadding.left - sPadding.right - sPosCols[0] - sPosCols[2];
            sPosRows[0] = sBasRows[0] * loc6;
            sPosRows[2] = sBasRows[2] * loc6;
            sPosRows[1] = loc14.height - sPadding.top - sPadding.bottom - sPosRows[0] - sPosRows[2];
            if (sPosCols[1] <= 0) 
            {
                loc12 = loc14.width / (loc14.width - loc13.width) * loc3;
                sPadding.left = sPadding.left * loc12;
                sPosCols[0] = sPosCols[0] * loc12;
                sPosCols[1] = 0;
                sPosCols[2] = sPosCols[2] * loc12;
            }
            if (sPosRows[1] <= 0) 
            {
                loc12 = loc14.height / (loc14.height - loc13.height) * loc4;
                sPadding.top = sPadding.top * loc12;
                sPosRows[0] = sPosRows[0] * loc12;
                sPosRows[1] = 0;
                sPosRows[2] = sPosRows[2] * loc12;
            }
            sTexCols[0] = sBasCols[0] / loc15.width;
            sTexCols[2] = sBasCols[2] / loc15.width;
            sTexCols[1] = 1 - sTexCols[0] - sTexCols[2];
            sTexRows[0] = sBasRows[0] / loc15.height;
            sTexRows[2] = sBasRows[2] / loc15.height;
            sTexRows[1] = 1 - sTexRows[0] - sTexRows[2];
            loc10 = this.setupScale9GridAttributes(sPadding.left, sPadding.top, sPosCols, sPosRows, sTexCols, sTexRows);
            loc11 = loc10 / 4;
            loc7.numVertices = loc10;
            loc8.numIndices = 0;
            var loc17:*=0;
            while (loc17 < loc11) 
            {
                loc8.addQuad(loc17 * 4, loc17 * 4 + 1, loc17 * 4 + 2, loc17 * 4 + 3);
                ++loc17;
            }
            if (loc10 != loc9) 
            {
                loc18 = loc9 ? loc7.getColor(0) : 16777215;
                loc19 = loc9 ? loc7.getAlpha(0) : 1;
                loc7.colorize("color", loc18, loc19);
            }
            starling.utils.Pool.putRectangle(loc14);
            starling.utils.Pool.putRectangle(loc15);
            starling.utils.Pool.putRectangle(loc13);
            starling.utils.Pool.putRectangle(loc16);
            setRequiresRedraw();
            return;
        }

        internal function setupScale9GridAttributes(arg1:Number, arg2:Number, arg3:__AS3__.vec.Vector.<Number>, arg4:__AS3__.vec.Vector.<Number>, arg5:__AS3__.vec.Vector.<Number>, arg6:__AS3__.vec.Vector.<Number>):int
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc1:*="position";
            var loc2:*="texCoords";
            var loc9:*=this.vertexData;
            var loc10:*=this.texture;
            var loc11:*=arg1;
            var loc12:*=arg2;
            var loc13:*=0;
            var loc14:*=0;
            var loc15:*=0;
            loc3 = 0;
            while (loc3 < 3) 
            {
                loc6 = arg4[loc3];
                loc8 = arg6[loc3];
                if (loc6 > 0) 
                {
                    loc4 = 0;
                    while (loc4 < 3) 
                    {
                        loc5 = arg3[loc4];
                        loc7 = arg5[loc4];
                        if (loc5 > 0) 
                        {
                            loc9.setPoint(loc15, loc1, loc11, loc12);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13, loc14);
                            ++loc15;
                            loc9.setPoint(loc15, loc1, loc11 + loc5, loc12);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13 + loc7, loc14);
                            ++loc15;
                            loc9.setPoint(loc15, loc1, loc11, loc12 + loc6);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13, loc14 + loc8);
                            ++loc15;
                            loc9.setPoint(loc15, loc1, loc11 + loc5, loc12 + loc6);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13 + loc7, loc14 + loc8);
                            ++loc15;
                            loc11 = loc11 + loc5;
                        }
                        loc13 = loc13 + loc7;
                        ++loc4;
                    }
                    loc12 = loc12 + loc6;
                }
                loc11 = arg1;
                loc13 = 0;
                loc14 = loc14 + loc8;
                ++loc3;
            }
            return loc15;
        }

        internal function setupTileGrid():void
        {
            var loc21:*=NaN;
            var loc22:*=NaN;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=NaN;
            var loc26:*=NaN;
            var loc27:*=NaN;
            var loc28:*=NaN;
            var loc31:*=NaN;
            var loc1:*=this.texture;
            var loc2:*=loc1.frame;
            var loc3:*=this.vertexData;
            var loc4:*=this.indexData;
            var loc5:*=getBounds(this, sBounds);
            var loc6:*=loc3.numVertices;
            var loc7:*=loc6 ? loc3.getColor(0) : 16777215;
            var loc8:*=loc6 ? loc3.getAlpha(0) : 1;
            var loc9:*=scaleX > 0 ? 1 / scaleX : -1 / scaleX;
            var loc10:*=scaleY > 0 ? 1 / scaleY : -1 / scaleY;
            var loc11:*=this._tileGrid.width > 0 ? this._tileGrid.width : loc1.frameWidth;
            var loc12:*=this._tileGrid.height > 0 ? this._tileGrid.height : loc1.frameHeight;
            loc11 = loc11 * loc9;
            loc12 = loc12 * loc10;
            var loc13:*=loc2 ? (-loc2.x) * loc11 / loc2.width : 0;
            var loc14:*=loc2 ? (-loc2.y) * loc12 / loc2.height : 0;
            var loc15:*=loc1.width * loc11 / loc1.frameWidth;
            var loc16:*=loc1.height * loc12 / loc1.frameHeight;
            var loc17:*=this._tileGrid.x * loc9 % loc11;
            var loc18:*=this._tileGrid.y * loc10 % loc12;
            if (loc17 < 0) 
            {
                loc17 = loc17 + loc11;
            }
            if (loc18 < 0) 
            {
                loc18 = loc18 + loc12;
            }
            var loc19:*=loc17 + loc13;
            var loc20:*=loc18 + loc14;
            if (loc19 > loc11 - loc15) 
            {
                loc19 = loc19 - loc11;
            }
            if (loc20 > loc12 - loc16) 
            {
                loc20 = loc20 - loc12;
            }
            var loc29:*="position";
            var loc30:*="texCoords";
            var loc32:*=loc20;
            var loc33:*=0;
            loc4.numIndices = 0;
            while (loc32 < loc5.height) 
            {
                loc31 = loc19;
                while (loc31 < loc5.width) 
                {
                    loc4.addQuad(loc33, loc33 + 1, loc33 + 2, loc33 + 3);
                    loc21 = loc31 < 0 ? 0 : loc31;
                    loc23 = loc32 < 0 ? 0 : loc32;
                    loc22 = loc31 + loc15 > loc5.width ? loc5.width : loc31 + loc15;
                    loc24 = loc32 + loc16 > loc5.height ? loc5.height : loc32 + loc16;
                    loc3.setPoint(loc33, loc29, loc21, loc23);
                    loc3.setPoint(loc33 + 1, loc29, loc22, loc23);
                    loc3.setPoint(loc33 + 2, loc29, loc21, loc24);
                    loc3.setPoint(loc33 + 3, loc29, loc22, loc24);
                    loc25 = (loc21 - loc31) / loc15;
                    loc27 = (loc23 - loc32) / loc16;
                    loc26 = (loc22 - loc31) / loc15;
                    loc28 = (loc24 - loc32) / loc16;
                    loc1.setTexCoords(loc3, loc33, loc30, loc25, loc27);
                    loc1.setTexCoords(loc3, loc33 + 1, loc30, loc26, loc27);
                    loc1.setTexCoords(loc3, loc33 + 2, loc30, loc25, loc28);
                    loc1.setTexCoords(loc3, loc33 + 3, loc30, loc26, loc28);
                    loc31 = loc31 + loc11;
                    loc33 = loc33 + 4;
                }
                loc32 = loc32 + loc12;
            }
            loc3.numVertices = loc33;
            var loc34:*=loc6;
            while (loc34 < loc33) 
            {
                loc3.setColor(loc34, "color", loc7);
                loc3.setAlpha(loc34, "color", loc8);
                ++loc34;
            }
            setRequiresRedraw();
            return;
        }

        
        {
            sPadding = new starling.utils.Padding();
            sBounds = new flash.geom.Rectangle();
            sBasCols = new Vector.<Number>(3, true);
            sBasRows = new Vector.<Number>(3, true);
            sPosCols = new Vector.<Number>(3, true);
            sPosRows = new Vector.<Number>(3, true);
            sTexCols = new Vector.<Number>(3, true);
            sTexRows = new Vector.<Number>(3, true);
        }

        internal var _scale9Grid:flash.geom.Rectangle;

        internal var _tileGrid:flash.geom.Rectangle;

        internal static var sPadding:starling.utils.Padding;

        internal static var sBounds:flash.geom.Rectangle;

        internal static var sBasCols:__AS3__.vec.Vector.<Number>;

        internal static var sBasRows:__AS3__.vec.Vector.<Number>;

        internal static var sPosCols:__AS3__.vec.Vector.<Number>;

        internal static var sPosRows:__AS3__.vec.Vector.<Number>;

        internal static var sTexCols:__AS3__.vec.Vector.<Number>;

        internal static var sTexRows:__AS3__.vec.Vector.<Number>;
    }
}


