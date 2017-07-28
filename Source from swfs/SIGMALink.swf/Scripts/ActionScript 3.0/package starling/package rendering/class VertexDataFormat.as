//class VertexDataFormat
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.utils.*;
    
    public class VertexDataFormat extends Object
    {
        public function VertexDataFormat()
        {
            super();
            this._attributes = new Vector.<VertexDataAttribute>();
            return;
        }

        public function extend(arg1:String):starling.rendering.VertexDataFormat
        {
            return fromString(this._format + ", " + arg1);
        }

        public function getSize(arg1:String):int
        {
            return this.getAttribute(arg1).size;
        }

        public function getSizeIn32Bits(arg1:String):int
        {
            return this.getAttribute(arg1).size / 4;
        }

        public function getOffset(arg1:String):int
        {
            return this.getAttribute(arg1).offset;
        }

        public function getOffsetIn32Bits(arg1:String):int
        {
            return this.getAttribute(arg1).offset / 4;
        }

        public function getFormat(arg1:String):String
        {
            return this.getAttribute(arg1).format;
        }

        public function getName(arg1:int):String
        {
            return this._attributes[arg1].name;
        }

        public function hasAttribute(arg1:String):Boolean
        {
            var loc1:*=this._attributes.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this._attributes[loc2].name == arg1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        public function setVertexBufferAt(arg1:int, arg2:flash.display3D.VertexBuffer3D, arg3:String):void
        {
            var loc1:*=this.getAttribute(arg3);
            starling.core.Starling.context.setVertexBufferAt(arg1, arg2, loc1.offset / 4, loc1.format);
            return;
        }

        internal function parseFormat(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            if (!(arg1 == null) && !(arg1 == "")) 
            {
                this._attributes.length = 0;
                this._format = "";
                loc1 = arg1.split(",");
                loc2 = loc1.length;
                loc3 = 0;
                loc4 = 0;
                while (loc4 < loc2) 
                {
                    loc5 = loc1[loc4];
                    loc6 = loc5.split(":");
                    if (loc6.length != 2) 
                    {
                        throw new ArgumentError("Missing colon: " + loc5);
                    }
                    loc7 = starling.utils.StringUtil.trim(loc6[0]);
                    loc8 = starling.utils.StringUtil.trim(loc6[1]);
                    if (loc7.length == 0 || loc8.length == 0) 
                    {
                        throw new ArgumentError("Invalid format string: " + loc5);
                    }
                    loc9 = new VertexDataAttribute(loc7, loc8, loc3);
                    loc3 = loc3 + loc9.size;
                    this._format = this._format + ((loc4 != 0 ? ", " : "") + loc9.name + ":" + loc9.format);
                    this._attributes[this._attributes.length] = loc9;
                    ++loc4;
                }
                this._vertexSize = loc3;
            }
            else 
            {
                this._format = "";
            }
            return;
        }

        public function toString():String
        {
            return this._format;
        }

        function getAttribute(arg1:String):VertexDataAttribute
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=this._attributes.length;
            loc1 = 0;
            while (loc1 < loc3) 
            {
                loc2 = this._attributes[loc1];
                if (loc2.name == arg1) 
                {
                    return loc2;
                }
                ++loc1;
            }
            return null;
        }

        function get attributes():__AS3__.vec.Vector.<VertexDataAttribute>
        {
            return this._attributes;
        }

        public function get formatString():String
        {
            return this._format;
        }

        public function get vertexSize():int
        {
            return this._vertexSize;
        }

        public function get vertexSizeIn32Bits():int
        {
            return this._vertexSize / 4;
        }

        public function get numAttributes():int
        {
            return this._attributes.length;
        }

        public static function fromString(arg1:String):starling.rendering.VertexDataFormat
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 in sFormats) 
            {
                return sFormats[arg1];
            }
            loc1 = new VertexDataFormat();
            loc1.parseFormat(arg1);
            loc2 = loc1._format;
            if (loc2 in sFormats) 
            {
                loc1 = sFormats[loc2];
            }
            sFormats[arg1] = loc1;
            sFormats[loc2] = loc1;
            return loc1;
        }

        
        {
            sFormats = new flash.utils.Dictionary();
        }

        internal var _format:String;

        internal var _vertexSize:int;

        internal var _attributes:__AS3__.vec.Vector.<VertexDataAttribute>;

        internal static var sFormats:flash.utils.Dictionary;
    }
}


